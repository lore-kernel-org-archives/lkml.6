Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5187DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BDE20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BDE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeLMLAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:00:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbeLMLAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:00:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D25EC6C8A9EA6;
        Thu, 13 Dec 2018 19:00:08 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 19:00:02 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <marc.zyngier@arm.com>, <linux-kernel@vger.kernel.org>
CC:     <shankerd@codeaurora.org>, <ganapatrao.kulkarni@cavium.com>,
        <Robert.Richter@cavium.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory allocation for ITS tables
Date:   Thu, 13 Dec 2018 10:59:24 +0000
Message-ID: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shanker Donthineni <shankerd@codeaurora.org>

The NUMA node information is visible to ITS driver but not being used
other than handling hardware errata. ITS/GICR hardware accesses to the
local NUMA node is usually quicker than the remote NUMA node. How slow
the remote NUMA accesses are depends on the implementation details.

This patch allocates memory for ITS management tables and command
queue from the corresponding NUMA node using the appropriate NUMA
aware functions. This change improves the performance of the ITS
tables read latency on systems where it has more than one ITS block,
and with the slower inter node accesses.

Apache Web server benchmarking using ab tool on a HiSilicon D06
board with multiple numa mem nodes shows Time per request and
Transfer rate improvements of ~3.6% with this patch.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---

This is to revive the patch originally sent by Shanker[1] and 
to back it up with a benchmark test. Any further testing of
this is most welcome.

v2-->v3
 -Addressed comments to use page_address().
 -Added Benchmark results to commit log.
 -Removed T-by from Ganapatrao for now.

v1-->v2
 -Edited commit text.
 -Added Ganapatrao's tested-by.

Benchmark test details:
--------------------------------
Test Setup:
-D06 with dimm on node 0(Sock#0) and 3 (Sock#1).
-ITS belongs to numa node 0.
-Filesystem mounted on a PCIe NVMe based disk.
-Apache server installed on D06.
-Running ab benchmark test in concurrency mode from a remote m/c
 connected to D06 via  hns3(PCIe) n/w port.
 "ab -k -c 750 -n 2000000 http://10.202.225.188/"

Test results are avg. of 15 runs.

For 4.20-rc1  Kernel,
----------------------------
Time per request(mean, concurrent)  = 0.02753[ms]  
Transfer Rate = 416501[Kbytes/sec]

For 4.20-rc1 +  this patch,
----------------------------------
Time per request(mean, concurrent)  = 0.02653[ms]  
Transfer Rate = 431954[Kbytes/sec]

% improvement ~3.6%

vmstat shows around 170K-200K interrupts per second.

~# vmstat 1 -w
procs -----------------------memory-- -  -system--
 r  b         swpd         free            in             
 5  0            0     30166724          102794 
 9  0            0     30141828          171148 
 5  0            0     30150160          207185 
13  0            0     30145924          175691 
15  0            0     30140792          145250 
13  0            0     30135556          201879 
13  0            0     30134864          192391 
10  0            0     30133632          168880 
....

[1] https://patchwork.kernel.org/patch/9833339/

 drivers/irqchip/irq-gic-v3-its.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index db20e99..ab01061 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1749,7 +1749,8 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		order = get_order(GITS_BASER_PAGES_MAX * psz);
 	}
 
-	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	base = (void *)page_address(alloc_pages_node(its->numa_node,
+				    GFP_KERNEL | __GFP_ZERO, order));
 	if (!base)
 		return -ENOMEM;
 
@@ -2236,7 +2237,8 @@ static struct its_baser *its_get_baser(struct its_node *its, u32 type)
 	return NULL;
 }
 
-static bool its_alloc_table_entry(struct its_baser *baser, u32 id)
+static bool its_alloc_table_entry(struct its_node *its,
+				  struct its_baser *baser, u32 id)
 {
 	struct page *page;
 	u32 esz, idx;
@@ -2256,7 +2258,8 @@ static bool its_alloc_table_entry(struct its_baser *baser, u32 id)
 
 	/* Allocate memory for 2nd level table */
 	if (!table[idx]) {
-		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(baser->psz));
+		page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
+					get_order(baser->psz));
 		if (!page)
 			return false;
 
@@ -2287,7 +2290,7 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 	if (!baser)
 		return (ilog2(dev_id) < its->device_ids);
 
-	return its_alloc_table_entry(baser, dev_id);
+	return its_alloc_table_entry(its, baser, dev_id);
 }
 
 static bool its_alloc_vpe_table(u32 vpe_id)
@@ -2311,7 +2314,7 @@ static bool its_alloc_vpe_table(u32 vpe_id)
 		if (!baser)
 			return false;
 
-		if (!its_alloc_table_entry(baser, vpe_id))
+		if (!its_alloc_table_entry(its, baser, vpe_id))
 			return false;
 	}
 
@@ -2345,7 +2348,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	nr_ites = max(2, nvecs);
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
-	itt = kzalloc(sz, GFP_KERNEL);
+	itt = kzalloc_node(sz, GFP_KERNEL, its->numa_node);
 	if (alloc_lpis) {
 		lpi_map = its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
 		if (lpi_map)
@@ -3541,8 +3544,9 @@ static int __init its_probe_one(struct resource *res,
 
 	its->numa_node = numa_node;
 
-	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						get_order(ITS_CMD_QUEUE_SZ));
+	its->cmd_base = (void *)page_address(alloc_pages_node(its->numa_node,
+					     GFP_KERNEL | __GFP_ZERO,
+					     get_order(ITS_CMD_QUEUE_SZ)));
 	if (!its->cmd_base) {
 		err = -ENOMEM;
 		goto out_free_its;
-- 
2.7.4


