Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbeEWJcJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:32:09 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:55616
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932307AbeEWJcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:32:02 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>, Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v5 5/7] drm/i2c: tda998x: split tda998x_encoder_dpms into enable/disable
Date: Wed, 23 May 2018 11:31:20 +0200
Message-Id: <20180523093122.27859-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523093122.27859-1-peda@axentia.se>
References: <20180523093122.27859-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::23) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:1kIKAFzdE3dtNrW7rAaB24LncUKP8hz3DBkWrDrxfi2MhvS6Y1X81TedmNnUhyFgaY2zv97EsSSVe1ZddnkwtH/p8IL8G8wXWor9uCMTYtYJZTXtEhtG2GXcKsoj1OuV37MJtBHip+fReHmUCbBHhW2vNR9AzrodXM7gPU4J0hG7TlBL8Ycj43Ky0h39KrjL1684VjhRJneRj6/RrFZ7lPyxHjOwwPPiBEB0/3u5Vkz24T0nf01oCisqUNXmYvbb;25:hTqzlhO/xMRani+BI23BQpGI4MPAKLvaQvyl0IxlzMnhS08fRHFZE1HRVqk3PgFEhbpSj/7zT018EjqZ7HqgrNq13j2vl34yjXfEAP0JtLq8TQSkxywkxW/5BFqMyL0HWs7IXLQQ9ZIp7sYbuiE3ry5YQj3zhlQ02QVkXGFhGXHhoFto501ap4nTJLOnR/imiDRppmPsQgx1nBkJfwH/XIjHv5Ce9j9yJQspsmyrP2v2BUN1D99vQgikh3NgWRY4vQxwKa069YOtQiL5EPwlcbsMuI+CUYmr0IjmHat+0thsjrKBObqwxOlyCLMKyrRleDiizuDYcCbOpV/jlLDMPg==;31:82IwzKONrhM/E85xmX3P7wSMmD7myWSzteYGtNQaKeV3sTayVrYE1rIdehcJmej1KJ+4XhGzl9m98HaqPjnpPVabBtzRBJxCPMHbK/aFtkkPSY+KrOM8RHxGDjIIVa92s3bTh8y/9rBfEJXbvwb9dzRR+pC3ZSR4XADI4Sd6SwZpP4y8ZYT5Fn2hIK77wD8Zwu/sX894mtguanFvW63vq8Gl0g/MvefGZXH99oXWOV0=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27826069DE1E925E14D9EFF9BC6B0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:cYaCC8tNEXm/BK/5N3iDudraWPl0d6lpUaATJEwgDerSax1/sOFJX2A/rB38ToazTp6NcRE84b+sKxCiIyml1ax/pN6641xG66700JdX5hAEV8n90WkgmrnbvIZT067/jvi4D2AqPYzFK6Urlx0cSoEUn4+YVG33yYygReJXsOVV5X7KXw/lEeL4VTZdhJ4jubh2UljVUaGJjClqzBxPF6dlczyWkvlLsTr2LjilDM6CTEGvb2npcE2z0HPIqB8qp+SdpSzIJ+Oe2XCEqCklRw==
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(39840400004)(366004)(189003)(199004)(486006)(68736007)(956004)(476003)(3846002)(97736004)(6116002)(478600001)(2616005)(5660300001)(6916009)(6666003)(53936002)(2906002)(4326008)(11346002)(6512007)(446003)(1076002)(36756003)(15760500003)(575784001)(86362001)(16586007)(7736002)(76176011)(52116002)(51416003)(25786009)(7416002)(305945005)(8936002)(6486002)(2361001)(48376002)(106356001)(66066001)(74482002)(50466002)(47776003)(26005)(316002)(6506007)(81156014)(105586002)(16526019)(186003)(386003)(8676002)(81166006)(50226002)(2351001)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:doJNn7Hjd4EQFj8k8U1h6nHAknMeysGp9H2gJMl?=
 =?us-ascii?Q?UcqAjaJhMSSEFPWeb+1xoD5d+iPj1RCP6HDCdnlxBYqP8Qto5PrX5JBbX/Hs?=
 =?us-ascii?Q?IuYTuA585BcwpiSW4YXFyZ6uPIrBgWoZdFz1N7Goow16xJKezoh6QWsIxS9K?=
 =?us-ascii?Q?uw6DCGoAkd40ykQrJVCohI5MJ4q9yFrA5b5xNRjW6WE8sZbgZfIao9Ldd63d?=
 =?us-ascii?Q?eZHsPszSgQDraXuxY3NC6/uCZbQuupFW2n0QKwOVqwV2i7imah7SNjSFiCao?=
 =?us-ascii?Q?2zI9T8rMsrZwB0FoW5jU2BbHxrDXZUxar3lHwcEkRYzgdw5d8dmBxNbUeT63?=
 =?us-ascii?Q?oHLw07jgashjj8Z4uc70Pm6U+/fJ3BSM1nEeMYSCgHLvRgzYnSWdgx5S/Oad?=
 =?us-ascii?Q?Mz23yW499hJOom1mVsX2q+krkBUDYl0jnNiWDOwmNZyS2gX4YamrdIxUL7Dh?=
 =?us-ascii?Q?35e6FScyXH47pEtlp67pHmAssDfR06dFgJ0WXr9REV9c8kgU06OkjcoQgNfm?=
 =?us-ascii?Q?JjAE09qdVDJQsh2BWWaKRIsZxvYg4mUOU8K36PeBWMuer7dvu+bZikyG1pHi?=
 =?us-ascii?Q?snXpUeXxQzFF6yYACi365rm5ET6cKkvyZe/FlWM4DTT6pMD+jpKr6/bimfA6?=
 =?us-ascii?Q?t3lfx7Kya2vDBHRsfeR3iepzrzEHPaSIpax/7JlyCh65ibOmfBmvHH0JPVVK?=
 =?us-ascii?Q?ZHKVQMaSNrula+2fHbk0btHvnE8n0qrSyVRZOGGodICaPNKWo9A9ByojhRNC?=
 =?us-ascii?Q?6qTWx/nnqcauxV/Z6Sbjs2K29mhr2z5KQfyrsYPYgE83M2UZLluXmAB+hFJ/?=
 =?us-ascii?Q?+a5eQ2V9qDQo8GKlhNUNCu7dY+nyRJWCKUga7yfKbnOSwrXCICW9VGyOkDCo?=
 =?us-ascii?Q?24xKHX4cqLBfA7n9RVraHg+IpSCBbRrlR31+SaOtMgbDEf3iyElHznz5JZ6B?=
 =?us-ascii?Q?+1v96kYzcJQYWkz1YgwCsrRHsw4haQgejVNYiEE6uMvz054NtFmNa2INkjCi?=
 =?us-ascii?Q?HtHvzfNpLavdxygooa2THhsiQgi6sqxyql06Atc5eHjPaL7B6gTMK3Od9oqG?=
 =?us-ascii?Q?Vji8/n1rbed9qP2PD6F+lY0zjIXgUAkdqA0q+H6budA+vWjBl0UFJouh9Kdj?=
 =?us-ascii?Q?DeOtAgzsbnHBX4/Gon59MGBHxV/ZQgTlsJDZrsFlPDRQAlO4R7TAN10VGGV0?=
 =?us-ascii?Q?OKiHrpAx4S3XurpdSDsNR3aDNnQv8mxTLp2oyILmGzos7RlWQrHC84IC0Zer?=
 =?us-ascii?Q?iSz566Yzk3Hqk2d5dLtaY+nk9gsCevVy1jAPbyCmIfuxB/uzJQTyKVH1SSLN?=
 =?us-ascii?Q?LhM5FgirjPi6nxNoai6mcji4lIx6XVftgwwJciiy6X9jJtR2Gy9ndlV07pGH?=
 =?us-ascii?Q?usEeGo/2KK10xuiSMDCAjRVE/O1c=3D?=
