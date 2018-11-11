Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94D6C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A817D208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0olR7MZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A817D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404244AbeKLIXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404200AbeKLIXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:08 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C80A223CA;
        Sun, 11 Nov 2018 22:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975591;
        bh=4hykq8r88v8ZqbbL7il5tihcuixL6PCxm2CrW/hO+uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0olR7MZgq30LbxHyxksmeboCO1qhznLICcmNvqBiJOKsTsZMQk3SJlvxgVgRbGTZ
         PFzL3d9grxEC1oNnL+pzXqNk/r8u9DQmrFFTjns7ndOeLzUMdhdyPDHnf0y0/w/cJO
         VPQs/h3ZiYqvVtsYAjW2l0m5G9ZlR7Ae2vRCyq2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 178/222] iommu/arm-smmu: Ensure that page-table updates are visible before TLBI
Date:   Sun, 11 Nov 2018 14:24:35 -0800
Message-Id: <20181111221702.988681074@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 7d321bd3542500caf125249f44dc37cb4e738013 upstream.

The IO-pgtable code relies on the driver TLB invalidation callbacks to
ensure that all page-table updates are visible to the IOMMU page-table
walker.

In the case that the page-table walker is cache-coherent, we cannot rely
on an implicit DSB from the DMA-mapping code, so we must ensure that we
execute a DSB in our tlb_add_flush() callback prior to triggering the
invalidation.

Cc: <stable@vger.kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: 2df7a25ce4a7 ("iommu/arm-smmu: Clean up DMA API usage")
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/arm-smmu.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -475,6 +475,9 @@ static void arm_smmu_tlb_inv_range_nosyn
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
 
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+		wmb();
+
 	if (stage1) {
 		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
@@ -516,6 +519,9 @@ static void arm_smmu_tlb_inv_vmid_nosync
 	struct arm_smmu_domain *smmu_domain = cookie;
 	void __iomem *base = ARM_SMMU_GR0(smmu_domain->smmu);
 
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+		wmb();
+
 	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
 }
 


