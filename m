Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755743AbeCVNwm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:52:42 -0400
Received: from mail-sn1nam01on0051.outbound.protection.outlook.com ([104.47.32.51]:64011
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755692AbeCVNwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:52:34 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <harinikatakamlinux@gmail.com>
To: <nicolas.ferre@atmel.com>, <davem@davemloft.net>,
        <harinikatakamlinux@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>
Subject: [RFC PATCH 5/5] net: macb: Add WOL support with ARP
Date: Thu, 22 Mar 2018 19:21:40 +0530
Message-ID: <1521726700-22634-6-git-send-email-harinikatakamlinux@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.760-7.0-31-1
X-imss-scan-details: No--5.760-7.0-31-1;No--5.760-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131662003518101857;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(396003)(346002)(2980300002)(199004)(189003)(43544003)(76482006)(8936002)(2201001)(2906002)(4326008)(26005)(498600001)(77096007)(5660300001)(106466001)(83322999)(50226002)(316002)(47776003)(82202002)(2950100002)(6666003)(16586007)(61266001)(36756003)(9786002)(2876002)(73392003)(107886003)(336012)(86152003)(63266004)(426003)(87572001)(450100002)(81156014)(81166006)(55446002)(8676002)(5890100001)(105596002)(86362001)(73972006)(356003)(51416003)(76176011)(7049001)(50466002)(59450400001)(54906003)(305945005)(110136005)(48376002)(446003)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2532;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:u8b7rWE0VxazpWMcY4qojeObo6zRwBqrk1BBnUKIPqCtRMVCrGASDaVf6lB9aA9Zz2oGWyRcHJi67WV9me9wPYr2wZ3OVe14RKGhIOaL04LaJnlEIjbVJVMFBSHOKrTC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f22a104-ff06-4b09-7700-08d58ffc2891
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR02MB2532;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;3:oe0QbpIkaO1GC6xahaZ3sr+6s5Y98KBXFSoArUpjgctAG8Owiv7B+kHC+x2/idCGnAvwhqI9HTd5oRjQw5KNkBnNWNaWC8NrnKI9blQe1YkU2p7uclUYK3g0CbRtlIdFoh5lerH9601InB7/l0WAQteWZWX1m+cr8JBREAvFEWo103sA4eOo/woEyXQiKN8zvTj5GC7pBTKiKL6HV5N5gVKKD906/5RdfWCnhcxhdsTY6+zk2BM9OnemVlzm22La3uYoPkQuTIpF5mL2NwMEkt+kPlLhUIa2CmQlgB8e2K+0nZu3mYSi/PAK4X7c2L7T+bM2yHnXzDtP1eIEdvSlYfixW2OzMeSD1K5of+1xqHM=;25:jjPjW1aht2bqMbYWUuXhzorwC2VZWlWRHp6NLmvOMRPNRkhRgJgKWg/tYPurLRyDpMQjuc0+2+g+TpBhWsMfQ+16d/fDlQ4/wIk2sGyEogBXFpdi5LezwaCVR+dUJutx41bSLIkHrJTI8T2g5MRkHuFrjI8Cy/6y453OGRSzCXWsEOUFS6umyvvHY+jfT+yRKIBVvA9S+E1dllSpV895fihxmzRkZhGJk0u9m9JpaE30v0+A1zOQ/FSKVU1L6rs3uv738+Df27GsY1kIfI5K2HD9X2MwnYD9mGBx908w66FK3ekpI+pHks31gY2R+e5nY4fu0RJnjEElpZ0ruKpcdw==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2532:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;31:DZSf00Wps+gktImYv64eFjfhd7RSpn34GBmmF//8hgD9xzoDRT/zWaTCwicwEW9FYwt8sXQ8MiiqFptGTNfoJ742pzmbHUStDIlnvEJOzYtdurg6iZeA6BIyBZt5h00dgWtTNM7ZJiUdUCCfx0tQFj3Wun+2Y89l5S4vUtSbUqOnVSIPt3d+ajtm6QEpU9tf4i6rVAIdLMJQ+vDeVA549sAGwDzmOzBnEw+qh/T4QLE=;4:UHEv3sacHiuOoTKJ5W2diB6n/7yNxHLLG45NtQJ7OgOM0DU3REUHCMWYZoOOo136hQbCpN7h/Z7aw4QRzZ7yy4xfQhmgJ/C8wv64OhVFO2wEtugID4fOE0gDCV8JhWmsvdN3dlSDhpce1cVJWawpyxPxoY5ucL6ANAOmxeYZGaz9VVoulcEBMXYQ9N0pLWyentDl3Yrjpj1HRywp2fXUETpxyc0MnleQBXEuxdWR1EGukC8xl1fgbGQ8IwuIaxX+SKV7RslOBJur2IMU/0ZlWQl0U2d5jAzjqFZtZImM6iYZvYUPoRU24Oz1WSK/Sx9r
X-Microsoft-Antispam-PRVS: <BN6PR02MB253291C325741E9EBC94792FD0A90@BN6PR02MB2532.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123559100)(20161123563025)(20161123556025)(20161123565025)(201708071742011);SRVR:BN6PR02MB2532;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR02MB2532;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2532;23:VahvNYJFsI2f87NzcHCHfsESb9ugCGedaH6Pfaqm2?=
 =?us-ascii?Q?uX5yVmhkzkUVwwIflNBcYCjNjVsKzAhPtJYcciuLziCFHavJMtAY9aiHTnU1?=
 =?us-ascii?Q?8uZYXt5zUQtKrFoPzKRTbnKI7TfU7S6pHF7TnDFkInQwpSixbJU81ET6hszw?=
 =?us-ascii?Q?GkqYM7b4jjYfQ3kWnNj2nyiUJaKFdIECJXHr8Ty+0MTGr5eOAwzWpHKyxmpf?=
 =?us-ascii?Q?qXp+5GQU4gefLe3H0ORYQuIJS23lTnb2sytSy5utLIL7CIFd7iaAxTarEaXN?=
 =?us-ascii?Q?nYx9F/K4vB4TMifB2g/HVOPcN0eZl008j3I56TRCYjwrcZlo6OK05bGqVUna?=
 =?us-ascii?Q?nIH/7MPNOBir+2k0NIToqzodO3Bw55Ztd5lNPDkSg9xXuQV+d4O7zpgfU1Oo?=
 =?us-ascii?Q?7BKYtvsbXknUrSWXWw0UzXw9j6hHlpMWVjkK4pgjFUZKmSPrRlzhp6IdRugE?=
 =?us-ascii?Q?FdCsz/D60ZXRK/m4Hx/pdHrGhMdBe2+EAmDM858N075HvMivWPMgxSiPwNDV?=
 =?us-ascii?Q?4wV6tP6AGC5gDn739ObMbmOpYIhcVWOGRwEA8evVPACxBkTCW0ap/XsVPbTu?=
 =?us-ascii?Q?OoG9EJ6XYlnM5Dy1q3YT5RGGq76Ya5xynNE2Ad1qZCQNN11X9k2ixcapPdKp?=
 =?us-ascii?Q?olHoT3Aq5bJ0cz+4hyl85QDp9AkUYfG7K3fJlxEtEAVzRNgAUsFVGCi+Rhl0?=
 =?us-ascii?Q?MYy8z0hAATIwCu+63UJcQHSIE2VkPkNl6e+C22zNs/kW4KJqKB/1Mx6eFgYN?=
 =?us-ascii?Q?GAnXO8Vbcvmby1YElo27sgCyJgv75ijcpuMEbLvyOtyO0YcHvT7miRh8RrWP?=
 =?us-ascii?Q?B4FBBHJgdcHbUpoXcxjT2fWsRJh62uy/Be7TJDQ6EAOQRuD5v7J+DHqqOJmX?=
 =?us-ascii?Q?KBekztX27o9fg2eE++pjb68OyIWqenccawibW5S9tRTuce7MBtMB0iDS6qHf?=
 =?us-ascii?Q?vM6qc8DHPQndy8W7GrMAAM8kVGadXRnrhrfsVtRp1NG4sZosGOiK2EKUuivT?=
 =?us-ascii?Q?IpNItizgB4TVAnowXq9G1vi5DT1XlrZwPiSyL1ogNy1Jjfhmc//yaeWv4hDa?=
 =?us-ascii?Q?d2aMRiirsUNSoiITeKGsTfC+4Aq/nLpVDAsyyy3tbzqLmCf4aYCQfS6EUKlq?=
 =?us-ascii?Q?iaQfAjgJQbQMMP8/NWjLvWBJC31+4h+ttpUXZejadUd+M9ai2kS4aLI7g4Nv?=
 =?us-ascii?Q?Rqr6lKAk4hsWevSC+AWmhDC8XVExe+DCo6J4mlF1mBLo027PrIWLp54CELIf?=
 =?us-ascii?Q?frlj/+cxliONFWjuSsfTtlFvyJqPLO7t3yCjxbQ8MSN2bGFfLtqIUvGfzX1w?=
 =?us-ascii?Q?N9HlrxDaPqLEi1KWuo5xDA1hprFC8U1F+BoNKIK2qT0wdbzon+3ZpCA49GD6?=
 =?us-ascii?Q?Rfj0OOtJcWqJaLfk5XgzwwoBoY=3D?=