X-Microsoft-Antispam-Message-Info: 8KZeS9YHfnG9pa7Q/JoGY6xiqsKPMG6qvYDotW3KtKwoJK46OsfN1YPrBvaKJ7BmttF6mR+quROv5DxDLVG8S0kuOJiqO6tiZgVwCGYEpxZRaAx3h+Fnne+R1iOUsJbsYB/jJWXQ3yTCN/bZczhSLYjuGNwgVRwZtx4rrSevlVJqq64skKXPTCoBRsXUhHEF
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:cJD8azpJM5L5Zznkf1+vKA00RaCkJ4De7Z01fQhi8C3BPKmO9uMJCqouwSukWJqqIDTQ02F+NtsUr3/AblhmzjZoJwH7TeOcukGM2ZKK7AeKpUE9Po0LDdVvICV488UF2Jqzs+PKc1Bmf1/kLYVXGKxsIdnkKF7XUfsdkv+qtIcK1u9WqmNHv3E8rfxY2t8GOlqyU53etjF9D+To+4LjK+iWID+x2ivhqrAYjqr6jb/YaceXuazIZWacfpAm91KLxijS8f7/9l5D7++/Iz+k0AZIqFSoS8XY2PDknPV5vpNmF31XvF9k2C/0HS4zM7CZBp6tLjaoXbXflkLzMJ3K5xUkvUYz5pyOGpfx2BdAE+vzIoA9g1I0ZJxm4rH81iPE1nDSn5mrknEbV+UH7lRSytxn+1+X++cnMjMu4XaPxOf2pd6oA2hXjTdbo4G+xIXNtPK74eOR5R8/mTYWBDABlw==;5:SipBnR+VN2hNkrS70/ATv5LC06IPjBBjKkC5OyZSUaKqymcGotwyDFZDwN//xSuKsc/czqSiXXSKgq1IC7C4GgPlh8Lp0fM4FhY8g1Qg7zOcVGMIlZsjrprg/whOdYcgxfXe/Bp8Af87w6Ch/laHqbmjoK5SR6pqHMuKjEcYxGU=;24:ZQSbTCP6Az6WAoDDBjk4rV51A8wg07eky/He7YDYdvxZmth+wsvXlBL79WbSl015jYDS5X71atG8y2tJSgrcOVEUpN/cbtaDcgBGYhg1ePI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:cV0CIQMF3Q23qe5On/r/0EI3qJzt4KT6PrgioRrZCppBpTBOHV51DxsaK/4f5wDG+R3t3WsRoNNLEFi1FCa864lTmHrrMJn7ecVc0I2Lb7Qa7SZJ/I6hCtL5UJ67YwyqR/IWh+CG2/SiLGKxUpw16eX6ACJmdQZ125E9RGVKXih2ZvKZuWu2MkKRh2TJKxgLyOPR9pD0dJYFdM9hiKSYTLtfZHa09iwl/oLZDP6guiqkrXOm5XOsBLLARhZwZ5mT
X-MS-Office365-Filtering-Correlation-Id: 71878c4b-5fe4-4114-aaf7-08d5c090063f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 09:31:54.3733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71878c4b-5fe4-4114-aaf7-08d5c090063f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fits better with the drm_bridge callbacks for when this
driver becomes a drm_bridge.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 64 ++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 933d309d2e0f..3dda07a2fd2f 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1163,36 +1163,42 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 
 /* DRM encoder functions */
 
