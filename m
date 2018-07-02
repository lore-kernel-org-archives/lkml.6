Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18487C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22CD25C0B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ep09ndRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22CD25C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeGBLxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:53:11 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:16590
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933051AbeGBLxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kclpYC3cVUqkXlsYHRJdMZqo0+Valz91xWvrnoM0Eow=;
 b=ep09ndRjsl+E7WqxSM4mrzffkxMZEw0fMfWOjMKMpGCR2Bxnj6EaEkFKtizUvJDA+IYh5Ory0cXlEFkvL6yPttH2XB8BhtRsVcvEcPZ28qfIDTR/ZCHRN3b8NWAwDoz773J3sZn2l+hx6DthiG1xeMlS6Xe4V+Mcz44QhfUlQbc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4295.eurprd04.prod.outlook.com (2603:10a6:209:4f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Mon, 2 Jul 2018 11:52:57 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] soc: imx: gpc: Power off PU domain in suspend/resume on 6qp
Date:   Mon,  2 Jul 2018 14:52:35 +0300
Message-Id: <cf9aaa345a27b3d5fcd306635270123f9d01e8c3.1530530881.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530530881.git.leonard.crestez@nxp.com>
References: <cover.1530530881.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR0201CA0035.eurprd02.prod.outlook.com
 (2603:10a6:4:3f::45) To AM6PR04MB4295.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95734913-36b3-418d-365d-08d5e0125b3d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4295;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;3:lEu4LSWhYP0y2nD9MyXdi/c7zfHEX6LjjfmZk6IHKnnHtu4FjI/4nCddqTonmZ2uXyuOz+0PdYIdS+UEDDc6G5w4bM5OHb2qEU+oVqN34tKEXkMWV9zi/NPxKe35eTOhi6FLd+KafAtQLmU8KKgSw32aqJBsK+oDZ5JObviSOqhar+WJtz5xwi3wtV8lZOT157XnpGIxgfEI1cUOPUPVPsdgvyUqVQZ3Zu3Tq98iRtJT4BtzotfYfufeNDui5b0Z;25:okYIAjaW72aiTFdqHCpjQjnWnHE+KCwTKVraW1+fn9QzaYozsLE2rUd52OyWXjEh635osIO98RLEvBlQ5zKw8rH5qz46Gvzq7nDrdhadtRtb5fM5K6p7QwPhvs5S2xKjKFMHFq9COQd+1klx10L4/fdiYYxducSmYyVoRefoOjZgaYZgFG3rV7ka86KXUNkLxuNvb5vulg+/PySomtU0uMofYorKfx4MpZkEnW8h6I12YxKPVUwdFVn+mpOsay8JjCeYcI0QOZrFfJJKBljtRSnmQSsxCejiU1keEzrPGu0eKuzdooEydRMZ02FBFs3L4eLNyWUvPWPewbhl38M8vw==;31:Z1sm+btIbhElf0xc2P8ikGt8etaQ26wpkcE0DDFwWPvnqgld3jjsthy0n2kNHy6EWOnlPjJdXWT0Mlw8qpfKs+pVDVMvjmdGitnlfjM9pYTaBhcOA5c6g0TzpueEvUIlc0pwshJEgb91q0jC611B2lWthHZr4jS5dW4gcxnO33vzD+7x0Ig4AGbzOf4Hfm65fHiNcQrPHIAMoVMfNNZn895zSvgabQVogREjFu35y1g=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4295:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;20:UnZYUyWlbIsOSFzg9qnhKbxgXwDB0gYiXHlo2E0BpBCh3JL/MVQM20qOjWJKX1iJ07g39oDkp5rBjpHTAkfcgrGCw/8OWRU2xq95XALpzk0NRJcsEIuVD7tzV8hZmuKNQNFC34X/Lnrih/7bgaXdcPnWraTmvqe5SsT8lEQx7qJMJs6E+tuUBAjsra0S+Hy+I5hSrSoZDayead4h1Vr2XY6P6kdOp1p0GPYAcXphu0HEy2rhyYmLJlRi5gDy3ArQ+HgXUGoKRieLO4pbTO8G9t2U+S04Ro2B8KDyZdMIyH7Y8dBYju/OafCctA1YeaCZ7jFu/FrWjtqfNo3Pvd/412OxUEJpAt6HhmZEy5PKGk9zf+x+MuRlqMn3JEMDZ1Sg+NXoK7Kjeo+P558Ztm+9D42nb7rhe1bMXuz0N8T7cJCV24rtn7G2/a9aChqQRRURCyQ5/+bTv31AeW5POF3BVFCTgwVSLQGiYv8lpPi0lOAw1AABMy39pC/cmHFukoW6;4:3OxHr5IzViM9gIP8NZSnUxGBekVvLUN0cNTtiPZ2AU0ALRL2d4xxyFr0Db6k5UZC5PNe8cbJ8qcbd3Jrqxat+SELdvQVPS+muzNmFMIdSa2aaFij71tsmFPj8ya4Av92fAaacBtH4+HBqLHhTT0rKF44/CaZFFHxha4IPt1ICecnPYOuXZeicCmN4P56NqlEDXYyVfJCr6aY7jNUa3OLGQoDXq10o7YUgbanze1R+3Re1u38c8Z48SthOJcyIRs88yQOHz1HLgZLvbw7T4Oy8N1KzmufuMPflggJPKq3UTDFnf9tfTntV8KQQnnijOJz
