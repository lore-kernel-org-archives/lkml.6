Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE5BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C052098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pb8lzphW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C052098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeIQTKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:10:31 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:57044
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727460AbeIQTKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZMbrbTCJrsmTfLND9qkbaNvCURQg0xkYrepOv0UU4E=;
 b=Pb8lzphWNPRZthpoAQqiS6R2TC909f9qCEyz+njMCHhotqeoH9sEMxeawT2DpSgM1OpyyAaIphXZkLf1nE1MDFxM9HOZN54IDz6tDrkJ5GMLlKsCK2jvtJ3cxZ6ihD8VcxJg76mtdeTvG9aQ5nuewv3zGvpYyTeAmNiO92htroc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 13:42:58 +0000
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
Subject: [RESEND 1/5] drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
Date:   Mon, 17 Sep 2018 16:42:11 +0300
Message-Id: <985c1f1cad250bd9ca154b3e4b3f913c310eeabd.1537191359.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537191359.git.leonard.crestez@nxp.com>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::17)
 To AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5141b6be-3402-4a08-4023-08d61ca37bc8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:euyD/ifS+Rt6vdC147PwqekihPwl0KcG0m2cdn5kOpj1Eqtn6P7aQ6hIuUCZZm3uiDXXDASR0p5xv5Cgs0S08tUm/zWGTSSryUfbQrRURt+4736BmA7u+hlbwj7+Kgw1qGly1ny/4snEBSul1yAVtFp4KEkqF38SqxRgxmxsbvNwa2KjN2ZfAuKfXi5DUjfnf5vf7x1pg/6T+NLTzyLJQVe7cXef3hwf/9OQJ/TjyNPYQh7qcYbWRQkhN9KJno7t;25:oj11VN/aikN+AM18iLEUasAt7XUYHwIfZ2IEFQ6s67hXfJmDeRpEQ9tqAeiFWlZtSzjVNulvMF/4XfqAXrnd2G1Fq4Ldq89H56VAyrxDBJVwB7t7NADB1MKVW5cVN23G34dD8bwHDkJmcVmn1uvZ0w6lJmqq9ULNBWqwzQ2MkPvET9UUcOy4PVl2gGa4OvYZZBcA8qT+9Q4pztaohyfrxMUUuDFYbsOc7t0uTofrwH8lu6/B7eWII6ct5Bc3Zu6HWxbi+uUB/6x10tnobUX8cYbn59Zoqo3V9ZE7ozgmpCyooYOrFkowiJ4NmngJ6GiLOPqbU6yzuo5EfFcazQMxWQ==;31:EjEeMlNS++WAeFwAdVbtkoWG4FmtUymlm6iT5L3T5ZUcLyPtqSX+0RInDMjcbx4DgCSFP+pXla3DGZkQDqyEoHPE9ewkSrfcJAmXOQMcs73T5oBTEcOu/eSJfMP6dsUjW3aKAvF/awk7uabSxdvkAbbAx65grxHsPP9hjM/7Fdyslc1tzmYg8qWVJU2j8EGPGaB0fArMGeuO6At09Md1nFWI1H9RjnjxNSVhFurg9j4=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:EbFFFfm/FRGZF/PHXlrEIHEOzCVrQOIH6VEzx/vj4hXHwPL4QPYqreUujC0hAOmLqIJvM7/rsbQEdcb8N8VdMppAh2Mo0pIuN9A2EYSQ42NTYA7Xzu+tW/Jzb5kzvDKfYr0wRB+HOvjA3lVOIRK3qfHeXFlLFj4qXWAe6/IaH4MfZsucMCpf/qaWrL+/s+MtOyVB6HVkWqZkCGRqYSW12aL1fIp/PnseADBnYP1a8yLscEM3NJaCtzJoTSvyG2s7n6rrVDoAaPcfjnlWXAZUncSMf9hCsV8NFlfrzArSe5EeBQbMfeA2Xqgonz1acXd0EMEDUS/W95e71q6W5mLKR8XZt6AhJAHBEWHen+bDGRK2//OliFBQXHfFy9kWa69dE0gfz+iSb5NsqOaB3XpEtwEQGQI88vbV2E1fgMhQDOLbny/a5o5ciELTFThJve77lzw9fOBymqbA3Hm6+rfnh9zkPPfJ926En40qnQ8XUSihiVx/AMxYCA3czV+NvdcK;4:7FF17BWFvg00MizJ+TqWfvBq6LjvmwYyCz/qwxqWVkdjlV1o/UwAZQclZlNiz7YxTC58YZsdlS3Ox2B1Ceb1Zde26LC8u1Gkgelr9m6GCHUmQLx38+BjUT9Jl18Ds02vmQQeufmHQRU2E0qxrPMPdlUUdXPkk6YaaLpFSk4kWu+gjlVA3MpbTzS+AmsKDWZu7BGuRzfnY2VuB1QyqDEHw0XPmM2tdINE5zJyCGS33TvZxGK76ElbdMEaCNANgSqGL8+D3dpdFjtkkGNFqKbdO8JRRlaVq4CBHDoJGWFJIywStYokSty8sYKAAhfFRQ29
