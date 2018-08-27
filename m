Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A1CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8EA208D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xJLzMNQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8EA208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeH0O5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:57:37 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:51613
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbeH0O5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QAhmaXx6KCcyr6kdBHbCSNBB1V8087ar5J2iuHWfNE=;
 b=xJLzMNQ5Inc8M4Tx9FlYlkaVv6egd16lG3hESyW2cgFhOz/E+AuxHCGM/s8fxUqJRFAz9DQExwIJ+fnPtIXEeqbyFGDhV6PtwKhaihqsJ0FAAu7S7+fYw77IlxFYFbb6EmogPJN4HJ6JDpmUIyR7ZIn6y5CMXnOKb5KEuVGgmFU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4297.eurprd04.prod.outlook.com (2603:10a6:5:28::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 11:11:09 +0000
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
Subject: [RESEND 3/5] drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
Date:   Mon, 27 Aug 2018 14:10:39 +0300
Message-Id: <22181175cbefbd997596969e1e3addc04063be03.1535367027.git.leonard.crestez@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0f6f00e5-7826-41c6-ad15-08d60c0dcbd9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4297;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;3:SXo4Oc16xeUF8QTXzMgnOxvwyWHskd0Spc8MiLj82cMaFDJXVsLYDgJmwQv3JLs7ucLitW7eniw8N1bkJKNzrqd7hicC4ueu7IWggOdK89SNxnslgDA7n9ukmLl0RTEQGN9Ig9IIYlCKD68Cdl8/wnJc/zfE+m9Lea5iPty6ls4pu4ElSOfkSHEfQ55JHIdwgBuSTOqqCa7zRmZo/EHi9b9RtoacdkEk6S+KB/+HUp0cBBjYpy8y8+lAMH2KmxCE;25:Esfzaml00Nd68lmiz8YLV3RIMORNaJGUMGn9WQyMPIH0osz4yTvpGOjIEdBM2Chn8rkFySQYAqhkO1XZg/J45FGUJHH3Je2kD1vwFl1N46ccNqG4xWSXCAxDjJZCV9PgpIXXc2XYGEkNUp8yqJ6cvcCKtXEwGm1pKG1RinJJGGUnwQFW246keicFlf3mkuRWBW5YPc78e/SOXI2gfBSJf0alKLMrYkyWYnvMhU7oCdGA3I0vvKUZ0hfntme57PJpSIifnQvPFvLUKfxJZlpFk+8UZITdBvWLy9Ym4jBPkZJIrqMY/e8MpnWUorAK9HNdb04mlOpDvjuSCmrXxXjusw==;31:BkIzx5EtzvkTI5b7KGgne6dG1TKo+VZMRaX0hboRBgsvpHFothWuaV3b5DPLwv6zeTSp4buyRJ57DmcG/xDcbsU9YjDvcCxXFV3wraHLMtVVNZASd6pzqWH+eL2Q5flaaGWOxizaxTCedsXWq4S66e9MAH7LchEw96+8IjBpzoGPS5npUdHlvoA4CH5wnCjCN16nSUH4dTaGprypBjkEySoukuq3hKIA0seOsjor40k=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4297:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;20:NaLhteG2+84coWwGEYVkJP9x4bkfO0uIjDkwyyMaePV7TdCHArZ+dIbhA4ma7/aHdBFNdKP98CKD56+s7BvDreleUfROOP3RhNf8hyj5WgyFQ17BdBcLi68Ah/S91KsQUCcvohr6G+5SspNm2GzU9BI84cnLt5mZtQj33U2+SN6vRaW+hbx5Xy8LiYxnP9lo7hM0JyLE0yCMvQynaQteAS8TVhWGeIg3QGIJ+xPY20RGRCuwL2zTh6P1T3WNxTGn1nksKfiJoTs8WRbdEaMwxRqdZ15H9i+60GLyS23CeCC4Z4AItX9mrQp2Q5frhUAlQ/0Vk1/3+ZaXhHXmpUiBqiRAlL4bT01O/sMjeeknkUinQVWfdV3rvgVw/nog+5Z5JNRR0pCUYVwPLIHDknqQSn0SCAHJEIC7bVZC2G9t8/R3KhF6gOOSRkE8klhd47UlGzncLMf5Xt43pGjpkLSp93QHy/b/5inwinBdaaPJ2OGnw8h2+xoXZJrTL4gHlUru;4:nptWmhYBPbIKs1sGe9NxMLs4TNGI1iUjvE2u7xhVsuRwO9ErxclmwM2ebVlW5pWeEy+XzcmkkV2HvyYJd/JP+7TLozgcSIBmPncWEFnq916xmB8P/8CiacipmNZtfVLpLPlS8B97jqDSRr226QUEChT1TmfeQ4/TQqJ2UbgolCUuRVvTKgPhxEDvNvaH5Lw6xGJuA/BbpfmvbxjH1j/lDKp4h1pLPJ2J8TFYHXs9oYSCHMw1eHCUXYNRnw3bIx6Fy0C3WFqDUudh3ThvxQJr8ejFYhrVv7NpgmFpSBhe+3B4KGQyJUgmhcefFlXeyA5P
X-Microsoft-Antispam-PRVS: <DB7PR04MB42970EA4552D5CD5C15243AFEE0B0@DB7PR04MB4297.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR04MB4297;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4297;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(4326008)(305945005)(478600001)(6666003)(2906002)(36756003)(446003)(476003)(2616005)(956004)(81166006)(8676002)(81156014)(14444005)(44832011)(7736002)(486006)(11346002)(3846002)(6116002)(47776003)(6486002)(66066001)(97736004)(575784001)(86362001)(54906003)(5660300001)(53936002)(6512007)(16586007)(110136005)(316002)(50466002)(48376002)(50226002)(118296001)(105586002)(8936002)(106356001)(51416003)(186003)(26005)(52116002)(16526019)(6506007)(386003)(68736007)(25786009)(76176011)(69590400005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4297;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4297;23:z1tAnZm9ViCd5PDep5ImvkaAFjgsRy/ymaR+mInz9?=
 =?us-ascii?Q?xYdp6UyyAZ9avE0dnY9CFtRUm6kZutfUFdhSUFshXr/nviZ1q6ZtoYOlUYNX?=
 =?us-ascii?Q?H03xD1GRg2V6JeCuRGxAkxmJ69O68WcW1oRlGvUuAtH5+J6BhrHfW79fmcrk?=
 =?us-ascii?Q?UKl1lmvM0eCe662fr/lRw5Gi1kHsIlFcqWxSXCthT1SjQPejSVz1Nx6Sj1FT?=
 =?us-ascii?Q?QbavaJSmRM7FnJuf29yxqlqDnrURbVwdGj4KLd1fcDxRE85/w0v/e2gXsbCo?=
 =?us-ascii?Q?Uo245dL807xIQ9yDVEle20YbBY1nqlKLhaITjVHuaXxYlDRMnDtVlOjBBQHj?=
 =?us-ascii?Q?ctlOQRrwyAieCGLjhWcf+YARvjqo1kNjfDBg5YK/g69Isp+2To22eaWLAJF6?=
 =?us-ascii?Q?4P8HeCnvViYwEFKitd/2hxdga2fJ8u6rxf0KINwQR5nOzRMCuUX5PfQiXOes?=
 =?us-ascii?Q?U33hHus6uNYyW/S0KGVVR8WCbJ9T3YZcROlG+JxFEBUY956uvu3wfJkTnZO9?=
 =?us-ascii?Q?5Q7AX+A+EPmLeHAYhhILx69LGfmysu4EZeex+dq10XupQ4JQ1wBLjb627wQv?=
 =?us-ascii?Q?hlGlWQ3QdJ3Lsg6P7jJDu4Sx715m7WEd6oImN3W/IARxemwB8xAW9zBSwu8y?=
 =?us-ascii?Q?QdLmk8EE6YETT/RvoUS9WgrsFUGMC7hgXmxbsMWrGbRIyD3XU0ozJ2OqGH5K?=
 =?us-ascii?Q?03Je2XM3pDwZx9R/uukrQXsZRSDdJEAC7hXynd3Zsp7Ka/2VApFlYJFDOtE7?=
 =?us-ascii?Q?TMAcJq1ysqvAV9GAkfu9RFLeEfcGHIsuqheCV3k+40TQHX40LMQRurJjifxv?=
 =?us-ascii?Q?uCWojTY/mZDiXdnmDimk5kNyXOsrWsDQ2zNpiqvdbESXz9WROYuhMuJXXM2m?=
 =?us-ascii?Q?WHU5Kms8znpGky2C/Udjyb5lDxxfb4fVwpJppPwLlJHojcqvZWSvIz/ESdJg?=
 =?us-ascii?Q?ZXM0D9vpalRn+eBcapNB1+KfRKvw0mnR3EJ8vzSjNbr54TvOh8UaxUr8rxDG?=
 =?us-ascii?Q?7SEdw/A9AaTUUbTbDny0mPOkZIZ0/9uYm01bIljvsgl79/s/vEVgDqmcn877?=
 =?us-ascii?Q?jsmVxFapiORU/yD9rkP/Qwk7XBTs2xXCRKT7zmAjO53CT8AArTfiVESLD7lV?=
 =?us-ascii?Q?ryik+l5vv/3jXtC8v+onjyXaNxeVVrjyQr4SMBhoIhC154Jyc2wcR7NKooM3?=
 =?us-ascii?Q?K3CHl5t1uLnSMEuTIzgv3qvCdVSXvCQJ6LDh98HhmuL0ILRlPRp88wiBownp?=
 =?us-ascii?Q?f5ANuFyYJ94oiHiNm3w/+9Xxko6VOV8ntZNJOZ3VBHo9QFCG5I6NakbkjkK9?=
 =?us-ascii?Q?RBwmGPAAdix83IuzTkP35YCjTWLSWyiV48WIOmEsy+T?=
X-Microsoft-Antispam-Message-Info: y4nnh5UUF8yufbnNQBT9Gqn5inoAiRHC9k54O/SBii6pYBybSIvl5/blC4P2FeCDRkSt6xEYjjJg2sPBFBYRn0o9sX0yTiuLkS5RqhcuMCJSyY4FtMEOWNjFV1gTnJLAt6Ggyd0keH5s6FPMMoc+hJZGq2iVcMy/rX0Dg5/tHdaK9xRJfB+5DS5KLo3GdtC+saywV7dxtQOsdCYvEzE+ZRakX03BAs0/djPpHeeZ6g0XP9IdvlQ5Q/Z7soIcNxqlDl+lDVD66RVUhTr4hiOzDL+XNLNvJw+wKk2pvNAFGZptPah0X/Py2GFTzdNxBHcSq0IDcAx7xI/ioF0YUpVpOh8mcDNH+5OKoZs0TLHL5OM=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;6:u0TVOqlrUzkd4suIF+gtwtLcA0XAuItOfR/ic6LDx0HWxjt1GoDSv64MqV6haaX62mtYt87Tf+1oibRkjywC2iEO9gWIeJ0UM90XcGowyI0MOhC6JV7eojaqg3GOL8Tr1uhKNRGB/uZ2EpYBroOFKAM0MthPzyR6oxwv6UftBYqlh0i1ltFwj0y5fnzZZWvQ8F2/ljaWWylOH4wqBJVLoUW36DVFYhX2IQSHhjIJkeS6FmUjoj6G/y97JYHqidH/qYIuPNYzeqWixc1642G1FdcbQEdjtamHYYReGLduz/Zjos4ckwzYrV/hGmHeFRGnYPFc59cvP1KHBybDYZsuNTmMfLlnRQrhm21BF0iMhySj1br8AOkksIr+YgjTUuQdnhz16oCXzNgcuSjwRcexBY2xfBz/PpKb8xIsFEfoTWO8IQDGyFfBotXcJhHrw51E4dhHJeYJZoqAVYSKtRbupQ==;5:kHYEUVkilbdeFzEhA8vYDEpuSPh2nn1fpkZSZOETtfX4kp5AMFbnHpdxK+GvSBdui0ZcHsqSQYeMMJ3JqTylkp6BtiuIsYq7sQsWuoT4eyFjWTZYyQi1iyyEJKBEKIXRDfCyMiSZBzg+MNsOHgrgEZ7DCl2kSOD/V1Ay0jawOLs=;7:dMTr6Ok5DY16j/YpMF2rjmN0wFyu4PVVLIon4hT3/vpFckfHAeDfAn0y5KNEAz7PZqcQyYR+h76pau9lsJ+4I2j/q+iOND0UftKn0810HmqHjNKNKMwiu98fS8uCebsp/dnBC9BEXDdlW1wNG5vuOzrmBqhYkw26x1PLb9iya4mO++Z8jIcHEysKxlUqT1yg3wW5mfYbae+6KnbMf9E3o9uBMb+qlUxutO+7KkpCAp3/h0iGT5HiqOy5zcc8oLPw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:11:09.5609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6f00e5-7826-41c6-ad15-08d60c0dcbd9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding lcdif nodes to a power domain currently results in
black/corrupted screens or hangs because power is not correctly enabled
when required.

Ensure power is on when display is active by adding
pm_runtime_get/put_sync to mxsfb_pipe_enable/disable.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index ffe5137ccaf8..68d79f5dc0d3 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -101,23 +101,27 @@ static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
+	pm_runtime_get_sync(drm->dev);
 	drm_panel_prepare(mxsfb->panel);
 	mxsfb_crtc_enable(mxsfb);
 	drm_panel_enable(mxsfb->panel);
 }
 
 static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	struct drm_device *drm = pipe->plane.dev;
 
 	drm_panel_disable(mxsfb->panel);
 	mxsfb_crtc_disable(mxsfb);
 	drm_panel_unprepare(mxsfb->panel);
+	pm_runtime_put_sync(drm->dev);
 }
 
 static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state)
 {
-- 
2.17.1