X-Microsoft-Antispam-Message-Info: WmBe+dD73uP1TI3kOSFQT4xjFdxW3KTtS+91CsI9aIbjVscfWe3HCpRojnTUZK1uzs/hiECBrwjdMdyx72DD2iHtNHZXBTbDfTxg3DLIWYiTUVOobz/D0Yn2nnDwEI3MgMEOGjcBeLYdwev4RiY0ITZ3QDM3HYO8YrL6FkJAdjdGq916yTXuZ9V9Q4qMlkGV
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;6:sbt7cpmkc3tymXJXKc478is+13Rd+SGzkhIq9mbLck2al0bhMavhDTi1nePxJzzWvzL0laO4uNHam+FLPZuEWRyjAH4J4MnZT9Ce4u9743HBANj4shtgUBe63KcoZsrzFhDPGyaVSVnQ1ocSFBHtffEqDGnBHsZarN81q6nVCjlc5nb+yoO8qRrfHhqPxyXTw0yowkXhKgxi83RLiouGgUWPGoIBoI35IyTFJYPgeqU+QT+GrvRHS/STopSZobmMKk+Pn8FzqY9WfE6UJSzpYD+gnKpxzKlh+COJZu/z41zXwWEI/beKDleguD62XYcl1W6YfHx4LBpZQvJujfiiY55RtZ9aSbVeXRpH4kuy/nrsZ/yRrOg05T6vStNI43jAP7B0mgmTiTeJl4IeD293XgB1FrRjiKRG3r+BHtN/v/43ugj6aBXD/xkQS4SNA58TH5YOpCElV297X2EPY+ngkg==;5:HgjSqFH6WiD3iCdhQNndrrp+cqyeMqM+hMgMbb389qrY68UUNSeNiXTLsXrFTjfr22mYSPa2JCIES7L+3LHdyvtF5HzfgVpWiGJU2rEQVkDe9xIcZgnVqUGONcwNelOkY3FtFgN3iDIsCRZlcSy+IUuxf5SaFBhRhBSxmjdozag=;24:kASkcJ9+3uu7a48LpjXMvm/8ddeFlQr2JK2RM4DkP7B/TFhIw5SuHVjMilZ/KnVpOlTVIghRT2DRI8lzouppVNGcDeab6OY3ZSvuzrmg8Po=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;7:omvqaZ4gIC3R3iFF4sc2YHHA64b5pgg8NGvnjsuJhlXW2JENjsZGQiCxlhyfNKS0ctgw3kBzMuuAHWSM/AiHv3U1MXumIEFzyMkQKhGqPKyuIW2TO7RPPu2wzQpajWGXuh8rsElmv9zBd6M9FiCJJJzTuvBlYSNFfVQ3QxfiGHhjwY52nvyZJpCNuLy/Z3AQnhqWayaBHCv3R8Yc8rX9Itj5XTFCPnQg4R+2RiKYcxHXSULvK8zG7xsCbvD6BP1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 13:52:30.7945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f22a104-ff06-4b09-7700-08d58ffc2891
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2532
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