X-Microsoft-Antispam-PRVS: <AM0PR04MB429031ADDF58EF085337FD76EE1E0@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(6506007)(81166006)(81156014)(8936002)(14444005)(50226002)(478600001)(16526019)(186003)(106356001)(3846002)(6116002)(105586002)(97736004)(47776003)(26005)(68736007)(50466002)(48376002)(66066001)(6512007)(2906002)(5660300001)(118296001)(11346002)(446003)(386003)(110136005)(4326008)(7736002)(6666003)(476003)(956004)(2616005)(54906003)(51416003)(16586007)(86362001)(305945005)(6486002)(44832011)(25786009)(53936002)(36756003)(8676002)(52116002)(486006)(69590400006)(76176011)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:K7c/0WtT/ILa4Irj1WikohINOha9fKSs9TjMsX/99?=
 =?us-ascii?Q?nTjTHqgql4sDolsBQPU5GOeHWj8Y3/u/ecRPcIG7n98e8JTHdDZvePbdvjWM?=
 =?us-ascii?Q?y1uOXSnoMwiYr9BK0ySlvyOcEUvBNe9m1zOX/LKCtnu4UQSG8f/a4I9uQFuI?=
 =?us-ascii?Q?NqMZGmwUp1ioCGuHngIKu4I4Mt+kUSBwJxIRodL3xkBi7Wo2zZlp03kyYyRe?=
 =?us-ascii?Q?FTtXw/3Jk63kfePD+EQt3lkafUMLNNPANlFi6zlksq2b2slZ4v/qDs156T09?=
 =?us-ascii?Q?jUrCu5EeiOHfQ4fQxCdPeXTGk7sN5tGBS7B4PqlY7QyHiP1yq0b2Z8kscMN8?=
 =?us-ascii?Q?KSREw3XtfLi5boYAnpXEnHl5hOoNf0UWWmqvwW816KAa1Cm+ttj7V/lk82bS?=
 =?us-ascii?Q?yAeX9cmA95zs+Vg463Sh//j31LeKUivMG8qU9A3+ORqPt5ZBWWrKYt385dLm?=
 =?us-ascii?Q?QGS9ykj94nRBGVUZi1SKfwzfevPwv+mdklf4SNf79kdAzJfSCRj7eWcuAy2C?=
 =?us-ascii?Q?ZvQeLZW5AyEN8x2ugpr8KiGf374XLeSPVyaaMpqKPFlRPtRhlvpCCrxwPQqP?=
 =?us-ascii?Q?hDj24KpzVvh4kuR9Xb7HurfpiWxvdI7kOzNsq+AQaAN8mjaZhMz5/Iehx5ES?=
 =?us-ascii?Q?GllhfqHYjhCv6hjntPG+20IRb6KZxyAy/kLx3j4htbz+for+5X1D3qUqc8yF?=
 =?us-ascii?Q?l98f0r03Zq6LBr6T2OJ9Psog4VkD2HxPrO4AiQnFmZ3DrSHJTw7XG+SduReB?=
 =?us-ascii?Q?TPkyXNR/VjDNWg1/0f97UV5VF1oLRa9eQbGDMxJ542M5mzBIRnKDO1PXUDLd?=
 =?us-ascii?Q?hHu4RdmLCAH+Xzk8s3vSobBNRlFPu6sQwFP5uRASpsY/9t9Jvg661Ep8RMEk?=
 =?us-ascii?Q?4AgUczpcXBJWbKVDcqw/uULc80s75/Vc+uOpnW3QOUjk0ZxP5CSyfx96pZND?=
 =?us-ascii?Q?xopPoX5X9oE1lrtyXA91qhnkb3w4CkqKmTs74zLbZDXmEH7+yN3FTyS1+dM8?=
 =?us-ascii?Q?mnunGU9Nh83+offsMGF09tTwBER73NgJfW7q5G27J+MGS+XGMdD2YZ9Z5QRM?=
 =?us-ascii?Q?XzVJtys1BcUQhD9pQAaSkXwvxJnP0nyhgDb8EPwnvhn8H+o/Ft1lV1ozHO7Y?=
 =?us-ascii?Q?oBPE1Ju/IHMEKn0q4HLVaL0Au+3pdiCiOMscMIJOHkC+/VlX9lLtt8MsuXxC?=
 =?us-ascii?Q?dkVDGqiep7hiqumSVWnexRdMuSlg3lIIDIcZ7DGEUm8Nyg1bJeoBC+0Ae+qJ?=
 =?us-ascii?Q?40KF6JDKv941Fj5BujsCb9s7/Tsm6yVRA15o4mPmPwox9zOD/3XdIdWxsUfV?=
 =?us-ascii?Q?tgizLEMZjZjDpnQUZosyuQ=3D?=
