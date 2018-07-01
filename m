Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFC825311
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFC825311
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031325AbeGAQgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:36:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36036 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031237AbeGAQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:36:34 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1EA22AA6;
        Sun,  1 Jul 2018 16:36:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Baoquan He <bhe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 154/157] x86/efi: Fix efi_call_phys_epilog() with CONFIG_X86_5LEVEL=y
Date:   Sun,  1 Jul 2018 18:23:46 +0200
Message-Id: <20180701160900.950421999@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit cfe19577047e74cdac5826adbdc2337d8437f8fb upstream.

Open-coded page table entry checks don't work correctly when we fold the
page table level at runtime.

pgd_present() on 4-level paging machine always returns true, but
open-coded version of the check may return false-negative result and
we silently skip the rest of the loop body in efi_call_phys_epilog().

Replace open-coded checks with proper helpers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org # v4.12+
Fixes: 94133e46a0f5 ("x86/efi: Correct EFI identity mapping under 'efi=old_map' when KASLR is enabled")
Link: http://lkml.kernel.org/r/20180625120852.18300-1-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/platform/efi/efi_64.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -166,14 +166,14 @@ void __init efi_call_phys_epilog(pgd_t *
 		pgd = pgd_offset_k(pgd_idx * PGDIR_SIZE);
 		set_pgd(pgd_offset_k(pgd_idx * PGDIR_SIZE), save_pgd[pgd_idx]);
 
-		if (!(pgd_val(*pgd) & _PAGE_PRESENT))
+		if (!pgd_present(*pgd))
 			continue;
 
 		for (i = 0; i < PTRS_PER_P4D; i++) {
 			p4d = p4d_offset(pgd,
 					 pgd_idx * PGDIR_SIZE + i * P4D_SIZE);
 
-			if (!(p4d_val(*p4d) & _PAGE_PRESENT))
+			if (!p4d_present(*p4d))
 				continue;
 
 			pud = (pud_t *)p4d_page_vaddr(*p4d);


