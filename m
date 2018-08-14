Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E052C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208BA21730
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K3n85g4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208BA21730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbeHNTjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:39:09 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:35184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730635AbeHNTjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VGMWyKaGbdJVhi0fowyNCTvV/S41e6KiarWsyVHILA=;
 b=K3n85g4S2xGdEueUfRVyhBhoyc+ILrXLfJmDAKdCBQdU7YI5vdcq1CXOlMI0dcoM/xjAEqHmWGlkrjfuxtlfboQuIC467GPxk1KUM7Qsxbsm0Yi73w5z2bs4vWEDu+FR4K9vdTyU1oYHigBFBKQlBHAGRm08x4ddxdktr1lgCrs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Tue, 14 Aug 2018 16:51:01 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 3/6] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
Date:   Tue, 14 Aug 2018 19:50:17 +0300
Message-Id: <88a5997e37d048cfc2dabb44cc13dce89c93d5eb.1534264292.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1534264292.git.leonard.crestez@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0102CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::18) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0e1fca8-f185-43a0-085f-08d602061ee3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:JeIAyNL+kEuRLMgZ+LoFqgFooG968iMzF7G1iT6GoaOHS89TC2c03cK2c+Rpxk84ldt2Q7HLV6g7/21KcpTgrHjatZCKxItwgg3ZKdUIQ3uUguJBp3delS1rPbCVpAlG806+0LRXiKoKTm8Tn+hDko9VYRD6B1/IyI/V34qeyNKHWYReoHR91pcXqlKVtSS4xNU0W7Km3PVsEW/Dh6+k5QVtU5gCygfGPHFhacnj7D+781afp4O7ifIpfyEnuwdM;25:NynLjRbEw3ngfaZhOmMvUTuOPSx+5KI0Ogc1bG/iYFbzNp/biCaR/vUnFKOucJkc3TNkj4nRhMVd9ntYL4oqogo2nF4yu94uVIobrLZeJbfBRfh0TWPbHdnKC9i4Se6cM+FyrlB1FwE9xwNKlxFcQq93OSUGaoY4BtjzsCuAJF93JjNfUSaGScBlFoSeQ+Vfks55SnU9rbLd6JdFeikxXHlXP9BLromNAkr7F5mU+gsR0Hoz9XE0kWaDRhtgWfGafPPUkudtKnjxG9EPGBNd+hl+T1m5Mi5fXWo4JuSRpVne80gcWu7dq3e0nvxjJ9xlJuV0hgfzGiza01tQ4PxbiQ==;31:rEqvgVFyk19iS9vlz7kCaBQete5sdJVJKUrein/sF19gZjN6ty2XRGSgwTqqtUB57VqMugydi7AStG67YNf0iynN6XC/AhyEj8q6kE1x0ys7CwCR4wdnHvzl3t2aHx8hcWJ2W+Y0J1uq97jy3hGhCjeV+Afl9GLWbN7/g6YEzPFZXWMtrAZZUA2f/Emj3ADKlViiQTdE/WK5jA3gEiIP3S2hnCGaaIVBdr7bgqgVaLA=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:7vAHN6p34LP1eGI6+s5pPd9q8ziffuD0Pby6TkAwprNLycWmj2wdQ4vKjL9vy2rWn5POG6XaIXpgo3D4AN/oCpHelUmxb7lImHnDG6TTUu4L+e8qQhVSOLTSwP3UHXNbHHt23tANYaT6hlsNvnQR3b5cEHFELVOfdo1NZzGLHKQZzP1gwYbyI9/2dOkpNf7lt4N08hGtwZdF0FMKt1Lwor4HrfnDu4e+/0O22AdeZB74N7AvuTlcdHTZKxyZx+uKcS63+Te+nDTdycKZWfkWlOyWcK/80YcwoJjwKAR/3+kYHxwjyzDTdJdC34a0ZY35/6jTDm4fQeL8S3HDJdaci/hNng2OZub8dIUb5LMWj5jK5IBBcUAqEBotBYBTYYK1xbl9VgcgTwiuEXjFj3+V36nl5IkDuO+gHQ7LB44FLBQkrSpV/mc2sDnpIjDeQFKHcpxhmMW3Wx78VHNg5PRdmRdaJEiNUdYOr2bXl2ITIcAEG9nDToXYGlq7wsrJsxE1;4:nATnb+Dv5wOL4P+4py9iT3yYaDuptlahzfOUULRc4obX7aIhWEh3r+mrq06ifYBRGOudVbGBHukBC8zBuOpSNhxe0cBza17zKTlzp9NXe8w/MMb7lNoyy1tP7I8bZbUaU8OITrl9yl2gCcaa3cpheUNXZn25k833n+8ixrp3zdnqEKoUgjBs4AKDzbiYDezKQEbo64T6Z5FOXPmnIf8nE7NnWz9gbnaBIUeBefLLtemfwYRbrxInc//ohm3BAWsDrGvTp5S0KUkIBHzu7pZNx+n62SFCXMKvW6U0Q6kzWNkMa3DxixvykM3/ku71n16/
X-Microsoft-Antispam-PRVS: <AM6PR04MB42934C7D85938A6FEB6F12BBEE380@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(118296001)(16586007)(6116002)(3846002)(50226002)(478600001)(36756003)(16526019)(316002)(386003)(26005)(186003)(97736004)(6506007)(86362001)(2906002)(68736007)(76176011)(54906003)(8676002)(81166006)(81156014)(8936002)(110136005)(66066001)(25786009)(50466002)(48376002)(446003)(11346002)(105586002)(106356001)(47776003)(486006)(44832011)(476003)(2616005)(6486002)(53936002)(51416003)(52116002)(7736002)(14444005)(956004)(5660300001)(6666003)(4326008)(7416002)(305945005)(39060400002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:zZiofB0kHEC2kqE2zDvN1j5vJl0hlKyH5PLFZPg5P?=
 =?us-ascii?Q?wVIH5dSW4xjXXdFB4ycmNfa0P1hE86wpleyviFSa3S1sFELWczZBZLfOgWjC?=
 =?us-ascii?Q?3ISpHcwHeOgL5jOourGijeUoXKczM8hZejBGtufJM9+dW1gtWbJPxpAJpDpt?=
 =?us-ascii?Q?hzIrbWWNlNJimmGPefxgdPMkH5NsWlJXxnpSRZl9bMoseqA8Io4hjHE3ifVY?=
 =?us-ascii?Q?hjR3oDgqQZ0dXJgMfDCbRY1Jx90QfVn9R8BTi64pL08v7Jix4L7VwIKrc1gn?=
 =?us-ascii?Q?UiGWB+KjHEHisJEWMUbG8zwuTCUnyoTyBroLgosFvLtsBba1ST0PUw82VCv9?=
 =?us-ascii?Q?oz9jl0cpgjtKOtwH0+lqLpPBVwyaFwwrPY29bc2RU/HXTix9/gcuQlq0s7Wz?=
 =?us-ascii?Q?GoCMPcrK6zw3IaCxzZSfNQNf4ue7zo3QYJ/nME04n4D1m+nEV84oH0E/PvlD?=
 =?us-ascii?Q?8uedT1s+DaqFRpXhlwIVhe1Z68FR4Oy85K0GMirnTXwJZTDocMvQWvGGesUt?=
 =?us-ascii?Q?BSLbi7PRWK8veBl001KA9s5rUvm3Us2cSh+rty3k7lxI3ZaMx2oA6TnNbsRr?=
 =?us-ascii?Q?0JcbstfrmYxun4GDmDbwvAHXWxAEk2X5xXsoXs5qhwf696hauXij8Uy9Gk3T?=
 =?us-ascii?Q?b8lXoEF+tLaeIbmP6qMvL7UhBmpyngwTaEPrXTC9KPAYpWe8KDOUx7ofrtfJ?=
 =?us-ascii?Q?eDOnGczMX10g5jRHX+FmLNZejXovHttrcKhrSfg7m3gscHD436po9Jye6czQ?=
 =?us-ascii?Q?ah+v1296jLg05v+UNfroGORNrwXUbZKUXXd3nIPYxZSczzKGWVgrBWzDIMpD?=
 =?us-ascii?Q?OJ8oMjLsET+43UQAEGQyu3hxDAmXSuaR76V33ZLxqVkFih5gcrnCYplfxeXL?=
 =?us-ascii?Q?RltaaK+Rcd1qILMU7AwCrfhU/DSMr4AVnm5rLQUQyKKY6OMhJ7LNVvDy7ctR?=
 =?us-ascii?Q?DCx+ThNfjAU/9svSMM0pDIMtp0G9U6W1zuz6kWVjnuh/oA/BEO7aE7Q5s2SH?=
 =?us-ascii?Q?Q37BLzAu/IIJ0iu2VHPzDJ7RuAI7+kZ+SoYYIOgymP94rWp0BM1DxZbbFFXs?=
 =?us-ascii?Q?gwAgsYEfrsFWIIK0S61mv3McTLH7TNNd83b72Bld2fpgGBAOcRs9hYn11pUj?=
 =?us-ascii?Q?jRL3uimkG7ATL9VgoH4NE0sUEov8A0Sz2rDKqwjoDWx8bBU0uWKlqKiSToEK?=
 =?us-ascii?Q?9hX7H2bmmRbkTeKWRo86nOKhlUuduk5HGX5n/XrijbSInljm3k5J+EMxkpQW?=
 =?us-ascii?Q?J1l0Uox5GQBjFd8v/cfUFYOjZoiDphTusmAxuvhAo3MccMGxJplEmK8p4YNi?=
 =?us-ascii?Q?yPoUT4elg6FbtW/QAQOPD0=3D?=
X-Microsoft-Antispam-Message-Info: TnlkXaKwiRxgNgkBZcAUQRNEn7o+21TPZUjNywFzeHsw7hJ5GOrai98NVFeScN2KjYdrwiEdXf/ZkL6WIDfMV5UhlQjv5q29TjnMtxa6ADnHMkyed6CaxI3H4hMc4Wq0NDbD8AaQiKvsPLpqIRkQkLt8SwMA3X48V9jwj9COwhyAlPGEfmjbuPH2kjZi3xbssmRMqWjgxkOlYixoL7LpNB9jp7fN1wG/0FjqjiktPx+4tzF9iPAlwPPSnjMLxFz7ajrbhNmYvGcqrZad1ZVyjIxx+hNcpPzoyo+8An0hlBk8FZvK47R45XmWHvsjKjAvVFpqrPYnagLhp6SSBoXD1spppx+cCvCziWpGI1tWOC0=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:CULcE+85jt+GX58VqCHZbxqERUdt4Wd5kMaQBEGK3PzdcWU8emsEas6ivgWp+BL60lr0rrhqrZScYKoMbeMxWl4vhECh7Gkr748/d/I8wWjHxlQBF1VQSzH07JxmzKu/c6ikCAV6Zmy3bOADuiiEsBv+Y4kOUqgfNkQ9LcuoKlS5jh32aIOxb3yUauJf2IugIy8/Orzo6UFUSwhcaSgg2s1pSyomF0udkUYCud8t0o2mZuQDwpE4kHy5b6412OPzqPpVKHTnvDuyP0+OphnMmEOKYtKCUjABy7jOBb0GjYq9Rgct7DxQuzJukw8rM5wwX58AKHAEIHA7BHH7sJ0F9EqeUxvEVwDf17ONgJgzSRjNn93Tb3zbYOfuccNkfcn76VSxmhanv+njez1NlAg7vmsXophC/D9/HGRbJle/5n3YMQRWGvIrzBSnVFtH4z9VqvFf30SgoB6Y1T5hGJg+5Q==;5:zxfxrc/xyJzNO+IPaTn0yRsQwH6gPOzYJZTmuBTWtNPBPQyDFlMt2f29Q3z8prvUiMGYa4prEkvye0iWQ6XywTvPVRZANUrsDN2ftIeXDzFTBy7EyfNw7TTQtwO/NcEnWLeH/7OEJxj3FUshd0qrGO70NCbOV3d5BEv+j+zP5S4=;7:yg9q0Y6XTDiPPo4bwxY0tmMfquN1F+5a7E7jFZOZLcIlPMrKTemUtDLXxPBYUM8TUDS9Ld5y6DsHEuAcB9cDvAha/LLW0qSiL770KcgbBkWB7vwZT+KLQI9GSQL7oprB81q+TbryK1R4kjl008t/2Alp7eL14hpBXz6z3baXEYVM5Kl+g6Ayc31euRx+sH7/9esBrWp+sBl+W+j5xBWG3LnSZH4m/IJCnnEwKXweL028VDL4UIWgOsudV8d8HLYU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 16:51:01.9610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e1fca8-f185-43a0-085f-08d602061ee3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for the imx pci driver to send the PME_Turn_Off TLP.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/reset/reset-imx7.c             | 1 +
 include/dt-bindings/reset/imx7-reset.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 97d9f08271c5..77911fa8f31d 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -65,10 +65,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_MIPI_PHY_MRST]	= { SRC_MIPIPHY_RCR, BIT(1) },
 	[IMX7_RESET_MIPI_PHY_SRST]	= { SRC_MIPIPHY_RCR, BIT(2) },
 	[IMX7_RESET_PCIEPHY]		= { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
 	[IMX7_RESET_PCIEPHY_PERST]	= { SRC_PCIEPHY_RCR, BIT(3) },
 	[IMX7_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX7_RESET_PCIE_CTRL_APPS_TURNOFF] = { SRC_PCIEPHY_RCR, BIT(11) },
 	[IMX7_RESET_DDRC_PRST]		= { SRC_DDRC_RCR, BIT(0) },
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
 };
 
 static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
diff --git a/include/dt-bindings/reset/imx7-reset.h b/include/dt-bindings/reset/imx7-reset.h
index 63948170c7b2..31b3f87dde9a 100644
--- a/include/dt-bindings/reset/imx7-reset.h
+++ b/include/dt-bindings/reset/imx7-reset.h
@@ -54,9 +54,11 @@
  */
 #define IMX7_RESET_PCIE_CTRL_APPS_EN	22
 #define IMX7_RESET_DDRC_PRST		23
 #define IMX7_RESET_DDRC_CORE_RST	24
 
-#define IMX7_RESET_NUM			25
+#define IMX7_RESET_PCIE_CTRL_APPS_TURNOFF 25
+
+#define IMX7_RESET_NUM			26
 
 #endif
 
-- 
2.17.1

