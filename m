Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B91ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58872098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JJMSB93u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58872098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeIQTLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:11:07 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:14673
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728388AbeIQTLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6my6uAMqziLxxqG1qIv87gR90N+afLl9bRdXzQVqn+I=;
 b=JJMSB93ubU7o+BurwXzrbXYUUWXIyxR3z/NZE+8sxrWzhYGXCujWv1wDqDE7cPWtMUbLY5iIC491KWIiWNKqToutTOw8TbsTs8zrV9BxOBucZYGPL84JH25+t2tWU4sZJQG6cT00qkks+DD6jlFabreXgjm0rG0VHM/e5MEeea0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 13:43:04 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Cc:     Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [RESEND 4/5] drm/mxsfb: Add PM_SLEEP support
Date:   Mon, 17 Sep 2018 16:42:14 +0300
Message-Id: <cfa1a4083eefd112362e640deeb2e120584ac3f5.1537191359.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537191359.git.leonard.crestez@nxp.com>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::17)
 To AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2efac388-a0aa-489c-ab47-08d61ca37ef1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:P78QgowvxqLdUqCPB1dIVnTrB08ICnt5QDsIg1fn7jCfU6rXVl76v2LWSUpa99Ry7NYssIflc8g1UEWVY9BaqAGpYVSZrnDahpMZIYfrC+F1Qyja7QvcBg3f2sxwmcadPLELMv4xudtHAhoQkehh1EG6+bLyCmO2wsoHX3w6G1q05Ev9OWvA2b5QrG608aKHmUpBSiHBvxtojqygebhaMDaTqSIFuCUJPfOpYfxzMdcaynRRQtgwWCXO1wYhwziL;25:oYhnYeuPI3858XvZP7YrnMIhx2qaD7B3PSc20AfMk4rkJ9TtcBxvioSO4qCONtoZndu5qc27GLD26wcrRSAjT4lugoDUgz1O3wXeircaM4yM4JiDrKygqgJhwSFv43D5BFXrQ1Y/5Nlgd2E67MWyUcQfohXz6sH/Rtdui1G7ECOYpzGpS43fArfYjy8xW7A6H0hzs9eBGEax2A6wg6Hayz2o3qK4Bvqqq3BtrDqqfD4+8p6c04dFTXbBZTMZtWK/XNPp4rgH1jWvOZZT0o4f+zar3VMQZIL9RhLZAWuh8skaxcdk4V97c0dBoKiXery0PWdKWnxXBRs6zaOWq3QB5Q==;31:N2x7nlmeLn1FNXxrnAzaKW7QGy8x51JFcvlTq3BuQ/48GtNTZoFPZKML5TcKOwSBq7t5q/cicvgcCATWO43PJnY91uDPmbSgXOZvyazl/9tm6vWogawaUn4n/IWdn8N6G1Hnwnj8BIsAIdQcNdLtL3bgpOH8nKu5Ssukc2XmhgQIkzo9+6D2GxPFBGPEScb1UZCPo4h8JUzfr6JrkPJS2LBtEE3GMveDpJxGbTICfGk=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:RSqzfx8JDIMQ7f+l4nVtoutxGbjy5lGWA7CflZPThCSvFxw4UVZafiHby+hSS8cfuKbMZuuy+wg1B4XV78t2xp2wvjP0HQfdhaS8RL7fOosl5hkLkrOUAyMsItVtTF4rS+sVUMU4UiFYN9S4ps/s2uZF5SDbQxBs4nK1ydxyP4DOM2e68qu8wYU5M1oPgRe7N9IEwSB/j194RNQf6onTep0kx5t0BD5gukGCBh5eb9CrAGrYzN1hv/iCW5Kqx5VlBCajCFpvtDOL41Gvr58fg4EEEhE7VIUoDcHeAADNyMX6qiqTqPhNmP1pQYk8wrsRWKhJCBTxWgO7aPs+XHTOjQQS44I59AKKQ370ctTwXHZnLEcJFGfJj/BF6/gOoHiH+czX6BiyKTEizu84ygAJwIwRx+nivMxziZ6STjwCgiiHFa0Bw5VRvRbk1BDK6vrDzRPCuuazp3+5z4193gcpjoIT179+SjrGYdkKO5reALAtnK4wXcad8Vgwu/SPA2Qg;4:gIL48VA7/fPm+8rEiGHh6FYmJB4rC+xU5kqmOamMmeacjWPBrwmFg6Ep6g0/c5v789Va5af7BeMedLEzyS233doaOCO47XbCLiBHcSyzYZX5hvEaOTtX3OAtU9GuN0j3jCkPJWWz7Ro7nonmC/ZfQxDLSAM2Lq8yCZUSeCZvlP9vl9hMqsM+WpoWuLfMaH8gb/yikkR/nj5zQDT3EtdikDRPOn0ZCDXGiBJVZ5a27lqt4HeW+yhnNLqZhx7CnYiLd0L5jeZdixwwqytNyXWKQJQo6nl3UfAnyUp4C31wLz264PGE50AJcoDwvSzJNF74
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290FF6691B9FC4ACB33792DEE1E0@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(6506007)(81166006)(81156014)(8936002)(14444005)(50226002)(478600001)(16526019)(186003)(106356001)(3846002)(6116002)(105586002)(97736004)(47776003)(26005)(68736007)(50466002)(48376002)(66066001)(6512007)(2906002)(5660300001)(118296001)(11346002)(446003)(386003)(110136005)(4326008)(7736002)(6666003)(476003)(956004)(2616005)(54906003)(51416003)(16586007)(575784001)(86362001)(305945005)(6486002)(44832011)(25786009)(53936002)(36756003)(8676002)(52116002)(486006)(69590400006)(76176011)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:doo2tDTW2qRxKbWdUIz+DXdJ2Q123lgZuPVwGOd/f?=
 =?us-ascii?Q?jHqZjm/5A5BLvTNEHi5MeRRmHJx+ivroFYNYLmwHT6K76iqyv1F3bE7Hpv4X?=
 =?us-ascii?Q?nD0adoEXZlnegMkgvBBSz+iuseq0nWxu/LrIOeoIZtfU8Y8+9PZX6kGSXDNo?=
 =?us-ascii?Q?l2IwfglIHL9JTxf5Gshc0kYeQM2HafA31uydoVNrf+JlUDe2958FUj8N2HCU?=
 =?us-ascii?Q?5Uc1b6V1AePXkmvyQHAFJSvtJusjAoYaLGbpJQV/FY349SPsA2IFWNh9nGnx?=
 =?us-ascii?Q?S8X6GX/0ZlnbaEchNB1alW9ePZplPlkjegYJzWYHnq7YardC0HT5azwKx2GH?=
 =?us-ascii?Q?zfc8cpYn7GOq5zIx4d3rFkdvaWmx4lDeq/VvDwoav9N0oEWaWwj/S6ztdl1G?=
 =?us-ascii?Q?L6bQuZUz8UQDn7zXriHn3Cnl2PlmOdO3WMBRsFC59TdfTEIMi6drP59plTdk?=
 =?us-ascii?Q?25funPIqdXqZZTFEC8JUYyeQ0ixlIBl1f7G9BP9TEFp0FCTGd3ySDKSeHvjc?=
 =?us-ascii?Q?DvWoMQIcblNka/zl9cXavIECzNfuNTSdaN5DkMT4E/yeYd1nq2//bqndMioX?=
 =?us-ascii?Q?5BqNc6Cjs/ZjMYalWd0p9Nme/2mz42QKg5o693SANM6/T03VvDMwqXcQqTVs?=
 =?us-ascii?Q?anCZT/Oz77EEUCZ887e/joxVh9mUEaSMY7+iPWObLaVHAQFPsbI3UhpqaTzj?=
 =?us-ascii?Q?unOKqSc+b8Kyg+MAGl1TWdEiQXKXYRWLK+/FUnYTFrwUGQtNNHrlvBvmOF2F?=
 =?us-ascii?Q?byVlLEtDt8+kkiVJ59uq4DBDD8c7q4l8Vv6pwhwPd4hgklfLq3iEIqLxDngr?=
 =?us-ascii?Q?kArzMx8OkrNl2CR1eS5dZx2dpCCxjQ2XQvorSUKhh6MSBwFqlZFJl+8Ye4mD?=
 =?us-ascii?Q?U1VRMvRVCI2TkBphfl6nhCsdJGAu/Ll3V73zrK12k+VkwwqTQeKKfrdw/Omr?=
 =?us-ascii?Q?wP+OauQkyBxyy6SMgck87n6jSDEss+7bGnGunwchxpobez7pcNph+dqPQrRq?=
 =?us-ascii?Q?1RnJp6uD7jKVU1bcMH6k2RFZvJGM5NMKsYLuIUb+RJrsrhC9hlZ/DspYC+Q3?=
 =?us-ascii?Q?OJyQn7T7XGjvqeNt24aeTHcG4Qq6mHN03Qz7BDstnT8GF8fY7/jXYWPxbMaT?=
 =?us-ascii?Q?z1gzfvxPP/DPtLPCE/Qokpfo+nB9/qsm+W2MrWjPeSAqTQDsg6aFiZOZZabY?=
 =?us-ascii?Q?dpnrdKmof2V0gB4Xr/LxTGEBQ1WP7vqw/+IKQCzwj2KSabM4n64foRApmm4r?=
 =?us-ascii?Q?utaQ99PpnqYiMn7IB7f/KhPXRVl6UT7UBW+JQN1vUQGZBXAf1jE/f3MbCrq8?=
 =?us-ascii?Q?QkyI2pTXeUdmtSV5RYM8ZxUx/HMY2uaRG72/jM4j6Tw?=
