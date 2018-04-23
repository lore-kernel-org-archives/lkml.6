Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeDWHYE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:24:04 -0400
Received: from mail-db5eur01on0116.outbound.protection.outlook.com ([104.47.2.116]:20692
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754235AbeDWHXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:47 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 6/8] drm/i2c: tda998x: split encoder and component functions from the work
Date: Mon, 23 Apr 2018 09:22:59 +0200
Message-Id: <20180423072301.11962-7-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180423072301.11962-1-peda@axentia.se>
References: <20180423072301.11962-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:7:28::15) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:q68z8Ifhc4IMW3MfLzbc+kpulTl/yRgyx312kn7LLYe2S4bzS8C+Nx/69ZBSf7z2jUe3etGi6P1U1Dp8bwpY9zqCuHQeISseQZTPJMfi32MkevPklri2kXbjcxwFGOdh5SstgZrQTgrJLlLBJt1R83zlc3s0CmFgyTCPeV64gRW/htqf0NfEkgEGiwCM3Hm2DdDXjyt/yOWuESbIgJHfaJFna6gBMMM6CyIehvDAU67Tb1q7REAXLpzEhcOrG9rd;25:c5Q+qVrDWot5T0+3ixhdGSf3CjbMuLzBrx13LkG1rXAEXICM2d4mQOc7IzUfgGqF7jaFMKlJacvLTa1NAXMqBPaSJ3zuh28Kh9Au4z5HB/H+v2AEJE5wlR1ORgbT5VqRBiq/CAykoL5Lf29aacUfAqTCp9tUowRpfSTrTd1yN5k6vjVZfXezd9YmCO1jKp0LVnUgNOeZKLh4NDxeHZtM3NP2KAq18iBTEcpkOmrgD1YE1OY14L+ufJyg5Qy11EMK1WbWv7sKLiSAG4k4sR7pil4TUUo9He7aRaa8e6IIYstSb+L31jTMY9bUCFt3Yrlr+2mQmgCqzyBu5NWvcUORjQ==;31:Xy2EI77g6hX1Pik2Qh6N7nYW1/b6iDputfaVwcvabxa34RiUgSiL5TrfQNwYqQOOfQxmAMOxQvDiW9P/1nrA6GzDZI2ggRDqv5cQoO7DRuckcBhcB/hRmp7aItNvV92qUTm2yKb+5HMU/q9yV0KffWrspjQTSk6YZx9UnGyudcMEOkFyN7Or8E14nn2hjGgs9jwBEgtw0Naz9bcYHOzdLvKk4SSjNlEu5w1qP4kkOAo=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27742DFB7DDF63B5DC3A651DBC890@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:K5VcwnBd278k0Dvia7Ak5Fh2X3KR7gkMg/Ca6Ohzg6S+ytdOyQjoDS/w0St9HkH6NUV4getGTs66oVmbz7uH16B5aBAiwss61iOWVERBVz5eAE29faMQQAAB7tKn/KzDBQwFwq0SMt2zk53GF8Ff24Dnz1ixgL7SclDNvwH2Tb9NsbKfBiUcUdRVnhAD6cOCikKSr2/CNsMRWXPXkIAHOOU4g23LOhsoDaet18XxrVSencnnU9i9MO72LN4XqF7UgJYc/lrMahH866jdCADYYw==
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39840400004)(6506007)(386003)(2351001)(25786009)(2361001)(1076002)(26005)(476003)(3846002)(6116002)(956004)(2616005)(11346002)(76176011)(478600001)(52116002)(66066001)(86362001)(575784001)(2906002)(446003)(16526019)(81166006)(48376002)(5660300001)(305945005)(8936002)(6486002)(6916009)(74482002)(36756003)(7736002)(53936002)(6666003)(316002)(54906003)(7416002)(4326008)(16586007)(50466002)(186003)(50226002)(47776003)(8676002)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:c8vrbgqCVXQcDkHYAA4VnrziNdqC+Zfumm+K2U9?=
 =?us-ascii?Q?3y30Dp6FG10snWq01UWL06/eWJJz7rUVHIBmTk4NmBqooN03vs9OUxL0kxSA?=
 =?us-ascii?Q?oFiRE4rIz/vC1KvhK/rxRfuIuhDuNZhyl4Q3VxHqf+L1XgmX6+EU0RxoVAyY?=
 =?us-ascii?Q?N8awN4DDnnQ1ZG1mP20CZsOBirYX5cxW2sd1wTwKJkBvGIaXBNjjSGKfJXLp?=
 =?us-ascii?Q?kFHTOAxMjlSjmjmBEWWHzIEJR3iyppl129FnDnTXQX43QWy9VlVBSWKWeDOL?=
 =?us-ascii?Q?BmrhnYTxXQL7LHwzCK+M5vaFul1IVwF5qAWe2iTZHx1fwennAqYKFxHJjEGa?=
 =?us-ascii?Q?RWxUYoo/r6Xbt+GUBHJifz8R/LqmPa/fjgb5tfkZY9Eyz2ezSFKjortl3AmO?=
 =?us-ascii?Q?jVDPoTzPi9MB5SLOQk/aH9Dg1DXYykOAqNWu/6NaTOjhd+o/HD3b7HK6m1fZ?=
 =?us-ascii?Q?P3IX2kMuUsgLeZU8+pIYyh9lup+/6vu2y030DH5n7/4GvXzeoCLV1FICSXc6?=
 =?us-ascii?Q?pE+Mhk0TtopdHte4IpmboWj2x+5gEiny3hVjxYt3PJK/AIGff8/7FuThuU/2?=
 =?us-ascii?Q?496WVTkYi6/M/gGkyc6OYYlvojVvH7B6gpb6MPixCZzRAB3pTYRC73D90YUR?=
 =?us-ascii?Q?qGWjr9jt9rmDvTm+oQNDteR3lyNAXepMrmzwkmQquUil3PIJWE1x5uGKXBaU?=
 =?us-ascii?Q?z8HjfPmqxmLz7jNVXpo72IZD3VXSEr8nz2Xb8AjI01IAxpO8vFl40+IGCLSr?=
 =?us-ascii?Q?4ct1yOx9PvTdjVavjRiUrl92F4tGshob0T3zCWzv6y7ufozY4GgtMVUa/wh4?=
 =?us-ascii?Q?HE67KyLYpa9FPQaCHvLPndFBeMOg87aUrMDe0Td2XNigszrspA4B7baWdF9r?=
 =?us-ascii?Q?M6Flu0Q0LHJytCozSewY6PMF8XMsSnYQfjDcMRKdodnEYLmjaECPIPvicGVd?=
 =?us-ascii?Q?63s5XAc2bmhgalY89WeYLENTYTAeXfd5QMwxVItJerfFzMJ0OzYiB4hm2FMZ?=
 =?us-ascii?Q?Rty80F1E3OD42Sd9PdpDFYi5egH4AkJO9waMBdOaZUXHK1xglHZTUbXYBQq8?=
 =?us-ascii?Q?Q/DPGPb1j1tBBO1R6MTK/pXJOE+Qsf+JwGb/TAjJtXzLYzFTAwCjuRPq84K2?=
 =?us-ascii?Q?hDgKNjHY/xCoR5XUNox4+M7j20uDsBvjIJbv9oaOueCgabzphNwD5gw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: zzoqr8ymN+k1RCUlN5qDfXPKmwDqcscLcBWBQY8WXmkCtlGpQXUYqNcfcHSlRhkiBQ4WVc0KVMiql7bkN617nDJFlRzQgEXP+an/0H7gfUqviLXyNrBQA7HSBR3N7HzY6uuco0sqU3e0gz3FStGIPcOXaOqM3c9vPRMUIRCzUIRVDQgGtIUfESL6j8p6NAhh
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:o0BLR/Fw5XDHXNbo7U5Fj+Enw9pLZuQmFVbaZzTX8hbXWq/kjNMQ6jvIhRJkwsYYuUoqQNj5mk5072vBye7c1DfJo2kWFAOS7DvKaOen78bkUaOcEmy+ZjXpLgJty+0Ms6N6q2RuzphpmrdCpyksAMXIHQjG+VWLfha1CHoonB75n0A7PA5PJXWVM/S1/gMeDs0om5YAj/TyRzAkwSDHwPHX7e4olwJt4B7k5hiyjrOqzt0G3XrrHzvSwOmUoEG39j4MrahztObMMCD7A8s+h3wgijx1ewmOdQ1717jkI2xw2anoTS1D4c3UsCpdUtytSw8I2wi+sRcm1nKRmxsyNzT59EDXqxmt/g67vojHBmBt6iqrjjugcw0YNKz4VPhKEANu8ncdBzc0vwMmbB/zIje00f147SXNb+nOzLvSOLVJ3VQVkcCuPxdasNyiWfHkVLSV2ZyaEINawHZDOqMhNA==;5:Fo5XegqNLUiSLZmcMlKJPCDrWuPBD9hr4p4jJzU18EO4ksyt1H6hLCMTl0hsNaHliFv1xV8M9A/oS2TpboUBOeLZV3DmAtUeeW28zcuFSMAyKtU751eJLEWBiSI8nVxDlwfLVIPkmELqoIEnu1+qF1rPDW8xnhoex+CyqxugZHs=;24:YZElxBGFnR3GJ1O1L/1HwrtEShlh1OsNZHUJWzX74Gag644vbLvAksjAV4pnNVVPMOoaEB+g5qb8bZeFuw/LeyLl+m4l572QCSGNTmtTdy4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:Ii1PspboUTF6PQvAyH4elZxUJhoiwOBdfi32a1rrgGIZu9wDU6TsOZXqRiaiCdUq+vjXfl28PQPiHGsalm7q4Y1kKP7CrD3yjDYCB3qXkKvJLJXcs0ALXHK/rod7ScKhhtwwVaHQ0yX5QKeE1CdBSeKNWZQR0xUVYB6ZOCpE13ttGATueFDr7nzhtQlmQjORukGLJONX97egcH3Wqk5dTNj723oaM5mICmehTN6tMEcYHr9TrjjPn7tDJaG7ahtE
X-MS-Office365-Filtering-Correlation-Id: 0bb6a3d5-9c39-4433-9657-08d5a8eb261e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:44.1081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb6a3d5-9c39-4433-9657-08d5a8eb261e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables reuse of the machinery for the case where a drm_bridge
needs to do the same work via different interfaces.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index f9028d567ec2..53fd0be076b4 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1202,11 +1202,10 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 }
 
 static void
