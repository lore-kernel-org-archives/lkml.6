Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E7521771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ezsAgSuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E7521771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeHHS35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:29:57 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:40736
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbeHHS34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTE1j8BGjhCZ8z3SdfPwlXJdSA2Wtao+NQ+Q+0lN8PE=;
 b=ezsAgSuW59mmUtIasMtDjW9ds8PSadbXLtVP2KtI8Sb1SAypmdh/03wrMMG9yykGWcONZGPzsNRZaoOpJJ55AeNhXtr6GQGRwuu45bLdV1yx2/2MVQbOs3RmToxXoh9gmkSMYWBXYIcFfzp0/6wuU7pEqg1n/ZYpJIm+E6Hyums=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 16:09:28 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
Date:   Wed,  8 Aug 2018 19:08:58 +0300
Message-Id: <f0d719af219a7f922bcc0746e9f840c471c56c5d.1533743954.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533743954.git.leonard.crestez@nxp.com>
References: <cover.1533743954.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:6:15::17) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bf0034b-2334-4404-87b8-08d5fd495242
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:1CXoTL0BWH21EwuCrwzl1W8qHGo/GjQrCPzdS8wIZpqrypHPZ1QcrdEfJCm1RUQp76ELyOLtl498bBfSy+uAk03jU/jjiaQIb2Ce9CH5BJmjzoDQjw3cEy9d6n2uXsOiAiTNHxPpNa1PrWklNEHu0HulCq/NQhDOTb6sv/HGVprwBEgA/kkCtW8XtWJFsuIGX9nS1IXRfrR2SSZX82e1ZqGw8jkjb697walbJmppZfgwrpWosit0z4W8Vus2JzSo;25:Ew2XYCtAoW6PJkWpTt2yOnQGDStKG95VmVRzBoz8+LkVod5+dTU5mV6TGulGPXkl4fdLrGGaTMrNR3UpfQj5d7wtz280MXhq4uq0KCw8QffUpb7iWp8NRoSQKV2oVH7YBAQeiCLI3/mvhBtU7KG/ccKcWE3uXFmONWxPnYIIgW+Xrf6In7YywKF20jQK+H2fQsJBITBp1fwlz0CI+87zgkLZl1kbnyIoZ5j+zZvQW3YaxlCCJbcfsAlkMgRXvMwhVmMs+WHA6KrOPzV2nA5d7f7o+6/WBNK+DTS1+YVymU0zm/mPmfyzZSDMKMUMdOz6aDTXLC2cZx0054cG0MFiFg==;31:I9wfTpKG72+MnnreYN3erBfKLkTvs5VAlU6nyXPxtb0iP2fsCvLaa7daXi2qCKg9lGp+uRhaxQ17H/I2VZ8JA0keE5UawHfgTGMl40jDPoXlGyMbmXXsXonuHDxZoHHybg80Ao3IT5RKJrFeUEKnobxy3TTk2EAH62YD7VxjE24BDgdUhZjtVyPfmzc4e6Q5PMUlSBiZpNO+zS6PcKZ+JU0xxJjutIVeSbUc3PnWLZg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:rgStXdGoUFUfrVhJqdUA9G1SWSt4NqstIuiFYOaTCrj0tV5JIUAbrpX6Iv5R4x4Roi6DIlcUWFCwVppO7ukoVw8Ap4wBLxg5JjU45RuNUD4u3QtcQLtmrcpEWzdmaPfoewhZ0eGrAF1+3+fcNAJSTDeFCOICPm4uMdGZ7A/sQWMyaMMBDAxlZYkbAor3sdcIWBVYQQ0BWlgdnYeliR6M00JJp4ZWv48BPYPkzPdm8SAO8g4CnkFkHdKlLA4U3rdPrBCoso5WX1fe0+nuiM/XFmoX2SraEnKoz75Ud8xckKX+7BCuSBE0sn5uA1J4uiDB5N9dKOqJH2w19UUTmLka5WtkG76RZPcI872D7p0rUj/B5+BFDm6ToAhqt3BSdVctcbSBj6zXO47ZopdNaifkxRca11ROFByeBdRud+GXkSVximVp4cM64jM13CDEhJhXszcFN1Ni1sjmjMA88exR9oPJj2+bcyoR3uLlJQ2Ob3Qgx8NtY1HY4Bf02W4b7zU6;4:z2J9lSLShTezbALpxorne2uoOfr/SIoE8r0ZLMoDrjD5ETqx4qIwi5+aMAlCvsrg6b2Fzt65uXE8ZKUgi5IqL5xEzhPteYSxGVsHjz7wu7XPomnVo865mAPYBR8H/iELH5UwcjUTEFQM1mcpHJkxJuLsbSQEjkBJhKjPGG1Zxs1nW7G5JFLFDLvdNUtvzHlO6sG3hVOuryUO1n39UV6/NfJC2ikSpXq9FVdgbrZMqjQrao9pwf1DfALmx9wKQe3h1Ffw9klNNYsPzAS+Cx4nwjy28BviLWa40hYUErRQXK3yiv3OuZrDaitKV/FKhxdI
X-Microsoft-Antispam-PRVS: <VI1PR04MB43013A5EFB8AD30AD2BC9A49EE260@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39850400004)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(66066001)(7736002)(76176011)(47776003)(6512007)(81166006)(68736007)(81156014)(25786009)(8676002)(6666003)(110136005)(54906003)(36756003)(14444005)(305945005)(106356001)(105586002)(53936002)(50466002)(6486002)(97736004)(48376002)(86362001)(4326008)(3846002)(5660300001)(26005)(486006)(16526019)(186003)(316002)(2906002)(16586007)(6116002)(6506007)(44832011)(478600001)(8936002)(956004)(11346002)(2616005)(50226002)(386003)(446003)(476003)(51416003)(52116002)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:fJT+Rii10Ok82ttUxh6BrIsfJno1u/ScY6JpYs1Tv?=
 =?us-ascii?Q?TPuEzhJXwhMCF6RakVg8h6bui3LI/0S8BpGbmK81oR4KDSRmfRLPAtRUlWYb?=
 =?us-ascii?Q?1q5qbEj9vzQbsdVopxNEZCuXQhfYEX9ibYQ+zfjbsyxOd4E3PkdotWUCbDfW?=
 =?us-ascii?Q?XmpaTcFn9FasNkJmMtwh6EcVsUzJg2ZNoiVNM/JeMqLtB03qNd+OsU4n/2+f?=
 =?us-ascii?Q?Q9nnWyoqMtsBdrbS331U6PqpWX7ehWfPM5OL+i5PWKmGYtTShoWXIPTuhMKj?=
 =?us-ascii?Q?XIoGMHQ+fv0mOARLB9zjYtLfMeWJ624cLWyG50RqqS0jF3JiARB384InVqqw?=
 =?us-ascii?Q?BIS2lipxvxmxk+P5uV+RQLzQj2e5dJrGgNcVnpLmZvaBeE6sG0WVvG6oqx8x?=
 =?us-ascii?Q?ySbVlKfxSEpesILPO+vkotHyJr4KuOZK72GWdu/6lJWySKndtFTMoqe5kM0o?=
 =?us-ascii?Q?yOQazESkHxrrJcBkJO3AduNUQPlEJzHiukWHnUEFjrdirRIFPi+JjwFMhh6c?=
 =?us-ascii?Q?rdkiCaI6PnR5JEx4kBqhuedRlLPa7BS+j6mrw26BINzC9xh2AgbOAdrP6Wm7?=
 =?us-ascii?Q?OcY8VWGuy5aY4/aNJSTGB91RcnS0YTNxD2a1hNLx3UbMU5Nh0/OCQVKDovjQ?=
 =?us-ascii?Q?ufnBY0WUM0Vxc0unEs+/XWFAlPQNbMNXzvGPwuzbMlYBb87CJ/5W02qyRNdq?=
 =?us-ascii?Q?o6ElK7DmxlW8huEpKkM+E94ffdX4SepGpL5KdrKxWk2jrj3WEAAcUzcrtBmk?=
 =?us-ascii?Q?0xvcU8w9j8cjX5NEjv/ISuHCdlfin7lp2MX1llCYqTB1rW4p8l7Sq9nzf2/X?=
 =?us-ascii?Q?NoyfPl9v9hAkZz3D3o/kMasRa0R+Kf/nCrYMY8KRrfCXiyQ7z4we8660IChn?=
 =?us-ascii?Q?q8Ro0oP5BV9OGKmCCwBlJIpPEz4pUpSGK0sIIw7sa8vkEeEK99vpLaDFXU77?=
 =?us-ascii?Q?C+7yNRCytJRwgrC5IaHtP9JrHb10z106JozOLEtkx6sh0p6/YM6/YtkHC98d?=
 =?us-ascii?Q?IuVszV7Z8N5y0JkVJ5j66MpfYJmAvPAmmq8FRTupUqJcTfjXoPadIq3JqeRT?=
 =?us-ascii?Q?jBo6Oob29fwvjN2l5HeZD7wDHLdwookrCV26TzUue0cvr8YBEbj5YqIkKhGv?=
 =?us-ascii?Q?ktOo22Cd2kWAyRi4/PvJprLwJJxDO8u+ZvtGwkSCdT/tg/xa61YxlEq5vHJ2?=
 =?us-ascii?Q?eVZhZtpK/KYi0cZf/j430hTrO8j14CpdZomuwdlUMAn5WTeJLsLcghcRKOWO?=
 =?us-ascii?Q?S3MAMYrxWaIhR5tZMjSpcJRMd8rJHf4f49g4fID?=
