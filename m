Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeEVGdd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:33:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751106AbeEVGd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:33:29 -0400
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
        joe@perches.com, elfring@users.sourceforge.net,
        david@gibson.dropbear.id.au, jasowang@redhat.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
        hch@infradead.org
Subject: [RFC V2] virtio: Add platform specific DMA API translation for virito devices
Date: Tue, 22 May 2018 12:03:17 +0530
X-Mailer: git-send-email 2.9.3
X-TM-AS-GCONF: 00
x-cbid: 18052206-0008-0000-0000-000004F90E2A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052206-0009-0000-0000-00001E8D9A69
Message-Id: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220076
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a hook which a platform can define in order to allow it to
force the use of the DMA API for all virtio devices even if they don't
have the VIRTIO_F_IOMMU_PLATFORM flag set.  We want to use this to do
bounce-buffering of data on the new secure pSeries platform, currently
under development, where a KVM host cannot access all of the memory
space of a secure KVM guest.  The host can only access the pages which
the guest has explicitly requested to be shared with the host, thus
the virtio implementation in the guest has to copy data to and from
shared pages.

With this hook, the platform code in the secure guest can force the
use of swiotlb for virtio buffers, with a back-end for swiotlb which
will use a pool of pre-allocated shared pages.  Thus all data being
sent or received by virtio devices will be copied through pages which
the host has access to.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V2:

The arch callback has been enabled through an weak symbol defintion
so that it is enabled only for those architectures subscribing to
this new framework. Clarified the patch description. The primary
objective for this RFC has been to get an in principle agreement
on this approach.

Original V1:

Original RFC and discussions https://patchwork.kernel.org/patch/10324405/

 arch/powerpc/include/asm/dma-mapping.h |  6 ++++++
 arch/powerpc/platforms/pseries/iommu.c | 11 +++++++++++
 drivers/virtio/virtio_ring.c           | 10 ++++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 8fa3945..056e578 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -115,4 +115,10 @@ extern u64 __dma_get_required_mask(struct device *dev);
 #define ARCH_HAS_DMA_MMAP_COHERENT
 
 #endif /* __KERNEL__ */
+
+#define platform_forces_virtio_dma platform_forces_virtio_dma
+
+struct virtio_device;
+
+extern bool platform_forces_virtio_dma(struct virtio_device *vdev);
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f0296..a2ec15a 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -38,6 +38,7 @@
 #include <linux/of.h>
 #include <linux/iommu.h>
 #include <linux/rculist.h>
+#include <linux/virtio.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -1396,3 +1397,13 @@ static int __init disable_multitce(char *str)
 __setup("multitce=", disable_multitce);
 
 machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
+
+bool platform_forces_virtio_dma(struct virtio_device *vdev)
+{
+	/*
+	 * On protected guest platforms, force virtio core to use DMA
+	 * MAP API for all virtio devices. But there can also be some
+	 * exceptions for individual devices like virtio balloon.
+	 */
+	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
+}
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 21d464a..47ea6c3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -141,8 +141,18 @@ struct vring_virtqueue {
  * unconditionally on data path.
  */
 
+#ifndef platform_forces_virtio_dma
+static inline bool platform_forces_virtio_dma(struct virtio_device *vdev)
+{
+	return false;
+}
+#endif
+
 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
+	if (platform_forces_virtio_dma(vdev))
+		return true;
+
 	if (!virtio_has_iommu_quirk(vdev))
 		return true;
 
-- 
2.9.3
