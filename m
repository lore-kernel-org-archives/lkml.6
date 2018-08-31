Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855902083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tEOCz69I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855902083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeHaME4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:04:56 -0400
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:7632
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbeHaMEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfwB5QpG4II+YnP7xB3hCSmC+N3wkOV4ECnDZ54A648=;
 b=tEOCz69I7WHT/6XNwTtK08PaVQGPBlmonEe4GWCiBrZ35V55mB6ACn0wurtJtpUlK/DdsXtGE8Je9nDg2445EgbsypR08To/cmkfdCbnLcTDMmUTbhmIhBsUopj+wmAozE97njirRizE+Rku5sAWCcySIcU7wFB9zjzt1ASKGFE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Fri, 31 Aug
 2018 07:58:33 +0000
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
Subject: [PATCH 6/7] clk: imx6q: add mmdc0 ipg clock
Date:   Fri, 31 Aug 2018 15:53:17 +0800
Message-Id: <1535701998-20443-7-git-send-email-Anson.Huang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0edd7ae7-7bc4-4972-b774-08d60f1790c4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:OKf1UmRQMR9ASGZa2rUuwdLYa0Rh0jCjABC41LK4gyKrX5zZ4ZBgdzHB1UvQlBk5QFAkyFTuKweiXsCFmUcjryv7dZnRnE42DyLwi7bArQyuvsW0tkeznu7lXhih6GiC20K3GZa7TOnOrOZiyAL/Ac/hJOUcVVwSZsIvPFJezKn79OMLwmPcqMg3G/cdDZpRGk2Z3rKb6tV16SU3fD9njWoXLxvV12NUDuVIuYdtAsy8RrIvNF9YOEdqBuKzYKGI;25:px3qvtWkvuEw9uIw/XvCS8q9FLyDk4M5rkj4Y5d2fFeHM/iJUii/7I297S61IZKAPNb3flV8QCwxWx1+gJ0FzHuuxkbYHIpKx7jCyK9ZRYxDlw20jcCSqbyXByyQsOMkUVJdNILJyadAOLL33yqlMvfuOuwRLIs7vFGvzmq7YeRt49pDZQGhvL6pG04UWrJCx/vfwxbt2gX5GZg/CuIgP0fQ6Rx+9tu7IjObacKQeDRsK5RHaWYx+6/AxRwMn44Wkxb6CDptS/rRx6tQXFl6l6wGvDYcaNClyvGYmirK5Ku2U/GXrrbt6EUuVradONa6pSSCMv9vhp2gxW5Wr99J/g==;31:knT34NAER05a4FlkQqbi9K+7sSJyrdbwM+yJG3pPPmJmrnnEXW5MC8PBb30gIUNqS5QMUMHRDw/McwgTg/Xohs6ogavrf+0HWopwKNFPrvkyF6NIEQQVga/xx/7rMEhM8Hm6HOs4oE+5lfwjtwsZJDebZ0Vak79I47B/PKJuI5x6mrALeA171A4qb1KqqGKaD7zvUcPsZPPwleZzizLvErO81hC39G8EJP2l8PIV7sM=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:KAZRh7Qog0WMoK6oRcLoboUOH0ga8OcUzBDdUY4aX7nmp+3K88u47FJmdd9pBFD0Y7maSRrtlVYVmGFUswy5nbAdH/sp16HD89imih0X+APZtHbtaJq9mgQ9Xp2tgQfYxuZAUF2bC5LpyQBjtJdwNAaPabo/Jg1IO2DkyiumPPjsyMjmdLE2/4qk+UjVw9/qeSvLgYtj7W05yDRs20kUI46/61h/j8MZGq0a9zN2awnNnKnxjIdr2b40hAQhWSvZju+9vXTLwnuB0VakSIhk2LXkoKE9egnQx8EhrboOwtKegBJFtihuoweznuVBa+Krgmm7ADuv+3MCLJi5QyMP4PgXYCRE/o+vQA2LAkQy5zi8BRIoU4lzRjq0V4+ZInoF7QXawRuiHXBiEciwVPtWip9i/NLkk1nNBAXYfkPkaDfXR0/NYQqu/G1/0AVl89iYG450yNssINVudV3lQzR4TjCI74bWdD9tXk+zW5bTGqMk0fcK5vYzhxjxjgearaJD;4:vJ4GjyNYdiK0K7ErK0iJZC3heP1yMUKvELOPD2F6zCYE4ra8n5Eru7/ymSpxYl6OqST4CY3+sl7FidgxJ/tVjUwJuaKLpjxSCBL7gh33+xFPHKOg3luEQgS1g+/Co4NePgv5B2rH1JwYwnodN6AQw/gngFxRBfqeoNWaK2avsYz7EPlt47Dptz1NZK7epA3xLdJAVDBegy0ctPCONcaJ6NEkdbpBzVMYoFUksOeaP4B5j6NNqjwXjZbPzSgn1h2QT2em/9DLVTtleOkTW9wbrILeSCW3GVZZFzUC3RZ+syATOho/RY0Y9c7c2I7EkKF/
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3907488697AE70B65D2A0DB9F50F0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(106356001)(105586002)(86362001)(575784001)(48376002)(50466002)(76176011)(478600001)(51416003)(52116002)(316002)(16586007)(25786009)(2906002)(5660300001)(305945005)(97736004)(4326008)(386003)(6506007)(7736002)(53936002)(50226002)(186003)(16526019)(68736007)(36756003)(8936002)(6666003)(26005)(6486002)(6116002)(14444005)(3846002)(6512007)(66066001)(8676002)(47776003)(81166006)(81156014)(476003)(2616005)(486006)(446003)(11346002)(956004)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:7Fm9OecqJVYDsO6uq4/Zok30ysHyQOtPCGpQI9b?=
 =?us-ascii?Q?Y813ygcYo97cLfUHqG5k6SwZkzA5gwikZqGGLyHefxqJbgTzvfoZ8YfLjZKw?=
 =?us-ascii?Q?Lm8T9zAiJWxCw/UShtt2HfSWGHPTGS2akSo8c9Sj30f9Ip6soQvwtCi8HePC?=
 =?us-ascii?Q?CAOBF/QjevcrqmSkOd9oZ01Rkpa7d2AWo3hEujC8W9aa4p8HoHu02MyBDcsh?=
 =?us-ascii?Q?GQU2L9KagD5ih5DGMo5sUAKD0JQ6r04G3rzojFBmmdku5D2xrAli+U7U37M5?=
 =?us-ascii?Q?9Ryt/5HwvZpoUSHLQrwQbhYt/NblGIwyROLipzoBTXSQHx2H+Iz5lGkC4F6Y?=
 =?us-ascii?Q?vq5ZDkWwwMiul/er878yv+57rjvt8i4cBlLHsnJ+q0LqtvQm2dx5OZp5AUOe?=
 =?us-ascii?Q?sa0EuLLGB4ipWgYIcJZ+v5zBOKB5YESeBVNl03tJNOLwE2gLj22PnEwhMo7M?=
 =?us-ascii?Q?l2FQe58kW2W8+Ck0p5qASfe92KJzDL76OrXVAV6OsUNqfAgzCVXqUF7QSONA?=
 =?us-ascii?Q?QsnZdKnbyTKnJL8NFMt3RFAATXJXi+Absutd3qOxku9Uk0FRwbXxOoDzOiFA?=
 =?us-ascii?Q?4vvsSMePcZCKOKzK4hzHNGmsK7V3KJz8KlvMIbRVllipOuPhC0V38e2mt6ko?=
 =?us-ascii?Q?F2fQDyHccibYfwhdK/7DHlVmkFJalsrgthWML8/8aU6MpSTtYncK/npqdB3/?=
 =?us-ascii?Q?mifJe+wuctkvAr2jUprbza1A6OFxrcufQu+s7FNb1WTaxXyrzdvUDZ4RTGus?=
 =?us-ascii?Q?2OG5PEaJxbCysmg81R/NPaFCNz/P90RlGL8cf1VErAAGstHhtreEL9lIukhX?=
 =?us-ascii?Q?R6BI+4mb/k+SfoUqqRUbdeWKHywdFRyiO4Xh/bS+DySVwZU5EGoxOkLY4wY8?=
 =?us-ascii?Q?iq5dajcNVkevJJcISSFp4FruSndAR+eypky5fCCCJ5QY8wC2g2mnJlOcfgHj?=
 =?us-ascii?Q?v7dboqwGYT6Va3dY+vKSUXO3Avb2whYstRFX4qxMHpsFZhENL/pM6jzn6uRO?=
 =?us-ascii?Q?WwFrdTtW5EO/mVtduju+hu9Vg6z/nA9kigiF9EK5IA+p9nezgm3ep5/p+z8l?=
 =?us-ascii?Q?9kN6G2eio0i/5b9YXvwXlAyLRSN3j6CI6eSPPDJBTu5vBT6TxrjMuIDZ62xr?=
 =?us-ascii?Q?EDkjyFYPrXM7QKtKQ4Ry6RoSu0bDQI8L/9LixTfEgrNQr+17q5L26fqZWd1b?=
 =?us-ascii?Q?dVoB7xn4lOl+obdRV0KNSemmUbTUcjVMvRxmpmaK4+qbZKsSOBNRb4KzojIM?=
 =?us-ascii?Q?0d/1Uz5CGVkMD8w1ZnVdQBOPWV4YErH3Ke6svvXzr?=