X-Microsoft-Antispam-PRVS: <AM6PR04MB4295A4B132111669BB953EDBEE430@AM6PR04MB4295.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4295;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4295;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(66066001)(305945005)(47776003)(478600001)(36756003)(6666003)(7736002)(50226002)(6512007)(3846002)(6486002)(6116002)(68736007)(50466002)(15650500001)(44832011)(118296001)(956004)(2616005)(476003)(11346002)(486006)(446003)(5660300001)(97736004)(26005)(186003)(6506007)(386003)(4326008)(39060400002)(14444005)(25786009)(16526019)(53936002)(86362001)(106356001)(16586007)(316002)(105586002)(52116002)(110136005)(2906002)(54906003)(8936002)(48376002)(81156014)(81166006)(51416003)(8676002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4295;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4295;23:NjItP9H/SRTCbCUawHfLwaMlunINeegfkm2gP/I7r?=
 =?us-ascii?Q?3NcZAY9i1PUf9DhY8OUjSPuXrh5At/OaCdUWxKD1aA0nHuc9dyfbtqWKtde3?=
 =?us-ascii?Q?V7VnKCYy7qpBAdCg2iKt64iSDMuUsjz6PtMqWIB0ZB419ingl36GxKdsBCvd?=
 =?us-ascii?Q?DaJMmyLaZvo8x5nu3omRRY0ztRRJ0hqElk7E4SyPtvOK2cBarSzenl1y9bWM?=
 =?us-ascii?Q?6J4kkAq5Hgw5yjojPS9lFCzmazBD+vexMN84LgJBOSzvFDjHGUwXR4/5/XTE?=
 =?us-ascii?Q?SFHfCTfVIAmCQXVGwWCb+BdRCMvNho4cKfrCJt5wd0kzOsmpqO6EZyRxobPZ?=
 =?us-ascii?Q?oBW9pKGkXVQaatEpo1ROhZMrFQmgPpKWwzV1BVcemk3UfsFFTJnBrj+zHeBf?=
 =?us-ascii?Q?JwOHIAwQzAbwV/IQtAt+jU2VrTACucOSvPI7X3vZGX9ILaKrDeOcAvErhLDZ?=
 =?us-ascii?Q?0leNEXtmtT9R9XGNyXDAqLwd16SCGRczf8UkVufdWFet5GzUtpZAGR1KxitD?=
 =?us-ascii?Q?01hD811sZ5upPINyZseuMvxd/VcR6ySHFr6RxBTTXO9ndxy7NXN46Mdvalj+?=
 =?us-ascii?Q?SbkZyXedMkPXvFZmJKhWdmEsd++HelGL9ChmPBTw4KQhrtbFM4okRT8dtwBt?=
 =?us-ascii?Q?LLPNMrPoIus57lJ6SYdgjnyyYz84mPgDrQYdUOH7vT9r+HGVsQgbfGtNyYt9?=
 =?us-ascii?Q?13rWnbbBbaYJkh1YhoispyTJplp3mSMD/6K1CI9GlhSfDTpX72fGOpi+7Uq9?=
 =?us-ascii?Q?pE5JN8efxYqzErlHJlS6FNbfCCN2G8JLA7q1mbwbWxBcz0I9r6bkMHMI69z0?=
 =?us-ascii?Q?04wdYL3S2V4msjO0XufHNDViOT6J3DwLj8wZtWMoj+PRspM+phHFvDTdvgoV?=
 =?us-ascii?Q?qh+nJ13FGryF66pzAfrUXGcSkdK1yYMmo46r19oL3x9ZLGuf+0jmsAI7gym7?=
 =?us-ascii?Q?mW513e4ukh24POzXxac+RvlCPZywyc9XOIl3ir5pKP6eylpT+jsiYZaCv1HR?=
 =?us-ascii?Q?rT/4bFTob6qaI+ptO/hNn5ktvk3yi9fSHKNQu00XcW+wATzsQqMd9JpZ6XvI?=
 =?us-ascii?Q?43Gys5DYux5T7Mr+qlcoqX66ycsMqVNujfmrGHcd+s6F44VQAinmTPAi7QJS?=
 =?us-ascii?Q?USgs7fN9x3H369lli4KLisP6L6yUWoohi9lBgXZXN1JMxPTMyDVuHK8B34O/?=
 =?us-ascii?Q?R4cd0C0K5b1vJSfthqCdFWvzXCpZGYmV4WHTUEhq/wxaU0GJOUzjHX4L9LEL?=
 =?us-ascii?Q?a4IEfD2/7mvdqnYt+xgtqIe5DrPbd1ncQVM+Ul+iTHD5SshL/hDfyaYtSWOp?=
 =?us-ascii?Q?FgCHdyht01vasGVLEI90LoUrNI74xX+vt+6M3MJ0+gW?=
X-Microsoft-Antispam-Message-Info: 9Jme71JR7n4/oWORgtT4Z2hdGMyhk6kDNRyycgR7pdGd3CXxwBvaHsPpV4BWYfUH5QzXY+LZsLrkyaVwep5XLBPyNR2hNwwWivvbSUVKBi1HpotXN+rzfwVcgenIJgWE/WVzD9KsEtPgPKEsACceyU2kXGe2L0hJ6Kx9ih4VoJLY0LLWMifFAgJfOAqcf7SJ7NXeNhIIYFH50XBoL1848T/o8HWDwxaygu8GqSiXOGN3O60hjHu6ZeOe1Cg4+07Q1/0zQcjyyKAcUsyIS9TW8QVxkC1eQPF4+fuIXA4HL/wyuaMjH5rMMxzzdEOIRk0ayqgwQ2AU9WydiD+OiJMUgM1cbiD4lpm8z13iQ+kVXQk=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;6:4lJgbvUyfhoTACMfRl9OE3iohplGsHJa6MUVX4soBFlqgOtSHp987Nz2cmNk9IR5Je4n8bDr6uu4T8hmyD/5GXgMLo/1tNNRbSo5tXy23ssPUtCt6awbORLCi1FiIB0u9B2hPe57RcUN6F0zfZ5oTWG4uzH3SsC/ds5k6f/7oWte6in7s012ZVlAutAfpNQvZoKkNWbsf3RQDWn5P2tvx+sJ6yM7NTmB2aphjzMJH9zRBwGtZLFgnfmKjFydpzomXNh+PBK3/Y1/8iKOFMG1juU9s9u7AwnYlFcjBp5lfyIHMixk02734CmGVYPUteD9k5aoc3Kcl/0Y332EU0j0Fto5IQYB0amECFZzaEGMrIZLrn0XF4NJBEUxY5Az4s10O3W7vf0RoguHOJiBkflkmApz7TwEbWOdEuShVfEgC2QFfrijGQmRH8jDSFzE0KG9Q8DCLw+8adb0XKbYJisbuQ==;5:sYfdUG5EBuDngvKP56IRFT7mzO5s8wxFMMr0KQXU4HzrM1y/VXtCOzmmfKX9Sj7OCBvlt84CCHj7E2e0OPw88xK48xKIjIAeWmNXvaY345skIsBIwuLxm74c85AYC6RVOsf78pXUYswG/UaaILRqL2j3FVbMfKnhVXIaTAyZIQw=;24:dWaIpn/0psnElXWJ4J0dlF9FSO0i0+RfhxDYTgnGNXTa3g8SOFRhUsPv5r9oZDcmhD0hhV+8dezyla2ytP1FBgSHVkbAlsNX6JPbWofI9LE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;7:wei3UcMiqmvj5gD6f2+MoPqurM6zuOPMJuM2eqmgtz+PcuScTwc/Z2H1dM6Ba/mijM9VGU6phC9qkj1ES+OxETsibdn9I+K0JkSnx4Xm+x5ema5n+uIRBLDctTdjDVCgprZ9MTJR2SLDlgaQUAZJ+sV97Kx/QnRFTJdYIbCleyoNrk3pnk3dmhCsOLi8deElWACh7J265aUAQGVlJqu4efQI7rSswPb8/Ub+zYc1MKipPY3kd6PYBiJtaHSWLZJX
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 11:52:57.7537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95734913-36b3-418d-365d-08d5e0125b3d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx6qp power gating on the PU domain is disabled because of errata
ERR009619. However power gating on suspend/resume can still work.

Enable this by calling the on/off functions directly from suspend code in
mach-imx.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 arch/arm/mach-imx/gpc.c | 10 +++++++
 drivers/soc/imx/gpc.c   | 58 ++++++++++++++++++++++++++++++-----------
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index de535cb679b3..e99258238210 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -32,10 +32,14 @@
 
 static void __iomem *gpc_base;
 static u32 gpc_wake_irqs[IMR_NUM];
 static u32 gpc_saved_imrs[IMR_NUM];
 
+/* implemented in drivers/soc/imx/gpc.c */
+extern void _imx6_pm_pu_power_off(void);
+extern void _imx6_pm_pu_power_on(void);
+
 void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw)
 {
 	writel_relaxed((sw2iso << GPC_PGC_SW2ISO_SHIFT) |
 		(sw << GPC_PGC_SW_SHIFT), gpc_base + GPC_PGC_CPU_PUPSCR);
 }
