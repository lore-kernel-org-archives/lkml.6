Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068BCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E5A20652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Dm1z1wBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E5A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeH2MZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:25:59 -0400
Received: from mail-eopbgr700073.outbound.protection.outlook.com ([40.107.70.73]:62679
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbeH2MZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpvJCTsq5QMMRNn+jWnajjQQLCmK9HG+EYZwyG3RlXk=;
 b=Dm1z1wBo014Sq/B3UIlc+EeurzYoM+53+JUPpsne8pCq/c0+e3xqsiA6nJO9pDT9x+lzzKivUs3Ou0a8rbh4t8EGemRu6L2GlHC50PMFBhC7oPWKK2fDb5er22wB0DwmEz6Ubd3/XBpG9KcNDEZm80gGfptg2d/So8XWr3v2ULc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Wed, 29 Aug
 2018 08:30:08 +0000
Date:   Wed, 29 Aug 2018 16:27:06 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] net: mvneta: fix rx_offset_correction set and usage
Message-ID: <20180829162706.24111f9c@xhacker.debian>
In-Reply-To: <20180829162456.2bd69796@xhacker.debian>
References: <20180829162456.2bd69796@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::17) To CY1PR0301MB1578.namprd03.prod.outlook.com
 (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff24efc4-36b5-45d9-2f69-08d60d89a24b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:Y5rr7JqScCJz+Z5Bk78sXqP1UYSOAWEORdbEJks8N8DVxcuQ9efe/yQ/CSf599aUXuX/HHk0XBsV6b19A9VgoEKt2Jf5hy6AmmD4oL7xqs7e9CnNATQkTHR8joJLYA9IuMElEUJDR4WVbfyyRtYiTi/OFpqLaFr8xUwZMVh+dE9qy40CERxDEXM1kw1M4r9lzcqAaPnAWoRdEQyYAR7vE067SklTbP4Fe48kC1wNVFT6S2Me/aRFXeg4+pHow+ms;25:M0KDcIetDiAdHpSg05Ft10FNOW7rB6N7zz5xCaQEingJ6G9w4qIkfwpNWofGlzZgONn3FPvUUOXTy0CZAnaZpDdHKmkFR/RCpKYSiFMX55wAvlMQvczogfqyj6umTCpSr+JoADiuaxGqVZ+PopZ9PDdQkxSxkB7+MYUNXd1Kk+chSJv6xGpUl7awD0ZVUcAetc6qWDduCmc7saNxocgUG0Uld0EROo8f7X7MJoLypmNFYN6q17SQsLrVJmj49yDxpIb8HfSHxH8GGLyxTOBcBL5NLPjEdyBMOLIDFk/hfytDmZTMSYzUjlHbsyZAt2elldRDhdJ5dUVvlUKtudbZGQ==;31:N7b9Id8vwOP/gdZKUKO7korETGVmj99dQ9QYx4/Ow/CQCQEZcbEhEAQzLViRPqKTMcuBYjqLGVuFXrf2aEA29CYmRS9tWXjRcunsU+413zQkGLKkWnhFuuU48Grefq5kRvnhksHuoW0iwLWL2pZR3beauuBzPa8r329TNQcBpb1ro0KZbp8EGRrqcK/xgRzjQjcL730gd3OmJC/vjm/V64Bh8UhuB0XX3WX6zdSXT+I=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:5CaRY5BAh9r/QXmdmGR7ZEVXlCMRuid+pdhIvZYswLMRKzd2iqkcSXH4E/gAZSqbu+tBkbFvBH4XfCR2HpvgpF6alFAEKyUgTe53ftJwCDNU7TRDOdQ/zH3RybtIgCJ6yEbPpoh6wezhCaIKHMR4d+H6hvcWkLSwj9+KaFoeuOY3WL2nZKkHxIfU4jDRRzWyAcwA0byfGZJL46YHtyXz/Au+g7lkSCylw81Q9TuhbRkwMK+8E6qOso0X4J8WonyYXqRaflZQaie3NvMURE0EO87o2IHjXBrCyMTl5dk+mh7lfPadiyyrL/SVYgf17PqTzc3JHqfOOBXqOBaZxXdI1NmkkgEmE0kjuyn9c3aI0/Sr4PnAvW6xlun0UO8wPCM9ePPCr2pEl0/K46xJy4+YtSIV9bMI19aN4VerHq3/l6wLSgzJvjYfaTsUki8asz3hSrcMuaIZ2v9T9Ka1mAW+ntlkVpK9pV3nMoaqUnbwI8JjAhV3tEHPGOovhR3S2s4E;4:lDZmkQU8d2vKzc0bT2BXT3SmYsX+aumm+dWnU7oy2JmZAYrRVXQdAkXX8pXiV73ZPhvCKASxH14hP8kKv9hu5rVYa1+f6VqRJZsuENdET7cBdHNof5g+cj/pFkGbS7NdFJbtq+CuWIfK9MfKxqAh96V7l78RqOF2dgD+Lla94e/c4OtUpJ8ZcvJ7yc+Tubsa/yOOsxviARwYejSFR8cOEGaZ1O5FTgKVOkXNX9XItbwqxaDOHoFVQAVJ5vddk76LpOVxE74E+0R2N/aAStLy5A==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB157861A6E4C139D4699093CBED090@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(11346002)(446003)(50466002)(81166006)(26005)(305945005)(68736007)(478600001)(3846002)(81156014)(8936002)(86362001)(76176011)(386003)(6506007)(97736004)(52116002)(7696005)(72206003)(50226002)(1076002)(23726003)(956004)(14444005)(6116002)(316002)(33896004)(54906003)(110136005)(16526019)(186003)(2906002)(8676002)(7736002)(230700001)(55016002)(9686003)(106356001)(476003)(105586002)(5660300001)(486006)(25786009)(4326008)(53936002)(66066001)(47776003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:vaGkosicxCeEepDUTVOCWEILHMkNmZUHXzrOFjP?=
 =?us-ascii?Q?tdQHqXmrwq2LFOI/RmOY4rhof+ChYyW7x5FTlsyi8h8JYeaEfk+3W5o8sD/s?=
 =?us-ascii?Q?KvHTRdGKSgAg4SINUm3Kt1WffymJINaM21JtGr9ArDDRd8ADUy54VwCdezte?=
 =?us-ascii?Q?LwAoKVkW6S1u6/QUrN8u84yucjpJ2/GQI5XA31uozqft1YY0Qij2w9k18YX4?=
 =?us-ascii?Q?VIhRaw56Mlyg94DurgfTd46EGFmrfUeCHETwqydQp7W1gHVNsRiU9cU7P4ot?=
 =?us-ascii?Q?IbKFsBg3W2Qw4r7A16pFC/Fyislh45OF+pyrVOi4ienrUX1KtdXLTjs/nRr1?=
 =?us-ascii?Q?RbaGqvxU1vSKHz4rLvreiCHnaLJeIEI2uZAY+0zqf7IcLz3pkgVava42PGEO?=
 =?us-ascii?Q?DhbWyQypKA5YzUdE+bJIsEyB5RZ1DrL9wVPIVphwgCwIga2HEf8KkpaN+ftU?=
 =?us-ascii?Q?xojwnq0sEb1XAL8mR4F9+IQ4/uPeMvyeJkdrj5uVkbrZTsGTulPaTqRJmIlj?=
 =?us-ascii?Q?lp46WObiW5iENvbZeAVnGD5Tylf5dNcmnDxen43VkJl9TdavWWHBE1RLiWRv?=
 =?us-ascii?Q?G6pitxI/Qtj6AKutL/vCib/MX7le5012OEJYUsahrsdy4M5F4BcLpDGsIJE2?=
 =?us-ascii?Q?XQI5e/bD+s4FN0fUOkkYwGUclxRob4ZQHF/tv4zVme83+uhKhDfXpXL3a/p2?=
 =?us-ascii?Q?7BTo1ooVVio3S+hNP5Xf0K7SJM0dO40WrBH86eoUs18gXVa36oA/Ocz5myg/?=
 =?us-ascii?Q?nFy7y3oKrueZqgZf+XlI0T4FhyZ0yzz48GOd4gZg9j4KJXsF9wGvBwegcEpg?=
 =?us-ascii?Q?p53kZWqeCeQj3x4aUHOLW8AH7j7NVCOGndLibOWA0OhPvrd/tXW54zSuFzJO?=
 =?us-ascii?Q?pYv52zjmBwYMydhoLh37a2YKiMtypqoX7F41Dqb8Fpt51cQsOaWAtucaRfNi?=
 =?us-ascii?Q?Uye+Uj5mxzmqvA5PoXPiea/JQppL+hSVayD9FgfsvE0YsEAjebFGo0srvn9v?=
 =?us-ascii?Q?LB9nmQl7E5eYM55wV/IVKnrw7626v97UF99uvR2dYHh5SE/kR5p+5b0oA/0J?=
 =?us-ascii?Q?RhWt2HUZpk+p+wxJyO2ZX8yChfAOg79jWTob+o7kufAjbMoMDz303gzZpILx?=
 =?us-ascii?Q?Ee0tbXfYaFS+yw3u3idPk6jT82kFhMz6l23lQCeg273aPBaQQD8bc2o8QaJ4?=
 =?us-ascii?Q?e+RNXU+G1NyqErh0y+lmTWfqk9u2wq9i32bcy5NmrfNG2sUoseZWyCzR0PEs?=
 =?us-ascii?Q?x3ZuZzKDAOQxn80mXzfc=3D?=
X-Microsoft-Antispam-Message-Info: ZvDc0SivJLQGg4kcthX+BI2ST1i42PK4UnHAMPm1/S0R7p5eVlwIhNMfgRmgiLkZXZM2jtiuGOFMT8e4Y1o59G9SxKQ6kFNKM9vZwV6T6r8YWgaK1taPhp/oqodCNhnUAhUe1+P8dQtbAwqiip38D0EHKWM8xDv0XaY3vCAQ4jShag5epPPkqTKrwF3Mo2SKORL8EzdyjGJqfN6mAovzKbv1Uj0YVanYWlX3YVVjyPhg24W0psvzyK6ocQukgLOMQSiNwvj5Tp2IpHR1yDuToztv1d3SHIxNtVWxHHS89kZV4skOjJTbbfuNXVl2gAF2BEY13Rs0XhEaLZJEt3dneeX2Rj4UwNj25ba2rh7bxmQ=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:O+P1BTOjvwbC3A77ivJWJa/Mkd+AncyGc1scIbatiXXAMmsk7ZxQ8ohfGVPjpvua4IjzLohdE9jfIZjgmPXKLTRBg5afUw952x8o1rRnSdhWv7r10ghWDFZPM4modX7Pwonoi//ZrmxMwTqLZyg/3wBPTdhfCqw6m5xBX8fOvSpaq0LhFjlRbDY3GeAwBc7zKAHOvsEDD+VdKno5FR1pznPSIXrTuhvMjBvJbZoByEvSZPeBiMRIA0kYffWB0hSQCZFDM6KrlRHPNnJ3TgyjGylM5CM//WdjxI/QxoTrAAwclUaCJQwhU1oyUA+02cgNgz4mdVCxmzhySKZoOHmqZH5UZkrmOEWvSW2Y22zTN3mBgVzpGwXs1kudNorQpu58GdD4WBoaeDfFB9ZeFyzng35fvCCfztC1GtgbeDez37uYfAvsTynSSgZUfXlfGpOEKqclG2Gtr8gc1PtTSwKmDw==;5:WbOhcDrW7JZhHCAxajJzZ10bVEkf7L9wUyGXN00ku8UWrQN2pIE8hgWgiKl9xLgWZ6xLme0tNM9h08xiN9ShtoK6M7GdxB1pUT1OovKXn+XYocxnbFyUtaegbQx9dAc69HbzFGCzAohJtWtlg7TxXkHiLXHazKeSV9i8ABSnWyM=;7:NoeD0wdrvJL97PTe4IcsGZSKdyO6BvJXccJHAkSgQDTC5QQid++rSYuL+yWW/eIlrxv+aJ1S2+M00wnR9DpScfa5nifnnkiVncH4L3H5a+y3C24aKR2ZnRN6zcKonxXf+yhniD3a081bqJhbHahpzKreVk43/OUqFst70UMpnUq/t0b1KyDyukXBX8FfkCLulplg9rpc6TjRMekMY12H9h9k8obcB8n/3AEbTbxgU7ats1YoPyenkXiJQ9Hej0/1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 08:30:08.5113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff24efc4-36b5-45d9-2f69-08d60d89a24b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rx_offset_correction is RX packet offset correction for platforms,
it's not related with SW BM, instead, it's only related with the
platform's NET_SKB_PAD.

Fix the issue by reverting to the original behavior.

Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index bc80a678abc3..0ce94f6587a5 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2899,21 +2899,18 @@ static void mvneta_rxq_hw_init(struct mvneta_port *pp,
 	mvreg_write(pp, MVNETA_RXQ_BASE_ADDR_REG(rxq->id), rxq->descs_phys);
 	mvreg_write(pp, MVNETA_RXQ_SIZE_REG(rxq->id), rxq->size);
 
+	/* Set Offset */
+	mvneta_rxq_offset_set(pp, rxq, NET_SKB_PAD - pp->rx_offset_correction);
+
 	/* Set coalescing pkts and time */
 	mvneta_rx_pkts_coal_set(pp, rxq, rxq->pkts_coal);
 	mvneta_rx_time_coal_set(pp, rxq, rxq->time_coal);
 
 	if (!pp->bm_priv) {
-		/* Set Offset */
-		mvneta_rxq_offset_set(pp, rxq, 0);
 		mvneta_rxq_buf_size_set(pp, rxq, pp->frag_size);
 		mvneta_rxq_bm_disable(pp, rxq);
 		mvneta_rxq_fill(pp, rxq, rxq->size);
 	} else {
-		/* Set Offset */
-		mvneta_rxq_offset_set(pp, rxq,
-				      NET_SKB_PAD - pp->rx_offset_correction);
-
 		mvneta_rxq_bm_enable(pp, rxq);
 		/* Fill RXQ with buffers from RX pool */
 		mvneta_rxq_long_pool_set(pp, rxq);
@@ -4547,7 +4544,13 @@ static int mvneta_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	pp->id = global_port_id++;
-	pp->rx_offset_correction = 0; /* not relevant for SW BM */
+
+	/* Set RX packet offset correction for platforms, whose
+	 * NET_SKB_PAD, exceeds 64B. It should be 64B for 64-bit
+	 * platforms and 0B for 32-bit ones.
+	 */
+	pp->rx_offset_correction =
+		max(0, NET_SKB_PAD - MVNETA_RX_PKT_OFFSET_CORRECTION);
 
 	/* Obtain access to BM resources if enabled and already initialized */
 	bm_node = of_parse_phandle(dn, "buffer-manager", 0);
@@ -4562,13 +4565,6 @@ static int mvneta_probe(struct platform_device *pdev)
 				pp->bm_priv = NULL;
 			}
 		}
-		/* Set RX packet offset correction for platforms, whose
-		 * NET_SKB_PAD, exceeds 64B. It should be 64B for 64-bit
-		 * platforms and 0B for 32-bit ones.
-		 */
-		pp->rx_offset_correction = max(0,
-					       NET_SKB_PAD -
-					       MVNETA_RX_PKT_OFFSET_CORRECTION);
 	}
 	of_node_put(bm_node);
 
-- 
2.18.0

