Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeDBDYE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:24:04 -0400
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:25077
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754048AbeDBDYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:24:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Mon, 2 Apr 2018 11:23:43 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] net: mvneta: split rxq/txq init and txq deinit into
 SW and HW parts
Message-ID: <20180402112343.54ddfadd@xhacker.debian>
In-Reply-To: <20180402112229.508e1feb@xhacker.debian>
References: <20180402112229.508e1feb@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: PU1PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::27) To BN6PR03MB2625.namprd03.prod.outlook.com
 (2603:10b6:404:59::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1adb77bc-85f1-4bda-734e-08d598492d74
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;3:AMxmFX9wqX9UiPNVZTnRdFrluuqeDHZ9FOUQEIds7lx4sewyeQIg0EqPcGbdZMz97Vy5E8gCjioP+LN72mNHc1dkPRKNGfgga1a6T8YR8xLA5qc8d/R/8NmNI3PrqXCtmIgQTqL42jI6skeZmuKlnUaFg9R1iZQbQ53ocq0u75aJpEFND1CVFF240E2kxqRwW8+RzOjpKxIcJ2q049YjvEgNR8akFzmhqHa70AVrb4bltaB32fm1o2qL+9fR5PIq;25:F1LDyF9+CNegsjfptQgyIUcZkuhINuvH/hhwejEXDsI9Bd57CNy7/zAoZwApUIKsS00I+1u+R7VvjlDmY5RnSAGxwnhFb12O4DcLKsk7NkwMT97EBYHur1k/dzCKJ1cVLw6SnUdEZGEs51NPBU2Yx8ec9uh9s+ThOCQOFxpJmm3dZ8wm+AQGRohKzeESmcppDUrk2nGYGb4UFEIhS+FOibFb11uebJ4588Gu8fJe5eyCJ0hUEhKuqVTwC0gzP6B0/IgptkYvyG2rGorYMEVuhdGwfKDurn+0cB5AL3u1k4kOHg4pXlAyHcBmmrWFrXeAjLNWryCHSS4HOTCcK01J1Q==;31:73g1nai3zAnieFVcfOg86bIOT7EMX5+fLQpsMU30Fb7gH9C5jHQ9VBTzH59crTRAFUyGOCJCQYCUFE4Y4AnSuAaSufj9TgoiM0WnU2Dxb4tV2DkF+GYz1UpWk9uxNG1gFmKNwxwWLOpg99rwGE8gWENKU5FDMvpVABHWGglpMLDchdhdz2AievQn5fAjCsATG+L8MyIEHpgUedipmxtXJesccVMMLIRcBPccZ2hWxNQ=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;20:8IQh2H33YA5DLmtHYrcFmeLYqaw91j7OjqnN7K1NLTQTZk/rzSuevQ5BBX3J37zi7D7lBl7mf1JAO8bWr3ew9ZZrFm8S7qGmiwo6d37MA4NL5cZeUGwCCT6xlu7daKA6fqFKcBX6MZfaLw7luBLOjF48grhe+IJTwsDIpb0t2er/NFfpnz48Aq+zFkVUdwaATXrY3T9DGJgkEbhZ4VuhhfvmAtqHu6qf85CX/lUwCZX0UpvQCkjUW8URqwYyaXaztUXwhrDB73bxlTgb5pXlVv9v31T9J6jNwIvoEXCQ+rafBoUrq5Yg5C5AMsNPiG+va4chLYxI4WjT7wuPX3mnJYXGNgDBwRkYuV55vatIsJQhHaQwoL6IcV1zZrDBuctsYhmkKwGbct65oQQuvu/U0VGOWL5Kp8zR8il2xqyPMNSezOakB0a/BZfiVufi55bDyDKBWqKccFVOk2wksQ0ggoMfJRV3T+EK1xyrSMgVke1CACCGkGgjH+sUAOPB2MYz;4:iVQMqPUcBp3Zcp1+dBVu9r6DAWjFWOlE1FwzjrcQwvKMLErp3Kp3NFDZmyzlAWQZ57wsBkbpoNUlyH/NyzJHLvw5mrmJSplNOzfZ4Zq1vlSC/03tnaBvoy4bbKi80ukBc4gnTL8Afx04asH0uU2vJqYQNUYHXa1q3PdZZxaCdQSXWr3Z+sAb6M3FJnqIc+5Em1gjvkgDlG9O7on5MYeo7D0MO8lDPz49vBoEw2H18LP+aOMRBMHXLAmdxpZApHvqPNXoES3vwQ/wPoLEc4TKGg==
X-Microsoft-Antispam-PRVS: <BN6PR03MB26252C0304726B12017F461DEDA60@BN6PR03MB2625.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR03MB2625;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2625;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(39380400002)(376002)(346002)(189003)(199004)(55016002)(26005)(7736002)(6116002)(3846002)(66066001)(105586002)(50226002)(4326008)(25786009)(47776003)(186003)(16526019)(8936002)(230700001)(81156014)(81166006)(8676002)(53936002)(72206003)(9686003)(305945005)(5660300001)(106356001)(476003)(50466002)(386003)(68736007)(6506007)(110136005)(1076002)(23726003)(316002)(59450400001)(33896004)(956004)(486005)(486005)(76176011)(11346002)(446003)(86362001)(97736004)(478600001)(6666003)(52116002)(2906002)(7696005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2625;23:A8KNU9Z3Ckju9iHfJoVq1MeLB3435M6aWuNCzVoCw?=
 =?us-ascii?Q?YBB1lDwE5wUYKeMjf47cAq5NvTYH9uG/2Uzd0pS7ALpJ81q1z+JoJJbP+Akd?=
 =?us-ascii?Q?LQgl5TPMXysoA8FQaQYtlNDm80Kl4kPscrGahIRD+5WDLZnlX4VvjJ/2bDIe?=
 =?us-ascii?Q?qKKP1FX09MtZHfzMbDQ/9ohLZJgq9KXpAgavdSrfUfj/8hdYiV6Y3NhjktY3?=
 =?us-ascii?Q?w/kXRwJnAt/y8eQAuEtJepqj257LewmXg80zrXeSO9AB+ixaEeVe9T4hKlz9?=
 =?us-ascii?Q?so7rPW0YPggFOhaGohRR7x1S/k6WDwbhERFtUvmsf/6niVHkDpVSaALtLbKE?=
 =?us-ascii?Q?AwDiLjfE6EBiyybyuATp8UL+5dxVnv5xZ9qWQf6VGFaEJWoXqB7A6dL1L2lm?=
 =?us-ascii?Q?8rWcEY8GR6r/rQqtncrznzCgJ/1J3s3h0bpNJhW5yMPGHrkt0J1vfP8XHoi2?=
 =?us-ascii?Q?x4HCbcww0hMLjevTDcQE8sP+GF5+c9LTDvpdvFBdWHivWJVV9tGfXTr6C/cL?=
 =?us-ascii?Q?GMzZe2ZyaYSYvaNCwsEc9BTdBL0VG04Sw4nJqcyEHJcCYgoEZXj7FbxrOCbn?=
 =?us-ascii?Q?kHin1yP1bsl2mzklqLzjfkWoRcPfWMlHX5BbRu1FhYLIAc4Uiz2xEaHuZFVB?=
 =?us-ascii?Q?R3enrhMXTvTOxM5Z+RGULH+6kQIbnkWrWIAt3r/I32/Dk1bhI/XJ5VZSTEU2?=
 =?us-ascii?Q?MfEoOs/TQC8jxrKJJKPvZAESBoVRAqwju6XxWa5jp5bnr+BWBE2CIjnHCX2o?=
 =?us-ascii?Q?jfj2CmKpEiWM9YH+ixxpKqskaSWwa/0hDR/bF+PHP5qbRlMMevBN75sDSwUH?=
 =?us-ascii?Q?G9t63vOrtoNj70BAY02udzX27qWIZgJpWvNemcL4tq5a+hyydExNtHx4ER/Z?=
 =?us-ascii?Q?M0F+ILBHSIyZH8tZbXfUlU64+gvAnGgziJr5024jb3Q7TByHFoXw7ohZzVi7?=
 =?us-ascii?Q?Bh1FRmnwbO8Lb+x9bfF+RnRhvB0JvDMuMhqZBSkenLrcRnUO2PiCWkTzcWin?=
 =?us-ascii?Q?I6dGPvyFjsEVx50ukgmAAmvQSo4CtW5pSB7wfGgSIkNLHXcpxliylnxTIw7G?=
 =?us-ascii?Q?jvUr+f6p+TcsA9OysLndbQVBsDHDHl+PIp7a8jCEUom+Yg5Xpe/R+7NVDueu?=
 =?us-ascii?Q?3E9uBeCuyBxtrF61gZ0AWo+GCvOGhoiv7dUhiKGDeBswV+Q9CdkmPfJ3e39v?=
 =?us-ascii?Q?hMbM9CMj+XgRqL/lvksdxJDYMW8VkYCm+2fqCtkcjzaEXeAcjSRJA1T/bpCS?=
 =?us-ascii?Q?yHLRfLyed5rgqrNZ9+rtgTojjrugn4knzR+q8/a?=
X-Microsoft-Antispam-Message-Info: jQCF75APsCiT6nbDEuEGCvMpitFMEkUiau5MA8F/nVZAaonb6i2ftO43FE2VzNwCC2npGfu2ca84KYYBkSNjsjRYcPEDsdF2khR0z6iZSTIw6rAVZrUGV6pOGi/GwhuIdx86nhErIF8YSFW7GKcWCQHr3I7BMBmr2wCkb0TH78W2SaG+0u/aobdgILSe1koV
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;6:eb+eww6KKfWdplRUKZYFsyyEqliierkmo3VqRgQELqij7WCgobxYhfDd8bBUalaWdac/zV48pAXUuAD1D2Fx6AYQ4FhnuWh6UKv4dJJlocQcc/00mZfSzDNJfbA/p1pNxflVsfIuc5Xde+bh+JLXayDeTDJxzjK14/r3fe32GW+Rwa3nES5EFNLo1A/mGjVTHqgy6ZHxmKzTct+Kt/9g9vxiOQks8JPoBPAYw3FXo+UCYT91OSwbedIih646iVeglehb811cI1v8fkoMl4JP70G/Suwdfkzrq0EIZuNjIVjKVPNVpBNttukq5c2XJHk9Oe5BXCZQnogGopoaL+7YKknipMixa8R2hGb+5MSHELdO0P4ijc7AWi1DKiITYNDsLdor54zyAJ0JyzVEwg0ydLgaUVIAeh76WoGV/tkog+SK/UfQ+eLJn8/tbSrwPaI2DVb2mxy4V/Mgvfa/sPU0Cg==;5:0SsOHjTvBJlXXXYz+8KiIqLLDvtFlsX5/uTwrss+SF24fvKCCIG1NQ6jmowj3/yexII1/5rsqgH3hHj7KFJ4eKjlG4DEtlQQs6X3xhpHovGq/UsuEU4TpMWhbhdBPY91XatOFq5lXGqG4rzzNyauxMpLXJs6NP2eHph5SZKFCSc=;24:OpevTiZL00JdezQkNjaNxk10jvgDcaezuFQwP9H1A59+U7x2owQzgieqK9TPaDetuC/J5TFCU3LnS5kcsQmH7BaoK56bntq6yCb/SLpkmkQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;7:iEJRwdRb28S8okyXir7opdLCXJ0Q2WmzJDBRFJ0BjFTrmP7O9MRnx5MC3F0hS1377XeYgrwoufCIEzbKa4W6t5mPDEwmysFUl3YtIwCx3ag7/k4mDKtM+dU7gHHbWaNcVlIPHqgktsdc9TW+0l+eWT1gR6hx+si5hBSBuEHCEAXSj+gwjkSlRFjJwM+gs9coRwWG7eZsZPnoiVQT4Nxj7bhpCxtavWyoBSJUG0LuWCogE+QZyJ3/4Y2zIR26+MUZ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 03:23:58.4286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb77bc-85f1-4bda-734e-08d598492d74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to prepare the suspend/resume improvement in next patch. The
SW parts can be optimized out during resume.

As for rxq handling during suspend, we'd like to drop packets by
calling mvneta_rxq_drop_pkts() which is both SW and HW operation,
so we don't split rxq deinit.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 85 +++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 30aab9bf77cc..f96815853108 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2796,10 +2796,8 @@ static void mvneta_rx_reset(struct mvneta_port *pp)
 
 /* Rx/Tx queue initialization/cleanup methods */
 
-/* Create a specified RX queue */
-static int mvneta_rxq_init(struct mvneta_port *pp,
-			   struct mvneta_rx_queue *rxq)
-
+static int mvneta_rxq_sw_init(struct mvneta_port *pp,
+			      struct mvneta_rx_queue *rxq)
 {
 	rxq->size = pp->rx_ring_size;
 
@@ -2812,6 +2810,12 @@ static int mvneta_rxq_init(struct mvneta_port *pp,
 
 	rxq->last_desc = rxq->size - 1;
 
+	return 0;
+}
+
+static void mvneta_rxq_hw_init(struct mvneta_port *pp,
+			       struct mvneta_rx_queue *rxq)
+{
 	/* Set Rx descriptors queue starting address */
 	mvreg_write(pp, MVNETA_RXQ_BASE_ADDR_REG(rxq->id), rxq->descs_phys);
 	mvreg_write(pp, MVNETA_RXQ_SIZE_REG(rxq->id), rxq->size);
@@ -2835,6 +2839,20 @@ static int mvneta_rxq_init(struct mvneta_port *pp,
 		mvneta_rxq_short_pool_set(pp, rxq);
 		mvneta_rxq_non_occup_desc_add(pp, rxq, rxq->size);
 	}
+}
+
+/* Create a specified RX queue */
+static int mvneta_rxq_init(struct mvneta_port *pp,
+			   struct mvneta_rx_queue *rxq)
+
+{
+	int ret;
+
+	ret = mvneta_rxq_sw_init(pp, rxq);
+	if (ret < 0)
+		return ret;
+
+	mvneta_rxq_hw_init(pp, rxq);
 
 	return 0;
 }
@@ -2857,9 +2875,8 @@ static void mvneta_rxq_deinit(struct mvneta_port *pp,
 	rxq->descs_phys        = 0;
 }
 
-/* Create and initialize a tx queue */
-static int mvneta_txq_init(struct mvneta_port *pp,
-			   struct mvneta_tx_queue *txq)
+static int mvneta_txq_sw_init(struct mvneta_port *pp,
+			      struct mvneta_tx_queue *txq)
 {
 	int cpu;
 
@@ -2872,7 +2889,6 @@ static int mvneta_txq_init(struct mvneta_port *pp,
 	txq->tx_stop_threshold = txq->size - MVNETA_MAX_SKB_DESCS;
 	txq->tx_wake_threshold = txq->tx_stop_threshold / 2;
 
-
 	/* Allocate memory for TX descriptors */
 	txq->descs = dma_alloc_coherent(pp->dev->dev.parent,
 					txq->size * MVNETA_DESC_ALIGNED_SIZE,
@@ -2882,14 +2898,6 @@ static int mvneta_txq_init(struct mvneta_port *pp,
 
 	txq->last_desc = txq->size - 1;
 
-	/* Set maximum bandwidth for enabled TXQs */
-	mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0x03ffffff);
-	mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0x3fffffff);
-
-	/* Set Tx descriptors queue starting address */
-	mvreg_write(pp, MVNETA_TXQ_BASE_ADDR_REG(txq->id), txq->descs_phys);
-	mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), txq->size);
-
 	txq->tx_skb = kmalloc_array(txq->size, sizeof(*txq->tx_skb),
 				    GFP_KERNEL);
 	if (!txq->tx_skb) {
@@ -2910,7 +2918,6 @@ static int mvneta_txq_init(struct mvneta_port *pp,
 				  txq->descs, txq->descs_phys);
 		return -ENOMEM;
 	}
-	mvneta_tx_done_pkts_coal_set(pp, txq, txq->done_pkts_coal);
 
 	/* Setup XPS mapping */
 	if (txq_number > 1)
@@ -2923,9 +2930,38 @@ static int mvneta_txq_init(struct mvneta_port *pp,
 	return 0;
 }
 
+static void mvneta_txq_hw_init(struct mvneta_port *pp,
+			       struct mvneta_tx_queue *txq)
+{
+	/* Set maximum bandwidth for enabled TXQs */
+	mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0x03ffffff);
+	mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0x3fffffff);
+
+	/* Set Tx descriptors queue starting address */
+	mvreg_write(pp, MVNETA_TXQ_BASE_ADDR_REG(txq->id), txq->descs_phys);
+	mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), txq->size);
+
+	mvneta_tx_done_pkts_coal_set(pp, txq, txq->done_pkts_coal);
+}
+
+/* Create and initialize a tx queue */
+static int mvneta_txq_init(struct mvneta_port *pp,
+			   struct mvneta_tx_queue *txq)
+{
+	int ret;
+
+	ret = mvneta_txq_sw_init(pp, txq);
+	if (ret < 0)
+		return ret;
+
+	mvneta_txq_hw_init(pp, txq);
+
+	return 0;
+}
+
 /* Free allocated resources when mvneta_txq_init() fails to allocate memory*/
