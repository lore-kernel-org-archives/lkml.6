Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeDNUyv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 16:54:51 -0400
Received: from mail-by2nam01on0076.outbound.protection.outlook.com ([104.47.34.76]:28285
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751614AbeDNUyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 16:54:49 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
From: Rafal Ozieblo <rafalo@cadence.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Rafal Ozieblo <rafalo@cadence.com>
Subject: [PATCH 2/3] net: macb: Add support for header data spliting
Date: Sat, 14 Apr 2018 21:54:32 +0100
Message-ID: <1523739272-24032-1-git-send-email-rafalo@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
References: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39380400002)(39830400003)(2980300002)(189003)(199004)(36092001)(2616005)(36756003)(76176011)(356003)(7636002)(246002)(486006)(59450400001)(186003)(6666003)(8676002)(48376002)(476003)(50466002)(2906002)(5660300001)(51416003)(478600001)(87636003)(26826003)(426003)(2201001)(316002)(8936002)(86362001)(50226002)(26005)(6346003)(105596002)(305945005)(126002)(106466001)(42186006)(336012)(47776003)(11346002)(16586007)(110136005)(446003)(107886003)(4326008)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB3916;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT051;1:e/NrBhFlNyebvEebkhqHpS+CPGzV4j0eomxxjCUy160FV7hmGLT2WhYobCFgGdnlkYbBo51hZfxJJ0icSxDCUk5tqzXSGFL1StKWbJ9riO7eAMfMvzQLXT91xBU0nJz6
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MW2PR07MB3916;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3916;3:R/39tE0mdzu+W+4h57PH9VwVRQN1f77Dwn1NBeScazVdegVcqnlZM7uDC3K0ls79XgP1XzYofUbwh+cOBdIOCq2Z+pUaZmx1/Awh3L4jKeJ4ukp/CJLeLWDIsFka81kTllbk6SOk2N6X251Hi7elBq8woxsR0VAvRndRRZHzfdMFIxdZM9NhN69/A/hzsT/2cub6IgI4goIaS3wKKF/lVGbvjjXv9in0TkworYGzzeq7mlYRvOg+AvIsC1H2341HVmdKpyuHjH7C8L07z2GPKMlIHcNDX8XlwRCbWYVStoGelu5Sgk7KgcZFc3PDEfaYAzseR9ldyk4ofZQWYUA+nujiRrbnUOgm+Go1QHsAzdM=;25:YUTRXIWhoFOfwYmMkHj/CptojBe9grZ/jlovpIOQgOfsk3iRUINnOuQMGDhQHJxrl/SDdEWYbXWplisoZe0z9+tqzv8XEgAnGQWcJfKsS3BiEIlis3HQAlRu8Xkahqa8h9D48p+1jz+qyVNv5Vlg6G4jcMc7gZaaYjqWVAQLTNKenNR21pr5chAQBEuUMo72T1/j6kRO+qKxJPqKFnuzR43wQXEkKx0CvNPa0fo1LTFa/9dPyKqQvsRkvYd29YKCKy/Su17ynXvRd3H485y9C22NCKLcYqONijjEJ5eA6AfL8/6+E0b4C8DVofMGP25UOAMvy6w4bfPCtsUAZbyF+A==
X-MS-TrafficTypeDiagnostic: MW2PR07MB3916:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3916;31:9j60gR/lVS/8UxxBwRasXPaAo/Mza3FGva+hc/OnsG/OszkhnofQGvkBRrW1Fu90cfsPnDB6hyh//HRpjH66qUrozqbgcRAoTuvhKokffWi6unO0hAOs5Pah7WIV1dM7jxw+qZZ+cT8V8IrPG9qXX6amjmtRDxzVw1tX+KhBOWA2z0dTrZjvKRhU3KP5lboyK1Oa5wEvrh/clILdvFKHMIbqooft8dntDJmV0vAeg7E=;20:SykKBSQRIuxxmsgEEc6aojmSxTMQTOsMu115B+gNNHob87/D8RsFhwtj3Q3l4E9nmHWd2JU221TXmtDoMbuViitPzBQmnn7wWsv5/HpgEjCHn7Ux3Ut4KqvPGWH5MpnwQw7JO6txFoubje1aMrzGeEUUixr5s6X49SdvqlSxahoNkG+PG0J4SvXJWGe1QyA6ETQsmXUFRc6owjKvZjgSfxVrjz1vAkVTqqIaBRi7wOk1/xLCHe9XNnJe37qGqGa5aQcC0jid1a6VZPMcfUUDozUIXRArC+kYZDlSRJr+RHSvH2RSGs20wbUukwIZG9xRYdsN63/TRiH4r8H4rjNZ6MupvxD/f1Ac+61NqMRMSKDNiyuhMYXLpyBTKBHso1x+6P6AlyZVbsL5gLoW7BcSlGxI46OO2aHX3mHuAW68yurSWTgl/OSv59dxb70C5Ga90MbYwwcjhRpG9lF+B3vJx7PXDTnfz8JFdc5YQHamJ8s6/bnhfNibVYYt+dI4CnmG
X-Microsoft-Antispam-PRVS: <MW2PR07MB3916A08DC99032EC3C83D295C9B20@MW2PR07MB3916.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(10201501046)(93006095)(93003095)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR07MB3916;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB3916;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3916;4:JhBiIXn1YLsjZlOizQb4JMNGYVx74XzrjGDK2XpjraN+AajiA1CgDr7W8xoVc6flsLxynU6ykJSPupdvGOYNDEOVL/AiLs1q21wxz9lzD/8DBrAhyMu80wAJ0U4kf0pbLyHR1VnuAmTtxJmaWvxc9HaiYTkpZIFebF9sfz69b/xkCCAK5a6D4scxCoa2fOhjtuMI5cabUn0Y7NdxaUqqggVxyMtx2BXQmnWuWclapqc/kROMlbTWbcIW20AlkTwGDwEjR+Zu8fspExByeV8DFyC1s73oflqqQOQnh0JQFWZ8LjUjeS1l1XVKAvH4b6pF
X-Forefront-PRVS: 0642A5E7BA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR07MB3916;23:b7l4km5BNMSiGRhzF34fkoBPuTF8SVg/wl48p3pqs?=
 =?us-ascii?Q?nv+bVXA43yu8oAS2fL6RAPAsX/AuJqHkqH3XFI6wHGZ7dPqHsWS4ZJDt1O8I?=
 =?us-ascii?Q?xSBt7Gij7W2XxKFAWAGX7eOShBkhcv6IgEn8G9If/wqPv7M7yRmbYtE0jXzF?=
 =?us-ascii?Q?cloxubIN/4z3mLizXS4jKv6qMpU9wX/O2woMI8+EQIis/yHnKrjKJGi+D1na?=
 =?us-ascii?Q?+ApSjiKp8rLgVSb51tEIe3eMk3nWG+Ahegx4ia+S6qJnARrDkt8mbswd6H7a?=
 =?us-ascii?Q?uiL/jZXEowvH2iStNrC1VcQUFXxV5BvcxpDT+OWWIzytklCu8wS+fEG91B/f?=
 =?us-ascii?Q?Yqb5ezs+6jzXgci76xm7WlEEGnS+9CbBuzwZudxKmKwJUuZ8j2bLRUf5K+yl?=
 =?us-ascii?Q?q3yb2j9rDTvrl+e8XBU8cDabn4Lkqyp8WUuRyDKj2ho+h718+I8S7/TstV48?=
 =?us-ascii?Q?BNlnneUjyuyPTaVnwih3jKrl3WeCKHvf6atiT+Ug/V5+BWphBVLY3jmwRcWi?=
 =?us-ascii?Q?nkCn2gBIqFjti2sIpQHi1mZi/ADgQ6Oy0F7tuxMuxW647AKdXChdNRsi2DuK?=
 =?us-ascii?Q?9auxAcMw/xX9INjGzN3ALkHeLKWD+FZJIZmd++ye33Gdt/IMGcw918hzDvX0?=
 =?us-ascii?Q?K2lvLE0sDAAKE/jzWtgq9UG2J1NOS7ehO/YCTnR7osUfXBwKix8jXfSxbPQF?=
 =?us-ascii?Q?ed2QDQHSpAZp7CA2wPjqqjaReu4FUaOAUDMtagmYUj/tdVKBEVfsa67QtMQr?=
 =?us-ascii?Q?susRhcW81Y04EkJCrELJ1W5Q5QOkgmeYsp35LX0SbRxWhdi5DRTR6LSGjYMu?=
 =?us-ascii?Q?aM4k3zGmhcuh1cpQ5XgAyj6lK+M3d2y4wKTBKGbh39d2jaCfodE5c8epPaPI?=
 =?us-ascii?Q?Fz2QibT6ZiBtF5nXETu6CcrrjF7bS5Yy8c0Wc6Z8QXbtXY1Ljo86o12WPVkM?=
 =?us-ascii?Q?HbfSqgm2twYf5JNIFZgL0PuBWk3X68jVmHSPwhTabDRCgQCtL54ozg0WeetF?=
 =?us-ascii?Q?qGpHi6DyvtUIFT01osgSXAteBOOIdH3U7yAb+EH7Y8bidAXEXAcaOjmPbWBE?=
 =?us-ascii?Q?qKkx/US8KYL18u1z/EFxKhuN+UMklWneLuv54DmuhB4az9PzzhxrSobWeu1Z?=
 =?us-ascii?Q?BjrtUr59U01ASOO8h9rYXjLR+ZLmgFH?=