-static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
+static void tda998x_enable(struct tda998x_priv *priv)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
-	bool on;
+	if (priv->is_on)
+		return;
 
-	/* we only care about on or off: */
-	on = mode == DRM_MODE_DPMS_ON;
+	/* enable video ports, audio will be enabled later */
+	reg_write(priv, REG_ENA_VP_0, 0xff);
+	reg_write(priv, REG_ENA_VP_1, 0xff);
+	reg_write(priv, REG_ENA_VP_2, 0xff);
+	/* set muxing after enabling ports: */
+	reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
+	reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
+	reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
 
-	if (on == priv->is_on)
-		return;
+	priv->is_on = true;
+}
 
-	if (on) {
-		/* enable video ports, audio will be enabled later */
-		reg_write(priv, REG_ENA_VP_0, 0xff);
-		reg_write(priv, REG_ENA_VP_1, 0xff);
-		reg_write(priv, REG_ENA_VP_2, 0xff);
-		/* set muxing after enabling ports: */
-		reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
-		reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
-		reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
-
-		priv->is_on = true;
-	} else {
-		/* disable video ports */
-		reg_write(priv, REG_ENA_VP_0, 0x00);
-		reg_write(priv, REG_ENA_VP_1, 0x00);
-		reg_write(priv, REG_ENA_VP_2, 0x00);
+static void tda998x_disable(struct tda998x_priv *priv)
+{
+	/* disable video ports */
+	reg_write(priv, REG_ENA_VP_0, 0x00);
+	reg_write(priv, REG_ENA_VP_1, 0x00);
+	reg_write(priv, REG_ENA_VP_2, 0x00);
 
-		priv->is_on = false;
-	}
+	priv->is_on = false;
+}
+
+static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+
+	/* we only care about on or off: */
+	if (mode == DRM_MODE_DPMS_ON)
+		tda998x_enable(priv);
+	else
+		tda998x_disable(priv);
 }
 
 static void
@@ -1606,12 +1612,16 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 
 static void tda998x_encoder_prepare(struct drm_encoder *encoder)
 {
-	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
+	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+
+	tda998x_disable(priv);
 }
 
 static void tda998x_encoder_commit(struct drm_encoder *encoder)
 {
-	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
+	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+
+	tda998x_enable(priv);
 }
 
 static const struct drm_encoder_helper_funcs tda998x_encoder_helper_funcs = {
-- 
2.11.0
