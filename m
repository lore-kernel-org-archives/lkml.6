Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4EDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283F92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283F92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeLKNoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:44:18 -0500
Received: from 8bytes.org ([81.169.241.247]:53346 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbeLKNnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:43:49 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1D1BD533; Tue, 11 Dec 2018 14:43:47 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        jroedel@suse.de, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 4/6] powerpc/iommu: Use device_iommu_mapped()
Date:   Tue, 11 Dec 2018 14:43:41 +0100
Message-Id: <20181211134343.10664-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211134343.10664-1-joro@8bytes.org>
References: <20181211134343.10664-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the new function to replace the open-coded iommu check.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell Currey <ruscur@russell.cc>
Cc: Sam Bobroff <sbobroff@linux.ibm.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/powerpc/kernel/eeh.c   | 2 +-
 arch/powerpc/kernel/iommu.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6cae6b56ffd6..23fe62f11486 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1472,7 +1472,7 @@ static int dev_has_iommu_table(struct device *dev, void *data)
 	if (!dev)
 		return 0;
 
-	if (dev->iommu_group) {
+	if (device_iommu_mapped(dev)) {
 		*ppdev = pdev;
 		return 1;
 	}
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index f0dc680e659a..48d58d1dcac2 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1086,7 +1086,7 @@ int iommu_add_device(struct device *dev)
 	if (!device_is_registered(dev))
 		return -ENOENT;
 
-	if (dev->iommu_group) {
+	if (device_iommu_mapped(dev)) {
 		pr_debug("%s: Skipping device %s with iommu group %d\n",
 			 __func__, dev_name(dev),
 			 iommu_group_id(dev->iommu_group));
@@ -1129,7 +1129,7 @@ void iommu_del_device(struct device *dev)
 	 * and we needn't detach them from the associated
 	 * IOMMU groups
 	 */
-	if (!dev->iommu_group) {
+	if (!device_iommu_mapped(dev)) {
 		pr_debug("iommu_tce: skipping device %s with no tbl\n",
 			 dev_name(dev));
 		return;
@@ -1148,7 +1148,7 @@ static int tce_iommu_bus_notifier(struct notifier_block *nb,
         case BUS_NOTIFY_ADD_DEVICE:
                 return iommu_add_device(dev);
         case BUS_NOTIFY_DEL_DEVICE:
-                if (dev->iommu_group)
+                if (device_iommu_mapped(dev))
                         iommu_del_device(dev);
                 return 0;
         default:
-- 
2.17.1

