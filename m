Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeC3MCG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:02:06 -0400
Received: from mail-by2nam01on0085.outbound.protection.outlook.com ([104.47.34.85]:43643
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752072AbeC3MAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:00:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, ynorov@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v2 2/7] net: thunderx: add MAC address filter tracking for LMAC
Date: Fri, 30 Mar 2018 04:59:48 -0700
Message-Id: <20180330115953.17154-3-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To CY4PR07MB2997.namprd07.prod.outlook.com
 (2603:10b6:903:d0::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31fa2611-052d-4abd-b9e8-08d59635d18b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2997;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;3:/X24axXaAqlfA57YaFl979NTQttKnHTVjtHcQKpDDf4T6pmcRQeNOtbgkFylqF9W5gOyE3X4zUFRAV8E7XuOhw7P1afXCS/R+M6PYTwkRV7N00syaM222wwZVCXxz9KGIWVzlIQxVg7AdHWvLMk0XP24tYAQEOso7ngrrR04zjmwMuIrLNzFZVU1HiVTMwZFW/u6iH8lgoVLmu/0Jz87y9Bc8J1gPLmxHhC+4Fx0hRp08z7J/I8vzTpTpnOcHKmf;25:Gu9PFgzmOLGCSEI01oRzBu0ENWYh/ISRh+6Sq1BHQIgs3UcZSnYF0I+GdTRFzZHoiRYZVt1cLpnJNgBWDO7pE6qUWZVWSzOoknD0N9DFuKnD7LpeaDJqT3IhcPJ1ckxe8V65OtovD/rjbNju+PXvvbxvoTF2wuRJPs1ueKhJUCXsjlO9TTnzTj7hFWCJXYArqqnpynuae0ARLOtDHsdwjPpjQj50WbBXGy9E7PUZW4YzmQgkUf5FBQiMMJGw6N8zzsAhHwsJNBGyo0RMLIljoGI2gMw3w1TfnfBSa2bZc5hztGUf2+H8wsmZbjZHUUEXmcjv6Ozfyp2YZDd9hiarZw==;31:qkIegJgI8mfZrFQ+uW+XPmefropSvP3z3+FjlWl1170oxv2zbEfCHf4YBz/MFa+E4mWR4vy9vWx65NaNvEedolWFSTLtej+jqL9xMdE0rfn/S7PbW/tLyc5i6bFySSZjfOQf1iIGr8y/nNUG5Oxdgf3rZ/zfCwuNSeOdkCoUbe3ydEHST/xP0ABYZqylbELHLZb0Du48eLcBwF046/dVw+eUOSTx1hFNQSAMrzpw358=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2997:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;20:TayiIGB05aD+kapWUC7Xly+RyTfR+c3UGeVWknQU73u+AwRciT3XPzK+SsHsj3Tya1CPkEeleYY+BViz6ffscwhSI7fE7tvmmkKge0D2coeTt/PVRvLlzIGHP5QeCLaLNFYMrsZU3o1XzaOsDg0SxWjYNnPKEhHhECaNNNlFOuNjG3c3V67k7Ph8ZpOY8gUceWFt7vPVitWMEZ5PNhiX/JNPyK4H9xzSl/FGqpMtbumhLuxWiyLKHxK2gIU/DiCvSbMABxVa3g4SuVNSZXKM2NMTRSS/VT2M5YLVZoy/OFqDLLua7syUkVpFxV4aW/4HQ1AudYpmDQoCfaAYgMLLwfi2A34tvdozeJx/79jH1SlVuN1xHCGbni3MfqCV8/zEGPb98TqKJX7MfGazeZJW0MljpfztcYaRx/JtcYMBEHtTpTA3RBxY+SQ24MKQcHwf5oQSlkZda6BXIjXzs5McHpNjRptDR8QVOXwK0NxC3AQHO4n7iYl/dtWgSjicFtNOG8NtwMYKocTsx/hveyzATvA/3Fxuv+LOgsjc8DQ3JP6PDpdZpltRCXmNpic9A5w5HToNTvU5BOpTUJyxNJa6TUAKJQpiUoDydWpRe7elUKE=;4:MKKfxqW30Z3almd3xztUatuMSUQGTNBgIPHGSfDTuM5LQ+VZNPmPobr5srRb1ylZ599X/4l9XAyjL/2fiV5I8a4/WHXplrU7zr6o5VjROf7qbdE/unbqEPtfq1InFaA+hEiTvj/rkh/ARzu+jkmr8cE6Dn/Bw5djUpKiLGJM53fo7Z4K7DRKgYxlGVwnKfxz4dm6nG6DCapUO0ReG1xlO4RCV7p6g2jkB/qmlBt/ggRQL7Tag4jUcMjXeQ/gbPLw7sbPRGtRcvzbNkFYGauqVg==
X-Microsoft-Antispam-PRVS: <CY4PR07MB299791FC363FBB4261CB030F8AA10@CY4PR07MB2997.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2997;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2997;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(366004)(39850400004)(189003)(199004)(3846002)(6116002)(1076002)(105586002)(81156014)(81166006)(8676002)(48376002)(50466002)(53416004)(5660300001)(52116002)(97736004)(51416003)(6506007)(8936002)(59450400001)(76176011)(386003)(69596002)(2906002)(6486002)(6512007)(72206003)(39060400002)(6666003)(47776003)(316002)(7736002)(16586007)(106356001)(486005)(486005)(476003)(107886003)(446003)(305945005)(53936002)(11346002)(2616005)(66066001)(16526019)(956004)(478600001)(68736007)(36756003)(50226002)(26005)(4326008)(42882007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2997;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2997;23:3AWxX65dcTKrzqn5a7zgLswHI34IG0YUhqM5agD1n?=
 =?us-ascii?Q?klmtoke+ysvh/mUVOs97aB+YqK8lARbGZLRxO4HywbKxQMiU+sSt5ts/qJKP?=
 =?us-ascii?Q?20I4EccJndONPrdxGZL4Ch3AkNhA/mhd0OJsmjTEREBbQhmUe5otjFZrSQeZ?=
 =?us-ascii?Q?3Cw1Gsnco1JcZM2HoseWt1Qfiev/n+N7LrMnRJ6vfej81pGNddLEN9gpynDJ?=
 =?us-ascii?Q?mtMyfJr6O/Atvezwef417yxavX28WNaEh99RBKpJBkziHHmSlKdg+GYsQZY5?=
 =?us-ascii?Q?WezYcCM5prznQabzN9zUsxuNUTFeoR62kyua4eXBNGrrA42u1saCjYVl1sky?=
 =?us-ascii?Q?Au8+raT0A0o8FCbCBcDzP7Cg/lhMnWgEogNpIFxCtHTY+3Kk5ynx5o446TLX?=
 =?us-ascii?Q?DuBI/AdCwn6B0mQsckH9LsT6p2PHZkvDvXCyYXu6ks+/dRoucNy1LlCeX5fl?=
 =?us-ascii?Q?9OpnjcZr6oAxaU1W/I0e9HXkRkgdym+1cUdvo1ZAzLEDUH5pXYPaq/Q02VCy?=
 =?us-ascii?Q?iPeNLnBWtUErMpW9RA8+R/pDgYdQVECW3PWymKFxFWO/khj/g1xGbhbM6u0U?=
 =?us-ascii?Q?unGbcqs+UnchGT+4ye/oYBVK4bmHB9dXmkw7f9t9skK8up1l3AkYaI8sWIp0?=
 =?us-ascii?Q?2itO4tIfQQrd2ovMQGyFY1kFg3BiINqqmUyUakGdovGr3+Hm+MLVueZIShbd?=
 =?us-ascii?Q?m3tbG1pGqvuzRAzH8R5mtuyF0/F+eC4tluuKMkLKBAjmDBaktlEt6JcQJQ+I?=
 =?us-ascii?Q?H+sBABLIcOsDCfDN2VXEQva8UYEcyXGlH6HzAXUoU2PxB6S0WvGYi2LxcKO2?=
 =?us-ascii?Q?iA6LND1/0yylB9WWTRCaZJSYb8WQv5hg3+lbSjfJ5/u0dsByNHWc0JWnMh8l?=
 =?us-ascii?Q?W+av/OTOinZFv011PvLbPHWCLNzR1dKc+HWvNUgP6AfFNVWHZPcqYWE5XriK?=
 =?us-ascii?Q?y9RvMm3WrCwEigAMiE9GmSh2pigXEgmSn1GhW8n0ol0WunyhRwcCXLDjRvht?=
 =?us-ascii?Q?sSghbxf/FO9xi7psVX7FxlToAHxyylIU9KMVCJnj9494u8jCVqCwywoaI1JW?=
 =?us-ascii?Q?0EMvBzubjPym0gOGL9IWaEdlFapvJT3sYafSNCP7qzosOwdK6HFYTdDSFuGG?=
 =?us-ascii?Q?ACSYV9461+yGsCWtYBnNeZYQ5Ts4JRnAJddbiOuJeUGi7aoaD5EYMi6aLkj0?=
 =?us-ascii?Q?o9AEGTbnaeym9JRdL8zq0QK6SEIOEL6C5Khhjx1sRD6UYefVeBJVV/4Z/hbP?=
 =?us-ascii?Q?ck37IgNCeYXQIzfpgEBfsl6l76Ttjo+7SKc+7z3HmCb37N5W8nG69h8d1/Fr?=
 =?us-ascii?Q?8/ObiqnlMh097ZG8NMSpLS5ckz6AFeTZST9HPQmQkxV?=
X-Microsoft-Antispam-Message-Info: wzT7AXbLL7Lmt1R0FQFxU+O7+dGqLz7jOp0sbuebxHPeHRKpSwPqbAJJew6TgixQavEnnMK1ZfMucIhk2yaDbzF4YEDuCPAHPgJ6VBOSl2Lqw/iuciz9Rp17RK4MGLq5vtxvkB6b+JkRoCPpEzI7/j5EbojBPEVeeWqRX+ZJiH5Ok261XiKy4vArZZruiRTK
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;6:DmU9iFpaOoQUV68FHu9Wn/Y/ggKd4KTviJf2HpeNuSaxvpE5Ea1njV8QPxbI5LkPdGt0d+h2YD6L7pwG4xfc7kbxShK7JGlIprEiE/Nv49y/G8a13UWC9cvd/uVSrMMO9ujn6Nxs4RClszjgPDQEPfhmqQTVi2RViCwhKX9jag3F7OtUFd5xoKXQCCyCfRj4Mq6/UZV4LQS9nUKAq6EgbzvLwqLJV9oh2dtmn51IvgdrDWNF7ObAms9DTeEGrJbpiGCMjFQ1EZPQMCS9YLK7/kZwbSXpMQALM2NBxi7tCxkyBBf8C3OxOsLcP8utBYp710BxZFwHva16x+HTE3GA3LXNN2+0sC1GhZ+zsKzWRAd1Bj9wGw49OtfFPMYD2s6kUrCV6TOQGYlkawN4gE3tTlLVHi8LkHVkGIhgbBruoVpWqophyVCF7Y2fVYwZXnP0BViP5sqa4W4inLzpFIFM4Q==;5:Gb8fh0m1r7OMjJnnc6WSWBz3USMxCNUw4BIycl9pOIQ6w/WripUv6XZDBCQhSD+3GjrG7Q+2oV/5GVwZnQiQ84d/L137JWoUHVLuGjv5L4Ga06bdvgx34eJo8n7wDGLT4xwoV4BR7tHGMui/gcXuAb5o35dW7KRtDkdtebl08OM=;24:GmknD8M2o+2t/jGO7fPIclWt+i00WxegDaglNruWwyvrIfTmUnnAswMQuqhJiIz1zd2ztrGi4HWVXMb4FTJLV1eKpmfe1bkKBruR4kfcB+M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;7:FColxOTzsJ5IlGMEIHbJtPvG3E4ueY6VsSnKbEscEBB1bTg9Hk8JxP6eVp2xNAIKkZ5qohAoS3VNqLKtyf3tNbmV5ZLFRXgTpW7p0uan8v/12zmFAkgw73XOi065VWZwA2nAloUbMY7NKDYa3aeReSoBYalD1FJy+RiEZKRtrEaU+O4bWzlRWiYc1+Sj/urZ/QVpq0XaYHFvWB/WSY97dtjft5klOv50mi6rIuFsRktPJhxtWUYYEE1tXv8eTDuJ
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 12:00:23.0196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fa2611-052d-4abd-b9e8-08d59635d18b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2997
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The ThunderX NIC has two Ethernet Interfaces (BGX) each of them could has
up to four Logical MACs configured. Each of BGX has 32 filters to be
configured for filtering ingress packets. The number of filters available
to particular LMAC is from 8 (if we have four LMACs configured per BGX)
up to 32 (in case of only one LMAC is configured per BGX).

At the same time the NIC could present up to 128 VFs to OS as network
interfaces, each of them kernel will configure with set of MAC addresses
for filtering. So to prevent dupes in BGX filter registers from different
network interfaces it is required to cache and track all filter
configuration requests prior to applying them onto BGX filter registers.

This commit is to update LMAC structures with control fields to
allocate/releasing filters tracking list along with implementing
dmac array allocate/release per LMAC.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 44 +++++++++++++++--------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 0dd211605eb1..de90e6aa5a4f 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -37,9 +37,18 @@ enum MCAST_MODE {
 #define MCAST_MODE_MASK   0x3
 #define BGX_MCAST_MODE(x) (x << 1)
 
+struct dmac_map {
+	u64                     vf_map;
+	u64                     dmac;
+};
+
 struct lmac {
 	struct bgx		*bgx;
-	int			dmac;
+	/* actual number of DMACs configured */
+	u8			dmacs_cfg;
+	/* overal number of possible DMACs could be configured per LMAC */
+	u8                      dmacs_count;
+	struct dmac_map         *dmacs; /* DMAC:VFs tracking filter array */
 	u8			mac[ETH_ALEN];
 	u8                      lmac_type;
 	u8                      lane_to_sds;
@@ -236,6 +245,19 @@ void bgx_set_lmac_mac(int node, int bgx_idx, int lmacid, const u8 *mac)
 }
 EXPORT_SYMBOL(bgx_set_lmac_mac);
 
+static void bgx_flush_dmac_cam_filter(struct bgx *bgx, int lmacid)
+{
+	struct lmac *lmac = NULL;
+	u8  idx = 0;
+
+	lmac = &bgx->lmac[lmacid];
+	/* reset CAM filters */
+	for (idx = 0; idx < lmac->dmacs_count; idx++)
+		bgx_reg_write(bgx, 0, BGX_CMR_RX_DMACX_CAM +
+			      ((lmacid * lmac->dmacs_count) + idx) *
+			      sizeof(u64), 0);
+}
+
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable)
 {
 	struct bgx *bgx = get_bgx(node, bgx_idx);
@@ -481,18 +503,6 @@ u64 bgx_get_tx_stats(int node, int bgx_idx, int lmac, int idx)
 }
 EXPORT_SYMBOL(bgx_get_tx_stats);
 
-static void bgx_flush_dmac_addrs(struct bgx *bgx, int lmac)
-{
-	u64 offset;
-
-	while (bgx->lmac[lmac].dmac > 0) {
-		offset = ((bgx->lmac[lmac].dmac - 1) * sizeof(u64)) +
-			(lmac * MAX_DMAC_PER_LMAC * sizeof(u64));
-		bgx_reg_write(bgx, 0, BGX_CMR_RX_DMACX_CAM + offset, 0);
-		bgx->lmac[lmac].dmac--;
-	}
-}
-
 /* Configure BGX LMAC in internal loopback mode */
 void bgx_lmac_internal_loopback(int node, int bgx_idx,
 				int lmac_idx, bool enable)
@@ -925,6 +935,11 @@ static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 		bgx_reg_write(bgx, lmacid, BGX_SMUX_TX_MIN_PKT, 60 + 4);
 	}
 
+	/* actual number of filters available to exact LMAC */
+	lmac->dmacs_count = (RX_DMAC_COUNT / bgx->lmac_count);
+	lmac->dmacs = kcalloc(lmac->dmacs_count, sizeof(*lmac->dmacs),
+			      GFP_KERNEL);
+
 	/* Enable lmac */
 	bgx_reg_modify(bgx, lmacid, BGX_CMRX_CFG, CMR_EN);
 
@@ -1011,7 +1026,8 @@ static void bgx_lmac_disable(struct bgx *bgx, u8 lmacid)
 	cfg &= ~CMR_EN;
 	bgx_reg_write(bgx, lmacid, BGX_CMRX_CFG, cfg);
 
-	bgx_flush_dmac_addrs(bgx, lmacid);
+	bgx_flush_dmac_cam_filter(bgx, lmacid);
+	kfree(lmac->dmacs);
 
 	if ((lmac->lmac_type != BGX_MODE_XFI) &&
 	    (lmac->lmac_type != BGX_MODE_XLAUI) &&
-- 
2.14.3
