Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966223AbeEYKjJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:39:09 -0400
Received: from mail-eopbgr10095.outbound.protection.outlook.com ([40.107.1.95]:20608
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965255AbeEYKi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:38:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        linux-imx@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V3 4/4] video: simplefb: switch to use clk_bulk API to simplify clock operations
Date: Fri, 25 May 2018 18:37:23 +0800
Message-Id: <1527244643-10736-5-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To VI1PR04MB4224.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4224;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;3:bECSzYm7RWW/+qV5jNkoChuwNcDgZS8RvCe9vDkmAVWBfsB3o/Rs+nHzAQtYK/EzewlP8929pQda97KEI9oIN7x8PIUcuQbG6Q13yqYMvht6cDEf+ozLrXW0LfBAoJ8Lql5fTcV8H1oDv5f7asJ3FDrt1BDoBtl9lgPgTrwMzfzwT4fkKFuCUk7BK/JXwXz5HGZM2V99/yDVTEHPxOV/ERI/OvwuU6A0BnOqvK9tVUZwrz/5ZwaN9X6c70WzvOhx;25:J9cLVfAkAYXH4PG6gHr9TEw+yNsAPjxhOBFzF5ICA1wySoP6inM7RnftYZ+C4ALX/trad/JGaknKdCrgtVX1HbbzCnCvnhd4REiKxb1zspRY1JDkVhZ/B4LOivDpsODV5v+ctr6XuKGaFgpSuxoQW2rEkz9B8w48973xtbhoaJlbnZbAWEas0lUDGWWiHDGZw+JDLdckMVKZPiQb5CIIoTVZYms7nILVkmLrX3bwvaC2/R6h+Hij/ewCL6w8CDs6cwVetVKKGblRggiI6YOW7/J5Dmp2ULh0I0AigR03WX4UsNk5GELowADbc/Idz5XkjRBFVuWidpM7tKc211wMDQ==;31:D7IEJOMcYBjLbtOhvjW7qxJNNzg25ekguZqBTRpLkgYJRv57x4UYgDYofIESpncVW1E23XdRTL15vHVMO/6Llq2CBMDVbFHt4cbxTYSSWyrZn9f5h2jxLL3KZRINQA8N7C53Ufb+E/BpXFvbTjyZvu26UUOTl2Wrl81XS19w+Fb8Tw+xP3BiA7xQpnNKbTcNjXgcebMiqL8mbYtIv/VGQZO7tztTIRFryCd5sVWFTvU=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4224:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;20:vhE0eg/xBpIcxwZ99Gv9K0Fi6Pa/kPNyWLJCu+rMakCZ8tDi33qnfUNzk975xbp1AKtbH8QydlqPaqg6m96Iyq1z5MJ4/UcbKzBd48zmiIqTbWPQvBCG3pihC1HlERQh7xQYFgkSVe8sb30DZKz84SAAS2do3JUj+3NGZ+aY6QOdC3IuGd4eqgBsriGjeDBFXQITnkJzsHsFge05wzVv33CDXWCgDKeS9Iz4MSZU8WgMf3Znq5nCD71m60eBZPx4a/Wm7eECdq1RBpU4RR3hKAaL+dN/wxAGS02obGJtMoCnwt7WAH1QOYhefPk2QO0R6QkNlMWWAgZiqBunlQ81yK/G9LDa/JsJde+sgljVlaLUYlnhIOwuTMiMbUr4xkOMaGBNeKsqP/3HrPBJAv94RN7FZvO4/0kTrbOjRp3VVt1N1hNJ3kuUBEEWqdiwf2ZpzW9wzdkuoP7xZkFAADGHis/18ICIyndFycZcluubCcZ1C3WJ70qBhO6ws+8Gj4af;4:ef+LwM9JE/VmXkbpKoYMbckd5HmwRSX9KveMj+aZ5mhS4ZwcwBhhAQuyZcXJoYyBleM8Yq0MJUESmI3VrXMHCkT6pFXCtqq2ERRk4etfj4SkP1+9aVMU6mJtq3eI1Vk00BG8NpaAUADLd3yImFC76O8DH1F9Te5B9/6vS+KBMJofxlNbxmXu8U9it3aSNRGX/Cizk98GJzlbWpoTEgZdm/pS6XfiyvxrwGNgS+cFjLUfZu0W+EWkq9jY0icbTK5M+J/jHd3KZ2Ss2GYNr9ilt+InIsQdbtZFv6aDyCePCW9rvxTEhQqAVTcEzwM/nBMi8EPnjkoDwtjfuA6/yZnCwdFOFg+Zvpg6AIVbDqpynYd3ANhza8zBBWTukIkn/EKi
X-Microsoft-Antispam-PRVS: <VI1PR04MB42242F5C977F3D6D3BE1334D80690@VI1PR04MB4224.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(7411616537696);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4224;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4224;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(20776003)(69226001)(63696002)(47776003)(74876001)(62966002)(74706001)(36756003)(77096001)(77156001)(76786001)(76796001)(81542001)(42186004)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(48376002)(77982001)(59766001)(56816005)(33646001)(80022001)(66066001)(76482001)(90146001)(89996001)(65816001)(87936001)(56776001)(88136002)(54316002)(74366001)(44376005)(87286001)(87266001)(50226001)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(50466002)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(93916002)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB4224;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4224;23:xNO5j0HuNOSPg14mQIYcrNX6awkn5lczb6867tiv0?=
 =?us-ascii?Q?JkkW2dKXCLY5azouIecDfFWdThBunUuPin29NwSOp+j6OpAiQyBTrjfC/eXW?=
 =?us-ascii?Q?kkMTpfJcoSuDki1yhh+LUeNcXhmxxrX+R5l50FtpjA/I3YsOWCOsOrcZIzPx?=
 =?us-ascii?Q?XWSZCyLPr2LzqPo2nmiRp3H+mGnNDJ1+500ymD3Mur5O9Em+fmL8ZfWh6mB0?=
 =?us-ascii?Q?3ZA+U2nkJC6RAHd00TAObhfo8kn/81HEp3S6NPTi8OpOSZwJKI+Ha1CzlY9U?=
 =?us-ascii?Q?M+/HRPMk6TcOfcwLY61hoaMjoBlaIbXSEQ7B2+94BS0wJRzIfAfT8vK9ncfi?=
 =?us-ascii?Q?wEfwaZa4rBJEj/F+zLZWj5/AcNP8jg5CUDmVzFpSf2JRQ6XQz5I/+aEm6QIS?=
 =?us-ascii?Q?tdBNG8986p55EjI/pMtY26QNcSNz50ctuc++/ajIN8Dl+hUFdnm5eBJWitzF?=
 =?us-ascii?Q?SMm5Ylvno9GwwUEzTey6ZRzxxLAjuzirUb3Dy70Lhw4UufYcNLJfquQ2oYtL?=
 =?us-ascii?Q?w4XnjLcsXGR1sA4p47+S1FzsDAjCcyib5xcbK4rlWLdSz5uKWLl2a/RkcD/D?=
 =?us-ascii?Q?250pEvR32iEQWRyhp4H3Po8kRhiMNwS1iPAlIDmdP4CLfak1UgwZrXxqoieB?=
 =?us-ascii?Q?nkSYODB2pjQ3zoAXOwgXVszf7iX0nEPgFzpPOuCGeSsShvbD7MK7HZVLCYsg?=
 =?us-ascii?Q?7awGj1MZ2jQnyH6rRK14zyEUbdLgpKCpsvgyeKIPeljNZZ1dwghgLSRGHLMZ?=
 =?us-ascii?Q?/bwbaMwsFK/IFavWg97tDLexwm7oEdkW0SseELR8AC8GUmINndGs2dEbWgP9?=
 =?us-ascii?Q?WDHukx5BGYxN5Kqv8Q/Ux5ask0AjY4APECX54ctj+wUudFZYJI9WqLLlm2+v?=
 =?us-ascii?Q?YnmsI3ThvhDAYfF1MWdGIGaqPSqdDNWt6yojlQ6542F+oEA5WsVhMuqKtNu1?=
 =?us-ascii?Q?d6icYJnf8uDZ3icYoZ6amHi1NRWkTFG+/b58vUZSX52TwJWlFaN+ee6CZrOi?=
 =?us-ascii?Q?VLbEYEFbEXlfNHuK6OTHw7E1ItyFryNaBqawtTeaHiUB2KWeTEoMUkMua7cW?=
 =?us-ascii?Q?F6R4I1WhJ+jcpC2cfKJXN/TztabhA3a2IM4CQBWelACg6RMS3iI3y2Nd1589?=
 =?us-ascii?Q?OK9Glf8E29KaujhdyumCwmNLFksHt4WsZIBbivnKrRml++bpAmZvixFzGrsW?=
 =?us-ascii?Q?BoWqJzMRZ/oHcXm6hYT4dVQX0EnwY1rGd2R9kJqyt/6XhiF/mFn3cvdxd8OK?=
 =?us-ascii?Q?eZSgwhaklp3GnptMsN851rl2iGh9mCDdO9qn50H0WgFjrlEYjOBC2oqX7dDg?=
 =?us-ascii?Q?Rp/HL9JD/DLmigY2JevGtbXQyu0HonRpM2kfLIdyeIVYdJ0u29EduoYp9wPq?=
 =?us-ascii?Q?Sq1xlFuimaBqKDWc6x8uT1DpNiVCVQsX6l0oxqj619TibTDhgAKIgRcTqgK4?=
 =?us-ascii?Q?Ze+6mhbPbVKZvqJJ4Y51ppnEpYpcJum0x7k00oJGWKhwAOE476b8/7P0M+XR?=
 =?us-ascii?Q?SkN5v7VzPzIUedyC/XXxy+NwtSWdTc2OSC6Jv/zxvrtDlFwmYN3GAmVenqMr?=
 =?us-ascii?Q?3Vhah9aTUxn6jS0V/GpivRTw/sxyrXSukZ4C54rmXJ1qQEL8jVwMsQxip2B9?=
 =?us-ascii?Q?qNhmKVM+U/0hlWY9x3TEEROCrJPzkQUrAoQQZqVlA9acMwoH5lOCH7GECwKo?=
 =?us-ascii?Q?R4rJXkNjP6KGEe/wDnjedavt9NoDT2aunynrW5tJb9MZj+cb8xCW76dDFSAG?=
 =?us-ascii?Q?VPF0BzuxcYx0oSDNf2ACE7+QD0kmU4yovyftIyP1nzU90Ce+q0=3D?=
