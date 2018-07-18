Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEB9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F7B20856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="efTZHSAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F7B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbeGRKSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:18:42 -0400
Received: from 8bytes.org ([81.169.241.247]:54154 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731692AbeGRKSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:41 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 65BF63C8F; Wed, 18 Jul 2018 11:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906885; bh=yLmhHW0HJjSKO5FWNE0Mj6MD7/zIRvh/dOclstvAtpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efTZHSAcIJxliJWJsIykoPT3ort+AtnsZwLyfs2rQjkH4aB36PJKFpYjt/F50omQ3
         T49QDFqcQKzMXw9r+QWftEqNfuzlzBCkujzAuvCt686AeI5Cu5aLVZUdmXtsZ9J2WX
         lZcBpEtroAeQA3RPT6oPIEomUBPnwBN6+g0D/m11ZX+KlEqtf02pElHT+kDFCQG07G
         dJ89e7BcMh6oQ5olwBfRASFrmEiu2UssBNNnNkZMI0siEcl1tOf4jkrQR0Smd3XSBG
         e9S29VMMjjOtMgJDPFkDqq5hrhvsNAiQIrZ3f4Zd0pEaspn1tLnHqBrM1deDYInojH
         IKAOB+mMWAbnw==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 27/39] x86/mm/pti: Make pti_clone_kernel_text() compile on 32 bit
Date:   Wed, 18 Jul 2018 11:41:04 +0200
Message-Id: <1531906876-13451-28-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The pti_clone_kernel_text() function references
__end_rodata_hpage_align, which is only present on x86-64.
This makes sense as the end of the rodata section is not
huge-page aligned on 32 bit.

Nevertheless we need a symbol for the function that points
at the right address for both 32 and 64 bit. Introduce
__end_rodata_aligned for that purpose and use it in
pti_clone_kernel_text().

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/sections.h |  1 +
 arch/x86/kernel/vmlinux.lds.S   | 17 ++++++++++-------
 arch/x86/mm/pti.c               |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 5c019d2..4a911a3 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -7,6 +7,7 @@
 
 extern char __brk_base[], __brk_limit[];
 extern struct exception_table_entry __stop___ex_table[];
+extern char __end_rodata_aligned[];
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 5e1458f..8bde0a4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -55,19 +55,22 @@ jiffies_64 = jiffies;
  * so we can enable protection checks as well as retain 2MB large page
  * mappings for kernel text.
  */
-#define X64_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
+#define X86_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
 
-#define X64_ALIGN_RODATA_END					\
+#define X86_ALIGN_RODATA_END					\
 		. = ALIGN(HPAGE_SIZE);				\
-		__end_rodata_hpage_align = .;
+		__end_rodata_hpage_align = .;			\
+		__end_rodata_aligned = .;
 
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
 
 #else
 
-#define X64_ALIGN_RODATA_BEGIN
-#define X64_ALIGN_RODATA_END
+#define X86_ALIGN_RODATA_BEGIN
+#define X86_ALIGN_RODATA_END					\
+		. = ALIGN(PAGE_SIZE);				\
+		__end_rodata_aligned = .;
 
 #define ALIGN_ENTRY_TEXT_BEGIN
 #define ALIGN_ENTRY_TEXT_END
@@ -141,9 +144,9 @@ SECTIONS
 
 	/* .text should occupy whole number of pages */
 	. = ALIGN(PAGE_SIZE);
-	X64_ALIGN_RODATA_BEGIN
+	X86_ALIGN_RODATA_BEGIN
 	RO_DATA(PAGE_SIZE)
-	X64_ALIGN_RODATA_END
+	X86_ALIGN_RODATA_END
 
 	/* Data */
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 2eadab0..4f6e933 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -470,7 +470,7 @@ void pti_clone_kernel_text(void)
 	 * clone the areas past rodata, they might contain secrets.
 	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = (unsigned long)__end_rodata_hpage_align;
+	unsigned long end = (unsigned long)__end_rodata_aligned;
 
 	if (!pti_kernel_image_global_ok())
 		return;
-- 
2.7.4