@@ -54,10 +58,13 @@ void imx_gpc_set_arm_power_in_lpm(bool power_off)
 void imx_gpc_pre_suspend(bool arm_power_off)
 {
 	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
 	int i;
 
+	if (cpu_is_imx6q() && imx_get_soc_revision() >= IMX_CHIP_REVISION_2_0)
+		_imx6_pm_pu_power_off();
+
 	/* Tell GPC to power off ARM core when suspend */
 	if (arm_power_off)
 		imx_gpc_set_arm_power_in_lpm(arm_power_off);
 
 	for (i = 0; i < IMR_NUM; i++) {
@@ -69,10 +76,13 @@ void imx_gpc_pre_suspend(bool arm_power_off)
 void imx_gpc_post_resume(void)
 {
 	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
 	int i;
 
+	if (cpu_is_imx6q() && imx_get_soc_revision() >= IMX_CHIP_REVISION_2_0)
+		_imx6_pm_pu_power_on();
+
 	/* Keep ARM core powered on for other low-power modes */
 	imx_gpc_set_arm_power_in_lpm(false);
 
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(gpc_saved_imrs[i], reg_imr1 + i * 4);
diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 83cb275592e9..dddc2469eaac 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -54,19 +54,16 @@ static inline struct imx_pm_domain *
 to_imx_pm_domain(struct generic_pm_domain *genpd)
 {
 	return container_of(genpd, struct imx_pm_domain, base);
 }
 
-static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
+static void _imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
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
 
@@ -78,32 +75,33 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 	val = BIT(pd->cntr_pdn_bit);
 	regmap_update_bits(pd->regmap, GPC_CNTR, val, val);
 
 	/* Wait ISO + ISO2SW IPG clock cycles */
 	udelay(DIV_ROUND_UP(iso + iso2sw, pd->ipg_rate_mhz));
+}
+
+static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
+{
+	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
+
+	if (to_imx_pm_domain(genpd)->flags & PGC_DOMAIN_FLAG_NO_PD)
+		return -EBUSY;
+
+	_imx6_pm_domain_power_off(genpd);
 
 	if (pd->supply)
 		regulator_disable(pd->supply);
 
 	return 0;
 }
 
-static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
+static void _imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
 {
 	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
-	int i, ret, sw, sw2iso;
+	int i, sw, sw2iso;
 	u32 val;
 
-	if (pd->supply) {
-		ret = regulator_enable(pd->supply);
-		if (ret) {
-			pr_err("%s: failed to enable regulator: %d\n",
-			       __func__, ret);
-			return ret;
-		}
-	}
-
 	/* Enable reset clocks for all devices in the domain */
 	for (i = 0; i < pd->num_clks; i++)
 		clk_prepare_enable(pd->clk[i]);
 
 	/* Gate off domain when powered down */
@@ -123,10 +121,27 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
 	udelay(DIV_ROUND_UP(sw + sw2iso, pd->ipg_rate_mhz));
 
 	/* Disable reset clocks for all devices in the domain */
 	for (i = 0; i < pd->num_clks; i++)
 		clk_disable_unprepare(pd->clk[i]);
+}
+
+static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
+{
+	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
+	int ret;
+
+	if (pd->supply) {
+		ret = regulator_enable(pd->supply);
+		if (ret) {
+			pr_err("%s: failed to enable regulator: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+	}
+
+	_imx6_pm_domain_power_on(genpd);
 
 	return 0;
 }
 
 static int imx_pgc_get_clocks(struct device *dev, struct imx_pm_domain *domain)
@@ -337,10 +352,23 @@ static const struct regmap_config imx_gpc_regmap_config = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = 0x2ac,
 };
 
+/* exported for suspend/resume code in arch/arm/mach-imx/gpc.c */
+void _imx6_pm_pu_power_off(void)
+{
+	_imx6_pm_domain_power_off(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
+}
+EXPORT_SYMBOL_GPL(_imx6_pm_pu_power_off);
+
+void _imx6_pm_pu_power_on(void)
+{
+	_imx6_pm_domain_power_on(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
+}
+EXPORT_SYMBOL_GPL(_imx6_pm_pu_power_on);
+
 static struct generic_pm_domain *imx_gpc_onecell_domains[] = {
 	&imx_gpc_domains[0].base,
 	&imx_gpc_domains[1].base,
 };
 
-- 
2.17.1

