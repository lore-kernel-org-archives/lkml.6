Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62617C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F009A23D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nVrm6NWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F009A23D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeFVFhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 01:37:02 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:7876
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751212AbeFVFhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 01:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EvKv1qsp81bu7H2rQuS0uUTe+8Pebirnamcc6BGAFk=;
 b=nVrm6NWrXkZ15/buUaE8ADC0aL4W5FouDEN9yBGTctdi6cCONKFDiKbHa1887z9MOGXJ6uig8d81qvEwQN4y5PJatNX1b9xz5b4SOAhr/BvRN4AiMZc2bkiOn9sHlUasb7DamKvMnWCbzNt769Ltv9pMz4W76SwUCTMyuNOoASQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1314.eurprd04.prod.outlook.com (2a01:111:e400:586e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Fri, 22 Jun
 2018 05:36:53 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk, lee.jones@linaro.org,
        tj@kernel.org, hongxing.zhu@nxp.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: enable bus auto clock gating function for i.mx6sll
Date:   Fri, 22 Jun 2018 13:32:48 +0800
Message-Id: <1529645568-3786-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To AM3PR04MB1314.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daec4644-cb31-4896-0940-08d5d8022b3c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989114)(4534165)(4627221)(201703031133081)(201702281549075)(8990104)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1314;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1314;3:tzhkZMhEMOHrLjsIfpnQxVA5r8GJ7SRErN7fhK87knJS4rrss4fwTUauZsmkPg/4TPMjHvxB63rWcMZkmyBKMQoVrQHVmrSc7MVasVc+5LCUomMeBDwKoLN7wyOKKA8ZQrSvQi44Oj3TV7rndlaXYBiWOUgN471QUkKEhpo0oM8ZYfJjqTadQVBtVFCCMPQ6VhSjk9EANzKUzR/io/Mj19ff8Lzdz/fXpqyMyIRa2EWInDgltpqngwlpx8aTLRaa;25:n65CNDAwPX8pmWB4VGu5T5H5c9OWvqWynPPO/FlIjOosT99m9Adhigdc3Jde05PPGATgqyqREQelhHiiow3EOSjMlsBYa0cVJDjtn6WIuqCP8RMhdyYuw3f994nAlGdp+D+IMzmY8C9rn4xhFB25EJFFFgetAnYmCxixu/j2f1EsZtQWX/0JuFWT8PSmI5JhLyKnTN2eOk7QM08XO3WrnloYiLBwMbpbQfWYgnCfoBjeIkm/buS0h6vfRwYFGh3UjIsxRaHlZ2ZgkJ2T4SrcvHJEwQfLBa9LoPGLUSgN8YCdg8SvMF45Mj3injlTyeZUFwaDFCCbX9OhuHT6MY44qg==;31:g3NR9Dv7V2xwNGaZigf7CfembqhlCdmSQ7wwsgmzgeQB5y/PweY9qcfiknEWQKkM5G3Mqw40qOCq1zCbwkiy1g6n8xONJu9tueKikh/H6USYDGEDvb9M913lnHiYzPxp8AvWHtWwCD4yC/+0eSDF70VadG8NQI+YwQUWLoTP0CeLqijk3f2HXj5HjBde988BY58QY4uPmwdhJd4U07thoEm6+sW77/3WL9JitCWBFdw=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1314:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1314;20:aJCvPpPbZzFi2LOqu2HcgjDMjIIhGNA5mUPOEdZc4JIPd5H3SYxzHa6PJKt+gyMk1Ml/bW1Zrdh1euHVs+8ZDpMquSymbNXl1eahlGi2OTd1IOp3Tks4B4wfiCMyULreEJ08TU9Hmg7gZUutlmlKddZY1jQ02P8G5s8SEXIOeVNC2led6lK7EjOWl68ohVtoE1fdj46AwUUYbDh0hMYxj87Zd2/llm7lxouT21TLWs0CV6IUnCu4HIaBjxSa7gFAfljC1ICo4POkaCaFXr3s82f9c6I8ANd0vcs/2DnBJNpmTsTfZ9V1sfhqwZQGxz3G+5daFIPl5jgpeWdVNAD8pC0VvatD4ChOz7vEx/VuOtN9QPuhRRdKpRQ91zYqYuMFXaSCeox+1fj6W7k8MjVPkfVWX1HOdHB+ke9yEnBSDNq9mdJQOeLSRwA695su6RTof6HeSQtkofwCto45Eq4pt08Vmz8xYGy1aMla4nnExD4uGzZzktEhN+kpaX7Bv+Jo;4:38WTboTBkdEtPFZWmXHhPk0b8oQEZeZhJpcC1ubLzuaAW5k4BJQ3C6Pns7ZhxAvYLZHJcW/5/x6u2J4vwiWAGq0/ZgqQMlG48VJCZs2ZIHY1QjhziDJkuhDu2i5sSslGVmKEaKzzeVXLFN5k2IKq7zxwNSnSLrH5QIq0LBnbC5WPAaW03+sBSaJTIHfaZTZ2QSu4kqUAU9xweZnBM7SAPJ5RKzmuk1EjRa9detz3k5rdNUQcNAnMmVKtn/0W7MNTSZk0Ln3wsLbT/mflM6TmopV7GvEGQd3XAvUQjSS656YU3JvurZvtRKwP0w19dCHb
X-Microsoft-Antispam-PRVS: <AM3PR04MB131457066A8334E8A8D775EDF5750@AM3PR04MB1314.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1314;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1314;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(39380400002)(376002)(199004)(189003)(6512007)(305945005)(25786009)(106356001)(6666003)(26005)(48376002)(7736002)(6636002)(68736007)(8936002)(16586007)(81166006)(53936002)(50466002)(8676002)(105586002)(316002)(59450400001)(36756003)(478600001)(81156014)(5660300001)(47776003)(2616005)(1857600001)(386003)(97736004)(3846002)(6486002)(86362001)(476003)(4326008)(50226002)(6116002)(16526019)(66066001)(186003)(2906002)(6506007)(52116002)(956004)(486006)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1314;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1314;23:unsnQFaHQT8m5DZFyerw9+pvXOhV8EA8xH6mrsIxr?=
 =?us-ascii?Q?Ge8ktAEzGVQttIX/1exZ9x51lIUFyjXXr9Nj3HbyZxVjhhm1B2dNCrPLY8dj?=
 =?us-ascii?Q?VISP74dHo01nQZnv8vRTNYUC4bP9fQCDQCxwdScUTS5ZeGx/Dzen0SUgsH/t?=
 =?us-ascii?Q?W7SUnK2M7i2B/mCr/26upHY++MKuQDDoVUYJlX9WRBynTIGioi4/kLhpcEnV?=
 =?us-ascii?Q?lSwsJcwZGMaYfibH8P4MQIcFBdosC3k+mH8TGXFNjx12EQZ29CGYYSR5DiXe?=
 =?us-ascii?Q?nXOo4cXUfiba2aAKm6jAL+8VyhXFJiUaklHtUe2wVJ1++mmsrR1TuZI/KHSz?=
 =?us-ascii?Q?yMsP7o1UxBkvwxYZDmmqhezp064G6kgeyw3T+2tYJ/RMIGOS4ebNuy2dkSv/?=
 =?us-ascii?Q?NvLhJML5/cDFVFdf04VaXkHyg3+byFcYbP1f2UzSOa1J1DfgJ26PXEDovnV4?=
 =?us-ascii?Q?Xf3k91T1xIsoBHsHHWzCZCPaGNA45slb+HaohlKv/PddoHDFDS/AR/vfBb2j?=
 =?us-ascii?Q?auRH2Rd2bhpHmSvyCZmokEuOvSCmZncRDUQneTuuOmIH/4OhjI15Inpk97zs?=
 =?us-ascii?Q?tOKy2Y06aK7TRSWcpIaP/H8Nq+JE2/mjiYCrJBTm+MaEJDtnePKOsAipzLLq?=
 =?us-ascii?Q?s3YygaLMNSFbWTb+st/B1fI5olxjz2S+A/gRp4p71oeZap6oEc4yXJkhzRqz?=
 =?us-ascii?Q?03JkYC6ZUVpJJ02QwZIAS4onVpovZGe8V7Tc+eD4IWJJ1z+D7LDGvWcUn+Jj?=
 =?us-ascii?Q?4XmwttZVrA/+Q99HtbG2qAiJwkr/Fq+kj1z9aavsIp+jj+a+yuRiSHyuAyil?=
 =?us-ascii?Q?/R+muS+riq5pYEJrpsed+bcUIRfPvzBOUv3T7VG0e0hP/ceKeuq2IAH32vtd?=
 =?us-ascii?Q?pyFKXTkuMjAmJOxC/ConCKrkBDhMA3MWd4WMN7vwXmSSw6IK0yQHvZqq0hXP?=
 =?us-ascii?Q?ET/ALqOAOPk/R1DCbII5tjj/4SvdiFF1cVmw7eOJTZ+sRItwDqNgFcTatKQV?=
 =?us-ascii?Q?nZr2lws7Zw/vnOpHp7Og2+ZG8Mzn8yoqZ9sSZ2MbfFabMKU7Up79SwUw3SJD?=
 =?us-ascii?Q?rq4cCV2M7XfnB2YibI1/Z3pOSWgoIaK0m0Lssh4keOW8GRaXPjanwUBCYekK?=
 =?us-ascii?Q?QIMDW6LLxkwldQd2AWWBuAnK40h39MGaLTv2vn40EpDRETDOLUdkg=3D=3D?=
