Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B8F2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B8SSlkCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B8F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeGCTjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:39:41 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:9343
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752061AbeGCTji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCf6r9OG9WaZPPzWxUJ/q+jph2PK5EjkCPoCbhPWHK0=;
 b=B8SSlkCSF8lrGbe8bx7l5kmvAEmn6fLZh2vHgGy34dJw49LdJ2U9DiceHhs33qzIur6CuEOIXHDoZl9B2ti6Naw6328pD5y17bhkIiIMqum8Y3piVqCfGI5qT3UAKhIRIXCCK5jeWug8amrgjUC9qYTnGevB7Wj7GGlWrSKIwX4=
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4289.eurprd04.prod.outlook.com (2603:10a6:208:67::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 19:39:34 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] soc: imx: gpc: Unregister pgc children on remove
Date:   Tue,  3 Jul 2018 22:39:16 +0300
Message-Id: <652cc0c045dbd4490752ef117e98ffbcc84de822.1530646251.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0402CA0026.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::15) To AM0PR04MB4289.eurprd04.prod.outlook.com
 (2603:10a6:208:67::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb1fce56-c3a1-4de9-ca78-08d5e11cb50d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4289;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;3:/IqkEAg12F7x8zQ6p1Wrw+Hi3HzmLzjtnhVzOHFpwDqJ6ovxmcOpi4nEj9JML2h+P+PE5BZX9o+YMta4367zcXfbbacKpIixaD5YzQfyBfFZapXXgXHQMGC/Gg2aIym+JaBpQdgYJ8oxb3hqESsHYQfMHhHzanj5yTtGnJ9JlGBsDO/A6Ho5ncQ8ayDSZE/u4daXi6SSmBDJRkRQca6PjVvZrGYeEkDnMi8FkJ5OU1nIvKGw5o+nxe0TFyh8e9zn;25:F0FqII5utpDf6f1CahFxeKpeDAWT8wXoGjnySGmpPoGqdEA8Bgjg39wjNA38kObkAhvbm+SFSnaTHitEKYKm0Q1x5hkkwQU+oifM0YmhyJ9WZHe3CoPWLxq5LWM+bPUSMXzMhqAh+bKVMdfh9IBZX40S3redrUE9A3beE8eTWfBIyCmSoVAiN194zm1I+Qh4+WZyJZQmeRKCwvpHdSAw+aP5gme3bhj67gVokbaLMFJhjKrlBkqBgDbP8/gO+JHodD2Ll7uXpccXI5AIn2M7uGdOMePguAGJcQJaYQldH6wMrKtPuox+YyybXA4SLd3yyom0qVEjwqg2qQ4/rpCNhw==;31:GpmZ1RovvXVuZe9dwaMy76y/V7m0m64F9JWZlFheGGB6B07e6HuHnL/mJu8LIsEEikp8zWaXh7GJa9K1N2cNYtY+zrWMhFT7do6hU6PWiwFRDSBUGHTbvV/1ktpWojzcpg5tuAmqeCmYP/COLCyI8MP731LqYuoZzRoyOatOtozyt/jqrIlWFaX+s9JfKmgJOhk2rvkh7YjKPTNTqLVj043+65HDlxG+hfcl3K/9yxs=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4289:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;20:3yZxy1/RiVnwz2q+uzUahewBQ0Tj5X4ahpu1ghnvHhUag6NtCfxYWigN3awJvE8FWodzE2Oadv/sIWTMFxLJjNWxgMnYJwOmVqBT+yJ2BbllEdVjkhnW+nMiBVs/tEa/Zb2vWNtWfuMwUcGXdLHR5OPUXzQVowxk9azUbFjgAbjo1HU8wJxxehJB3agnREPd5P8BrMT2p5dy2FCmi6849X3ad9JP6s5/W1Vjyb89uYlXWloDFyGQlykfFeG6rkHmoL/j/743p9eWfq5a47Q2+hW/fL+MpbCQ6xFD1VZ2n/fTbf2HlY6X99LuzNVebK845o5JwCTGqaR9QnA3NIRPv3l7MlH6F1vUvt/mYy5PuMbFCND/GhB6IpzuYSZP+n8enngJK4Z4577vyaF4a2Dxc6WybyaJ+rzTNNnDvtauB8bkYuIfKPLzh0YlXihkXFza13IrevIEPqqOvbM7PB6l0dNFMW/XaiGrwg1VcF1Z0nyvc8Vtmk3Fyq0cNmRVidDP;4:UFavRtqeGJvxyg4lL/AHMaahQFnuQbOgpdcmTUPaP+JrOwL0CCesVCX/ezyTMnLttf2QL+Ew+FNAWe+GgFrubOd28gDj0+MrOYWk3ym4qupINP2fpMPlXQwn8SwvnLjaW/cDTrzUecsgF3YkAQv4f2HW0odKkm/4XyGo9pkNIrjwbLl/RL7b1lvBRNoItXRMWpooDj9QDHF1SjmJsOwL4DPnmkTYbFbvHJWv6/SgdIetCcA3o7NnnqZ8nWx4WzpSBsB6MDXO9KQ5U5SajQ8eVBPectv2U7Yl38p69ALDjFLJ2x5b0OL7anvS4b9dsE2ZlJdlwGXaRPFUriMuR9LPAQ==
X-Microsoft-Antispam-PRVS: <AM0PR04MB42897040168F6EB0FB00ACA5EE420@AM0PR04MB4289.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231280)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4289;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4289;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(2616005)(186003)(81156014)(956004)(81166006)(14444005)(36756003)(316002)(52116002)(6506007)(386003)(6666003)(6486002)(966005)(478600001)(8936002)(476003)(51416003)(8676002)(2906002)(25786009)(6512007)(54906003)(6346003)(5660300001)(6306002)(16526019)(16586007)(110136005)(26005)(106356001)(39060400002)(486006)(105586002)(50466002)(3846002)(6116002)(7736002)(305945005)(68736007)(53936002)(97736004)(47776003)(4326008)(118296001)(50226002)(44832011)(66066001)(48376002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4289;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4289;23:dMginYWZ5883j3G2SUJuiWqmEU+nikyy5Nb5G+/ly?=
 =?us-ascii?Q?LAce1Phig4YIAuXom1ymKs+RKikK/sE//8mNCylz8JNuRwZgrNh2YCfnGzWJ?=
 =?us-ascii?Q?qbU9wdzxIW1zIbZ3ogYY5rx3NCBA1NrgkrMxTM4NHIMK5VGxVQLOupDezvh8?=
 =?us-ascii?Q?W0t8pvI8Z8B/YyHhKy9QwqqUxIJ0TiRwpyj7hD1WWgRnjxCLRQtOS9I5dRg9?=
 =?us-ascii?Q?ZMhqHwl1MZqgVQwvEZLcdI1NsiukHUTFp8I328GxBmJ16y941ZGvB8LG90d1?=
 =?us-ascii?Q?z5F5IRFuc74fIVps+4b4szrLaeM0+WPRZKxOH0c+Ma0Xi/ws3MbgQttX5a9d?=
 =?us-ascii?Q?bzkrqwWMOsaeJTyVteROoEF7MezOt3pNbDL2BuEi4qF+vXL/fW2oISu/hqi8?=
 =?us-ascii?Q?Ga83gG3G+AkKj08JjiQeplzeB5xISvuuVurJpiOjs8FOn37qJ4M/ByNaBHfQ?=
 =?us-ascii?Q?ITvScaL9qFo7Zps+rQYSk0B/tE+W5RZn+X2cLX7Eu5R9ikUFb46bvxVFuHXR?=
 =?us-ascii?Q?Knu4Pe8Zs1xoJd1p+1aSsT4xcgPfA8vyzzsSqmDoEYtTOczXJ9SmfOP/jZRh?=
 =?us-ascii?Q?VqyJRf3Qdf6WAJnsWpBLE7btBpofP6Q6++b9Z8313l2e6cpegPi74rwPr/rD?=
 =?us-ascii?Q?f4P8wQwqNT2BHfAOFoHw9SyLcs241zB/C/ljaAB541/MktbtjEiWb/nqN4EC?=
 =?us-ascii?Q?GdvF+vzdAzef/uRV7p+bIYCe98bhHG8IOnywRAzDxQzwYBwhuEynqFqK2TgI?=
 =?us-ascii?Q?+zFP1eNJnYRnEtJ0XiXj7pbxYC5wF8TG39gZn35i+QhX8hWKtUl0xV99+rT2?=
 =?us-ascii?Q?5m/UZeGxT5DCAuOd5Srsf9aifb+vH38lagDdXP6MI8HnP9M/0V72TlHTcoiq?=
 =?us-ascii?Q?bLCSAlUVmgYtOXdnvUaRTn9WFx1iT7TnoM3rV8n8l/YZJX1ugjUrle4twVYI?=
 =?us-ascii?Q?LF1+hcCvTvRsMGYjoXA4Lh7dWujQvDS4pTnsyu9E8iOng710JKSSSOvLMpTK?=
 =?us-ascii?Q?lEfgkkq92ST3y5e6i9uvVflI5xCZz46AXIl+uwtCc9xoxY8GmUsJwedIVAY2?=
 =?us-ascii?Q?EpCZ0zCwN4RO+xi6TGak8iJmhgA+4xZ5HvYIna7ybKjyQmClEiWfJX3TbfXc?=
 =?us-ascii?Q?ObgIf0cJDz56Q+DmOL6LcwpzQfa+Tmz5CGSMGvt9GHRIm7MVuspEVEe0M+XO?=
 =?us-ascii?Q?dTkpRfnc5QuPEOYtOGBOI3GxoszvqwwcN4To1cBe+h32qXjvZg6nh6ab32a2?=
 =?us-ascii?Q?ijIW/gDC0U/Hp6uFfrZOPoaw/2n680skI34b84v5r21leXpdNAWUFlo3y60U?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: bEpF4NzkSfC64efkbX73MDen0Rcq98unhrO5piZhWiQjoXAGQT0fGQS+msdw1zwDgaXFO7fjsQxh59SqGNXBaY7V9tHm0ouYqV8Xl9jSS9cgDxtuZMGUfsO//nNxQQbmhOW7gxn19b57vVS3uGa8Pxgo8xYnhVwoQcLNHQi49YN/PqA6qR4jqgtZ2tRNDSevHu4/WClugLc2ML9S5xk9n9T2eOuPO4pzrVBUz3Duuc2p6BxcDrv27hBX8Xff4bhu0gq/8CVxmT9Zhe3qaHB1j+shCjfRJpPFJkjj3/9wh0aHRg5CeVSArsUOoKwCK711sl37xWS+kGJBxwGASFA93w==
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;6:4dC3ilII+Qz5CzZeXROFQjmbeB6H848bh3IzbW365iZVku+8pp2m8rqLKvrD/xA7yuMJtUCurXZFvXTyhXMcwJAQfL9qUCRiM3gvzbsY0tOQ6vRgAB0qg1jptI8+qRqcgHiE5uPWhXcg5LBZnN7fEGjlLguTXCrsFDFwtx9waIcRwkrezXCyfxaxeWMMO2YQ57TkenfsKhuiAcmF97RQqD/OdKi0wxiJyWXyFDUDIUS818FzmYNicZQcn/1WyZ1XDEvKT/fFDty6nZ4/46f6154tx0znQR8jhCjjjZJXSI7G6E3sy760/bjSMjwqR6PU6tELZR8XZanpdSwKEyg5FTdGxW0RS2KOznCkgyZa3UKjyzJgagNO//RzEjsPAc2oDV2czp1o30w4L/rfJ0SVP2sHybAH+Cxxrur3B7IZkoYUo8ffTuqMr7mlqRwy6p+bp+Oj7OXuaQjn3LspuMtf6w==;5:rKYxuwtAN5TkBPuYg1MU2fqohVqmQYZkhWNVHYgXlyK7BL+tFAaeHQgMzc0p2r+HpjnA9FZF0XRqqYc+s0F+7nTG671zc204RYRII/qWsYI+30p3gmCYalfLeqVrfYCgcS0ESDhgwK7wap+KINfzWuKCyMG625yA+JopYqyW9ik=;24:wfm5UEMTLV/s1dkh5U9UoxFEnxDPdH5BS3RqKXSL9oWDUlwXYPvcS/M0mzQ3+a0diYl0/dRanXDbmiQ4X2a5MfjqnvaC4rn/IHILtNNfsgU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;7:S3cbQE7Y3khbhjp/oEZ6/K53ElwN7qb/J7BJ/m9XR/sClbWSHyGJ12PHkcKOvcFPKgU9zhIPDgR6ZJOG+ZSc2agINagd5z/Cy153uOwPGTN6MHmTkCgGwEyx1KZ8/3lOt+thb/GbMBHFUDGRD0Ep/es8q4hBST0TyV/mOga0GXZfjTQVy1l755wBPqnzvakgxnCqCaI+YSp+u4QAhItTOSNS9+Zl5OTXJqzhD5/T199G76oGDKYV9SyHH4VfJrIg
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:39:34.3518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1fce56-c3a1-4de9-ca78-08d5e11cb50d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the gpc device is removed the platform_devices for its
imx-pgc-power-domains are still registered and trying to probe gpc again
results in an error.

Fix this by iterating children inside imx_gpc_remove and calling
platfrom_device_unregister.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

This was prompted by the rejection of the following series:
	https://lkml.org/lkml/2018/7/2/534

Tested glxgears after rebinding gpc and etnaviv by echo to
/sys/bus/platform/drivers/{imx-gpc,etnaviv-gpu}/{unbind,bind}

When doing probe again it triggers a warning inside
driver_links_drivers_bound:

	WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);