This patch enables ARP wake event support in GEM through the following:

-> WOL capability can be selected based on the SoC/GEM IP version rather
than a devictree property alone. Hence add a new capability property and
set device as "wakeup capable" in probe in this case.
-> Wake source selection can be done via ethtool or by enabling wakeup
in /sys/devices/platform/..../ethx/power/
This patch adds default wake source as ARP and the existing selection of
WOL using magic packet remains unchanged.
-> When GEM is the wake device with ARP as the wake event, the current
IP address to match is written to WOL register along with other
necessary confuguration required for MAC to recognize an ARP event.
-> While RX needs to remain enabled, there is no need to process the
actual wake packet - hence tie off all RX queues to avoid unnecessary
processing by DMA in the background. This tie off is done using a
dummy buffer descriptor with used bit set. (There is no other provision
to disable RX DMA in the GEM IP version in ZynqMP)
-> TX is disabled and all interrupts except WOL on Q0 are disabled.
Clear the WOL interrupt as no other action is required from driver.
Power management of the SoC will already have got the event and will
take care of initiating resume.
-> Upon resume ARP WOL config is cleared and macb is reinitialized.

Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
 drivers/net/ethernet/cadence/macb.h      |   6 ++
 drivers/net/ethernet/cadence/macb_main.c | 130 +++++++++++++++++++++++++++++--
 2 files changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 9e7fb14..e18ff34 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -93,6 +93,7 @@
 #define GEM_SA3T		0x009C /* Specific3 Top */
 #define GEM_SA4B		0x00A0 /* Specific4 Bottom */
 #define GEM_SA4T		0x00A4 /* Specific4 Top */