X-Microsoft-Antispam-Message-Info: xNM6SLCRUEJxiwKl94knBAtwbVeOmZ7XMl3b7kUFPfo3yFUFUx6cvF5fRlXGheYU5YOWUcK3rkxWSQaX7EbH4wkq8VkzSqoLh//DLwcoOFAELNdRKb9PO80q4hzzQ32qkPHpO7FxI2dnOwGyzKmHRv6PrQUvQmefaMyUzovlsdNF6WcF3lBvMQ+mQDyZhyIHPOL8zSPqtGHcVORrQyPfJuBY81YSg2Ie1Koq0iTYZRZ+d5gQe/kGQKhMEscOr0URtFtJaI8rApr/kEQbCfNfC1iawM0wn54kV3v/oga0wdn/c23uBpTkInd+/rBm7FxKyD6DupjoJEM4Jtu4YYdImvpZnTqCHtPmYJRdE3lCik0JCg4CllmAuRcG7tbCiFqdQhGG72Z1qWKIBiVIeN0ms9vkDU9kT9Wk9LFWlTPbSKc=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3916;6:UHfDHH65DxKeD9wyKwj6xOpEc/zMKOFnnBOfHN3g5z7yKvCd6IKnV0GcWEeUXFgKbZ14NFOMSl66O44I0sWPStvJTBj7MB9C6Kffbo7fnC3ihrKsOkb3n/a7l3XMJHSLjpIYDtTZuWD2jCPxU+JBsTFV16hRMfLu4Y9+6DaEq7+DOee5HQzLCmzwffk+Jszx7n4prcdr8NHFk5OtfhmNVso/CRX0+QWf+xB+H3fASriDi4ijP3Kw9yjQMjkFef3UZ9HJGNgxavZbUfzGDwvzG9hlNFZHDGaQBHU3yHDw2HzOtH3ieSIv58nF3IM2WkdCEQTOaJ5sOfGf26aAqQ+pdcEOo90/cbK0I5xfsALWsHiUIfgvyqoPzmR/RcyrXeJlYbwsX0Tjg75TXa0jEjArEstDD6tV+Y4UL5RvZP4nsHbU7Fu3LTGVCW5TY+fiazzhyXQamJq4Ib+brvuy4BydRFI07GgeImFl07PN6T22WCptqGOthaWQFc0g5YPE6xkB;5:qHSPNsQuFSugzGX7ppXjdZdRLDS04zNc4YtIaaUbynWy+drQ8CLOGU37sAoFSbkdWV6bTMLFXvoI8pkfyZ9v7dMj29aZCzAheXjMXWQtBwFKHcuh8XwnWpxZqV0s/qJkPphbTwWI8ob4aFdrBBwyqPDKZW/UL+/LEZX6C7bqxac=;24:lPz1NWyjd70MI4LLltR5qWlcULTl6TLPKnvQqMUc/weWbASr9Pu+XmvANKdFO7p3wtvlOuSGhJvmBaFgu0mw5UcJjFKR0uh3BEUW1xTyGuo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3916;7:ZEmtujFuMZ/+G6qiX1PIyn9DT0sIuPHgHYK0oBA8xGn88BMJqPIti74PvNyRXOiT1IJN7DxLQT4jAgUK410iOeWQ4HcwIRguWsMjuUVDc+3jXoZvzQICUokr/WPDPCGL0j2Q/GwqoXePsp6MyHkTFkWjkV5dv9KJvqsZIKKX4OXQxml3x/Qj0bdKa+39WKvwGnol9wt+9QFY/5Vzujb637ve90+/8n5zdprZAOchZAMsWekXc0Zn5gCaOWUldznp;20:2eaGA1NJWvlHK2yxnPAobHzk4pEzTA7uil/YPqpCFw6NiJaUaRW4mVBiKNpicBhhy9V+Bja5G8I6NdaUVRyBeyfz2QBGvJS58xsVbqHtG0ZjQTL4iYQfCVNawswhiTNfkr3tdVe0Gl9/FFhxzOw918QPj7UZuobnpnb/MYJ1el6w5CQyCqZb1KQjuvwmfhJdYBJevIkOdoXBm0HU1IOHqyGFuI9ReezUXgYl1G9nJqov9tuuyyn9VEX8B9tDdCMb
X-MS-Office365-Filtering-Correlation-Id: 62c1b9ae-9441-45cf-70c0-08d5a249f4c4
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2018 20:54:46.4995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c1b9ae-9441-45cf-70c0-08d5a249f4c4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3916
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for frames splited between
many rx buffers. Header data spliting can be used
but also buffers shorter than max frame length.
The only limitation is that frame header can't
be splited.

