Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A29C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C962208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsauYRu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C962208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966364AbeFOTou (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:44:50 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:2496
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964930AbeFOToO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5CfGDs+oYNwl7QaxL27Ae0wrBIJiXBU30Q2vGnIFys=;
 b=LsauYRu4O5JwrchI4P5KIO+qaSFJRNzFGIkA+VBI+G8sxhYb/KvQbUantUZuuSFvvz+cWRZ2L5yCcfNo6Si0rYp6GdYKUurLGMqeNUCLm8rh2mWXRmDUm42W43UgSV48HgmzCvwHNv8FAIM4ooUwYZBVbDDrOWXf5fM1neaGCWY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4292.eurprd04.prod.outlook.com (2603:10a6:208:67::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.15; Fri, 15 Jun 2018 19:44:09 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Franchi <marcofrk@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] fbdev: mxsfb: Return ENODEV on missing display node
Date:   Fri, 15 Jun 2018 22:43:43 +0300
Message-Id: <31ca6156a1b36c8ca2811d60e28c6128e988d5d4.1529091248.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529091248.git.leonard.crestez@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0701CA0065.eurprd07.prod.outlook.com
 (2603:10a6:203:2::27) To AM0PR04MB4292.eurprd04.prod.outlook.com
 (2603:10a6:208:67::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebad33a1-b61e-4006-18cc-08d5d2f85d52
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4292;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;3:6sYswJlG/SFgvXUt76ZaVOsDrOa9T7E3QXvcUqjx5zVpBBAfDFQh0TrkvvK8ONaG4SDZZQclhZXGkM54t5lJ01o9U21tzvwNRQCXmmCTstbbK+/oDcdHfLoSDaZ5vTpLyhEBXqipuX4CNQzzpDWDpwQVUJ0W07b35N1uh55ObmhnMbu5lcfLqXLz36BJ80iZVs0BfzCOdnrHCIe6ky5CxXg34LLE1c1wnjmGYhPHC1kpGH9T7kN2p33GJMaK6piL;25:+J5EtslQXKr//SJVkd5R2+YxpfoU8+36V3dD3ydjKeFganj0L8R4punG+bwr+Dllp1OMcYGiF6wC1uP+3cey1XDA7sRRrzqPCdINZYOmynwo7nzJIyikk1Tjn1nQoQzkR1HlRyK5i68fpY7ygaROVnSO8RcBwvMUV09DZwVgxP0rgxqN/MTv0W+EY3liBia3NJxf3Ao6QbZrAeYtHL0xAINFtuu4vIkAG/qFUzRG5/VrEWKw8RUwhIHTSe3KeYwmKQvNIQW65BZM3KE3adXgutLuHkdTl3p2yWPHjCE+unHFcjYBgmqL9aRHryYY93ethaiIzeDa6Cw4keIsNMN6pg==;31:U69OpnJ6mW37GqNV5zGqe9LuEoNTMhs0/Xg1M4DPjKyI64BfkM67QJreHEtGOPzlCxs0e6uXBr1FpbubWYgh7c7lqboe4xsGg/3BCVeXSSANvoqAR7HGWEaJJpuKax2dByd3sQfv1h3wGEiA7rv4wmMWNvOUM3UzvdLAWvB24zXJ7yvTwsFAB+A2+7TcifIN1df8fGkjU1W4IoT32XwEtx6XBJ1eev2QVd2f4SfRP44=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4292:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;20:tHgrcSrGd1r+4qfGKQSre/hpOJjfMIL/xzUyD2Z+LPsCN0Ux5vlk1V2GUSo1gjkuM5bSE1DQxLv/mGp01hPe53XnnvEk4xFOYWcw8HvRRwdlf+EQAwwNc0Cx0KSzU2TzmV/Nw3NcL1xX5E9BpsWlN6EmBSw159I8/qFovhC9YcT4+BjfF4LHf+d2urvMye9T2sq9fzi8Wo8Q1Akr/YedK2SkLrlzQrECYkZP4eoxM0voUQYpIbz5wyBiR92ayW6X8ZWMax+1BkW9FlO5wp/lJMR3eByvdVBgzj3kXY/nHMBardekIRKabFnZ+r8b7av2+AiKseyjKzSHMUYhb8omOwLA3PnjnwCBs30YWvhI1j0R6d/x+upLx4L25EdwRzaNsZ2NP1I3IjbRxrrk367e25r9UwsxkwuPgyRz+1L7nmrUffsiwMT7PQo1E7W42UUc9Pd7cxzy6VthQByD20hirEoT18nm5BrMzwlp2d9BQv1J+X74gyrNrKyFkt5dqUm6;4:WLTO8iukZ+4/TT9e9WkT0383jUlpCNwRnKwR7cQdLFmjgxMoOVg0XY7ML4leaAPID157KBehRPpyp85eUNSvjPFHdM1oxgwapP6hw7lQ3zUf6D2PRfBg+sd+IDwjuihr9qMUwLsMH52jxyhkkuDKMkfSJHsP7ta/OUjtzj9tZ7TkVaHhd/gf0TqG/k2HU2V+FopGcU9u5shE8QoGnneQ8VurXsskogctC6QcLpFiprx6T+J8uWDNP5SDp24Tgxn//4dGMYXEcqkY3x8Ax5UviaDOdPjYFwFbKDISOYi/oQJ9O/UJoQdSykcnvv1OsyoRZell3Su+F2apm9pmRYbygKEV1ZuJosKvvSJcf6pLZCU=
X-Microsoft-Antispam-PRVS: <AM0PR04MB4292AE39DEC834FED46D3598EE7C0@AM0PR04MB4292.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4292;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4292;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(189003)(199004)(39060400002)(54906003)(110136005)(16586007)(53936002)(106356001)(316002)(36756003)(118296001)(25786009)(6666003)(4326008)(305945005)(66066001)(86362001)(5660300001)(26005)(47776003)(478600001)(97736004)(105586002)(7736002)(16526019)(51416003)(386003)(81156014)(6116002)(3846002)(52116002)(68736007)(8676002)(6506007)(50226002)(81166006)(956004)(76176011)(59450400001)(8936002)(486006)(48376002)(44832011)(50466002)(6486002)(2906002)(476003)(6512007)(2616005)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4292;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4292;23:goc1Bmb7R3tDKPr/wR2W0G2LH+EOi6/ZYB9c/So27?=
 =?us-ascii?Q?h71mtOFD2a+afdvxxjjwPlRTo8im8fbueYYcDJcpioTHj6llWBVrd0wojYOX?=
 =?us-ascii?Q?3dUFsAsv4TcupojtLJodMfTZ4okS4J3QHijH42Mg/6rMlQ6owKYzG6XzsSH6?=
 =?us-ascii?Q?x9kuRlg3GkYHKJ0vMAEjq/Z4iPr8qxcWArmBlCxOSZmIm+E83BZm4n1tLdQO?=
 =?us-ascii?Q?ohs2kJRHaS2wHB5pxwjUEc3Uv5G6+RLpOAhPpi0nrbgq0AKAPKk1A0ybUsFV?=
 =?us-ascii?Q?BtM+F7kSDn4AEZxNabzztlal8FiHc8R4tLBrABz50bgo/5zctfWr3/9VRnki?=
 =?us-ascii?Q?sP1AmeW8/EORLmdTWPpi1YL2/Kw47WHJb2OgcBE6I1WMYhpLwq5NGf2sSfV9?=
 =?us-ascii?Q?PNJeflNFXwQMWMu+G3H8fNFvD3y43NCLwR9kVAP5pDr/7RRd0DNDuT4aNq4A?=
 =?us-ascii?Q?+fOOlHv15VqaFLHkaBmPtcfKTxM83NklsbkWSjWqyENswDe5A2S4WkaZFndX?=
 =?us-ascii?Q?GoBUirPKwLFgsnTL9lMWd29K/l6gGO2OdZJQKhsbZdajDBvMoOV3CSb9LnVI?=
 =?us-ascii?Q?AzS2ekNqNP9s0onhYonXttCN1ZKprm0wLUjINeDOsgvVZgVbUeMI8T00UkTs?=
 =?us-ascii?Q?cF6Zo0VQL4U0l5Embpvp+ZwDF8hbNfsMejyatDH8U+RoPCHhsRq7XiPIpbNu?=
 =?us-ascii?Q?8P26AMOwEp+dLYWa54jtawXVNf8xvv0r4tNQzSbFH6ATh/vP5ulfiVrugDzL?=
 =?us-ascii?Q?Y65DoiIjySCz+tKT6UkBA81J1I0KJCTWj4IoVMX2QAOBQaZBgL8LIxzyfotq?=
 =?us-ascii?Q?Va4/DBBvjtn6DWQYNyYGgshsfBahoL6iVREs9lkRm5cpE2A8QJSvvlr+o3Lr?=
 =?us-ascii?Q?OFuNGwRnezh2FInStr3BydegK6DxPahPntcKLrZx5f+/ttgvLClXPDjb2vlK?=
 =?us-ascii?Q?XpRZwW8PGJk+NHRbJLVY5FeRoG+KyZXXAF2HQ00uYB9rq+8VtnceiLdLI2sh?=
 =?us-ascii?Q?kFlkM3ozwVvX3WdxQFI8Y1ni1ololnyCaxktKE/q0kUohFmL4wr26Ye4Jk1z?=
 =?us-ascii?Q?/Aaw/ERqW/e4+r6dZ9dN7s7j7fa9Ld2rxYnHYd17erYvDANmpW5flTtwzHGo?=
 =?us-ascii?Q?6+70hmlhEJudvqB/HWZPswqHOFyTNJsBfjHqnYqzyzfghreLFYnJU2rwgkm3?=
 =?us-ascii?Q?neHXPcQS0CRJQhtM5mt8O7U5thU4hYmvy2eQkh7WZScH5xF93KPpRMnGZZB9?=
 =?us-ascii?Q?5dBdFNPRuY7OzowgGOcXXyqRfYCRrtnsT7Ku8NQ7VZN6l1S7tOlVOHiPVGyd?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: /Eallm+lfqc2I6bM1G7N7O5eN1LGQMhxDeDbhjAbJ67PHsM99TV6Ekg5qGYAT7ck/p3KL0BXoik7jRuDKWE9laBYZpO1b/lFjcALR4vOGh8gXWS6i2oImwYxNaYkKTQhj/ZlO+v87aScongO86ytOZdntMu0VqyI2UpKllIw82Rm2qa41iBEp927D/UliIAC
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;6:Qq6l3MtDnhJ+v/NDDIP5tQG5q57gth/5/nvgEjFx1rJ90pPbbMOnTRK0t4L1qkHZKv/Q9us0xd1HbLDBSKq1eLO1/5ypEN7DkMl3JFHLyZcwy0LqODrUdBPT03IA5e/2FtOSE56TjvSp0JXiRmzgiNOnSi+A7iOmPYRTwjpzneVXsl6cjKGoVgBMr431Uii3UkN2TMprqlarFHGBFnri1uJan4V/di4UYu4t3m+mdn3sv9U78pRhKUck0V+x/YEFT8/ywzk6gaf7e4mTICqxpu9qh/FWqKuez6x7n1y1fUTU3LarWmd05UnP+NmYWe27Y2S50dLLKisomWQ5p3gdKHpQ6KrDVCelLQBmm2suc40TdQoorFmxmIcG2cax3bvr+mwxNYgbl7mdIxHRHNDhOtluHbNqwbk80E7Ko3GtKgRgioF7MdtwBM0uZWppDnTCykzh2HqgXF+OyWXq8IWuKQ==;5:qBvY119WRC35CNyoN3Hi2Pu+LnAKSrXzD0qJ6MV9Y9orJag7yv/Q9wrKmKb7Qx+kPLFZzQCnCyvHiYlY7WV4J3FrFGXnSMEJA668Kpsvyyx5AZaV1EwLA66uNXdeoXwULthA9t6KrfqoH4sWxvu2ijqM+Rig7OkCQUn5P6xwYKc=;24:5Wyp56Cj+xZmBxeZTLdGnJeaMxXQAIzwYiWCHukOcc1xHvg/8xfNoMnapjq7ngWQYF9fqOhaWn1O4NwSXEf50FO9fYPxjb0YOIA7rgewWAc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;7:/s6Re0i/A+a9amsZzRiRaPubRJF3x3OA3IgBxGHaQHwRbCidzu1hIA5jAenWG+tSjBBT4+gXmlIkyI2hCKvNLny3OkgUz2QRgOVl7uOUCl4V6By23vZsRUHhJfz4pRULd40p36WgT81joxrpQnVddul2ilnM1oz71JM8Ikt1hwH4DGTtH6i0X4Aqpqp5D+EOuG/Zh7Hj84pkW0DSTg5uOj5nyMG0innUzLLhDBQpdsD0f9X6Q8KXVEOxR7MCiBiw
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 19:44:09.6083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebad33a1-b61e-4006-18cc-08d5d2f85d52
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this driver encounters drm-style bindings it returns -ENOENT and
this reports a probe error. Make it return -ENODEV to signal an explicit
rejection instead.

This allows peaceful coexistence between the DRM_MXSFB and FB_MXS config
options.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/video/fbdev/mxsfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index 12c8bd1d24d5..9ec8882d7b3d 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -736,11 +736,11 @@ static int mxsfb_init_fbinfo_dt(struct fb_info *fb_info,
 	int ret;
 
 	display_np = of_parse_phandle(np, "display", 0);
 	if (!display_np) {
 		dev_err(dev, "failed to find display phandle\n");
-		return -ENOENT;
+		return -ENODEV;
 	}
 
 	ret = of_property_read_u32(display_np, "bus-width", &width);
 	if (ret < 0) {
 		dev_err(dev, "failed to get property bus-width\n");
-- 
2.17.1

