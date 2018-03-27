Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbeC0PKM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:10:12 -0400
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:25088
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752152AbeC0PHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH 3/7] net: thunderx: add multicast filter management support
Date: Tue, 27 Mar 2018 08:07:32 -0700
Message-Id: <20180327150736.10718-4-Vadim.Lomovtsev@caviumnetworks.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6bd505e-f5f9-40e3-1684-08d593f481e1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2998;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;3:T4P3sgq1wmmfn1OTbGLLa2e86BtBkuqxusa2KltN6ozd7JPjzT3XjkpJGTNAAVCCQIMDRJ4hDWE+stk90+ukIeMOrHIOfRtVSulgytEHZ5KnPIZKpOAfj9xPtYVK3eeGRc8lVPpdfH+m8bW7X8hpQUiPMca68/BOUWYoIDqUMtXP3+5znZJJ29opklpTYFY4otbsYpvTDmx3DJIA1u8++Pyq9/y8W+LSp7Hwe0YO0LFgW80X0YwsnuFqCfpizqoe;25:xLO5PUygGPQS+XM1cZHuqyI9aRSlPQ+DoX82s75Dugk6Aeo694JU7jj3jGLA+1hoS9g1tnEir0e5uUX4qcD1ZX7L6RY1X5xZAfu8bs1jFxknGGORDVqq5ThaXtW/2+XwHW3NDrd7uB4r5o+0RQA4m8777w3UmMyuzPislnEZH9/eNdP4eZseCMly8Ll9ts3YYxuu2ZkHXiI2ZWbLZztaKGbtVlXk+BiE+9v4BCtEj/5VedBUOOvY4JVBMJ+W9SpF5XHNB4Nnn5zjL8Dpk67K8SYMaOZiJ62wiad/34FnKzff0HeJ1sJxdXI3a0GrWl8MuDT66GzW0/ekHnMxbWgrtw==;31:WCxex4di77M/bEo4FeEQNupEfDL5PkGfYK+yhMZaEiQ2cUkYpmG0JhDkPDPZ4v41+8ab0OxBS5sGaob5jE/Wp97iEixv2tG2LzmSLTvWUnJYIUbBbWhu2acP34NqF+xN32IdcSt1t9/0Ys2zO45G+tf2rU7FILq3hKTtNWwiwdklW5YMG5JsgB2MrCrs7bVPSX5TzZVULmkWOT0m+Bjv8g7n5OXak15xQbZ58QaMlf4=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2998:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;20:8+4cs6dSLBtOcZu6qIgePdDwUh50ROca/Fq54OeU/bDm4JYktzkxiwjISx8z9A38JKpVLXWw/qp7gzTLt9lwuziYs12NmA6Oa+PsqlWvtFcW+jzZS2blpyvUMeT7WtQxBUutNau9q+gAPV2cDNOYKHET/MZH3gKafBQizhvRt998O0TPLQb5qT09isA5gUfBUv+8P8bNyzdCfJDq9iinxeRbkEv92oGVK3QDUopU4yeMJn4zOBeVuYO35XG2BZl/3kMlQV+VUKkj9KUwnJ+QmAjDkPDxwE6nfPKj4DAlWnjWhSl5bvFxD9GxyQM4DfGJVjYdaOiXAuTTHQ1aVpOtVwX2pqi8fQ6oUbzcJdWaTS7SszyAx/nESkeqhI912py07ZXZ31ztunJ1pGYa2iGA+7Sg3yZZTWVAZCdpQ/tVUmv5GWTQnKd/5iPyD9QG6VopDb8Wi7YoJM/rO2fVA1nyfcNnFULpR8xTUX2iespYciJUmdnBx22AAQapc7xr1oGVfON3AVM9pmq8Nn6dAGOrx4Ln/vm1/boi1fuPrvovaQFGtxjDtAbpLXASGl9X3Ipl2Flhd+QvYBN21FaKEeHuNk3zx9iZluKRJuRqVrZn43s=;4:Dk8c9Ju3lsCR4AYmr3jBtFg9wRA+KgFWM5j37iHPYeyaWEROTWhTK2EYr2bfksvgP3MdPioRrLd2icKX7Tqblz9e7jGf/MC83cNRrHSaYIPY+thrz7IzpXzOm5BPGD33NIddjvS3lHM1m5eZHZXk6uxRkptDX/zs0xVSfl58jgfutMssoy/BMgzBgn7L1nh6GxoEEeTW76LVDQiAOLJzLmlxkZSNN7a/FtOFl4rM7/BedaMc2MjkfoEkxQSZ4e/bliwITU1k4BeyGCWEyt7LXg==
X-Microsoft-Antispam-PRVS: <CY4PR07MB299841322F971ECAFB4B90548AAC0@CY4PR07MB2998.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2998;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2998;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(189003)(199004)(446003)(2616005)(6116002)(478600001)(1076002)(107886003)(3846002)(6666003)(956004)(97736004)(39060400002)(50466002)(7736002)(53936002)(16526019)(66066001)(47776003)(26005)(48376002)(486005)(486005)(6486002)(6512007)(316002)(305945005)(11346002)(16586007)(105586002)(42882007)(6506007)(575784001)(386003)(68736007)(59450400001)(69596002)(106356001)(72206003)(25786009)(2906002)(52116002)(53416004)(76176011)(5890100001)(81166006)(51416003)(8676002)(36756003)(476003)(50226002)(4326008)(5660300001)(81156014)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2998;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2998;23:hrGF2iLjdKIOGPdxErt1CRKPapSgtq7ZI3qiJu53j?=
 =?us-ascii?Q?qilxCK8IH1bEtmosSk59hGEVwF9TRtT9d3mxyD5cduDAj2R/7nKn4uz2eei7?=
 =?us-ascii?Q?QnBvP6RxEB9j0n2JoTLV914HD2EFqvsBCcnfhOudQVjYGpTmJFOty1AmnUQZ?=
 =?us-ascii?Q?uBg6Yn8hFA//+YcnC9aAjismdy+j/rudblGnVsOukRVj7hbiLvDN9PL9+IrC?=
 =?us-ascii?Q?u13h3SgZclN5JyiGyBQOXXgnHfnF20YdFPyatb4ZSjl0/CClFyopt1s7Uonv?=
 =?us-ascii?Q?o+Aks8MgtbuI+xPP9JKekkXc0C2CFiPNJikzPvhu0kpJ5vqwA2KVbU4TQYR4?=
 =?us-ascii?Q?3zQ3wJaB2ED21lQhrAimiR5zIjOaWwS1Ft+PxHQL1HMVRuFg/prd/eIlygpf?=
 =?us-ascii?Q?JTrT3iJECXOr8gBUexw6mOhMVyuuW031N1lKssvvGt9tSZyAQdOS7hX5Jnaf?=
 =?us-ascii?Q?R8tc18p3WpYhIPGGWnB7SShJLXDJj/C+r9AgoTRdce9y5F3FG8jERFwVbIP9?=
 =?us-ascii?Q?0mWesRPCWOq3UckZ+/po0eUrkSGRK6Y0KaI1K5Ia6O8HGebu6C78reFb7yI5?=
 =?us-ascii?Q?OvpaRmrIPunBCyRFw4Msqiz80WUXZqrjyT0pm1vXT0JQgFGksJhwf4R8wexR?=
 =?us-ascii?Q?JDO3n870F+C7BeYktuiGj61u2Ofv+x4rf63GnkIytd0V8JMf8/t+gTZ7bLjY?=
 =?us-ascii?Q?DNFC0UQy/O1lCVqwaOh4Oa/gZnz4/fl3t5TWrdvN0bLZRoS4hOD74fXnH2Uk?=
 =?us-ascii?Q?36MHxXvvrt45tO3H/vK5Z8hEJXGbDzJCv8xAKmCwkF5S9KI8Orf/ZPa7Ipz+?=
 =?us-ascii?Q?+MbJRdkUdWYpgu7BscCc9UfhGkrVwj7MDch8Dva3gx2X6PIeSX8Jo7fFlIn6?=
 =?us-ascii?Q?GDEMi9Mb815TAdNxp5Pp617ZPzMMVb7XrsBZGv+7U/d9skUX3rwiV5LcD47P?=
 =?us-ascii?Q?NjO6e5UJn92EVZr+IlRdktNAqmhBXNA1wtkshCksBLGK+OatBbnf/00ml7kK?=
 =?us-ascii?Q?E1ZpueM8qpVPKW/GE9wLr/fBMNG3ibAQy82iEYaY0MhZi789ksPY7dOqmTpM?=
 =?us-ascii?Q?CATZzQjAHj/DyvR0m4pQwxGBg7mGCBu2YUsc7nurN6dhiBiX8j+o9/NPM+In?=
 =?us-ascii?Q?EnElKsiMR6WnvUz44wVPtsqwCPvIcPmyiXSCpnyeXuN9rXqBoqqExS/JUrhT?=
 =?us-ascii?Q?GQZ+xSW6chn1DfWrVgryWtggP+WXMETHmi0L2lG5f/7qMkNmsY244vhBKNwD?=
 =?us-ascii?Q?EagDAKpWU8rKXzGZwPAzxJ6yv1Ya3hM0VAz0/qvjLX88Jiv4O1vo85NBfCLH?=
 =?us-ascii?Q?fkS63lzZMDm5pC5GGy8sNNTgdgLPs+zCgZbHma0/Z9sVr5VkkcJQf4RRNsK3?=
 =?us-ascii?Q?CQf0N3S3fCyoPAt+R8/vvSvM08=3D?=