Signed-off-by: Rafal Ozieblo <rafalo@cadence.com>
---
 drivers/net/ethernet/cadence/macb.h      |  13 +++
 drivers/net/ethernet/cadence/macb_main.c | 137 +++++++++++++++++++++++--------
 2 files changed, 118 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 33c9a48..a2cb805 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -295,6 +295,8 @@
 /* Bitfields in DMACFG. */
 #define GEM_FBLDO_OFFSET	0 /* fixed burst length for DMA */
 #define GEM_FBLDO_SIZE		5
+#define GEM_HDRS_OFFSET		5 /* Header Data Splitting */
+#define GEM_HDRS_SIZE		1
 #define GEM_ENDIA_DESC_OFFSET	6 /* endian swap mode for management descriptor access */
 #define GEM_ENDIA_DESC_SIZE	1
 #define GEM_ENDIA_PKT_OFFSET	7 /* endian swap mode for packet data access */
@@ -755,8 +757,12 @@ struct gem_tx_ts {
 #define MACB_RX_SOF_SIZE			1
 #define MACB_RX_EOF_OFFSET			15
 #define MACB_RX_EOF_SIZE			1
+#define MACB_RX_HDR_OFFSET			16
+#define MACB_RX_HDR_SIZE			1
 #define MACB_RX_CFI_OFFSET			16
 #define MACB_RX_CFI_SIZE			1
+#define MACB_RX_EOH_OFFSET			17
+#define MACB_RX_EOH_SIZE			1
 #define MACB_RX_VLAN_PRI_OFFSET			17
 #define MACB_RX_VLAN_PRI_SIZE			3
 #define MACB_RX_PRI_TAG_OFFSET			20
@@ -1086,6 +1092,11 @@ struct tsu_incr {
 	u32 ns;
 };
 
+struct rx_frag_list {
+	struct sk_buff		*skb_head;
+	struct sk_buff		*skb_tail;
+};
+
 struct macb_queue {
 	struct macb		*bp;
 	int			irq;
@@ -1121,6 +1132,8 @@ struct macb_queue {
 	unsigned int		tx_ts_head, tx_ts_tail;
 	struct gem_tx_ts	tx_timestamps[PTP_TS_BUFFER_SIZE];
 #endif
+	struct rx_frag_list	rx_frag;
+	u32			rx_frag_len;
 };
 
 struct ethtool_rx_fs_item {
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43201a8..27c406c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -967,6 +967,13 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
+void gem_reset_rx_state(struct macb_queue *queue)
+{
+	queue->rx_frag.skb_head = NULL;
+	queue->rx_frag.skb_tail = NULL;
+	queue->rx_frag_len = 0;
+}
+
 static int gem_rx(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
@@ -977,6 +984,9 @@ static int gem_rx(struct macb_queue *queue, int budget)
 	int			count = 0;
 
 	while (count < budget) {
+		struct sk_buff *skb_head, *skb_tail;
+		bool eoh = false, header = false;
+		bool sof, eof;
 		u32 ctrl;
 		dma_addr_t addr;
 		bool rxused;
@@ -995,57 +1005,118 @@ static int gem_rx(struct macb_queue *queue, int budget)
 			break;
 
 		queue->rx_tail++;
-		count++;
-
-		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
+		skb = queue->rx_skbuff[entry];
+		if (unlikely(!skb)) {
 			netdev_err(bp->dev,
-				   "not whole frame pointed by descriptor\n");
+				   "inconsistent Rx descriptor chain\n");
 			bp->dev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
-		if (unlikely(!skb)) {
+		skb_head = queue->rx_frag.skb_head;
+		skb_tail = queue->rx_frag.skb_tail;
+		sof = !!(ctrl & MACB_BIT(RX_SOF));
+		eof = !!(ctrl & MACB_BIT(RX_EOF));
+		if (GEM_BFEXT(HDRS, gem_readl(bp, DMACFG))) {
+			eoh = !!(ctrl & MACB_BIT(RX_EOH));
+			if (!eof)
+				header = !!(ctrl & MACB_BIT(RX_HDR));
+		}
+
+		queue->rx_skbuff[entry] = NULL;
+		/* Discard if out-of-sequence or header split across buffers */
+		if ((!skb_head /* first frame buffer */
+		&& (!sof /* without start of frame */
+		|| (header && !eoh))) /* or without whole header */
+		|| (skb_head && sof)) { /* or new start before EOF */
+			struct sk_buff *tmp_skb;
+
 			netdev_err(bp->dev,
-				   "inconsistent Rx descriptor chain\n");
+				   "Incomplete frame received! (skb_head=%p sof=%u hdr=%u eoh=%u)\n",
+				   skb_head, (u32)sof, (u32)header, (u32)eoh);
+			dev_kfree_skb(skb);
+			if (skb_head) {
+				skb = skb_shinfo(skb_head)->frag_list;
+				dev_kfree_skb(skb_head);
+				while (skb) {
+					tmp_skb = skb;
+					skb = skb->next;
+					dev_kfree_skb(tmp_skb);
+				}
+			}
 			bp->dev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
+			gem_reset_rx_state(queue);
 			break;
 		}
+
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
+		/* Buffer lengths in the descriptor:
+		 * eoh: len = header size,
+		 * eof: len = frame size (including header),
+		 * else: len = 0, length equals bp->rx_buffer_size
+		 */
+		if (!len)
+			len = bp->rx_buffer_size;
+		else
+			/* If EOF or EOH reduce the size of the packet
+			 * by already received bytes
+			 */
+			len -= queue->rx_frag_len;
+
 		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
 
+		gem_ptp_do_rxstamp(bp, skb, desc);
+
 		skb_put(skb, len);
 		dma_unmap_single(&bp->pdev->dev, addr,
 				 bp->rx_buffer_size, DMA_FROM_DEVICE);
 
-		skb->protocol = eth_type_trans(skb, bp->dev);
-		skb_checksum_none_assert(skb);
-		if (bp->dev->features & NETIF_F_RXCSUM &&
-		    !(bp->dev->flags & IFF_PROMISC) &&
-		    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-		bp->dev->stats.rx_packets++;
-		queue->stats.rx_packets++;
-		bp->dev->stats.rx_bytes += skb->len;
-		queue->stats.rx_bytes += skb->len;
-
-		gem_ptp_do_rxstamp(bp, skb, desc);
-
-#if defined(DEBUG) && defined(VERBOSE_DEBUG)
-		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
-			    skb->len, skb->csum);
-		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			       skb_mac_header(skb), 16, true);
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			       skb->data, 32, true);
-#endif
-
-		netif_receive_skb(skb);
+		if (!skb_head) {
+			/* first buffer in frame */
+			skb->protocol = eth_type_trans(skb, bp->dev);
+			skb_checksum_none_assert(skb);
+			if (bp->dev->features & NETIF_F_RXCSUM &&
+			    !(bp->dev->flags & IFF_PROMISC) &&
+			    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			queue->rx_frag.skb_head = skb;
+			queue->rx_frag.skb_tail = skb;
+			skb_head = skb;
+		} else {
+			/* not first buffer in frame */
+			if (!skb_shinfo(skb_head)->frag_list)
+				skb_shinfo(skb_head)->frag_list = skb;
+			else
+				skb_tail->next = skb;
+			queue->rx_frag.skb_tail = skb;
+			skb_head->len += len;
+			skb_head->data_len += len;
+			skb_head->truesize += len;
+		}
+		if (eof) {
+			bp->dev->stats.rx_packets++;
+			queue->stats.rx_packets++;
+			bp->dev->stats.rx_bytes += skb->len;
+			queue->stats.rx_bytes += skb->len;
+
+	#if defined(DEBUG) && defined(VERBOSE_DEBUG)
+			netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
+				    skb->len, skb->csum);
+			print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
+				       skb_mac_header(skb), 16, true);
+			print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
+				       skb->data, 32, true);
+	#endif
+
+			netif_receive_skb(skb_head);
+			gem_reset_rx_state(queue);
+			count++;
+		} else {
+			queue->rx_frag_len += len;
+		}
 	}
 
 	gem_rx_refill(queue);
@@ -1905,6 +1976,8 @@ static int macb_alloc_consistent(struct macb *bp)
 		netdev_dbg(bp->dev,
 			   "Allocated RX ring of %d bytes at %08lx (mapped %p)\n",
 			   size, (unsigned long)queue->rx_ring_dma, queue->rx_ring);
+
+		gem_reset_rx_state(queue);
 	}
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;
-- 
2.4.5
