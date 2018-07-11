Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A08DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5076D208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ADc8m9FP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5076D208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbeGKLfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:35:42 -0400
Received: from 8bytes.org ([81.169.241.247]:37770 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732982AbeGKLeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:10 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 103E6AA4; Wed, 11 Jul 2018 13:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308606; bh=yLmhHW0HJjSKO5FWNE0Mj6MD7/zIRvh/dOclstvAtpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADc8m9FPUU7TC/Tk5YLBsyXYPzqPHCaBPp3E/gImIsWIWsHatJqoGz8igl0/WZsvk
         6m7u+75J5lB4oZNfd8KDmrnm4fbxtclGJle8uwfRHX2uxpvOyXuYz2P17HW79Fa7Al
         E1Zktq0zCkrTgGUk+Tc4HeNPa2SXNdyc+Qg+lCEidJdhunHfxZ5AJZUxc4c3D0EEpT
         x8a5BUFlcXspMVAH9j/HOLznDKPB9s511C1vIZ3G0hDOCulUpOR92lQdADdA3nokNo
         6qkXM2Mmk1vpp+qwq5VpcX+orq4dHkl7ablq6Y66ETvYVOnckMYDGDwvDMrFOsEo2v
         dg2NvpsFZ3gjg==
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
Date:   Wed, 11 Jul 2018 13:29:34 +0200
Message-Id: <1531308586-29340-28-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
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

