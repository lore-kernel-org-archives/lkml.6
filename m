Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F51C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C017F2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5GK1bKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C017F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeLFD6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:58:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55126 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeLFD6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:58:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB63smIT107904;
        Thu, 6 Dec 2018 03:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=NlRLkCwiOA7f6mtyYzVHnLMr2b9B2jZqdxk3AnAyazI=;
 b=R5GK1bKSE6S07aQ4pzAy/xS6A7HqXizt3cuf04dGdRPi+q8SeSMnriHrL/bSdGnmPmAD
 v83u8zqMyuQgLtSHs5unYrfCnhFrXemAgmJ5q1QAenehxjMiThh4H6MthZmfkz5JCEJh
 16rsEY30IdVaelfXx3uFazcX0Y0eM+f/jNOBX4kmgnm8tTCmCd5Nukbgi7P2ChoTPgxh
 f3g5vmUaZT0nHiEXOXqYrofdGgc/tIz7DxjZIeFgkluWtQHtOAbFxYcbduHnZq2V3d6f
 MMVAXBTaSEIy2DZHaUt5zJiedc47yDv+AKQjQpGcjV7crGe/GWtHSUPkCmZfA+S8s97n Qw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2p3ftf9ycf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 03:57:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB63viv8032419
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 03:57:44 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB63vh1J015730;
        Thu, 6 Dec 2018 03:57:44 GMT
Received: from linux.cn.oracle.com (/10.182.71.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 19:57:43 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com, dongli.zhang@oracle.com
Subject: [PATCH RFC 1/1] swiotlb: add debugfs to track swiotlb buffer usage
Date:   Thu,  6 Dec 2018 11:59:45 +0800
Message-Id: <1544068785-20399-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device driver will not be able to do dma operations once swiotlb buffer
is full, either because the driver is using so many IO TLB blocks inflight,
or because there is memory leak issue in device driver. To export the
swiotlb buffer usage via debugfs would help the user estimate the size of
swiotlb buffer to pre-allocate or analyze device driver memory leak issue.

As the swiotlb can be initialized at very early stage when debugfs cannot
register successfully, this patch creates the debugfs entry on demand.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 kernel/dma/swiotlb.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 045930e..d3c8aa4 100644
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
@@ -100,6 +110,41 @@ static DEFINE_SPINLOCK(io_tlb_lock);
 
 static int late_alloc;
 
+#ifdef CONFIG_DEBUG_FS
+
+static struct dentry *d_swiotlb_usage;
+
+static int swiotlb_usage_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%lu\n%lu\n", io_tlb_used, io_tlb_nslabs);
+	return 0;
+}
+
+static int swiotlb_usage_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, swiotlb_usage_show, NULL);
+}
+
+static const struct file_operations swiotlb_usage_fops = {
+	.open           = swiotlb_usage_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+void swiotlb_create_debugfs(void)
+{
+	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
+
+	if (!d_swiotlb_usage)
+		return;
+
+	debugfs_create_file("usage", 0600, d_swiotlb_usage,
+			    NULL, &swiotlb_usage_fops);
+}
+
+#endif
+
 static int __init
 setup_io_tlb_npages(char *str)
 {
@@ -449,6 +494,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
 			     sme_active() ? "SME" : "SEV");
 
+#ifdef CONFIG_DEBUG_FS
+	if (unlikely(!d_swiotlb_usage))
+		swiotlb_create_debugfs();
+#endif
+
 	mask = dma_get_seg_boundary(hwdev);
 
 	tbl_dma_addr &= mask;
@@ -528,6 +578,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return SWIOTLB_MAP_ERROR;
 found:
+#ifdef CONFIG_DEBUG_FS
+	io_tlb_used += nslots;
+#endif
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 
 	/*
@@ -588,6 +641,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
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
-- 
2.7.4