X-Microsoft-Antispam-Message-Info: /IbNs3PEk6+qaQ/Ot/QQXVGxVwD7gvdZNoxufmBJOS4td46JF08iP1qb0GjqAjoEzJIbAT9Mlz9CaTTuiI5dGCVq1y2fUikC/WnU53GfINGqBXHM9CsksYtnNQm0vx1ijbwHu+7lZ6VvoWy25AGsuMrsfboLMEMmmwdD+2lS5tBDhRXcH2I1IbeDvNeZEOZiEl4P+dsJ2Q9sn3hmCdvBYL60trELQCi54FgXT7AxGslKA5CySo88F0bhFv749w/aK4J/xZzhVOfQ8ep3q/cTaYHfPwQL4pKf/tL7NLwQ11jyczlbilT4/1cMRDv5iE3HYS75A9Dgiw+MnGI0VcuFDmFJgu9vSy83+Kz40sVsMg4=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:5BmhiX71XYwMjVx3lYYlFzxOAIZHqXFhXjF/xUoaIsxgfpM7oGTlTLCjd7MyDXwrBc4E8Z4AebI2O6wdgXC0Be6A+zU7G5PvIa0CtiR1WIhzX+pZlaGefnYON3yliNFeirhXZnhs228GcfjLWXBfSkZF+VRq12louqGzXtdcEtm3D5fjtIGNuB0H8i1+v6S6g/9HfnuamXd33N4yWdssG7A4R9f55easBPGOB6riVMorDNLDkKaXGlu39tbbZvkRjBe8+MBf/WzqLGw5ypUEE4Lz9tIVJKLmOx8VilW1fij3wE5834Mgg3aBXVv40aO2XfmrwuAQxd4v8GJ02swQt/fW7xP5bl+xdgPGDAPWLXlFvqNpp4qKShD6oenc8YNJpRqLik079bMq6Z4NfV9jEEoK7IMFxccxVxIXyZ34YNKJXQmtEaztrAc9AjS+Ed8/xBQAdhuICtfJebuG5rJ+MQ==;5:6iRzcB3KdYDZWBb+60Vx8rA49UrYQ+FUOv510mNMoYUzC2mEYgkipHufXQN5P6ytGrmT+cKZzmH2YFKdVNArzyXCpKIuYXzIOh74iH+Ck9HzOt4k2MABZIo/CwFBUmhXYSpSCHzrXi3vCndWouLSFMtY3vga9VdvzbfWLTrNHwg=;7:S9DwPALEGgKDJWijAllg7hO14g43lcG4gGcLiV4U0s2VOvr4rbgjIjhckM5r44xFQLIqEuWpN7UjFBWAnHKOCk6sh4JFdZz/F7PvpG3vOTWMMICLxDcJVYSuyc7SDp3A5XcbrD4QpiDPTZEyAozUu6hhuWZq5VmkUD97zADNIZsd9RsE7nv1cpEBMY+lAvbZx8i720Dy7VKbq0frFIRVV73C9psHh/tRreBL6SyiRdrR5kCx/w7o37uJHqeQHq4c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:42:58.7112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5141b6be-3402-4a08-4023-08d61ca37bc8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main axi clk is disabled at the end of mxsfb_crtc_mode_set_nofb and
immediately reenabled in mxsfb_enable_controller.