X-Microsoft-Antispam-Message-Info: HTyH5MQWlCiku3/RVfIqPEaFii9tDndW4WP9AwL+BlETdzZOQ8/hQBMHpLuInPKRh8MTC6MPWShtng3A7PrHTjH5G4YZLbbvLtIH8T/zoVo5NYbp3eyC4It6THWj6QnGA6cgu9EhLLwUNWkdjplkBXoLLCriDKXEJYwhC9aAiCtgcRuUEw+V/sG7pN9B8WIB
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;6:NH7jt7hcTNPK+ckjc9Sdl6X/DZD8jMhjSB7OhlRWjGD0QtFez5vPkHLoS+h7yvejnm8OgsQc8attZQI/dFgHmqQ0ZiSyCWwPsHTXYxLFsPMAOx3eXiqKx/ogNrvJLCDeEaJzAO2GTMYhN9la03rf8FptLpBo6464Tbe45tNsJzauvogLucaL0uHFfK+7b1CDGTt2AIkV8x842SxuBo+7JnDLlKeP+owl1exnvyTMxNcQFFLFf/4tX0RuSh+4kKc2XiYrJFgEZd+a2Bfo+pJ3gGZKT0ZK0llV5Oj+BgPmlY8oKvl77r2GxslOJQ9uSAmznKgsclJCb5thLrkso6aBuFDSS3k/jFxPAa3PtddY1Pfgi28gjikLnDbcAQuNU/vUWp6R5xwyuNxAIyRBKKjfbGOFjye4b3do8dly4am3c70o5t9rqwp/MNSeD6ebDPjy+SNAgiG8KmysUrcPbTaoAA==;5:WUOFlCzxRkNreB7uNCOPr413z7k4vLzBmU3uXU/0HHMUVzZ5DXmmqfiUCBmC6R5zk7vfXpaUHy2yvVyB8Y2ukBfHlDAVpFw3Lny81pWZ//h59/w4T3oMHA4GpOx43CxRqd9OxvYJeAy4ZFaCXON3LUJlGigo3j2gJ+cNzKnYzLU=;24:8APdrD1mPXTi/N0xUODLEg5Omzn4y9SHyIDWxy1mCpOLY8PpKbiOd+XZ5stFhdbQLTDFQi4uwd92K9P+UFLy4EjkLPHAUHenaH4zsPXswds=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2998;7:AHmgXVo4wNITWZttk3TDM04DAezpu0JK3D7lA4tAeMT+FgfMBFfZ4mQThdCu/2Sf/S0uoCgtKj10b+5DyP2USCVzvU0lTmujYr+GoVZZFOakiri+XYX9zw9PbWLZFLTuAbV9Cv+nuccsZswVqmkLVrf4EpXMkiZNsAWj2uUpVp8b86ATZkc31N2+Hv3V36i/qSpigkwJLnl8DLXz+aw5P6+7E/ykDdD/nnny6TvgI0QRQ3/88GE+s/fbXkHb1Yxy
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 15:07:49.6858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bd505e-f5f9-40e3-1684-08d593f481e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2998
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The ThunderX NIC could be partitioned to up to 128 VFs and thus
represented to system. Each VF is mapped to pair BGX:LMAC, and each of VF
is configured by kernel individually. Eventually the bunch of VFs could be
mapped onto same pair BGX:LMAC and thus could cause several multicast
filtering configuration requests to LMAC with the same MAC addresses.

