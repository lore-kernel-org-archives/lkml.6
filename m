Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E445C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355F325C16
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bXLCKEuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355F325C16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbeGBLxa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:53:30 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:16590
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754020AbeGBLw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOtViNz0ugpBvNkN8Ga29jDg9Q4Xc3qqDF3J/XZxQl8=;
 b=bXLCKEuz5OHEg2Ua0uIgfjE9ZX/IF9TpGSlr2PbaMwDOP+DBnD5fUxBxkimlCaNin+ygz0TYNVFFmEIyXkO4QhHiAGgZXnOSFHUIiA8OhZORqOAc4SzVw8uoI8ZtvWsKEOQGoZtrFBSzx43DsMCFbuNkSDDy4i4uQHypzr2z+ek=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4295.eurprd04.prod.outlook.com (2603:10a6:209:4f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Mon, 2 Jul 2018 11:52:56 +0000
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
Subject: [PATCH 1/2] soc: imx: gpc: Use static platform_device instances
Date:   Mon,  2 Jul 2018 14:52:34 +0300
Message-Id: <d6af4fbf666a01aea5831cf67f299390e632f698.1530530881.git.leonard.crestez@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b05d23cb-73de-400f-d332-08d5e0125a71
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4295;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;3:ROvqAvYFLHrrNULOMUWHoN3VC0bK9F8QC3wp9bK3zmc2yhrYeuSEpNyLfamx/2leBik4ZfLBjvvuFVtKKv7XqSMkS1aTteK/0vAwpSdBxDCRZsqhaIy1af4NjzGcl0NNfEieMZlesuAWAd0Jzc8xd8kx3QhhcjJuq1/axAofODiUBb2R6jXup1iWYwsMYWIgSOBJiteIBV1e49H7cLpLRED+6m0d2Nl35vuf0baaqiYeJHRvfSrxD03rLxALLPa9;25:6Tlf4x0E05+QTJBbzsWW+4PFXLD30bl8hQxxif7LPz9X8NUasBxwRzwcPIEZC4g8F9NsGe2iCKO6etqLSqTP7IBVP71JyxRFcUv4FgLNh+7Szyc7JAu9I2q41IWRKDVXQ724mywAM9uRSDPjidnTWhP+Pgol7U+f6So3/tcEdh2fTbwrbO9a5cUvK5tvNtPJ4LRcQceUl941yRlSwDKom3C7vmiI5k3OF+JgFrbUl6zWY1s4KQ4v3k7j9padiF2WFlgcqI1PT58lc1gJNKmGAo3EhGFB/8TCnCFjkgqwvpwcyvsrGPpxxqKPsmTKzeGbTrfbjk5ZIcw6VCAct6+8yg==;31:oC74zuDmsQUkEHvprSrfwrDMN84fsHjzuKnqZmaXnrSpniZ/Yn4iM/j/2m1w8WdWNSUWUVn4jsy6NAPLpDrbPPpHrWr0auzOgwJIp7jnpCKRhczoHleYYiVrrANO+J1AO1ePqcm1X/CDQhIbEgGWgj94pMuVtWXQmfBSzXFfuep9TphGubeOL1UZWMrvIpJrPfWeeIm5DUM2RKxpNHUem5SwiKBGS3lhxaT6S9fr9TM=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4295:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;20:o4Js+XfUyGXq35mNtpUHYdZ+amoe5rfsXZSX7e+JyWsx2Y7FVYgA0ndDBJeBOI9GenqixOU6fRH7xr4ISXWIItu7pt6an9xBZX2argaZuM0kRM2ehMJRX44eb3LU7j2BxvAfiPgxtOAZiunPNHnFj82hDHtKMKc5Ggo8Cpw/Lqzfru0CRnQZahlgqcFdxxpCWY5saYEUC7mDRFOvvmmKzRup+cABmEJ+rZhH+B6SMJXyJGZWWP7JWmfPoXIwF2kfsLSzbFyrjeph6/WdI6QRyKrZhGY9LQlpNuXH3Pqwqti04+I81egn/Es5ksyAg8x7Ypk1czNI5IH6I9lX57bEwsj1EB0O/yfsoc7WCyqFWMns7WEQMRbO6EcaG/ugA8VU8PvOU8Rk9i/U5tTsyVgNG8H6VzejDmZlSrWsbY6cBlT8hFeBqm3RJebUWw55hK4j0UpqOjhL4rl8zf7YhlKvdAK3oKDhSlaw+rEgQFS7r0olt6By73jp/YqQs3RwQXXI;4:WRYrILlxgCYpRvzNVsHWoRYJfFnwgtMEEFXt9gzbOX+01SNDiotIrSmkww4vtC6R9gr6jo0HXRGmV4d9m5LF9rAKVrnsGsGYFSX7ZI84CF/H5LN2AxWOSa+KZF9/honZqSvvI+5zl+EiXI1fj3yxjlSrnDsJRqrYsbEw9vi2soJP9xwW8UGflixzRGy1ICrz7mhJrwA+MXXAVk276IJe404rc6aj3htiAlU9QeqDiNdGadCMqVY53AbOQAhg1RkQ/BY4oHvWq4UmdFNeB93hC8F2zOshvJOBhImaCRqOvmsKhrWchwHFiijxlzI/x16o
X-Microsoft-Antispam-PRVS: <AM6PR04MB42952189582F908DC09CA0EDEE430@AM6PR04MB4295.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4295;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4295;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(66066001)(305945005)(47776003)(478600001)(36756003)(6666003)(7736002)(50226002)(6512007)(3846002)(6486002)(6116002)(68736007)(50466002)(44832011)(118296001)(956004)(2616005)(476003)(11346002)(486006)(446003)(5660300001)(97736004)(26005)(186003)(6506007)(386003)(4326008)(39060400002)(25786009)(16526019)(53936002)(86362001)(106356001)(16586007)(316002)(105586002)(52116002)(110136005)(2906002)(54906003)(8936002)(48376002)(81156014)(81166006)(51416003)(8676002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4295;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4295;23:Tva6ouXr0r4hOAS/q3ee9QaKKLJ7laFrF4VmcAtBr?=
 =?us-ascii?Q?qv1iQ7C0uYSwoXAVmS9YP3AKDJB7cTqMbpWwNq7ypjVDNVurTI5GXJ6+0D9n?=
 =?us-ascii?Q?7pBmBth80hGxwbDx9lOMsJ1sWnMfN6wrY/VNkmGsDZC0AAeIaPb8edF1LLfL?=
 =?us-ascii?Q?s+Cw7v3nQQqhu42LfX97XCHWrzToal5KiT32QNjX6Qz93ZOalJI9YCVY0ru7?=
 =?us-ascii?Q?Qdyi6uXF1yx3e/hsovz+DjCfOiSCChOBlEXi0sNMVRQZuT3lz3zPP5hotgx3?=
 =?us-ascii?Q?yUDAoI93fh7Bjs/KiSrFD/na2jxJjM+pth8QaT2ZmzR6efoU9Pp7TRV59/qN?=
 =?us-ascii?Q?iy5rFIfMmp32DJXScwUuwrQLrBMpjjUAM34TwepXx+vf6QER/cQzyOiRxtN+?=
 =?us-ascii?Q?t9a+BIpROjjWpBBI42/NRJW1MdgWaXQCGr6wfVLA+M+dKP2+KQ59EqMPQj2/?=
 =?us-ascii?Q?qksJAibk8i7/RpjyMNwo1dKEiot+jM5Po4bzITUHJMMbA494yfSfvDkUz2x7?=
 =?us-ascii?Q?8qo8iH9I0f+3v9ccpVN1WOCyA0dDPy0uVEKUACeNHZIO8cJRpdVDb0fxvbp0?=
 =?us-ascii?Q?3HYZXamMz+sZlmoeK85kksy7g3/bsDERFRZQ0Cryil4xsLHlLyxgMj5gyEKb?=
 =?us-ascii?Q?AwAhpNaahz5NeHesJXyMQywSe0YECYkFQ0pwyq9dNIn8baSWo2CM/2z1qAi7?=
 =?us-ascii?Q?2xJ07e/mm5P3xtymV2j/jFj41tgaeys+LgVEDpvxnO+RDxFgdu4noHWxW06P?=
 =?us-ascii?Q?SSZnS14+rDRY6gWmYl6fuXyc9CKq0GCG45m0fP3/IQv9GH02MtfDaluIIJCF?=
 =?us-ascii?Q?bzi1/WDvJQ87hOz3uJeJ8xy6dN3DkcZ9pwc+Z59TfTFLlOniO/n+ix4VahUs?=
 =?us-ascii?Q?jHKR4kHrpt6fmaJpFnTYeetek08f/akO0qsTHvpfN9NWJZlVLm7mc6bvqtW3?=
 =?us-ascii?Q?aZ3MX68DMmx8VDhOu4Cxdbxc5kwNvjyR6hiG6r59I4x1twj4W3MGP1Zw1vAv?=
 =?us-ascii?Q?AzMwtd9Jr/iWSnizXT6AoTx/HKkyT83rPaRAb5t+3p885WXEHdNCsPqAwOt3?=
 =?us-ascii?Q?KulmZlyYLa0InB/+7HAb04WMhehOHn3tWuZMs7o7sB7NtuTutlrxQxsJZXCl?=
 =?us-ascii?Q?8zMRrqiAY+3/dhFycUoestA5URxeXsIuIhyhX/y/M6wI93QxgM2C+XgRai9z?=
 =?us-ascii?Q?ZWLwXkGfVZlu/HKlQJjf0bCz+UHAZHgx++2gOsG3wGB6Wu4ZYRAnZk1YycrC?=
 =?us-ascii?Q?OnqCw/bbNJZx+iQSJo+3zXXoBMyhD+Q7uPxzlG0?=
X-Microsoft-Antispam-Message-Info: MTNHGFiZytzmdgEMq0/WsmsbnIFgGm2JAnNlOCZcf0p3t6zCJKF0annfYJQizo7GVtxDEk3xgYB0dPw1N3QOr1mM/RTyPxC0sS4XReJKsCsrhHoSqaSzoo7zbCKpMPTK27pWCoCRlPmB23+iVj8OC984Rkfzk917AFVK6uGlvACFzAeeg6JB2mEbTmtCJf3DeiceqguXMlLFQettlWecKz2SN5QLOaA7J/8/lM49XWyTIi6zYhMBB/mURujgNPr83RMW8pWldlGMjFUiMxuptRD+N4oYpzTB9YI7i3z2CsebVKbZHrU/RfVCjAt579gGuUeivYeNF9qoQBo4FM5VVtIzlDqKuCYv0Iq/Y5d3EHc=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;6:F8sG/mLSHMU4sGQnzuhY2eLRLUt3Ym7ucL8n91s6/5aUxgRy+ik1Wfl2dzVq/cnqrCTO7lq5ELRwugc/QKJuXFQLqyilhgWt0Tj/4bQSAg9LIOE95RdqrvyX8QtdsY9tQe64i+FmUIlC10KFnrzqwajOWrMLCKAS7Wj/CrCdBNajRKAt+a4x6PDQcV9W/xj/3mp47e6nQypx+ctzuwPgK33Jx1bd84cDpewl5LCp1JLllIlumdd8YqCtDqn6YpnH1vij3L4Tb1LELc53QepyjD0ImIIsDL0vnG0pKrzAjBjTnIdhszxycqIF2qwje+ibJ3hj+3yEO37ipg80MEUMDRzh2gE5fghCWGOTXLs8mBFQPJOZalYuWsJrKHd4EPTWR9e7tZ0TIstzRITLcWub9bVUeZPykDG6lJr0oX0HvWWa6JbV4GBNGIHB/p+jK95f6piaVw82ySsjkG/vxHE+zw==;5:yhtm1nDaSaBqhJXPB+d7Ef6adskS8EuL1v5ds4oo9YE51jVfH0IyMSiybu7IwpP20aGCzSwNA0G+42Xotqueti8ItwBi23/tpmT+cYP/oNhbQIEcD4YU6MSfZ2yEQfMXdSRaXqi2vAxtKUwEVjMuiM3NIfFYpxt6c0curI5yzao=;24:oq0ZHEPpVVs/nYPF9RRqvN9ZxOZcoeJlreNgevsRK0LrJ/V/ccW5rewQ5T137aLSlYgon9ga7HG8Iezi3OppKSM90ShhfPCVltLEyOt7JkI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;7:RgTvMYw8sNBPPjj0H44v5uJcu+Aq34y/yus4soxVYruKBUKsLoD/a6G3gggc2nu82GEM8spiSND/z7OpDjJrqhxy0f1z6PnYK3wNW1uFLHz2RtiF28uOUBSX2Br8WfbeoI4jgzLoei96scejSEe9PLqYXCLUy4AAxYKFBxoOlaPoLCUChoE1eX3r2v6LJJ/H5EK8/VPHNWDYpFpAIyeUzQVG7lQMJMtw97saU+pyeoHNw2cKHhC+igDWJoDMPO8U
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 11:52:56.3728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05d23cb-73de-400f-d332-08d5e0125a71
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code by doing less dynamic allocation.

This also allows easier direct manipulation of individual power domains.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 32f0748fd067..83cb275592e9 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -283,10 +283,24 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		.reg_offs = 0x200,
 		.cntr_pdn_bit = 6,
 	},
 };
 
