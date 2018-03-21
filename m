Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeCUHzz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:55:55 -0400
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:43264
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751617AbeCUHzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:55:46 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <mturquette@baylibre.com>, <hdegoede@redhat.com>,
        <b.zolnierkie@samsung.com>, <linux@armlinux.org.uk>,
        <linux-fbdev@vger.kernel.org>, <linux-imx@nxp.com>, <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V2 4/4] video: simplefb: switch to use clk_bulk API to simplify clock operations
Date: Wed, 21 Mar 2018 10:54:54 +0800
Message-ID: <1521600894-29919-5-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
References: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131660925451244226;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(39860400002)(39380400002)(376002)(346002)(396003)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(2351001)(106466001)(316002)(47776003)(105606002)(5660300001)(16586007)(54906003)(81156014)(26826003)(81166006)(51416003)(76176011)(2906002)(8936002)(336012)(8676002)(77096007)(26005)(48376002)(104016004)(50466002)(6916009)(2950100002)(6666003)(450100002)(4326008)(53936002)(356003)(50226002)(68736007)(36756003)(508600001)(305945005)(97736004)(85426001)(86362001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2762;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD027;1:Xc1GnRNIlc6zqfrEaVN9yClmm5y73t/Kn4tFJ/5DsaxcOuA4RvZ9rbS1bBfDNbWo61S0Gq0YCOkKHtST5jyAC10XcbnYYhUYi8/YK4wETOfScx1ylkdVr/TqnO1BvKmC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abdecdaa-5a8b-44c3-b161-08d58f0126c6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM5PR03MB2762;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2762;3:r3s+0MJP8iwsTOq4E6h5qRYJwCIsrOcPlAxjH9JhjpZyId/FIjINSNYuNQNmj3Vqu5YXeyNyfxkhvGHa1sLiGafFl1E24seE/z8cLFQSC3fEGE5iseJuQDjeHUDblNXP7JBbKv63mMAW727yH6vIBgSPRWIdk8SyteWKbaMYC5O4Zmetwqb8N9g0Idm02ltADGXt3kqNRE/4fhwTzVy3mgVs9WZ7ZswvJ1c3UgD3ztqs7ThwRdIeMxT22ak3MMHGyR3tei2v/3IDz2dj1mOMPBkEhN4MR3tRlpkFbggjrpv5dAAoM1dB9azDO9Mk3PwnuLkT6sNxfQ35VjQ+jvC7JthY8CqZWS71dmrGHqaaVv8=;25:rydAhR5D1IcUwCmEfLoV14CplC8LKdYP7IuN7qas8mIz2t9YcqnAjcvGcQQ2kr6Eb3rD+GKwMlo4NbwOztaCqWNhmf+e4CzmCYRr9E5+oNC8VX8FfdyyMxlAVszYO39sQeTZFEHkkJu0Zr+CTw8zIjSubLk3rmizh/+IBTB0p25QGl66AdBph7RZCea/X71E+zI48dsUrtmOa9djKt1YKsRuEJqhEtxAUMfHyDhxViwZXdp4EKgIdxuye0l0x85rNCXYo41oZwiV5QVQ3GHp2nf9M+NZVzlEY5+zO8zoj5c3aJkozP/v1dRZspeakHPiF7Pmy8QpFQNlow7KIM5L+g==
X-MS-TrafficTypeDiagnostic: DM5PR03MB2762:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2762;31:CkTohlD1i+IVu0mmA9XYevttM/9tHAe1vKQ6LMTkpWtPx362NudSQoe7ZXVlTR8DAcvSzYQTSkhGqItmTuNeCt+zQlNL53uiZzSQDaRDpeNf2cpWrMfg+YffKgZbHlJ+5TUktBUTW0HyoHcrTu4xq9+9liqnl0UnMsS6cpmKvIah7sYp4uAcdECKEnT8hErDUMeGxHMppd0JDYY/N8ML+KPrNapSTo5Cq//hq+AruV0=;4:By9NjLIT1lGJBPm8m+TAAL5yLpvTHJyCXbLEYeBKJZRUKZqEbnmHCsDAH783EjagJIhG43agcn4bExXsxP7BytnlcANUjrq4dboY+t48+Psc8slVso0gTo6sitB9ZgDVSsf0CX8GrjGNSEvNENThIgZAZt9sHnypFSmE2VhYCYYb+vrL0Qpu8ahQCy7bQ8wpRB8g2cppIpW+a2ElsVHH1ehroPhaPUwZ7L3KEY6vw3scG1SzZl6X+BxNZzcs31uecD8YG7nxeDzIwpdVv34AHueq56DrjQHfNr/wMKigIsqyvpe1++BYdd9l4AXkbMdCrublePPuB+RlKIpTS9Pt2lfreZ1gvZbx3VlHrecteb5rgDWTpSJyKyrdcLqqiYuZ
X-Microsoft-Antispam-PRVS: <DM5PR03MB2762D210DC3420A19426162280AA0@DM5PR03MB2762.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(7411616537696);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501320)(52105095)(3002001)(10201501046)(6055026)(6096035)(20161123563025)(20161123556025)(20161123565025)(20161123559100)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123561025)(201708071742011);SRVR:DM5PR03MB2762;BCL:0;PCL:0;RULEID:(400006);SRVR:DM5PR03MB2762;
X-Forefront-PRVS: 0618E4E7E1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2762;23:MVj1j9tEdvrjHfbzFJHdeM3eLYi03NqHUFpYigce0?=
 =?us-ascii?Q?Nmg98fp8D0AviIYGDZglu8F6gdeTQB4s0gspsDqHuU95C6YErZjNkuklD4Kk?=
 =?us-ascii?Q?pfBUwHsi98vcgrZZUDvm1HnPMlsX4cK2nxISVVj5qW25sM/yYHXCPCUByaM/?=
 =?us-ascii?Q?7+YI6vLPdxh3uCmxLPHHx0y64evgvhdd1O1OFNgIOOFkqEZYKfFsW4L1Mca0?=
 =?us-ascii?Q?tOTVrfxL6mywlgZy4ubpHicQODjXv9azU07BqYP3tyfo8ZeNBUCc8lNZaG66?=
 =?us-ascii?Q?vD9tYVauTj1MHWnvHwnG3ZUk1sQGlxecPCUs7pVIsxm4gzMMA6ybmuaaj96y?=
 =?us-ascii?Q?GdfRf2yFnKCgUTblA+2Mb8DHXG3ernWgWj+TfXHSmDPHxW8SqUA8G1c/3xF9?=
 =?us-ascii?Q?2Yo2Wgoa1GxLBXPWEqGt4PdhYlQNxT8EnDhswKiWJEgZyODJsf4qouuswmDl?=
 =?us-ascii?Q?UKxCIgCB0rF3K4mqrVJkJNGN+ec1pp7YpufuedufPCsFsBmXTQE7NPp9oCLr?=
 =?us-ascii?Q?i8sGXCJdGff3w/FaPRlCJmEkHDhOnzvtM9hXXz7OuE3XgJRzdYJzr7nzUd5Y?=
 =?us-ascii?Q?dJSAAGaWtbNMoJP7OXEsaVNrdy/LYSRFR4cbNKI1d6td9Y5t1Fz5nMug/MdW?=
 =?us-ascii?Q?h7nNK2IFopxcgNZCxAHxaRzstMb8TO5sL0ldGf3nILhxzxpEQZ/lG3tIxhG2?=
 =?us-ascii?Q?Dg9Lp4fXAW8oY6ctes7E22t5QoyKO9j6e9Z3N1eIWydc2vceRl+UP8B6nXIi?=
 =?us-ascii?Q?5S38OXofO6s32693sMJJXLzg4RJYvOZboPC4G6483YFwcfWNMgh5lnc5kTkW?=
 =?us-ascii?Q?Al8KWjIlQ/WIFbg7JB6yel1OrIjRcNEPKJbkja2UiYOV9NNJg538hQcgkTbY?=
 =?us-ascii?Q?yK2RcQ2f7Y/ULM1Df1bHnTo6zvHh+ztulkJvD7gmaQTrYO/4fVK61nTbwGk8?=
 =?us-ascii?Q?ZNIW3wrxWAu3BnfCbt2laewHllxAI4oo1QgVlw9r3O0nHk+4n78ihf7mWEUq?=
 =?us-ascii?Q?dITI6j+wcXEBW0ab7krLx9PB/G19hcNgVGIgnqlGqYdYft8DY9HwZANWJdAt?=
 =?us-ascii?Q?XBXsfK6dY1+zGXCirEGosss1y1hgCj4ymqXWRwHrNWa07jrJoIMybFGmPBfL?=
 =?us-ascii?Q?BhYQKv9b80wV7ljB/OJrXVNJR7461pYYb7uUW5IliF8RfNrqr2SGw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5ekqHlXcZKSWy97eOUfTGCHxIjqS7xoe9KaEuyCoHK/yhvxPRAoPwRDziED1Ja6E2OdyfXc49A27BiyyfIMwyhmuIC6iobQVK4kGwP3ifF3nzBlBnyNG13e9fVv3vCWApKEmiyvBfBvMR3jeBb53qn9iBHiW/9YH1buevVSgwdeKqYnbcsxUWV+ZfcPOCJ05
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2762;6:qO3TBQPADQ+GJqniz+FxdOMwz9KwjNGk9YZUvukTB3VCfpWUSLiy/pgUtprWO6D5rIaQsO0dCMH9rk2+rpMdqdt0+GAjC/xq9erHIyUbMq5ZGv/sVwPSpEOgh5AuVZ0ub4yx4rv1RbwG3s2iVHkonTr3HXfLneCRYK9oTZM0R1dP5nxaFhnJ2QYJPsuHtz5x8Ep70MdastDZJYC1XIPoWRjABxULAmocbgS3i0cXQax/dMeihHuZT4DTevNGMYQuQyJIkP63lTbKOyp6Yd1OJlg7B1UBpcZjiYBd8PwmfDr5dPt27DxeVsVMJntCjjke3xxOqukhuPO6UVaLlQe/vzR3xtKlZ3oPcdZE5Ms7HdE=;5:5OBhjtcluYBJ6t7tC8LoW1tVqwWYxQqxM9116ptziYJwnjgl7ELEiQAvm3NwN9+30ABce5l/xbWMJ/Qyp2qFEDju2AZXS8HV82c0CZzbyq17XB8O0lOSJ/EqCcSa84OOyxqXFbhHB2/5MbAU9TRmn3LGgdA/7fv7/bFYtKMV8p0=;24:Nfzwc7zkfdMnNqPBKofwFxrlHdvpSL1HMc6dgFCCAIQ745+M4qoMnGYAuIlReuJNJkdBdI5b9Vv+N4159cj5w/lYH86kFgJkBgBx4/Icc0I=;7:/iHSexAwiPSF2xR+I0ai6+I8ObDVgnb8U4EOBtOEwcn1va9lXOTdjRLO/f109VGgd/e3cbyTpBKhoJrcgBUbv1jUcDAwbM3LekBDN0dKmZGI0YsRA+yVdJs7N21N2WwoQlpsPaenFSNqVP9kd+RKLcKPJRzq3WDIvfHzxss78T5a8HGY7df2js8bTc0CiK+VAmeDixq3bQKA8Fqx4TuWc5BS++9jaegQcosd0dCQaFSMadvQoU3rGRw7rtrGc92M
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 07:55:43.5800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abdecdaa-5a8b-44c3-b161-08d58f0126c6
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2762
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
v1->v2:
 * switch to clk_bulk_get_all from of_clk_bulk_get_all
---
 drivers/video/fbdev/simplefb.c | 69 ++++++++----------------------------------
 1 file changed, 13 insertions(+), 56 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index a3c44ec..3c8124e 100644
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
@@ -252,45 +228,26 @@ static int simplefb_clocks_get(struct simplefb_par *par,
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
+	if (par->clks_enabled)
+		clk_bulk_disable_unprepare(par->clk_count, par->clks);
 
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			if (par->clks_enabled)
-				clk_disable_unprepare(par->clks[i]);
-			clk_put(par->clks[i]);
-		}
-	}
-
-	kfree(par->clks);
+	clk_bulk_put_all(par->clk_count, par->clks);
 }
 #else
 static int simplefb_clocks_get(struct simplefb_par *par,
 	struct platform_device *pdev) { return 0; }
-static void simplefb_clocks_enable(struct simplefb_par *par,
-	struct platform_device *pdev) { }
+static int simplefb_clocks_enable(struct simplefb_par *par) { }
 static void simplefb_clocks_destroy(struct simplefb_par *par) { }
 #endif
 
-- 
2.7.4
