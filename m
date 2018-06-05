Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeFEGQq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:16:46 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:16028 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeFEGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:16:43 -0400
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 4/8] mailbox: ti-msgmgr: Move the memory region name to descriptor
Date: Tue, 5 Jun 2018 01:16:25 -0500
Message-ID: <20180605061629.4759-5-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For newer generation of the hardware, the naming of the region is
decided at integration level and there could be additional regions
as well. Hence move the region naming to be described from compatible
descriptor.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/mailbox/ti-msgmgr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 2952339a8446..a37d6a4b392f 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -48,6 +48,8 @@ struct ti_msgmgr_valid_queue_desc {
  * @tx_polled:		Do I need to use polled mechanism for tx
  * @tx_poll_timeout_ms: Timeout in ms if polled
  * @valid_queues:	List of Valid queues that the processor can access
+ * @data_region_name:	Name of the proxy data region
+ * @status_region_name:	Name of the proxy status region
  * @num_valid_queues:	Number of valid queues
  *
  * This structure is used in of match data to describe how integration
@@ -63,6 +65,8 @@ struct ti_msgmgr_desc {
 	bool tx_polled;
 	int tx_poll_timeout_ms;
 	const struct ti_msgmgr_valid_queue_desc *valid_queues;
+	const char *data_region_name;
+	const char *status_region_name;
 	int num_valid_queues;
 };
 
@@ -531,6 +535,8 @@ static const struct ti_msgmgr_desc k2g_desc = {
 	.queue_count = 64,
 	.max_message_size = 64,
 	.max_messages = 128,
+	.data_region_name = "queue_proxy_region",
+	.status_region_name = "queue_state_debug_region",
 	.data_first_reg = 16,
 	.data_last_reg = 31,
 	.status_cnt_mask = Q_STATE_ENTRY_COUNT_MASK,
@@ -582,13 +588,13 @@ static int ti_msgmgr_probe(struct platform_device *pdev)
 	inst->desc = desc;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "queue_proxy_region");
+					   desc->data_region_name);
 	inst->queue_proxy_region = devm_ioremap_resource(dev, res);
 	if (IS_ERR(inst->queue_proxy_region))
 		return PTR_ERR(inst->queue_proxy_region);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "queue_state_debug_region");
+					   desc->status_region_name);
 	inst->queue_state_debug_region = devm_ioremap_resource(dev, res);
 	if (IS_ERR(inst->queue_state_debug_region))
 		return PTR_ERR(inst->queue_state_debug_region);
-- 
2.15.1
