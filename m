Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCLGu2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:50:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751618AbeCLGu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:50:27 -0400
From: Yang Yingliang <yangyingliang@huawei.com>
To: <marc.zyngier@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>
Subject: [RFC PATCH 2/4] irqchip/gic-v3-its: replace alloc_pages() with alloc_pages_node()
Date: Mon, 12 Mar 2018 14:49:53 +0800
Message-ID: <1520837395-10288-3-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
In-Reply-To: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
References: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use alloc_pages_node() to allocate pages on current node.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a03e18e..4ebe131 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1557,11 +1557,11 @@ static void its_lpi_free_chunks(unsigned long *bitmap, int base, int nr_ids)
 	kfree(bitmap);
 }
 
-static struct page *its_allocate_prop_table(gfp_t gfp_flags)
+static struct page *its_allocate_prop_table(int nid, gfp_t gfp_flags)
 {
 	struct page *prop_page;
 
-	prop_page = alloc_pages(gfp_flags, get_order(LPI_PROPBASE_SZ));
+	prop_page = alloc_pages_node(nid, gfp_flags, get_order(LPI_PROPBASE_SZ));
 	if (!prop_page)
 		return NULL;
 
@@ -1587,7 +1587,8 @@ static int __init its_alloc_lpi_tables(void)
 	phys_addr_t paddr;
 
 	lpi_id_bits = min_t(u32, gic_rdists->id_bits, ITS_MAX_LPI_NRBITS);
-	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
+	gic_rdists->prop_page = its_allocate_prop_table(cpu_to_node(smp_processor_id()),
+							GFP_NOWAIT);
 	if (!gic_rdists->prop_page) {
 		pr_err("Failed to allocate PROPBASE\n");
 		return -ENOMEM;
@@ -2829,7 +2830,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		return -ENOMEM;
 	}
 
-	vprop_page = its_allocate_prop_table(GFP_KERNEL);
+	vprop_page = its_allocate_prop_table(NUMA_NO_NODE, GFP_KERNEL);
 	if (!vprop_page) {
 		its_lpi_free_chunks(bitmap, base, nr_ids);
 		return -ENOMEM;
-- 
1.8.3
