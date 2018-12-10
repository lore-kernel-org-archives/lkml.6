Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E84C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D7420831
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qssk8/iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D7420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeLJAgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:36:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46518 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLJAgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:36:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBA0a9sE083239;
        Mon, 10 Dec 2018 00:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=LsoGoMDSrVd81rNdgUZFJRvsyXeVDk6/k7Pg9+hpAMg=;
 b=qssk8/iGyfRtpOUSuIkFLRQhTLyvf+ZzkhHu9OaEVGADkfaFn19OgLHCiSvJM0AR3yr8
 1qKgR/e7P1OzJGIUknjTIqJJ/bi7teKOEhVp+5Q+H+d3u5qpPIbizMDLLX/BVjmXF6Kr
 kDSbxUgm1+nk2uGDPM56e/QOYBZMWtA1JjzZM7NkDpKpXROdN1dKzCvUJHP9FvZu3yzF
 3kNl6qPAPKX12SEIhsy49spPS2jYSkPv/mkFvAVRGzPFqyVOoFHTtywN8MPoiWL49Kyr
 DGjP5oKY9HsK1HADDUH+G69ovKBs/7DO3gjl6qKc0k8TTGSrV5rsNM2mF1g+8Ui+WkJc DA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p85ctu8yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 00:36:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBA0a6sf030490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 00:36:07 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBA0a4Ct010413;
        Mon, 10 Dec 2018 00:36:06 GMT
Received: from linux.cn.oracle.com (/10.182.71.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Dec 2018 16:36:03 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com, dongli.zhang@oracle.com
Subject: [PATCH v2 1/2] swiotlb: add debugfs to track swiotlb buffer usage
Date:   Mon, 10 Dec 2018 08:37:57 +0800
Message-Id: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9102 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100004
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

 kernel/dma/swiotlb.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 045930e..3979c2c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -35,6 +35,9 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -73,6 +76,13 @@ static phys_addr_t io_tlb_start, io_tlb_end;
  */
 static unsigned long io_tlb_nslabs;
 
+#ifdef CONFIG_DEBUG_FS
+/*
+ * The number of used IO TLB block
+ */
+static unsigned long io_tlb_used;
+#endif
+
 /*
  * This is a free list describing the number of free entries available from
  * each index
@@ -528,6 +538,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return SWIOTLB_MAP_ERROR;
 found:
+#ifdef CONFIG_DEBUG_FS
+	io_tlb_used += nslots;
+#endif
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 
 	/*
@@ -588,6 +601,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 		 */
 		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
 			io_tlb_list[i] = ++count;
+
+#ifdef CONFIG_DEBUG_FS
+		io_tlb_used -= nslots;
+#endif
 	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
@@ -883,3 +900,36 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.dma_supported		= dma_direct_supported,
 };
 EXPORT_SYMBOL(swiotlb_dma_ops);
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
+				    d_swiotlb_usage, &io_tlb_used);
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

