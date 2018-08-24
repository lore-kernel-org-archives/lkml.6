Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CCCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C4F2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C4F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeHXUCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:02:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbeHXUCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:02:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OGNxG4124403
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:26:54 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m2msehw3t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:26:53 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 24 Aug 2018 10:26:52 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 10:26:48 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7OGQksQ48496704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 09:26:46 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0CA97805C;
        Fri, 24 Aug 2018 10:26:46 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10D517805E;
        Fri, 24 Aug 2018 10:26:43 -0600 (MDT)
Received: from morokweng.localdomain.com (unknown [9.80.232.133])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 10:26:42 -0600 (MDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 11/11] powerpc/svm: Increase SWIOTLB buffer size
Date:   Fri, 24 Aug 2018 13:25:35 -0300
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180824162535.22798-1-bauerman@linux.ibm.com>
References: <20180824162535.22798-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082416-0016-0000-0000-00000920D660
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009603; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01078233; UDB=6.00555984; IPR=6.00858208;
 MB=3.00022909; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 16:26:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082416-0017-0000-0000-0000401D2B42
Message-Id: <20180824162535.22798-12-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=779 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

SWIOTLB buffer default size (64MB) is not enough for large sequential write
operations which eventually leads to kernel crash like here.

virtio-pci 0000:00:05.0: swiotlb buffer is full (sz: 327680 bytes)
virtio-pci 0000:00:05.0: DMA: Out of SW-IOMMU space for 327680 bytes
Kernel panic - not syncing: DMA: Random memory could be DMA read
CPU: 12 PID: 3985 Comm: mkfs.ext4 Not tainted 4.18.0-rc4+ #285
Call Trace:
[c0000007d2a27020] [c000000000cfdffc] dump_stack+0xb0/0xf4 (unreliable)
[c0000007d2a27060] [c000000000112a98] panic+0x140/0x328
[c0000007d2a270f0] [c0000000001b4f88] swiotlb_full+0x108/0x130
[c0000007d2a27180] [c0000000001b5f6c] swiotlb_map_page+0x25c/0x2c0
[c0000007d2a271e0] [c0000000007bfaf8] vring_map_one_sg.isra.0+0x58/0x70
[c0000007d2a27200] [c0000000007c08dc] virtqueue_add_sgs+0x1bc/0x690
[c0000007d2a272f0] [d0000000042a1280] virtio_queue_rq+0x358/0x4a0 [virtio_blk]
[c0000007d2a273d0] [c0000000006b5d68] blk_mq_dispatch_rq_list+0x1f8/0x6d0
..................

Increase the SWIOTLB size to 1GB on Ultravisor based secure guests.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/Kconfig | 5 +++++
 kernel/dma/swiotlb.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1466d1234723..fee7194ce9e4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -457,6 +457,11 @@ config PPC_SVM
 
 	 If unsure, say "N".
 
+config SWIOTLB_DEFAULT_SIZE
+       int "Size of Software I/O TLB buffer (in MiB)"
+       default "1024"
+       depends on PPC_SVM
+
 config PPC_TRANSACTIONAL_MEM
        bool "Transactional Memory support for POWERPC"
        depends on PPC_BOOK3S_64
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 04b68d9dffac..32dc67422d8a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -146,8 +146,13 @@ void swiotlb_set_max_segment(unsigned int val)
 		max_segment = rounddown(val, PAGE_SIZE);
 }
 
+#ifdef CONFIG_SWIOTLB_DEFAULT_SIZE
+#define IO_TLB_DEFAULT_SIZE ((unsigned long) CONFIG_SWIOTLB_DEFAULT_SIZE << 20)
+#else
 /* default to 64MB */
 #define IO_TLB_DEFAULT_SIZE (64UL<<20)
+#endif
+
 unsigned long swiotlb_size_or_default(void)
 {
 	unsigned long size;

