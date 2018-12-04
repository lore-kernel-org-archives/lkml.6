Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D957206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D957206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeLDQaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:30:07 -0500
Received: from 8bytes.org ([81.169.241.247]:51474 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeLDQaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:30:06 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CAB9D3CA; Tue,  4 Dec 2018 17:30:04 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/9] ACPI/IORT: Use helper functions to access dev->iommu_fwspec
Date:   Tue,  4 Dec 2018 17:29:55 +0100
Message-Id: <20181204163002.15800-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204163002.15800-1-joro@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/arm64/iort.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..754a67ba49e5 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -779,7 +779,7 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 {
 	struct acpi_iort_node *iommu;
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
 
@@ -824,6 +824,7 @@ static inline int iort_add_device_replay(const struct iommu_ops *ops,
  */
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct acpi_iort_its_group *its;
 	struct acpi_iort_node *iommu_node, *its_node = NULL;
 	int i, resv = 0;
@@ -841,9 +842,9 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	 * a given PCI or named component may map IDs to.
 	 */
 
-	for (i = 0; i < dev->iommu_fwspec->num_ids; i++) {
+	for (i = 0; i < fwspec->num_ids; i++) {
 		its_node = iort_node_map_id(iommu_node,
-					dev->iommu_fwspec->ids[i],
+					fwspec->ids[i],
 					NULL, IORT_MSI_TYPE);
 		if (its_node)
 			break;
@@ -1036,6 +1037,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
  */
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct acpi_iort_node *node, *parent;
 	const struct iommu_ops *ops;
 	u32 streamid = 0;
@@ -1045,7 +1047,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	 * If we already translated the fwspec there
 	 * is nothing left to do, return the iommu_ops.
 	 */
-	ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
+	ops = iort_fwspec_iommu_ops(fwspec);
 	if (ops)
 		return ops;
 
@@ -1084,7 +1086,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	 * add_device callback for dev, replay it to get things in order.
 	 */
 	if (!err) {
-		ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
+		ops = iort_fwspec_iommu_ops(fwspec);
 		err = iort_add_device_replay(ops, dev);
 	}
 
-- 
2.17.1

