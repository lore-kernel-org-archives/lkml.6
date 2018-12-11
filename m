Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EDDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C3B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C3B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeLKMTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:19:16 -0500
Received: from 8bytes.org ([81.169.241.247]:53148 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbeLKMTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:19:14 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DA87E5EC; Tue, 11 Dec 2018 13:19:12 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5/9] iommu/ipmmu-vmsa: Use helper functions to access dev->iommu_fwspec
Date:   Tue, 11 Dec 2018 13:19:06 +0100
Message-Id: <20181211121910.5604-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211121910.5604-1-joro@8bytes.org>
References: <20181211121910.5604-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/ipmmu-vmsa.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ddf3a492e1d5..679f18bf0634 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -81,7 +81,9 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
 
 static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 {
-	return dev->iommu_fwspec ? dev->iommu_fwspec->iommu_priv : NULL;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	return fwspec ? fwspec->iommu_priv : NULL;
 }
 
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
@@ -643,7 +645,7 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;
@@ -692,7 +694,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;
 
@@ -744,13 +746,15 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 static int ipmmu_init_platform_device(struct device *dev,
 				      struct of_phandle_args *args)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct platform_device *ipmmu_pdev;
 
 	ipmmu_pdev = of_find_device_by_node(args->np);
 	if (!ipmmu_pdev)
 		return -ENODEV;
 
-	dev->iommu_fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
+	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
+
 	return 0;
 }
 
-- 
2.17.1

