Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeC0OXx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:23:53 -0400
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:13856
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751122AbeC0OXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:23:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Peter Chen <peter.chen@freescale.com>,
        Irina Tirdea <irina.tirdea@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Anson Huang <anson.huang@nxp.com>,
        Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
        Dong Aisheng <b29396@freescale.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx7d: Move clks_init_on before any clock operations
Date: Tue, 27 Mar 2018 17:23:27 +0300
Message-Id: <1522160607-7104-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR08CA0059.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::30) To VI1PR04MB2143.eurprd04.prod.outlook.com
 (2a01:111:e400:7bdf::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e44d8f0-879c-4e99-f5df-08d593ee57a8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2143;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB2143;3:FBcxUjBKVv40gq3Phn4zT3aAI72tHuQEJtav1XJsIJNMakfuFn5V85JQmHA7KRZaf8WS94UvIDUiavK+QvjFG/cNx445afAfYi0gcojIZmO5WwtuAIiQv5Z6wQ+wVWhbyzf5hgWPR/qkqcF3fhN4U+EDa5Oqh2HMFBTtx9vL4WmlV6lPNhvQrOGxZ5z3xDpRnVu5pe9iWlPa0ACyexeBThtX+biSPkou+cAEkYttYLpfTR3cr0RuduD0PoapCExQ;25:W9jMurWkvr+JWBW60DtBK86sqrIcwOTvev9T0IjMPZ0rcocI2URfTWgYUXYC5OF7in8z4cqn8N8n9fZyO48DaobGRyVra790ynLQ5e95BhH5PgdoQlSqfqnDgYX/qwcivjoou3JJSdKHYH8xs1/vcflszuJG0/VJNbmyaurKBOJTdmAEly8lVXIEsrduAonzTQDoVUe20FLtuEnscEiBB21kap2AfGGwIWJFzELTkbXMGAX/TGG1nrCWvJjSf0cL8ISpF57+mISLLhDffMa1+J801BAEoXvbNz7yuT0WqQ49BXRt6ivdN9X2p4uGyvEZRVa8oz6GAiZ2vEzVE+rZWA==;31:xOwfQf9ytOTI7ByjTXUI0DF0vnJ2RTUmkSthC7Vwu8z69ojjnaheS4tK/iq6u3GI6ClS3utEVkv+6HEu8KxWzIpVLBrKHN07MIJ5jy0/Cn6ZzYGKLSW/5e1x9wr0DQwZBYHBJKpc3Hb5q5PSVNgPuo4tWf5AsnroyfApDC96yrTUWJ4fR7PGrwDuhByVBjXI05KoIDUonN7/TQ4Pd2DLjh2NUXi1jRlw2cpnEX0Bs/g=
X-MS-TrafficTypeDiagnostic: VI1PR04MB2143:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB2143;20:yyrtswe41fl+yU3Qbqez9LEbaMm0H4ICM2uvZVQrw/NCHi+ZWCIPEl3QvKFr9uzkEvn6a/UfAsc/Bk+fWYbnDGa+7pduYiubtIvIc1mQZVRalPFsgqJ6bbZY4+eBtPNm0dZ/ibRjHflpmt2YacBedCFntElScZdx3omrwhi2ZfwFVaNZYVYSoA2DbCs6ch/bDz9wk2CSnQwhcORd4QUVP+OpOzW9nYfIc9Q5HMG5a3YGD0VwbLT8FXvq2g5MKJNClMEF5quNTQKBhMWMEfRFqYObv4AV/4u3w5pq/w3WsP2wZdDCvS54PrG6IGZrFtDsSvaERJOEtIhExxkwSj7SoG3Q0HJymdNRqwWF8T1UN6o9du60DMetOTZOH72NYgxYKxs8OCr3PTk0APsW/AVXrqUCWAvMul8k1+EeQMJ5lQO9V/4SSvlJqfT72ReaAb42LyEtYs5cd82DujKO7yI2jbUKG5SQE/BtEIPGMIxxKbJlylSEK15Tjy+RYk+hP9Xq;4:H7dtgofFnzXBlJ6nvhQgXZJczB2WMpzCs1e/ZVEcg7k5vYc8Wvdsmm8DmaZOI5PvCpDGp9ZpD1GN+11uTYWJs8twfdlU0QTidCvC+YTtOhhm/ZMerpho4XkJbU3Cn2uf8LcpfgKLmAYPS40NSUVjAWhaU6MEOTThG5muGjFk3QV9VH3H/W0uPmC3QPNjk/pTY4vWQI7FNBa/e+hmDcYSQSEvh24PULQrZmXEnshs9S+MDDAnKJQcMblgZkM8HIUOFpn62SH1E/hZ7H8CPR73uqpF+NPg83krLoufUStk2kBKbPrRwpsqDw8baeVvhnuUE5DIcCrwY2pQ3kbsqofcvkPecL+RcPlhX8EeZdxnKe4=
X-Microsoft-Antispam-PRVS: <VI1PR04MB2143B1236C537770E9426617F6AC0@VI1PR04MB2143.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB2143;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB2143;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(8936002)(16526019)(54906003)(2906002)(110136005)(106356001)(16586007)(478600001)(6666003)(53936002)(1857600001)(186003)(476003)(386003)(26005)(6506007)(2616005)(68736007)(6512007)(956004)(7736002)(5660300001)(305945005)(6486002)(25786009)(4326008)(105586002)(48376002)(6636002)(50466002)(8676002)(316002)(36756003)(3846002)(86362001)(97736004)(81166006)(66066001)(6116002)(50226002)(52116002)(47776003)(51416003)(81156014)(486005)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2143;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB2143;23:RchAkHKieUfiSzSMgoDZTy3Etkb+8a+6DwERgROr5?=
 =?us-ascii?Q?iB8vlRKuD4s6jagzoLwCibm7Od/UdLxA18JwCyhBL9H81lh9Mo18SfRP0l1S?=
 =?us-ascii?Q?R4c1tT4/iFx6e2y0PxtoecqA/pxLJnhkuf7B4znpt+yUyMpccLa8za/e0FJ1?=
 =?us-ascii?Q?gWuzQu/zF/glLpIhlSdD/OywUGyK6vDUjf5EM0LkHPm9Yi3Zq5Mxgc5N/hxN?=
 =?us-ascii?Q?wjPBbkq10ypvDWVkAGUW476RLHtSTBxNq/IfOajYbAXnvUQqtDYYqPQ3wrg8?=
 =?us-ascii?Q?C0wyS4Uvj7NrNOm1peTOYBAtnsFGVN/7wKUI33faM3IUiP0GHRJCr+Mit2w7?=
 =?us-ascii?Q?qgmPCL/Rk1aRiKqntWO7OEyCOcdIDj4INQJAitTTs50FNxq6q8KTrbSTx7L0?=
 =?us-ascii?Q?J1R8EgZvjeGc73fxi+Fpap0wjzTD3l//V5Sdof0HxGMHrHLptIYMox7cYp1E?=
 =?us-ascii?Q?jj7ww1r+UdbO+BzKWTiH4+uD3vW7X2uct7jrOUitVXOmTMEZAX0cowQwpHZs?=
 =?us-ascii?Q?N9tgvaqoPghJhrUTfGG9BGz2jIpn/C1q86GU++gaOVFeoAx2pksXGcI04stL?=
 =?us-ascii?Q?vvxQQMqXZCaJr6I+BaSyGfLQEl0sSoSYaTc1WbnlYZuUTHF29kHfPs7ugvs1?=
 =?us-ascii?Q?5LbpXWJ6qrW+vpjJU7J5Qdo/1uPTxLQmBeSBQwT8kIxoBniydbHlkl8Oxrsz?=
 =?us-ascii?Q?wQQiruoxXdiJUhCf+L2ZNCH4NVB5OI6fN9axOUeKlFOV3drGSGU4+q66R9Ud?=
 =?us-ascii?Q?Ea3MVHcH8A4gF/LFSKrGVy2jmeTuC1ugR5hX0Ml9DXtYd+oodx56vsqDZUzC?=
 =?us-ascii?Q?qilAJTZeIQWa12HS7N4q6EEP7MG3Rq2oQs2mGUpS/BBlGqWk3y7SBDvPObyl?=
 =?us-ascii?Q?O1Nrp86kkN6B6iesAGpCJIK/YPK4o51kLdE4T/hCSyqXVgY4Baz96gkE/JQa?=
 =?us-ascii?Q?QIARVgJDV17niCl+0IdBOawQ/ybzF37MvaPQYGukxA30+vXnI6hu7XXiTAvN?=
 =?us-ascii?Q?a/okzNwtUvSKUewQ0G8dLQhqILTdbQLhSGrbqYAYdb7b9a/pWl96X3w2P03X?=
 =?us-ascii?Q?1xDodPThmB5/qbunzQT9Dt0Yy9HUpMvDtmzb81DPuBeA9YhPw506l3JlvcZq?=
 =?us-ascii?Q?AQFkXOAx1ckCYBid2vmrSRPHyz0Jiwpka9zrjmUZC2FSii3mtP3b+TM2bvVr?=
 =?us-ascii?Q?rnhqu+hFsTx79J7Q3tjVbGqRGd1CQC4snk3?=
X-Microsoft-Antispam-Message-Info: TPXjipFJIPaoEDbVqNxDvVYsfG3WSGWG2BZx6+V5/wZ3pPNfc05ELZLxuCVuryvzuWaX3/RXLAMn5NlIGRxkbSIS8gKB4n88OEJDn+SUlLC7Rnze0x1U1zA4r8RAdZC04ATOoOC6+tMS1uF3HfSbQTZC2fkc/GuPlkVVl+uyfM8889d0SiYHoc8QWAph5JlG
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB2143;6:M0fgkMBOOrsUYSjDUlBhwuq1y2lwkcblSXSYvbtXEnVHltch974ISNe+00ftiJOHvct9cYJ9GWDjiLFBGo59H/Z4iSESG9MKn81vT0MwcQj3FNelPk44VqFY6igiaRa7e45GwS2jfHo8mLw/k11x+pdi73/tPC+R8BKA8Gy/k53Ldl3AeK62Or68d3JBPgAK6eiXgBrL2akoE7hBvfc3HxvqQZNhVTn4+bM3owAZsEi6pAJwWleSspnvfxSb0UB0Y3CjVzYWPQUDUhaMv8ZnHI2errUJFM3uLB3JKuGXLtpuYlAjf7f2bbmGT0tHACYG/YE2fxX+GmOM02p1l0x2zgy10HqSOOMjKWyFu0yOe51eq0/0usTyf10zlIf4RqzL2ohMMwXJonMWb7m9EvzRZuO2j1QC1quUMNGuDvkI0dBdv+FFD3lJYMrMdce2vNEupAOxHADDJNQfy3bcR8gSkQ==;5:EkqUC+x/3deBn/GRT1cTrMngeG0XmurXRns3YBvdXuMcpbrjaktSlPHGscaAb1/o+WEhMScKtIXnsylSOT1fFnMX8WNXXED8k775fkOK++HphgZ18JavLhZaIa+AKbrjx/NxpOPARPi4qrc5brWmEs5daPLHdrROu4mY2yMkhs0=;24:00fks4tV3Ness3kiM+Ir77OjuJaVwNpnchLcvLknCwIauaJuFRvMWn5BqA6KWfyGw5sV4yQ6cTB5sJll5F01Gsw3j42/a32abuYovg/swFQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB2143;7:H+/J8X5kmb6GWDSSaUcEo2jWtZqWpvMP1BhXUfcQ/eWrHoXzm/CR05Z4Jo9SjBvIfiRz2/uSynpBDChReb3IaRiP2ZLjjbspGRtbD7uyuvLcHnUBgrbHPojV1JeQgvHmaL+fUX0G5yve2iHY76yeJrVAv+iWzvhqGqatFWbLsd6RlzmaT3WBLmPRNtseofdNOwO+4At8hUF+OB9yK/1UGZz+V3PKTfU8LoPfOLpSVyh4JktEMdWewYE/v7+xwMTa
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 14:23:40.7482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e44d8f0-879c-4e99-f5df-08d593ee57a8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <b29396@freescale.com>

For init on clocks we should move it at the first place in imx7d_clocks_init()
before any clock operations, else the clock operation may fail in case the clock
is still not on.

Acked-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
Signed-off-by: Dong Aisheng <b29396@freescale.com>
Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 89bfa75..9b17805 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -433,13 +433,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	clks[IMX7D_PLL_AUDIO_MAIN_BYPASS] = imx_clk_mux_flags("pll_audio_main_bypass", base + 0xf0, 16, 1, pll_audio_bypass_sel, ARRAY_SIZE(pll_audio_bypass_sel), CLK_SET_RATE_PARENT);
 	clks[IMX7D_PLL_VIDEO_MAIN_BYPASS] = imx_clk_mux_flags("pll_video_main_bypass", base + 0x130, 16, 1, pll_video_bypass_sel, ARRAY_SIZE(pll_video_bypass_sel), CLK_SET_RATE_PARENT);
 
-	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
-	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
-
 	clks[IMX7D_PLL_ARM_MAIN_CLK] = imx_clk_gate("pll_arm_main_clk", "pll_arm_main_bypass", base + 0x60, 13);
 	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_main_bypass", base + 0x70, 13);
 	clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk", "pll_sys_main_bypass", base + 0xb0, 13);
@@ -886,6 +879,13 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
 
+	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
+	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
+
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
 	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
-- 
2.7.4
