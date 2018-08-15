Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED28C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1260F214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdtWUzUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1260F214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbeHOSA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbeHOSA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:00:59 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82FE5214F0;
        Wed, 15 Aug 2018 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345706;
        bh=56fEHwCh7wLt1n9JjGbZCQjb93VGGy4Bm2cqtR2vyF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OdtWUzUFCE+XVW1xkSerIOxGrpu0tN/54J0oLAsm/Xi+ZXmjOK4TnHlthCnxdTfnS
         EYjFYh8SqOgw0N31/u+5UfldGuPtu9vpKf7pqvr+Blp9nFuj/v7VVIUF2mGgtgcOAl
         nR6nt25Lpl2qPLjqB6fk+Xb7uYFHIFId8fwFn8rc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/35] perf tools: Fix check-headers.sh AND list path of execution
Date:   Wed, 15 Aug 2018 12:06:03 -0300
Message-Id: <20180815150611.32080-28-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Kapshuk <alexander.kapshuk@gmail.com>

The '||' path of execution in the 'test' block of the check_2() function
may also be taken if file2 does not exist, in which case the warning
message about the ABI headers being different would still be printed
where it should not be.  See below.

  % file1=file1; file2=file2
  % cmd="echo diff $file1 $file2"
  % test -f $file2 && \
    eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file1'
                       differs from latest version at '$file2'" >&2
                       Warning: Kernel ABI header at 'tools/file1' differs from latest
                       version at 'file2'

The proposed patch converts the code following the '&&' operator into a
compound list to be executed in the current process environment only if file2
does exist. Should the files being compared differ, a diff command to compare
the files concerned is printed on standard output. E.g.

  $ diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S

Committer testing:

Remove a line from that tools/arch/x86/lib/memcpy_64.S file to test
this:

  BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180811083915.17471-1-alexander.kapshuk@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index de28466c0186..ea48aa6f8d19 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -67,8 +67,12 @@ check_2 () {
 
   cmd="diff $* $file1 $file2 > /dev/null"
 
-  test -f $file2 &&
-  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
+  test -f $file2 && {
+    eval $cmd || {
+      echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
+      echo diff -u tools/$file $file
+    }
+  }
 }
 
 check () {
-- 
2.14.4