Avoid this by moving the handling of axi clk one level up to
mxsfb_crtc_enable. Do the same for mxsfb_crtc_disable for symmetry.

This shouldn't have any functional effect.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 0abe77675b76..e4fcbb65b969 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -127,11 +127,10 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 	u32 reg;
 
 	if (mxsfb->clk_disp_axi)
 		clk_prepare_enable(mxsfb->clk_disp_axi);
 	clk_prepare_enable(mxsfb->clk);
-	mxsfb_enable_axi_clk(mxsfb);
 
 	/* If it was disabled, re-enable the mode again */
 	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
 
 	/* Enable the SYNC signals first, then the DMA engine */
@@ -157,12 +156,10 @@ static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
 
 	reg = readl(mxsfb->base + LCDC_VDCTRL4);
 	reg &= ~VDCTRL4_SYNC_SIGNALS_ON;
 	writel(reg, mxsfb->base + LCDC_VDCTRL4);
 
-	mxsfb_disable_axi_clk(mxsfb);
-
 	clk_disable_unprepare(mxsfb->clk);
 	if (mxsfb->clk_disp_axi)
 		clk_disable_unprepare(mxsfb->clk_disp_axi);
 }
 
@@ -206,11 +203,10 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	/*
 	 * It seems, you can't re-program the controller if it is still
 	 * running. This may lead to shifted pictures (FIFO issue?), so
 	 * first stop the controller and drain its FIFOs.
 	 */
-	mxsfb_enable_axi_clk(mxsfb);
 
 	/* Mandatory eLCDIF reset as per the Reference Manual */
 	err = mxsfb_reset_block(mxsfb->base);
 	if (err)
 		return;
@@ -267,23 +263,23 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 	       SET_VERT_WAIT_CNT(m->crtc_vtotal - m->crtc_vsync_start),
 	       mxsfb->base + LCDC_VDCTRL3);
 
 	writel(SET_DOTCLK_H_VALID_DATA_CNT(m->hdisplay),
 	       mxsfb->base + LCDC_VDCTRL4);
-
-	mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
+	mxsfb_enable_axi_clk(mxsfb);
 	mxsfb_crtc_mode_set_nofb(mxsfb);
 	mxsfb_enable_controller(mxsfb);
 }
 
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
 	mxsfb_disable_controller(mxsfb);
+	mxsfb_disable_axi_clk(mxsfb);
 }
 
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 			       struct drm_plane_state *state)
 {
-- 
2.17.1

