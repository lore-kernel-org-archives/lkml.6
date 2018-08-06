Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FF1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEE8219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bW/ICjh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEE8219C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeHFIwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:52:33 -0400
Received: from mail-db5eur01on0046.outbound.protection.outlook.com ([104.47.2.46]:50928
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbeHFIwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u+d53P5gk+kiklaY8vb3jaEiC+PxgbVReMdKrSO8jo=;
 b=bW/ICjh9+qABmK18zt67E4zWUYSXbRjunHBdMCg2+YPPkkTxShx34TQxPpK9+EMSEZWnnvcr8KesNS5IAvg917yoBmoz93nweThn9jIyVDOQHvTfevuURY8a56SgG8mMWB+NjcHXippd412Z1kFfwyhCVyq5spJkIJqralzzvsg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.17; Mon, 6 Aug
 2018 06:44:18 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] soc: imx: gpcv2: make pgc driver more generic for other i.MX platforms
Date:   Mon,  6 Aug 2018 14:39:49 +0800
Message-Id: <1533537589-7202-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
References: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0078.apcprd03.prod.outlook.com
 (2603:1096:203:72::18) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e09aa59-72e7-470e-5d3c-08d5fb680a45
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:O0+3nfhfikNQl9gZ40OOcMZF7iaWbGrddX7urOSr5EuSE6gi7VGPShgr/z6kot/NCAtlzIXwE2yGI4jdRp8EEfSRYeS5TfsiazCUSx2UKhvZwPqZZVVMnUC7DpZPSuBgLmayM9Z2iHJSYT0vFOrkXospmGL9Ck2JISwHGu2iorvLYa/BkuggtermbKZhuTGYnbVA18iiYMGbZoKNeivTRxkpHZNuOV/yWaRZAQlkdH6ed/c9a9d/LB7xQ8/Tmkj2;25:q2NAM0e2UijBw5AztQ6XfUFBeDwgQuAwa+Kh1B1xNqcMqQnswymkW3S5GJY1BWh/gjJcwRNndBPj8IihO+9Z/zaZwd5MhYo4XFutmL4as0IX086RHuqsUl1MSj922vHHDXvAbnmz/YVyQvKuV6wIF25DxSQ3KAr7q1BzraDNKZAJWYQTM98UiBXn7Q6nG5kl9adwccLTnFOAW6flJnLYxep3YBB3CoSPI6p+ekuyexPXtd6kThx9WtZ9L2hMX8gpy0Pj+TS7yzIbZRnxEpfj1+/+e0/PLsPkOkfzdG0XG29IyKsq7cl5F2ePe84xExoHzh7/vRLuijCIL5/+w19UsQ==;31:sDa/phxeJpKxMTnhuz1OAanHKXy2MezuXcxLvjh9h1aQIOnWkb/LT3NTKZBwezFTSV20cgOcqL0McepN0Jec6jTYeZLXmyqy6kBG9lj1k+QyX7pqLaIK+ql5/q/pAvRH4YI0rmkm4M92RRRt6brmPqVC+t6UHBgWLX9lOJtllN25yG8DJiYlB7SRsLXEtDaFHHNnuYEV7RSye8t9KeZgmmExop07YiNKozUz+JqxJXM=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:0rnkKwzkz3K2gXCttfnrs5qmab6WMJ1CSVOAXnwfbmEuu6hIJaWc0GuRbm+DzPgIeikrdlpljQRDG63oeRpnYR6iox6fTs7/lVcTtvfv9X8NKL4W9Xl5rdsJkTuGuC/3502vVGHP0vJddvIF2O50lJiK37MdcjNKzgvpHHpI0yQegWmp49X7yI7JvSFJXp5orJ9JnPR67LpsxiSQAohZPa2WrmSrWxz3/4otd9BEd0BgaHXp8em8LunBUuY0VRR0AnmjCtYM5rAoIXaPe3f08FonKsbC4QHCj/pNzbJlZ+R2ZWy+wQqt3jnJ4rjv2SMgtpp0UVDnxlKnYZFRIWPZHEfu36OPQshmq9/FhEfGSUiMZMQyKRqTSf1MCE9r9QVu+WHtOHdDYCaRX1AnirljJDOnumbflB/Y02yDgj6bn1O0PwjxXOucoW9LQhoQZkp89Ey5CiRZjKwv6OChm0tl683jfIhJ8aLEUGxdgzo+UELM9bqLGw7uG1r4y7qN/J/B;4:JrEJS9DsdkSUIUzcKDhG7iK/Q7VXY3x/XQOaHtikzfSieVk0RO9TxEJbzy1WpSsqIgqpZKPVyiJBqdJDUP10DWdgHEtNwHXWaBdvg+PHI95FdGaCX41BgkTesgXw3ZXUMFdalb5Voh9vcDcOm0jcGvn+RmUmdXS3qaCJ5kxSmteQjuEV6NR1FAZ+IkhW1OjEkq7E47wD25E5qt6A70DF3FG/BozmsU/dDRzM61OkqDWJwfm3F0QmcBM5pQ2yf9bd2kTaR24lnD8XI+56zkzI4fTdWsFwhZqmqzVNasgDJ3NFzGiOVQwGVinHGdldi/yv
X-Microsoft-Antispam-PRVS: <AM3PR04MB131560F360EC7D32F1D43F32F5200@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(189003)(316002)(5660300001)(6486002)(36756003)(16586007)(6666003)(53936002)(7736002)(6512007)(25786009)(97736004)(305945005)(4326008)(106356001)(105586002)(446003)(486006)(956004)(476003)(47776003)(8676002)(48376002)(50466002)(66066001)(81156014)(81166006)(8936002)(50226002)(2906002)(86362001)(52116002)(26005)(478600001)(68736007)(6116002)(386003)(6506007)(51416003)(186003)(16526019)(3846002)(2616005)(76176011)(11346002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:DyxTV4Behex7hY4gZ0Yuog8ISSRp+f3VgUyjZCtDt?=
 =?us-ascii?Q?NjWHPxaIJwla++WQAF4+RFlH0JH2bzTmF7IS3vV9BPTEBQEzz+rH54w78GnZ?=
 =?us-ascii?Q?Mz8uK94x6WwyurXr53mNlFzS0BLDYSEa1Mu1AgSPXSvNLNV5jNO8FliuFA7I?=
 =?us-ascii?Q?6oYzy1Y9gMDmsLn+jrcu92hcacwX6iBZZ/Afp5mGbkNlpLXUr0v+7CF8cQFl?=
 =?us-ascii?Q?7V/kcpFNcj8N6m93kalYEnZlnVnht+TriqukyTHN65dxQBrIX3UUI83MAxP4?=
 =?us-ascii?Q?tdX9cIC6QngaqFp4BCbmYmw3loZ5PuIAcZwBhbXA366jTKAePts1dAwR984u?=
 =?us-ascii?Q?mm1WhIT4hwZGgkw7C4lvf27Wz8+ZcOr0UA3tGjsck3Tn7lE7cE4qxKs2R6MS?=
 =?us-ascii?Q?SXxe6hU6ajtlPVP8UnLXweRkBBoSIpFdJOVcwXn2vjPcI7hKc91OyZFDLzcq?=
 =?us-ascii?Q?/ZDzp5hDmBZ9xXZAB39NAVozdr8V6+8zdUTsTdddGgUN4t1/wVd4vwB//EEj?=
 =?us-ascii?Q?pOyQgrFDb0ous4GVkHTihaAEpk7xALm0ZMDoyxQzQ72EoP/vcVLHsBSFl6BA?=
 =?us-ascii?Q?5iGsTMXxUHc+qk31p/DJgN/LHHv0ftX4H3OnP9PgP2u7YfqsKpnK/+lI00VQ?=
 =?us-ascii?Q?57cp53um+lv9QBjb3TMMQpaG9GMNblxIqdzUShMwyu9fTy6FCrcjnr/kQJNl?=
 =?us-ascii?Q?azkrle7KPtt6PNP9iUHG5mkZX463YANAMgzoFMbU6EX5n0RBGyqXUjfBi/x0?=
 =?us-ascii?Q?ffTfn5lfM8IB9KaICUUGov+ktnodN+q2XzXE3jbLnk9dL5AMxQoH/cnkY9J5?=
 =?us-ascii?Q?hjBE4cE8YGikD2cJfvZWoqqS/2YQ5wMMCahn2eVmrjVpoz5UWn8a466UF4Fg?=
 =?us-ascii?Q?8FtG2ncPzO7bBOiJITkbfvi/lls5s7+SKfbU08fdpaLCNeG3iLopu9Qf7dEb?=
 =?us-ascii?Q?arfswx8RhYXIdpnAzzFHnnmlZggh7nv0NnbwNRYlZO8fyXREF93CL9K3FGZK?=
 =?us-ascii?Q?CORgqU/9ZBJmKgdIs8PxRhw3ItKXse6amNgfO9ez1xwSUccKf2b9Ep1g8gD7?=
 =?us-ascii?Q?bl+rBfw2L+WsvwU8eCv2mUebIVf/2E3SWcdJU2UQ5WLUJUlDeZk3cH5isaaA?=
 =?us-ascii?Q?ibcbefZ6B/yR1ViIZRYvyUyNbDziaJNRQemG4EQ21xmKnlOzBK+Ow=3D=3D?=
X-Microsoft-Antispam-Message-Info: f81Oyz5Qgbsgvo10xKobeCspOrblBFsCMVtGufM79j0CEAB/qS+dz1GwkMDdYemwGRmQcXdr9kktNSlrN3sCbZHgcRYPLoJvv7pF/pDBhDvHgrqNalw41WGnCJ95+VyxR4tpYAR8ZPlBbyvUC8786WnrLaUjjL9DhgmWRFZRx7W3IC2nUSgfZ89OwBtRA1Cfocph4RdnLLzHmI984w3zFr1pgmKEOOGnp3Kb2stbfqIoI9QJ6nspOEqfcVY41MWTuuK9PFnOa2b5wk6uNE+r33q5UX8YMps9T0WuNOP+YcXUssvljUx7tFrbrmTzgaZ7mbB0GY2HlOuUDVFw0kkAGFsLpJn+b2VYXS9iV6O6HzI=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:GmasTMiOf4tmfxs2FCd8Vfom0XPtpkVzL7mPsBTMqnRJ3/rc6MIujxYVDrpo3puscwL7uaGEHvBl/SOI+AAhw4bxxGfJOIstvtIel3L0pMqQSpEaOXykXnbalmy+zAFRDkPyZt1Ifctgf5fm30lCY65pPBI+Dw4SC2OBRrVZ2Gn+Rfv6qkBLPZOGlV7hoEbs+yUGg7yysETt8s5s9PXoTPOIF1pnsm62sbS6wFxucY220l7GhJUgk9yMw57UpsPR3rmG3x30m2rJb499ddkZEvw8w2oGm7WFGSPTmMWiFhzXs9N7ZLFzfYKrTDgnTDG2JVMxQN/lB0eueKo/truo2/d98VAyD17iBML5z3xXHH034Gb4zpT2RJ13eg03SBBptVfiyexnLnJtYi9VBKJEyQKijryj7UFaj3CnKQVQXj1wqrD66peeVWZ8g5JhzMTuHYqULkFX4QdBxM5cWlZSuA==;5:EbCgpJ9VMjOzEDVtDEzD1fRVcT7B416p7hR8FtTFhdtnPc8kVwtHH09114w+7LRIagMSIxW9VSLfs/DFlRhWsyuaQefqGiPrwjGnFT5Z8Q0vvI/EbeDKB508V0+HBCArK4X1SFzSeOOb7yL4TYtpzCnTeAedOtTuwjrBoGbx83k=;7:BdoeW4XmmnHQa9xqe+lTmdenh3/Rxj2W6G8MEk08zIRRlP/oZlEnLdsupfxEty2ZU58JH4cwJvEYNo3/mbc1pgKqNKE7P7B1HuCFNnZYK3MtGLkIsztWoW6HDuVKqFrh5FtwiuRdckx8lwnnbbRESC+YuQKHRi+si8CgSO5reVJGjd+Vu64zXmYv+kEMZw6BNN9wG21+PUhv/Acl25/oU8RK8i/cKZYpk3yVVyvenc6/cBUJkWS4mbcKYZpYcd1Q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 06:44:18.4480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e09aa59-72e7-470e-5d3c-08d5fb680a45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MQ and i.MX8MM share same gpc module with i.MX7D, they
can reuse gpcv2 pgc driver for power domain control, this
patch renames all functions and structure definitions started
with "imx7" to "imx", and check machine type to pass platform
specific power domain data for power domain driver, thus make
gpcv2 pgc driver more generic for i.MX platforms.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 68 +++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 0e31465..0e33cb5 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -53,7 +53,7 @@
 
 #define GPC_PGC_CTRL_PCR		BIT(0)
 
-struct imx7_pgc_domain {
+struct imx_pgc_domain {
 	struct generic_pm_domain genpd;
 	struct regmap *regmap;
 	struct regulator *regulator;
@@ -69,11 +69,11 @@ struct imx7_pgc_domain {
 	struct device *dev;
 };
 
-static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
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
@@ -150,17 +150,17 @@ static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
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
@@ -198,9 +198,9 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 	},
 };
 
-static int imx7_pgc_domain_probe(struct platform_device *pdev)
+static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
-	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
+	struct imx_pgc_domain *domain = pdev->dev.platform_data;
 	int ret;
 
 	domain->dev = &pdev->dev;
@@ -233,9 +233,9 @@ static int imx7_pgc_domain_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx7_pgc_domain_remove(struct platform_device *pdev)
+static int imx_pgc_domain_remove(struct platform_device *pdev)
 {
-	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
+	struct imx_pgc_domain *domain = pdev->dev.platform_data;
 
 	of_genpd_del_provider(domain->dev->of_node);
 	pm_genpd_remove(&domain->genpd);
@@ -243,23 +243,24 @@ static int imx7_pgc_domain_remove(struct platform_device *pdev)
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
+	static const struct imx_pgc_domain *imx_pgc_domains;
 	static const struct regmap_range yes_ranges[] = {
 		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
 				 GPC_M4_PU_PDN_FLG),
@@ -287,6 +288,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct resource *res;
 	void __iomem *base;
+	int pgc_max_index;
 	int ret;
 
 	pgc_np = of_get_child_by_name(dev->of_node, "pgc");
@@ -307,9 +309,19 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (of_machine_is_compatible("fsl,imx7d")) {
+		pgc_max_index = ARRAY_SIZE(imx7_pgc_domains);
+		imx_pgc_domains = imx7_pgc_domains;
+	}
+
+	if (!imx_pgc_domains) {
+		dev_err(&pdev->dev, "no device match found\n");
+		return -ENODEV;
+	}
+
 	for_each_child_of_node(pgc_np, np) {
 		struct platform_device *pd_pdev;
-		struct imx7_pgc_domain *domain;
+		struct imx_pgc_domain *domain;
 		u32 domain_index;
 
 		ret = of_property_read_u32(np, "reg", &domain_index);
@@ -319,14 +331,14 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		if (domain_index >= ARRAY_SIZE(imx7_pgc_domains)) {
+		if (domain_index >= pgc_max_index) {
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
@@ -335,8 +347,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		}
 
 		ret = platform_device_add_data(pd_pdev,
-					       &imx7_pgc_domains[domain_index],
-					       sizeof(imx7_pgc_domains[domain_index]));
+					       &imx_pgc_domains[domain_index],
+					       sizeof(imx_pgc_domains[domain_index]));
 		if (ret) {
 			platform_device_put(pd_pdev);
 			of_node_put(np);
@@ -345,8 +357,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 		domain = pd_pdev->dev.platform_data;
 		domain->regmap = regmap;
-		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
-		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
+		domain->genpd.power_on  = imx_gpc_pu_pgc_sw_pup_req;
+		domain->genpd.power_off = imx_gpc_pu_pgc_sw_pdn_req;
 
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
-- 
2.7.4