X-Microsoft-Antispam-Message-Info: BUATmrf5NWUgPTcHYDam8E/wvo5b7seas3XpS0qryJbgJktD4iO8rhmE2Ip+9Crz4l9RTESmiKfdqCguPwK4lJYkmsdi2yYNIt6XezcohIeN3nYaWLcsDe3NHDAam9LK53fxg3CsBbyBoET8Jqe1PgjB13NJcIkLSJIOlC34woXnCoHBaOuoS5Vf0EG7uEL7zNx0D+OhLaVE4Otd8/1JWyL0M6wCBfhE5O0vWhYPlxZPrRH0JnsZY27bTkyHIffeBLRckwUgO1HVEdGTF2jhutMDPpxA6ErjsCQNlZFrP+k9rxZTRX1lkMyqrV01vzH07rf/ULTc3bglwGTTyxM5Ei7crpuGqKa8JyMQAGYubq8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:vdXanvdgVO1/zXbEazEIsrEA4V4QyaBcl2lnmZro1H+MlBJ7lVJwqSrHkZaSe7aEDnU5qQnj8y63Jpm+1/HCe8PHe52PWN5RkaTWcNP22ThmQn2h3RJSPa62bYQH6RTXmCphVP+kOzKCQg8Y6DKnX/W5+BcjoDEPe85wLhrl4RkgxRvm4auvCLfTEHgPinQOcyXWrK/EO6fYIqsGsDjr0yPbKe4p9mxssV5ojYR8Nh5M2GOsFJOYYiuMXlBvztsIY4u5GFeFbe1E7oe+KVlk1Own3dYyYCMhrFj0oa+4RpG2T/bZTZYGqEkv8O4gyvrNu3ainwUFwrImru2mbEBVpBCfrAES6KjAS0wwEP8NxvzSPHIHtSPA480tw43Hud3eYorfs58JwI1cqm9cmNpetRwMXT7+1I606eLttXDcdLRIsTpD4aqkp5Ydg41fev13zZRVOTmoPGFVVoCaTPqUow==;5:75JOA6qwalN84Rp74Pi9qrEh3GObHby/ZW6KG7YfwH/XbF2vuAtR8uUx7A20UbDW+9Dp//casZYdXH6JIgg8j8DpZx4ONHCLzEaT/YdQk3NhO6c+P5NhCFzSDmCjKR0rlMtOVAKad664pDiOGzeZETfNbomOA3Pmju1fbVDPHIQ=;7:2TLuhXsnk1bK9X6u6JHgvf/KesDIQ0yI4keNMWnY7YjO5HNOR04O4+N+zFc9bI9BHyUBL9jz7hu5MgSuetf9MpTC/aRGFr2RvLH7B2ZWCjniNEVqW+mbs+HoilFJjb/Fgu/Iev01c8MKoM4DQ0u380iJnbDSh6VUGo7Z0HUvKV3oQUBe5ntaEHEHQW0v4D3Sku2fOktWir+zInex33Vg4TEFu4959b+0QVMNNJxV5wNJWw/IE+q+FzJB96Xeh72w
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 16:09:28.4199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf0034b-2334-4404-87b8-08d5fd495242
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main axi clk is disabled at the end of mxsfb_crtc_mode_set_nofb and
immediately reenabled in mxsfb_enable_controller.

Avoid this by moving the handling of axi clk one level up to
mxsfb_crtc_enable. Do the same for mxsfb_crtc_disable for simmetry

This shouldn't have any functional effect.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
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

