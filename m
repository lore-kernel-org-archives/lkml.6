Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeC2KOQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:14:16 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:51840
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750716AbeC2KOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:14:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Thu, 29 Mar 2018 18:13:56 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: mvneta: split rxq/txq init into SW and HW parts
Message-ID: <20180329181356.6489ee2e@xhacker.debian>
In-Reply-To: <20180329181220.61d63c92@xhacker.debian>
References: <20180329181220.61d63c92@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:404:a::27) To DM5PR03MB2635.namprd03.prod.outlook.com
 (2603:10b6:3:43::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ad48005-a4aa-4848-dfab-08d5955dd151
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2635;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;3:hwrJg4Z1Qqa9TW1nm7xWYWa47t5h+K81ByZ9giOo2chtYWBo3CZsGH638LU1eQh4YtltEJtjWZZoaltpLGuDuFsrfYzEGHB7y9GxOVbNEOlWsHcHB1s7T+GvdDoHA28mg6yFu+N6DKCs5dMWEP55LV0E001ffMnAt0WoCSrLRLE4HOZq9yDo3Nq9+Wo0nFY7n2FyVfn0ZDpemeBUKwTJBUO0p6WeqHmdIYiSp3sjBHdNX82KQA6olLbcWWEUR9cq;25:7FtHpEbMbsc/sLCQdtXz+m4uL+KKBeBjlVaYRkp4h6fD37TC5r+tfGx8nCcyansb7u33wq1tEyuACzZLCxVY4Np90GQECJHj3V1HeVV8p1HMvokPevUznyS029/5tb25F7OlWduxXrbqaBOXax6KxvtMl65GWCGy3TtvI61VAEKkfwWqbPnEimpaOt7l261s/z2I6/Aq2X6nwjyuOCYki/k/WpFrqDHG2XVOWciWP7IjyIFGHUpBqr6Fm+nq3B0KHIdsZ5NYceHtgkdiedGrPR0U1U3HaPWtA14ri/FC/tgMaNBXuSDIjgGuKVgYSR4Zf32qMms6oJDJ4u1tsoPOmQ==;31:fFJIYVC8YaexHzGBu09KbD6AQ0U8Qz8oZTmRq5QA46KTe3PJwiejZWBh9hs9eJsSy4C5wDiFFdW+ttXc+1M4x+4xPgYUpBvzmC8b06zdEMLjSU+QyXiDlv/W7qHcs1Ply6MWK0+x+sfZyR5KxKqLQcP90AtcFf8UWLALHKsq/z+YfsF8gA7JWouz4ciYBfu3su40Q1w0Jj5A3ZCrx0BQ86D8Eh5hwd4wz3L14zSQf44=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2635:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;20:7+Gcw7xCBbIgyA1oJEyAQ73CJZKTDbX4VOf4nWGT7ck41NsGu42GPMpUfHUBwK/A6RDyWy1ZKMiXVzYD4AG0DkFcCfJjXm4mu3TZU6orLbZiOD4wJNaNVNzCbH3P78RMLaaYhRzXyHGJEeJd728Tv9fCReyzamVAXMI74P4iDOXSZ6mB8DgBDF5x7EOQPZ5Z60S6MqCq0O4acGu5VC6axjrADrAKHR4znvKyKCNV9Rz4bEqNTzTpkQCDo5wikpXxXdSEt8aKGgfOBu7Anof2gjhSMfcW+4dZvfB2oFEUVcnHXOvhJRGxUOgVS+WBi7uXa+W5vd9KN78nrlfqCmCxoB1ZsPmgHzYIken2lZysYOw9+QAAW7O/4OpaCUE/Vy55igbHGzoVx66eoeulHawR+yXfSuV1AS9pyo6Nfe8rvCic1uapO20cW66T6yWbeWRyR1EBZI3yoWmbQgTAC4vsyjqxps1uRZoWcZjBlRgSO7wchnfQO0sQ9LbkE9p7OqrJ;4:+B/doKsRK62NAbDfctQKf2xsZBApNQRg0FZPA21IpcoxwmMGK6aW4wd3DeLp7nQoSXpdF1XdWOWfEYbu8fp0RoJqn9PE1NEkQEUSAzViWIsqooAi/XRg5VRtGUzzjm0GtFsTz/IPo6llaF2wUIBToXBTvqsArQNqxc/WeXVapN5KHJbXFtSMHlGHagDKCbv/bk681+pcvalf1mEUI5ofE1CvywVhkjjCWu8w+VG3DIpBF5GVwi4Bc+c8I15VX2TvRNsVS/NY72d8LFzGB3Ay3g==
X-Microsoft-Antispam-PRVS: <DM5PR03MB2635B36BBED141A332B231D6EDA20@DM5PR03MB2635.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR03MB2635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2635;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(47776003)(66066001)(105586002)(55016002)(3846002)(9686003)(5660300001)(305945005)(23726003)(7736002)(97736004)(6116002)(72206003)(110136005)(6666003)(7696005)(50466002)(52116002)(33896004)(59450400001)(386003)(6506007)(76176011)(478600001)(68736007)(8936002)(81166006)(50226002)(81156014)(8676002)(316002)(25786009)(4326008)(53936002)(86362001)(26005)(1076002)(956004)(446003)(11346002)(476003)(486005)(486005)(230700001)(2906002)(186003)(16526019)(106356001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2635;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2635;23:weCzo+g2eQjxtYOiWNNe0/v2nA9bZFWoi+tmdHFqr?=
 =?us-ascii?Q?zIlw11eyJqnFInAyxBNL5z2qR900ZYHT1ILxhreWT2KRh3/T3mcG110E0oEA?=
 =?us-ascii?Q?jOQome8pU5xNXhqRtcrWeRbUeppXy4UeN8nLP+/2/l2lVYMJjZvuwcAap6eI?=
 =?us-ascii?Q?NI+vV4w9rAfTpr8V038EvsgBaq/PCIbDPsXBXsbVk6j61F3NmHQskNrpiAda?=
 =?us-ascii?Q?L1TQuJiD/bbMqmzkU6cjebQbyrm+7AOMhB6A3nQ2aahlE3nne5emWVksTlfg?=
 =?us-ascii?Q?CVWSlNPtCz3UJsF48/DUPKtVtfFSP+0digvQB6A5jhquYFuRAQ9DNxc/l6rS?=
 =?us-ascii?Q?w9Ua0qRS7o20oTlqY0ENIVAnzhCCkvQauLKoleZDzCOHwJYmMgDzW5la6JwB?=
 =?us-ascii?Q?9hDy0X7rHaP/ghmrBDyg2SJdoB98MBaPOdzaB+bcV66zpDQ1bPz6the87qJz?=
 =?us-ascii?Q?i4Ik0UOhbNzJ0Hwa0dGT02Hv+aZgbsozS+4l2dEMtuWTrekI11a0ve3S/rKI?=
 =?us-ascii?Q?qvV82lxYSamvmAn/BvP1qsH+9yafNry0H6iKNRpE3Gp6dxOVDrCKRcIHvmmN?=
 =?us-ascii?Q?QmJC51sk/BURrsvjEbzFlarhMEA3nCTIHehUXBcQP+JfG57ULCv4NsJAgwxE?=
 =?us-ascii?Q?UKGL6KZZrOcfh7LRl7wUENQlW9lXVKE/xHfsZNFWtQxa8q8Vo8OVylKzKUFQ?=
 =?us-ascii?Q?agJg/Kh9tGGXMJ3n1qEbmgwN9JEEhMrdA+sE0aQnwufPZCA2gmyC6rG3iy9I?=
 =?us-ascii?Q?rcoclfah9QbcZvd05aEpBppTJizOMOBP4lUIGLhTnnb1eaUzfvpny1bcqRGc?=
 =?us-ascii?Q?b+byL+hAzc3OQC38BHd/h02T/Lg8Qe0U8a5S8c3VF6i8y99ThqjC8wPvbzge?=
 =?us-ascii?Q?lLYSCb/VGshBQtOua6PsIXvw0FOXNf1CaD3exETxLy6OAIuC1+9WQIpvPCV4?=
 =?us-ascii?Q?ekndq3z4YR49ZyReUI86pcYjj22ZwLbTMeKzwXEo/wT27Bijf9B8p6vkexvp?=
 =?us-ascii?Q?UH2DQkOdAbI8nDmRT/psI4DLaTjccnGiYSmE6vty94ozoEdD6DU4FXLmPbyL?=
 =?us-ascii?Q?1VDiEGa3Q4guRYVNVv6OvpsictUVLEKJyv/Ke2bc8ry1wtiqihLwk8boyFPI?=
 =?us-ascii?Q?E6G4kBroDikZ0bgGu6Fa8GUvk0/VTI4vDE+hT7U6w1Y1pyWQ8zVlwCBvdTaw?=
 =?us-ascii?Q?Om9YilRjkHQtDWd2J7QRvGw6Wohk4pAAbpARJd6V+g8gpmrg/SPyXKK/O6aC?=
 =?us-ascii?Q?+qyqWeSDE+rMrzpWqZUSCk7xY29F6mMAfaTqnlA?=
X-Microsoft-Antispam-Message-Info: vMF8jHot1NuNgfjKmYNeW5LbWpnSi5Pu2Sd28xV2O04RFm4HxLWJ3dPwFa0GkJNDhCeq/f1knEpMsfuO0qscgsvJ1Wx3hsJO0ksWGi49XisLTVSjsqlGUO0ONLn7/EFD5iL4bIzmqjszC/fRUBFQI1n3JTyFXZ+7Wj4wtLVaryoWETlzT4/LOqlxOcz9WnkC
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;6:mopg7FLAeb04b3L6J4Eg4pQAXItMzVv6o68vwGomyZJ8/QrLvCTjljDAjtoo5+keNdIc1ZLDYqrBbpb2eJ9rU1NkfVxIur061n3MLIJQyoYt/CgbWgR67kE89X7xWDHEfhE9XKznARry70vcaE7a/sUQcCPzPQ9mHjvDZUIEtkCbZbkzTCi4aVeRaEeIDe/ltrvYQjdMl1cy7pEU3W0ob1B6z9BMuhX4wRpMpSNOgY8LCQT48r6LwZhrDKkxjCKxmwzgi941GpEfOp024t0ssIsAdVEzFfK2i8ltF0z61VE+NCC0xwfOr8Mm1YloLUbF5qflwBPIjfUo71EZTXFIlpNWNa24efvPGwbFPXUthe9XU5DHx4nS0sVdntCA/B/NW+lBmnzwHna5nXU2zpDdsXdSWX1WULlphRq9fOxsqBET7zMCYWsqbh//DUGBlSiOU5HheHIrJhvwq3qOIm/Biw==;5:UvVQpFuPyh9VwjNSSTSREGG8rz5EL5ccTKg3HeIi/5OgFW9iLohJ70lw5LLxwq5cbSHBO1myjnN0u7+PxIyYzNB0mAJstuxjK1Mf/PipRf6Rc2p5t97GFdNZfkggUFX4YEWlT0ALbddwwpInWZ6ewO9jtxwdtTgXM9ye8ChKVUU=;24:99gAIUzMIyflTRo3QJjJKweT/oW+6ZJNGJ8moaMxUGxVO7h+/341j3RgbHF4QvoTlE3ZiF0pqrPHZ6LPpCUWrT+Af1F7V/DU3DYmJNdZb38=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;7:iPQ/ToXUDAQvFi1iTtXE5GflZYOe15q0dEENacAC4oZfdQXaS2rf015RMFQgPkgrZEmjKe0/yFwxYEv6I4ArIkQiEXh9f/GMzf8ry1wH4HKP+/h9z8JZTGI6Am0e2X+kZDr0b56iA2nJfTmBq2TNtwb1Lixv3KOSt71IOkHjQfOhUxQgtLAwRxhK/bOTKAQmcbTJCN1bD+F8xI/hj8HqL41lBGkR9X34Hd2TNPQCp+dadiLqyfEp/qm/+jkbYqrQ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 10:14:10.3625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad48005-a4aa-4848-dfab-08d5955dd151
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2635
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to prepare the suspend/resume improvement in next patch. The
SW parts can be optimized out during resume.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 70 ++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 30aab9bf77cc..4ec69bbd1eb4 100644
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
+	if (ret)
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
@@ -2923,6 +2930,35 @@ static int mvneta_txq_init(struct mvneta_port *pp,
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
 static void mvneta_txq_deinit(struct mvneta_port *pp,
 			      struct mvneta_tx_queue *txq)
-- 
2.16.3
