Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C89F21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388769AbfBRObG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:31:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbfBRN6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21DD86445A;
        Mon, 18 Feb 2019 13:58:18 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C00B55D70E;
        Mon, 18 Feb 2019 13:58:11 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [PATCH v4 19/22] vfio-pci: Register an iommu fault handler
Date:   Mon, 18 Feb 2019 14:55:00 +0100
Message-Id: <20190218135504.25048-20-eric.auger@redhat.com>
In-Reply-To: <20190218135504.25048-1-eric.auger@redhat.com>
References: <20190218135504.25048-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 18 Feb 2019 13:58:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch registers a fault handler which records faults in
a circular buffer and then signals an eventfd. This buffer is
exposed within the fault region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c         | 49 +++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index aaf63e5ca2b6..019c9fd380a5 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -29,6 +29,7 @@
 #include <linux/vfio.h>
 #include <linux/vgaarb.h>
 #include <linux/nospec.h>
+#include <linux/circ_buf.h>
 
 #include "vfio_pci_private.h"
 
@@ -244,6 +245,46 @@ static const struct vfio_pci_regops vfio_pci_fault_prod_regops = {
 	.add_capability = vfio_pci_fault_prod_add_capability,
 };
 
+int vfio_pci_iommu_dev_fault_handler(struct iommu_fault_event *evt, void *data)
+{
+	struct vfio_pci_device *vdev = (struct vfio_pci_device *) data;
+	struct vfio_region_fault_prod *prod_region =
+		(struct vfio_region_fault_prod *)vdev->fault_pages;
+	struct vfio_region_fault_cons *cons_region =
+		(struct vfio_region_fault_cons *)(vdev->fault_pages + 2 * PAGE_SIZE);
+	struct iommu_fault *new =
+		(struct iommu_fault *)(vdev->fault_pages + prod_region->offset +
+			prod_region->prod * prod_region->entry_size);
+	int prod, cons, size;
+
+	mutex_lock(&vdev->fault_queue_lock);
+
+	if (!vdev->fault_abi)
+		goto unlock;
+
+	prod = prod_region->prod;
+	cons = cons_region->cons;
+	size = prod_region->nb_entries;
+
+	if (CIRC_SPACE(prod, cons, size) < 1)
+		goto unlock;
+
+	*new = evt->fault;
+	prod = (prod + 1) % size;
+	prod_region->prod = prod;
+	mutex_unlock(&vdev->fault_queue_lock);
+
+	mutex_lock(&vdev->igate);
+	if (vdev->dma_fault_trigger)
+		eventfd_signal(vdev->dma_fault_trigger, 1);
+	mutex_unlock(&vdev->igate);
+	return 0;
+
+unlock:
+	mutex_unlock(&vdev->fault_queue_lock);
+	return -EINVAL;
+}
+
 static int vfio_pci_init_fault_region(struct vfio_pci_device *vdev)
 {
 	struct vfio_region_fault_prod *header;
@@ -276,6 +317,13 @@ static int vfio_pci_init_fault_region(struct vfio_pci_device *vdev)
 	header = (struct vfio_region_fault_prod *)vdev->fault_pages;
 	header->version = -1;
 	header->offset = PAGE_SIZE;
+
+	ret = iommu_register_device_fault_handler(&vdev->pdev->dev,
+					vfio_pci_iommu_dev_fault_handler,
+					vdev);
+	if (ret)
+		goto out;
+
 	return 0;
 out:
 	kfree(vdev->fault_pages);
@@ -1420,6 +1468,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
 	kfree(vdev->region);
 	kfree(vdev->fault_pages);
+	iommu_unregister_device_fault_handler(&pdev->dev);
 	mutex_destroy(&vdev->ioeventfds_lock);
 	kfree(vdev);
 
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 047708aaad66..6f4309c4fe87 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -120,6 +120,7 @@ struct vfio_pci_device {
 	int			ioeventfds_nr;
 	struct eventfd_ctx	*err_trigger;
 	struct eventfd_ctx	*req_trigger;
+	struct eventfd_ctx	*dma_fault_trigger;
 	struct mutex		fault_queue_lock;
 	int			fault_abi;
 	struct list_head	dummy_resources_list;
-- 
2.20.1