-static void mvneta_txq_deinit(struct mvneta_port *pp,
-			      struct mvneta_tx_queue *txq)
+static void mvneta_txq_sw_deinit(struct mvneta_port *pp,
+				 struct mvneta_tx_queue *txq)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(pp->dev, txq->id);
 
@@ -2946,7 +2982,11 @@ static void mvneta_txq_deinit(struct mvneta_port *pp,
 	txq->last_desc         = 0;
 	txq->next_desc_to_proc = 0;
 	txq->descs_phys        = 0;
+}
 
+static void mvneta_txq_hw_deinit(struct mvneta_port *pp,
+				 struct mvneta_tx_queue *txq)
+{
 	/* Set minimum bandwidth for disabled TXQs */
 	mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0);
 	mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0);
@@ -2956,6 +2996,13 @@ static void mvneta_txq_deinit(struct mvneta_port *pp,
 	mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), 0);
 }
 
+static void mvneta_txq_deinit(struct mvneta_port *pp,
+			      struct mvneta_tx_queue *txq)
+{
+	mvneta_txq_sw_deinit(pp, txq);
+	mvneta_txq_hw_deinit(pp, txq);
+}
+
 /* Cleanup all Tx queues */
 static void mvneta_cleanup_txqs(struct mvneta_port *pp)
 {
-- 
2.16.3