This seems to be because devicelink code does not expect consumers to
bind before suppliers but GPC code adds PGC children during its
probe function and they register a device-link to their still-probing
parent.

The warning doesn't trigger on normal boot because the pgc driver is
registered after gpc and probing is not nested. The warning can be made
to reproduce in a normal boot by making imx_gpc_probe return
-EPROBE_DEFER once (no other changes required).

This does not seem to be a valid scenario for device links so fix this
by adding a check in imx_pgc_power_domain_probe to defer if parent is not
probed.

This check is not very nice, device_is_bound seems like something that
should be internal to the driver core.

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 32f0748fd067..b4acdfd3cffd 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -182,10 +182,13 @@ static int imx_pgc_power_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pm_domain *domain = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
 	int ret;
 
+	if (!device_is_bound(dev->parent))
+		return -EPROBE_DEFER;
+
 	/* if this PD is associated with a DT node try to parse it */
 	if (dev->of_node) {
 		ret = imx_pgc_parse_dt(dev, domain);
 		if (ret)
 			return ret;
@@ -475,10 +478,19 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	}
 
 	return 0;
 }
 
+static int __imx_gpc_unregister_child(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
 static int imx_gpc_remove(struct platform_device *pdev)
 {
 	struct device_node *pgc_node;
 	int ret;
 
@@ -502,10 +514,13 @@ static int imx_gpc_remove(struct platform_device *pdev)
 		imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
 
 		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base);
 		if (ret)
 			return ret;
+	} else {
+		device_for_each_child(&pdev->dev, NULL,
+				__imx_gpc_unregister_child);
 	}
 
 	return 0;
 }
 
-- 
2.17.1

