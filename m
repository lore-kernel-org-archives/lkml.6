Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42742186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfBFQnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:43:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbfBFQnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:43:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C747C20811;
        Wed,  6 Feb 2019 16:43:01 +0000 (UTC)
Date:   Wed, 6 Feb 2019 11:43:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Small fixes to the uprobe code
Message-ID: <20190206114300.44ee1d49@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This has two fixes for uprobe code.

 - Cut and paste fix to have uprobe printks say "uprobe" and not "kprobe"

 - Add terminating '\0' byte when copying of function arguments


Please pull the latest trace-v5.0-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.0-rc3

Tag SHA1: a4b2450f61452093078955c7287aee413188755b
Head SHA1: 0722069a5374b904ec1a67f91249f90e1cfae259


Andreas Ziegler (2):
      tracing: uprobes: Fix typo in pr_fmt string
      tracing/uprobes: Fix output for multiple string arguments

----
 kernel/trace/trace_uprobe.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
---------------------------
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index e335576b9411..9bde07c06362 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -5,7 +5,7 @@
  * Copyright (C) IBM Corporation, 2010-2012
  * Author:	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
  */
-#define pr_fmt(fmt)	"trace_kprobe: " fmt
+#define pr_fmt(fmt)	"trace_uprobe: " fmt
 
 #include <linux/ctype.h>
 #include <linux/module.h>
@@ -160,6 +160,13 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	if (ret >= 0) {
 		if (ret == maxlen)
 			dst[ret - 1] = '\0';
+		else
+			/*
+			 * Include the terminating null byte. In this case it
+			 * was copied by strncpy_from_user but not accounted
+			 * for in ret.
+			 */
+			ret++;
 		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
 	}
 
