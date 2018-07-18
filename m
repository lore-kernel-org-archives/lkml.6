Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4226ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F592075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xb/nV3Lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F592075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbeGRCFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:05:49 -0400
Received: from mail-he1eur01on0041.outbound.protection.outlook.com ([104.47.0.41]:20259
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730614AbeGRCFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JHB/EBVDaLF+AxMnYRzghSvHKlABGjQY9G0EIR9a6U=;
 b=xb/nV3LbhNkKrlEjPDfi7jUZ40HIYl8/kmt2HbcTb0G2G2k/g3ELj1hHtqUFbVPNo7HEvkTq8D2hQsXS9riaJ3j/O1agMGrRZyr80sw2MoAlNYwcb5rr8va2/Yl7pcxAiNQA7JKLegauDmm3LIlJlkl5QpndFqgFvDUDTIpJpBc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1327.eurprd04.prod.outlook.com (2a01:111:e400:5187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Wed, 18 Jul
 2018 01:30:18 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     Linux-imx@nxp.com, fabio.estevam@nxp.com
Subject: [PATCH V3] gpio: mxc: add power management support
Date:   Wed, 18 Jul 2018 09:25:32 +0800
Message-Id: <1531877132-14280-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57a6d3f9-e0d8-4165-f933-08d5ec4e0633
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:avv1l4V7IF38tKlKV15IjnFfxGCGORuu2INo4YfRp7TgOBY/CQdrbP3S59ziNJJNK8JSVp0dCzY6pMqA/QLIq6OIJG5bTIARGDov4pRbHYCwdtcFlWKlyEnE+mz4T25WuE0pCnfV8YAIBzja0wjLFQff5InEZ1s+XOWq5uaZwMSEPxZlPHBFcu1yAyJGq9kcMSNhNZKaDa6ZRTgbpaUgIYL2DTBNlwDjlSXvGkWvZyE0OAv7u+noNSYCjjPF2S/p;25:EJtvC868vo5e8k0fsDsfW/Mpl2FQCOkcv5jlo5U2wFQcYBDSTUwdZMbcngm8Gk1LsJTVRCWxyYNT/Lyiagr4csrcAV5CAo5vWqGo2wUA81nqcMCy20ICxq0Kb6k4AeX3H3aqkYyXqzLUnojMsQDaoPjaRQj7oUWokOjL1NQyf+fQCI0REqZEVHeJV67XAoj+asu/Dxt6LteecdlMrOa9324kor5Rqvb4NXoasLhveU8QMRDAusaLQ7qBVA7Y0pkz5UTpwkq9DoPv7Q7x91duWKqLZLUyZIRJlYcYS/PtuRpIDcWcjmENutR29sgIuFLxBeuLSkl9B2Evh6CehMX+6w==;31:IivkSM8ECXzmeErpk1hIuh4zfKiUbOg/r2f/xxmyYtlMVYTejVAEPhZs2orFaTnka2oo78oHRVKUopPCKuJtJb3ckfGOPKzt1Z+/r9ki6DXNutENdovS6PY3h05b2lgio4yZRNS6PVCz3PM4Vw0CZs6dhUv41fIR6D1KdkR8zOFygSZx04ThbuDk70FaF4QcUH5v8HOHinjgYNw88YAvGTStYMXjEgyetI8UPypPAJ4=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:eRvMoL3imgNExSSX+HK8+h3Rlswf+9pu3yJymXKiMgqACoS/DbZHAkg8XqjoRSy/GK92+MzxXCAPTLPHQWjBxMJy5iq71QZPdC0ztVZYrerEwlNt75aSN7WyHZ9NOhuWmkLgCgw46aGIUX3YhDXwPV+ezPZ79a1Gux/HK2RHJvMVplHGgEwRYpBvekMl5xMyB2KAwBCfSX2Vf7MnSY8ft+XZMPV3yV8QppJGBmS4tQsxKCyvM7VNLSiS3fktEULJ9FLBmhGndEvQQKdq//xsNKj00F1Zp2m5i7JM7gqXidEN310Mrt/DQfWahEGyRVIi6B77qupQ28oMMX7cxd93XQ4CE9HHauBEAdxKqZPMR/AWRsBtK9bh2LeYm2CxNtfqpdg+Vw0/2RYsJlrdR9rqNOAqVylI5GVyI5TkZWHOktwd4mmT3sOBWRUj2L8+yJuhkwoVPqEQuvq3aGu2Gn5oRmiBYRnNlFwrhAitQQqvLpaEIezMgdSnk5uQfNoTtL6z;4:H9omAlekJLpn79hOfGw3NPQbfTBL25tJ1w1Vd9BfvUeCfDZMlXQNvBKBQlRBH86OoNfjDwOs+m5W8n9QdmdhTQxAW5RtFboJtK/9EzJEiUhRIUQMdR5ODAZA7ohmHq1GL9n6i8vNHvIlK/rD6rV8iA3irxEB27qdijdTfY66b3UXkTDdvegNWnLd/Gt27aY4SZIEOTN0GB19IIMiCaFS9IaMUd3zyOHhglC7NWKw5nN4mbyFbjdhgOkT9X6+Qr5RrH13v01nyqdgMVZ4pd8rkPrJxuhgOIu8wHmBTavum72WnW/wkhZUfUAJwTqKILm4
X-Microsoft-Antispam-PRVS: <VI1PR04MB13272BDFFDDE83DBC2547698F5530@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(50466002)(26005)(16586007)(14444005)(6666003)(6512007)(6116002)(3846002)(25786009)(4326008)(36756003)(53936002)(486006)(386003)(316002)(7736002)(6506007)(5660300001)(2906002)(50226002)(68736007)(575784001)(48376002)(86362001)(305945005)(105586002)(97736004)(47776003)(8676002)(476003)(478600001)(106356001)(186003)(6486002)(2616005)(8936002)(16526019)(81156014)(66066001)(51416003)(81166006)(52116002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:sRsWtyccfZ/grqfB/6DJBGiY8uQp7HtL6WO8u+uEa?=
 =?us-ascii?Q?IY+q9co/ygC3I0OqEEV7cWgEpbfB4iRG9pf91EZKqzR7FAkF01A5O1bRkk5E?=
 =?us-ascii?Q?OGBgNLeGQvOoSsfqJ0Vp1JXvOP/e0UHg0x0kupTnLT9tRKAxgyVe0N7gFfJd?=
 =?us-ascii?Q?4f7180gRImALKNmvx3Formoh2eF1Wjh4LdfqJQ75tPHM/BGwf+1JX7uhH6QG?=
 =?us-ascii?Q?Q2YMIY0WuXyZANCaWyOxKUs3IsHUbr1Jo5Wagk0p2xbJnWQ7PhRmQTZlz2Tw?=
 =?us-ascii?Q?wtMiqUwvVNE7h2jygBWxti48YsE1+zIWls9NdnxvlUH9pBrdEaL9SMUKdC+4?=
 =?us-ascii?Q?s5pLYrIGnfCmSD2EvtBx6v+TEftlSxYv/gJrIrL7N31L4wLWjj4gDn6j8CWK?=
 =?us-ascii?Q?grco0h21iIdacu2mtOQq5oa3ULWG/aEgJ6+r5dHHFyERJSX/Ghl64Zwlk8CH?=
 =?us-ascii?Q?RWBu9jUeQ5WomFsrrWXnkgv+MmvYMKbUrsUpm2mBHUb+40S2dKqdGaF+aOY4?=
 =?us-ascii?Q?CYAusUhditDBFZBIw11gK6k99pOmR23jBrTSnmhArk+5Kl7UyrcQ2PU3siRP?=
 =?us-ascii?Q?6ybAXDmMRmAnxD8sGnX8SYi4pwO5/C7KmUo/SqcFblWwIhnT1aAbDf1DXhSj?=
 =?us-ascii?Q?4wcSADbYRlbjDwFwVIK3nqSo61vgOb4VzYtF6WVIe/F4mrnZMaYj5YFNxJnb?=
 =?us-ascii?Q?xb25GxzNWi+EcoVQ+AFtOfD4X8Xut3WgGliw+s2sD79qsLV5lqGuI4NQxeBY?=
 =?us-ascii?Q?IkxsQQ+879M1KQE3ubws2zM0fKmlbbGpfqLbTGEEjXq7LlB0MfFpGivCHecE?=
 =?us-ascii?Q?ItxixFqgm+dqQIsG+rCx3WItVlN+BbIZt4Xhtuy+hrX8jjMu/ccpZ5ayhvhQ?=
 =?us-ascii?Q?BC+Mgje9luCLbkZH8dO8cTrTInk9ae4bWHo10usa1O1RdHwonBSwh4VwdJ7+?=
 =?us-ascii?Q?RdEpC3LwdWQ+Dldethb1uEIsEn7yWKcd01nb985/DAFt0WsyAz8kYX7IGL91?=
 =?us-ascii?Q?NVZjXB1xAq9LnieNZXv6gac7vf+JV3J64NcF/Cm4ph3Z0aO9psEeGFhb0DzS?=
 =?us-ascii?Q?ytDMBcw22rEluSXsotoCPiARwHdBzktT04WWe2ePqwsFyazNR1ZN3Mlaa18g?=
 =?us-ascii?Q?9Fi9hoZ3LbulNGQaSHMiuJxz2TJF9U7?=
X-Microsoft-Antispam-Message-Info: OvS5Mv1S3+T4ZclHFQAlyw2qHzd/znVwd295va4obG9RL7GRUraLgQVtwRECqJiSAusfgS7dslZv3DwEZbMJiFVNzLRS1kW+EKZLrLNf92iO+NPp0DCBHPFr3iowycPJlsQAuIhwS/48cAU95BGhOBDPjaU7jpfSZoZSL3EZJV+tBc1i8lcrSss5Ejk3hJt9fvcHPT5z568p/WQdJpLBUy2jYaoU0y9ag52l0hdQ/iGh6uzqcSRIHQ2skV7FcJSMdlBgLhjDxn8AydoVnlm8v+VkMQgJ2EmSNoWFPILc/G30Sjqm0YJjsP48pL9CCFQMUWD3fYTvFxTz1NqjwKWDMQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:enF77Ed7DtnFw7ciECC/1qlf1y46W/fVnoiZ1w4feanHD8S4GCGVCcsBVlZ2GRx+r4JeBcSKs2MmfZm5kkQwG6ySQ8Lj4eNzYZVJYZ8MK6VxW+WiWMA89ezmIbeFSc0Jzp9+k3jj/H7jUCIyt/pBB3ioyMZEpmevewmouTuuJ1jxCclpbQLzUBOdGljmR8hkFgxKmMrRRtu86Wpf9x092BMilko+gRuQI6smDcd3hJZEAbmGucauYTo3vpHPzgRF6lfz6OmQkW5RaXQY1QZeLlZadjF51Rou2f+UIkpoE3/mQsjG8loemQuE3M6k7FbQfjLP1SZpUNNKnab6D027TCUnkxvnbcSgiQfhtQth4t2v6/+qmP4xieQQgApM0WtazoeEWV9Ej3h4krRG6t+hdwDpFA/dr60PglXp2JR7+IIRmfyvALoWoFykuuWGlEhChhgNnGw4qHal54Sonvlwzw==;5:yGNfN0+W1JE0U2IWDpOpUCNQk9q35umMccVeNCKen8N3u5E8mqV8Cfbwe2Alc8vuvChRBUMC9FTwWd4D41aYSEi3Kj5LLtaM5sd4/K4vxlXXQg+X3cR/xjQ0wd4abtIdRlBeQADVBpzbuLIBWdwR8p/OVVepfvdBJkdvMQtHAmc=;7:HUnkME6PYIR1AON6LAXfGnUqTLsZNDxCNuDjvgFpvY6rS83Sk4jEqeIYK9SO+IOpbM7xdtwW9NaEN9OpPZhqjpYb8Fxi5O8/LP+Aqrbza+xAaQPsjOyzK/liTGg1sVkB8rM+CO8PDCxED/5vcuhOdseY2fHksBmCeFfN+wdftKDtTI6f26112ImMu8WRKOCjoftKYGtw7x9oNxXgaH5XDkerGIVpoXRyGBMhPzCLZQ4mr6Ha/hguLPE10yQDMmCO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 01:30:18.0460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a6d3f9-e0d8-4165-f933-08d5ec4e0633
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO registers could lose context on i.MX7D, when
enter LPSR mode, the whole SoC will be powered off
except LPSR domain, GPIO banks will lose context
in this case, need to restore the context after
resume from LPSR mode.

This patch adds new compatible string for i.MX7D
which supports GPIO power off feature in suspend,
and adds the GPIO save/restore operations in noirq
suspend/resume phase, since GPIO is fundamental
module which could be used by other peripherals'
resume phase.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	Add compatible string for i.MX7D GPIO using i.MX35 type GPIO data, but
supporting power off feature in suspend.
 drivers/gpio/gpio-mxc.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 2f28299..995cf0b 100644
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
+	bool power_off;
 };
 
 static struct mxc_gpio_hwdata imx1_imx21_gpio_hwdata = {
@@ -143,6 +154,7 @@ static const struct of_device_id mxc_gpio_dt_ids[] = {
 	{ .compatible = "fsl,imx21-gpio", .data = &mxc_gpio_devtype[IMX21_GPIO], },
 	{ .compatible = "fsl,imx31-gpio", .data = &mxc_gpio_devtype[IMX31_GPIO], },
 	{ .compatible = "fsl,imx35-gpio", .data = &mxc_gpio_devtype[IMX35_GPIO], },
+	{ .compatible = "fsl,imx7d-gpio", .data = &mxc_gpio_devtype[IMX35_GPIO], },
 	{ /* sentinel */ }
 };
 
@@ -434,6 +446,9 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	if (of_device_is_compatible(np, "fsl,imx7d-gpio"))
+		port->power_off = true;
+
 	/* disable the interrupt and clear the status */
 	writel(0, port->base + GPIO_IMR);
 	writel(~0, port->base + GPIO_ISR);
@@ -497,6 +512,8 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 
 	list_add_tail(&port->node, &mxc_gpio_ports);
 
+	platform_set_drvdata(pdev, port);
+
 	return 0;
 
 out_irqdomain_remove:
@@ -507,11 +524,67 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	return err;
 }
 
+static void mxc_gpio_save_regs(struct mxc_gpio_port *port)
+{
+	if (!port->power_off)
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
+	if (!port->power_off)
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

