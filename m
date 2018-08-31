Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEB1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1BE20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DC/dELd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1BE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHaMEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:04:42 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:56111
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbeHaMEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqECgyhTdEkkA/dmO/vRtPbs0xtTVk8toX0MPr05vrg=;
 b=DC/dELd0FvSqJ2rckiEEAcnbRh9CO886wsg0rYEJ403cIyQrPoYIQt2Y9a7zP1keKAdcTiQJpaaJ0+9czZSSUKXVCA2vdOJJCillXm6KyCTU4YKU2ttcEeFr2eJIaw4nu7pQJ54eKjg4osAzrc4vtHd6x0qAm+eto2KvVRrNYEA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Fri, 31 Aug
 2018 07:58:14 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        colin.didier@devialet.com, clement.peron@devialet.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, shengjiu.wang@nxp.com,
        matteo.lisi@engicam.com, michael@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 4/7] clk: imx6sll: add mmdc1 ipg clock
Date:   Fri, 31 Aug 2018 15:53:15 +0800
Message-Id: <1535701998-20443-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::25) To AM0PR0402MB3907.eurprd04.prod.outlook.com
 (2603:10a6:208:f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 464bfc69-2578-40d3-de16-08d60f17860e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:DRHOTmKmZFvNdd5qQTJTDO3QX6DqmLOegX94yJTP00hXK+SamcJRf/gJxMbYLwjIeJqEgwInuk2ECKb2qPF+A7JJz6RcqrFjnnRBehG96hP1X8CGXNQ7eb4OMrWl0h+3YZNIpSdPxE2QXDwwiGZu8fU/0ZljwcjT2RA7odsh+3fDw90MTyMx3eMmsjAUK4Bxy44vG9rrEhopOc0vWwMZJ2aJW9U8ZEB5deP8zWXZpO8B7C+j65Ct13w1b4Hifq32;25:9DP48XTDc0Uzx4g0Oap+S6FhodctTxafy41jfBEg/t/KLYj9wRkr0ZY9xtly938yxnyL3Tn9xN3+7aEzY2Bjugxjrd9WZsjcmokdfzkRffzJM6zUAxpfoRo7bm5/FibtL9WM5dqIMJo4pZvGMrx7uInU759+Ry+vTXrohnu5XJGMHR970GPT9Hbg5NrXXeDxxzlOkm95DFWbgOXKlIa/mF/kK196MdkRwKj9cYXgI3zwKI/0kUhnHYesMUHSFzoy2KpNR2rVFJHi+cFdXO4y23gjvqeVhFsmS/SfkrE+pJeSgZNDcnsyn3qaUZ+f9j6E6OUQiKdizHi5GFNnMTsrcQ==;31:7pZdMS2f2gSyqpnmI8kuGTFCN1HaPahyxl6WzeoW56IbJ5Ta+bJPulykAkP3BaKKMCSa9Q4PoqsakSW9zp2h5x2rd7nUMvKOIinwDSLCvYNwmR9c4BH5ctC+4a/9igMLeuBjAUoDRviPSjJToy06FEoEorbnVfVq3BzIYxLzskpX1kS6yi7jlkquZFklaa+JYW0eUpqhtP9R3D/6Uu6uaaaNh2WiHcgEur9//LA0kto=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:Y8VrThg1hGJyxXvShLbEP0ZsVxClGmo1S9juEyjDvU8Lg3uVfd5eenlEXyUg0L0j3CLrQgiWZ0/roIk1LvaW4ezZ/Yr05IxCyb+J+gteoXE3BWfgq5btQjLjVyBdRAWqUQmRsinCOLVn7+Hm1LoORRR8DjBW+B1rn4XmNLrZS1dIwc27fbH1jZtKLK66Qf4iwZ4CSqDczTS5D9jIGyLfe/TafTEX2cN6kq4w3ydt/ZLHszFBPIkelpmUs/0SXAN+9CQ8SwD+nodkzYIxsFLGhaCr+NK4E0B+2rEa0oiNj+oCd+W8G+b/Ra+OC+N/N/cThr0h0aM6VPAu2X0b9aD8RvbRvaaqeMPhrHM0vfFTGBM+65oLmwl7GDHwfxcoj4scB5q/jfpVJDkFmRKEAsSdoD2oJ/hRrplpxYg3iSd5xbX1U10jMnISvXX6GUe5tf4UJpDkm4dhkVwqL2al/dynIsNeTGa6x2OE4fn/ZMBZrQ1AZr/J009d7rUoEVscK3Yi;4:XZdFFws7e70kJI5U2q0mG0S4KMmdI2V7R9jBWseeVYaHjNnohOR9xXxyxMBZZiit7jRPwn2lTBsC7saLO+BGg+CfsrPenIyX17XFqHa0PVn3IiD5bXtQYIogiq5P5RY0NZjhCLOvDHTQvB5uA2XQWpD9ajPqY9+6yzfP1XLbFbF98eb8ZtZkNVJac+Q4lBOPYqiKCFjiz68UeJbb+hZqSvTbtkEhnBLyVuSWooFnkY+o4kdSAmh8dhtZ1jjsPG4yQMMGq7EcLfLkJdqPkfBjPgZ6TlmD8UnJyr0k7CIHYnTkZ7ai5M0TPgOeDUvwU9sq
X-Microsoft-Antispam-PRVS: <AM0PR0402MB390748FB83AC89AFB9CCE9BDF50F0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(106356001)(105586002)(86362001)(48376002)(50466002)(76176011)(478600001)(51416003)(52116002)(316002)(16586007)(25786009)(2906002)(5660300001)(305945005)(97736004)(4326008)(386003)(6506007)(7736002)(53936002)(50226002)(186003)(16526019)(68736007)(36756003)(8936002)(26005)(6486002)(6116002)(14444005)(3846002)(6512007)(66066001)(8676002)(47776003)(81166006)(81156014)(476003)(2616005)(486006)(446003)(11346002)(956004)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:o72onKkEePVnLX6wlQX8cIUl/s9Y5ZKXisVPUUe?=
 =?us-ascii?Q?GJvSaP6H5HW9m/mZru8cLLYbqt1DhVq6T9ytEiBgxmV0ajIcpws1t+cXlM6x?=
 =?us-ascii?Q?vzDvr217QCU91vm95FWxY6d0imvIfZMJtfZy9y+CVrQEwUqnusjl/DYY0nrP?=
 =?us-ascii?Q?1dzZiVcqJ1YRNG/tyYfnzdhlTJN+gtn84Xpr5Ctx+ZWyIHnWfSsad/VaM3ai?=
 =?us-ascii?Q?dfDMfDiDbmqsFqwi0ujO+rBVbUbwzRRHBL/VSv2KtZlwiV1Sp645gFmX5/t/?=
 =?us-ascii?Q?Vah9UCnW6vGDTblJ9hDyPwxIV2juUiT+sMNvyai83hmiAQm7+QGj+kZjWgsE?=
 =?us-ascii?Q?hEH+W5phKEdLubvUVItMURwOHcw4bFf1ocfwWxZwXndFEmIrc34XH59rgjUc?=
 =?us-ascii?Q?ruzGE0M2Sr6YYeX2O2qh6H26cC0oEMdRQDgTUHGgoNCtMVNkrf4zp1Lj3Ne+?=
 =?us-ascii?Q?82k2g5wXnMwYai7fM7hb2V0oNZFRaSeoFR8F9Zdn8EDxEi58bP2H3OocjUFI?=
 =?us-ascii?Q?a/DAo7M442PdMUjmZKJS8rMs7+NhK/rIuiubcS9GeROnWy5M9FC22HhLa47h?=
 =?us-ascii?Q?e2RE8Xb+QLGJXCQSyTCWIyvmAArFN2bliVrQ5WwxhPKBPWOiIwwlm8tKJI0n?=
 =?us-ascii?Q?uBL8MpsiolJhJsCcDypsTSkp4VrfwdNqYU53Gcyv5jI4d6banJwMLEbzeHWO?=
 =?us-ascii?Q?S7KawiygYk+jwIL/rN64/3GcJURW658i+iB+6V5vd93g6aXrANd+V2ajDzFp?=
 =?us-ascii?Q?wM0ed6nZXW8lLkm6ekz5tbAuZ2OOk/tWssg/0RdAaN0Kz7hg8/UNL5/PH/63?=
 =?us-ascii?Q?RZe4vLH2HJkANlxkonMZgH/PqE/O21hkQ4Ce/SFzUdB6bHOBKCvePtesE3zR?=
 =?us-ascii?Q?uXxSB6PBcpLnbCVlqBkRWI17yvAvWOsmsDjA0/q+NrIb+h8PloKwDUClNewc?=
 =?us-ascii?Q?1Rj5Wo+zp4/tEfBeFccag7lxG3gsvEKZBGvBbjFBtWlbfwLl1+2bgARuNnWo?=
 =?us-ascii?Q?ApF/gNBMktNxQ+AWOAQZgEcWLSCmrRlUCfVl5L8oCkqbV8wqn2zOH7ZO+b0M?=
 =?us-ascii?Q?/fy9DPsKBuD4adi2gsDjmgzYb2m/jA9bsGobfto6JUP7HYNFYL2BDs84JhyO?=
 =?us-ascii?Q?melHNegUyCb75fXs85jC8cEnZJlwoWynWDU9c7+yiNZBbXum8b/wtgSpFjHI?=
 =?us-ascii?Q?OHYKLGiM4FpgGtWjSNaM3edi59qgZKVYVoYSuBgB+Ni5ln4pWfsQ7vgBB1w?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: L08uU0cfx6zVsits1FviVHL5bzUMvoxsHz5MQJECaD+UZwi14+wEP++tz7XjiDj9oNjqmtEOW5+j9oVtc0n7bIphC3xxaRfyilfXo8JimUFD/niAReYb5fG7x2h/V4guxAnQsdM/cEPX03cc3l6MN887R4cWnmwPjaiA3QtMI3Pe7ADG9zidLHIJa+D5A2ZagmC+POQ4nhhA9yntQZruhqPvodWMv3W1N2rKRCzsssJzNpKj5R4sDd2z5bkjp0Rc1CVdFqDf5YjrJxImKhDbqCCO++5zhImu7uBUzMVTAraCWosBBGRO/1buOw5+uLPWuOeExp/sDHT/GZQ0zmSJtf4GRY0SoS9R2rN1LufMOEg=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:avq7ukiU5kiIuJpYwFCVi2zvvDPMuk6o5HxuviRFq2l02IKF/kAzdRsScnA/PBGOj073BK03sgFR9pf/JgQjl75nkk3zhppw+Fm9V/chjvychiWjnCfmTaCZ7pAukhj3hlMJuks/QTb3Qpl1rZxBgRxHKEcdbWh5gDZ3kwi9in3VfN0ZAzj0NKTR52YI2i8vjW15+3Ubp31N9615VD23zAZfgmOai+rFrj4iwDSldUxbeoqzIqYgIQOlgYgK2VgU/442pZTNuEq4/affV3XXTaNbfeScf2SOQ4d7EgKOMzHZC9NLMX+DNPwL2qEo/ke2m0L5uZhnbezkPnTH2PDm0lZXNZOm0ZvW0VyV0Y0i80LpYqa+PqhUu8rMlTVS1Ca62in3G50MQrPxyBtG0zgmOzn2s/UzgGHU5mee1+sy473i5d4ZhblgAdjITRNw/9sWKjJnWx2UK5psLhMrGwQosg==;5:kbLuTFz9Dset/cSRFl5rdYKOc+k0qCm44yHA1TtMj4NzlJH9KJL1XQMBWgyewRkOlMkjE0snV6f0FFRp37qF32VkhEpzbU1PcMHNwSaevAWMwb/1KZH5VjZZb6FHTYTuEkbvvC5BC1O6fdAxmo0MUSFDtm751sV6eWwq/B2pCL0=;7:IX09+Xuo4Hyvc067EHpJQphCr564iRyllbx6u2Q6sMMsO+1/q1afWvgdOam5+PI1bc5mv18cI3X7CAiXpr4BJ9dKAodoXbUjBkMPPQDwfDbvNxbGWKL7ZvRnuBWux69BsZ7uuDJZ40CIZyXaARtQySlt7RnxL7x5BmHEWcqr0GZ14TJWdCHu/mF6GVAOeM9djpIWyiP6mN2QJFwqX0uZ8KJLSAhMrJAp0RpxfQeGAByT+Nk/bpgUCPU5KGMlfe9W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 07:58:14.8851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464bfc69-2578-40d3-de16-08d60f17860e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL has MMDC1 ipg clock in CCM CCGR, add it into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sll.c             | 1 +
 include/dt-bindings/clock/imx6sll-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 52379ee..3bd2044 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -293,6 +293,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SLL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74, 16);
 	clks[IMX6SLL_CLK_MMDC_P0_FAST]	= imx_clk_gate_flags("mmdc_p0_fast", "mmdc_podf",  base + 0x74,	20, CLK_IS_CRITICAL);
 	clks[IMX6SLL_CLK_MMDC_P0_IPG]	= imx_clk_gate2_flags("mmdc_p0_ipg", "ipg",	   base + 0x74,	24, CLK_IS_CRITICAL);
+	clks[IMX6SLL_CLK_MMDC_P1_IPG]	= imx_clk_gate2("mmdc_p1_ipg", "ipg",	   base + 0x74,	26);
 	clks[IMX6SLL_CLK_OCRAM]		= imx_clk_gate_flags("ocram","ahb",		   base + 0x74,	28, CLK_IS_CRITICAL);
 
 	/* CCGR4 */
diff --git a/include/dt-bindings/clock/imx6sll-clock.h b/include/dt-bindings/clock/imx6sll-clock.h
index 1036475..f446710 100644
--- a/include/dt-bindings/clock/imx6sll-clock.h
+++ b/include/dt-bindings/clock/imx6sll-clock.h
@@ -203,7 +203,8 @@
 #define IMX6SLL_CLK_GPIO4               176
 #define IMX6SLL_CLK_GPIO5               177
 #define IMX6SLL_CLK_GPIO6               178
+#define IMX6SLL_CLK_MMDC_P1_IPG		179
 
-#define IMX6SLL_CLK_END			179
+#define IMX6SLL_CLK_END			180
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SLL_H */
-- 
2.7.4

