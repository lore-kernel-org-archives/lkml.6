Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D1C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7424220811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7424220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLKMTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:19:50 -0500
Received: from 8bytes.org ([81.169.241.247]:53152 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbeLKMTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:19:14 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 17496692; Tue, 11 Dec 2018 13:19:12 +0100 (CET)
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
Subject: [PATCH 6/9] iommu/mediatek: Use helper functions to access dev->iommu_fwspec
Date:   Tue, 11 Dec 2018 13:19:07 +0100
Message-Id: <20181211121910.5604-7-joro@8bytes.org>
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

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/mtk_iommu.c    | 21 ++++++++++++---------
 drivers/iommu/mtk_iommu_v1.c | 28 ++++++++++++++++------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 44bd5b9166bb..0783fba05d19 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -244,7 +244,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 {
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
@@ -336,7 +336,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
 
 	if (!data)
 		return -ENODEV;
@@ -355,7 +355,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 static void mtk_iommu_detach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
 
 	if (!data)
 		return;
@@ -417,13 +417,14 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 
 static int mtk_iommu_add_device(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_data *data;
 	struct iommu_group *group;
 
-	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
+	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return -ENODEV; /* Not a iommu client device */
 
-	data = dev->iommu_fwspec->iommu_priv;
+	data = fwspec->iommu_priv;
 	iommu_device_link(&data->iommu, dev);
 
 	group = iommu_group_get_for_dev(dev);
@@ -436,12 +437,13 @@ static int mtk_iommu_add_device(struct device *dev)
 
 static void mtk_iommu_remove_device(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_data *data;
 
-	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
+	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return;
 
-	data = dev->iommu_fwspec->iommu_priv;
+	data = fwspec->iommu_priv;
 	iommu_device_unlink(&data->iommu, dev);
 
 	iommu_group_remove_device(dev);
@@ -468,6 +470,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 
 static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct platform_device *m4updev;
 
 	if (args->args_count != 1) {
@@ -476,13 +479,13 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 		return -EINVAL;
 	}
 
-	if (!dev->iommu_fwspec->iommu_priv) {
+	if (!fwspec->iommu_priv) {
 		/* Get the m4u device */
 		m4updev = of_find_device_by_node(args->np);
 		if (WARN_ON(!m4updev))
 			return -EINVAL;
 
-		dev->iommu_fwspec->iommu_priv = platform_get_drvdata(m4updev);
+		fwspec->iommu_priv = platform_get_drvdata(m4updev);
 	}
 
 	return iommu_fwspec_add_ids(dev, args->args, 1);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 0e780848f59b..d22a2a145bd2 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -206,7 +206,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 {
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
@@ -271,7 +271,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
 	int ret;
 
 	if (!data)
@@ -293,7 +293,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 static void mtk_iommu_detach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
 
 	if (!data)
 		return;
@@ -371,6 +371,7 @@ static struct iommu_ops mtk_iommu_ops;
 static int mtk_iommu_create_mapping(struct device *dev,
 				    struct of_phandle_args *args)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_data *data;
 	struct platform_device *m4updev;
 	struct dma_iommu_mapping *mtk_mapping;
@@ -383,28 +384,29 @@ static int mtk_iommu_create_mapping(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (!dev->iommu_fwspec) {
+	if (!fwspec) {
 		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_ops);
 		if (ret)
 			return ret;
-	} else if (dev->iommu_fwspec->ops != &mtk_iommu_ops) {
+		fwspec = dev_iommu_fwspec_get(dev);
+	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_ops) {
 		return -EINVAL;
 	}
 
-	if (!dev->iommu_fwspec->iommu_priv) {
+	if (!fwspec->iommu_priv) {
 		/* Get the m4u device */
 		m4updev = of_find_device_by_node(args->np);
 		if (WARN_ON(!m4updev))
 			return -EINVAL;
 
-		dev->iommu_fwspec->iommu_priv = platform_get_drvdata(m4updev);
+		fwspec->iommu_priv = platform_get_drvdata(m4updev);
 	}
 
 	ret = iommu_fwspec_add_ids(dev, args->args, 1);
 	if (ret)
 		return ret;
 
-	data = dev->iommu_fwspec->iommu_priv;
+	data = fwspec->iommu_priv;
 	m4udev = data->dev;
 	mtk_mapping = m4udev->archdata.iommu;
 	if (!mtk_mapping) {
@@ -422,6 +424,7 @@ static int mtk_iommu_create_mapping(struct device *dev,
 
 static int mtk_iommu_add_device(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct dma_iommu_mapping *mtk_mapping;
 	struct of_phandle_args iommu_spec;
 	struct of_phandle_iterator it;
@@ -440,7 +443,7 @@ static int mtk_iommu_add_device(struct device *dev)
 		of_node_put(iommu_spec.np);
 	}
 
-	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
+	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return -ENODEV; /* Not a iommu client device */
 
 	/*
@@ -458,7 +461,7 @@ static int mtk_iommu_add_device(struct device *dev)
 	if (err)
 		return err;
 
-	data = dev->iommu_fwspec->iommu_priv;
+	data = fwspec->iommu_priv;
 	mtk_mapping = data->dev->archdata.iommu;
 	err = arm_iommu_attach_device(dev, mtk_mapping);
 	if (err) {
@@ -471,12 +474,13 @@ static int mtk_iommu_add_device(struct device *dev)
 
 static void mtk_iommu_remove_device(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_data *data;
 
-	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
+	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return;
 
-	data = dev->iommu_fwspec->iommu_priv;
+	data = fwspec->iommu_priv;
 	iommu_device_unlink(&data->iommu, dev);
 
 	iommu_group_remove_device(dev);
-- 
2.17.1

