Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC17C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6912C253B9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6912C253B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeF0JL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:11:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49867 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbeF0JLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:11:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5R98mp42025792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jun 2018 02:08:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5R98mOe2025789;
        Wed, 27 Jun 2018 02:08:48 -0700
Date:   Wed, 27 Jun 2018 02:08:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-cfe19577047e74cdac5826adbdc2337d8437f8fb@git.kernel.org>
Cc:     ard.biesheuvel@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        matt@codeblueprint.co.uk, bhe@redhat.com, hpa@zytor.com,
        peterz@infradead.org, aryabinin@virtuozzo.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Reply-To: ard.biesheuvel@linaro.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          bhe@redhat.com, hpa@zytor.com, matt@codeblueprint.co.uk,
          peterz@infradead.org, aryabinin@virtuozzo.com, mingo@kernel.org,
          kirill.shutemov@linux.intel.com
In-Reply-To: <20180625120852.18300-1-kirill.shutemov@linux.intel.com>
References: <20180625120852.18300-1-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/efi: Fix efi_call_phys_epilog() with
 CONFIG_X86_5LEVEL=y
Git-Commit-ID: cfe19577047e74cdac5826adbdc2337d8437f8fb
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

Commit-ID:  cfe19577047e74cdac5826adbdc2337d8437f8fb
Gitweb:     https://git.kernel.org/tip/cfe19577047e74cdac5826adbdc2337d8437f8fb
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 25 Jun 2018 15:08:52 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 27 Jun 2018 09:52:52 +0200

x86/efi: Fix efi_call_phys_epilog() with CONFIG_X86_5LEVEL=y

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
---
 arch/x86/platform/efi/efi_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e01f7ceb9e7a..77873ce700ae 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -166,14 +166,14 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
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
