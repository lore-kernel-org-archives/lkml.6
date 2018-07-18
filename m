Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE4CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548FE2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xw9vnFbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548FE2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbeGROSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:18:30 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:46816
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731695AbeGROSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6WtaYPyyTCQ7aXMwMRHoN/ID/ZGJwUlnqGa+cpuN+4=;
 b=xw9vnFbtHDj3iEmHz/hlQ3vQ+7pj6/1pZgaFFGdIIuCRUUoAUC7b794BK0ztzhBQ2b8F0SNvaaDPUcbJRi/m6pNkjMQiA3l3EuNDb+Z8I1BVKFJRoXZ6C5Bl3JTYqLVMKCPi7miebtW6h74jevbdKUO8OMEmHkmC7gTSuHYHBdo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:40:21 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 7/9] clk: imx: make mux parent strings const
Date:   Wed, 18 Jul 2018 21:37:01 +0800
Message-Id: <1531921023-18497-8-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB7PR04MB4219.eurprd04.prod.outlook.com
 (2603:10a6:5:27::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e10631-c0c0-48e3-2c5d-08d5ecb4049e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:mP4xON6lO+DTAYsiJaJf2rpyPzimjtu6/27j0MgdnDa6ODulwELi6sUdxQPYYzNSB7spqOuzzEj/Wt/EPI0D+DYU2Sma/93q4KEDplwG4CM74tgSTLmUzRz1/6qcWiIVUs56/GXmWUWOCSKiY6NSK63+G9fsHgNt64qYS84GBBpYewi7KcdVGFIQII2eyW6FfPSkkwSKZD/diWx2w3A+eWEdgdRtO5NJby1lA7LHlmAxxOA133C5BatSpNMOLKr1;25:TnHGD9KeDpz8/SYhh171mk27Zo/0lvGrerSH+hq4esGYihjGaU4kD/4WKPuzS5H0ymHQFCm+vqVZ75Y7CeowK5MMPw7v/Gqd/sXnaDKp4Uu9GZQopcl0x6NxV4w/lL7atToIgAhAh92EHH2ZZiTDv6osbfGO0vDTaiWOBiByPbZACzJXRMZ4eS5duUFmAjeVdnsZ4cxisMYoAGWTC/jQegdOJMHY5PQmfPSTdzl7YPxfYcFVp9awxUmsuHQVe9QY8yvl7dSqZQat2o0EcJImVawB93XRx0QLGYpvC35xTrUqSOKnFJZGSxhwY7niEe35OCcHhjnH0pfR1HIrcJsssQ==;31:yQAlZDA6lCbGBf6yrECKCc56Ij4baN1EWUZWX1ipogBP0wnBMbXjAquMSDk7rsct3IrBReSx6yO25EEcaYX+WY71d95UsnPLAbvN164Xa/RJF0iiVkwWjpthrqkkYihUKnd7F+qfbrAYOUI1u7MthQWSkiRenylo0TKiMOjJDXZUs/2ED+Uqx533VcgzsJMQ2QzrhSgbis409DWvr8V357Fw8JJmEGOvnAgY50VS7qc=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:663xwobUVaFSmkXj9VkR+5f+um4GfXWRhOR7vPO3KqRolecsOgNvIo+oCt7qerrLqr2P5Bb4myz+fpglKb2ekR3pzKfiOMlmblOBFaFT8DvqA/m3MXRXkfzq8AqCvr6pI2wF1boCx7xdcq29VYaO7TdHq+0k4byMN3jAt/B+0du0Fl+JvGZx6jEyRv1NWCjf/V+X+Djo9FIqB6d4cxme7sOyu/BmVnGDLrjk2Vqv5MJO3ML7ZURPBzxgds2lpyIFdcqxIbz74nq0bWXTQEWlirqUc+68FZw8ZB3OgTIgbOr1qcbuuwIBWfEZ1o1CoTNLs6cUR6xxR99ebAFDoFlOHULo+04Mak8Z6o+SnmOzB9boumP5lZ2ubr/EtbuYb1F3yEJYOCpO2ofApPLmt+3FiSyHRF0nv2u8XB8DgiyryoSbVRn/HtuLuamsrXOqFRSJwixim8CMRM16guHQXE5OkIZzjiGPLI+kapgIG/I2uOBPNXCgLgQNFC62tAcFQhXp;4:9g0zrr8ynFDyy+UZzp+hwJnpB8aCOG/F+QUszkXByATJEql9vMi7k9hcjAqwKeW0wJZRZj72t13Y/NkTG0sNjTbbbzyJ3ZGNRZ8rVCIidmkthZ1OEmyhnna7pf0gDHaH+bBeP980N16JCF8vay1Rv1jfiY2AUBW1E6UNPT0i6tB7ULpHwa9LrMIZOwnbXW1ED891ADHyHx16GqL6vnUCeKjxrt3dGgmzW+A27++wXcUNZiFdUpm+ZngHev7mKjLxWVNa/1JeTPSBrPC0JGZ7nAlmYPCbR5b0AhuDSIE+48Loxe1fo0cM7rn5HMNkuVtA
X-Microsoft-Antispam-PRVS: <DB7PR04MB4219A67792EC436BE179FCF080530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(14444005)(68736007)(76176011)(186003)(97736004)(50226002)(11346002)(476003)(956004)(2616005)(86362001)(446003)(36756003)(16586007)(25786009)(6666003)(81166006)(6916009)(54906003)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:76GbLXRSRhEwlONkNBGsMNBi/SC/JpYrHXdwI7KjV?=
 =?us-ascii?Q?Zr4/HCXqMp+gx/jOPITDgYgDqgMca+zRl7okDG7W/2CqnFsBA4Nq+qCGM1aW?=
 =?us-ascii?Q?qDaZnlPJ8BYxGqVklVN8EPfbvJIFNCqpCw3kttQ+Fx+i/j0za/VA8QzwUZDO?=
 =?us-ascii?Q?+9zWPC65lQdqi1rXS1yZ8t/IRqE0VPRdfVAkOk6kx4ABsmuJIQ1WpkbCheo1?=
 =?us-ascii?Q?uAdlIfmjDOz5pUZg2y3r+dLWw88Bq3Fk8k02KSaWSDL0zY6RGidyxLB4as9J?=
 =?us-ascii?Q?R7PmyHm0Q3/lAMnaOe9Yzy9VeZP6MZf0QiN1ILA+64LO4nIPOkoAfAgcZ4hP?=
 =?us-ascii?Q?byLKV7YaFRGXA31KBHxWBew+If982t/WONJacUhK9yp1/lRGK+mHmRF4nOM+?=
 =?us-ascii?Q?/MxqHGsuv1SwZMGY3p1UhLOJXEYxSycCqXWzJLKzaa3ZvlS7i5rtkyunxxbE?=
 =?us-ascii?Q?zWh53rPNOr+505ORAIxG+faCTJYSSAUO7eFfD/WvB3DWmybxPq2n1B1n0N/v?=
 =?us-ascii?Q?FQDJqnbgS3tQOLrVEnICFFC9kcfG+buOTFViAQpBYYn87E/bqmYAE0HWWB3I?=
 =?us-ascii?Q?MlULE3CbqQ8Mwq8Kcz4HgOPqzDl3GYpfS6WzFSYWYxSDy9StILrQQVZ3utpM?=
 =?us-ascii?Q?nnGSIuTump2mM+NwOAhW/lcXlTSVtDQJOU78gfvrc9FovkN83+/Sij/0wS4J?=
 =?us-ascii?Q?RqBEBYPgNEFoPdCk27eP9iIdjQpIxc3ur5y9sRaN917EJgxyYuW0yk237sLR?=
 =?us-ascii?Q?Zapxfi0xVIIh9mxZ6Je1i2v1MYMp04ZVQoHlR4xHbMvnplGhI3t+JbCeaKx/?=
 =?us-ascii?Q?RqoL1uGkN+v6h93hSsZSFLUxIC9mPxTvJ0OWDpzIB+lezTXZDDi6sBq7Prd9?=
 =?us-ascii?Q?kvrq91HEU+DlHumymTpmXUoA7caWP1Sq5fzjnefq+3YJYn2Q+opc676xJvUb?=
 =?us-ascii?Q?DVgLmx76AGD5yh55jiT2M1NQwuF86HPq769HoF7blCmdM/lhL3PDFUCIhEqZ?=
 =?us-ascii?Q?R5plZKcnzANiqbJg3KXBhQLmfdMT0J1qlfOGRVIYFesRQsmL+DVwkMlANSAC?=
 =?us-ascii?Q?/4ZoqM3llXkXdKvl2tPbLB4Gq4H9DOtHoAjpZo8Bg3LOgE1vflgMxtS+aioj?=
 =?us-ascii?Q?+ghLHA63htAMuzooz2PaZq+JDdZv++nBrfTwz5SvTNoQACI890xbo0KdxRak?=
 =?us-ascii?Q?I0XLDD9RTpznYIZwkyzR3IdwhMbI5rlQBk3tCrtrbFdhItKQRf6UHdVUcEco?=
 =?us-ascii?Q?+eH+TUO4+fdoBEC16CI2gbpbuuDyX0Bi/UH1+HPYPrMeNngWn4O9MKLy+nHS?=
 =?us-ascii?Q?/Fe4OQVPbcYE7B/Qq+RQ57XoLkXSX95ttFCeUfgqXmzQuv9/QdETvrRVth/m?=
 =?us-ascii?Q?pzIyg=3D=3D?=
X-Microsoft-Antispam-Message-Info: R3ei715vwbFnWyr7+LBCiedsrGgH9W/OjZPnLw0rhYmWCWtsf8MO09ejuR1FOoCIG3ZaBUwkbeKidgZoPAa9WQIYphrLXvBlz1RX03U53s7Ml4i94eL0jDRwvFZ2j+TKDMPoon86ryk8Wpmoq1Bjb6BDql3G2ghZ5Zb6Ifgijmy4S+89V2EbiWt5CVkeSUC/wkLeJmIPFAYJhC9tyTop1t8l/kZkhotGx9fDg9MYpw9qEL2/Yf9y5ijcggCQG+DelsJSINehs1wem5NGQumPh+FewYk0Q57qEfmrf2zeIFh0FmUTGF6haVco2TnIxzgXJ5KP9p5Vud6LDppbzNtYGi/YM6Y85hM5XeLRoObzCDA=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:K1Ym2tR9hIHlOHVuOqPeDcQqGgdhv5UmPuy3JyzSG1hKjzJXiL5qrrCbMN/091LPwlVLn764RqmiCQnCdXttsuwxfQ8PPJ4u+1DpRexkUfj+kEunvqbw8EWdTOtf66vYexfuwu0+c8uCxIns64XkqpUF44rPGlyiJMrioPB233vrSvX5YTHsJidMB8tjkk9ickCGsCu36GxJLU05M9U0v5Bska4iXd5stfcSLsjEsDqcjKKwt0kfNTmiRfYosQIdI5vxdRAGsdeqYG1r6/BczK/3YPN9ve6Se7G06s/nNivtAH4Bnyk1ziJi2X1XZEnDzoeT89v2V6t+i7R/aGijSNcFaQig0U/MKaG6M7H3eR8FxLfpSO67+e0NWSjkD2pWnBZ4FNHlJ/OWcbOb3E5rO/ILoh8Y64IBq8N49x++FuK7o37Apnz2Jf3RcT9EaIrUDXggJf8ausL5ZCvlG+emPA==;5:LGOuTFG0dE19OsUQrC2iMyMCD3Lio7GuzLZU8eC4rP99nZGYMFaYiz/I3n3ztTAqqrkw3YarOVBxL1ix6fCdRZEBZwFEzeCpT5zqJaMoCwYEFg2lL5LQhlWsYryIC5k+Fhxf9YPbEoYn/AZzf9M5X2OWB0LKVPLQCQ4PniGtSKA=;24:3r+C3mCk5Oq/tsuFTtgdIOHbzftz4NRLsEEiRnoBOLJ6TVOEqgTSCm6HVx+kf7FGiBGzxbhjOrQAtYxiguu5HeTu9oFuvn95CFv9SDWbGpg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:TCNP/wCgbfEGDXaHIbgknxTCqNlEv1O0+QNhNIzkmn/8BiTpB+y7mGRQMUfWhNsKY9v7JktWOgFg4CwXVF1AjVG9+sdpBvhGr5w9+IdI5RpUcvYUkizl1aUv5Ed6DyAfBT8ts6r1d65rwsJeiNevUhtWd/KYdQPmiT59H4b67AyksZq3I6+HAMR6jLP3uVwfmNQlyyZWJ/LOZ0cOTgWQicH+OfpOyE22JR/0By2r0njJ4Z0htaRDN+2ADMKiC1/N
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:40:21.7128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e10631-c0c0-48e3-2c5d-08d5ecb4049e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the commit 2893c379461a ("clk: make strings in parent name arrays
const"), let's make the parent strings const, otherwise we may meet
the following warning when compiling:

drivers/clk/imx/clk-imx7ulp.c: In function 'imx7ulp_clocks_init':
drivers/clk/imx/clk-imx7ulp.c:73:35: warning: passing argument 5 of
	'imx_clk_mux_flags' discards 'const' qualifier from pointer target type

  clks[IMX7ULP_CLK_APLL_PRE_SEL] = imx_clk_mux_flags("apll_pre_sel", base + 0x508, 0,
	1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
                                   ^
In file included from drivers/clk/imx/clk-imx7ulp.c:23:0:
drivers/clk/imx/clk.h:200:27: note: expected 'const char **' but argument is
 of type 'const char * const*'
...

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v1->v4: no changes
---
 drivers/clk/imx/clk-busy.c      |  2 +-
 drivers/clk/imx/clk-fixup-mux.c |  2 +-
 drivers/clk/imx/clk.h           | 18 +++++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
index 9903652..e695622 100644
--- a/drivers/clk/imx/clk-busy.c
+++ b/drivers/clk/imx/clk-busy.c
@@ -154,7 +154,7 @@ static const struct clk_ops clk_busy_mux_ops = {
 
 struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
-			     const char **parent_names, int num_parents)
+			     const char * const *parent_names, int num_parents)
 {
 	struct clk_busy_mux *busy;
 	struct clk *clk;
diff --git a/drivers/clk/imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mux.c
index c9b327e..44817c1 100644
--- a/drivers/clk/imx/clk-fixup-mux.c
+++ b/drivers/clk/imx/clk-fixup-mux.c
@@ -70,7 +70,7 @@ static const struct clk_ops clk_fixup_mux_ops = {
 };
 
 struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
-			      u8 shift, u8 width, const char **parents,
+			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val))
 {
 	struct clk_fixup_mux *fixup_mux;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index bc43f68..7fca912 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -69,7 +69,7 @@ struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
 
 struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
-			     const char **parent_names, int num_parents);
+			     const char * const *parent_names, int num_parents);
 
 struct clk_hw *imx_clk_composite(const char *name,
 				 const char * const *parent_names,
@@ -82,7 +82,7 @@ struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void (*fixup)(u32 *val));
 
 struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
-			      u8 shift, u8 width, const char **parents,
+			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val));
 
 static inline struct clk *imx_clk_fixed(const char *name, int rate)
@@ -91,7 +91,8 @@ static inline struct clk *imx_clk_fixed(const char *name, int rate)
 }
 
 static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT, reg,
@@ -204,7 +205,8 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 }
 
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT, reg, shift,
@@ -212,7 +214,8 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 }
 
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
-		u8 shift, u8 width, const char **parents, int num_parents)
+			u8 shift, u8 width, const char * const *parents,
+			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
@@ -220,8 +223,9 @@ static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 }
 
 static inline struct clk *imx_clk_mux_flags(const char *name,
-		void __iomem *reg, u8 shift, u8 width, const char **parents,
-		int num_parents, unsigned long flags)
+			void __iomem *reg, u8 shift, u8 width,
+			const char * const *parents, int num_parents,
+			unsigned long flags)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
 			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
-- 
2.7.4

