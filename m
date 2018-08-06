Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C3F21A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DDcjASaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C3F21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbeHFVmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:42:09 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:22570
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731324AbeHFVmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YXYWPS8UPXT2fZWKPxA/MG6g3TPed3zxy2zxOQmTek=;
 b=DDcjASaHPHcRzfwvi9poJkK+odws2fWvhqhhFYkHX5wsqVDRYoU2geOT4O1vvpOeEs35GcKTnCl0rkhgtF/HWG92r1NLEWQ1ldXd0dPe7cBJ0E9mnyGqrsswYlSFTPZ2g2JN/SsXDyy2lNOSKwcQQbYVv3SAMpbQW9naEKTGU/0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 19:31:30 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] drm/mxsfb: Add PM_SLEEP support
Date:   Mon,  6 Aug 2018 22:31:09 +0300
Message-Id: <948022edecc7af494e8bb6f55bc4ddbc33c74e3c.1533583611.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533583611.git.leonard.crestez@nxp.com>
References: <cover.1533583611.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR07CA0162.eurprd07.prod.outlook.com
 (2603:10a6:6:43::16) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d62b7614-08ba-4c84-fd8c-08d5fbd33668
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:ZhilLrOUr2tRS+Ep52aVIMuxks1maJkxrBtxCXTtwHJEpB+dwrWTFFvg97pclCj27p57wobZFm2/yiFLpOTUq+e9FmIJnWblH1A6FB9hifkVqyfSBFyXpRXiQBEKkYJhYfbqd9OOWbflMqqayGECvRgo8TQ65Bueh5egkV4ZbHZeumZLaqpEzBUR+IiIS6qHLzoul1l6nCtrRUHoN7NZXLmJMCcnTWYadpPav7gke0v4FS6hwGTRL66q8UosS0mc;25:q6+nZb9FMp9jlS4gtdWdMIcBeajcIIPEnFHGzDhsVqcjRmC0jMOk3wTf/XZaVfOzT6xwUbJaenbOHEjrjEjnd/kffsnTAYNMmKN814AwuB7If5/1EyCucT+11rC29GrIip0hu7XGzpMyZE1WhLzBgP7lUuQAqbo7eER10K/vD7LIu9Ltbz5suZHndzT5rT3WhsuazblMxvLTQxUSPjN3AValjvWUvOKwcdrTaNgEMk3YhWyly6OtfketCvDkDwMm74/rOosm+LgrkSKvpcCgnNi7YhOBDz/tr1wi7+wGUC6vMX1LC+hQKKUhE66ggscEB4lxuDMNMSKt6qzCWy65Cg==;31:tuBA1HhFyYQ1VS96u4XBO/tjUzYUKe9TxEFjjsT1vpdMNAKkdZyKSY6y5BfgNKVLMG4GNepI5BVKvabZV7D/wWLi6+ycfvvyjEXauIwDjMltG53j9LN+FhA1FLSwtFPZ0WFxPdyD9SZpsLnYMQ7W3YgdreyPQmnoqdKn+csstyTZbeoJ+Wb33z0omDaOdM3cXfA1WCMK9lp4j7zbuW0Qc1e7bQi/4jOwq8H1ezo6J4A=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:DKmYCExSsFxBvsHzBNjzl93E/5nCkSogEDLb0XcyZ1MpF28ol3HM5MKfBuQF4iSr7OCMy38TC+b4Il1WIMSGfU85S8wn1cXqQ/GShIirLXuBoGK17Ghkl2OWDrl0kmsjZ3qg1MJUMp8SaHtEXCJSyoHvnGk6Bxy5WrtI433DIAoWY8EtXyK86sLiqZtFnfhzLUe4LhGZlLyiE0gj6tvIjLMrshryuU6w6qFSt3cezUFZ1lu+MwkIOX/CErpEa7DW5Iwd0YaX0ukfDNvYfykN5LvY2fz5iJ7tVTMLVbC1i5KnEjpcD1OdiadclyMtqbu2q515wG86rk0A28OHMHNGRmRKOHlZ2aL4EhBlkY5cceXw9OXr3xwtcaRsoM8Du6EZPYqQYkXH4a2lN1OTvEZXhSJhu1T88A8UMjMTdcnJsXsZEH11/jZSse4DGBnGek200JACRhe2DMzSJLOHt7DZosaEru9+NfG5gVOM8qbFKsAlnOnJ8GIojil4Z/Jvtzic;4:RYop5SdqjdzcbwTKBGf6UXuVVcejsB6frWS+AOIUUHdzcLY8ocxHnBRP2PysAqihKhNzCQDU/3vsIOeXhDdx3qA5Hp4S1U4OZrII7OX/H+YtYNtyfM1+c1/8FDETV3pRBra2tc4k9eIYCZRi5wx6KIGwpy8OivcMwwl+K2rhGlyCk19nUf4q/K41WxCNOq8yKFIa3uw6orWZCmtqd0E5aKil22W8lwVc6sAzw95lOayFyHIvpp6WSWyz+ulnrUqsHsCKwew+lziy9MyH/6KfR9Z1UgJEVFnQW5Pq2wX4m84eLsjyX2uIY5UuEiLTgYdP
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290300C196D5228EFEDE53FEE200@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(486006)(86362001)(575784001)(50226002)(76176011)(316002)(6486002)(68736007)(14444005)(386003)(6506007)(2906002)(6512007)(50466002)(51416003)(5660300001)(478600001)(6116002)(16526019)(3846002)(66066001)(25786009)(26005)(47776003)(305945005)(44832011)(186003)(8936002)(52116002)(476003)(48376002)(6666003)(2616005)(4326008)(446003)(118296001)(54906003)(8676002)(105586002)(81166006)(53936002)(7736002)(97736004)(110136005)(11346002)(956004)(106356001)(81156014)(16586007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:VRt7s62xWiVEZtRZzs9BGhOpf2H7QHVA67HdDNAoM?=
 =?us-ascii?Q?ToAmTNWj/NDtZbTl9k9T7fOIJpNTt5vhv/0RFz0VgLRPEMB2uPy6kLFnSRr7?=
 =?us-ascii?Q?1XsiXbE3jU32LWGNJT6n5SfAjtt3A1aVW7ShhikMAEq8qdKGtaCsPBXJ2ho5?=
 =?us-ascii?Q?A9kE52FOPlxX8lilQsH45/YRYSwfWLLWqxH3gY+A8SUdjODZhpmtJuWjrsdm?=
 =?us-ascii?Q?54XdKtH6nzfSB0SmKVKsgOFbyQjCHe1D0jaj1RLrfWnj/K647+cqC0AWKt29?=
 =?us-ascii?Q?Oa9ggpKQ7f94kSj6pDyCDV+ED0neDMT7o8Ts/8/QYJhrkqoK1NfC6mGJZ122?=
 =?us-ascii?Q?95+4aT+ioVCkUpdBXhMC0/LO3OLnDgLYHSmQ504aG4K2XSX+YcDtMuNALdaA?=
 =?us-ascii?Q?65XX8ur7hzr8WTf6Ax002+aGXo+vk3+ZvXhsp6KbNZl6jNLgnuiCyVlpUBas?=
 =?us-ascii?Q?0wy/Hbnu99NnfBWdSxDKcu8G1+wxKIveMBHaGkCde4KGESY+S29zr0mfbrm6?=
 =?us-ascii?Q?qwMtvnkH4AWEVKJh6oNNQMGxCOtgmAmF0R4p/1UBG7CvePfF8mW8qgugFPKq?=
 =?us-ascii?Q?8lWqNXH4hKlifQPnNeqUY6EVJWR/+jOdBPcC8ozTHlNskwUVxMeCt2DwPv3H?=
 =?us-ascii?Q?ekq8evc04s8nAwqdg31dPgW0BlwLP87CNTZV8Ig3aSVJb9WE3fr3mR/ZqIWa?=
 =?us-ascii?Q?Be2GLVLkKERUuntfFzjELETW6tq5DVW9jkQJsc2hkZOPsZLWxTkvrQskX0Kc?=
 =?us-ascii?Q?w2a5u6wNbQ5NNL+2fMXQq8Q4f45gdmokdrl9clM6DqZHscaAArYbh0Yf+t/3?=
 =?us-ascii?Q?hS2uStw+I4KbPrajAvv7QNYKT/Ik+5l7u71U4mdqlvOZka3tUl09NEpNgbUl?=
 =?us-ascii?Q?/f52Rs6NegnHSnLtLXK8y/JPaog7OWIQS71jKOq5nCZ0v0RM52nykS9glnbw?=
 =?us-ascii?Q?OcvLeWBLVu3wrssORzrufuNf81cYSqTkXRRzykuy4xLccgUAfR1b3hK2q+Yo?=
 =?us-ascii?Q?BEvcqNFaIGqV/VZP5gCGV3LxPm9Hda3bjPHPgOUIRtSHnGj1r+UKxF+5RS0h?=
 =?us-ascii?Q?x/Sv69qzexTPl6cdej4Yj0gMCCQToFQ3ycZPwUjmSQR6Be7uIs31IhLNdy1N?=
 =?us-ascii?Q?CF/Hh8ZNnfx4odiWYFE37L+XbfwdSWWYCnhenTEWxxv7S2sQowkf/N4oSk1p?=
 =?us-ascii?Q?Paw5f02ZF5gk49bkNT8ad2pe/DSj8Bm6YUCymboIiciAslYI355UUTew9pg1?=
 =?us-ascii?Q?0qevRSpjXRvR6tDeMhvMjyb9PkQ6kaDvDp8m8Bw9hkwuTj6pKno2xkG4KNxa?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: 9E5APEAjox8kv2ASwnbN2eS/g+0xKYqQvbWQfJ8M5pbRzQAAcTSxbAj4D7XXr2ycCvQcC/MzgQ+Hpcp5rxSN4Hs4C4l/YRl2OWi4wktLznV3YHrudmGs5Hguu7lG7JnCCRjx5LtIHi4B+u8PfWEP6A5NH46lkl5A1ID4UiRxGirxflQafUVpfwikUCMwsSL5z4DcFafAD90YMV0r3IqHKfPc6ebFESPbMv+1xI90fq6VonvlsgmPTf9wMoKvjTOggzFvgKFY9FKdHhCdk7zix71ck0OdbX6PQpXahwKymRBv/6dIWraudZZbwkxvL3iEo7p3WFBWAaeosY2LnXgGJAyhYRNiANHo3/bOrx31jGc=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:cpg9A4wOA2cXS8vlVegFeDhNd3HWLfilNotHa3DdPc7MQOG2UiODsbkjyvuuejBOsAhgxxmhKIfdajkvmOmeyeX3L6xfQPeLWxKDQSsjvLhBQjE56BP7KHlBqQKfcvlFdOXJq1pDzFV7oieZ4/eQDFLGoHWEjtVthME9CI1HR+Rtqar33KAxDJsYxRWDx5elzUpzSjYQ9zytvXBuBlvrlRxQPPXrf5Tl2ih/erNcKrq0STMwOfI63OGvN1LJdrDkyk+mvu7hXqm09fKjURHL+RRtVJlEhz6w66ae7lvO8SqKByDwHx7E36OIY5SHl5FvROsbSjIC4F6mkDMPQApC8/WA9iJPeMhchcignMKbG/CMlM+sJMuFox2I3IDYtHGID4eoJL+woKIQgsZIlgUrUHaBNwRj3UQ+AYSH1lcl3TBMwmvKLeJZpzM+qwxgVgAW/1EVT59cKH5iF09LAATFLQ==;5:tfaqjZeDz9ndN4BPK0jufjMrpadN796Bk3hoKXkEyTd4J6Fs30lgHHRma7uaoU481GZl5HQ5LCqQDacD4oHpi1O8MTmQtvdvE3qJA5hyTMyRpNhJ6NXUmHqZWiBBGpmAI93Z5mWyrtjrU2jCU1AopT/OnJeGVWhlQ/BtqRioG4w=;7:fRd+bCZAPD0XRk1x05CrKXOxbomw7xvcdpdkNnAI23uZcFs+KxAWdiQkE4kZJ49YhObo+pjuKIRA+qGEspqwyYCueaH8DFsSjH/k47XrhuvacPq6zN4DTsd31THrPhquYDyh+zor72l0louYhRXxuj3V9aJDVKZSF0gFYurGNZHMpMYR53psHxBceKptxH6TvRG5vK6NBkCex9cZbROXqEBTOZPnAsWhtpRg0hfzhedCcpcgp/SU5M7buxV6+4WL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 19:31:30.0806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d62b7614-08ba-4c84-fd8c-08d5fbd33668
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

