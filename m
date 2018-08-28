Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAF2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAFD2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hA9XhAUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAFD2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeH1Mbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:31:53 -0400
Received: from mail-ve1eur01on0080.outbound.protection.outlook.com ([104.47.1.80]:35184
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727299AbeH1Mbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvk8HM5VJEKcRP4yhfqjrm9u41zfvt0P4tglQdaqvEw=;
 b=hA9XhAUI6T2MbAsz4vTl2gQk0hNpVKhdSXp54o+xF8Wg6kgcQ6/crAzqiEyHBs8wHxVX7X3qRuLJclBTZXCkEWK3VFPPLJ0KClPYLzF8sL7Nn/Y4ZVQdECII4u1cxYxBD4mi0HxdRYPieDlSWo0U88HCM8Ffa9ru8hTg7Q+NcMU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 08:41:08 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, andrew.smirnov@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/2] soc: imx: gpcv2: make pgc driver more generic for other i.MX platforms
Date:   Tue, 28 Aug 2018 16:36:46 +0800
Message-Id: <1535445406-19633-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535445406-19633-1-git-send-email-Anson.Huang@nxp.com>
References: <1535445406-19633-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0067.apcprd03.prod.outlook.com
 (2603:1096:203:52::31) To AM0PR0402MB3907.eurprd04.prod.outlook.com
 (2603:10a6:208:f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a12b11-fe87-4a64-8885-08d60cc201f6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:Suqr9xxOgEJPZEv8bb/m3qOHr2GaK50g2G7ahSiSkd8YBCO8Ze1kcG0uVO8yqu/igl6fmfzUOHwmRyvGPfQ2T3A+shmfKiRvaRzWtfkKGgr6qedTvORFr2b0c5cJXe7vsovJKY/67S/V75F3fFv20Q3XfyKHh0hNEZBbZCvma6574ncffjoeMVb6Xxg/RtRrE9wTboQB5SqYgUyjezsxzdtia6SpJTB+G7z06ds+vmp2VUTtrvh9lISu78yrlSLo;25:AcyOjpQEDMviOVOVwF5O0h/6aMBh8fFgJ/J6UQs4UJeG5TQ1HzgjlZmqi9tYwVtv6zfZfLkMA9KCWq8NY1cLGL3FnzjOHkWC/W4RWkzOW/t14oiMI8MXOkdOSxSUECnZMrYmuLVpvraCM7ibNOB8tf7n1f5BADuHdPTaJYF4EFl7htUuwWTJANC20zWPBnCCj/yWkcId2NRT/hSCwvJQli/UZzJVjw138arX9RUPgGzSIPudJIwhg3NRlhCIuYa88bdemCQGj/8uO5LaBuWILM74mEdAMdSDua/hd+OXZxIcOFR0kWVlpcc1EMzKjA+4+ea79oVJBdkZG4ALxQmUIg==;31:WmdSH6+C5+/y27Zj23JA0h4v/kVTozNTX/jicqR3SHCdSkQTgZxZ0pJ97xmHo8wHyaWZThh55IJ8fH0Ru3pG32lrsjscxOch7Y+Lb5SOyh05VD72p1mpvGaoQtMQvWHQ0G4xv8wTyUy6r3RW/Tirdj8scviLpmEnO7yoNesokycozpW0bhelEnUjlOz249xljKeJVXwLG9/1ZO9wqQQ3t5pWNe2H5VArX3FvTb3pGuA=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:tb3KeTk6mm1u2D7K9lqU9dx3cmRUazGxShmOdJLmTJTtPGQ2g2NKpOfFD9YcrSRa9OqkcaoteDZl+LYMR/FKicYHEQYD5Fz2rrlgykU482pWqdqFJj86Bu/SEKd8zIdQtv/OePR6T0PcK4ILvXOPD9jbrnykczsdrTGVAPbYl3MxjroLMVdVf83K2EykmTcDEsPjilJLt7q+xccykUJoxcD+cPSMXkiCNUU9bgqoKGAi9oULd6/P3yuFmN4pPSpUWkGdHjtW5VwhtdELsugP6GdQORNZJRcNgAOtL9lNlzQyE/fJ6YSf9zoAnWhq6h4zjT8EXyrshqdMzZUj7w6guVM6yg4vkWbRtG6qFlb+Na9hJvV/6eIbsNlfgtLkNFeGZ6AY/MKVXraoTz+sLFKAJ0ESLEcTiWiW6bPVnlbCr1m2Qptvm5M1M4hQbXkHWUCOkBRXR4f1GO5bvJmpiu5AUBBUFNAPw2gix9z+0B9cqMAOTph7D/7A1Mrrh0ZrP13u;4:MOcN4myDlHT57xhtuM0xiHY3KTPyzepUJ7ZjzCWqc1S1WZ+ycY93FYaaRka45YBBIFKrZ6d+B8dZ/HtWg2xM5TSEuvkvTT58TBzAVKrhmQWBQ4Un5PTMqTuVlH9fy2cPu5glyRzZFTPA0+QT9TW0KAKZPKdmp2ify/gkWrwO3xx9RkLZmAeYUCLCKJbcY/SIG5ucir1oAlU8XvB+qEBFq6L/tNKb237NAdCEjsQDQ/Mriz23d24o/LXCnHPgMfWZlrlX8wvYuSV6UzGJXMPr1vcB+XDXa7twEP74Kvbu1C+7syyxLz/QX1GQgz7tVLDnxTZscFWEVLA4U03ECrkFflGZTVVK3a8Y5QB2mDhwimw6QH9T34UOsps9DSXiZiLCgd0BK47QqI+6Uh12puxz5+ZXu6Vt+z+tcKH84faRseU=
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3907D77CF7B4D393918240DDF50A0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(185117386973197)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(106356001)(50466002)(105586002)(68736007)(50226002)(8936002)(48376002)(52116002)(16526019)(186003)(51416003)(76176011)(6506007)(386003)(47776003)(66066001)(39060400002)(305945005)(26005)(4326008)(25786009)(36756003)(486006)(446003)(2616005)(956004)(476003)(5660300001)(11346002)(6116002)(3846002)(97736004)(6486002)(6666003)(8676002)(81156014)(81166006)(966005)(2906002)(86362001)(7736002)(478600001)(6512007)(6306002)(16586007)(316002)(53936002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:YfALGUp4DAn/VRpljG0d6o2UTa4AXCLAoT7x+OF?=
 =?us-ascii?Q?DgGHinjxu5kfyujLTX2pY9s33KZ44svu30bloke98wF5DcFJrGq3Tft1nBNA?=
 =?us-ascii?Q?BSaky3+Fv10M3698kVPJSHmhBiexU/USzb1UEClTkUCz2vA2t66CvyGKqOVr?=
 =?us-ascii?Q?EsER5Sspq8xPEgCEU6G/8DzDB7Oc7a9mT+fMXqK28aLFMRoQqvYn3QoF9RRM?=
 =?us-ascii?Q?RhETRzpz1aqdL2i5k8EhRmpAyssrqnknaS8lNXHgTG/CNJkrXNqYtm63Rszr?=
 =?us-ascii?Q?ix9eHFBOLIhwR27Oa1T3mFHbmNXc7pCmKVUyEZ3NiDk7UZpO2Vezy5CQwhjh?=
 =?us-ascii?Q?E4ZGrxtUBZHvYJW1luFVhYC26eQfflUEOZC7qvnHb5GP9U3cFdVejbI8O9BX?=
 =?us-ascii?Q?u/Mp+r+LgmBvAtWiDuj4RF9Mm5VbAY7IM+g547FDh4czL29UiW/x/TsWAYtO?=
 =?us-ascii?Q?XkBaWY/kGnTRUv3lCPEZX9QtmCOJ/BcOzjedPF5x/SxJVnyPil0FEuBvQrFe?=
 =?us-ascii?Q?tEDfpMK+Sr47j4cU2FcvgvzxiFKviWAC9xCpepz1U71xyzUNEsqDhf5RUw0e?=
 =?us-ascii?Q?UfY2Ml0lMrVJ7XgM8lGoK3pVlbtdCfLI2qSbfKKD8Hpso1KZQX7ognzVKwd5?=
 =?us-ascii?Q?eUKPzO3G3NjIbDmGQdAXhKRq5BxaEb7zqgWKHY47w/M29maqvwLChXVkEXIV?=
 =?us-ascii?Q?O4/hbOjDBwsMlIGBUZNJTpQyQiRdl+2jz2RsWGFCEvG6Hgu2uFY94+QgCwaz?=
 =?us-ascii?Q?n6HTzN5C8sDMsTbSqK6zp2HJ3XYSEt2E/YepP7n1VJIE/C6FHGITzC32ZAqW?=
 =?us-ascii?Q?bibyUrzkcwqRwIvLTKtPBF2dhtslSpWAXtxeQ/eVSC0CrP+Fp6a8YYaof2ft?=
 =?us-ascii?Q?/dJpJOH2bV79lcNKrLiGYFlloYeM50T1afyp7JrjCk0JMW1HQnK/jCJvPHQ/?=
 =?us-ascii?Q?ZeoCCYtU5pIqw7zrfxo9h8SABqWqMohlPr5I32SDMsyXEBcTNDQJuoap37U7?=
 =?us-ascii?Q?4hU2eomOrNMdkR8fTu0Zf7kQn+6iPusGoKJBpxzKy6tTRVmfde+swQPfamYN?=
 =?us-ascii?Q?DHpHefeLGSbKURK0sCLSu7IqlJDxoXmGhrdqzCy2nb9+kdzvE4dxZlokiSEf?=
 =?us-ascii?Q?qLmsBA3ILbsnd80wnvxJLAeF0cvB2kPvM77cbh/qBt3uwT69wCNm/ZayswbM?=
 =?us-ascii?Q?IV//9DxG6Ov/jaQMdjjBVmU6XfRC1utb3TICMiQue/4V6jMnB/J8cJ29hgA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: k/1gVQl2+5075Y0zAkLHppWBlOyyNfEBbeyRXJn6Zbcpc0Pok4sZBgfwki4ziSCK5lQWQrdj7HtpBX3N89/SR6EDfT6yEFomZ7ABrzao5+Hlbh81R7HczBlQeLjd6UyWaLiyyyRLyzBv6D/YzQ7kPuuRdKmdOJnGPZJjowHn3JowGAr7yd8zekymOEiZ0wIqgmnvIqxhuvWCgmdMLYCy2UY1cJWKQXVUdQl1hZliCUl22iMVNdOP+dVhtvgD91mwTjHOcH3qaa9mnr5nKHSEmxKpAF8mJxuCL25tK/FDErxtmxlMrALrGAyeVct0bQ+1+L/mr02a5fD6O326muJMjA==
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:PG34X2ZcBevA9GF4y0NoAJLn5wr36BkX+BV1m51HzuV4x0b3c8Mrs10afF20nbnZ+/sdWiXMcV4AVqY5FuhkcZzaupFp46pGorUE6ajz9wkBjOmphQy5N01S50+nq6XsYTB43JWDjZsUNfA9dU9jxWmbEZ7+mSCTNlMeCJhU/skSJo1kC9YhFp4AeHPLlwrjvXVsIIkwhuKdxlP5qIMS8eH5Se4jMqLvM3SlFKFZMhDtV4XaNverJ9s7AI7cPCoKC1VtdellRcvP2TUVCsmssKJuRc9PkGC+y2801sLctOH9yhWNGWCA2HZ3gT58tIYb+BLGR3mGUxhXtdW/ODs7s3TOPTANsDnyI0rq8vbMGe1nDFFIjYbGGPwaqMeqwQDNEEYMzSs7rDAMVXkDfdst2HOyM998gf6nS2gr9f5695obePsAJzCtE3XI7yiwwHkAIY195WxksqSOooBDzAle/w==;5:eRjjTrGW+B2VUNoj0/Md3G6YN7aDQuyoTYjbRsRSTKl4lQXKzEdrCnZL+gnpOO6nHOlN3k4DA5e0IYQLLr1tzWbmvxIlresUmEys8ju1VXs57/fR5PG8qxt39OadErljhMstLcYzHKD4lT41KF1cuTk1n1h8b0TvrQuDZoz8fYY=;7:ncAIEOV80ohhgSeYypRQqH3c8LLhZLS2psKz/cjYk7W3T7zEDUYgsHq7yv2kcSd+Qj60tVaJ5NJuTvxx9dgAjZFJRlaKg9JDlf9WizCla37ednJe//0ZpWGAbeJwZncMlpAaeeIqYBPM2b/Ss7r41LF/fYc5F5IlOQe6n3fpPCNQ/pDXx29gEXeI6ODRXpYJyQ9Z5I0yT9sV9LzRi5aFY0oEFOYXWYQMRIBKGpxbtq4wE2bdonKa2EHOuvBKcNHJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 08:41:08.6255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a12b11-fe87-4a64-8885-08d60cc201f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ and i.MX8MM share same gpc module with i.MX7D, they
can reuse gpcv2 pgc driver for power domain control, this
patch renames all functions and structure definitions started
with "imx7" to "imx", and use .data in imx_gpcv2_dt_ids[] to
pass platform specific power domain data for power domain
driver, thus make gpcv2 pgc driver more generic for i.MX
platforms.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
changes since V1:
	use .data in imx_gpcv2_dt_ids[] instead of calling
	of_machine_is_compatible() for different platforms support.
 drivers/soc/imx/gpcv2.c | 72 +++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 0e31465..938103a 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -14,6 +14,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
@@ -53,7 +54,7 @@
 
 #define GPC_PGC_CTRL_PCR		BIT(0)
 
-struct imx7_pgc_domain {
+struct imx_pgc_domain {
 	struct generic_pm_domain genpd;
 	struct regmap *regmap;
 	struct regulator *regulator;
@@ -69,11 +70,16 @@ struct imx7_pgc_domain {
 	struct device *dev;
 };
 
-static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
+struct imx_pgc_domain_data {
+	const struct imx_pgc_domain *domains;
+	size_t domains_num;
+};
+
+static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 				      bool on)
 {
-	struct imx7_pgc_domain *domain = container_of(genpd,
-						      struct imx7_pgc_domain,
+	struct imx_pgc_domain *domain = container_of(genpd,
+						      struct imx_pgc_domain,
 						      genpd);
 	unsigned int offset = on ?
 		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
@@ -150,17 +156,17 @@ static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	return ret;
 }
 
-static int imx7_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
+static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
 {
-	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, true);
+	return imx_gpc_pu_pgc_sw_pxx_req(genpd, true);
 }
 
-static int imx7_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
+static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
 {
-	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
+	return imx_gpc_pu_pgc_sw_pxx_req(genpd, false);
 }
 
-static const struct imx7_pgc_domain imx7_pgc_domains[] = {
+static const struct imx_pgc_domain imx7_pgc_domains[] = {
 	[IMX7_POWER_DOMAIN_MIPI_PHY] = {
 		.genpd = {
 			.name      = "mipi-phy",
@@ -198,9 +204,14 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 	},
 };
 
-static int imx7_pgc_domain_probe(struct platform_device *pdev)
+static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
+	.domains = imx7_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx7_pgc_domains),
+};
+
+static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
-	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
+	struct imx_pgc_domain *domain = pdev->dev.platform_data;
 	int ret;
 
 	domain->dev = &pdev->dev;
@@ -233,9 +244,9 @@ static int imx7_pgc_domain_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx7_pgc_domain_remove(struct platform_device *pdev)
+static int imx_pgc_domain_remove(struct platform_device *pdev)
 {
-	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
+	struct imx_pgc_domain *domain = pdev->dev.platform_data;
 
 	of_genpd_del_provider(domain->dev->of_node);
 	pm_genpd_remove(&domain->genpd);
@@ -243,23 +254,24 @@ static int imx7_pgc_domain_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id imx7_pgc_domain_id[] = {
-	{ "imx7-pgc-domain", },
+static const struct platform_device_id imx_pgc_domain_id[] = {
+	{ "imx-pgc-domain", },
 	{ },
 };
 
-static struct platform_driver imx7_pgc_domain_driver = {
+static struct platform_driver imx_pgc_domain_driver = {
 	.driver = {
-		.name = "imx7-pgc",
+		.name = "imx-pgc",
 	},
-	.probe    = imx7_pgc_domain_probe,
-	.remove   = imx7_pgc_domain_remove,
-	.id_table = imx7_pgc_domain_id,
+	.probe    = imx_pgc_domain_probe,
+	.remove   = imx_pgc_domain_remove,
+	.id_table = imx_pgc_domain_id,
 };
-builtin_platform_driver(imx7_pgc_domain_driver)
+builtin_platform_driver(imx_pgc_domain_driver)
 
 static int imx_gpcv2_probe(struct platform_device *pdev)
 {
+	static const struct imx_pgc_domain_data *domain_data;
 	static const struct regmap_range yes_ranges[] = {
 		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
 				 GPC_M4_PU_PDN_FLG),
@@ -307,9 +319,11 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	domain_data = of_device_get_match_data(&pdev->dev);
+
 	for_each_child_of_node(pgc_np, np) {
 		struct platform_device *pd_pdev;
-		struct imx7_pgc_domain *domain;
+		struct imx_pgc_domain *domain;
 		u32 domain_index;
 
 		ret = of_property_read_u32(np, "reg", &domain_index);
@@ -319,14 +333,14 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		if (domain_index >= ARRAY_SIZE(imx7_pgc_domains)) {
+		if (domain_index >= domain_data->domains_num) {
 			dev_warn(dev,
 				 "Domain index %d is out of bounds\n",
 				 domain_index);
 			continue;
 		}
 
-		pd_pdev = platform_device_alloc("imx7-pgc-domain",
+		pd_pdev = platform_device_alloc("imx-pgc-domain",
 						domain_index);
 		if (!pd_pdev) {
 			dev_err(dev, "Failed to allocate platform device\n");
@@ -335,8 +349,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		}
 
 		ret = platform_device_add_data(pd_pdev,
-					       &imx7_pgc_domains[domain_index],
-					       sizeof(imx7_pgc_domains[domain_index]));
+					       &domain_data->domains[domain_index],
+					       sizeof(domain_data->domains[domain_index]));
 		if (ret) {
 			platform_device_put(pd_pdev);
 			of_node_put(np);
@@ -345,8 +359,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 		domain = pd_pdev->dev.platform_data;
 		domain->regmap = regmap;
-		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
-		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
+		domain->genpd.power_on  = imx_gpc_pu_pgc_sw_pup_req;
+		domain->genpd.power_off = imx_gpc_pu_pgc_sw_pdn_req;
 
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
@@ -363,7 +377,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
-	{ .compatible = "fsl,imx7d-gpc" },
+	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
 	{ }
 };
 
-- 
2.7.4

