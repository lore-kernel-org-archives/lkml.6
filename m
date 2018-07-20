Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C678AECDFBE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C24220833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C24220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeGTEqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:46:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727160AbeGTEqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:46:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6K403Wc040775
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 00:00:07 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kb4a2f3qe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 00:00:06 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Fri, 20 Jul 2018 04:59:56 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Jul 2018 04:59:52 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6K3xp6833816594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jul 2018 03:59:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 481755204F;
        Fri, 20 Jul 2018 07:00:08 +0100 (BST)
Received: from dhcp-9-202-14-95.in.ibm.com (unknown [9.202.14.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4E7B45204E;
        Fri, 20 Jul 2018 07:00:04 +0100 (BST)
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, robh@kernel.org,
        joe@perches.com, elfring@users.sourceforge.net,
        david@gibson.dropbear.id.au, jasowang@redhat.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, mst@redhat.com,
        hch@infradead.org, khandual@linux.vnet.ibm.com,
        linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com
Subject: [RFC 1/4] virtio: Define virtio_direct_dma_ops structure
Date:   Fri, 20 Jul 2018 09:29:38 +0530
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072003-4275-0000-0000-0000029B3CCF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072003-4276-0000-0000-000037A3612D
Message-Id: <20180720035941.6844-2-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of DMA API inside virtio core calls device's DMA OPS
callback functions when the flag VIRTIO_F_IOMMU_PLATFORM flag is set. But
in absence of the flag, virtio core falls back calling basic transformation
of the incoming SG addresses as GPA. Going forward virtio should only call
DMA API based transformations generating either GPA or IOVA depending on
QEMU expectations again based on VIRTIO_F_IOMMU_PLATFORM flag. It requires
removing existing fallback code path for GPA transformation and replacing
that with a direct map DMA OPS structure. This adds that direct mapping DMA
OPS structure to be used in later patches which will make virtio core call
DMA API all the time for all virtio devices.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 drivers/virtio/virtio.c            | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h |  3 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 59e36ef..7907ad3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -3,6 +3,7 @@
 #include <linux/virtio_config.h>
 #include <linux/module.h>
 #include <linux/idr.h>
+#include <linux/dma-mapping.h>
 #include <uapi/linux/virtio_ids.h>
 
 /* Unique numbering for virtio devices. */
@@ -442,3 +443,62 @@ core_initcall(virtio_init);
 module_exit(virtio_exit);
 
 MODULE_LICENSE("GPL");
+
+/*
+ * Virtio direct mapping DMA API operations structure
+ *
+ * This defines DMA API structure for all virtio devices which would not
+ * either bring in their own DMA OPS from architecture or they would not
+ * like to use architecture specific IOMMU based DMA OPS because QEMU
+ * expects GPA instead of an IOVA in absence of VIRTIO_F_IOMMU_PLATFORM.
+ */
+dma_addr_t virtio_direct_map_page(struct device *dev, struct page *page,
+			    unsigned long offset, size_t size,
+			    enum dma_data_direction dir,
+			    unsigned long attrs)
+{
+	return page_to_phys(page) + offset;
+}
+
+void virtio_direct_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs)
+{
+}
+
+int virtio_direct_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+void *virtio_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
+{
+	void *queue = alloc_pages_exact(PAGE_ALIGN(size), gfp);
+
+	if (queue) {
+		phys_addr_t phys_addr = virt_to_phys(queue);
+		*dma_handle = (dma_addr_t)phys_addr;
+
+		if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
+			free_pages_exact(queue, PAGE_ALIGN(size));
+			return NULL;
+		}
+	}
+	return queue;
+}
+
+void virtio_direct_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs)
+{
+	free_pages_exact(vaddr, PAGE_ALIGN(size));
+}
+
+const struct dma_map_ops virtio_direct_dma_ops = {
+	.alloc			= virtio_direct_alloc,
+	.free			= virtio_direct_free,
+	.map_page		= virtio_direct_map_page,
+	.unmap_page		= virtio_direct_unmap_page,
+	.mapping_error		= virtio_direct_mapping_error,
+};
+EXPORT_SYMBOL(virtio_direct_dma_ops);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 135ee3c..ec44d2f 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -31,6 +31,9 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 
+extern struct dma_map_ops virtio_direct_dma_ops;
+
+
 struct virtio_pci_vq_info {
 	/* the actual virtqueue */
 	struct virtqueue *vq;
-- 
2.9.3

