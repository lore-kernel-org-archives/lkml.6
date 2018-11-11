Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB80C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7637120871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/ysinM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7637120871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbeKLJjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:39:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbeKLISj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:39 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5B522443;
        Sun, 11 Nov 2018 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975323;
        bh=z8cST7FqxHUeHdn+dQuXgZjknwfGAMRcJNoMtDF2yMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/ysinM34XBHEWL2Hxg9itsE/vrYeW02HI2ywY153+G5OmPQCC4E3unVkkPpOQ534
         9R08SaM2GhuEj9IHYlJVA1mLfx/2qo/WY4ToIW/6xMlTHxcrhvoR39PKhiKCM77qGD
         Eb0utL3tjh+hNMUkKgH4Y8o+LKGbpuuw0wJi2V8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 290/361] iommu/arm-smmu: Ensure that page-table updates are visible before TLBI
Date:   Sun, 11 Nov 2018 14:20:37 -0800
Message-Id: <20181111221656.614720724@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -469,6 +469,9 @@ static void arm_smmu_tlb_inv_range_nosyn
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
 
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+		wmb();
+
 	if (stage1) {
 		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
@@ -510,6 +513,9 @@ static void arm_smmu_tlb_inv_vmid_nosync
 	struct arm_smmu_domain *smmu_domain = cookie;
 	void __iomem *base = ARM_SMMU_GR0(smmu_domain->smmu);
 
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
+		wmb();
+
 	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
 }
 


