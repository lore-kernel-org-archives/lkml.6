Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MfanHbfWGlumOQAAmS7hNA
	; Fri, 08 Jun 2018 19:23:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BD97A6074D; Fri,  8 Jun 2018 19:23:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OirEIKtk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AC8F7605A2;
	Fri,  8 Jun 2018 19:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC8F7605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeFHTXI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:23:08 -0400
Received: from mail-db5eur01on0087.outbound.protection.outlook.com ([104.47.2.87]:40183
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751719AbeFHTXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow6pf3kOoKhT7zTB0kt+HLEWiBxpWolBCQHFimBegqQ=;
 b=OirEIKtkGHAi5lxmzTGrYIFpzOngCWmdDzvzaE7G6iSZxqjkH1NG8tH3u85CxuH5CehnSksxHVf73uh4tJp1sPPOh30zkE5oD55cpdvWTLgj5CY9o6yIaoPBiT2VpKigEmrFwLl1PRnd2tsiTegW551QeefyxyryTgfXI/2A9UY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com;
Received: from Ubuntu14.localdomain (64.157.242.222) by
 HE1PR04MB3289.eurprd04.prod.outlook.com (2603:10a6:7:1f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Fri, 8 Jun 2018 19:23:02 +0000
Received: by Ubuntu14.localdomain (Postfix, from userid 1000)
        id 540E110A55E6; Fri,  8 Jun 2018 14:22:50 -0500 (CDT)
From: shenwei.wang@nxp.com
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 1/4] pwm: fsl-ftm: Added a dedicated IP interface clock
Date: Fri,  8 Jun 2018 14:22:34 -0500
Message-Id: <20180608192237.11063-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To HE1PR04MB3289.eurprd04.prod.outlook.com
 (2603:10a6:7:1f::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3289;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3289;3:e1Q8IcqboewUjadG+qAWdeRwj9Fw6i33Tpl6TSMMx3tnzFf9RxhP4C7ETi23LvAXSSvioEsxZTEfUOkz0ABpXlhiUyQe9b/Kfa2n3hV5Vk4FCLFkn8kwtfyw7NUJvhVMxdMes9diR5Qx5tdF5pWolw6mWSGD5qNbyf/7/5iZlMbeilcZk0PXzH1uPOdXylLoDX58sA3/CrmwuI715mGXshcZXbCzhf5WMXrA2btAw8G7VZkf9yXi+Yya5ww4BSBn;25:aY/YE8DN6JsPf2i+ew8YC8dl2KG47cc7GbxoQ7w351THrsT6T2ymqdYXgGF6kkd98X3aStOdgMyTq4afRLRloTctRfxHnYU3PJnunEXg7TLQBiRRPwgubYu7rwv0pxfDqnqi4xwQi/IwVtRRB7th1Kr51x7d/dquV8peeZw62/R2xkzwIZ89fDTG8V6mAQL9d46kXFQw2MqCDe7Ksd+1KSZXxm6wlLkktGqp5Q7X/+YL79OZbuG+PEiurg8oCCqzr0QVuGo5ZvQV3ibmPlz/flsOucRmJ+wc9QqSMnhayZszg/dr3IzoJaNCoqKp1LfWWJFv6qf1pX2gKaHjc3e3hg==;31:Q5Epko+1FnTOGCNS7ktYx2ztbQW4NKnqCagEdqrqpBtMWqdIMJGKLMHQb1t8XZe+WEdTNgkfMYyArGGG3vpI+RQldGx8Uqupcwp2u7cIQfi16FiR0/oQyXa4JCUXuIVJfhJ/ySVyk5EnFFXis+fYURgvrQBA3uqmWDPH3gRR55Tr76yeIT4NdMSzQbbLC/RTUQirmYTBO16gOlojObL4flVqEDaz0Za7RGdcqu+rV8U=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3289:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3289;20:fplyk7/F1ekoWq50rZ4p9MU7t8JhrD2P7J1kVIASH2bo+on8Bb73LHv+Rbx3Vwh2DFBOvsax8eXmHX7p1LZ2bjuQRe4e9qQIj5Hapy4NFCg3n3PKgR836q+b4t/vKAJ5ECyCno07UJ5Ashcy4943HZpC95tT8EGX3yjtfiGy+vGPLezpMwlvPRn+vVmA7uFYpknYy2toI3UagiI9f9p/LuV4/uccqosyHtreli0MbGWS4lO3h1fqxyrk+ZnBTwIE1gaQFVeQNNSUnsTAGZN4YzkCGIT+xP5Stys9ccPV6g62H+i8eb+qQfRgnsAbwaA+74T/dkZwb44rmfn6hqnPoB5fJEsr8ekN1l/joMA7SR3rn4bWo5vSMkPlfJDJwMEejE/VbxM5bnPtxXi1SCgiT1OUS2+tfOuvtbSEk1trtPMdMzQ2Whv4BNJ6DHntQSJ7LgDR6MrpU/NF6gCb87+9q3YJo59xooFOxqYMspUCnQu20Bcn8o+Y2VWkGMFolJNP;4:Rn3/NQgfrsgsczIDCIS+zchrh6zZEF+OJyPyeO9vcc8gL7Uti7AjvwivyBpQjPuzMMOJaQ34eVN/KkWaveOzCYpgWAoHJZ0UvB6Xn8jeDhbQbUemrg0ymE2tWT5mqBdqfLITkBjyV+6RvxFDYL46AXKgUZ2cM+ftUYpRjl04UsXNxm8kXCJF6rDgA4Hn3aX2Vhodt4BRhC5OMeAuplmwj+QsrrAhpskkexWMR+rTVpy/PAaOSkM1JCBuqNOn2HtFE1CN6/N+zebmAnbwRI7zfUJV6X/ADAmn03y8r+0f9Zt+QBm+FPDyFJRA0e4Gyk7+
X-Microsoft-Antispam-PRVS: <HE1PR04MB3289577EE839C34F7EF0A7F2897B0@HE1PR04MB3289.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB3289;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3289;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(52116002)(478600001)(1076002)(51416003)(6116002)(9686003)(33896004)(3846002)(101396001)(66066001)(386003)(5660300001)(47776003)(122856001)(36756003)(8936002)(50226002)(68736007)(2361001)(81156014)(8676002)(81166006)(59450400001)(2351001)(7736002)(48376002)(53936002)(476003)(2906002)(2616005)(305945005)(486006)(575784001)(86362001)(106356001)(6266002)(105586002)(50466002)(42186006)(316002)(26005)(4326008)(16586007)(97736004)(39060400002)(85782001)(6666003)(90966002)(6916009)(52956003)(186003)(85772001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3289;H:Ubuntu14.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3289;23:EZ0dlB/7wLRKvLjVvXM213y2sFmSqCkrVr4UkgQEm?=
 =?us-ascii?Q?t5vK1iUBjBpHpqycVkaeFq368hnw+1qnursBAnm763f/hcLZzmj73PF6TMdG?=
 =?us-ascii?Q?f2dRdeyXao4/jGaNUWYX7l8NXcqE20z02vxg8HmUGhkUcCe9oul68Gpj5DZt?=
 =?us-ascii?Q?FYHfKzdAO83lMhh/wLvMcx5myNAfmuFf5XXUjL2w9u4dx6rVHP4caOB1ojaq?=
 =?us-ascii?Q?FiTV3AwjS0q+qkpJxz7NzxjUaeLlaBuum8yscjhGJ9uWIe3DBDk89J7lMBrp?=
 =?us-ascii?Q?4RsPUePdjV2DyNtxoZWxMyrr7masJH/ohtE0GXCl1MGUO6yEouIE+6IU/rpR?=
 =?us-ascii?Q?HSLpNZoI+s8Esp0qVW2w8Bc+7NyO019UYd8BLsXAzXRwzh4tbwChf23xAj+w?=
 =?us-ascii?Q?ucCQAYF9ePPtuStaUEzV1H+UlQ3FWXseaE1nPqdAEW6n/awS5BiHnTdHu6Bm?=
 =?us-ascii?Q?U9IHWXMWrmsY66jBSAq/jz9JvWOVqecZo4wRqOsjsv/zmFEcGLsrGszB20Dz?=
 =?us-ascii?Q?5majQs1hmv8eTNRnyLqt0XZbrub/CqUOP9otH4S2DnO/gm7RsS6QDrh6MM1E?=
 =?us-ascii?Q?iPBrWJAV8D6pW+iz2SbJhI5j2tAyogylpUl6+bmI4ps8kXiXcqb+RtFW02Um?=
 =?us-ascii?Q?xN6ac3/SQ7VMEJ2BgZmlmQfmaCkjKyQ2Tb9gT2maiQd6NmDV65FOmsspY3j1?=
 =?us-ascii?Q?URh54/ehMDzsHtDljCgcWzk1HVyzfb5sRaCsVllyAmeLWFh/G/RUPC7DpHha?=
 =?us-ascii?Q?3/tKlL1XTjDvB7Xf5Qj2QhZTy5npPB3qstZf6vxTaGgGbww0GItZ5KaYa2yK?=
 =?us-ascii?Q?iW/PoDRjrmvVfakmd/uRY/b6jfORGafw+L6TLpEZvIBoFS7/IvkHv280/ZH8?=
 =?us-ascii?Q?+S+AGywqClBwjD2sPWHs39GvMP+kzDuG5Ryvn1bTYxWcHbz2WawMTbF5HQYz?=
 =?us-ascii?Q?akvgpknAZz8e7HChZa9rqvGYWAA/D65N0svqtYMXVPrzORiqV5Ph09b4M/Ji?=
 =?us-ascii?Q?SaLjI4NqgVNadrlIW6ivYPsB10kI5Cp5o3biPzeAEaScjmiWC9ioDduf6jUD?=
 =?us-ascii?Q?YvitIAylvfdcoWF4yONNqBHPvwmKn+Wv0XbcdutXb1O2S3YNE3OnTVQwXKAL?=
 =?us-ascii?Q?C0Dea/K/BTOv4ohbJqg9dN6xeoBo3Fx5tQDWYWSTBHQUQ8tqkVhpFYFBin1F?=
 =?us-ascii?Q?LH7bliZ4vLfObt90TH7xicpkeru9NKHZKynyTSyVk2GJSyp45nT80HYbkp8z?=
 =?us-ascii?Q?P8Uh4DF3Rmix+C7mhDyAKupLXrPD9iZnI5HxOetNDpOWlz4dJWri7LGs1p1w?=
 =?us-ascii?Q?qbPCZBV3eJJlRpK6DA1Pe9BNLSbj53gjksgekMgSStPzETTRS0FddLSOTWLf?=
 =?us-ascii?Q?HjVbA=3D=3D?=
X-Microsoft-Antispam-Message-Info: M9qdcCwUvg4LfQAuclayPW0lSXvv0uajk9dZH1CJ61X8FxpKb+qLXjUZ/bMDcTCwgw7GLeEGzILoipJCVQbqEo1TQ/ZWh2+wtGqB3UiOVqKGRACidnMBfG6a2uwN7D0P4mMVbS5qKR1AN3cPzFKtiKOrx+hURtqPhRw3wYlqCQlizOzT5wd4LpaaVDQcdreB
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3289;6:Nw5liU+V07BIBdajrnWSX3hGf5wIcWUDLyDgQXa6bsuArtnH55MVPFxvIbs/Vogob1473TMtRHNBLh1ZqFy0ErK0YTY8hp68sz9uUe0oPc+eQlJwaPqjb2rZsc2Zz6YfRGMIONHPSIxpJetn8cWkyPEahj/pQR3PmauTXlapTmed9RheNE+yRCyhdYmDj5FhTIa6U+GVHHs7PD3UjEZqwUf2J8BDvLpZDFQ5gTGoGwu8uYjEic1oiyiI4WUxaYNdzXSjyZkkEFN1a+cAcv6ISrP/opUSDWwqiUkk1iSd3485jZzEMECtRqyGF2EcpMKsFqykeAUuOc+bJRDvw9UTHnlbydRPu96+063B+9N+z0jZCupZLJZB56ZxT5UoEYfebcykBKcHykcKRpv/V2mFDx/4G+YslIz1GYLfJy2Hi/9tPYb9H62WkLTiEFn0llRfNDp/hI4FdY35oXobQjqSQw==;5:jWw4M1mWyFwQdTs6PHdM7FjLzeBg8aAh/zxBnUbZ8zzplsFakkvECBUuc1yNmEqXd7Fpib66Evp4iwStN9/WlWnqcWYlbBXjmNKzDNZ0+4907AcUXoaKqBf2pq2LckrGt/m3TwzibHZb2JeGDIx8JY4FVFQxmS1apQcQbXRRA6I=;24:PWRh74kR53d/rgZNDyu5gRL3WBqGDQm7kkof0iXHRDLbZoZdxCck425HN6c5JbFtzE/n7BAN3t55xLxwrKz8StOcshANINyHzW6CT7dcDhc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3289;7:Zprwgpa2fIVo8Ep/2QK1pzbloNUOHsBTYP/oUWhi6Vu0JIP2DP6K6aZqGPa8g1TVuOrHZu5pIg835Qacalc3/rwwPnCdeWjKQ7SZC/XgOysNry7eALHLY2VXZFtJ3hd7RWpYHaavqHKO5dpklOGKPycbY1LhZNwJj5f4ykMyqj5v6qKf6870pmTHUQJRlFYT4EYzrt9KrZAkvh0589qgD1W5mxBRCw+sL8AaH0gbddmfusEdcBkc0JJMzi5hwoMH
X-MS-Office365-Filtering-Correlation-Id: 33bfb83f-7f44-457e-5a3d-08d5cd7540ab
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 19:23:02.0757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bfb83f-7f44-457e-5a3d-08d5cd7540ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver assumes that the ftm_sys clock works as
one of the clock sources for the IP block as well as the IP
interface clock. This assumption does not apply any more on
the latest i.MX8x SoC family. On i.MX8x SoCs, a dedicated IP
interface clock is introduced and it must be enabled before
accessing any FTM registers. Moreover, the clock can not be
used as the source clock for the FTM IP block. This patch
introduces the ipg_clk as the dedicated IP interface clock
and by default it is the same as the ftm_sys clock if not
specified.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 557b4ea..df0a1c0 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -87,6 +87,7 @@ struct fsl_pwm_chip {
 
 	int period_ns;
 
+	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
 };
 
@@ -99,14 +100,14 @@ static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	return clk_prepare_enable(fpc->ipg_clk);
 }
 
 static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
 }
 
 static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
@@ -363,7 +364,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 {
 	int ret;
 
-	ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret = clk_prepare_enable(fpc->ipg_clk);
 	if (ret)
 		return ret;
 
@@ -371,7 +372,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
 	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
 
 	return 0;
 }
@@ -441,6 +442,15 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]);
 
+	/* ipg_clk is the interface clock for the IP.
+	 * If not provided, use the ftm_sys clock as
+	 * the default
+	 */
+	fpc->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fpc->ipg_clk))
+		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
+
+
 	fpc->chip.ops = &fsl_pwm_ops;
 	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
 	fpc->chip.of_pwm_n_cells = 3;
@@ -480,7 +490,7 @@ static int fsl_pwm_suspend(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_disable_unprepare(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -503,7 +513,7 @@ static int fsl_pwm_resume(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_prepare_enable(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
-- 
2.9.2
