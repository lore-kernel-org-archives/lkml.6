Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21ACECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B747C2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B747C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbeIRUAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:00:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17989 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbeIRUAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:00:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CF84C04F4D5;
        Tue, 18 Sep 2018 14:27:09 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E55D87B00E;
        Tue, 18 Sep 2018 14:27:00 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     tianyu.lan@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v2 19/20] vfio: Document nested stage control
Date:   Tue, 18 Sep 2018 16:24:56 +0200
Message-Id: <20180918142457.3325-20-eric.auger@redhat.com>
In-Reply-To: <20180918142457.3325-1-eric.auger@redhat.com>
References: <20180918142457.3325-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 18 Sep 2018 14:27:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New iotcls were introduced to pass information about guest stage1
to the host through VFIO. Let's document the nested stage control.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

fault reporting is current missing to the picture

v1 -> v2:
- use the new ioctl names
- add doc related to fault handling
---
 Documentation/vfio.txt | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index f1a4d3c3ba0b..d4611759d306 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -239,6 +239,66 @@ group and can access them as follows::
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
+By calling: ioctl(container, VFIO_IOMMU_SET_FAULT_EVENTFD &fault_config),
+the virtualizer can register an eventfd. This latter will be signalled
+whenever an event is detected at physical level. The fault handler,
+executed at userspace level has to call:
+ioctl(container, VFIO_IOMMU_GET_FAULT_EVENTS, &fault_info) to retrieve
+the pending fault events.
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
2.17.1