-tda998x_encoder_mode_set(struct drm_encoder *encoder,
-			 struct drm_display_mode *mode,
-			 struct drm_display_mode *adjusted_mode)
+tda998x_mode_set(struct tda998x_priv *priv,
+		 struct drm_display_mode *mode,
+		 struct drm_display_mode *adjusted_mode)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
 	u16 ref_pix, ref_line, n_pix, n_line;
 	u16 hs_pix_s, hs_pix_e;
 	u16 vs1_pix_s, vs1_pix_e, vs1_line_s, vs1_line_e;
@@ -1413,6 +1412,16 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	mutex_unlock(&priv->audio_mutex);
 }
 
+static void
+tda998x_encoder_mode_set(struct drm_encoder *encoder,
+			 struct drm_display_mode *mode,
+			 struct drm_display_mode *adjusted_mode)
+{
+	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+
+	tda998x_mode_set(priv, mode, adjusted_mode);
+}
+
 static void tda998x_destroy(struct tda998x_priv *priv)
 {
 	/* disable all IRQs and free the IRQ handler */
@@ -1663,11 +1672,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
 	priv->audio_params = p->audio_params;
 }
 
-static int tda998x_bind(struct device *dev, struct device *master, void *data)
+static int tda998x_init(struct device *dev, struct drm_device *drm)
 {
 	struct tda998x_encoder_params *params = dev->platform_data;
 	struct i2c_client *client = to_i2c_client(dev);
-	struct drm_device *drm = data;
 	struct tda998x_priv *priv;
 	u32 crtcs = 0;
 	int ret;
@@ -1715,8 +1723,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	return ret;
 }
 
-static void tda998x_unbind(struct device *dev, struct device *master,
-			   void *data)
+static void tda998x_fini(struct device *dev)
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
@@ -1725,6 +1732,19 @@ static void tda998x_unbind(struct device *dev, struct device *master,
 	tda998x_destroy(priv);
 }
 
+static int tda998x_bind(struct device *dev, struct device *master, void *data)
+{
+	struct drm_device *drm = data;
+
+	return tda998x_init(dev, drm);
+}
+
+static void tda998x_unbind(struct device *dev, struct device *master,
+			   void *data)
+{
+	tda998x_fini(dev);
+}
+
 static const struct component_ops tda998x_ops = {
 	.bind = tda998x_bind,
 	.unbind = tda998x_unbind,
-- 
2.11.0
