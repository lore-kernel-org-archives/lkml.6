Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B32ECDFBE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3629520833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3629520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeGTEqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:46:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727155AbeGTEq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:46:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6K3wq6L064354
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 00:00:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kb6snange-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 00:00:15 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Fri, 20 Jul 2018 05:00:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Jul 2018 05:00:08 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6K407Ks39780416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jul 2018 04:00:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33AA452054;
        Fri, 20 Jul 2018 07:00:24 +0100 (BST)
Received: from dhcp-9-202-14-95.in.ibm.com (unknown [9.202.14.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3040452051;
        Fri, 20 Jul 2018 07:00:20 +0100 (BST)
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
Subject: [RFC 4/4] virtio: Add platform specific DMA API translation for virito devices
Date:   Fri, 20 Jul 2018 09:29:41 +0530
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072004-4275-0000-0000-0000029B3CD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072004-4276-0000-0000-000037A36136
Message-Id: <20180720035941.6844-5-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=990 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a hook which a platform can define in order to allow it to
override virtio device's DMA OPS irrespective of whether it has the
flag VIRTIO_F_IOMMU_PLATFORM set or not. We want to use this to do
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
 arch/powerpc/include/asm/dma-mapping.h | 6 ++++++
 arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
 drivers/virtio/virtio.c                | 7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 8fa3945..bc5a9d3 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -116,3 +116,9 @@ extern u64 __dma_get_required_mask(struct device *dev);
 
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
+
+#define platform_override_dma_ops platform_override_dma_ops
+
+struct virtio_device;
+
+extern void platform_override_dma_ops(struct virtio_device *vdev);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f0296..5773bc7 100644
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
@@ -1396,3 +1397,8 @@ static int __init disable_multitce(char *str)
 __setup("multitce=", disable_multitce);
 
 machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
+
+void platform_override_dma_ops(struct virtio_device *vdev)
+{
+	/* Override vdev->parent.dma_ops if required */
+}
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 6b13987..432c332 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -168,6 +168,12 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
 
 const struct dma_map_ops virtio_direct_dma_ops;
 
+#ifndef platform_override_dma_ops
+static inline void platform_override_dma_ops(struct virtio_device *vdev)
+{
+}
+#endif
+
 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -179,6 +185,7 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (virtio_has_iommu_quirk(dev))
 		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
 
+	platform_override_dma_ops(dev);
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;
 
-- 
2.9.3

