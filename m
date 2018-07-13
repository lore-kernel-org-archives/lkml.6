Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EFCECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD9A208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmbASXhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD9A208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeGMKSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:18:22 -0400
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:15202
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726789AbeGMKSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyS4abmhw+0JAr1h7Y9DGhwo26JegBVNnOkd/EJlyik=;
 b=UmbASXhdzoYbLO42MDfI7Wg0bp5UAQq7KyY+GkhfCvyW3CNoFGs97K5HfzHttB+9GPYRNg0F3G/ieeWOTB/znXIE90zrjAXw+oExC9bJTxxi1Z8YmYlBVeNUUkd6n+rD6aWRYOdGH9Gnp/yuuQEY4jc0AIy8BA+zzqqlNJrPY/I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Fri, 13 Jul 2018 10:04:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH] soc: imx6qp: Use GENPD_FLAG_ALWAYS_ON for PU errata
Date:   Fri, 13 Jul 2018 13:01:15 +0300
Message-Id: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR05CA0117.eurprd05.prod.outlook.com
 (2603:10a6:207:2::19) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74cc4448-14bc-44b4-51d2-08d5e8a7fead
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:odfMuy0H/p13YCQetrIQZA6/ook63p5mgeuSV4p08dXRUP1c2rTum+zHkHcQyScviCjaHgOWOETjb4cbXyN5Q2HZpIkUb4q8fV6/DU45Mf4e1fB1p2O9nR081MW/QQDaJWgx/NkZiaWZZF9u6klig1HOyFdQUFK2AobEZ5yq/1U/L/BoIihzAIh0FhmwvIey4CPZeXUbo1fRPZ9Y4GOV85WOdOWguJgvpue9VYiHhKQpXJeRBSd0fEDG2SZU6tRh;25:1uy3sr+AFbnfQ0vgYLa2FH/YfFSTMlF71/xO11RESh7/g0d2N/3v+WymqAtB2bRDXBce+tG5A1j57TlZfp/UStqoqxH/c+LDFo9nSzNhjHnbDRw8MwOng12LtzAzWAmSpzneKqJ9nO0AOY6ycGtqPhNIfxjlgSX0bS2MC7NkHSGuEPubsIeaQqUKY9MsH8YkWQq8Gyl4sZ3nF32XnysDTz9eTDdr3DdGYHVm3kc+R39mdzTlrO3ChCnftbvSI0cSyQ39Mtq2ZBWuNr6z3trugFi7cdfdSSz03pwz9YklXHcerWlcKgDLFosgSuZxyib5T5JFv3QAyqDcMMTNCRrhQw==;31:1QA5zsAxIrqQzWce8IkLtX2rSNwSZU8JwuZVRkRvtXiXM3hz6gCkrsOu91twCljszo/OvqT+jyI6KYU75Hg/LyoZO/rV0k/ecv42euEHAL7Maf1+yo49redsYLibqgSgaZTfdIA5XFjVbme/emadwAsG9mALYpxq3S1R9GAlHrK1uxDiqeLnBwEiGWq6di5Cod8yG7twaT3FQXRSe3z+19opcD9KLiNXee5SzAP2cKo=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:2K738xyl5WCfgVxzSX97vdMHtLXJplCSk5kjOgEwHJY4HY83b3fupM4LcjzMTvVBJDPKnxX7yjz9GpF8MlNx0c4qY5VzQ115pa6GuK2R/mCWUbY18aLjV0i5Esniamzzj0M37/F0uMKgiMB0Je4Jvq5saQZNvGr2XHc/g3YTCU+UT4rgdc5AnI4ghqfsQSdfsU9L3BOVLxaJilsVAl8QfLWyIKkTWH70hgE6TkK1Sa4yyziFn5FSfNmWDyVu4LyfA5zv1gn9rRGY+BOxKkZ6um/FFcftezPvot4DORoDwtPFUiQeSFy+D7nq8FKg+4sCrzS9esu92ccK/K2TDyykHiuqdh6lt2IoGv5kmPM2n1N1XIGGtecpL2NcE1O5r1K2rFSPB9mqlsdfelGhQSH1TnNtregGfeK69Kikcd+2MsOVguxV5AtbupJCXM5wvUc5IvB3VsrLNYBvPqwSoTcaHgGBADHzWR6v16DPttCTxLKD9WtzWRLhZJDmfNKZ6VUx;4:usxipC/jck+EEiAJHfV6OTbnNQz+zheFb/G60avuFt+zlljku01vmltEelsvwGamUghT/Dkgddfg8gdbEOkXP6nMtz2Qaa0EQDLW/2Wwl0wMVHRBpv/VQaahvEqs6qxlJwCgkwBvmkAkA1VWvjpQmZVvksOU7ea7wv2z8BNN4wSD+GiXcmmW5DUGIqwUsT/zrfMd8PzP6+HuDp6CDpvo/ZS2spDg2nzWrrocm4DzuGdiuFHE0tf6bEVwQn5CF6Jb+r3njaXGtCN85uXhBDo9vqMWDsw2Lj3HAQ5EAHdZLfkz0Rv5tj4DXo8JeGXx/A6E
X-Microsoft-Antispam-PRVS: <VI1PR04MB4301BF18A5AE45EC826EB2FDEE580@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(14444005)(16586007)(110136005)(54906003)(36756003)(25786009)(97736004)(26005)(316002)(186003)(2906002)(50226002)(16526019)(106356001)(6506007)(386003)(50466002)(51416003)(48376002)(105586002)(5660300001)(47776003)(52116002)(476003)(2616005)(956004)(44832011)(486006)(4326008)(81156014)(81166006)(575784001)(86362001)(8676002)(966005)(66066001)(478600001)(68736007)(6306002)(6486002)(6512007)(7736002)(6116002)(1857600001)(118296001)(8936002)(3846002)(305945005)(53936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:ltOkx2o9BWBdJ/oYweIN++JnAZRD2rO4/vl15/9CE?=
 =?us-ascii?Q?HMR78kdzBRJWN+M49AJ5MoSVDFXDy2Yp/IkK6gA/G/1qxuadJ38k7BhiUJu5?=
 =?us-ascii?Q?+urfttnlslFcxVRPctlz5RMiYUlVn6Kkf8ZQyilg+wiPTcgikfGR5yz3pg5R?=
 =?us-ascii?Q?ec+5LgbmTeJqPcELCSEGbg6eowmdILybSCBTqUzpwpd2nJoDKQ6KAloOsrxx?=
 =?us-ascii?Q?7mFq/OmbaycFI4mZRWs5SVBaTGuS0K3kQWkGwwDx93kwVTEAYLjRnUmrYN59?=
 =?us-ascii?Q?kiLKpRCH2SAC/QUn5w1FpzvwWTJkBUXYHIGATrZDEb9QJjJZ6fWsrtcAKAzl?=
 =?us-ascii?Q?zdEm8bxAti82rYL8s+X94DFP1FyvRihZAhd1iv1cKMzJLat/GOeGVnE1vq8b?=
 =?us-ascii?Q?gnywowgnGZ14QtdMYgwuh32RKl1hXWlB6gtLL1LDjrVni6Y4xYoF+nQ+zl3g?=
 =?us-ascii?Q?yLIHCHolz9yOvba5CWxLkDukjNC/04a6Iw8e6JzqXaUYz/PXm7enUaoUAr2g?=
 =?us-ascii?Q?tCHatYpTYapgOVB6TnbVkZDUMjArBsWugMq3gQBsJ9HAZPg7j1xddYDyw+hy?=
 =?us-ascii?Q?ixK0H0zblNTUJJTI+cE0/hAb5v4f6X1gJ257zM2BpuKjx+ttv05zC85Sjl4w?=
 =?us-ascii?Q?//WH4BbaNMEhTXTDb0F2kWJusSYawHk9EyfAlzgS7q7ar2epqnsGNOTjjzfx?=
 =?us-ascii?Q?c19CzjWtVWwvdb6gvrBZdrxuKwWwLUESwL1zggrCpFwbmnP9a8U9BDkWiNou?=
 =?us-ascii?Q?YNsdytL0xeft9qNBFA3erGvI+pcCfvlmfV0fklfIGPpjrug131J4e6B+fVWV?=
 =?us-ascii?Q?0nPYMh+dOgRM2ui0jhO06UKVTDJrjMU4/86B+WSjsV4RfRBMbq16P4SKwB1+?=
 =?us-ascii?Q?/dd4szIeQpVwLes78vT7WOTB/yvzuWH4bXNEBLnGxJvsGs7pGbl618NmDiLN?=
 =?us-ascii?Q?ClbRfdJ3KjTSnbZgNPxToCfgVHytfoctdveoTz3Td3EMuUbR3pj2WibltlZI?=
 =?us-ascii?Q?BYLKZLqudFSbsSR4cBZ1vnFSBDzdFnAkjhMpbEWVi4ur87kuXWEp1L3NpGRM?=
 =?us-ascii?Q?PWdITeo4wxWB4Pf/vlDnKYRyvD1jwSP8n49r8KF9A5uRw2BGeG/sLJ+C9UHH?=
 =?us-ascii?Q?P37HjUE18mKzFWN1/3HsJ4DkMGZanhE57iV/UMW/Lhuy2msNNjNRZo5gFXLS?=
 =?us-ascii?Q?oGLaaPCIbMeQOkyr+qCaZ8ZGhWZ+7m4ODysc8O9W2lw05YPA6qu9KE8MpK+j?=
 =?us-ascii?Q?uUEgeOyFOHT25ZslLudePnYHkEapsydvjMb7PRdJUu6YKDxMGOhmP7o3zzmQ?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: latmhMI/uqPw7JBwz/HHHZLeIA760WOShEXWuDki7CfCeh+CJOUrJQyQYTMecwXryg7w4bOBB3o1ojXQep8tLtXCcfFXbcB4ei1d0FpmnBP9RM+GMZA21YZuphwJT4OKWpxKaqsGy/85EXQ4gIhgYXdJ77dXYlP0F7SL/MTKw7SdG9KK8d985DCM6kGgVpM9qgfWN5eGxigf0X8cof+4jFOYp7xVLGiH/4jLvGW8ehVRnDUKEzk15nYXYZCQh5rMUM31z67uLUDtlOQhl08S9MVQBn3aL7hrnyJ4EfusJKVrNGxeUjE7XFuIKXRPPOOlUjHr+b8fLK00hV0HHfas8FRONoZyHtM5RPyKEOCyVsI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:UaQsOdzrS/CEGglPYD7V1cuuSr93TmeFK5s2UHoLdOgwHNAA3qnIV86c+lE1/ddAvTkw0wN3uTDZx4hwOv3+RT4/RArhtQ0mZGHu3SsR6TUuZrIAaLKQB/siBIDU9Hgmp1mUst2/1ER/7Qv6RF48izhLhFWDbi+L/bKBYs93wQt1P3uQo1tvjjvSdVGrC5MaLj1ulWy7+iNt8ejbSqza/8gauyS8BIXIO4ktl9bnqEaVQZ8kkkKi5vls60aO1h7bHWHjo0WdrNyXfzlRe83PYkYLkcrA8mr1EkEuL0i6/wXwmjr47ZgDKP0ZJ7uTMsl0c92j3qIR5R2PHNGuxl5DfGpFLBk5p1Vx142yX8mA0RLOqdru9E0MMttPgLan7DjbiL1n5/dn/0xjlJSfQNpwHIVF2BAxryUdvl6+9a2T99+DzjOX3oROdszi5ZskEuUpcvnyyvNq/yTQE0DUXSfZbA==;5:6yeF/lYQAx1q2OWsupirQ1soI3X9M11NJMVBWc79HQI9aJIFq9uihEFkNWsOI/IbtP5o1W1fQYNvnBQLdjeMEfDxtWKnJIIVcsqtKrAqrVbNJ82SczUYm5JhXp64m2jJlMyBWtlJLt4g3NlWJCPFS9PbDZriuq6gzgAbL9qFwDE=;24:mCldDWHozYCEWQhs0Io8Nhel4w+/EbxhWltDlvJOn7eUGhH2aqfDmzTQVd0TIFaQ5kRWbI4opqocC4mnR9Wt2tAFXzUMtUaaCHM3QT7VAJI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;7:T9aoNDQZhCvuOk5dZj+GtlyqGf9KKHF+2Y6BpgIxtclorU8kAP4YPaAl1jrO2g16VjFpiSzP4egfuDLOjlUB7suKRWmjDZ+nD+MShh0BaXO+bTwJGyU7yt9xzVQXzMZRXfNDrCGhRhK9JzHdYIe8A4WuNvPQX4ehe7Qnwxm3tEo/5IvTWBeVURqsG2uTsKly3L39us91t4j0fwg6Ttguu5cC16c34NatjR454RWkDE6D91nv89x+rttNml7qYrC9
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 10:04:16.2329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cc4448-14bc-44b4-51d2-08d5e8a7fead
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is functionally identical but simpler and slightly faster.

The PU domain is turned on at boot time and never turned off. In the
current implementation the pm core will repeatedly call power_off when
the domain is unused and get -EBUSY back. If the domain is marked as
"always on" instead the pm core won't even attempt to turn it off.

In theory on 6qp it is safe to turn PU off in suspend, however that is
best accomplished with a new core flag.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Previous discussion:
* https://lkml.org/lkml/2018/7/11/431
* https://lkml.org/lkml/2018/7/10/103

Attempt at turning PU off in suspend:
* https://lkml.org/lkml/2018/7/6/698

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index faf13a0b85d6..f31978e5af20 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -45,11 +45,10 @@ struct imx_pm_domain {
 	struct clk *clk[GPC_CLK_MAX];
 	int num_clks;
 	unsigned int reg_offs;
 	signed char cntr_pdn_bit;
 	unsigned int ipg_rate_mhz;
-	unsigned int flags;
 };
 
 static inline struct imx_pm_domain *
 to_imx_pm_domain(struct generic_pm_domain *genpd)
 {
@@ -60,13 +59,10 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 {
 	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
 	int iso, iso2sw;
 	u32 val;
 
-	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
-		return -EBUSY;
-
 	/* Read ISO and ISO2SW power down delays */
 	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
 	iso = val & 0x3f;
 	iso2sw = (val >> 8) & 0x3f;
 
@@ -419,12 +415,12 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
 	/* Disable PU power down in normal operation if ERR009619 is present */
 	if (of_id_data->err009619_present)
-		imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
-				PGC_DOMAIN_FLAG_NO_PD;
+		imx_gpc_domains[GPC_PGC_DOMAIN_PU].base.flags |=
+				GENPD_FLAG_ALWAYS_ON;
 
 	/* Keep DISP always on if ERR006287 is present */
 	if (of_id_data->err006287_present)
 		imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
 				GENPD_FLAG_ALWAYS_ON;
-- 
2.17.1

