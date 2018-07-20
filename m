Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8348FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4515420833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4515420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeGTEqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:46:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726348AbeGTEqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:46:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6K3xKpI027075
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 23:59:54 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kb243ucy9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 23:59:53 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Fri, 20 Jul 2018 04:59:51 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Jul 2018 04:59:47 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6K3xkjm40763588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jul 2018 03:59:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCF5D5204F;
        Fri, 20 Jul 2018 07:00:02 +0100 (BST)
Received: from dhcp-9-202-14-95.in.ibm.com (unknown [9.202.14.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F31FB5204E;
        Fri, 20 Jul 2018 06:59:58 +0100 (BST)
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
Subject: [RFC 0/4] Virtio uses DMA API for all devices
Date:   Fri, 20 Jul 2018 09:29:37 +0530
X-Mailer: git-send-email 2.9.3
X-TM-AS-GCONF: 00
x-cbid: 18072003-0012-0000-0000-0000028C67B8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072003-0013-0000-0000-000020BE337E
Message-Id: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is the follow up on the discussions we had before about
the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
for virito devices (https://patchwork.kernel.org/patch/10417371/). There
were suggestions about doing away with two different paths of transactions
with the host/QEMU, first being the direct GPA and the other being the DMA
API based translations.

First patch attempts to create a direct GPA mapping based DMA operations
structure called 'virtio_direct_dma_ops' with exact same implementation
of the direct GPA path which virtio core currently has but just wrapped in
a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
existing semantics. The second patch does exactly that inside the function
virtio_finalize_features(). The third patch removes the default direct GPA
path from virtio core forcing it to use DMA API callbacks for all devices.
Now with that change, every device must have a DMA operations structure
associated with it. The fourth patch adds an additional hook which gives
the platform an opportunity to do yet another override if required. This
platform hook can be used on POWER Ultravisor based protected guests to
load up SWIOTLB DMA callbacks to do the required (as discussed previously
in the above mentioned thread how host is allowed to access only parts of
the guest GPA range) bounce buffering into the shared memory for all I/O
scatter gather buffers to be consumed on the host side.

Please go through these patches and review whether this approach broadly
makes sense. I will appreciate suggestions, inputs, comments regarding
the patches or the approach in general. Thank you.

Anshuman Khandual (4):
  virtio: Define virtio_direct_dma_ops structure
  virtio: Override device's DMA OPS with virtio_direct_dma_ops selectively
  virtio: Force virtio core to use DMA API callbacks for all virtio devices
  virtio: Add platform specific DMA API translation for virito devices

 arch/powerpc/include/asm/dma-mapping.h |  6 +++
 arch/powerpc/platforms/pseries/iommu.c |  6 +++
 drivers/virtio/virtio.c                | 72 ++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h     |  3 ++
 drivers/virtio/virtio_ring.c           | 65 +-----------------------------
 5 files changed, 89 insertions(+), 63 deletions(-)

-- 
2.9.3