+#define GEM_WOL			0x00B8 /* Wake on LAN */
 #define GEM_EFTSH		0x00e8 /* PTP Event Frame Transmitted Seconds Register 47:32 */
 #define GEM_EFRSH		0x00ec /* PTP Event Frame Received Seconds Register 47:32 */
 #define GEM_PEFTSH		0x00f0 /* PTP Peer Event Frame Transmitted Seconds Register 47:32 */
@@ -398,6 +399,8 @@
 #define MACB_PDRSFT_SIZE	1
 #define MACB_SRI_OFFSET		26 /* TSU Seconds Register Increment */
 #define MACB_SRI_SIZE		1
+#define GEM_WOL_OFFSET		28 /* Enable wake-on-lan interrupt in GEM */
+#define GEM_WOL_SIZE		1
 
 /* Timer increment fields */
 #define MACB_TI_CNS_OFFSET	0
@@ -635,6 +638,7 @@
 #define MACB_CAPS_USRIO_DISABLED		0x00000010
 #define MACB_CAPS_JUMBO				0x00000020
 #define MACB_CAPS_GEM_HAS_PTP			0x00000040
+#define MACB_CAPS_WOL				0x00000080
 #define MACB_CAPS_FIFO_MODE			0x10000000
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
 #define MACB_CAPS_SG_DISABLED			0x40000000
@@ -1147,6 +1151,8 @@ struct macb {
 	unsigned int		num_queues;
 	unsigned int		queue_mask;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
+	dma_addr_t		rx_ring_tieoff_dma;
+	struct macb_dma_desc	*rx_ring_tieoff;
 
 	spinlock_t		lock;
 	struct platform_device	*pdev;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index bca91bd..9902654 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -36,6 +36,7 @@
 #include <linux/udp.h>
 #include <linux/tcp.h>
 #include <linux/pm_runtime.h>
+#include <linux/inetdevice.h>
 #include "macb.h"
 
 #define MACB_RX_BUFFER_SIZE	128
@@ -1400,6 +1401,12 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	spin_lock(&bp->lock);
 
 	while (status) {
+		if (status & GEM_BIT(WOL)) {
+			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+				queue_writel(queue, ISR, GEM_BIT(WOL));
+			break;
+		}
+
 		/* close possible race with dev_close */
 		if (unlikely(!netif_running(dev))) {
 			queue_writel(queue, IDR, -1);
@@ -1900,6 +1907,12 @@ static void macb_free_consistent(struct macb *bp)
 		queue->rx_ring = NULL;
 	}
 
+	if (bp->rx_ring_tieoff) {
+		dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
+		bp->rx_ring_tieoff = NULL;
+	}
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
@@ -1979,6 +1992,14 @@ static int macb_alloc_consistent(struct macb *bp)
 			   "Allocated RX ring of %d bytes at %08lx (mapped %p)\n",
 			   size, (unsigned long)queue->rx_ring_dma, queue->rx_ring);
 	}
