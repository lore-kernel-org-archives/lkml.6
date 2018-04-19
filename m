Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbeDSQ3R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:29:17 -0400
Received: from mail-he1eur01on0122.outbound.protection.outlook.com ([104.47.0.122]:28384
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754063AbeDSQ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:28:43 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/7] drm/i2c: tda998x: split encoder and component functions from the work
Date: Thu, 19 Apr 2018 18:27:50 +0200
Message-Id: <20180419162751.25223-7-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419162751.25223-1-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::49) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:8Qy5gxzXcvv4w6e79/Uj4GPFwWbrXbwlnIVPTmmoKfCyqjBW+DnF0T3ob8wactjBWZRcZDeB72jg+dPAR6P9e5/uuxHNxmntbGE+xT42mE/ACyvE/1e3rfCAYR6SbFWm/BRuGwXw7fxVKfdDyh4i5Zb8Eys6VRBJRXGkQ8AhpEMs3sn9uZ5GUJLiQq6uuu1YldZjicXkqTNClZ8BTRsNtmQMc0Be3BbnDbC0bu5UNTJjr3bJ3GlQ5zItjBw1SOQG;25:ctyf+skmJQp/bUZtSgFftcPXycEGtEZ7ZdygBSsW3ulUYbYll8ROV4FF7O8eLC8xg++ax1+Yy1Xn5hUxwjZGcmyMMnlwTagJLtEGNCfdYKjv6A5c90dLahTJ9izrEEWtq9sBJaDwv+7jRTUW3yfrYrkfWT5rM6E4J+rFhwAz1Hzomw+fLD+ydjdCU1TLifjJay8YJzxhapRc1YsN2VewOvRzUVb9h64yRGhgPOJ+eREMy55bZOknU1EnYRfhPIeBSWfkVYWwTS61Rqs3U5xZZhdl7yU4RF4PjkF5SXbS5oKhqh+B8idJRwpDqykKEZByBJR+lSYlMbUdkRZGuEgEPA==;31:rHFu75F721heJBo7YTuvx5AmADZSqRe48aJ4YyaCpBX8dfPYx8N1r+oyn58JWVC38yk/kROxk90buJOuskvea75B+zeVo4dWtp41gO2IPK6x7/d1BKgf0KwibarQPHOMsibg9TgT6llFmcn+9zOrpaePiRfgC9wzY6Z4HJppFcKo3DFtzwEg6P9endb94xCVbLDjqEnzPAypnpVqJD4Yyawk61j3n2G0zt5wobX4RH4=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784AEB382FC52F6846A025EBCB50@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:U8WJzCLfhGkiBH6bJW3HZS9o4Sl4xPMCtWoeu1cSPb8rZ04H7y+i2ZUhBWnmiCUeh/XzYx+17t4WmwszuBqJ43UDQujRcvF7KsxDyZ7hBUsF/1zQXiy0PkcdAt/ajHWUJA5ASejVbk0HBFdVLvudPJdp0nY72nV3LTj5yI/fgpYUBdISs2jZCRdNn8AQ0Wv+fQGSgzhYkyO7CLARQF7dtAyGSkfZcg5JxRU9b2ZyIg97wGuyAKE8fessBZ44ytkyais1YLKhKvmyAtci6mlZNQ==
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39840400004)(26005)(86362001)(50466002)(50226002)(8936002)(6506007)(386003)(76176011)(47776003)(1076002)(2351001)(66066001)(6116002)(3846002)(2361001)(16526019)(305945005)(186003)(74482002)(11346002)(956004)(2906002)(446003)(6512007)(52116002)(53936002)(6916009)(6486002)(476003)(478600001)(316002)(8676002)(4326008)(2616005)(36756003)(7416002)(7736002)(6666003)(48376002)(16586007)(5660300001)(54906003)(25786009)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:m5kuKaJMJ1mKI8VnBzRmjz4dKwm4gfTRe9U3nI2?=
 =?us-ascii?Q?/TqYpLIeB796Gr4qMCnmtVX0obHRZNavJsaW08JABJfyqPxrbQ0R/1jdnntB?=
 =?us-ascii?Q?ny7/0KAwF0mfp6WlDRzHkChTJIwGvXfE8Ti/sF9GCyGosY+FVhIGTlFEFuqn?=
 =?us-ascii?Q?KzRtf1O+vENU7XhI9g3R7Z3IXXVeEgESR8anMLdQgrKdzEFrJsWfkZ2XTMyh?=
 =?us-ascii?Q?dK/GbQ2m/4Ukw9Up+gPEtSWC9pPhRi2YBg8YuH6YS2we+CR64/Hg4u/2U5E5?=
 =?us-ascii?Q?Nm3fiejbWD6wdVu0F6ajtXqp7uLpNNrFowY2Ymk1gRkG3422gDjhQi163XTv?=
 =?us-ascii?Q?LwPSw0w64oUfhOS4G9oVS05c1sos7OFZuh+3wgJOwS9oQl/mUhx7PN1Mq3xw?=
 =?us-ascii?Q?WTAaC8GlBKVY3D3GCnQzYMjmuXaAjkBiEkRaVdd0+ICAOxYHxbD2a/Wn5Mt2?=
 =?us-ascii?Q?TO/ucpHxmb3JIR+U/x0xtACrF+wOuE1HnVLmBpwNPWdlSbz30reGfF6RWaQ1?=
 =?us-ascii?Q?nF9rWYKQEVP71pgNeSAbJ9S2+c1MF/Ui8YsmoktNzX7X4sxkOyCK7O0guZAq?=
 =?us-ascii?Q?hrdTohHdlCscG/P0OCf+pPwHgCq+o40WUmxnBRkkvUOOTlqe6kSFMYq5fiET?=
 =?us-ascii?Q?uTC1swlXgIeMw4H8DfeEGPpifk48tL125HEUcA41x1OP4k+ZT7FliPNoAvIt?=
 =?us-ascii?Q?c7bC8r6YqymhhLKQcIhiVPCOX7mH11v43s/fU+ZpPGnvvsr50nhcC0A/YS/l?=
 =?us-ascii?Q?0zrmBYsH+CjAOQCJ9OI/EAMQR1zBXlrvw5ctFD9obks4I5pkfp6kPs09uBB8?=
 =?us-ascii?Q?HBiNCPLiFk6XXGb51bMAWYUrpIQk1cmxx4Ap0/QL/D59t++NTHGlJ4nRbvUw?=
 =?us-ascii?Q?xiYCV1nVsXgKutMVQTKfhEHVNghoOnazlLJLFbyXYOzDlbrG/zDKjoiMXBgn?=
 =?us-ascii?Q?9nmmD3TqFq9B7IPeSRozKu7bhWDluqeujHeTLkXJv26KoqU5a0hD2xK6P1aO?=
 =?us-ascii?Q?07bntdsFAUyvQdtRUYS5wAgR9Fhnv2OqfJGGD+liR+FkM0wLI4a97VEZa8ef?=
 =?us-ascii?Q?m7bCtK8n/5xdWPGV8c8kcL4Xh/0LIvhEeMYq6buy8o474PIbU5I5c+kDmFmO?=
 =?us-ascii?Q?9G1IgvUwTV/ydJBawdm9A7xjxF4Oy7rpz?=