X-Microsoft-Antispam-Message-Info: 0qMnNKdtPzV6Wy+q1/FmDqPafE+ZA/HjOiApioD5wLneh+3sTvGm/30ulEYnmcmCljyX4krdgBaVVULVajUbFojXhayKQGEW9LNeAkbCAe9xCHEhPJoPgNFZT8XV8LR45Nna1+Hcdk/EHGGULSdX8M/T9sSY73vRWCchFqt/2D+gAkya1DFTDy3dVFtzepuIy0fjzygjpqDXC3Pe6HPcWdzeOLScjhiL7y7Dg56WcThbLQS353wewKmFSpmOx/vbMSydzMzSQRwF6lzT4uL4/5JbJK/zbgL5CnXZgtgrFj1mI/pX0en5xkns94J02CVa4zEvCiAJIB744t002BCZwe8GUONuAV3Twk3WjM1J+Ww=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:HbsZQ5aZdvWzEh/C2UimTlXCs+XjplK5CBk1WXHMutvj1QDLCEUBOh/6kELKYbqegH6eYC0oYiJgG8hZYCdJnZ4vjQqc2Vk6UGk9vUNTXtF+8p5H/dTXrMRjpg7GROicZhLN9kuRE1A8BKolkTvxTeW2SNcAKLXg4abi+ZBqRmW+5MD4/hizasLIA7wzYHfR7ix0AOpeHOi654NcJua/YBprsSBEGn/vQfoDBN0YHDZJ+oKnU6bCM3yZoobw2gv5p2vgQKkOXklC4/gkavoxHKJk2INFnvgxrSPB+tJNJ+UBBf9OOEritooeY3dHpjG6TOPlhC1GjA4ypx2FCiV7b/2BWHuDHfSt2M9ATANYsEqEE1r4c6czqLIp2+/mULbIysz478Wi0fwR41vAGcyeGjMK7t8pjHu5JRW5pgeBGzUF/GYlmBVQ7ZTL17hQ1ql4YNPldMz+WkYZK+lyUEt3/A==;5:eGvO6PeCs7/TbPGif6I3GBNlf4nvIEVYlEXL+0dk4ApVMcH55ZCr6QgvZIdsz3xGG8tHrwX48IoDjrQV+VZb79tgN1SxCjXm8PR3x1c/RpLoiw459+UZyTaSwWvnTIRtyDXOteLMGbbbMmj5EmXWfNxoVoD7IERmXt8vSYkJa48=;7:ETsNgnzl/Zi/AJibkBxnv6x/pbE0LATjAr2ou8Zi/1F6OaQBaEJPshOD/Nf3TmNR81eUDL/gnZSnJwZTdWYePAklRh2oN90kf22jos9uXG+Ckit4heXAi/h/xLiAd/KxX0W4dhsLKG0FB/xHi8YCNS21+4H5H8KeET7/tl5rn+MnivX6Kfn+0bWrmxPTAu0c+7XmV0o0c9SNgoybkQc5JvOUHGirVib6f3P3zGyBEEW5fS7VhNA/zA5LSOpdATtS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:43:04.0538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efac388-a0aa-489c-ab47-08d61ca37ef1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
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

