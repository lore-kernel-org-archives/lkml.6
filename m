Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA04C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908C1279F4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908C1279F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935338AbeF2Rq5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:46:57 -0400
Received: from foss.arm.com ([217.140.101.70]:37940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933284AbeF2Rqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:46:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5523815AD;
        Fri, 29 Jun 2018 10:46:55 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BBC23F5AD;
        Fri, 29 Jun 2018 10:46:54 -0700 (PDT)
Date:   Fri, 29 Jun 2018 12:46:52 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        =?ISO-8859-1?Q? "Hendrik_Br=FCckner" ?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: [PATCH v2 3/4] perf llvm-utils: remove bashism from kernel include
 fetch script
Message-Id: <20180629124652.8d0af7e2281fd3fd8262cacc@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like system(), popen() calls /bin/sh, which may/may not be bash.

Script when run on dash and encounters the line, yields:

 exit: Illegal number: -1

checkbashisms report on script content:

 possible bashism (exit|return with negative status code):
 exit -1

Remove the bashism and use the more portable non-zero failure
status code 1.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
v2: new for this remove bashisms series

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
2.17.1