+#define DEFINE_IMX_GPC_PDEV(_id) \
+	{ \
+		.name	= "imx-pgc-power-domain", \
+		.id	= _id, \
+		.dev	= { .platform_data = &imx_gpc_domains[_id] }, \
+	}
+
+static struct platform_device imx_pgc_pdev[] = {
+	DEFINE_IMX_GPC_PDEV(0),
+	DEFINE_IMX_GPC_PDEV(1),
+	DEFINE_IMX_GPC_PDEV(2),
+	DEFINE_IMX_GPC_PDEV(3),
+};
+
 struct imx_gpc_dt_data {
 	int num_domains;
 	bool err009619_present;
 };
 
@@ -441,35 +455,20 @@ static int imx_gpc_probe(struct platform_device *pdev)
 				return ret;
 			}
 			if (domain_index >= of_id_data->num_domains)
 				continue;
 
-			pd_pdev = platform_device_alloc("imx-pgc-power-domain",
-							domain_index);
-			if (!pd_pdev) {
-				of_node_put(np);
-				return -ENOMEM;
-			}
-
-			ret = platform_device_add_data(pd_pdev,
-						       &imx_gpc_domains[domain_index],
-						       sizeof(imx_gpc_domains[domain_index]));
-			if (ret) {
-				platform_device_put(pd_pdev);
-				of_node_put(np);
-				return ret;
-			}
-			domain = pd_pdev->dev.platform_data;
+			domain = &imx_gpc_domains[domain_index];
 			domain->regmap = regmap;
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
+			pd_pdev = &imx_pgc_pdev[domain_index];
 			pd_pdev->dev.parent = &pdev->dev;
 			pd_pdev->dev.of_node = np;
 
-			ret = platform_device_add(pd_pdev);
+			ret = platform_device_register(pd_pdev);
 			if (ret) {
-				platform_device_put(pd_pdev);
 				of_node_put(np);
 				return ret;
 			}
 		}
 	}
-- 
2.17.1