+	/* Allocate one dummy descriptor to tie off RX queues when required */
+	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
+						macb_dma_desc_get_size(bp),
+						&bp->rx_ring_tieoff_dma,
+						GFP_KERNEL);
+	if (!bp->rx_ring_tieoff)
+		goto out_err;
+
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;
 
@@ -1989,6 +2010,34 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
+static void macb_init_tieoff(struct macb *bp)
+{
+	struct macb_dma_desc *d = bp->rx_ring_tieoff;
+
+	/* Setup a wrapping descriptor with no free slots
+	 * (WRAP and USED) to tie off/disable unused RX queues.
+	 */
+	macb_set_addr(bp, d, MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
+	d->ctrl = 0;
+}
+
+static inline void macb_rx_tieoff(struct macb *bp)
+{
+	struct macb_queue *queue = bp->queues;
+	unsigned int q;
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues;
+	     ++q, ++queue) {
+		queue_writel(queue, RBQP,
+			     lower_32_bits(bp->rx_ring_tieoff_dma));
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			queue_writel(queue, RBQPH,
+				     upper_32_bits(bp->rx_ring_tieoff_dma));
+#endif
+	}
+}
+
 static void gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -2011,6 +2060,7 @@ static void gem_init_rings(struct macb *bp)
 
 		gem_rx_refill(queue);
 	}
+	macb_init_tieoff(bp);
 
 }
 
@@ -2653,6 +2703,13 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 		if (bp->wol & MACB_WOL_ENABLED)
 			wol->wolopts |= WAKE_MAGIC;
 	}
+
+	if (bp->caps & MACB_CAPS_WOL) {
+		wol->supported = WAKE_ARP;
+
+		if (bp->wol & MACB_WOL_ENABLED)
+			wol->wolopts |= WAKE_ARP;
+	}
 }
 
 static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
@@ -2660,10 +2717,11 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 	struct macb *bp = netdev_priv(netdev);
 
 	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
-	    (wol->wolopts & ~WAKE_MAGIC))
+	    !(bp->caps & MACB_CAPS_WOL) ||
+	    (wol->wolopts & ~WAKE_MAGIC) || (wol->wolopts & ~WAKE_ARP))
 		return -EOPNOTSUPP;
 
-	if (wol->wolopts & WAKE_MAGIC)
+	if (wol->wolopts & (WAKE_MAGIC | WAKE_ARP))
 		bp->wol |= MACB_WOL_ENABLED;
 	else
 		bp->wol &= ~MACB_WOL_ENABLED;
@@ -3895,7 +3953,7 @@ static const struct macb_config np4_config = {
 static const struct macb_config zynqmp_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 			MACB_CAPS_JUMBO |
-			MACB_CAPS_GEM_HAS_PTP,
+			MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_WOL,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
@@ -4093,6 +4151,9 @@ static int macb_probe(struct platform_device *pdev)
 
 	phy_attached_info(phydev);
 
+	if (bp->caps & MACB_CAPS_WOL)
+		device_set_wakeup_capable(&bp->dev->dev, 1);
+
 	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
 		    dev->base_addr, dev->irq, dev->dev_addr);
@@ -4170,16 +4231,58 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	struct macb_queue *queue = bp->queues;
 	unsigned long flags;
 	unsigned int q;
+	u32 ctrl, arpipmask;
 
 	if (!netif_running(netdev))
 		return 0;
 
 
