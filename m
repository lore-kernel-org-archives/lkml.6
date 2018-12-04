Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228FCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5778206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5778206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeLDQaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:30:06 -0500
Received: from 8bytes.org ([81.169.241.247]:51468 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDQaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:30:06 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A753E239; Tue,  4 Dec 2018 17:30:04 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/9] iommu: Introduce wrappers around dev->iommu_fwspec
Date:   Tue,  4 Dec 2018 17:29:54 +0100
Message-Id: <20181204163002.15800-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204163002.15800-1-joro@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

These wrappers will be used to easily change the location of
the field later when all users are converted.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 14 +++++++-------
 include/linux/iommu.h | 11 +++++++++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index edbdf5d6962c..4cfd407b972c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1976,7 +1976,7 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
@@ -1988,26 +1988,26 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	of_node_get(to_of_node(iommu_fwnode));
 	fwspec->iommu_fwnode = iommu_fwnode;
 	fwspec->ops = ops;
-	dev->iommu_fwspec = fwspec;
+	dev_iommu_fwspec_set(dev, fwspec);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
 
 void iommu_fwspec_free(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	if (fwspec) {
 		fwnode_handle_put(fwspec->iommu_fwnode);
 		kfree(fwspec);
-		dev->iommu_fwspec = NULL;
+		dev_iommu_fwspec_set(dev, NULL);
 	}
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_free);
 
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	size_t size;
 	int i;
 
@@ -2016,11 +2016,11 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 
 	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
 	if (size > sizeof(*fwspec)) {
-		fwspec = krealloc(dev->iommu_fwspec, size, GFP_KERNEL);
+		fwspec = krealloc(fwspec, size, GFP_KERNEL);
 		if (!fwspec)
 			return -ENOMEM;
 
-		dev->iommu_fwspec = fwspec;
+		dev_iommu_fwspec_set(dev, fwspec);
 	}
 
 	for (i = 0; i < num_ids; i++)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1d28f42cb77..f93fdcf7d130 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -398,6 +398,17 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
+{
+	return dev->iommu_fwspec;
+}
+
+static inline void dev_iommu_fwspec_set(struct device *dev,
+					struct iommu_fwspec *fwspec)
+{
+	dev->iommu_fwspec = fwspec;
+}
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
-- 
2.17.1

