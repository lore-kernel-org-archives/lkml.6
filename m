Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEDFC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07E821A78
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sxQ6TYeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07E821A78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbeHIMeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:34:37 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:12896
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729965AbeHIMeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqV4D3eFCOCHMbwTpq09oFL8vlQcfTETjL1rjDM3nv0=;
 b=sxQ6TYeI4vwpknvbMg0xTr4OiEYUdXnOYKYiyUWFBqqnGRQ4cVdbTuJoWF98KfWjcsScaTa9Lrd2iM5hSYTwV+xGS96j4kRyYOsPSL1BgvC5RTNAws5sL1XTy0+cCR32v3ZPcrh92oWbiTn7qPM9HYEVyrhuHbX6/LUCtKc62FY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3911.eurprd04.prod.outlook.com (2603:10a6:209:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Thu, 9 Aug
 2018 10:10:20 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] tty: serial: imx: add pinctrl sleep/default mode switch for suspend
Date:   Thu,  9 Aug 2018 18:06:09 +0800
Message-Id: <1533809169-24133-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
References: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:2e::22) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7345711b-a775-4565-933c-08d5fde05179
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3911;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;3:BmZpEp/260mo9JqNzHxDbuRZO2pkOupLB98pdbcRu4ZPZkyQvlT2FPXFMW9gqfrqXjH6PbCy1pc0QqvtT95fW5v+2e0TAZK9xIL11d6NJjsB8yGVSZIAS+M4uTZMquzppVflmTYVZtFio7LKq1bEIw8CHdcPqbgIX+YzDE4D+cT9VK4fgRfbuHGKhKqxBktnipd5SQ91GBa/7yqneC5jrvpBaQeW5nmxmI422Sp8MFgtTOMPESY8kzEmV0/EDJBj;25:By/eVPXk5w54NT1HFwLwn5rDYxo+NMBYaMO/65ar6YCHhWoIgATgY5bpFP1IZWpj9uXLrh2OoDxk0LajbE8cXSWF/mxHbuJnWpSZoWNP0Jr2JhJqirmDaP5kCethpiiSAUYrfSyVnXrVBM1opbCESK1K/oggQfz7f4bSgZDiqzcbCd7YyMK0mgF3GbweOdlvIVx5aAwpMhF+h0hYc8SqfeiO9wcvq5GdaH0jeFgRp7vd7+byG7Q6TiE5FDXwUjaIbvvJ8qn6b5p8Kw0OASds6eFmfykiFvIOB3nRnKKYBmiQPc53MwR1nijkeh5V1c8RHKr/WAlQJI64rZGumtCfQA==;31:mvHUFLxM5NsG70ZHTi26IDZ0k65ra1TlkfNdyDaFBOWkMv+5ve/TuZm/R9YZ4XokTpjW1sYrMz6q36SQEiO8yyxx369fGP00hw5UeZBsw0k7jlHwZbay0QNvZdP7sQyS58PBcx5w2R99oeUDsOxddRb4PyAP3xVdT5CTi/+xz9dHXBy6QNG5EVDSLAeAez4k9oKk8nYGecZY4CXdZSikxZdnv8NTtFz/0Ig+C6JVanA=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3911:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;20:GTdryxmoLVt2LS1bE4SZ0FyjmOvtTstVA2prkLB90hNK79J3YB/fZZuSU07bZTa0wIDzhYOcFtBsvNXRnXjnwBb1yjIpcJ5m4odM4uQmjKpgFuTY31ZxE5sKPPzXXvzKoQUifUF/iiGBbadYSfK6wfPmTNBQ+ZAvS6uZIvW7Z+5nvuXnLJm89yuLHZRW6j9QYl1KED1dlep4h4o93oX9YZxzmrwTVk4or4RkacRRGaGFbaRShmfwwhyfocQTy/nBm3AWqDOdqFvePmlpVZZa4a8eeOjO1ioDbtBGJyWUFm5uE3WX6CVkbfKldCfdz0hR7tiryS1QfnH238oHiZuhmg9XxdtGGAJM6TUd18h6Xp3MM9qPVDEBNYncDE2tcvr/Pzgj8oNE8ds7gvJjTi1bKQqGJpKkhP3lmywV4eJTb5O6amahdfoRXWC77WzHrtISOF2XKRM/ipCzpt1jPjHOBkEKAQ41+Al/VwwyoRaes5MOnXGeFqK/GinkIfmyXeMw;4:2fRLkRTbg/QfCiiknbu98dDKD597RztSMCsiTGuyFLpjfofhVFNpUj2cm1lJYbp9k6bWOaSDynH0OTybQGVJRJHoAFzQrWOvQGbQcY2j+LyC+aD+IEAOEYEcFP1pZr3FPfq+XGxwOd11DbsrkLrc90VKLXNPNsk08kYj9WPElkpb2+2z8MsTg7kaousdI/M/waZnA/aEcZlid4mmdUjnzvr84YdWChc+u9PSWvI6rU25GDNM55R1CFRgoaFDZzqWL+Ttw0LZE+YE03OVeRQG8ul4bpmS/xKycj5R2ILvu6WISnv/om5kI3dCSEUXu2xk
X-Microsoft-Antispam-PRVS: <AM6PR0402MB391199A11D0ECE05113D938BF5250@AM6PR0402MB3911.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR0402MB3911;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3911;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(7736002)(50466002)(6486002)(48376002)(386003)(6506007)(97736004)(476003)(956004)(2616005)(486006)(478600001)(446003)(11346002)(6512007)(25786009)(53936002)(4326008)(81156014)(8676002)(81166006)(105586002)(26005)(305945005)(106356001)(16526019)(186003)(8936002)(50226002)(66066001)(5660300001)(6666003)(6116002)(68736007)(14444005)(76176011)(2906002)(15650500001)(3846002)(47776003)(52116002)(86362001)(51416003)(16586007)(316002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3911;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3911;23:jpCas7ahp3TuCC2k3g/QqzxNqJtW1VM9qChcJ24?=
 =?us-ascii?Q?ri2TCKiyZj7WpxXVs42HHizdr/4cNtQ1NEYJ0ToN0TDhqM6wfVhvXWpfWweg?=
 =?us-ascii?Q?RzMGtLepzkdbJyLvluUfEcDg7PaAn94ll2/yOH+0v4Um0JzP4nDYNpd6oGoo?=
 =?us-ascii?Q?7tnnLuLpNsji47LPq09RxVq9JUlwjsAkjekykSCaw4UrqGjRzaluq68KvKp7?=
 =?us-ascii?Q?mYOamuBtqIC3s5yQJ7pInsnifk7InA7IE3L9vdR7fl0k9K+w87ubhe6uy41z?=
 =?us-ascii?Q?S7HOh6hK5KD58rKqmFb53rHcUUtve96poQDwqsBXtVeGhOX748DhgBqpg6A1?=
 =?us-ascii?Q?CJZiRhz3pWV+XquxhilbQZFyVjmqWRBbNRMfB6NRQcHiztmoxVv3GIRZbmOH?=
 =?us-ascii?Q?nF16+BZVv7hjz1aHGfw6SPR9EMSVUH4CtHiRNQhJs9uPHSbLgdVpKMosg5vx?=
 =?us-ascii?Q?ZaH3oOLO6ABxQDxUVaMk5Va7oTNuhP3FWPVfujGArCKBtO19Wxcpgmb4pSU3?=
 =?us-ascii?Q?93/KcBOUspypfgmNF3Uu2jRcjRWLJjYM0EO/PaqpLO8tSj4QIkiynno6HkhE?=
 =?us-ascii?Q?hQZdvbJbtQDG4FbKJAlVvxjXt/fs9XfBhvG3KwZkTuRVlvX/dubYfc6RpgUt?=
 =?us-ascii?Q?91R2kGE1KggsVr/rvkBv8eMVM0rkIBkZlmMqpuqtKBWOLMwU6QTT08Drptq6?=
 =?us-ascii?Q?Oxaxuf8fT9QEY9KwXztce1XK9oRVY+rdKvGhXw3XBonBBtaZxTXvQq9cp+Vi?=
 =?us-ascii?Q?FQnY4uXYT/grzGJo2KTY962uIYp9pvfZqla3ilJ5ilyal0ndFG58pFlILgVG?=
 =?us-ascii?Q?5Mm+ugPqSyRHMkgnrc7MFE/SeplpbvSe4HyBSxH3SkvNwd/XQkal2sTerwwb?=
 =?us-ascii?Q?FFV+MRS+bCTMWNvDNmEFI9rXQh5aHhC+GcD+Pw1lBBqfs5FVkxwMF6oHGZCs?=
 =?us-ascii?Q?rf0znKVYadtpW8NYrucjgYOS3kjzDLVm61xfAb0Tf8Ww1bLL6zpjy0xRnzy4?=
 =?us-ascii?Q?qELIh4h43TOX+9hKDq9v1yGgNRFoW+BNOUpHcx4b4GRAtiXRPv5aMT8zRrX1?=
 =?us-ascii?Q?jnT7Lgo82KJDoaY5DJDOfh2Bq6RBk7Bh09dQc95gmuKMTig7nfSC7gZwWF6e?=
 =?us-ascii?Q?ULziP3aLdAi0oOtgSqtFB0rsvU7Co2s8oQ/4ic1B3rq/K+MRwiy1Tey/9MHv?=
 =?us-ascii?Q?H/5S/HQtIVJ04atU=3D?=
X-Microsoft-Antispam-Message-Info: V4PNiWjrfHFgfsxpmLvy5CJTp5uAp6NZEfOe0RE03N4ncc0lP4UDmrUJpZQvZZR0tfPdaFuyybPi/XgUKtRrufAApNCZ75MePdUJSLU2kwvHCIik3HgMTcUJ80F0aji2o0yHPklh1M4i2tB/QZVqE1GZBcYlxzTgkSz9yst4zisXrJ/cxpVXVd3POsOajkQ8CIl91TMa6mMqS/Nz+Lw62+sxYOJmRqvGg/AvH00ui7MixcguKzKzV77B0ymaR8w3tvdpdpvBHypXBMr6H5cHkRh+dljMCilu7FqqlyWow2CLMCmH9v7lO9mXrSOC46GNUQCh0ZUju+C+gc3kNbrzD7HjdeAd5JjLZiXWmLTYvHo=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;6:hOn/JRSgBUwta/XLox5RVhNFI6q7mGA6G8WyXmrCqNLHTflHzeroZQBJjP1qfGAFRh+HH89VGt40a0H5ItATPdot03y5go2KtcaAFgApf1ygolRmRQ4/38v3BctxUoHzb1ldvTIOR/T9wTx0hBKu1YYWOmRBXs4zaa2ui9GOIVJO9dqQXVN9Ca/4EKVtnYHAhjZPwH0lsFX1lR9KOvQha+gYzpoXftY5G1fxxMtXBYF5DQg8mwc0mz38bmFvQC1IpiT4On93XAGB8qmzLeCUMyAV7AsUnCjxjZFxFSsyz5sRiZDESPsrBztOUFDpH1kPXhVAR2yKLf5pyIuRNKeR6QF0bJFcQj2A/lyL8tFvoZnUNvnsBTGTI+TKvB+vJlV6gOcyqJe4GkuKFN+QHJ634SVTCz1+/EdN5SKdW474/J7kjvr+AKGy+VhG1wKhh5xugoa+81cDivSknWAmpWTGZg==;5:fCQozZlkvRHFGYT/+LOV0ytVLDCgWKyd2AhY1aG/nW5Al9a86plNl16DDfj+AMhmdgKHPvPsoi4B7RQQ+6vFpWHveKJn3ptx+X2kkm/FofDGS6r2t/XVilAlJk7IlBqbynqk/CtKba4zd4O8/C+YmQ6fxnygvHKwTkqTjbRZpCY=;7:s/7TODkROSCLIpjtiMKDhJYkOceBRa1YsilTAH7nKrLP6OgCaViXaZmoEprx48w9+vxj6um8TwXvvFcneWrBCPr5aFrL+4iIQZKS3EgfoZqTIm+v5Chy1BLaXyLSxYPjvSOo/A71zdcPExB5QeO9CkdUDr4a//iLSv36ohy2BAjv4bvXKNQWllLKOjzBWKJxnKvD2dzNcsglN9Tdaz+5s9a0bUu5/6LK5MwdGfIsccrKod95MnbiVCcwYAcFNUl3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 10:10:20.3842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7345711b-a775-4565-933c-08d5fde05179
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some i.MX SoCs' low power mode, UART iomux settings
may be lost, need to add pinctrl sleep/default mode switch
during suspend/resume to make sure UART iomux settings are
correct after resume.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a09ccef..c280d43 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -24,6 +24,7 @@
 #include <linux/serial.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -2447,6 +2448,8 @@ static int imx_uart_suspend_noirq(struct device *dev)
 
 	clk_disable(sport->clk_ipg);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -2455,6 +2458,8 @@ static int imx_uart_resume_noirq(struct device *dev)
 	struct imx_port *sport = dev_get_drvdata(dev);
 	int ret;
 
+	pinctrl_pm_select_default_state(dev);
+
 	ret = clk_enable(sport->clk_ipg);
 	if (ret)
 		return ret;
-- 
2.7.4

