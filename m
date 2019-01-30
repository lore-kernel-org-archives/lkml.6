Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8887820882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbfA3MsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:48:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:44370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731067AbfA3Mrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:47:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E18BEB133;
        Wed, 30 Jan 2019 12:47:32 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     mingo@redhat.com
Cc:     bp@alien8.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v7 28/28] x86/asm: replace WEAK uses by SYM_INNER_LABEL_ALIGN
Date:   Wed, 30 Jan 2019 13:47:11 +0100
Message-Id: <20190130124711.12463-29-jslaby@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new SYM_INNER_LABEL_ALIGN for WEAK entries in the middle of x86
assembly functions.

And make sure WEAK is not defined for x86 anymore as these were the last
users.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/ftrace_32.S | 2 +-
 arch/x86/kernel/ftrace_64.S | 2 +-
 arch/x86/kernel/head_32.S   | 2 +-
 include/linux/linkage.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index f519c22f6f9e..b3b42bb8bd74 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -98,7 +98,7 @@ ftrace_graph_call:
 #endif
 
 /* This is weak to keep gas from relaxing the jumps */
-WEAK(ftrace_stub)
+SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	ret
 SYM_CODE_END(ftrace_caller)
 
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index e3d4ef5d7aff..3d6635c09b9c 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -186,7 +186,7 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
  * This is weak to keep gas from relaxing the jumps.
  * It is also used to copy the retq for trampolines.
  */
-WEAK(ftrace_stub)
+SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	retq
 SYM_FUNC_END(ftrace_caller)
 
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 0f4961075792..4b2d668afd70 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -156,7 +156,7 @@ SYM_CODE_START(startup_32)
 	jmp *%eax
 
 .Lbad_subarch:
-WEAK(xen_entry)
+SYM_INNER_LABEL_ALIGN(xen_entry, SYM_L_WEAK)
 	/* Unknown implementation; there's really
 	   nothing we can do at this point. */
 	ud2a
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 331a2306312c..9280209d1f62 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -121,13 +121,13 @@
 #endif /* CONFIG_X86 */
 #endif /* LINKER_SCRIPT */
 
+#ifndef CONFIG_X86
 #ifndef WEAK
 /* deprecated, use SYM_FUNC_START_WEAK* */
 #define WEAK(name)	   \
 	SYM_FUNC_START_WEAK(name)
 #endif
 
-#ifndef CONFIG_X86
 #ifndef END
 /* deprecated, use SYM_FUNC_END, SYM_DATA_END, or SYM_END */
 #define END(name) \
-- 
2.20.1

