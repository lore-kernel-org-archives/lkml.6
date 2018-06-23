Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9F6C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFA224BF0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFA224BF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeFWMa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:30:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeFWMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:30:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCUmJv468196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:30:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCUm3C468193;
        Sat, 23 Jun 2018 05:30:48 -0700
Date:   Sat, 23 Jun 2018 05:30:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-51be1335151771075dcb19f3464ca9f331134285@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mingo@kernel.org, hpa@zytor.com
Reply-To: kirill.shutemov@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20180622220841.54135-2-kirill.shutemov@linux.intel.com>
References: <20180622220841.54135-2-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] Revert "x86/mm: Mark __pgtable_l5_enabled
 __initdata"
Git-Commit-ID: 51be1335151771075dcb19f3464ca9f331134285
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

Commit-ID:  51be1335151771075dcb19f3464ca9f331134285
Gitweb:     https://git.kernel.org/tip/51be1335151771075dcb19f3464ca9f331134285
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Sat, 23 Jun 2018 01:08:40 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 14:20:37 +0200

Revert "x86/mm: Mark __pgtable_l5_enabled __initdata"

This reverts commit e4e961e36f063484c48bed919013c106d178995d.

We need to use early version of pgtable_l5_enabled() in
early_identify_cpu() as this code runs before cpu_feature_enabled() is
usable.

But it leads to section mismatch:

cpu_init()
  load_mm_ldt()
    ldt_slot_va()
      LDT_BASE_ADDR
        LDT_PGD_ENTRY
	  pgtable_l5_enabled()
	    __pgtable_l5_enabled

__pgtable_l5_enabled marked as __initdata, but cpu_init() is not __init.

It's fixable: early code can be isolated into a separate translation unit,
but such change collides with other work in the area.  That's too much
hassle to save 4 bytes of memory.

Return __pgtable_l5_enabled back to be __ro_after_init.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180622220841.54135-2-kirill.shutemov@linux.intel.com

---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a21d6ace648e..8047379e575a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -44,7 +44,7 @@ static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled __initdata;
+unsigned int __pgtable_l5_enabled __ro_after_init;
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
