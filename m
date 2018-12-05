Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD0EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A1F20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A1F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeLEOhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:37:01 -0500
Received: from 8bytes.org ([81.169.241.247]:51852 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeLEOgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:36:55 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C55F13CA; Wed,  5 Dec 2018 15:36:52 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 2/4] iommu: Consolitate ->add/remove_device() calls
Date:   Wed,  5 Dec 2018 15:36:44 +0100
Message-Id: <20181205143646.4876-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205143646.4876-1-joro@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Put them into separate functions and call those where the
plain ops have been called before.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 54 ++++++++++++++++++++++---------------------
 include/linux/iommu.h |  3 +++
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index edbdf5d6962c..ad4dc51eb69c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -110,6 +110,26 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	spin_unlock(&iommu_device_lock);
 }
 
+int iommu_probe_device(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (!ops->add_device)
+		return 0;
+
+	WARN_ON(dev->iommu_group);
+
+	return ops->add_device(dev);
+}
+
+void  iommu_release_device(struct device *dev)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops->remove_device && dev->iommu_group)
+		ops->remove_device(dev);
+}
+
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -1117,16 +1137,7 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 
 static int add_iommu_group(struct device *dev, void *data)
 {
-	struct iommu_callback_data *cb = data;
-	const struct iommu_ops *ops = cb->ops;
-	int ret;
-
-	if (!ops->add_device)
-		return 0;
-
-	WARN_ON(dev->iommu_group);
-
-	ret = ops->add_device(dev);
+	int ret = iommu_probe_device(dev);
 
 	/*
 	 * We ignore -ENODEV errors for now, as they just mean that the
@@ -1141,11 +1152,7 @@ static int add_iommu_group(struct device *dev, void *data)
 
 static int remove_iommu_group(struct device *dev, void *data)
 {
-	struct iommu_callback_data *cb = data;
-	const struct iommu_ops *ops = cb->ops;
-
-	if (ops->remove_device && dev->iommu_group)
-		ops->remove_device(dev);
+	iommu_release_device(dev);
 
 	return 0;
 }
@@ -1153,27 +1160,22 @@ static int remove_iommu_group(struct device *dev, void *data)
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
 {
+	unsigned long group_action = 0;
 	struct device *dev = data;
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
-	unsigned long group_action = 0;
 
 	/*
 	 * ADD/DEL call into iommu driver ops if provided, which may
 	 * result in ADD/DEL notifiers to group->notifier
 	 */
 	if (action == BUS_NOTIFY_ADD_DEVICE) {
-		if (ops->add_device) {
-			int ret;
+		int ret;
 
-			ret = ops->add_device(dev);
-			return (ret) ? NOTIFY_DONE : NOTIFY_OK;
-		}
+		ret = iommu_probe_device(dev);
+		return (ret) ? NOTIFY_DONE : NOTIFY_OK;
 	} else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
-		if (ops->remove_device && dev->iommu_group) {
-			ops->remove_device(dev);
-			return 0;
-		}
+		iommu_release_device(dev);
+		return NOTIFY_OK;
 	}
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1d28f42cb77..2357841845bb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -398,6 +398,9 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+int iommu_probe_device(struct device *dev);
+void  iommu_release_device(struct device *dev);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
-- 
2.17.1