X-Microsoft-Antispam-Message-Info: 0YpEoiC7h5A863v57Xn4aq21fg5BbFf1KjfyiEvJC+s1Xk9ncHsN56WqVrniQxbIaRHdGNPjdIs1+0r8RJaUAO+PdgbXjfeHod+xZ20tN4vVOra5ylwdnn88OSdOpHrxM3wskdIThz1TzCvm5YW5gn38kmL9Vt4+CU7MejTn+zxWeP2RvhtWN/tBBDQTPI++UiucK4QhgAt9e9WTPGb81YOKTQ8k6TnedKOb5izAnalgpbecR4GqgQcPj4g8jnlpAVENijFUcTTd3kuKYSXHaAiGbwoWXWNmJqf9uaF3unsKWY6l9jThyQM8MLE6oGtNabY62uFp6RQjVirk2gSnCQcxCmUyVciMna+4LPcfM7g=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:svUglcy/b34VFBbOijHxJYl69498fJv/zk+LvSIqHKuRflm+zJxMnU6uKwDUsJ6Ozb2kaI0yvUP97XCstiBskpIIGGcg0s3plcEq4QYXQF8eQnwRbChbw06VKW86jtz128En7hN8geI7NuiDo2/bT8NjxeVqNu8ocCFiy/cH/17yUXNXsb8sUAz7ZABuG6F/4ljbQa5Dl4bNSSU5lE2oLV5/8xYddM/f5P/ABjB/ixd8MlcADQttYrGiD7Gr8/BsTK4eBkn/91pO9PJT9XsGsLCtk9+PdsK89uWGgMjvygAy3r21/knr7ljMrTn7vMuk01kGuRjL/yogXDwTIpavzGu1kj7UKCN9z+IZojDmx5IQVguXhG9OTWl2yUHDnGaUc3/xbcPsmKUVJLnbPCogZuPsydWJcATlXpwJ/pOMNcofe4R0C32sgFpx1NyrIY+g6/UcAGkK6TzwcYcLCbN+Ug==;5:Pv8p38i2wnSottsWR7TOiVCxOJoQBfWRQwDvNp4JqEIS/GSpraEMy1iXoNmpjlkTNbJQM9tbVnk8r4QYFwdM9/PU7Yw66PcGQ/ej64497vbrKRehKrIov9B5JvNqi2pH1yYqMfBkMU5I4QSwzcdxuIWXiB/ysTVYoJjovX6HAow=;7:YVSVHCLr4ZDYYJ9u3U5WMkyN32p/MgWIM48dWILvvvpNtoHYCh32iTPdbHP8v5ibQj3LiFah9WUD8Ljlg2vwcsFHbB7Dw7nd/LZxuJFqux68OpTaLJD9A3+SWLfR4WGXam2bVNp3ngFcMrMaRzYu2DF/530ORJm7UtHkRWGs5LimsrCy0Ih3TeD3FTcgLrgb8X73Uxj+6ubgZG0brVr5FOE4M+WMMKsdWAeDgoZyakaYB/Y9Qnu9kPgqG1Ba140o
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 07:58:33.7603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edd7ae7-7bc4-4972-b774-08d60f1790c4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6Q has MMDC0 ipg clock in CCM CCGR, add it into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6q.c               | 1 +
 include/dt-bindings/clock/imx6qdl-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8c7c2fc..bbe0c60 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -789,6 +789,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "axi",               base + 0x74, 18);
 	clk[IMX6QDL_CLK_MMDC_CH0_AXI] = imx_clk_gate2_flags("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20, CLK_IS_CRITICAL);
 	clk[IMX6QDL_CLK_MMDC_CH1_AXI] = imx_clk_gate2("mmdc_ch1_axi",  "mmdc_ch1_axi_podf", base + 0x74, 22);
+	clk[IMX6QDL_CLK_MMDC_P0_IPG]  = imx_clk_gate2_flags("mmdc_p0_ipg",   "ipg",         base + 0x74, 24, CLK_IS_CRITICAL);
 	clk[IMX6QDL_CLK_OCRAM]        = imx_clk_gate2("ocram",         "ahb",               base + 0x74, 28);
 	clk[IMX6QDL_CLK_OPENVG_AXI]   = imx_clk_gate2("openvg_axi",    "axi",               base + 0x74, 30);
 	clk[IMX6QDL_CLK_PCIE_AXI]     = imx_clk_gate2("pcie_axi",      "pcie_axi_sel",      base + 0x78, 0);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 7ad171b..87b068f 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -273,6 +273,7 @@
 #define IMX6QDL_CLK_MLB_PODF			260
 #define IMX6QDL_CLK_EPIT1			261
 #define IMX6QDL_CLK_EPIT2			262
-#define IMX6QDL_CLK_END				263
+#define IMX6QDL_CLK_MMDC_P0_IPG			263
+#define IMX6QDL_CLK_END				264
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
2.7.4

