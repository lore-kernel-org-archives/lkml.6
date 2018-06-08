Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /L2HDI/XGlsBSwAAmS7hNA
	; Fri, 08 Jun 2018 19:23:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 67BC4605A5; Fri,  8 Jun 2018 19:23:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gI/5X8wm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BE42F605A2;
	Fri,  8 Jun 2018 19:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE42F605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeFHTXT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:23:19 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:46176
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752328AbeFHTXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWUO76KoyCjc31GpyYVepHhO+M6yR+NqKED+CQujD5Y=;
 b=gI/5X8wmb02uDeGcLsdwyDcNS0GD//OaUG1l+hy7b0ftOKLA/lMvoyIOSN/STfHoLFfRMht1jA2MAyWQw0XVBt70ZW22pbgRyCszf6AlHLtMTAIFuVo0rimK+MZT9iD9NAx+rE6hG7UkL7qG2+6libQ6PVo+CIwcHXI51n3Cmdg=
Received: from Ubuntu14.localdomain (64.157.242.222) by
 DB6PR04MB3285.eurprd04.prod.outlook.com (2603:10a6:6:11::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Fri, 8 Jun 2018 19:23:07 +0000
Received: by Ubuntu14.localdomain (Postfix, from userid 1000)
        id E36F510A55E7; Fri,  8 Jun 2018 14:22:56 -0500 (CDT)
From: shenwei.wang@nxp.com
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 2/4] pwm: fsl-ftm: Added the support of per-compatible data
Date: Fri,  8 Jun 2018 14:22:35 -0500
Message-Id: <20180608192237.11063-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20180608192237.11063-1-shenwei.wang@nxp.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR0102CA0036.prod.exchangelabs.com (2603:10b6:805:1::49)
 To DB6PR04MB3285.eurprd04.prod.outlook.com (2603:10a6:6:11::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3285;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3285;3:KeXIHm3F53MGkZgZ5TSG9QBJ2dIFEl3kyacyHf7uDk9CEBJaO5icv+9s8g9R1oI+AtglNlONN1mw7259Wj5gUcVN4ep/N9tMk+eoFwyhtbGmARsZagdx4IG7uYk4yNiZ2jRo6x64r22+bYTj1McPTnZpFQBQU0SQo1e/KX+wXlzyhXEPWBd2PN7up+tplbsQHDXehCzEMIUmtYpJxtOKTimHWt9nQF5il/KBNBhBhGJm4ZwWWpoWyAiEHBNPNhjh;25:jx13HZ1GsPtnVd4VrW6AmYuQU6ky4tlZre/zAR0+m3X5WDuPOQFjQQ8Im+6oxJXex5jnMj6AVws7YrlusEZpvwtVBpq1Lu7eTXoM4ABPesoBM0+0Ewut5ANWMntmsPMMqQWGpgx7pmXWup/wbhG40EgY52Q/BLTTDO8GhyHiqA2dJjtDwtB6LZMZF+Dak0gRmvN1JgQF8O5riiL/ktbZoMTzj4Ymgjro8+2jgH3fJxQ4C2f9QMVqbd0kfzOmWTlbm4iixGOpdVCiL58e7M4QnlsBk8Jons1q2VdGQOkPpcMR1oA3NQmMXktm2hDmujRnRZXRL7+9AwWLGHJU0q/YUw==;31:DGNkqucsbrmdbgx0kC10H5DIs8tpl4e50nmmvPcWAMUqib6FB0oOQl5t7zg+3GTsTD/NZ6p6kZEjT7rqgkyRGVrpTZjSVutbZ++Y5I7FJXV7bzWIShOB6+17vb7w95jsH8+36u6xjcGaqIJK9EmZ3m3jvCIdXM5ZzMUyZlzxJykc3CEjjs0KuSUIrMVbVQYRW4zLpH7+ebrl3qznSxe6Nssf62xgo0NKlpj2o5BeVxI=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3285:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3285;20:VpmAar3Ijn7hjYdY9kX/FG0kzeXg75ZPYLt6nJI8fIzCm6EQJpzG9kA4eKnNVVLq35UTIj6U8XAFUgDpGNLP8pNY9mMmAIGtHZ17cF4HSpur70SdWlNCx+UEShMqNmEuxfVX0ts3TNnw+j2RqBhAzlsB2oKJnHyL9bf7kGVRGeyPIPAJungoqkQSd8mmNxaDJyw53WlXi+Hfr3O1X5xgMOHazOvrBCfyKvPS3itl4kdm/RHwcbRcZfY5UQdYg8yvK8xvtxVlly92bzhRtYln3OgTm71ylsPhwn/J3v1CDWVz0reB3LsnYm9vCN4p14MJzMPsW0s0WMX+C8KzXiDvw1nOAGftUNfRkjrIipcnq8ureqxK20HhQosngH/aVlOEyEJuF/o2jmOZg5cIFDTsBQi0YKFsgbsRVxPlmCjrxhDydolwTK6EbVTPIkAAPv+itIdHDJd8dGw6F7ouYxnZzGFYzbSdwvmDpKsVgfpb+xkANBqCKmapCEtK3eJfhk8M;4:S0xmO7WPISrkKL8McHh1PDi5HYllGQhb3zTsna9IAOh7FODdnhx8YvYJ6LszQz1+fPiwwR5kXaP0JD30sSGDSBC8GvKHgcAZsrqPr4r3KiLLMOee7HAJkY/dazvoeSr/GHHD7B8/dRJhU4Mm00Dc16RqzG7JES3G5lTFbNFZ3Wg4xCzWh8A7LnX1JtLLMHut8qRs0Hi6eGCN9RYm/WHscXiDDUeaGV++VNdVUM4cdr1EpKkos4SAXmtuqyRr7mz+RWYuqAviZAV9dHAkSReb8ANGiuPbntN6bsGF66WbNikehZezOpuBpUv910KgtZv0
X-Microsoft-Antispam-PRVS: <DB6PR04MB32857695C5678AE50E09EC96897B0@DB6PR04MB3285.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3285;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3285;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(26005)(6266002)(36756003)(68736007)(50466002)(316002)(86362001)(47776003)(575784001)(105586002)(16586007)(42186006)(66066001)(48376002)(186003)(386003)(97736004)(85782001)(59450400001)(9686003)(33896004)(8936002)(52956003)(81166006)(81156014)(8676002)(3846002)(101396001)(6116002)(4326008)(446003)(76176011)(122856001)(53936002)(6916009)(39060400002)(51416003)(476003)(305945005)(486006)(52116002)(50226002)(6666003)(106356001)(478600001)(2351001)(5660300001)(90966002)(2616005)(2906002)(7736002)(2361001)(11346002)(1076002)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3285;H:Ubuntu14.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3285;23:tKE/ankYUcu5758BcjT0ne7yzo+7ktTRfVc+41zZo?=
 =?us-ascii?Q?VNPGAQyomOwmSkFCScaHttarxrApjQ5J0baoNhXshjwg26jFNHqoByc++7nv?=
 =?us-ascii?Q?T4XljaYsDFfkFxAZ9QhOW4QoPxcqFAuwFK/eLg65XqTIIt+ZJiL+wkIjTJDz?=
 =?us-ascii?Q?7K53KJcFfhLDrTwk9yKGCcF9MSguk145dIdfmGIU8lYOXkWGeAIZil9jPMpI?=
 =?us-ascii?Q?6UPrtbRcdimUFlvoI2gBcRwQlfqGJhH5hGYS3VClFN30q5SHYd0RzKAOQOut?=
 =?us-ascii?Q?RReANUTc0TGmAqdtl/2+vD5ommWL4UPgYi9YVN1bwJmWohp0gUSkPR4qfIUF?=
 =?us-ascii?Q?xmoufOe2zSlT+bjvdQFxF3KzBIcXxR+Iqsqog3nBi83/HUQIcbwOUnIToRkf?=
 =?us-ascii?Q?6mPZLrcMJcH5xqbuGT1bOuAN06xCpa5CSRjVFd3396v/fAonLwl6iXTlrgdn?=
 =?us-ascii?Q?WEsKUC6qKKagR4kgIzyGqoSr3qLUumo+OlpVeYt8wzN0qfaQTQav/blSOFo9?=
 =?us-ascii?Q?XWAlGf9GSl9JDVI4ceQXKjU19/T7mlBFNoqOjKYb0xh/Hx59YdAMiCZn1YHC?=
 =?us-ascii?Q?DKGehJ1Od6BRrr57/1eOIOXxQ+YO31BNSrJYTlv6uYUAm5glLilfYW3G3odb?=
 =?us-ascii?Q?X55vj1iHZ89Ncn1affxMsL/K3d+2Ru170hHWI3wgRlKZA5GGPe6pNLlxEeDa?=
 =?us-ascii?Q?VrGgH3uJtuS17YagXvJ5ovh6EPRnTSfsC6JRjo0qiJYSK5jrldISdvEccj4y?=
 =?us-ascii?Q?I2CnmljGoMENigGf57mG85BwpkPWAwBc92Nyk6Hilmp0brmzYqCOIBhrNrf7?=
 =?us-ascii?Q?7ehAyVRPNhPQHnzWD6J6eJ7avgir3VCAzaqk0K7UgxjERz5smlBWpDJ3Vehr?=
 =?us-ascii?Q?KIojnWZku/gI/fzynk8Ni+e7GAn8nYOTEqNYOyb8z2EaDwkXafkY6mLQCHMJ?=
 =?us-ascii?Q?AO87ZoOYAI1c3vdENIP00bvD53A7vBroOrVQu7xzaOxNGEFIfNAJofLgznRx?=
 =?us-ascii?Q?tqbYJSqWpozAS+Gf49P9gFSQk1XREOn3xU9R8VE16RBVL1gCbsATITGy587u?=
 =?us-ascii?Q?pUZbUsXqkaeWx6foFKMmURoR6R9MSpT+WNBDgF0WLVUJO4D+3aAdvfS6G5+f?=
 =?us-ascii?Q?wCLi1l7nFqHqixduaZdcpNRNEaIYuncWrKGKin5RRwOvx5LrZR7rqx9PqesR?=
 =?us-ascii?Q?A76hiXrUelIndyLBzQrRUhM+7sLPET5iYXnyTCcK3epi5pOrg8dqe4YBkCDE?=
 =?us-ascii?Q?zXjMOJoJYAwT5rf/O6k6ZC054RpSeTDHlhpDAAiT92Gmj713VzjHqCbJnwoC?=
 =?us-ascii?Q?E2+tOCX2kCLaOlDK8CoaUGOZT4eeurjJN3dE2sr6+35K9U7Lhx8RIDjWCHle?=
 =?us-ascii?Q?CDxYT7BPVQgaBawe5pIe5i9hPaauiskKIBAELlqVknwcWhS?=
X-Microsoft-Antispam-Message-Info: h/KkJnITb2NNUDDGsfrXpXnTC7A0gC1FqxeUcMhjPvK6FX4nMudp/fvZOL9BhboW9HJM2wBkWe7VGTKnDkMDH1mFCVycmETIJ/UZVF1DUwnNr65kseYwpHmdcomBM3PT6Jh+XxVi4GnnV93rMr3U6wsYasuZz5W0WB6zizvu7/Cez5SoD6ybmO5cO2teaPQm
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3285;6:lQNOoovVOQsQPiHdq0LBHoqxDQyVYm3nXqysCBKOHyUN/juvqP8vmWW1Ox/Y/Gducrh9G7Xt3f2l6hQMcAtMFDMJF4bVHqmmRZ0Ncz649dYecyTkwSXd57zscSV2vUjdxnoyye+7QjXc/h+ImtBTjH6Vt+lIC1lDlY7s6dHSMiNQ3cUKpP/bH8P0QyCfAPK3NABb/8BUqwhHMaQBviDfY8jj/XvmOxFfwMglIu1WhS1kJe4wU9LL5sZOexol3zRZlJATKpZInnp11V7R/0GsEeKG03ZeITlH9OeJ6fgS6LPOtCYpeoR937klsFydvrvSrmvIAUYniQ7RR3JX/qSzuok/5ZPeiTMu+LdcKZCPYZYPiB5e8M1+QrCAKhZ8M2WO8ebKCyHiO9Zx4xBGOK/PxqMA+lvS9wODl17a4E6MkaOhCMHYXBXiUEeTNQ1ixQZJ+C1ILp2zI2KFJ+2Te7/dng==;5:Iaas54MpZDqjoU0wNxHqcPdfPXT8A69oLlTxBDM7b+l0A1NxXpufEk+Gf5+8Zw1itoU4cBQg/7zw+2sYW3VY8ma7gSq9MhEuRtFECg/ZvgIxd+AQDEOjWXCJpgNhSIYcBPohw0q9ZVWub2IMQbZzU0NS+tXniVFelIektOG7FNE=;24:RVhIs+sT8yeUrUMSPk/MMKD2RpBqdHSdhh0vjNoyTyfL6n6TSh7+W/2HVh4Wn7bc/K+yoX8rz24WEQzZY7J6T3fUEjw3dtOWva1Deys1K4o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3285;7:J7pYi7YvArcu7J7atDqeQz60gYCdfxAnOTHB3tHaAkPNy5cYlQ3+YvNqt1Xp6YoFXhdo9nLnqHSack2et12N1JC/3pJ8SCmmlSp/CZ8ZS2btPOKK7BdSdCjFHRdVyCYEMe1kALBjXMvaMfIdXHpI7pfn2EzQ9oR64XcWprzslf5kMVI1sYke7ES60byJ+WKIlhv+doO+p6+ML/Wcd9FgkKp8I/O4RkRPE4ihQUGLscQNV+MWKwulbAZrjb18buEG
X-MS-Office365-Filtering-Correlation-Id: 04ad02cf-5d0f-4f12-7f01-08d5cd7543e4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 19:23:07.5057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ad02cf-5d0f-4f12-7f01-08d5cd7543e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3285
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the i.MX8x SoC family, an additional PWM enable bit is
added for each PWM channel in the register FTM_SC[23:16].
It supports 8 channels. Bit16 is for channel 0, and bit23
is for channel 7. As the IP version information can not
be obtained via any of the FTM registers, a property of
"has_enable_bits" is added via per-compatible data structure.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index df0a1c0..e4c76da 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -75,6 +76,10 @@ enum fsl_pwm_clk {
 	FSL_PWM_CLK_MAX
 };
 
+struct fsl_ftm_soc {
+	bool has_enable_bits;
+};
+
 struct fsl_pwm_chip {
 	struct pwm_chip chip;
 
@@ -89,6 +94,8 @@ struct fsl_pwm_chip {
 
 	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
+
+	const struct fsl_ftm_soc *soc;
 };
 
 static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
@@ -98,15 +105,31 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 
 static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	int ret;
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	return clk_prepare_enable(fpc->ipg_clk);
+	ret = clk_prepare_enable(fpc->ipg_clk);
+
+	if ((!ret) && (fpc->soc->has_enable_bits)) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC,
+				BIT(pwm->hwpwm + 16), BIT(pwm->hwpwm + 16));
+		mutex_unlock(&fpc->lock);
+	}
+
+	return ret;
 }
 
 static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
+	if (fpc->soc->has_enable_bits) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16), 0);
+		mutex_unlock(&fpc->lock);
+	}
+
 	clk_disable_unprepare(fpc->ipg_clk);
 }
 
@@ -409,6 +432,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 
 	mutex_init(&fpc->lock);
 
+	fpc->soc = of_device_get_match_data(&pdev->dev);
 	fpc->chip.dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -534,8 +558,12 @@ static const struct dev_pm_ops fsl_pwm_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(fsl_pwm_suspend, fsl_pwm_resume)
 };
 
+static const struct fsl_ftm_soc vf610_ftm_pwm = {
+	.has_enable_bits = false,
+};
+
 static const struct of_device_id fsl_pwm_dt_ids[] = {
-	{ .compatible = "fsl,vf610-ftm-pwm", },
+	{ .compatible = "fsl,vf610-ftm-pwm", .data = &vf610_ftm_pwm },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_pwm_dt_ids);
-- 
2.9.2
