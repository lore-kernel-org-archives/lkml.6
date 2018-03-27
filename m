Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeC0PLS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:11:18 -0400
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com ([104.47.41.55]:5369
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752507AbeC0PHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH 2/7] net: thunderx: add MAC address filter tracking for LMAC
Date: Tue, 27 Mar 2018 08:07:31 -0700
Message-Id: <20180327150736.10718-3-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:3:93::13) To CY4PR07MB2998.namprd07.prod.outlook.com
 (2603:10b6:903:d0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a155892-517c-413b-f91e-08d593f48100
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2998;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;3:U01LDnJrRZkX+rAYZvGwsfltbGDda93NCaeGaNnVVCdfQXoWh/BO5lg1B3v7YhU7XJaLmIQQwrmuXhyhn2cGvvGIyjgLl6oMPSLkHLoI+PS+FlHtirDY9cQz5vFriHa7a2V2dr0/w4h9d5DieOTGDs4dPNIwix3wVYatPgQMeYu9fpDhEPju7xn7MtOK8K2CdJaAeYQ9EEk8B/+zYKV2s/jRrLS5290YYTyfLG6GffqyzMBGAEs4FGWOVv50Q8EP;25:7icUU/PbnLyU0lcAeh8aH1D8tjaymg95GNQ0g8Aj3xsDeoOROg5E7mQs+z0I46z7/LrP/XBfk5tcbAjkSfDfuW1uQlPIXwyP75z+2oakM2CaVpl1cQw/ROraAgFM6sdU7KVgjv0qc6pv31sHCM63l3C+BmMdMUGkrM7PovhgSgA+G4wfTUVRGaIGuGacuDy/c0OTTJYe9zKk8sCX+FG3ujf1bJfmEdMzDhBQUx4LAlKapUusT+blJnCCLR8GMMsn84ZWRQn4m3lLAv8Q3ymJg6/OFHHRl1234S0Y34d/04Z16RLFWjOb+fDhAgDlhScFe4v4MhX1rTMsuzO7Qnt3ig==;31:8WOpstxp7hP5BN/HMywxDdif0JrX+3Ao3/OsYxIvokqWGuc44lHrSlOPm1TCBS/1w0v6deVa3FJBdtvkWy7nqIO+kXibfBe8zvBKAuQBKHTc8QBpH7uQ0Aua3JiCcbNCbFqO4UJQVaP9eVQFbwkguAoM7dyomh3ilNlaNUxiEIInkOBNFG6HlwDX7Wr7IuJVwoD7cbZuugex98rkYIiYoCW/JijcFh12MHXyu+XI15Q=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2998:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;20:XEBXYwfI6Qr3V7oLGmN1LGzJYhl2x/lDakxYJJs6FBpkV80IiwcA3N8wEcgWC7iibX0DC8VZVKQ1opSeXK3v9LeO68iJW4khD2rCgj1galOeZWB/RIYcDI/czjKV5AQn8S1a7Kb3XYtqkco0Tpf+w+UZv4iLJhtxj5/GTV/BIImC72TgG2emVr0S85Zh5/vOSHg1wToGph2ixAjmk77sowKI9pQuFefkSAhaI51rI9gDk9qF2Jeot6av+uM3wldjG3uI3boJecOu296yHSH9rCSGDMKCpe4mRqDQc2LmtdSaVtaZ/e7ivZxIftHhW6ERaWUdKx6zqn3uwH0AfBMs1MafFcX2N8AeG4BdgEBz8f788SfuPYyUcgO7QSmFyH/pC3mX0NqBAmENqWvy+uH7BLE8ahwGSEVpE3BwWw3xm29+vvM70DEF3nTOP2IvCB70Mr43uEuPmmpl6g3igTIHgsNrwhk0MoMSbI7xxYMXKNSa2gcTFohKDF1XEmuTuojMu2hQc0WWxtpRhAcTzBxzSETPY3MxWzeW+ZvWGbFPM0KzUdPmX4T5ORJ4l3/Ylisx+3Z8gLx9aY4SX13hIAqsI8A6KXF742iMe/NYpzKAmgE=;4:H3JMaalVbNXgVbVOur2vcvYWLk0AIwG3yO3n7BR8jGpT9GFPudv8Zcyn5ngeUmcyLDi/URl9DZGsiGwFSMr7NjZh+UsIosge5gGCWDGuoHdJeXWdp9/Lv/hITQCn4okeVpOLlChUDYU/h5OZB357ZcYRPO1TCnzLfJhxgKpKgrlbKd65BDRjV8cxSYyThlgBaGdVqH38IuO9pjhWi31IvZEBer8FNZvKLSV+w8oyJZ/B0e35KoGxtq8xbm6fpaRKXGz7P9O2zhalYa+of/ZppQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB299879D96C8AB776C5F236978AAC0@CY4PR07MB2998.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2998;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2998;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(189003)(199004)(446003)(2616005)(6116002)(478600001)(1076002)(107886003)(3846002)(6666003)(956004)(97736004)(39060400002)(50466002)(7736002)(53936002)(16526019)(66066001)(47776003)(26005)(48376002)(486005)(486005)(6486002)(6512007)(316002)(305945005)(11346002)(16586007)(105586002)(42882007)(6506007)(575784001)(386003)(68736007)(59450400001)(69596002)(106356001)(72206003)(25786009)(2906002)(52116002)(53416004)(76176011)(81166006)(51416003)(8676002)(36756003)(476003)(50226002)(4326008)(5660300001)(81156014)(8936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2998;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2998;23:BtCXLYpanPrBYoLpWdF1fAB7byFlJLwv3HzTqyGbk?=
 =?us-ascii?Q?0AdhBLS/4Fu/5lB8JKrSSP8Kh0IrkVqyNW3fepzG13WP0itSE19pMNcTGZ+b?=
 =?us-ascii?Q?InvGM26l3JOvDIYI9p87V7bRrwrdarWmoqmNxcZdzh7iBRPC2Arj5iXX528X?=
 =?us-ascii?Q?0bqQq/0HcfQMmAC+pW0f0Ui69mokENHurtz0Ba0VJHSFRhuH+YTwAld5kcU+?=
 =?us-ascii?Q?qBQmdksmH/As1NA6JmNcgkl7m8YsSle25WHnGngdwwavXveG583pCpmM19kt?=
 =?us-ascii?Q?Mid1d5ypoY9gTRPZMBLrqTCJ5EM0W/l08QuwCopx9YgAHSRMHFFhugzH7eeD?=
 =?us-ascii?Q?4k0neE83g4u6onlxjVLyt0vIS//EMPNyW6uF1GLqjbAfDt+UjR9xEaKbTP9Y?=
 =?us-ascii?Q?GEDzMIX9HVbN1drhNsNUuxNJbIWP04r76Ju3YvYw45Mc1RUR6FJFzWELDmp/?=
 =?us-ascii?Q?GjkfIeuwnRHVZUEOkWBwnfC23ibbiEGMj16P2DWpJ5ellLCQmgidcgSWexFJ?=
 =?us-ascii?Q?R/EK8VqJvxOkKlp5XOpsJGgIAKs6YjmOyuZgaVX8Qp8l2KgUsy+uwkUJRM5w?=
 =?us-ascii?Q?vqxsniuYvswvEJTz906eWKyb6B+sxA+s0cTZkGd9tDfEvesL6l0GxV45KonB?=
 =?us-ascii?Q?NqLjK+gqpjhzje9AYUub4iZm5+BY8AIqzsf+gYG+/xHGRpVKsNGHJEdVPDih?=
 =?us-ascii?Q?vpvmq6yd2B1tQsO/vBylMs/5VNj8fX/tShttrjc+ZpsSLD/mTcbBqqB0e9xh?=
 =?us-ascii?Q?5YEaoo7YPfn2pvY8OviYDDTW1VhDV//bChBp/cO3oeAMYo1CuR/ja8IM5Cym?=
 =?us-ascii?Q?+SXlTS+dOoAz7VgEFe1sUTyxAKd40zKqaho0qgmYNBEng2HNzdsJ5bT9j/Dz?=
 =?us-ascii?Q?dV6ZodaH5GhW5c6jQQJO8NEj2oOFvuJHLVzbLCAvyLHvfMZMtSTP9W68B2r7?=
 =?us-ascii?Q?m6B1milK2aH+HI1N3Cd12PbBNj/OCr8pgnmnjKJtv+G3FIjzLTCi5RGY1tsK?=
 =?us-ascii?Q?mXeK5Xo23jeT3Tt0nmI1IrUAXMG9X9fX5MGOruApK/jt1q0gjhariCi6CJI9?=
 =?us-ascii?Q?MoUY0fCHbazkSA5/m1w987E4BflKttFrVA+KaeqppKJiGwmxofm+h4SGlXJ6?=
 =?us-ascii?Q?qA7udO5Oh5XhnCVpM9DEISg9CtjkWQ51p/7cWS/AAb0a7CYDu0611BD/Sg2+?=
 =?us-ascii?Q?nmHUR2jWtKICk+k9j4pfPW5Ru1qL29dEXjzuSSxy/deiwKfmXofo3bMYZ2U3?=
 =?us-ascii?Q?JyuLnFnYhyfJIegwpC4eGoKoAPxmKSkf/uFEN9Eg15k+CLs3Q9rofjqpAz7i?=
 =?us-ascii?Q?ikrmOPWxZBEIIsdIpG320Z7pWBwkykQhIFG8xyKO+g2Z88D+wugN7jwkFbyR?=
 =?us-ascii?Q?BVsVkU0PBlu+5uoEBf09bMN/eAuEPTOO/C/x2biQdNeOVt2Ut1/XZSRnn1lY?=
 =?us-ascii?Q?8MehKnlHFyvmyyPF5ZHftWFd5cbFRINaU8v2OkibwrA8dYwzXcD?=
X-Microsoft-Antispam-Message-Info: 4mjvrXMYCB4Tob01T7jMg0IvEkxEvFuk8cYe6mq6ui9xtr4KfYmrNvCujxm+f02UySKcLkQYnmMfu4/Wv5Q5002ifg2uuAVMm08bXZGqUBaizyQ9Dahxu78EppxBizpkjguHMpZwEqZIQmh/Yr/SDMUUuQjsPCD1LLNKdYhwYORrCSe8dn8uVivTx/tzouu0
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;6:P9mE8Mof8B4rYN5/pNWHDjLJsGw/jTUHxNRvv5yYviDqlJw1qr2+dk7+O/u0oZHGgKkv5TAEZ3pjo3k2um2wC5PP0hvuqUXh34fFkCsY+RhE3eutsV0KoG60QPz3XtT88pU4rCYNP+/0fob8te1OfZbf3CoXj0y/DPk8xWfeC2oavOLwb5D84+m5ZcxJDMleT6Cxm8EF5RqzNx7IDoQIRZj7VK98RTNF26NkbBGQs4jIN6XSo0bzPxPv9TKYYx5S6PWgB+orBPXs2bzLA6S+kAYLAiDfAf0S+C++3LJzMqTc1j+PrViSwpoWi/eSVPvQQ1DrYq2isL3PHAp1d0h146D/TTmxYoWLSI+bC+SpeW7LdMGTex8QApPl1Q122QozrfrSbSYYXrtSKaGoTd9yjKb1RkrvSHi+0lJ7EmsImR5OeE6R9ZrppSFaUAA7I1Xfd82H3PZgmpLHY0vserEvuw==;5:MY9hKH1VjNUzvnFcxJYf/n1chPuE/5W6TfxGjIyhvNb+q1PRBS0NdByT5eih7cGTcVxKrQT90RSFehq3nMUdI3voHZMxH+OnjBKYlYHdgTuXQtxgH0aKeXLFcDKe4KDCsaC7ioRNcoImm4HqW9zC8Q2exGFWG/SflZDIrA49RJ4=;24:9RUFSLkP2DqOkCksx1eyecZVOczqYwv3FfXNMM64B2JNE9yOLqBBL78hX2sQFQXjyiwkAIn8qO6JpistNR50+BLDAQ54hfTNuhTEFpiKdfY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;7:A9en3QJumOVEPz/CD9RHKmMOGkC+KksTiJT14khPnFl2XhetdIOR45Qe7c8ssZN+FHKfsPOqcs1R9JbeSfPrEHQyUOzGvGUanKEZtAxXmf3ahi15SLsjnJDtVZz16luLW4STP0fcdJb1EB0BOhj2lRcyj68mDvGArUYCLaB5VM2/W21G9+wsbaYWGmheeiunYgvCi3/kqnrVXZty2TwPitKNYoggaPSvjipuKof1m6TA7cDAGwtopsCKJnm9eoCH
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:07:48.2171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a155892-517c-413b-f91e-08d593f48100
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2998
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
network interfaces it is required to cache and track all filter configuration
requests prior to applying them onto BGX filter registers.

This commit is to update LMAC structures with control fields to
allocate/releasing filters tracking list along with implementing
dmac array allocate/release per LMAC.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 42 +++++++++++++++--------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 0dd211605eb1..cf0cc19c03c5 100644
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
@@ -236,6 +245,17 @@ void bgx_set_lmac_mac(int node, int bgx_idx, int lmacid, const u8 *mac)
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
+		bgx_reg_write(bgx, 0, BGX_CMR_RX_DMACX_CAM + ((lmacid * lmac->dmacs_count) + idx) * sizeof(u64), 0);
+}
+
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable)
 {
 	struct bgx *bgx = get_bgx(node, bgx_idx);
@@ -481,18 +501,6 @@ u64 bgx_get_tx_stats(int node, int bgx_idx, int lmac, int idx)
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
@@ -925,6 +933,11 @@ static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 		bgx_reg_write(bgx, lmacid, BGX_SMUX_TX_MIN_PKT, 60 + 4);
 	}
 
+	/* actual number of filters available to exact LMAC */
+	lmac->dmacs_count = (RX_DMAC_COUNT / bgx->lmac_count);
+	lmac->dmacs = kcalloc(lmac->dmacs_count, sizeof(*lmac->dmacs),
+			      GFP_KERNEL);
+
 	/* Enable lmac */
 	bgx_reg_modify(bgx, lmacid, BGX_CMRX_CFG, CMR_EN);
 
@@ -1011,7 +1024,8 @@ static void bgx_lmac_disable(struct bgx *bgx, u8 lmacid)
 	cfg &= ~CMR_EN;
 	bgx_reg_write(bgx, lmacid, BGX_CMRX_CFG, cfg);
 
-	bgx_flush_dmac_addrs(bgx, lmacid);
+	bgx_flush_dmac_cam_filter(bgx, lmacid);
+	kfree(lmac->dmacs);
 
 	if ((lmac->lmac_type != BGX_MODE_XFI) &&
 	    (lmac->lmac_type != BGX_MODE_XLAUI) &&
-- 
2.14.3