X-Microsoft-Antispam-Message-Info: 3Jgb3okSW05qhnVr9DtnE0K0qq9se6kETE9SmwNZamytRzj7CzEMBO1BJstMRv/L1Kv+/mOFMy0jyU/pYsZCST9UgAKFZq9Ko7067iMuVg7edvpdeiVnIxg4Bmcqv4HU8JOQLnoxJVJMRD9KgHXhY6qTFJPVaINz68ER3um5pOlFD0GRIpvDrCs3AMf9eAD4
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;6:niAlie7/7EDan7U+Xm6Fbld/J5wj5JR/9lbYcONe6h4PtDq0IH19fNZ7MYuQfnRDuOY5Kmwnk+BcHsCUzyfezZ6Nf9ibj8irxm8N+G+KZt713Nu07+oYKOusilUbii67DTNTvH0P43D25bhITuPnkqebjwsxa1SJu25vHx3AUotPrAkJeEVafFB7USclA4FgECeyzGOTM0Tiw6WO9lkWERmYnRfC5sOjwccS1siM63X0iRxNxcQQ2iZ8XpLeLBA5E6shokcRtDzfXRh3VwDoSR2WyOSWjPa80advP+gMMkKu4CtnRSVxBXbN4iGAVsb7yUadz8Pwc7wvpNC2JUqgX5lO73OSSA7zaM2T5++c2PJrSZYRuKCfQHIXkpb+qipWVQX6zGKYIlXE4A18oFQy3TkAlw6+0rQVurSBDbbnGPqiu2sZb/7CHSs3oapw9a5iDG0qjXBG3KDji1TdJXApxg==;5:kpVJKvUFtpBAL2ozPd4P9mIAA4/3dmAhOWJH/qpg7U1mGZMUuJTTp/4bZH7gj3TchUYdt9NuN5L/2EWpwXU9LVHt3kt0OaRGD9KdsA5COcdtWYUZHLOUrq/8BiMcBHEWKAhbXONfBtqoKeUvSTeuuOLVxeZb5UKLhAFpOMoWiUo=;24:1TM9bIzqPs4InjIc/u2O+ec7YJryj0baYmk/RZwvmlPyZEN4SxXNtwt0WjZ0DskONYDNpTfWpf2VtG9MTr8lEWo5oTyP3VD38WeSDVkGlAU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;7:Tj8jhS/KK7Rrrn2DwkVN24DoGvrepZjmKYEW6ErJsLnWyJn08UPGouF1HJQhuCfjMc6UPQxrv9GX6OoumUHiEzZEWFs/6kEK8NMSNVNQBpCuTkLwJLgIhhjmOmFphKARxQwijiP8xSEufyH7VwHKzHB4EIyM5MqaBujWBE6PHDkdcaSh2x1vyZ+/Viy12gzpdrUtvndYzV0YZ2uFg3IgqS9rGPx5yMcyC3QsCVSWXRRlZ6T9UruWnlmojm6ipLyl
X-MS-Office365-Filtering-Correlation-Id: fbeb06c1-da27-43bb-2d6e-08d5c22bb6e4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 10:38:51.0582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbeb06c1-da27-43bb-2d6e-08d5c22bb6e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to use clk_bulk API to simplify clock operations.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * fix a build warning on x86 platform due to a wrong
   of the prototype of simplefb_clocks_enable
