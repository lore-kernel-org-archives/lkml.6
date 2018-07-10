Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2EEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613F720878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WEauiOI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613F720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeGJHxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:53:19 -0400
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:30408
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751061AbeGJHxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FtI+NGi8k3sVzLELP6yNv0P7D3bvyb1rdfo6vuKAhg=;
 b=WEauiOI14FiDbOwdSfTq/kYJCIFsc+7yodaRXsqAeCO4jX7vRrEeHPO5vVIo6Hs4WWal7JAjHYfwDDVJRa6/ckym0yYaW6Z86J/6z+bu4/2joViKbMcIBoQVXH/XheUHowVs5CwUFyuh/Ye5SSy7mZDyIxPAtjtHMZRoRBIDL7U=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1319.eurprd04.prod.outlook.com (2a01:111:e400:51cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Tue, 10 Jul
 2018 07:53:12 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] gpio: mxc: add power management support
Date:   Tue, 10 Jul 2018 15:48:41 +0800
Message-Id: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:2e::34) To DB5PR04MB1319.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d9172c-9240-43b6-beb9-08d5e63a309a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;3:vr4e8AlTrVhOPPMK6Eb5YD/JUPRLsSzA6hf72lYe3DrgonpCZoFB+vvJOt277NdFepZPO+CdPA8MMRTUWkSQZHI4HJiVhMrGC2aW4t+Ci6z1GDx85pw+SPIl2x/DlGvwaEy1yRSd7ToioSPomX2n93DShW+E0p8PHDVjb0PShO0mr+5EjNcRWpV/97NO3wuYvpNdXhuethn0ns+eAsKO75KLa6JbeuKWSFUwZpA5osmKokj9AbPeMQIOk2nlQ4q+;25:dK1U0hBI0Nzj0G343Wuxf3ZiOpq5ggzfi2NwfXAd0+CkJJqiL0O4sRcZNpSMCYrFY/gM+x1LFdhgVRt3cEsOvXtFzm8rG4PI8I9RSMtk6DjS+Lem0Dfql7qfsxYdU8ROf/nLOcyH2Is2skE34TWXtCyO3tE2truHW8WOS2w1p4LnM8KG5O+f0TcFI80RuCZEjLkRbK1uEPyK7j8hVbhWWieMbCBrrV1esxyvQLWn1Xu5YPGBEd/iP096KJ4gvODWfYec2sI7aqXfyjd57YOe1Ykh5rxP2KbMzHf8nKgxEWlIK0g1Vh0yXEgqmyohfV1BOFlANPuvCqW91t5Im4AtHw==;31:jkmQubsp3CBfH5FhhDwEhWKpi5lYc/hcETGSbF+fIunuoMP037znzwa9d4yKqYJd1L6E5BE5fg3GALsWD4D5BM7p5dd2IgJLIs4TKH8nPT+gBH5jw7m4Vlc2rNLn5Di0ja+kCR64uA+dWMoDU3CohxY7ce2Qv6JFkPIqEr0a4nowH9u4JTRtoQ4tm7V5MLfVRJ+k7UCW0LR0pzdGUWqPeMC4P7G0WkMdwMhaLgtN6Wc=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1319:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;20:V6onL0AAOPuKNX9KyCFL+8iSuU+UwSOm0LUu0VnlQJtwlZkAImHz66iFtjJcopJtZoab0FmZ6xCbl2WxKJ2NwDGgBa56VzNhkimbSUfRjpVNFFvzABJUSxZDhVyCEmvT1ZNllAt5lknQM7JuU/IRqfEgeZ8iWxz0NDSwI7c9RunN+QnjLaeX2gI06VQ+9+LyW4kWZ19HXTogK1cqUBGgtkc6NdLlaxwnRrzLx3r359lSVGdw5CSdzm4EDjX/GK4tEHqJZbuJHYp0JCeuX+7RjnbTuKWtVcRjjQXlgPW0spXHfSOS8++8Z5nCvp1fXHtAFIuMhEqpvu5npWnJCjUDbe7tyaIMlkNkJHxwmHa2jifB7a0+nX9g9K92bLfeatyDyf7bnvyZ0bIWpMijg6c65LU2a0WpoKbkapdS2MBQ+7TNqUl9hJhG0v0ClH5D3Xr03Z9Cj1Q1bn0+MLdEhK1AJrsCjqIiyn67KRqN4ZfyBL1PlAwGWOcdRbjpTk6n4uj+;4:ez3hXLIO9H+/vUsZfdKsiqZ37Rt/Xdj8nPv5nMUMcE3nYso3vdxg2/JD6zYwBxZhdYV8rhS+nOA/Q+cVC60y2NZSjpoV3zAeW7dq1XEupMxPJvSatKfGzYMwiiaivH1nBusVFiUfvFe+BhIKlhQ2V58qNaRpKtFwmdM3n2NUbfbYdvl07pXEvnl0RDGif1f08hwcwqC/Cm0aXoYrM2LjUlIib37Ek3ZXaIsRVWXl/YPM1RBUoPvJjsD9u06kQpWndr12FVvq7iNXzS/o2tOLPjuCqjZXRVMpzEw9IrFn1L9XSh9lzWDV5MyHDDtbaTE8
X-Microsoft-Antispam-PRVS: <DB5PR04MB1319601218B584FD208D74BCF55B0@DB5PR04MB1319.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1319;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(386003)(476003)(14444005)(53936002)(486006)(3846002)(2616005)(8936002)(478600001)(6116002)(1857600001)(26005)(6506007)(16526019)(186003)(36756003)(6512007)(956004)(81166006)(86362001)(97736004)(305945005)(52116002)(4326008)(316002)(51416003)(6486002)(105586002)(68736007)(5660300001)(66066001)(7736002)(2906002)(47776003)(16586007)(8676002)(48376002)(81156014)(6666003)(25786009)(106356001)(50226002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1319;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1319;23:zUxzUGM6LoZJTwc/XkE8IkTW0ELIYvNXcJvQEkaI9?=
 =?us-ascii?Q?cxoBUvDKOVBEvW1USHAfETBTUdcjt9az87S9oSUZkGbSDMny4jU8mqrBbT6T?=
 =?us-ascii?Q?motNrh4g/FoHdBcItJ8lhr8eYK3weS31yIwN7MEOS/ktqmEcGKGsoPKkXnqn?=
 =?us-ascii?Q?eQ8EgWFBx+AthZmhwGCY4ZMU+QMFA2LUX07Hss8q6Q3hhcNhIFnPsAIMvvHi?=
 =?us-ascii?Q?wXzquVapQD0bJ7+YxwVM+QhQrltLbWUgcR5S0r9v+OBT++TIjSPdz6EsrmsH?=
 =?us-ascii?Q?bF1eqjK5LsjZghLie4AEeXvMdH2URHgbEbErVT9bhVHgu+io1aP4CoqwV35d?=
 =?us-ascii?Q?ZeJYXVRJMxdc9RLCuYiGo15MImXNuTfsq/SBEYe9btGsthjQ5A1bAIxSbi1c?=
 =?us-ascii?Q?5iPTW0RNITJZETnptydzhxhBKkRD1izey6eogkYqSYUvI8cxispLJNOjuBol?=
 =?us-ascii?Q?kJeUXoWVqh+Dhemw1XGpOKgauvzIozbksG75JfqX9vZY627q2hlEXuyUrhbu?=
 =?us-ascii?Q?6d1YUnjDuZRvc2z8kOPFwviJg1ogkGdNeqDiSi5aFZiauY5hbMmnV+e9Vhwx?=
 =?us-ascii?Q?vxzSaqBzzal2AXktrtuJjn5pdd0koagNRiIGaXFUe1PoZftpyByHKwo4Wvkv?=
 =?us-ascii?Q?GE+WvxFlS+NzZdIfut647ezlbkHAcwgxVhBdwCXHpbGoTjVuOd/RJUaqDObW?=
 =?us-ascii?Q?K2gW0MQDdLxCtXmyUDDh7otXUa2kBvOz+y+nktTaYfCLLlELL47XexdVMKZg?=
 =?us-ascii?Q?qk6uCPCS84OlztOmZrjskmFKv6ps/uGrKBlFu6TLSpP8f/ELFPqa+RyLdcv0?=
 =?us-ascii?Q?F3uQMbASiA8OQab2WrqxWdwFMt3DXLXFLDxA56PBz0cpPp5h/iqEW0tP5dt4?=
 =?us-ascii?Q?9tlhMrZYW4XRvmNhPs/K8m1C3/yBrnx2hfSk85E8sWoTL5ecnP6qxeY9F5B2?=
 =?us-ascii?Q?5jfyaORQJFddxVokn3XAqZZ8ZgYW+60xvyd2CdHaUK1TMeWk8ZJAEFpRra6A?=
 =?us-ascii?Q?Yo2Hd07yXcOtJWHUku/sPL1WWoUODVHCRhp/xGezLQjjmNjttGtklbaT0Am6?=
 =?us-ascii?Q?5a5/ydHXpzoCbc5Hmfqa0xt8fCG1zSkB/tp1U9n3ns+xCAZk0nBwqxtqpu2M?=
 =?us-ascii?Q?IY4sIIGhY/Q/rRFy+TbweunTy7L66Yq?=
X-Microsoft-Antispam-Message-Info: zwoeg0sxthaFz1qlSf6JllBW+mbgUrXXdZwGqI/gsBq3F/fJIKnrNnArEhFmiir5n9DUpUVFSSNuP8xtRWAvGmnDvJ7CkPwXiU52MsP8Sf3aQ60EhgGum6rfxHjiOKe+CNw92mN3QhLAQzjY+DhBJqiVT1DmTEgu/HPsziyyxQuf1/vnsSi4YQ5g4C74VXoUgeZLE1sdozSOtLmIA5XXyOiZuS6WaD52Evqvu4CbjJV+5XRONWPjs/Fe6rVdtmuNuPC7nNlRXpwRkslLL8oKkl253HlYgjSua6YjatEguykLWbjDQsi2L6P/hvGOLYp8mX/aEQ0kdRZ2NCT9xgLAOw==
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;6:2yDU4L0WYE43dS0LP39b2HbZv1PWmgW4gMuchca4gQlCnvx6ikRcISKVKpY3euz9zsTPv3VQ+5JTdnlrMlaSIxvo/Ya4SdmE43QFGshOIMttGMwPdP3JhI/11OViiDaPGw4Ke0HJ7TRbrYa8OmpNogBEHVjpA1hpMtSKlava+juW3CLJaciZGPIN/EYfh+GAppZc8gMZcf7nJXw8Y5S4q1rDk3S3vdsOag4OSrjnK4lGWFd83tf6LhgPFAtJM8xxkj3dY8uANWHH6NaRW3rml7DMCg4y9GjlYAwkTFH7f/rppkfY33K960kl40H1L0D6vGMSpbgA1pOp/B4rcTWzpF6sbBT7AmjihoLs/CpUCitPFyfFh2hDmH7inC7fX0LRARTDxyX8BgoqPbYHP93q3Y/OYlgw7bMYYKmcJDondWHURSmZlX+7hO2mhgtKn6+tvDX9yGV306+zslxGFNE1FA==;5:beMEb/I4CW5em0qexdyI94xIeyG9QMeTjyd5E5bdrxUF+kbUZ62H6Ke8ogmt9D22iS4aRCxko71yC/mKAm605wEETVsCFKKLalB5iUz5GobyXZ3edG4Q1sLvvfqrrZS36ohz48sq931+RXE/CewB1GyA8aqSCU+TgdMMPY36FIY=;24:XTaokzjm+vI17VFrHwc4FubbTTeRr6Ds22E0QqlcBN/PANaKORfEtlooN1dhmV/1tUpkOwXAGXqb5kB9RBVc3KTz0NEbaQpXkRx9SJja5M0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;7:+Pk8b+/lA4Y9tRBkKNeDHRxrtT+nJ9bOtRfK51X1H7ikw5lygKLd6ggXr+Xv5HBVvkV9j+2gQq9cgJ8HNYkbjZC6q6Fy6jQKM+En9MTe8T6/vVBTERttW1uQUqP9BMra1QIDuhrvsjWzPxmGxBR/Zs2v1+L0Ud44MMLxTWXOuoDbnwSzjPmU6/W4oI9XFMvRr4j5niy2DpMB6XQZmny3uemaqB62W2DpRun7YDITXMyQhPOFF1K1R//9Xn2gOXrY
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 07:53:12.3318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d9172c-9240-43b6-beb9-08d5e63a309a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO registers could lose context on some i.MX SoCs,
like on i.MX7D, when enter LPSR mode, the whole SoC
will be powered off except LPSR domain, GPIO banks
will lose context in this case, need to restore
the context after resume from LPSR mode.

This patch adds GPIO save/restore for those necessary
registers, and put the save/restore operations in noirq
suspend/resume phase, since GPIO is fundamental module
which could be used by other peripherals' resume phase.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 2f28299..0fc52d8 100644
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
@@ -55,6 +64,7 @@ struct mxc_gpio_port {
 	struct gpio_chip gc;
 	struct device *dev;
 	u32 both_edges;
+	struct mxc_gpio_reg_saved gpio_saved_reg;
 };
 
 static struct mxc_gpio_hwdata imx1_imx21_gpio_hwdata = {
@@ -497,6 +507,8 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 
 	list_add_tail(&port->node, &mxc_gpio_ports);
 
+	platform_set_drvdata(pdev, port);
+
 	return 0;
 
 out_irqdomain_remove:
@@ -507,11 +519,67 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	return err;
 }
 
+static void mxc_gpio_save_regs(struct mxc_gpio_port *port)
+{
+	if (mxc_gpio_hwtype == IMX21_GPIO)
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
+	if (mxc_gpio_hwtype == IMX21_GPIO)
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

