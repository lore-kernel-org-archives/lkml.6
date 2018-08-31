Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4837C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830CD20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fi9wpacu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830CD20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeHaMEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:04:49 -0400
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:29888
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbeHaMEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpOV0UVdB7tPceiSfpMY0xW8Bmh7NQIp2hgvFHKUWS8=;
 b=Fi9wpacuH8yQCpf28XZMBNWisyFR/EvSUWH8EWNr2jWm0Q2k9cH0jFhNGohwUyY3BH4sFniMD2Nfw1vX7KQwl0gWXsZJV8lWx7Yeaq7vwz42GkaaZU4yBWjkhh3eX7j/WqyL/g9AbMVcTnKmvySan159zXPoZ6FznO3mQJqhzQs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Fri, 31 Aug
 2018 07:58:26 +0000
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
Subject: [PATCH 5/7] clk: imx6sl: add mmdc ipg clocks
Date:   Fri, 31 Aug 2018 15:53:16 +0800
Message-Id: <1535701998-20443-6-git-send-email-Anson.Huang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c13d264-c610-4767-36b0-08d60f178c58
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:3LR5rNAqeWnZ5T0GYns4zdjZ7pEY9pgW9WzJPG8mJcWq77gZ9MIPScMKtvRVLOUAiBgBYJJghTx9pl61y8bJJcwLdrLBZMNOu5fAjtO6wpKpxugt5Qhca3iSYLmoW5xzTqkMnzO5D2CDOOTXbj2j0JE2ayk3YLTXMfhC+vmsPdDfNbNz4FKtDrOUONM63g0M5zdkFx5aI7nart1//g3S+CRKcxMizhLuQi+WNTxvvaFDBGcOCIZYxjj2hVD1prQw;25:XuhUQdU5g2advaLx90qaS2fagOmNXOOmeYOjwzT2qIFz6pWdc83HDwSTRCnSm13Mj0fUl0Y0KseDsfFMlig0FoMnddZfJdvXJlS+uCVsMmJyHjgarPxI0/rGX4tqg5rNhXNRRIzgKkljHmx9VZIDMIiSCF9S5wWjSh+W8ZO6zGnV3cwTxpBY0NQqU8vabow6YaPKsolGK6ezD98aYB7/vXxUrAeCpW45sbzzRhUEQK0Fq9XkGJ0yZO+u3N8jv8klA5X+FeP+7VZeQ02hKNrwOlNoYg6MP4VTFI0v2YQLJL/+1kwJpkRYb2+3qCpIPqhXjgkc42AETNl4y8kCfzV2HQ==;31:R0WUqYZ8N7tt8zKVE9hSEV8G6AwNeA8/wkMsBITXAHukymnsX49vk/5UNZTScHYgOvuQq4llAwlEUr0pERytTTMNV9g1VTJga213Kn0URCvFTZCxheAqqg8s5+hRIGLB7WpD25L1IHWlyY7vJ+ZcCf9OXDu80YVkJuB52szf2sdePkMsnJSbB0YB9U4edGMH+YkvJsXdJYONKRtaPKVfpd9Iqd28u5BENErvl/DigtU=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:5Ciyejw7h3IFma8y0FdcL2H4hDQD53mgUwi3cfWokoM18uSRn288l7zxtVgNPcSj3EDs1pdjflrEkGZz29K4u5eu3PuLYT2Zxl8sLPP6Ps65t6Bk7s1sP4kAw2L4/JGGv7Ly28o2uIi3dgyq7FZAJg/CXjVr2Ep+Id3kOSpB2XC15rvX93gcepld8qdUXpzSKfte5sddWuTTD/Q49QXxOdLOrYcXcRLFueP1ufhWhrTwIRHiA6M3UjOYfeOYmF1Lb+MYfSG+ZiNbt2m0gv5A9enxm6YOqnk/KDzdsGWXjpsmBLlnDCN5YkQ4Mjtzv0Z5Cyq6dLnMH2U8AZI8ugTzg2Oj8M5lrhwriKooQnreMiczZQQg0BaXRCxg4VngkBK+cfT5KvlBH7biUUxVaeaSHUyuverkzRH3yhg6wp7v7iLKQ3vLwuWWyDMnleKOtCQSrQLGib+eYbyus4FGSRkYtjN8yikPNyfZm5zVXH2RQiC4MpPR6VVTRo80n0Vyp1h7;4:vnHnBQXuUk6XbpkcKLCnwqvn9X+H5raTG26uuOBYr/TPoRyiGEGe2JM85EI56+NTJIm4A53fpUZQkrrKLxCvY4gAsaBu9/xc8uHHKCyXobf8J5FDzcOt/JS7Z2qXGNfl6W1JIQzYbD/hwgBqq7YSnLbF2Hk7HV+1QHjIKQaM0MdTs7IlvM+bBUH0xuenc+oFSvho2i48qoT0H3giS3galxDsZycIVwzxCrzvihfuWEQagqlNUE1s1qcp5XABtRSqpvsnYIQK5g5KjxwQm6Yoajj5qRI/C2j4FzCpGCknZY1sdy5eUAvX7o+0hMCOt7ws
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3907A27725C79315DA38433AF50F0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(106356001)(105586002)(86362001)(48376002)(50466002)(76176011)(478600001)(51416003)(52116002)(316002)(16586007)(25786009)(2906002)(5660300001)(305945005)(97736004)(4326008)(386003)(6506007)(7736002)(53936002)(50226002)(186003)(16526019)(68736007)(36756003)(8936002)(6666003)(26005)(6486002)(6116002)(14444005)(3846002)(6512007)(66066001)(8676002)(47776003)(81166006)(81156014)(476003)(2616005)(486006)(446003)(11346002)(956004)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:cmMZPYjshsL4qwRHVOcjVCS130QpXtxGWBMk9HV?=
 =?us-ascii?Q?KRn5dFhg9/xmYVtFNPL0XcHPpXz7yE0as81eAwzibYaNAgt3fcAwe37qgifY?=
 =?us-ascii?Q?5li02W570O/q6wXYKkoflQqq8F01+0EcoE+hlbmEMZxkVcfuf0jIgsgNj5Pv?=
 =?us-ascii?Q?kDEOEcbI8a3eu8dtcUZdoOsiC4/biyvInvD0uP060H7pc3AVAMLovV+RO04d?=
 =?us-ascii?Q?Hfq9AUXJhRfQUJSryXcXb0cg/TQ2vQ74AwxfUH2W5dc4glnPgvppGaWSgmXX?=
 =?us-ascii?Q?rLTJUQbn9xulp6usjSHErzY+8xN77P4qDaRk9NZycn2rJWyRn+NMND6ihZu/?=
 =?us-ascii?Q?ikXUE+pLUekDkoIOAmyTIB04qkdFGMhku47WZJcRHxjuUQtan15G6PQCd8oj?=
 =?us-ascii?Q?h5+xUBphU6Yrl91WpKA0XPS7kHJvfTXwKGuYlcEjV/KeEDX57FQUeRm4fCGB?=
 =?us-ascii?Q?0yjLK4aWWxzB4eMxxeDRGZOFa5NB7JwN6WGrRepbQ4CxmhqXyasc8V5eYeAY?=
 =?us-ascii?Q?dDm26cgprscbb6KJFB40yFMDJLZ7YCgNsD29Ly5rGd1rQiUNXVVc0u9BhugD?=
 =?us-ascii?Q?/yS+HX7r4z9NVfbdldvBBZiFN5hhK3pR4ksixQESxu6J4xnSvQ/uHcGd/gAQ?=
 =?us-ascii?Q?Dwp7uWZFgyuO/keerYxuHCTYQT9vYSOIn1ahV2chFHrBmKpu9zqzasmFrkbf?=
 =?us-ascii?Q?PvimThcYsH/hmXkODQ7TEEa4FZ/KbRB2OozcUrEa99gbjinRjthcwE6EvQrH?=
 =?us-ascii?Q?50kZZpMOPCT6GKdR2WYglMXpPe2GgG8PjX7RcBHNTw/rKwxUlEn+fBBepH8+?=
 =?us-ascii?Q?RjWoMbb13JoWOR+NvxXRm1atcRLP/wUG/c2Z8elxbGcPS2Qs7Njs9XCWHwSJ?=
 =?us-ascii?Q?lpXwjR77IQhFq76OtoZNof7V9rsHFYqsdVcS0ULEwY1u2WcTjno4FwRlQOp4?=
 =?us-ascii?Q?FMBZQbJAjVYqeecSpSvsCDrdCrPO5sEflzX9kOgfSIDa4btBIOZSPZn+6J9y?=
 =?us-ascii?Q?bS5d77hjlkS9MuN/l3jwXNnaMnil1UIBEbAK/+JifC8CyqMzZ3W1H0MMQC0M?=
 =?us-ascii?Q?B8d1eFJiFWfYyFKFNcvQAp8ZVjvuxP6JRX2iKlKXFwXYjH9+GqDyYlLKUl0W?=
 =?us-ascii?Q?+UvPJp0RZTsb54g0gbbXaQdY9huvYgVYqkW1vDqeDi6823P5vFtUyqlsoSuY?=
 =?us-ascii?Q?tFKhLFzwff0DYMo5AankFNUwbFS6owBocqKY7xXCOFEshD/OfKEWi6xj5CBI?=
 =?us-ascii?Q?rA8ln1tcsF1ih1M6cGTA=3D?=
