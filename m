Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45E1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7720620882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfA3Mtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:49:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:44132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730985AbfA3MrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:47:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F653B0C6;
        Wed, 30 Jan 2019 12:47:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     mingo@redhat.com
Cc:     bp@alien8.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH v7 08/28] x86/boot/compressed: annotate local functions
Date:   Wed, 30 Jan 2019 13:46:51 +0100
Message-Id: <20190130124711.12463-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

relocated, paging_enabled, and no_longmode are self-standing local
functions, annotate them as such. paging_enabled is annotated as
NOALIGN, since the trampoline code has to be compact.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/head_32.S | 3 ++-
 arch/x86/boot/compressed/head_64.S | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 37380c0d5999..7e8ab0bb6968 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -209,7 +209,7 @@ ENDPROC(efi32_stub_entry)
 #endif
 
 	.text
-relocated:
+SYM_FUNC_START_LOCAL(relocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -260,6 +260,7 @@ relocated:
  */
 	xorl	%ebx, %ebx
 	jmp	*%eax
+SYM_FUNC_END(relocated)
 
 #ifdef CONFIG_EFI_STUB
 	.data
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 64037895b085..b840618edd58 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -508,7 +508,7 @@ ENDPROC(efi64_stub_entry)
 #endif
 
 	.text
-relocated:
+SYM_FUNC_START_LOCAL(relocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -537,6 +537,7 @@ relocated:
  * Jump to the decompressed kernel.
  */
 	jmp	*%rax
+SYM_FUNC_END(relocated)
 
 /*
  * Adjust the global offset table
@@ -622,9 +623,10 @@ ENTRY(trampoline_32bit_src)
 	lret
 
 	.code64
-paging_enabled:
+SYM_FUNC_START_LOCAL_NOALIGN(paging_enabled)
 	/* Return from the trampoline */
 	jmp	*%rdi
+SYM_FUNC_END(paging_enabled)
 
 	/*
          * The trampoline code has a size limit.
@@ -634,11 +636,12 @@ paging_enabled:
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
 	.code32
-no_longmode:
+SYM_FUNC_START_LOCAL(no_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
 	hlt
 	jmp     1b
+SYM_FUNC_END(no_longmode)
 
 #include "../../kernel/verify_cpu.S"
 
-- 
2.20.1

