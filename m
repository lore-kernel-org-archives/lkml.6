Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECC020859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBTPFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:05:41 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:35360 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfBTPFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:05:38 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id f35b1z00r3XaVaC0135bmY; Wed, 20 Feb 2019 16:05:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwTRH-0002IR-MD; Wed, 20 Feb 2019 16:05:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwTRH-0000ez-KV; Wed, 20 Feb 2019 16:05:35 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/7] iommu/ipmmu-vmsa: Extract hardware context initialization
Date:   Wed, 20 Feb 2019 16:05:30 +0100
Message-Id: <20190220150531.2462-7-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220150531.2462-1-geert+renesas@glider.be>
References: <20190220150531.2462-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipmmu_domain_init_context() takes care of (1) initializing the software
domain, and (2) initializing the hardware context for the domain.

Extract the code to initialize the hardware context into a new subroutine
ipmmu_context_init(), to prepare for later reuse.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 91 ++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 0a21e734466eb1bd..92a766dd8b459f0c 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -404,52 +404,10 @@ static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
 	spin_unlock_irqrestore(&mmu->lock, flags);
 }
 
-static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
+static void ipmmu_context_init(struct ipmmu_vmsa_domain *domain)
 {
 	u64 ttbr;
 	u32 tmp;
-	int ret;
-
-	/*
-	 * Allocate the page table operations.
-	 *
-	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
-	 * access, Long-descriptor format" that the NStable bit being set in a
-	 * table descriptor will result in the NStable and NS bits of all child
-	 * entries being ignored and considered as being set. The IPMMU seems
-	 * not to comply with this, as it generates a secure access page fault
-	 * if any of the NStable and NS bits isn't set when running in
-	 * non-secure mode.
-	 */
-	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
-	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
-	domain->cfg.ias = 32;
-	domain->cfg.oas = 40;
-	domain->cfg.tlb = &ipmmu_gather_ops;
-	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
-	domain->io_domain.geometry.force_aperture = true;
-	/*
-	 * TODO: Add support for coherent walk through CCI with DVM and remove
-	 * cache handling. For now, delegate it to the io-pgtable code.
-	 */
-	domain->cfg.iommu_dev = domain->mmu->root->dev;
-
-	/*
-	 * Find an unused context.
-	 */
-	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
-	if (ret < 0)
-		return ret;
-
-	domain->context_id = ret;
-
-	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
-					   domain);
-	if (!domain->iop) {
-		ipmmu_domain_free_context(domain->mmu->root,
-					  domain->context_id);
-		return -EINVAL;
-	}
 
 	/* TTBR0 */
 	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
@@ -495,7 +453,54 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	 */
 	ipmmu_ctx_write_all(domain, IMCTR,
 			    IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
+}
+
+static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
+{
+	int ret;
+
+	/*
+	 * Allocate the page table operations.
+	 *
+	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
+	 * access, Long-descriptor format" that the NStable bit being set in a
+	 * table descriptor will result in the NStable and NS bits of all child
+	 * entries being ignored and considered as being set. The IPMMU seems
+	 * not to comply with this, as it generates a secure access page fault
+	 * if any of the NStable and NS bits isn't set when running in
+	 * non-secure mode.
+	 */
+	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
+	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
+	domain->cfg.ias = 32;
+	domain->cfg.oas = 40;
+	domain->cfg.tlb = &ipmmu_gather_ops;
+	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
+	domain->io_domain.geometry.force_aperture = true;
+	/*
+	 * TODO: Add support for coherent walk through CCI with DVM and remove
+	 * cache handling. For now, delegate it to the io-pgtable code.
+	 */
+	domain->cfg.iommu_dev = domain->mmu->root->dev;
+
+	/*
+	 * Find an unused context.
+	 */
+	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
+	if (ret < 0)
+		return ret;
+
+	domain->context_id = ret;
+
+	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
+					   domain);
+	if (!domain->iop) {
+		ipmmu_domain_free_context(domain->mmu->root,
+					  domain->context_id);
+		return -EINVAL;
+	}
 
+	ipmmu_context_init(domain);
 	return 0;
 }
 
-- 
2.17.1