X-Microsoft-Antispam-Message-Info: N85l9O8Gzk9hYzWAC7ySClzkyUzz9thXL0PcMjzrQYNXckOyTpPwRfKmVucgl+HWvjtkU0zw0DYtNnEsArnJyCih6jnkxerX70p/LJJSf3uAHsmYLq8zEWvDfjM5aSqUglWIZ1i2bb/BkNpnwgZdyqy7wOphCQItMOMlPB56684JbHfMuUZvc8uiGQGFpEJ+YZgILwsETytuxKejZIHfYekUrQCD4V/L3HbVtF1UmcgfH2Ii21uTIsKX08HVHsmb3UXL+KzJA/vse/Vsf9NL7yDCVDBD0VByjUYFdSI8IU0AyT/PkDwnpyWbMOFdjAnt
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1314;6:9f4HudFTo6pRWhHFLRcfoFtXix0M7DZoz+EZBOajZdwKgY9X5VcMsA5a3Ased0bWh3cn6SvKmlEmkkyyraygBAosavkcKSOu8DsLAOnJzHEevyQleI37Dq+1iglXudCP20RndAJkrO6/n0vqp4OS/M4gB+ydxeMsdpUJEuOr5++TYr8ROzy/3YZPFT0/mgVUZhR8Y7AiGzTuDIcGr/7xgPbBFg3Pw16ijDR1Ir+i2oIJm+0J5bgOWtv4N+4GPPgekUok64OYvOfKyz6Lmo1gpZt6Psgp3grMiUyfUUfcXqDiZKdN2FPnu3snLvBEGn6zfo5b35C8odpFVK5qpSP1MzX/OwJdTKMcWou9mWuRGcUVQ364dvYq7fmGWOKHvnx41WqEmdo4ucqOvoN2driNGGKcYXf5LAe1rJxl0AX+D6YHKyvD89a+kOutDmq3K1cDlW/PZMV6IWa6bvZI+FCwJg==;5:PZ30a+DWsMPSgcy9SqbP1pYiaDsm6VDpA1S1lTK5IVXv/f2hQPzNRKHlafqzfm48WvpJrlPA0MQVS1Y6O4laEg7I6vMHWONXRkD21w6B7F8YAi9JGgltqfKujqMvOW92HcOX0gNpb9W4S8TycV9xjbE3Y2h5qWySC4Lbhu2alhw=;24:6B0fRjKnN8Zx8bruR6xpyCN7oiMaND1LR9V9MyXbnkEgRo4vYqbwyv+X5TkoN56W5QRSHaNYdna/QVNK6GaFiuYbf2GIEyQwyD8AOzfRF5Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1314;7:7spA1+1FlYjyI9Bj7nsKyMga9RDOgqfP2PuokR75fJVhiuZG8X9ZdS1sc2PGfxlh51mw5OxmTN2nQO84Wm08o7rfkTkcRyEPQOkHEWlO+YZBbFFQ31efayhh16H83X2wY/7caLP79r3wT60eGWWu5Ijk/vzb/pIVtwmvzAQ5ulwtjXcwx+wEDud5FTTipXfeFFjzaqlDOxdxxTdgycJAC0kJWqEOdEJ8Ou+8fm2YD/bQP+VLqnl7+NLC+iq+cv1s
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 05:36:53.5931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daec4644-cb31-4896-0940-08d5d8022b3c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL has HW bus auto clock gating function, enable
it by default to save VDD_SOC_IN power, about 5% ~ 20%
saved depends on different use cases.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c                 | 11 +++++++++--
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 791e1fd..b08e407 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -648,10 +648,17 @@ void __init imx6dl_pm_init(void)
 
 void __init imx6sl_pm_init(void)
 {
-	if (cpu_is_imx6sl())
+	struct regmap *gpr;
+
+	if (cpu_is_imx6sl()) {
 		imx6_pm_common_init(&imx6sl_pm_data);
-	else
+	} else {
 		imx6_pm_common_init(&imx6sll_pm_data);
+		gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+		if (!IS_ERR(gpr))
+			regmap_update_bits(gpr, IOMUXC_GPR5,
+				IMX6SLL_GPR5_AFCG_X_BYPASS_MASK, 0);
+	}
 }
 
 void __init imx6sx_pm_init(void)
diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index e06f5f7..6c1ad16 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -457,4 +457,7 @@
 #define MCLK_DIR(x) (x == 1 ? IMX6UL_GPR1_SAI1_MCLK_DIR : x == 2 ? \
 		     IMX6UL_GPR1_SAI2_MCLK_DIR : IMX6UL_GPR1_SAI3_MCLK_DIR)
 
+/* For imx6sll iomux gpr register field define */
+#define IMX6SLL_GPR5_AFCG_X_BYPASS_MASK		(0x1f << 11)
+
 #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */
-- 
2.7.4