X-Microsoft-Antispam-Message-Info: 88A8xofDD0HDRXgQsmpNz6ihdFSlke9785BUCOoJubePzFMjL8aYLgcGZHRtCDNs4a2E8jrIEu0P9bWhI98hwgal8w/G6y39wJtVMFJnJz+tvoKodYW0BuKabyJrqih8Zpeb8Gs6w5MTJssi0tn5/cbiRGiJVyAmQLG0r6qL6CXsmUbxybmhqhYQ0+uoRpLCRSlhB9d7PLG0ynvYShji4wWj3zXJd+O5GhXSSPExqJETsdCkD8sEkTSEiE1SheQkoQYJhY+PpiMIwrU+6PEiXta/ZP6cdCQP4SldC+x9QZS1GQxRxIjCGES5Jt4jFPesbZ6BVckS4X5WeChDLIqa0SGkefWStSM6N4rcXbK7QI8=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:1SxDuMHe71nNphs7YxDGik6q9vFgCNaekT1yVu5SG4x+8okOnhmjESSN97PAS6Iq1ovXPf1+b+6zYB/pfASvozgEYnZijE3Kr/0YtgYYBnAAFhE+kYoavmu233FEMcr4qEpBeDrIAHsR2llOYZuTsjjU8LmLgRbq4inwSMR3rR4ay2ttXQYILNXvWgPw1TJFhJORAYua35xbAf6InYSdvrHVfCkcf/uLgn/ZzVGWErlRkSm9LxDwMm4umaeHu3uMlWl2uThx+UWLqxIqW7gtEHnecigtxm2xMF9xzZ26iJFZEyejWPGlrg2jsp2NnNlLNZsEEZ5GtY81D+sx4aEOdWlVRUVa0hO0eVx+0OpgbNq7U6CGQnEPIeZRH9p9Zvq5BjGac2DkEnXiPC66RWQljGYovDW/2cHaTHpu/Jhe6PjnzEoWFrYvmY8dp8A+10WMwkhee4sjfZPXsFpfuwua1Q==;5:4G9Z/Xrdn3rJg1umO44lMyUxVgkYTqtHUDl14ZxoPE5SW6KB3Fz1Ljsf3Ax453zoVqO4dOB04kgzhB+yISVcV/5vshG+tstXlMgvFGNqIjE+6mE1+Se5jiEjccYWy0WytDM+KJBNqiw26HOYIumygOY5mNOVQQ30mLymO8d/xPs=;7:x7dJ6YeO62APoRz5DWtQKN8wOd/T5DO96UZ+IDbkdNQGktbzHx+SOVhjh1Iv1Xst/v9JQWMZkCy7X+Rj5tjwMX8kHSn6RAOmnYU5c8NNBqH1/17W6zoesvrVLttl/M/B9lvb1MtrhX4LeHa6EWADMkGwE1mE5ASXGTKj6PJiiOrpfRO09pwM1P7aiCjEMNOxG+HCX/o1t8PbnOyXsdXDJWFHbncb8VD7lxizkiwwLCT4z15tor0PYJ2ELcoG6pbe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 07:58:26.3383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c13d264-c610-4767-36b0-08d60f178c58
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SL has MMDC0 and MMDC1 ipg clock in CCM CCGR, add them into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sl.c             | 2 ++
 include/dt-bindings/clock/imx6sl-clock.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index eb6bcbf..6fcfbbd 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -386,6 +386,8 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_LCDIF_AXI]    = imx_clk_gate2("lcdif_axi",    "lcdif_axi_podf",    base + 0x74, 6);
 	clks[IMX6SL_CLK_LCDIF_PIX]    = imx_clk_gate2("lcdif_pix",    "lcdif_pix_podf",    base + 0x74, 8);
 	clks[IMX6SL_CLK_EPDC_PIX]     = imx_clk_gate2("epdc_pix",     "epdc_pix_podf",     base + 0x74, 10);
