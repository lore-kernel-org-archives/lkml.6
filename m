Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AEAECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E242920833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E242920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeGTEqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:46:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbeGTEqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:46:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6K3x6MZ143402
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 00:00:06 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kb1h24qv3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 00:00:05 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Fri, 20 Jul 2018 05:00:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Jul 2018 04:59:57 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6K3xvhT24838248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jul 2018 03:59:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB7765205F;
        Fri, 20 Jul 2018 07:00:13 +0100 (BST)
Received: from dhcp-9-202-14-95.in.ibm.com (unknown [9.202.14.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B809C5204F;
        Fri, 20 Jul 2018 07:00:09 +0100 (BST)
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
Subject: [RFC 2/4] virtio: Override device's DMA OPS with virtio_direct_dma_ops selectively
Date:   Fri, 20 Jul 2018 09:29:39 +0530
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072004-0016-0000-0000-000001E90B1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072003-0017-0000-0000-0000323DCDA3
Message-Id: <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that virtio core always needs all virtio devices to have DMA OPS, we
need to make sure that the structure it points is the right one. In the
absence of VIRTIO_F_IOMMU_PLATFORM flag QEMU expects GPA from guest kernel.
In such case, virtio device must use default virtio_direct_dma_ops DMA OPS
structure which transforms scatter gather buffer addresses as GPA. This
DMA OPS override must happen as early as possible during virtio device
initializatin sequence before virtio core starts using given device's DMA
OPS callbacks for I/O transactions. This change detects device's IOMMU flag
and does the override in case the flag is cleared.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 drivers/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 7907ad3..6b13987 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
+const struct dma_map_ops virtio_direct_dma_ops;
+
 int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
@@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (ret)
 		return ret;
 
+	if (virtio_has_iommu_quirk(dev))
+		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
+
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;
 
-- 
2.9.3

