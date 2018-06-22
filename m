Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F9DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ECF24945
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26ECF24945
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933660AbeFVWIp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:08:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:1559 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751377AbeFVWIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:08:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="239522269"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2018 15:08:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CB12D73; Sat, 23 Jun 2018 01:08:44 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] Revert "x86/mm: Mark __pgtable_l5_enabled __initdata"
Date:   Sat, 23 Jun 2018 01:08:40 +0300
Message-Id: <20180622220841.54135-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622220841.54135-1-kirill.shutemov@linux.intel.com>
References: <20180622220841.54135-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

It's fixable: early code can be isolated into a separate translation
unit, but such change collides with other work in the area.
That's too much hassle to save 4 bytes of memory.

Return __pgtable_l5_enabled back to be __ro_after_init.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
-- 
2.17.1

