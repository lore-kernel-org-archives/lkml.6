Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0599208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EBO4dTKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0599208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeH0O5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:57:42 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:51613
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbeH0O5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6my6uAMqziLxxqG1qIv87gR90N+afLl9bRdXzQVqn+I=;
 b=EBO4dTKykZN1i2b0ONTDIW7Cs3tXzdIAYMmwyzyMLkP0UVBlnJr88ut4O6okv4FCG+sCZi/XLJiY0vvAaZ7+Unv3KFruC16t6j/tDdllShZ5msOx6U56Y4KwBcr8C6VObjzCG+HJunRzh3AIUscercvIHtP2eV+i4RFUAwSg18o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4297.eurprd04.prod.outlook.com (2603:10a6:5:28::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 11:11:11 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marek Vasut <marex@denx.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND 4/5] drm/mxsfb: Add PM_SLEEP support
Date:   Mon, 27 Aug 2018 14:10:40 +0300
Message-Id: <7d661819825a36f4aebe412e7bed8fe24c7292ae.1535367027.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535367027.git.leonard.crestez@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::22) To DB7PR04MB4297.eurprd04.prod.outlook.com
 (2603:10a6:5:28::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15917ca7-ec2a-4bcd-70f6-08d60c0dcd3f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4297;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;3:i57l5Il3XzR3jU11c+dWSMEuJkvFzM6E2uBxxWvjF3ciajEPAXY2RvYsOSWpKK8xz5KPFzuJJmXQjqjyUviz4K4WZJRtuOW6hE2O3HTN/fE0yaaO8H41haZ2Qacw3ZfRDctoUkiELjJhx4hLOvC05+2JqF0RyTZL0xxvbLiLrirAr58dmmxm3CaI35YxstACv/a2gMc7zF4/kTYhi9Opx0NDDlc5Hn5VN+tz6SS9jaffPoaZclaiV18KZgc/uczk;25:zMwwmZTfaN/5PuBfQ4b2RxA8zqj7Bpk9Dew4ORCfU25PbTUl6lrrpo+Ymky6m773myAtJcTvvVwv/4ufErsHHZdU+ix5vroshDPn/FG1qB9dY6KWQw2hHT9FKJ2d4gJHlpL3GygnAM5GGGmcHuas2fa6mSIa8G6aZOS49S1YXTKSN7u3wP/7MkBnzgiUbmb7wP1ARgeFn7lShbCiV+qbo/GFuQ5N4uS+za+4ahbJE65Cg8kJcp5m8Tz1oQzPGJ7teqtFZ4NAkf5+zGyqJMYIPiL1EFC0QgJxD+jsFWAtBLuQD+uNG0NxDbhoGGrR9jdI0ujUCTsTFPDwzqFsBuhmpg==;31:9gmfKsZrAA3nRcrlyFi8ueb+SVSlk8rn1FKwyWddKpSPTDpjdVnB8NdeqO3k+IC1B7RuygY9O+B5qcZeTD1RvfjTG8Gjc2Um7oFdRruHrJyk46SezVghkoyxzB8QgZdSf2f2BjtOsuv41lRWcl5AOBwBmBP11eCclwNOU0pXe+Tys3C6XKiuJBOF4Loy9M4fxFp+619WkA6zS5ZOFKcQxJVDhmAQ20O7kPV2PyVRB5w=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4297:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;20:l5Gj05sC4C6ZgS6P51aiP+zA+f4TuM8ncx5Cgf+/mlYKuYTrsVrvNKsdvGep+wzl3RzTj8Q4yCREr8veOMMrRpXaOjXNrw4AvOKN3H7VKzSKTJpq70Pr4hQCHPqZ32HiuWiY/fKjWfWOoxwfHzO5yyEDvHyCj/uMad/4oRupA/b04YxrtIqhOFJUArW/0erLgKaaIbwEkELU4eTwK3MP1Ci5xGu+LsZQb/a730XYK6pGoG8bGc9tknGa482VMNHIIT41936VpJpolySvtB5lVmYS4mAL9u7EYiMDXJh7BXw9ict2uWx21c21EDQlkzcAj3ajEHZUbkVxlxrFLvjnZcnQpdgbHGwiaEkZC9CcvKKzEnDhuiYwzS3oGh31jlH/SXp3vITFrmuaHMWOEp6yCqivL5ql/lpVzU7qVZRMttai8Pbvmm6A/wLFy6kn9Xn+TtcIO4S2NoKdyTeZeLUfTen/Xg9KEDX4WXcBU5cN6h8+duNzzJzYizKl8Bl4740V;4:feJH8dhtarDSjQ/gbFM85mRQPeCYV5z6uNAO3/LxXokxUdOdPDjTjxzalPvG+dphT1f/q1OtiCeEeBoM3W8K1TNQ69UE/LvpG/ZncbkoYhxdNjvOmAdn7xvGPu8z9oKXe/2QO5GWTIGoG7v3w+n3sLDVaGFuPHvwkPm/IzOEMkOTUWh11HNd9GFxrLUOdg9VwtF6JkKVxEpL5y/hL3K0Nhg3yhXRitDVfkbzfq3l+UjMD1wH/T3Vkb7PZlnI/+wrgb8cWd4Ll0THIUBF6cTczvVXB4mh0xt+/bmjTMXmbmhS7NHBEP23ryPyH1ZbHaEF
X-Microsoft-Antispam-PRVS: <DB7PR04MB4297D4A732621C85B952F4EBEE0B0@DB7PR04MB4297.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR04MB4297;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4297;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(4326008)(305945005)(478600001)(6666003)(2906002)(36756003)(446003)(476003)(2616005)(956004)(81166006)(8676002)(81156014)(14444005)(44832011)(7736002)(486006)(11346002)(3846002)(6116002)(47776003)(6486002)(66066001)(97736004)(575784001)(86362001)(54906003)(5660300001)(53936002)(6512007)(16586007)(110136005)(316002)(50466002)(48376002)(50226002)(118296001)(105586002)(8936002)(106356001)(51416003)(186003)(26005)(52116002)(16526019)(6506007)(386003)(68736007)(25786009)(76176011)(69590400005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4297;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4297;23:FY3yZAD5sT+ss3dMU6WDvn15ajAZ27E6CgnQQgAX7?=
 =?us-ascii?Q?hpjxpuqGgGSIB3so4ewBRGzzHdXVX6U//67YY7WM66XnKUxCBtsAq5LVeWg7?=
 =?us-ascii?Q?vtTMqSK10bY2/KoOJGKeTdpi47EhECq/uTl4pB2sPzI5CRKsQ4FmB6mTrEw2?=
 =?us-ascii?Q?ri/go8rz+vZLZkJ/pe6ZQqtQRdlkuHi5oAUgWebIZW9Z85nCc/UWpzHP+Em4?=
 =?us-ascii?Q?ppIvp3/hQzLjL2O9U2Ha7ALa13vXxxavVyY6gy0/rF6IrwTGhLpAWq8NmfJA?=
 =?us-ascii?Q?xS3xmblwaEnElyF2uFw4PTat2loV/6fVFE17Fc6evVfFV6iScQlIyJJ6+GJh?=
 =?us-ascii?Q?Aexv26x2Z3iMi8kg1SlPGC4uwbj7ARijadcFwJYXE1quVSN16K6syYVgmxL9?=
 =?us-ascii?Q?t5gOwLaCNufOFcqnyOukS2guytKXZvoYNgOs2AVoNwCW//avsVl/b/u+BbCj?=
 =?us-ascii?Q?PkNA1oru/SXt6inawLSGUnTt9j9LghhXcHBdy4IJ1BGuJIC6ZpCeFyOGYY4i?=
 =?us-ascii?Q?iZJeitef1m47DxCU5MzNjZgp7v4UmqKV1fpj/SiDSU2de4af+mFlIqFxqeJ0?=
 =?us-ascii?Q?/Pfo/c4+lhGjKnqqO/u+cAZapBMcuIRZklBWVxxJhUvmwaYVsm2LMqtSMzQ4?=
 =?us-ascii?Q?l9FB/+qxg9WeXmxioWlomlvgj/qeZvIQX2PtwN25geo0Jdl4EofUAznQVvDx?=
 =?us-ascii?Q?omzrQzTr/HxmhsugWU7xYwWGn/wJhuWlAfGVeic/BghZzBZTEF4i00hVzrWN?=
 =?us-ascii?Q?dm+pZ8rZkQ9Bugh24S/ffk6Ox02z6/spJwwX/I1vP8B9KmbT7wEPTyqpJjMJ?=
 =?us-ascii?Q?zMrWS8YLakFCcp4Mp9A/UxP27YHvyfPNk5xW42rXB3M8OIknRJiaYyYb2lRX?=
 =?us-ascii?Q?D0Ggj1OlaD1yNiBTGwtyzBxlJGIiVP2Gac6uYHz4DwB8OqdsWg/VuWRZx8eY?=
 =?us-ascii?Q?uK0zTHYDbSpdPaaaAGXR9gGObRfy2KXAtLh6Jg9OJ0cc+8k0t8jBoOwACE2C?=
 =?us-ascii?Q?lEVEUifBIgapfMrHe6MXT696AtgquIP7WsMfqIgTo0O/Zhz1heLOs6XfzcqT?=
 =?us-ascii?Q?NByPu1iAw/4rVi/9EShBd7LLuSrhInHQPTRU2Pfa3ji7p9zd06FjtTwFkWjD?=
 =?us-ascii?Q?6mLJkRfp3JUHuwF/9it+Ldv19S8WmxayhR/rhUztmAzyURFWq/82FtCcR1Yf?=
 =?us-ascii?Q?sjTz6kTemqjxHXYYGdKmytCzZn5gpWqWoacKZrGvW74Nhclg+nMbKhzqs9/V?=
 =?us-ascii?Q?2AEH4g1/1ZBgTwhM5NSKSHMtQORZ6huHFLLZXAMbflkpUH74O//v7bdzfDV+?=
 =?us-ascii?Q?9E4XOz6NQ7wG9/yIsPnI3aqYwSbTiMcSEPJHuuwVEL8?=
X-Microsoft-Antispam-Message-Info: jUAewAirtZVxkl+JbYsW7r1ijonjkurE6WZxCwU/z9msn2/2+2dQ1wgrISp0TtebGgN27Ff3HyQ2QyHDdQ5LI+jLdV4SXADTc7s6TnLHNmQzejQqMnYWNASaOjtoBUac1ZPC//TQXY9z8/m+En2Au8zja+7BYKWvmf5sDad2VDWxaTOBvsC2hCnDYqwZNsFmdashL9X0lwrlV7/NQV4JPCIRv/0+8RGKARu+RAdSnhLOpe8oJg8pWa0LetI+x1jLXRDfTNATf7/T1PAgg6IVQIQB0+D+ipko/98oDAXCmXX41td/ygSxcrPgjZ/hYuFmcMxaHajsZP77vcqLNfUjWSvtfTL5Kpua8E8Bn304yQI=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;6:Jgq7Z60U5v3WKPDHMxG3F5FqGCZGYk9QuwfC7535RmIMp0NUey9qB8SA2N5hljNuEGWUVi3qjVxL8WxGQt7/hOpVqnEGWiZVttDmMUtSdk6a57Y5lsQTh+Gk6esTFrJAwx+pAbTcZbDKN73lmHcORKFwDYdhgri+/4j/lV4XZ1IVDOfdOjXrXlYXwZpSS08H9FQ59QC5X+ZFXhxC2aBpPXNchmf31DXUOTV0c0ihvA5/bLErUv3wGx2iRW9jwjhSyuVOMmg/r5LqogkIVhNdE14bay4g33E0ypVuNlTL2H5faBvL05RUgtEc3DDl1/c+Cc8A0d+eJjYFvM9VJeJAwLdyvM/jrDf9J9t5OLx60yb/wGnrxVtwVMjLeOkILgECceJG0OFbDdXXH/q40PCLAjJIgAPNPq3NXbmmY2eqlm/fv3YVXVpZ52y0gD3+FByNUdAibcKy7OwvXnH0IkkxyA==;5:TERZOpwKpZmyvel43CcmQmpP2rdG0n8KxGFZ/ze42w9HrIjmtAJiX0RZbzA+OiBux6YjeURk1TatDvjpXOII1A1E9h/8ivdcSRbtyZAA4si3kqfV1zc9RjF8EJ1DQXk3ig/QqzCuQZDpbFGAiqW2jp09MquUFF8MKNuwjdilxNM=;7:Hj4jZabZVyLKB0+z0wTdO1w2Nfyxm1Fkzl5dFoA/jyVfA01vmgprKP6/3t4PpXNhBMnOAa9H6XyWbmY6d1/2DALwfndzh27aOwJvLzNRPTeyJU7soy4XOhJjK8xSUREZDVkbDbE4Afwmaejy9alIP8mctflWCQMzBjJO0pkDjYR8+huCMLCwuRB9RvP/zEW2LLelmE8QDhrG0RkFcL1KaBiU8IoVtNFZIVqkp3cKj/p5ov4MLzVTfVjKaZ3aTHWt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:11:11.9136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15917ca7-ec2a-4bcd-70f6-08d60c0dcd3f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since power to the lcdif block can be lost on suspend implement
PM_SLEEP_OPS using drm_mode_config_helper_suspend/resume to save/restore
the current mode.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 68d79f5dc0d3..d797dfd40d98 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -416,17 +416,38 @@ static int mxsfb_remove(struct platform_device *pdev)
 	drm_dev_unref(drm);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mxsfb_suspend(struct device *dev)
+{
+       struct drm_device *drm = dev_get_drvdata(dev);
+
+       return drm_mode_config_helper_suspend(drm);
+}
+
+static int mxsfb_resume(struct device *dev)
+{
+       struct drm_device *drm = dev_get_drvdata(dev);
+
+       return drm_mode_config_helper_resume(drm);
+}
+#endif
+
+static const struct dev_pm_ops mxsfb_pm_ops = {
+       SET_SYSTEM_SLEEP_PM_OPS(mxsfb_suspend, mxsfb_resume)
+};
+
 static struct platform_driver mxsfb_platform_driver = {
 	.probe		= mxsfb_probe,
 	.remove		= mxsfb_remove,
 	.id_table	= mxsfb_devtype,
 	.driver	= {
 		.name		= "mxsfb",
 		.of_match_table	= mxsfb_dt_ids,
+		.pm		= &mxsfb_pm_ops,
 	},
 };
 
 module_platform_driver(mxsfb_platform_driver);
 
-- 
2.17.1

