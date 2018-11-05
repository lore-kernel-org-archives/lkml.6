Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C11C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB0420825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB0420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeKFFqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:46:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:46:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5KOp5g476601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 12:24:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5KOpMW476598;
        Mon, 5 Nov 2018 12:24:51 -0800
Date:   Mon, 5 Nov 2018 12:24:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-63ecd3b13d5cf07959a2315ec62a7c62e20df114@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rppt@linux.ibm.com, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org, x86@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, x86@kernel.org,
          linux-kernel@vger.kernel.org, rppt@linux.ibm.com, bp@suse.de,
          tglx@linutronix.de
In-Reply-To: <20181101155314.30690-1-bp@alien8.de>
References: <20181101155314.30690-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/gart: Rewrite early_gart_iommu_check()
 comment
Git-Commit-ID: 63ecd3b13d5cf07959a2315ec62a7c62e20df114
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

Commit-ID:  63ecd3b13d5cf07959a2315ec62a7c62e20df114
Gitweb:     https://git.kernel.org/tip/63ecd3b13d5cf07959a2315ec62a7c62e20df114
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 1 Nov 2018 16:24:43 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 5 Nov 2018 21:18:31 +0100

x86/gart: Rewrite early_gart_iommu_check() comment

... to actually explain what the function is trying to do.

Reported-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181101155314.30690-1-bp@alien8.de
---
 arch/x86/kernel/aperture_64.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 2c4d5ece7456..58176b56354e 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -264,18 +264,23 @@ static int __init parse_gart_mem(char *p)
 }
 early_param("gart_fix_e820", parse_gart_mem);
 
+/*
+ * With kexec/kdump, if the first kernel doesn't shut down the GART and the
+ * second kernel allocates a different GART region, there might be two
+ * overlapping GART regions present:
+ *
+ * - the first still used by the GART initialized in the first kernel.
+ * - (sub-)set of it used as normal RAM by the second kernel.
+ *
+ * which leads to memory corruptions and a kernel panic eventually.
+ *
+ * This can also happen if the BIOS has forgotten to mark the GART region
+ * as reserved.
+ *
+ * Try to update the e820 map to mark that new region as reserved.
+ */
 void __init early_gart_iommu_check(void)
 {
-	/*
-	 * in case it is enabled before, esp for kexec/kdump,
-	 * previous kernel already enable that. memset called
-	 * by allocate_aperture/__alloc_bootmem_nopanic cause restart.
-	 * or second kernel have different position for GART hole. and new
-	 * kernel could use hole as RAM that is still used by GART set by
-	 * first kernel
-	 * or BIOS forget to put that in reserved.
-	 * try to update e820 to make that region as reserved.
-	 */
 	u32 agp_aper_order = 0;
 	int i, fix, slot, valid_agp = 0;
 	u32 ctl;
