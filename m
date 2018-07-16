Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA296ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5896F20856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qC8D/sHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5896F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeGPGhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:37:04 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:61408
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727214AbeGPGhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NPU6WiVC+bdOj/JP/XYi0iDzN9dwpdGdD+GeTFlp9I=;
 b=qC8D/sHHGufJgz6riCrIQ7cSLkmTjX9V3g8S0LMk1Mcrq29t8JtkSATFBMdd2GyuH2/uq3i5/EqgoNFb8KNdaCvKqbcPMzb7ceKwteqMnFAbO8SVXf2xQwl+4GjvSJepPISn583QLxS8cdaAcWk6lQucQTtjpJhvTiD+GdPlQD4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1326.eurprd04.prod.outlook.com (2a01:111:e400:5187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Mon, 16 Jul
 2018 06:11:08 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] gpio: mxc: add power management support
Date:   Mon, 16 Jul 2018 14:06:26 +0800
Message-Id: <1531721186-19417-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:2e::34) To VI1PR04MB1326.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66e342ba-eb54-4e07-3e6c-08d5eae2eca4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1326;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;3:HmQAew/lXLtTCppVtkR+CK9trhNEmOYq90x+5Iac1yFeQXe9JiL/AzZUARlrHdf2SGjrPMErTF9mduMoctY0SDUlWuoyTK7dlr5AldY/sKcO6LrxMCLp9xBGAI7fhjQIaPbPO+82Z8lkpgwlwpMr6iAiCV23o/ip3l99/RYSVMKDs1KDLckxEqF8cYcRel2Kh60Pkimi3EFEepwr2uEEI0BML9BObz55CJHaNl0FBg8jN4tUHth7QhMXEX/C2XyV;25:djB+dD0Q1VugXiBkbJPUTd/7uHmjDi6ZGfluW4mPboFruwZiiQOQcdyRixD7Gjkmux2F/i7uvyyRW1KnHJ8l1uNcSLP6abzzayYznY0bLNueI6lMU4qt0nVtRFIB9tR7SWrwOFhXcNRNEfRVUF/DKo4A5LJwNqDpAA058JUBtnPfIDit4zdCYm075WXiSO9LzpQnwptnJW1SUY0iKBkcbTxGXJmaUUAzMr4QHxkU2Nbt7tKzZ+L/oddoDM6cFT/fjJKB3j7UiBkk0RuoctMi2vpAiCabffkwROwILESQCpYEDj6SiXtvfl9pswPf/kbivCWBXdeDhVkhLDkklZe/bA==;31:+thICnhaQNZY/aHbmUpWbLd3MaApY0sVb1RCySr9JaASmsPalTQRH5vM8pB7hi52+7jtfOntSCj0wkdSjgCj11NARNSVfVTQGkWXEPaxqPMjkuzPOSNeGM6KsK6WZG6UI8/pRZr8Pg5OEWwaMRUnSALNMSVy9vdKMwiA+TnQ5MPG8cyYB0IZ7IhFylVdmpPiA8ArXzYjkixgG7b0bVAQq2C3QCqiprsn7fMnvPy7Y80=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1326:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;20:pmNBQ8KCZ5WfbED5Ln0wD7/xnSvQjMN2QzYlX5qPQVvxtC50oCJkEH81WtJJDXwWoRq56dnf9uMdeBuFwlX03dIX0uQQ5Fy6kGqAc9eXAWzak1Md9G7+KO8cdKDtvsV09fF+nkktedMuDANP6sejYJiAcCCsYi8WonqIebvLv581CKJR9g1vHg+r6+UgyNnGTTzhYn73f3EV4IiM0ONEzTFSW0niZHluDrE2UvKes/dgw78L2Sr10qLA0h8/dkJQkiwiR5Dz5BfGnMAsCp0cBAKMIcuOxwaFLhSHuApQUIyW/vaO191RLU+4jZLCpLTI/DhS4straZgIc6UBVMODQhYPKjfwJkbkgLE5Fr/r8VL1tRs0N4vwFPqqS7N6E3Qe2aNjIB3FP3vfxdpUgYlMpVxNW6x4pz/dxcFxlBVRC75Q5mTNIlL8pxO03q902r9N3ShqyY78Gj4ZrlVO8NJv2kuFCGn1aemPlk5TA9uIqeu/zouTnaC3Frnj9s/CLuEn;4:SmDa5iKeDdxbQyOsTIobkkBoJ8Eq+Yy5gmCfOe7IRjM3KOUBrY0uDaQwaERrsCvPtjhucZVAYXno+hHR9bEJgE1BrqGIy2e23use0cG7lphWa4H2EPHGgU6Qv164CLcgIdphaKHgRCS5cAfW30tsZWeDYoDkJlzV1QPpAUOcgnb6fcNT01YpgyhU1xC63KYnq0y1FI8CWod0EYHS/qDG0Mu0V/QZIByOABoSME0tN98oiCBqULEE4a6CbDc5DHq2HrdxHM1BHqn3snVbfivXjvqD5bS3khU/ta3nK5pbOfY8eRRo612yHVyrsyI3+VWz
X-Microsoft-Antispam-PRVS: <VI1PR04MB13262C573803BDBB30A09541F55D0@VI1PR04MB1326.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1326;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1326;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(48376002)(6486002)(14444005)(66066001)(50466002)(53936002)(6512007)(4326008)(47776003)(25786009)(36756003)(486006)(956004)(7736002)(2906002)(6116002)(3846002)(8676002)(305945005)(478600001)(476003)(26005)(316002)(6506007)(186003)(16526019)(50226002)(386003)(68736007)(16586007)(51416003)(52116002)(2616005)(5660300001)(97736004)(81156014)(6666003)(106356001)(86362001)(81166006)(8936002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1326;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1326;23:kvSdKW11QD9tXKRnb+CAyIpqUMo9wPmuv5N4pNtJj?=
 =?us-ascii?Q?sCC4HEpZ2lSF5gq6ujBEgBiCEjiB8MwBlmare5WOaUxmk//y3XGgxdeu5Od6?=
 =?us-ascii?Q?jXbiEEyT21ZNl/vdpdrpXwQCR1kf2y6CAjJxujS8ct0cyra1neZWn+63zCBb?=
 =?us-ascii?Q?4ky3YPpPAJSmaFKz9MODKkOpshufhZHM4cWRTzm4IwoBNOxn+7wuRMUEPJn4?=
 =?us-ascii?Q?QhOkR/9QrBTHY1NiQdTYByeG3tqQyFVQJLOexWxQgBq0gbhIzO6ldkfrawCt?=
 =?us-ascii?Q?NELtyGge5tVdZ0qUk1xtJxEp66RpF1trdb5BukhNgd3BjoRO/YnQth5YZ9QN?=
 =?us-ascii?Q?BnbXzNSCTmlP9coJQUvYjpAsBJwtw7krkGAbL2sfDwbHZukIlzXojjB66uaT?=
 =?us-ascii?Q?eYxty6NNpOVURP1VfIAuEULLFC0tn3Z2xPQzAnz7RKpZ8N++f/8OTJEf2zeR?=
 =?us-ascii?Q?WKDjhr3PPyZQygRzkE0zgsV6/IisCpjrr/UM8neEuO/KQOywrI6XcbTboOdB?=
 =?us-ascii?Q?uDlI2icsO5XwRxGaw86Rk7GWecf7tZ4lqj8aNqNVyMtY6xdGGYoTrIWOZI11?=
 =?us-ascii?Q?u8Fzvc115gGEXExoJUiTh4+/yNuUhdGG6QbhTjIRgi1szTTLvhTnD5/8QiqN?=
 =?us-ascii?Q?B0TwARdkzdFHKDqdceG9MIefQ/AWOH7sYjPY7BcQ5TLjjSuedqeLELYomB0S?=
 =?us-ascii?Q?vsxdr9fz0zCiRxS3uvRzQPxf0j/9JgVBrWkCtQeKng+JyVCUR28IVKQ458no?=
 =?us-ascii?Q?HQ4gajrPToksL6GRb6WQJEUIJXE7OME2HcGPhlq50wBAb3wpI1kgilW55V/0?=
 =?us-ascii?Q?lrDvMAZecL6JNjE/nZnJWrlgmV5s6QQYs73NrPt6bAsJcMwQSoWiuo5eLWZw?=
 =?us-ascii?Q?I7jC9dPlHJk02vAiHYRvHZZsMcp6AQxCzHVbCNcPYxx9PATyBm0DMl01ecdS?=
 =?us-ascii?Q?/ET5J7kP99nLZyroUW3xOp76M76LpRVQhgF9MOSvcUfaQpBqEfysgQzSpcjs?=
 =?us-ascii?Q?/0UcYfMCDnFHGwey+lsKPZKR9/GKeG2MrqtsUvGLSdALnPxFAIOqV8BI4+6D?=
 =?us-ascii?Q?88tt8rMS4BjDgKVfWuD1PSBTytmz70Y5lyVauUa8V42I8olKM+2KS3ZfDizF?=
 =?us-ascii?Q?iVyi2RW4L8=3D?=
X-Microsoft-Antispam-Message-Info: 5gg8AyTjznLeGeowfGnNAh/M6jOABB8FsgZcK762QxvZ3KQX4u3cYp4QaQsT7E/gyUfk7AqTvJZNu1T4RoTXiwOM87mquDGDHJUQS6wasoNkqimibzRLg4HZOQtg7MhQ1bRumLdIDC5NONmiaNpyMAeTm1DiQETEcx1OiIwkKy5ORHvrG9+xpIYPjYiHd3EY2V/i2t2nj6gfQfKvLyXRVm5cPHHUEfAk6FUG89e4SE3mnhJWAEip8wvPzdvllWXciWmdSiXlnQIcmxaZE3qC/UcSUGRXamalqlWtJWrZVIi0zJSxFdXHIKPxLD80p3tEuV92J9Sw3y4XzAhw7Eal2w==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;6:Glf/vqo5CjcLQTeXxJQ62bpqj5hnxIVSThAAYSJUTfuHCAxzDECzGkI4yoF86TJ/EWD5VOW0BnQqeRlmgahp8k0PHHVR1VCoc1gJ3cwzRMYtyBCuHh9WdDL9pVBUYEDO41etQgVYqJ1MG61DngxpMz218h0FiPoqLMIhvoKRffQ89Te9KN+BY+HSVwtelQL9HxwsJw7mUUrMwKx4A+70JJbp4pBOZFyCc1KRApETuBPK1T9LzIOXZMdwFpW32qaseTUuJr1fJHgKDFXAnjZooSHtp/YhLCMxxBRRu6dXY2H/Cc62sR3Enwn48roeULL/AggAMPVlM+0FyPB6Yp5wffaMc3aTTB+RaE34cv6H/IE1h2iKXWD9M5qdcmE/liYC/0JFdmEvJe9XiTemhLCv1fVZAs8zbX/Lt9uuL+WhVP8wyeARUDhqzyDOym+VJVNTOhR3rxGbmy7GM2WGYd5r1Q==;5:AS9Pf6geD6IklqRTSjEmsZSiAPiFWmAU/thzb9ynotOzOlLuXaA3a5PJuHpmT+IXAIpvnR+Cs3iLeNgxbtuMSKCpjfPMAXsYibF25CwSwaJGNHFyKf7ET1ctUJRPkIFMDVuk9f8LU2EMmIG090AuXVAro5CKfos4HG3MZRtCfyM=;24:GPq3fiMjXMHTNWqkUrWo2glFgGqlCere93czSuTUJDi11NdiurVOXUMQ8OBCyGTIT+flbBMJZ7aWrx4QOaBJ8cw6DTvIHIEtTode0PZPyxk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;7:tRqXZm+3O2RgzF6xwt/gCgOiCxwGyL1Tw9wrrVbUN4T0kLhWRQ0fcHgMU45xW4quyDAMTyf39xDnToJpy2HE8sot8hx5k58sM1KsWXLrozI8tO3A5sAZiRjUTgax0bYbKM7braml3R4lZSzu6D8G9DmHQcz0CzUu8VXBjjULEkufXwrnt7F5PVp2jXoMN/ydxwB8gYgySt62Z3KmKzoIe8oXiGNPTYHN9mx8MhEXoPlB+tXlLsEhPQ/tX/SHj0S7
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 06:11:08.0954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e342ba-eb54-4e07-3e6c-08d5eae2eca4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO registers could lose context on i.MX7D,
when enter LPSR mode, the whole SoC will be
powered off except LPSR domain, GPIO banks
will lose context in this case, need to restore
the context after resume from LPSR mode.

This patch adds GPIO save/restore for those necessary
registers, and put the save/restore operations in noirq
suspend/resume phase, since GPIO is fundamental module
which could be used by other peripherals' resume phase.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	Add condition check to make it only work for i.MX7D which GPIO might lost power.
 drivers/gpio/gpio-mxc.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 2f28299..17f2fe2 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -45,6 +45,15 @@ struct mxc_gpio_hwdata {
 	unsigned fall_edge;
 };
 
+struct mxc_gpio_reg_saved {
+	u32 icr1;
+	u32 icr2;
+	u32 imr;
+	u32 gdir;
+	u32 edge_sel;
+	u32 dr;
+};
+
 struct mxc_gpio_port {
 	struct list_head node;
 	void __iomem *base;
@@ -55,6 +64,8 @@ struct mxc_gpio_port {
 	struct gpio_chip gc;
 	struct device *dev;
 	u32 both_edges;
+	struct mxc_gpio_reg_saved gpio_saved_reg;
+	bool support_power_off;
 };
 
 static struct mxc_gpio_hwdata imx1_imx21_gpio_hwdata = {
@@ -434,6 +445,9 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	if (of_machine_is_compatible("fsl,imx7d"))
+		port->support_power_off = true;
+
 	/* disable the interrupt and clear the status */
 	writel(0, port->base + GPIO_IMR);
 	writel(~0, port->base + GPIO_ISR);
@@ -497,6 +511,8 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 
 	list_add_tail(&port->node, &mxc_gpio_ports);
 
+	platform_set_drvdata(pdev, port);
+
 	return 0;
 
 out_irqdomain_remove:
@@ -507,11 +523,67 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	return err;
 }
 
+static void mxc_gpio_save_regs(struct mxc_gpio_port *port)
+{
+	if (!port->support_power_off)
+		return;
+
+	port->gpio_saved_reg.icr1 = readl(port->base + GPIO_ICR1);
+	port->gpio_saved_reg.icr2 = readl(port->base + GPIO_ICR2);
+	port->gpio_saved_reg.imr = readl(port->base + GPIO_IMR);
+	port->gpio_saved_reg.gdir = readl(port->base + GPIO_GDIR);
+	port->gpio_saved_reg.edge_sel = readl(port->base + GPIO_EDGE_SEL);
+	port->gpio_saved_reg.dr = readl(port->base + GPIO_DR);
+}
+
+static void mxc_gpio_restore_regs(struct mxc_gpio_port *port)
+{
+	if (!port->support_power_off)
+		return;
+
+	writel(port->gpio_saved_reg.icr1, port->base + GPIO_ICR1);
+	writel(port->gpio_saved_reg.icr2, port->base + GPIO_ICR2);
+	writel(port->gpio_saved_reg.imr, port->base + GPIO_IMR);
+	writel(port->gpio_saved_reg.gdir, port->base + GPIO_GDIR);
+	writel(port->gpio_saved_reg.edge_sel, port->base + GPIO_EDGE_SEL);
+	writel(port->gpio_saved_reg.dr, port->base + GPIO_DR);
+}
+
+static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
+
+	mxc_gpio_save_regs(port);
+	clk_disable_unprepare(port->clk);
+
+	return 0;
+}
+
+static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_prepare_enable(port->clk);
+	if (ret)
+		return ret;
+	mxc_gpio_restore_regs(port);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mxc_gpio_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
+};
+
 static struct platform_driver mxc_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-mxc",
 		.of_match_table = mxc_gpio_dt_ids,
 		.suppress_bind_attrs = true,
+		.pm = &mxc_gpio_dev_pm_ops,
 	},
 	.probe		= mxc_gpio_probe,
 	.id_table	= mxc_gpio_devtype,
-- 
2.7.4

