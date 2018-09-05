Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E75C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001B620838
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gC+gvKgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001B620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeIEF4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:56:47 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:49819
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbeIEF4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY+6bDfldr3BE4Ymk5zMVcUn98bet3LrQuiVMaN5Bxc=;
 b=gC+gvKgD7fMl0gGyVmy32mC3V5LvvdLk6CTvR/NXMvesarSlUkR4QoxkWL2q45OBDBBXLO4/WYjSjdaOTgQDWGEhz7KsUvecuXTC/D5b+ezWpwqrx+TQ9EWJBLajYcW/jiqQIcbHG3oihx6HBSAwdcAKrGPqOZ0UIRDw8Y/zkJw=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (2603:10a6:803:22::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Wed, 5 Sep
 2018 01:28:58 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] tty: serial: imx: add lock for registers save/restore
Date:   Wed,  5 Sep 2018 09:24:26 +0800
Message-Id: <1536110667-23530-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::18) To VI1PR0402MB3918.eurprd04.prod.outlook.com
 (2603:10a6:803:22::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 864655fa-3283-476e-a292-08d612cef533
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3918;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;3:2ZC+fmd08zyn5L0qVT3D5v4sNV2ZDx/ISRNdN8292vVi09yEhgvZq9ska8ZJ5jHpz5gaBtSX5hTvl7vfnf9en+78tdN3RAPpEUrYjS0U9bBRMnUOP4HwfnEJQJ/v3giSAWvfWHCrwBPN+TrdAqVZDWNJJc8fQjKJPlIiE18b4TlShEzQ/9lq2zfi0FtIa67QGtUSxKtVjYqd7tl6BLDCPbE0jCZazsrGOG9fx3aLUB2NBFv3nx2Q7o3qiDW+SXXD;25:JQVh9fEyWqKI/me8FomuAUmA4WXXBGU7Fnb9F4OD/GoeNz5EIrscsHWR8UrJj/R2kZD6/F+s5fwwuHiEhryYjF/lXO61kny0c0Y1tWStL2YZAiDvCLdlp6Db0h0lbChPNoSUvXbMJ2Zzc1Ma81F0OAZ92MdFfPJohRBGUuvas59+CGKoEUGne4HxbGw3uQm77Jyjc+7d4cjptUxrr7e3mdkmOa0vpBPt6wFmb17GO+nKGmybq0Cg0AbH5x8DYKIKZgFGeuyUhEV3NxFqD4KatN45+N1BRKhoMxJ7IAxB6y6UhRojSAOTELHE2XIbX87hVVaJCbXc8nB3cEfd1xsVwA==;31:pRPHBkSVLZCoHLjOztl5P86H4rtskpMVmlkZ0g+fBHBJGE60z8oZWrgi5XRa6cU9gdYDLzByj5y0HcKeQszUtrqhjVpqhswgZI+TfneDtNECiaJLPuzxdNcTWCm2TlHfi6vjFtxIUYLbLa8uuXc0sopjWlhc1jTSAdt0OcG2eKv4XFF8/pKrcC2pPvUECuozGiSD8OzCj3R88wiTNvav/ZN8p5N56EIqDVi2sUC7t+8=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3918:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;20:oQ5BeF+5e6b/dPZwEYaH19GlGSJym53Qkh9l3Ca8Msip2xZuRkyx9kGnd2yLOO8X3HeKMq61KFILy3kZL24haAJZhbszmNbyletO6NRcYxlh/QxaFbrCfAijuQDwdB83IxhMhH1gpDGrVDWiHLUTavjxDm9a1M7vQIsPrRC00fWLDPcozFawjOOtLV0wSaEPT2yEUq2mibODBdjg1cHRsLLSO9LHm5WizAPezTtGP7o6S+AcDEkjJbqXBXNl3MRijuz3dOHhFPCqTFr+G4B9gd0pMFg692hcKWqhPVKfcQlDQaJM4YUuo+51lKrbKU1lHiuhYHJoE5oxbOPKNdVBxw1VSb/mSWcHWGmrIyACEG8RDzdG/GaUFqiYEPBA2h8wlvpI6TfLdUfGLZszUihfNUjhcHS+eJSGfcuqLZ3ttjFJM95rAG+rtJdIZFXCZ21adVJzjIcrdPpJ8upVrpknLvA3Mw8AzQ+uS6wRW6VakMe0GCE+zWfxDX2jdLJw/mVp;4:spX23IfTkJJVqn1LS/l/AoueguA+6s3cBlaCR7qlXwWhkPLwfluloNl74x3IqoKjU+eCnP6B+JvY/EnEYDGtTw6TEKaFxMIvA88WjwFlwDMvYpYmMescDTXCTKC0WDixK6LJRY8GTA4yi9xFk5VNZYYMhm0S/TjncB7I335tqJ3h1nHjAccubbmkul32SBNit5LfOLrp15V4Xulz9d0c3bc78CaCv9ulWmIxeLMOUKEh3eQG/8TZpyciuHMTs6yhANIEnqsXvZXwNdmbOwJX3BFgz8a/xYlsyZvrqBCyt7whXtf1biTYjyxc2zHD7wja
X-Microsoft-Antispam-PRVS: <VI1PR0402MB39183CA7B718CBD93051B610F5020@VI1PR0402MB3918.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231342)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:VI1PR0402MB3918;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3918;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(376002)(346002)(189003)(199004)(66066001)(106356001)(47776003)(105586002)(50466002)(48376002)(8676002)(7736002)(81156014)(36756003)(6666003)(5660300001)(68736007)(50226002)(2906002)(8936002)(81166006)(476003)(956004)(2616005)(16526019)(186003)(14444005)(486006)(316002)(52116002)(305945005)(26005)(6506007)(386003)(6512007)(6486002)(16586007)(4326008)(25786009)(53936002)(51416003)(3846002)(6116002)(97736004)(478600001)(575784001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0402MB3918;23:3zPR0oMr6i2osqhglypKBMGGWlGnHPhZB43gUAp?=
 =?us-ascii?Q?8jNr2S+7g24AUfp2Up55IHf5N6PtjcDhuxDbuBzDWA/fIW9k3QUSCdnsmJ2B?=
 =?us-ascii?Q?XXUcYF8DmHNjpAOWfnr58jRU0pYh4NCuDHNEOEQBiImqe9FzjTuveLEMuhai?=
 =?us-ascii?Q?zXBtpKYvz2tCo0PipVFjp1UwQ32wjqbYRt7nIOATYeJYyLs1o9d13/vyYkvK?=
 =?us-ascii?Q?qAP1390fGyBxj8lYNepNz6IgK1N/HFyzGCW0FrHayhkETlF/jirnpW7zzIwK?=
 =?us-ascii?Q?L4YC8i1RvNXFNwYaG/FlApI58jjfI2Xlgow7G7IFnyPL4CWyUUd289KrB54z?=
 =?us-ascii?Q?+R2HBPniSIHAlMfcP/qOYQ7TW6BDVqZyZvRCClzM41iz5DSzZ/nMiRZaIsbC?=
 =?us-ascii?Q?t2kkVKAOM1JjMg7qxTgb8ZdimjiEUgCRHXK0BupEvIJMv9BCJsR8JdNQ1xYP?=
 =?us-ascii?Q?bxdU7v3G8UChuiydpfvqDRJgo7z8Tg2N05fxBqC8us4jvrRMBhTlfFoZK0yV?=
 =?us-ascii?Q?hu+sHY5O1hsg/X2z9xhlEsEuSxzS8ktt9eakO25b8JLBxEHNXakUazd3Zi4D?=
 =?us-ascii?Q?gkue6QSkThusXdgr/iUiDkkrF8D/3+gR9+Bw/swF1rAlxmXkLAafZ0TYdv+d?=
 =?us-ascii?Q?ep2taMVZvVb3+zsdYmmAn4UOcRmyRSMMKTFSfHAR3y8HEBgxw1/tmrZ8DqJ6?=
 =?us-ascii?Q?6Qob7YX6l3j1OV6T9wWsERAaCsU1e5MVTRLyePybIyLuKduUOPfQ6S7Oqc7Q?=
 =?us-ascii?Q?z4GEiFrBWV6PXIv5WjZXe8jvgkAWriwDpV80TCuGWe7VtsvQ27DRV6zeBhy0?=
 =?us-ascii?Q?iSWoYhKUf0uLvft30ywoZO6EwXXn7cQaqydAlMxGYC7ct+bCjfmuUdHGWHi8?=
 =?us-ascii?Q?lFGHlQ2m/6+RoH7EgbHTRb1/TcHXsXfcULuqbwpjhg55LblbF7CyF1Sz6HHa?=
 =?us-ascii?Q?uuUxXYxj18fRPQLVnbPPGLc1hA50RWZOgKsRtVRyXv2LiC92K34vXx8/psz2?=
 =?us-ascii?Q?n2B+lfBVZfkst4iLU7DnwNuVX2R1ck46R35XQLYjmcubeJ/57JCbYaS0qlp5?=
 =?us-ascii?Q?BqnZQ62UmZ6VjtFlPdFYTs7IMM2Qmd1ZtGqf1ElYKjR9WBRLQlgSzrkdIKs+?=
 =?us-ascii?Q?w6Kh0/itjlC1Tc00GW0UP5ZOWlvfzzg6w?=
X-Microsoft-Antispam-Message-Info: IpmadSubEpeBC4/TeTvfhhU7RrYFijfRYUam9DmPI+8PjKD1I9/JnRH+jTXRCGcyc+62NBjmlKjfhGTDwwYkITuITB5ZbC9qqqUmzxEfmV+wDOdYCZsyV5yJGbz2o2Zle+/1/2WNoTnVgeLvJ9tEqfHh0YjVjt+1pFkhUCErAFbpBRzpqg59kFi3IH1+l3AojggG2WFR315G5zHHKLtRt2IxkYO1UMyDHaB+uXHUfuJCkQd1OgejbtdZwEPQPb6TZY7G8eJrT91Q1Q3pKL4+6/HgOnxqvHIiC8zg/8mJQcOlVW1Qu/0gIUxELcNUU0Qs0JNOIkTgfQ5bYvsC1HYdl81YXK0wjKTCAXzPiCCcWIs=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;6:rk8ytoSTmYZL9i2vvRUBONW7+eSdva/pl9ZJehY4xWclLJjX4gq44yuazlySLLyYm65SLqlv9slmrutoYAKjuxxNIQRiHDdlYs+htREx76dcqilui1z5XLHnNMPyRacFW24xwCfDLQvjo6EipnddAwfIE7BvjsMMRIBDsXhrsKMxk00fIw5rOevJVMim7lfqpMuht2hSxqu2EjcF9IDyJtydzSOwpuK65HtwAzm/+ZtyPwlWJ7kRuc9cCSxQ6s5lUb99yznfgSkwhwadC5GMJVFJlwTy2AaRxUYyNjzYhJ/ALT4RkJvsD4xe22XKv+VsU35TPPrDRoIIOQc+jyMe5dP7nTmzTYosCF2i5bioqNVvdukY4eHYkhF+w1e3mGtz2O1CkpfI8NsnCfZdCXcXYxQHzfpd+bCfkyTi6Opn59r0k3/Hfr4QiKTfqadwimqNa938hO7G9AORkx0tw1Y0tg==;5:ObIR8Yg44d/Acv5CWDZYFX9VnydnUkokPkzLHz9eBg2TfTQZoPOiAo6wmAsJf7L/I6dQV8DydVsOtviSjTjNWZPU37Qqv+6TiwVJARorpEE679uh57CerhvaHDfyDEcKdug9ztRRLXB++64oCIMpsxe5uMmypXmh2T9xtE85wZ8=;7:CKdPVF7dslUJwwLri188DuM+tE6zL9P4S7R0NDeHoSdFMppCzHT+v8TKEyf3o9IoU5Mz0rFEHm/mvxmNb40/BW6xkssDBMU5lIx0HPD5th5e6EIsklYjoqJJTxQ76Sp0Zim4epQTJHXyiNqoCCRdJOy1seXdhnotx8YUzJldvL98qccDeDdQoGlH6jYHbYSyEk05d2gW6wfwQRaromMrVDw70Nt0uVn6MzrCGSDq7dtsJ8jvJRsC6wv3cesjonMa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 01:28:58.4223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 864655fa-3283-476e-a292-08d612cef533
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In noirq suspend/resume stage with no_console_suspend enabled,
imx_uart_console_write() may be called to print out log_buf
message by printk(), so there will be race condition between
imx_uart_console_write() and imx_uart_save/restore_context(),
need to add lock to protect the registers save/restore operations.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/imx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 239c0fa..c15332d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2376,8 +2376,13 @@ static int imx_uart_remove(struct platform_device *pdev)
 
 static void imx_uart_restore_context(struct imx_port *sport)
 {
-	if (!sport->context_saved)
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+	if (!sport->context_saved) {
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 		return;
+	}
 
 	imx_uart_writel(sport, sport->saved_reg[4], UFCR);
 	imx_uart_writel(sport, sport->saved_reg[5], UESC);
@@ -2390,11 +2395,15 @@ static void imx_uart_restore_context(struct imx_port *sport)
 	imx_uart_writel(sport, sport->saved_reg[2], UCR3);
 	imx_uart_writel(sport, sport->saved_reg[3], UCR4);
 	sport->context_saved = false;
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 static void imx_uart_save_context(struct imx_port *sport)
 {
+	unsigned long flags;
+
 	/* Save necessary regs */
+	spin_lock_irqsave(&sport->port.lock, flags);
 	sport->saved_reg[0] = imx_uart_readl(sport, UCR1);
 	sport->saved_reg[1] = imx_uart_readl(sport, UCR2);
 	sport->saved_reg[2] = imx_uart_readl(sport, UCR3);
@@ -2406,6 +2415,7 @@ static void imx_uart_save_context(struct imx_port *sport)
 	sport->saved_reg[8] = imx_uart_readl(sport, UBMR);
 	sport->saved_reg[9] = imx_uart_readl(sport, IMX21_UTS);
 	sport->context_saved = true;
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
-- 
2.7.4

