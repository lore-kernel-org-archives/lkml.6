Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ED7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738A020850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TxWWYhRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfARHIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:08:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53404 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfARHIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:08:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0I74fCg091884;
        Fri, 18 Jan 2019 07:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=BFzd1il6u5usTiODuBdm4kdIGVHFRleDvZa0r/5wX9M=;
 b=TxWWYhRH7FbvCSk2fYnarwTuawXhQlhbXpbgQxBFvKux43MjqVbhqmGDCSDyDdHOITMD
 hKmEunxiN/snf9LBSMVXTdjEKUhEcfEfMt3/FcleVMPTqsLOjd068prw0ujVLv+F5GJC
 Vf2NYEcW67DgYicdYssowwOfzOq6cIXh69zANJxOiOqwqadaAbK93M/LHRDmd4BRHr8Q
 s64Y7GE8uz4+oJBS6p8I8vVaXX7dWDjhwyxrilJdljobHUYLn19SpfxmFv1mIELuG2JW
 9kisDrEf3y1HTbJJY2Qjk7GXcAspj395JE5apcuDXBQioGc35LNte7S0o0ExvZ+sGvq+ iA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pybjp3x0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 07:08:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0I78HSF018897
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 07:08:17 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0I78HXN028476;
        Fri, 18 Jan 2019 07:08:17 GMT
Received: from linux.cn.oracle.com (/10.182.71.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 23:08:17 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com, dongli.zhang@oracle.com
Subject: [PATCH v3 2/3] swiotlb: add debugfs to track swiotlb buffer usage
Date:   Fri, 18 Jan 2019 15:10:27 +0800
Message-Id: <1547795428-10595-2-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
References: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9139 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901180054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device driver will not be able to do dma operations once swiotlb buffer
is full, either because the driver is using so many IO TLB blocks inflight,
or because there is memory leak issue in device driver. To export the
swiotlb buffer usage via debugfs would help the user estimate the size of
swiotlb buffer to pre-allocate or analyze device driver memory leak issue.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  * init debugfs with late_initcall (suggested by Robin Murphy)
  * create debugfs entries with debugfs_create_ulong(suggested by Robin Murphy)

Changed since v2:
  * some #ifdef folding (suggested by Konrad Rzeszutek Wilk)

 kernel/dma/swiotlb.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1d8b377..bedc9f9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -34,6 +34,9 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -73,6 +76,11 @@ phys_addr_t io_tlb_start, io_tlb_end;
 static unsigned long io_tlb_nslabs;
 
 /*
+ * The number of used IO TLB block
+ */
+static unsigned long io_tlb_used;
+
+/*
  * This is a free list describing the number of free entries available from
  * each index
  */
@@ -524,6 +532,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return DMA_MAPPING_ERROR;
 found:
+	io_tlb_used += nslots;
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 
 	/*
@@ -584,6 +593,8 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 		 */
 		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
 			io_tlb_list[i] = ++count;
+
+		io_tlb_used -= nslots;
 	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
@@ -662,3 +673,36 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
+
+#ifdef CONFIG_DEBUG_FS
+
+static int __init swiotlb_create_debugfs(void)
+{
+	static struct dentry *d_swiotlb_usage;
+	struct dentry *ent;
+
+	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
+
+	if (!d_swiotlb_usage)
+		return -ENOMEM;
+
+	ent = debugfs_create_ulong("io_tlb_nslabs", 0400,
+				   d_swiotlb_usage, &io_tlb_nslabs);
+	if (!ent)
+		goto fail;
+
+	ent = debugfs_create_ulong("io_tlb_used", 0400,
+				   d_swiotlb_usage, &io_tlb_used);
+	if (!ent)
+		goto fail;
+
+	return 0;
+
+fail:
+	debugfs_remove_recursive(d_swiotlb_usage);
+	return -ENOMEM;
+}
+
+late_initcall(swiotlb_create_debugfs);
+
+#endif
-- 
2.7.4

