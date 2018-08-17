Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53022C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09175218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09175218A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeHQPsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbeHQPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:48:11 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38387218F9;
        Fri, 17 Aug 2018 12:44:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fqe7X-0004rk-Vf; Fri, 17 Aug 2018 08:44:52 -0400
Message-Id: <20180817124451.878994009@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Aug 2018 08:44:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [for-next][PATCH 1/8] tracing: Handle CC_FLAGS_FTRACE more accurately
References: <20180817124418.038744612@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

CC_FLAGS_FTRACE is exported and later used to remove ftrace relevant
build flags from files which should be built without ftrace support.
For that reason add -mfentry to CC_FLAGS_FTRACE as well. That fixes
a problem with vdso32 build on s390, where -mfentry could not be used
together with -m31 flag.

At the same time flags like -pg and -mfentry are not relevant for asm
files, so avoid adding them to KBUILD_AFLAGS.

Introduce CC_FLAGS_USING instead of CC_USING_FENTRY to collect
-DCC_USING_FENTRY (and future alike) which are relevant for both
KBUILD_CFLAGS and KBUILD_AFLAGS.

Link: http://lkml.kernel.org/r/patch-1.thread-aa7b8d.git-42971afe87de.your-ad-here.call-01533557518-ext-9465@work.hours

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 67d9d20f8564..489de42d30c7 100644
--- a/Makefile
+++ b/Makefile
@@ -743,12 +743,15 @@ ifdef CONFIG_FUNCTION_TRACER
 ifndef CC_FLAGS_FTRACE
 CC_FLAGS_FTRACE := -pg
 endif
-export CC_FLAGS_FTRACE
 ifdef CONFIG_HAVE_FENTRY
-CC_USING_FENTRY	:= $(call cc-option, -mfentry -DCC_USING_FENTRY)
+  ifeq ($(call cc-option-yn, -mfentry),y)
+    CC_FLAGS_FTRACE	+= -mfentry
+    CC_FLAGS_USING	+= -DCC_USING_FENTRY
+  endif
 endif
-KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_USING_FENTRY)
-KBUILD_AFLAGS	+= $(CC_USING_FENTRY)
+export CC_FLAGS_FTRACE
+KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
+KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
 		BUILD_C_RECORDMCOUNT := y
-- 
2.18.0


