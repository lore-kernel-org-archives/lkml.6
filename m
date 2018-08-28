Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FCAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D4B2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XpvSrm6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D4B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeH1Mbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:31:49 -0400
Received: from mail-ve1eur01on0080.outbound.protection.outlook.com ([104.47.1.80]:35184
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726975AbeH1Mbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE4DodF5h+CGT3VfehyEU8j7rYJgOEw0AwstzRmDlsw=;
 b=XpvSrm6sCzsvHUVsWuql0xgUOdVljpkkwREVF59GMC6/TNN5tc1RQ7ZOGHPsWOo0KGDSDUBztg3/YZj9dMWpTWc5hIcA2Eq9U5JR5ReGGlkEDBqjUKZSbroPVerUJUNykFjJvwKrvr0AQv9h2vksgbvahK4n/s1BGIevyEg0kkE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 08:41:04 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, andrew.smirnov@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] soc: imx: gpc: use A_CORE instread of A7 for more i.MX platforms
Date:   Tue, 28 Aug 2018 16:36:45 +0800
Message-Id: <1535445406-19633-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0067.apcprd03.prod.outlook.com
 (2603:1096:203:52::31) To AM0PR0402MB3907.eurprd04.prod.outlook.com
 (2603:10a6:208:f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5941b1e-48e9-4842-7bb6-08d60cc1ffe8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:4PDpECzgOqCjceE8REU0871JxyL67LyHn3TDjOy222vLeZxaDcyuKryksqDqiT3RSrSL9fj0WuxEKIKD+1ULK/XC1efO3S2+3g7JzA/ganeOArqoXYr2hr1sdwwFdS0lFPXMA/vCOldqHVpW/iDTdcKR93uPcJt0qu1Cu2N7/UGfPrVKJFR9lb1TPk6ejRBx7fFd6qvZAqLRRC+pRJPu/plWxnToUdlwV/JMJnUN0pPr3WpN/0rj5nc21cOX8Xjv;25:qvsgJ8a6H08J5mytNVi466uVCRsib2aC+jXhi9rWDoVhf70K3NOBFt6ogf64//NpG35/vyvHnbaCz/lmCUIKlBA+8pXEo4N4OpuJyc7A1TyPZxBPxdX+5cdQWAlHFHuRr7u2S9JsMbQ+t93YoDkrNB/eWXNNxUxmqDEZ7PUfN6kknD0mbwvXpLVlJ7RyK575Lt8+00ZGRBuoCKNhMVgIkFTQcHYeKZh/rnMxv7yZy77doPZJlMN1mBo8eHNVcOKJTYPbEHpWTM6jikCYuEXcVQOB+vHOZWJjkZ4Su5b0KvTfdhDTJ8JZ3ilucndzoxDRQgMhtUSDEU8N8+jSYRrhHA==;31:NZome2WkmeCr6BcrPKl9ajlfp6S8MjfzoJU3I9VuEUG0Hub3XEr49+MjzEd4nyJ6uPx0bnSrQz24ZDg6TLhg03GOx6MGOR7ccgdnogcyrByNAIBQT4Hs7MJhv9ltsPmrnp9X3arq0Wz7Nr304tvhLFo3OSzMnGtySDWS/a9aYKK2pxvWAf9372+/g9yTQddEPpQYqGnoxfMVYV2EWiGxJIG9d5Goo4kyEa5N/WLiwwo=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:1KBgygYwepL6rDYoC6U5YjnKwQ1Fwi1QqtPBhlNJAtNT1X6NmX+bsb49VPFHU4mQSFXMAmLpwlwmLarb9D5cBkwmIR0bUz8MD1D6cmnJXc5G4sbn9ZHb2CCRfOVWo+2dCN7KzCwNs8369aguet4u02PyiY31aUykQ2SgtIfD5lkAF9Wh94hikvnaezcFrbPDmsKl3a9PonamQQfIVlizXoDgqAm+h8Ba3+jQJRjjBb4HHD7pl8c+NpPIJLSDxLs12DmOE/YaSeaKs/HImeQXTOs9PXwvJkQHZo+nd/6HVVpIIGMRMwq1YGkyE0P5CkjRjaPvDLhzcuhQKWqd5UblOPF/dZAS/BAN7tzP0d0N+xu9IeSdxr79+Ncn0/75u8+XD/i79veCGZuWQohDneFKUL9TDgp1v7EaMeXR9JOlweg3WVjiYl3HaJbmLNDahj+7UjcC4vZ7dF79mw380Hko/beQ1XvgJXKdIYY0VgNZ8jtOwePQTl+SPNnpUnJBT/rl;4:PoXVDBzixcndPJa996Iwn8SGoLJ1hs+DwyZ5JeGgUmKGlEo/Uhc6rax8q8L7kBKBedQTCtaXq9vIHtzDnNbos2Spv5FEok+mPbx4GRHVDi4FD2Khq6G8W91PmWUy74veEHWvkmzsNsVjQE6JP9+mzOYytONLypMg9U+zIDZCFkcItzZSCWutpLRl2x09TvaaoofvTY4haveII7xyXJCs1Y02EDHb3jDd4A4taaROGO3dUwzfwbv/SSZNH66vyESCOjfNcu6k4TPGzK4669QZrBDuaCrr6/dwO2CbHETTwiA6WdlRiJsdntcDyOM2HusW+3BV9ZjkqQ7Tt2SrLq86rbvIga2z7uHcB86DQox3a0k=
X-Microsoft-Antispam-PRVS: <AM0PR0402MB39073198C7A3B2DEA3B967C5F50A0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(106356001)(50466002)(105586002)(68736007)(50226002)(8936002)(48376002)(52116002)(16526019)(186003)(51416003)(6506007)(386003)(47776003)(66066001)(39060400002)(305945005)(26005)(4326008)(25786009)(36756003)(486006)(2616005)(956004)(476003)(5660300001)(6116002)(3846002)(97736004)(6486002)(6666003)(8676002)(81156014)(81166006)(2906002)(86362001)(7736002)(575784001)(478600001)(6512007)(16586007)(316002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:zYgDQUJthum7jNp/Wph/bLxHZl+tuUnGJKov6QQ?=
 =?us-ascii?Q?b9e5lK1UYmMIc9ByzPB2Fv3TATMfRKl8BuOec2W3QV6dNmizYLqAYxJm7/97?=
 =?us-ascii?Q?vnjDMq+czhh/dN1+5+2IzMMG/YypkWcdzgsxvujco6oJAFvIUYBSxJMamld/?=
 =?us-ascii?Q?fl+xE/Ur/HA1svTBtbbKZ3DGFW0+FF9wrfQOYezm2N2S3ZBWzw74RvRoxg7d?=
 =?us-ascii?Q?/yKDGKk32FGHwN60RRKEkHTehNxuc8bvT5k3Br4ZKNbhqi2+72BJNxZbqeGj?=
 =?us-ascii?Q?9Qx9ceTXiDeAV4Oo5Kf6vTabTPeY0VxOzONSCuwZdAixfbexvQNdyVJj/wYU?=
 =?us-ascii?Q?yLKmFyMavKdhnmpl829IYg5EBByiuwjTu+P/bxQNFP/vQybo5DbxAV6nZDij?=
 =?us-ascii?Q?xnW8+Nkfe37cp9EUtKHXdBt1qVZlVt+PxtLNloupFbh0mYLsKrUXD9zcZd7N?=
 =?us-ascii?Q?Lk5Rtv1jFhJ9yXeSMlzP7/dZF06O1GJ+ulUYPYaNhqULyuZniVaHx7FuamOm?=
 =?us-ascii?Q?Um4f/rkXHSUO3jKRESHhbNh5mfKUMaI/zKBu3jTCC1rjIHXKwdVzDckHy53a?=
 =?us-ascii?Q?ES4y4r2B7wFNMRpFN5ztw+Z5aCxPGR/Ny9ykii7Hmj30sG9HPcTD0repDqvz?=
 =?us-ascii?Q?8J8aK/UV0yWvLGhiyR15WDVyy/PmkaJnqMBDrdaS7B72gSsGxJOONEwDcC1F?=
 =?us-ascii?Q?T0FZ+qNy3UmctyhtP2jfQTfWxH43+ywYXm9twLdR68NxarD4d7KY71/tLXrI?=
 =?us-ascii?Q?q+F3N7VwDr0xdjjrbTAnTEbT1RSK5jeozEMohLEgNd1hs9lpiRAaI/wRK25y?=
 =?us-ascii?Q?gSAHSQpfRzD/TfEUxguj723iXzFuRqd+ZjQOQkq3IM04bkdAUOFgHLNC9AuB?=
 =?us-ascii?Q?2ICAtLpC7YqUaU4ndhsdvi4InXDShpAzLVdjKA1S/FmJlUns7xAREF+grcgF?=
 =?us-ascii?Q?Lm1nWuBzgKjhx0qSjZVmxvjqkvP7t88eZ+fT/CPVCAbNtcwINI+Vw2pcOFZO?=
 =?us-ascii?Q?3VbwuEoUBZalIVhyE/2aIJdzUklFAKtzE1vvTZmgesnNVuGL1HICylW+oCyR?=
 =?us-ascii?Q?ZBmHOORbthEAidVKthcDr3TgmdJwgvXBdX+JsCHNrsH6MT9f3zeWreuigxh7?=
 =?us-ascii?Q?1iiTzi1LJshpd0giB8DXsHzCgXfHhT9Nd?=
X-Microsoft-Antispam-Message-Info: fAtlrdFKewPUZ5xLMDvrhKeXQqYcyqA1cktO4JFbaT9rUQFhzoSd2az/kJOtHVhrd7AN9RYPS9g67XUuu9Fuz4OQuiXBJNXsGpMrzMxbrA1eaaYvpCbLPKClK7oLIZzNSsiVH5w6d8bfQ5+t5ezaM8nVKVWd4OPXIWeXSQA+MJqSLDO5iOHhUnw/YLbRyN0O+BU+krs4ctKV7WFId9mEGOrFctwk+N+LAj/ktDwo9QuIAPJPRzrfhsTKWdDvJo4fRpv5b4+u9MdQEpMvBgVxh3YIi5oSsavoncLitQSFIn/sOfPYr5VW7CzYBl69kO6L7PBVQUicp8NyXnuZS1i9wvecbH9FvpJupp4x6pZNw5o=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:9a2GWjgSrPpbcIfYRQohvZ+eK9ZBM6hM7lbCH/F6obS871hdywFd45zjXrm1KhJip8kVAMBaxOLaJnGkeqZMJh0wX++M68OYbEvRu6ytmIQf0uCGISMV5UZrsOcjQ6V7RHu3nFzuLRtKRTvOiy3Ouuunb/7Bq0WS+LGzN0EaoO3Y2UEuTqhlZGH9sFmFlv4QbT9q64MFbAyspAreha69Y5ISewg7uiygOCIZ7S9sRIUrs8KEbdj95mj4eEsEpdtE6jCYr9HYX6UNDoyataoYLdh698jHUVf8prhyOObirvvl24L05DwBMzyjedPahk+4ILlTT/N8ZadLFmAWqc/tMDk8s1ysYsxEnFin23pNxk+ft388G16YvJxoBGeWbXH3fsGrcXQV30XuqCUdSdwBN/mXe67bsvyfa2JngZkNyhMhPzF/HDQv3t6+OGvIeC5Im5wqIfBrSD/UcZv1o35qNw==;5:8n91Q4zKZEcWgat6CgOOV54vQR6G79sP0zSVDOyieTrPfAuatKyqkrPCgExPs2zZLQQnZlinlC5EKKLINGUsLqQW+u4ofPv4trTbF9HgigFDYuMMS3JAfwtFbpnU0nJt6W6i/SddsvWBSq7dZKdTl8Br8FlNiVugEKz590C37Q4=;7:EqbJcVnW4FcmqzRV7N1eT0KQ/MeZ6Q85cRfiEVrmULdSwZqDh1HMN5DjsTuv+AEzjrpV41IMSJsAJ/scKKxeUFALRVgwihGe/sXj6abidyLY2tFm2SIo7SLPj3n/a+HSBffae16bPoe1FSzvaLEWDM9IAe2enTkz7iXj58iXMXzpUk0bYIDa4P1YkRr/dCBQb1WKU9f79ptZGQMoW15OLGBg98BzT582MaZnqj79IwEdIzc+6H3efJA0v9fh5ZhB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 08:41:04.8737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5941b1e-48e9-4842-7bb6-08d60cc1ffe8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpcv2 driver is NOT just used on i.MX7D which has Cortex-A7
cores, but also on i.MX8MQ/i.MX8MM platforms which use Cortex-A53
cores, so let's use A_CORE instread of A7 to avoid confusion.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
no change since V1.
 drivers/soc/imx/gpcv2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 6ef18cf..0e31465 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -20,14 +20,14 @@
 #include <linux/regulator/consumer.h>
 #include <dt-bindings/power/imx7-power.h>
 
-#define GPC_LPCR_A7_BSC			0x000
+#define GPC_LPCR_A_CORE_BSC			0x000
 
 #define GPC_PGC_CPU_MAPPING		0x0ec
-#define USB_HSIC_PHY_A7_DOMAIN		BIT(6)
-#define USB_OTG2_PHY_A7_DOMAIN		BIT(5)
-#define USB_OTG1_PHY_A7_DOMAIN		BIT(4)
-#define PCIE_PHY_A7_DOMAIN		BIT(3)
-#define MIPI_PHY_A7_DOMAIN		BIT(2)
+#define USB_HSIC_PHY_A_CORE_DOMAIN		BIT(6)
+#define USB_OTG2_PHY_A_CORE_DOMAIN		BIT(5)
+#define USB_OTG1_PHY_A_CORE_DOMAIN		BIT(4)
+#define PCIE_PHY_A_CORE_DOMAIN		BIT(3)
+#define MIPI_PHY_A_CORE_DOMAIN		BIT(2)
 
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
@@ -167,7 +167,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 		},
 		.bits  = {
 			.pxx = MIPI_PHY_SW_Pxx_REQ,
-			.map = MIPI_PHY_A7_DOMAIN,
+			.map = MIPI_PHY_A_CORE_DOMAIN,
 		},
 		.voltage   = 1000000,
 		.pgc	   = PGC_MIPI,
@@ -179,7 +179,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 		},
 		.bits  = {
 			.pxx = PCIE_PHY_SW_Pxx_REQ,
-			.map = PCIE_PHY_A7_DOMAIN,
+			.map = PCIE_PHY_A_CORE_DOMAIN,
 		},
 		.voltage   = 1000000,
 		.pgc	   = PGC_PCIE,
@@ -191,7 +191,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 		},
 		.bits  = {
 			.pxx = USB_HSIC_PHY_SW_Pxx_REQ,
-			.map = USB_HSIC_PHY_A7_DOMAIN,
+			.map = USB_HSIC_PHY_A_CORE_DOMAIN,
 		},
 		.voltage   = 1200000,
 		.pgc	   = PGC_USB_HSIC,
@@ -261,7 +261,7 @@ builtin_platform_driver(imx7_pgc_domain_driver)
 static int imx_gpcv2_probe(struct platform_device *pdev)
 {
 	static const struct regmap_range yes_ranges[] = {
-		regmap_reg_range(GPC_LPCR_A7_BSC,
+		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
 				 GPC_M4_PU_PDN_FLG),
 		regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
 				 GPC_PGC_SR(PGC_MIPI)),
-- 
2.7.4

