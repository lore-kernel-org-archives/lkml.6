Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeC3KfR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:35:17 -0400
Received: from mail-by2nam01on0053.outbound.protection.outlook.com ([104.47.34.53]:41328
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751232AbeC3KfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:35:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 30 Mar 2018 18:34:57 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] net: mvneta: split rxq/txq init and txq deinit into
 SW and HW parts
Message-ID: <20180330183457.0e77f5c8@xhacker.debian>
In-Reply-To: <20180330183332.3e180a1a@xhacker.debian>
References: <20180330183332.3e180a1a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0092.jpnprd01.prod.outlook.com
 (2603:1096:402:c::28) To DM5PR03MB2635.namprd03.prod.outlook.com
 (2603:10b6:3:43::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 283c8d0a-1069-43eb-5f55-08d59629eb54
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2635;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;3:9m5/PnVLlxh+licZkc9zULI/A1sg775ReqeKuoXv/q7mYTkzNHXvV83CsnYvrDTF7/xBU1zGggOZllOtPkaOmd3JSoxB+2DvpypQpN7a/wmJF6M8MvbKBqkEijsK4FbP/jOdtsti59d4RGiBhjPvADqbIg6rdIfcWB97uF58N0xY8dYMDuQe30mivyq0kBRAKK90xSUR9pSTAmhdhB3lqCb7ayIO1gT2xfTYrKYfYWWa6jw2eTSoxR+5diHtWjtj;25:fsU+ZtVgjS4Aftrbh+3scMCEZ5c71VwGn56O9Uir7M/uvNolzq+gMGGF2/P7EeUYqqJkiWkkfrHJR2AuAvRaoEXtX5ehnc5LRdDTEx41BJuVvOKkUtQebHqXEnaVZ8bS1fbo8TTmvE9x/ddOgJaJqUWQWhVXGgEPAbWzmtTgLCkKKk02f2ZWj3SOYbxZpVK1nyI8UmVi1z5eYKj8H3UgsZmqrPPzd8Wjz65u2L2uAz8xL75s4oML+QeGNyDYjfH3M6gvh2KzHAK3F5xSXXiRHVUBU/FodSVQUUON8fQkERCEmRsDV+76eo5Pfzt5rz96ogrNyxUG2Hqyk/JROrg3Sw==;31:zH5ELVZnn9hNToz5+KvtEKUd4ryGB1votX7QoNbg4OVahlv8EJuzzLg9jK3QwcQctTZ/msW5Tq56gqaw53774SnqcwbiAFuJ2APz/2JitAEA9dmqtqgAuXK94qJzkLrdtd+sYpHJdhUtKvNjVSJ5yrOXKJmYhGzubaEnfouka7H+jJhG+RQqQWHNlxy8meUKKd8iy9BZciwObafGRjQywovY/dgOazUdLmGxKC2D5AY=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2635:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;20:hqLEe3HVkB+ybxP0XmTrCawlA4dR9HEmnKJo2scjmu4rUhuwsEmltSHpMhaE+fgl6OIEDFB3/ac4iLz3wYHRM/mv4ddG8tgkVZCvZaFzmpKqbMd+NWRHIsciLIR0RILyKz+NHpCkC0aou+MzUsqYQa/lbc/gWDPJ2krK+YRrcqbqJ76X9vEphsFpL/VSNxww4arH4tOSAHxueaDURKaDftEI0GgB8GnaEKDg9Y9lJQxkGDXWF9+xiIzitdQfFjKf5qV0XMJYlL0ncAgG6gRxDok0Tdp3mbeuLTGm5+WLSCP2mblSJnm8zf0PfwWcTPg5gltfHzTbC9HgVoSwmar7nP1UI6MEZeLAD3m+YSPS+QkDTwD1/EhlTK99w2Z+TeR35EDeTGLgJB0KEeDEDg1elTnvqRYnaG8b0+KvXmJdSqJv5fmwHjBDBtaVftO9LPLfFBdeeQRp9x7XjqtGnEhib9sfvwU55mM361aGsY9i9tZez3A0I6pKd0Jq2wsGKndT;4:sc0tBednAtlZYLFl7M7M4GbmGzTNR90r2wu87xq+VR78leBn1v43ZEcHnrpbJ7fM18j1uBGzZqKzDQtZ8aCUkRANbqMQrHq9uOYhCsRfNPVx32rdqbe4SrAfGx4d1DcIRrG8NHt6qfjjXYUDONlqeBdT1odnDCf2CrjilLhFQGtT+SYL1OBpmdL/mT2HNZpSQ5K0i+1yNs+dXKVCW6RSFNj5vqx6/9UKZxlXsPBUrwqI4W6+u8mPQB0sXGYuPuKHxx7K3fbZX3JK68G0nyKX6Q==
X-Microsoft-Antispam-PRVS: <DM5PR03MB263532E767A7511A639BD099EDA10@DM5PR03MB2635.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR03MB2635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2635;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(53936002)(26005)(4326008)(50226002)(86362001)(81156014)(8936002)(8676002)(25786009)(316002)(81166006)(16526019)(2906002)(230700001)(1076002)(106356001)(446003)(956004)(486005)(486005)(476003)(11346002)(186003)(47776003)(9686003)(55016002)(105586002)(6116002)(3846002)(66066001)(7696005)(52116002)(54906003)(59450400001)(386003)(6506007)(50466002)(33896004)(76176011)(97736004)(23726003)(305945005)(6666003)(7736002)(5660300001)(478600001)(110136005)(68736007)(72206003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2635;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2635;23:QcqqQhjgn3qSZvJN/eM0e5oOmGMAfJtUjmDaovnMl?=
 =?us-ascii?Q?o6pI83OdZ9lTM/RZ1UghznW7NV14qGS0YJyMWnxtz4wWiRf4DpX1jOfjJWVu?=
 =?us-ascii?Q?t717quQMQjfSpHYELFYaO6yM+rC72+r/hThrsD0Q2c7AtY7Ji2HPvG6aE0Oh?=
 =?us-ascii?Q?DgliWrHB25LhLKs1Xar7EAdPHkYA75xu9o1xbRg2+VJnNg9mrA6P+Lkn8cPK?=
 =?us-ascii?Q?mBNmHCknjvTUbBqqBmTcFtEj+OkQNolMvuCUzmxn8NOLaggd7o4kB5nGLkvF?=
 =?us-ascii?Q?NBO+ZB1Fxd3fP6X5U+s/ZmCs1ljk7/yXqf35BPLZr3Z+2D+ffHR7RbbjZETY?=
 =?us-ascii?Q?fBDvNnJIZIf7Ycr5jPTyi76husyc9QuharQdzJokYme8HUg8KJ/wN45tcjDm?=
 =?us-ascii?Q?OD/uDrWSLV+1heUz2/C+wPX2KoRDvY6znw4tgGkWdzIjenQBqMqxW69nFSuz?=
 =?us-ascii?Q?MbonfeArMAL+3Goryy9fhyRLvvPtPtbLNlWxE5ObwyorK124708oSbomMRJy?=
 =?us-ascii?Q?h9X+d0j4kqRmH0XFx4S15JK6XAX3dO3cIrhiGlMuYhhD8n1+saGogihAAKyT?=
 =?us-ascii?Q?NMtEs5KxJIUVbeIpTxT48d7e02eYxxMyzqHaIlq4h0kOwkV/dwF7o10eLzYj?=
 =?us-ascii?Q?8aH+LvMyI7ZEr1uHGHEcqzl/7vzFO2tAfE/lvrfQe33EXfIcHm3nykKrGluA?=
 =?us-ascii?Q?Rfbm0gQYxczHx8NMdKvGKVglNkAe4noBYuzQqxb0FnA//BuTXGasZ9+WeULw?=
 =?us-ascii?Q?6xCOFmEVHQ+K5glSfvTZgbT3abdoHOhF9rRLkdVUUyUosPwSOigL/j881vGi?=
 =?us-ascii?Q?ht5nupdQZi1atex6JZrGBtAb4M/Vqiz8qbG+G3BqYVsF8kZ+yd0Jd91IBO7a?=
 =?us-ascii?Q?+DBuKnXVNItN3NevUooA1iCUU5rwYi7CLxPrv0S3OtFZH9zZRw05bzlIdKIE?=
 =?us-ascii?Q?jWJppnli28/wdcWkvAeNsOcbuKn1u6/w01UUsk9QHwJnvzRO0qfv+ViKlAHQ?=
 =?us-ascii?Q?QV52us7I5MX+yPVhWc8bJGIDLRRztpAGiKBpzjSPzcRMf2I2LDHbZpWl/t6T?=
 =?us-ascii?Q?vbZzsQDazp2QcAK5O2/RBq1IIt0LQ0o2OGE4ynJE7JvNJkvgolC9p/JVvhej?=
 =?us-ascii?Q?B/i9mdC2UdyVO/khgnTr8/TxonGzMRmQ6inVrD9rvStcvbPU+1uPjMY55Vf+?=
 =?us-ascii?Q?lpUMg4+KAIXVwm46xeLrpd0luRUyQ6IV1o5KM2n8n/GbcvFiF+kTpY33DsFg?=
 =?us-ascii?Q?Yv0sS1VN6WdmqimqKVdwRTOGwz6WGR3JY4SRLdGoN5ww0azNdB0h3EF2rsZF?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: NIgqxjm8vT9sRjI4OqDEXzuq2kFQXuC96MeWrR+jB6lBYHzCAOdn2C4CC9Gujqlvhy6WdIqQrgwpczC9i4gtraQZpCdkT4xYAGQg0JO24m3La8LmG3cOevxl37Cn5Xt/k5F0jNSRZrKBlp1YKyZidaxWMSfOcIIoSxe2bTI26YW/S1b1R7Em73Z4aR1/OMkh
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;6:FvJwmspFidZ4ltQ31bJdVjOKdig9+7cQnPjVcJPvQUyrU5QRthjbaQMtsKSJ/XlcgkMZQUQiX+fGjYboZWLUh8TiqCb0386jAbkpAcGlkFAI81Z9H0QZUfkAy3PAYiJe/X+Z/I+OEL0qIWZey6kVt6CBAF+xzwL/32ncF2tVAJe9IXJYW5oWdwLDe3hlDUwkHr2Ed5ZiK2rU8ELLWh+hPnfhfpwivY0X0VX3bNPuBREluu8DRbUOOY/mGHmrNynDo3vTrCmdHdA5HT4galXMr3Wh0cnpoRXSbus3p6LGOnnHOLmQBE/lAdA4qPs2PvLISQZ61XYNuXzMuWCN+VxD0keSZ4P823lVKdPAWXWDW8ALEVY1uVemLvK+NlJoAFajCA8Zxq1nZUASD7T8/wXFBnNAu6fgGzYgUajqbe6sYdLUHMsFm0c1rV3yTearJGPvKo0n5fRt1oJxxK5xq1rzBw==;5:P9BWJftIPXQ9tYBFh6AsYYFfS4HFJKfLRqM/3dzCBWXJYK4ZmvqpQ+qAWUG7TvE7w1FViys7+mRPCTaQOfIornNFhwrx6Fn5SOCwhyNBt11JOxMk2/m005whhfLco0YsTlbreVO5wtB1QDWm/MXOnPT41YoiF5QT/d9cbVja3zA=;24:336UGXIf0w6qpwoyiiui+GYmLwcEghHYkbwdorERHM4pMqYuAnPCDrBl3LI/bZ73DhIIVodskN7ge9IHEU1Y2yGD0AZrCTcYVgOivr2/Nl8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;7:kcNB+mGfb//LDUKT+8H9eCtGtgAdEqXPb/50r2C2mvp+A8IwSSTitdwvY2FdleqPJ8DgdKPxCxRHGBvjEAtjZXKvE+Lnzr0HRKwBBD7RubCgjTC45tLTrVAifi65EzRjOxfKGOiv9ieEV4gbGoKctCqzmpLtvuNpMs4rhE3evg9wAFGnI2eE/84YdmviHc0+NhxmtXshN7Boqo2IuNAycaFupVnmvUk//MlD7/a3FSSXsF98YYZURZ0n4zZUerjS
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 10:35:11.3481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283c8d0a-1069-43eb-5f55-08d59629eb54
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2635
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