+	clks[IMX6SL_CLK_MMDC_P0_IPG]  = imx_clk_gate2_flags("mmdc_p0_ipg",  "ipg",         base + 0x74,	24, CLK_IS_CRITICAL);
+	clks[IMX6SL_CLK_MMDC_P1_IPG]  = imx_clk_gate2("mmdc_p1_ipg",  "ipg",	  	   base + 0x74,	26);
 	clks[IMX6SL_CLK_OCRAM]        = imx_clk_gate2("ocram",        "ocram_podf",        base + 0x74, 28);
 	clks[IMX6SL_CLK_PWM1]         = imx_clk_gate2("pwm1",         "perclk",            base + 0x78, 16);
 	clks[IMX6SL_CLK_PWM2]         = imx_clk_gate2("pwm2",         "perclk",            base + 0x78, 18);
diff --git a/include/dt-bindings/clock/imx6sl-clock.h b/include/dt-bindings/clock/imx6sl-clock.h
index e14573e..cfbfc39 100644
--- a/include/dt-bindings/clock/imx6sl-clock.h
+++ b/include/dt-bindings/clock/imx6sl-clock.h
@@ -175,6 +175,8 @@
 #define IMX6SL_CLK_SSI2_IPG		162
 #define IMX6SL_CLK_SSI3_IPG		163
 #define IMX6SL_CLK_SPDIF_GCLK		164
-#define IMX6SL_CLK_END			165
+#define IMX6SL_CLK_MMDC_P0_IPG		165
+#define IMX6SL_CLK_MMDC_P1_IPG		166
+#define IMX6SL_CLK_END			167
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SL_H */
-- 
2.7.4