X-Microsoft-Antispam-Message-Info: 5YnGPLmQc/n3csueHfevJpVNARue9LZURb/0tR7NgnD7UaCAJQF3H1vRez96h2slL+9Vo8RH77Wav8SDdbUkSI6ph7fEPn+RNpidxXcplaGr8KXLh7pXDoIqwZeaX0sL5ZtRtwrKSdWV+mJ5vW3HJfd1j9r93JYgPhWafpza8ZN+QZzpCaDxsSpdI0+XXO5X
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:c5Iouky5UWdd5SZo/devb2uQ1T6LkX9A5w7kaZ+QlgoIFNbyqKAndkb/HN0qMnttA1doY775hXbjNWk+k+9vczKiinagNTeuHnhkNMJxYCL2TP122w2GK2i/89r+9gEGkhM7DfVXotLwbFJlyRj3z61VvLsGVpKAbOXgftxgb5tyUQu6qj2prsA1ZrF0nvfSPPKpi0MgciGvi5uwmUBeUFEVHzbsdMpsYIBZIJG4T8e6KLcJFQS/+5L1g7W3cXe3DZMiaaZNzFYoNdSZsrttKb+92eA11exPAFmknzSP5F6kFP4sSc3diTTv7Y3CqbNt8vsLE3ifh0zrikN4Z2mY8ixVZzF7zA+kal9WWBr6QRemja9GMtRqFkRiViB5ccsm9nwDlgib1i/RhgJDl32BBxvaO15UR3eS+0cPfqNcxXBAaFSBN/uv4tgGRNDov7HabF463iktsQF0TZoV46gGGw==;5:GZgR/rnH3+qImWnRi7wxtGbbBkllGo+dyeVHv/3DBConuXh782J6vcD5EgVYL2hMGB10tTb1EVWEqEjUh0Xb1FLneoBM/yhefQvHwp6zY1Nw2HFrUEFz2UMnBHtyxdqn824VR7ESOljL4XrFZH/KW0lAxqR4IlEAeJhZQubmrn8=;24:5zTAiUP+OYYpPetSFfJcQ+hSDO/6e3caxELiW9hQvQKJiu3+8Rc5+CpGDPwS5xWqA1wzNfnUlv1ulGJwkk8YdvN0OlEChNdyVOfq+QCpJ3M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:aeDQYvPtCt838N5RMX81lti2kYXLYP3FWPwsuRp7ZCNWdFhylmaEjmXtRjuWnjV2t3sjwv8kQfQdZ1JUByxu4wWhpNQt4h5B/RbdMh4uzB5u2qRIqZ8htSH9b3RS8zwHEWEtudkSO5nbLyRbnX9i83j2Q1Umpxa9R6v+UfReg845ECJinNQAJUXp1CEDv5+A2de99fBYJsQN8VzHXxFAS4HW9lgwlmmx1f4uXy44DRgBsrs/yBD0Y6Xk8mWkh4vx
X-MS-Office365-Filtering-Correlation-Id: 1d03b777-037b-4ac7-977d-08d5a6129c22
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:28:39.0365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d03b777-037b-4ac7-977d-08d5a6129c22
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables reuse of the machinery for the case where a drm_bridge
needs to do the same work via different interfaces.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 46 ++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 8f6e013f2b87..9c78f7bde49c 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1163,9 +1163,8 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 
 /* DRM encoder functions */
 
-static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
+static void tda998x_dpms(struct tda998x_priv *priv, int mode)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
 	bool on;
 
 	/* we only care about on or off: */
@@ -1195,12 +1194,18 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 	}
 }
 
-static void
-tda998x_encoder_mode_set(struct drm_encoder *encoder,
-			 struct drm_display_mode *mode,
-			 struct drm_display_mode *adjusted_mode)
+static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+
+	tda998x_dpms(priv, mode);
+}
+
+static void
+tda998x_mode_set(struct tda998x_priv *priv,
+		 struct drm_display_mode *mode,
+		 struct drm_display_mode *adjusted_mode)
+{
 	u16 ref_pix, ref_line, n_pix, n_line;
 	u16 hs_pix_s, hs_pix_e;
 	u16 vs1_pix_s, vs1_pix_e, vs1_line_s, vs1_line_e;
@@ -1407,6 +1412,16 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
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
@@ -1653,11 +1668,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
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
@@ -1705,8 +1719,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	return ret;
 }
 
-static void tda998x_unbind(struct device *dev, struct device *master,
-			   void *data)
+static void tda998x_fini(struct device *dev)
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
@@ -1715,6 +1728,19 @@ static void tda998x_unbind(struct device *dev, struct device *master,
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
