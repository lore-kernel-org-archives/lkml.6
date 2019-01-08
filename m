Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5E9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A6720850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfAHK3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:29:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbfAHK3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:29:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 537933F731;
        Tue,  8 Jan 2019 10:29:15 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-249.ams2.redhat.com [10.36.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF6336013A;
        Tue,  8 Jan 2019 10:29:02 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v3 21/21] vfio: Document nested stage control
Date:   Tue,  8 Jan 2019 11:26:33 +0100
Message-Id: <20190108102633.17482-22-eric.auger@redhat.com>
In-Reply-To: <20190108102633.17482-1-eric.auger@redhat.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 08 Jan 2019 10:29:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New iotcls were introduced to pass information about guest stage1
to the host through VFIO. Let's document the nested stage control.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- document the new fault API

v1 -> v2:
- use the new ioctl names
- add doc related to fault handling
---
 Documentation/vfio.txt | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index f1a4d3c3ba0b..620e38ed0c4a 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -239,6 +239,68 @@ group and can access them as follows::
 	/* Gratuitous device reset and go... */
 	ioctl(device, VFIO_DEVICE_RESET);
 
+IOMMU Dual Stage Control
+------------------------
+
+Some IOMMUs support 2 stages/levels of translation. "Stage" corresponds to
+the ARM terminology while "level" corresponds to Intel's VTD terminology. In
+the following text we use either without distinction.
+
+This is useful when the guest is exposed with a virtual IOMMU and some
+devices are assigned to the guest through VFIO. Then the guest OS can use
+stage 1 (IOVA -> GPA), while the hypervisor uses stage 2 for VM isolation
+(GPA -> HPA).
+
+The guest gets ownership of the stage 1 page tables and also owns stage 1
+configuration structures. The hypervisor owns the root configuration structure
+(for security reason), including stage 2 configuration. This works as long
+configuration structures and page table format are compatible between the
+virtual IOMMU and the physical IOMMU.
+
+Assuming the HW supports it, this nested mode is selected by choosing the
+VFIO_TYPE1_NESTING_IOMMU type through:
+
+ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU);
+
+This forces the hypervisor to use the stage 2, leaving stage 1 available for
+guest usage.
+
+Once groups are attached to the container, the guest stage 1 translation
+configuration data can be passed to VFIO by using
+
+ioctl(container, VFIO_IOMMU_BIND_PASID_TABLE, &pasid_table_info);
+
+This allows to combine guest stage 1 configuration structure along with
+hypervisor stage 2 configuration structure. stage 1 configuration structures
+are dependent on the IOMMU type.
+
+As the stage 1 translation is fully delegated to the HW, physical events that
+may occur (especially translation faults), need to be propagated up to
+the virtualizer and re-injected into the guest.
+
+By using VFIO_DEVICE_SET_IRQS along with the VFIO_PCI_DMA_FAULT_IRQ_INDEX
+index, the virtualizer can register an eventfd signalled whenever a
+fault is observed at physical level. The actual faults can be retrieved
+from the device fault region whose type/subtype is:
+VFIO_REGION_TYPE_NESTED/VFIO_REGION_SUBTYPE_NESTED_FAULT_REGION.
+
+This region can be mmapped. When a fault is consumed, the user must increment
+the consumer index.
+
+When the guest invalidates stage 1 related caches, invalidations must be
+forwarded to the host through
+ioctl(container, VFIO_IOMMU_CACHE_INVALIDATE, &inv_data);
+Those invalidations can happen at various granularity levels, page, context, ...
+
+The ARM SMMU specification introduces another challenge: MSIs are translated by
+both the virtual SMMU and the physical SMMU. To build a nested mapping for the
+IOVA programmed into the assigned device, the guest needs to pass its IOVA/MSI
+doorbell GPA binding to the host. Then the hypervisor can build a nested stage 2
+binding eventually translating into the physical MSI doorbell.
+
+This is achieved by
+ioctl(container, VFIO_IOMMU_BIND_MSI, &guest_binding);
+
 VFIO User API
 -------------------------------------------------------------------------------
 
-- 
2.17.2