v1->v2:
 * switch to clk_bulk_get_all from of_clk_bulk_get_all
---
 drivers/video/fbdev/simplefb.c | 66 ++++++++----------------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index a3c44ec..db74354 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -182,7 +182,7 @@ struct simplefb_par {
 #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
 	bool clks_enabled;
 	unsigned int clk_count;
-	struct clk **clks;
+	struct clk_bulk_data *clks;
 #endif
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
 	bool regulators_enabled;
@@ -214,37 +214,13 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 			       struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct clk *clock;
-	int i;
 
 	if (dev_get_platdata(&pdev->dev) || !np)
 		return 0;
 
-	par->clk_count = of_clk_get_parent_count(np);
-	if (!par->clk_count)
-		return 0;
-
-	par->clks = kcalloc(par->clk_count, sizeof(struct clk *), GFP_KERNEL);
-	if (!par->clks)
-		return -ENOMEM;
-
-	for (i = 0; i < par->clk_count; i++) {
-		clock = of_clk_get(np, i);
-		if (IS_ERR(clock)) {
-			if (PTR_ERR(clock) == -EPROBE_DEFER) {
-				while (--i >= 0) {
-					if (par->clks[i])
-						clk_put(par->clks[i]);
-				}
-				kfree(par->clks);
-				return -EPROBE_DEFER;
-			}
-			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
-				__func__, i, PTR_ERR(clock));
-			continue;
-		}
-		par->clks[i] = clock;
-	}
+	par->clk_count = clk_bulk_get_all(&pdev->dev, &par->clks);
+	if ((par->clk_count < 0) && (par->clk_count == -EPROBE_DEFER))
+		return -EPROBE_DEFER;
 
 	return 0;
 }
@@ -252,39 +228,21 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 static void simplefb_clocks_enable(struct simplefb_par *par,
 				   struct platform_device *pdev)
 {
-	int i, ret;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(par->clk_count, par->clks);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to enable clocks\n");
 
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			ret = clk_prepare_enable(par->clks[i]);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"%s: failed to enable clock %d: %d\n",
-					__func__, i, ret);
-				clk_put(par->clks[i]);
-				par->clks[i] = NULL;
-			}
-		}
-	}
 	par->clks_enabled = true;
 }
 
 static void simplefb_clocks_destroy(struct simplefb_par *par)
 {
-	int i;
-
-	if (!par->clks)
-		return;
-
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			if (par->clks_enabled)
-				clk_disable_unprepare(par->clks[i]);
-			clk_put(par->clks[i]);
-		}
-	}
+	if (par->clks_enabled)
+		clk_bulk_disable_unprepare(par->clk_count, par->clks);
 
-	kfree(par->clks);
+	clk_bulk_put_all(par->clk_count, par->clks);
 }
 #else
 static int simplefb_clocks_get(struct simplefb_par *par,
-- 
2.7.4
