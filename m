Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF9DC38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620D320C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUsGV2s9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620D320C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbeGKUvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389371AbeGKUvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:51:18 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB032147C;
        Wed, 11 Jul 2018 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341912;
        bh=Cm/+GLOERMRoBzIUQ6+MQybO4Cm0CxX7SRQ4rB8+jTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUsGV2s9LKTMofPzaN5tsZeveM8sKboSRfVPV43cE4Khfkps1gWxLDNyYN+YkIUiR
         zDnSoORxQOCYdpzlJnaJCL6V9yqgAmbv401psNfOLVAQ19nc3RsljNhb3hLGWHEz4N
         WZGi6WXj9YxHwhG+Q2y5Hw2FQZUFp2OWrYIv226c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/14] perf llvm-utils: Remove bashism from kernel include fetch script
Date:   Wed, 11 Jul 2018 16:43:00 -0400
Message-Id: <20180711204305.12924-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Like system(), popen() calls /bin/sh, which may/may not be bash.

Script when run on dash and encounters the line, yields:

 exit: Illegal number: -1

checkbashisms report on script content:

 possible bashism (exit|return with negative status code):
 exit -1

Remove the bashism and use the more portable non-zero failure
status code 1.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180629124652.8d0af7e2281fd3fd8262cacc@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 976e658e38dc..5e94857dfca2 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -266,16 +266,16 @@ static const char *kinc_fetch_script =
 "#!/usr/bin/env sh\n"
 "if ! test -d \"$KBUILD_DIR\"\n"
 "then\n"
-"	exit -1\n"
+"	exit 1\n"
 "fi\n"
 "if ! test -f \"$KBUILD_DIR/include/generated/autoconf.h\"\n"
 "then\n"
-"	exit -1\n"
+"	exit 1\n"
 "fi\n"
 "TMPDIR=`mktemp -d`\n"
 "if test -z \"$TMPDIR\"\n"
 "then\n"
-"    exit -1\n"
+"    exit 1\n"
 "fi\n"
 "cat << EOF > $TMPDIR/Makefile\n"
 "obj-y := dummy.o\n"
-- 
2.14.4

