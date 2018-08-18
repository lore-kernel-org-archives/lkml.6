Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F1BC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6351F218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6351F218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeHRPED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:04:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34657 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeHRPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:04:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBuGuQ1291312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:56:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBuGSx1291309;
        Sat, 18 Aug 2018 04:56:16 -0700
Date:   Sat, 18 Aug 2018 04:56:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Kapshuk <tipbot@zytor.com>
Message-ID: <tip-51d8aac236493833acf60d9c3b6c42437a18da36@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, alexander.kapshuk@gmail.com, dsahern@gmail.com
Reply-To: alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          alexander.kapshuk@gmail.com, dsahern@gmail.com, jolsa@kernel.org,
          hpa@zytor.com, acme@redhat.com, peterz@infradead.org,
          mingo@kernel.org
In-Reply-To: <20180811083915.17471-1-alexander.kapshuk@gmail.com>
References: <20180811083915.17471-1-alexander.kapshuk@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix check-headers.sh AND list path of
 execution
Git-Commit-ID: 51d8aac236493833acf60d9c3b6c42437a18da36
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  51d8aac236493833acf60d9c3b6c42437a18da36
Gitweb:     https://git.kernel.org/tip/51d8aac236493833acf60d9c3b6c42437a18da36
Author:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
AuthorDate: Sat, 11 Aug 2018 11:39:15 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:46:19 -0300

perf tools: Fix check-headers.sh AND list path of execution

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