-	if (bp->wol & MACB_WOL_ENABLED) {
+	if ((bp->wol & MACB_WOL_ENABLED) &&
+	    (bp->wol & MACB_WOL_HAS_MAGIC_PACKET)) {
 		macb_writel(bp, IER, MACB_BIT(WOL));
 		macb_writel(bp, WOL, MACB_BIT(MAG));
 		enable_irq_wake(bp->queues[0].irq);
 		netif_device_detach(netdev);
+	} else if (device_may_wakeup(&bp->dev->dev)) {
+		/* Use ARP as default wake source */
+		spin_lock_irqsave(&bp->lock, flags);
+		ctrl = macb_readl(bp, NCR);
+		/* Disable TX as is it not required;
+		 * Disable RX to change BD pointers and enable again
+		 */
+		ctrl &= ~(MACB_BIT(TE) | MACB_BIT(RE));
+		macb_writel(bp, NCR, ctrl);
+		/* Tie all RX queues */
+		macb_rx_tieoff(bp);
+		ctrl = macb_readl(bp, NCR);
+		ctrl |= MACB_BIT(RE);
+		macb_writel(bp, NCR, ctrl);
+		/* Broadcast should be enabled for ARP wake event */
+		gem_writel(bp, NCFGR, gem_readl(bp, NCFGR) & ~MACB_BIT(NBC));
+		macb_writel(bp, TSR, -1);
+		macb_writel(bp, RSR, -1);
+		macb_readl(bp, ISR);
+		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			macb_writel(bp, ISR, -1);
+
+		/* Enable WOL (Q0 only) and disable all other interrupts */
+		queue = bp->queues;
+		queue_writel(queue, IER, GEM_BIT(WOL));
+		for (q = 0, queue = bp->queues; q < bp->num_queues;
+		     ++q, ++queue) {
+			queue_writel(queue, IDR, MACB_RX_INT_FLAGS |
+						 MACB_TX_INT_FLAGS |
+						 MACB_BIT(HRESP));
+		}
+
+		arpipmask = cpu_to_be32p(&bp->dev->ip_ptr->ifa_list->ifa_local)
+					 & 0xFFFF;
+		gem_writel(bp, WOL, MACB_BIT(ARP) | arpipmask);
+		spin_unlock_irqrestore(&bp->lock, flags);
+		enable_irq_wake(bp->queues[0].irq);
+		netif_device_detach(netdev);
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			napi_disable(&queue->napi);
 	} else {
 		netif_device_detach(netdev);
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
@@ -4206,16 +4309,33 @@ static int __maybe_unused macb_resume(struct device *dev)
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue = bp->queues;
 	unsigned int q;
+	unsigned long flags;
 
 	if (!netif_running(netdev))
 		return 0;
 
 	pm_runtime_force_resume(dev);
 
-	if (bp->wol & MACB_WOL_ENABLED) {
+	if ((bp->wol & MACB_WOL_ENABLED) &&
+	    (bp->wol & MACB_WOL_HAS_MAGIC_PACKET)) {
 		macb_writel(bp, IDR, MACB_BIT(WOL));
 		macb_writel(bp, WOL, 0);
 		disable_irq_wake(bp->queues[0].irq);
+	} else if (device_may_wakeup(&bp->dev->dev)) {
+		/* Resume after ARP wake event */
+		spin_lock_irqsave(&bp->lock, flags);
+		queue = bp->queues;
+		queue_writel(queue, IDR, GEM_BIT(WOL));
+		gem_writel(bp, WOL, 0);
+		/* Clear Q0 ISR as WOL was enabled on Q0 */
+		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
+			macb_writel(bp, ISR, -1);
+		disable_irq_wake(bp->queues[0].irq);
+		spin_unlock_irqrestore(&bp->lock, flags);
+		macb_writel(bp, NCR, MACB_BIT(MPE));
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			napi_enable(&queue->napi);
+		netif_carrier_on(netdev);
 	} else {
 		macb_writel(bp, NCR, MACB_BIT(MPE));
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
-- 
2.7.4