This commit is to add ThunderX NIC BGX filtering manipulation routines.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 141 ++++++++++++++++++++++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |   8 ++
 2 files changed, 149 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index cf0cc19c03c5..52fef3dab0a3 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -256,6 +256,147 @@ static void bgx_flush_dmac_cam_filter(struct bgx *bgx, int lmacid)
 		bgx_reg_write(bgx, 0, BGX_CMR_RX_DMACX_CAM + ((lmacid * lmac->dmacs_count) + idx) * sizeof(u64), 0);
 }
 
+static void bgx_lmac_remove_filters(struct lmac *lmac, u8 vf_id)
+{
+	int i = 0;
+
+	if (!lmac)
+		return;
+
+	/* We've got reset filters request from some of attached VF, while the
+	 * others might want to keep their configuration. So in this case lets
+	 * iterate over all of configured filters and decrease number of
+	 * referencies. if some addresses get zero refs remove them from list
+	 */
+	for (i = lmac->dmacs_cfg - 1; i >= 0; i--) {
+		lmac->dmacs[i].vf_map &= ~BIT_ULL(vf_id);
+		if (!lmac->dmacs[i].vf_map) {
+			lmac->dmacs_cfg--;
+			lmac->dmacs[i].dmac = 0;
+			lmac->dmacs[i].vf_map = 0;
+		}
+	}
+}
+
+static int bgx_lmac_save_filter(struct lmac *lmac, u64 dmac, u8 vf_id)
+{
+	u8 i = 0;
+
+	if (!lmac)
+		return;
+
+	/* At the same time we could have several VFs 'attached' to some
+	 * particular LMAC, and each VF is represented as network interface
+	 * for kernel. So from user perspective it should be possible to
+	 * manipulate with its' (VF) receive modes. However from PF
+	 * driver perspective we need to keep track of filter configurations
+	 * for different VFs to prevent filter values dupes
+	 */
+	for (i = 0; i < lmac->dmacs_cfg; i++) {
+		if (lmac->dmacs[i].dmac == dmac) {
+			lmac->dmacs[i].vf_map |= BIT_ULL(vf_id);
+			return -1;
+		}
+	}
+
+	if (!(lmac->dmacs_cfg < lmac->dmacs_count))
+		return -1;
+
+	/* keep it for further tracking */
+	lmac->dmacs[lmac->dmacs_cfg].dmac = dmac;
+	lmac->dmacs[lmac->dmacs_cfg].vf_map = BIT_ULL(vf_id);
+	lmac->dmacs_cfg++;
+	return 0;
+}
+
+static int bgx_set_dmac_cam_filter_mac(struct bgx *bgx, int lmacid, u64 cam_dmac, u8 idx)
+{
+	struct lmac *lmac = NULL;
+	u64 cfg = 0;
+
+	/* skip zero addresses as meaningless */
+	if (!cam_dmac || !bgx)
+		return -1;
+
+	lmac = &bgx->lmac[lmacid];
+
+	/* configure DCAM filtering for designated LMAC */
+	cfg = RX_DMACX_CAM_LMACID(lmacid & LMAC_ID_MASK) |
+		RX_DMACX_CAM_EN | cam_dmac;
+	bgx_reg_write(bgx, 0, BGX_CMR_RX_DMACX_CAM + ((lmacid * lmac->dmacs_count) + idx) * sizeof(u64), cfg);
+	return 0;
+}
+
+void bgx_set_dmac_cam_filter(int node, int bgx_idx, int lmacid, u64 cam_dmac, u8 vf_id)
+{
+	struct bgx *bgx = get_bgx(node, bgx_idx);
+	struct lmac *lmac = NULL;
+
+	if (!bgx)
+		return;
+
+	lmac = &bgx->lmac[lmacid];
+
+	if (!cam_dmac)
+		cam_dmac = ether_addr_to_u64(lmac->mac);
+
+	/* since we might have several VFs attached to particular LMAC
+	 * and kernel could call mcast config for each of them with the
+	 * same MAC, check if requested MAC is already in filtering list and
+	 * updare/prepare list of MACs to be applied later to HW filters
+	 */
+	bgx_lmac_save_filter(lmac, cam_dmac, vf_id);
+}
+EXPORT_SYMBOL(bgx_set_dmac_cam_filter);
+
+void bgx_set_xcast_mode(int node, int bgx_idx, int lmacid, u8 mode)
+{
+	struct bgx *bgx = get_bgx(node, bgx_idx);
+	struct lmac *lmac = NULL;
+	u64 cfg = 0;
+	u8 i = 0;
+
+	if (!bgx)
+		return;
+
+	lmac = &bgx->lmac[lmacid];
+
+	cfg = bgx_reg_read(bgx, lmacid, BGX_CMRX_RX_DMAC_CTL);
+	if (mode & BGX_XCAST_BCAST_ACCEPT)
+		cfg |= BCAST_ACCEPT;
+	else
+		cfg &= ~BCAST_ACCEPT;
+
+	/* disable all MCASTs and DMAC filtering */
+	cfg &= ~(CAM_ACCEPT | BGX_MCAST_MODE(MCAST_MODE_MASK));
+
+	/* check requested bits and set filtergin mode appropriately */
+	if (mode & (BGX_XCAST_MCAST_ACCEPT)) {
+		cfg |= (BGX_MCAST_MODE(MCAST_MODE_ACCEPT));
+	} else if (mode & BGX_XCAST_MCAST_FILTER) {
+		cfg |= (BGX_MCAST_MODE(MCAST_MODE_CAM_FILTER) | CAM_ACCEPT);
+		for (i = 0; i < lmac->dmacs_cfg; i++)
+			bgx_set_dmac_cam_filter_mac(bgx, lmacid,
+						    lmac->dmacs[i].dmac, i);
+	}
+	bgx_reg_write(bgx, lmacid, BGX_CMRX_RX_DMAC_CTL, cfg);
+}
+EXPORT_SYMBOL(bgx_set_xcast_mode);
+
+void bgx_reset_xcast_mode(int node, int bgx_idx, int lmacid, u8 vf_id)
+{
+	struct bgx *bgx = get_bgx(node, bgx_idx);
+
+	if (!bgx)
+		return;
+
+	bgx_lmac_remove_filters(&bgx->lmac[lmacid], vf_id);
+	bgx_flush_dmac_cam_filter(bgx, lmacid);
+	bgx_set_xcast_mode(node, bgx_idx, lmacid,
+			   (BGX_XCAST_BCAST_ACCEPT | BGX_XCAST_MCAST_ACCEPT));
+}
+EXPORT_SYMBOL(bgx_reset_xcast_mode);
+
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable)
 {
 	struct bgx *bgx = get_bgx(node, bgx_idx);
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
index 52439da62c97..f5de44bc3bdb 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -30,6 +30,7 @@
 #define    DEFAULT_PAUSE_TIME			0xFFFF
 
 #define	   BGX_ID_MASK				0x3
+#define	   LMAC_ID_MASK				0x3
 
 #define    MAX_DMAC_PER_LMAC_TNS_BYPASS_MODE	2
 
@@ -205,6 +206,13 @@
 #define LMAC_INTR_LINK_UP	BIT(0)
 #define LMAC_INTR_LINK_DOWN	BIT(1)
 
+#define BGX_XCAST_BCAST_ACCEPT  BIT(0)
+#define BGX_XCAST_MCAST_ACCEPT  BIT(1)
+#define BGX_XCAST_MCAST_FILTER  BIT(2)
+
+void bgx_set_dmac_cam_filter(int node, int bgx_idx, int lmacid, u64 mac, u8 vf);
+void bgx_reset_xcast_mode(int node, int bgx_idx, int lmacid, u8 vf);
+void bgx_set_xcast_mode(int node, int bgx_idx, int lmacid, u8 mode);
 void octeon_mdiobus_force_mod_depencency(void);
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable);
 void bgx_add_dmac_addr(u64 dmac, int node, int bgx_idx, int lmac);
-- 
2.14.3
