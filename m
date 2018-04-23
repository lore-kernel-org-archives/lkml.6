Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbeDWHX5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:23:57 -0400
Received: from mail-db5eur01on0128.outbound.protection.outlook.com ([104.47.2.128]:6718
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754223AbeDWHXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:42 -0400
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
Subject: [PATCH v4 5/8] drm/i2c: tda998x: split tda998x_encoder_dpms into enable/disable
Date: Mon, 23 Apr 2018 09:22:58 +0200
Message-Id: <20180423072301.11962-6-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:szlMaSrzkSG5v0avTlSha/6VqlhdD6BjuIinG0oPyyY1y0SnAomv59yczDFbMHjOGIQyTpG58pdXLwVv3b/UYEsGMHemLxDYMpYe9Oomdf50V3ObAihsTJb6pYzJsX+YN1LXybchGYQoycYuQXGzb/MkxeY1MknTkP+TCFEdNrqg88/5TY8VKtuzV0sCmDNg53j3drkB1SekHxudU0eG63cwgo+TrPcoufCyfWiAMSJoFGxdFzkFQqlhkhsuN83c;25:86LmmjUN9uujFBUntRyaXV99IPl6TCDefng/DG/E6823jqTwGm7zsQvoF/tzgjIrJ+SrGtUUloUkuTZEHkpeNVgmT6zaxGw6U/TyxQugVeGvtqJIgk3N2wZD8BFcdf24rcv72QC2zkZtgm2UbLA9PDRMc5i1GPDUZkZ5eDOWQvm/XCPVh9nGznaQf0zIue1vBP2UwZHyt5vyKsvtRbRcakBe8r+rCYQdxIb+qBycF1ADWWBP2Q+QS+aauDrENMppb1AHi/9REdVMQAQYm3t96rf5CKwZoqMhtdyMCEmQ3lNtUrE5FWk0yAZYwAHAQJ9RQyDwsPpk/MYqaoCWkcidxw==;31:iz1C/0Pkdv/bKvhN7FTDZpLpZreWfwrMXLYhwbhRVCizQae3ryfa+eVAvW0mK1W0FhxuHlE2sJrg59eBkDLJ/C/K3UwOaSVBj+LWw/mhs7qNWQ0dQ7eg2Ep2E/vkcySuBvIuf55iBRf86b2AmhzL48cycfn9lQfAq0mXGaPPzqCUnCEoRmXjZ9GCmPRukC3L/8/al5GbcwDRTwTf1RfVsRbQahCZ3f30zRinB8/jsDU=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27744B68F8038CCE75CE95FBBC890@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:7f43RDzOD6COU6fNka6o3h7be46n/58RUggGlX8e40QxfZIvY4C1FdOYH6fz+nMWDdlZAGrcgd+nXu53F1Jk4Hnd7Yb96wSDKQfD3Kxxi1DuDMD+3aKiaCYWm7+eqHDD+7FUHKPJsuMKSh0YSMPZrr4CJgfq0FX0VVHKTcQylKxfcyINGY6vTs+8zyMYex11Oj7pD0Fi9jVN2KKbs+PDF++fB4RaxAM1cR08bKzrSycM/Fl6TGmU4ui3QxddeLZKRI0DhhiVZbn5knP3P/CB7w==
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39840400004)(6506007)(386003)(2351001)(25786009)(2361001)(1076002)(26005)(476003)(3846002)(6116002)(956004)(2616005)(11346002)(76176011)(478600001)(52116002)(66066001)(86362001)(2906002)(446003)(16526019)(81166006)(48376002)(5660300001)(305945005)(8936002)(6486002)(6916009)(74482002)(36756003)(7736002)(53936002)(6666003)(316002)(54906003)(7416002)(4326008)(16586007)(50466002)(186003)(50226002)(47776003)(8676002)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:dRETeK2h+o8ghDnNHXO/XEJ9osHQ96rUxr17grc?=
 =?us-ascii?Q?5dG1rA2zqStBOY2WD4riGZ2BfpnmDwmZLAyDxe4k1MqQuOUeJ1tF9bFJsbOi?=
 =?us-ascii?Q?e7HE8H65ZXrj2/8LCbKyL5oA5RuqGJiZ5vn/AvSoB4R5GUstd0VGoEdowoST?=
 =?us-ascii?Q?yX2JizvTzA4ueuMx2EJmmQ2w/Dn+AcFCJUtK/qmFEa9B+6O/9XsKy5GtDDac?=
 =?us-ascii?Q?Kt7infhU3d2PCXSWKjz8CIpsUcOLuQANapJ0cq4wUSOcO8n3ywHdJ0cT2pGw?=
 =?us-ascii?Q?H+JOO8IYmjo6mDxQ+cqcwPjxpSmPEigVeGDMjWzXEI87zU5nAcl8Ndfltuko?=
 =?us-ascii?Q?ju17VFbeV2d6WkodHMsIGlrTpfETIp9lRCRGFYSaviiyfFTWo4UGEqTQzmOk?=
 =?us-ascii?Q?BBRdz84Q8r5vKDaAHwOOkZGAJcG4ZSywbEuTULq8M7TlvwN8XDluPlX2HfjV?=
 =?us-ascii?Q?RY2P7qy8j/7cPRxYHQFlLXN+CoB+q36wjDf4Ogjapu9ILFkSMNgw3GIsP5bn?=
 =?us-ascii?Q?p6AFxEmQEr68IoHR0VRIsA1qtbjbjO3EZW45HzSZRN9MOeXdMMRRWHH8nnY8?=
 =?us-ascii?Q?fzp0nKK+PomnV2PlfDpwcdVQ5u19yhksXFlE69/Lyd7YGa9Mp1P/MXN5a2y+?=
 =?us-ascii?Q?V66HJGlVnXrLADj1VRpk0/UkBLZ9WaXO3Dt6Dhwm03/UybCBZEGtZqpGU/8q?=
 =?us-ascii?Q?9VGFOEVbcz+owdtfqwJagNyU42/ZXN8qsAwP0fC/vv9oDC9GnrWM8TmKEyUl?=
 =?us-ascii?Q?HHM7ZNjBPTsgjxm8wMZJ4J/6TehhSdCRNgrmAS3xImuASB65iBy/pgu/LTEk?=
 =?us-ascii?Q?/Fc5qsjwCaZIeRHSUiljJPS+WKbFnzw3nfd9ayKVNGXK7IcjGUdHWmdp+Qi+?=
 =?us-ascii?Q?EM6qS8ljLJYDlUt+bKnrOlbgYjUM6AeXD7k3W76ok9fpcB4XIysoEGOlcJwP?=
 =?us-ascii?Q?kLYX7dxTgGfsTZDXzb+tjhQ+sNI0WHL+gAX1HNuBn8IN0gtKqGt5Ja5PHJiv?=
 =?us-ascii?Q?AxEiYQDJ421ZGUFsCuNH6dbtRbtiD+98hNB83XIGLDbDoCx5q17muTHSAbk8?=
 =?us-ascii?Q?luw5NLSZgh7kZQvrVQbOYY5VI5o/ybErxPWpLFch2IpnHisLT1T0WoDRYoAC?=
 =?us-ascii?Q?wo6zbpmUFZpwgdJf7s0HYwMfIlKhj5TUE?=
X-Microsoft-Antispam-Message-Info: c9vrg9kiVWupvIH2hHzI+pP/qItMJsA08kjKVNdF8mGHpg2uQv0VS7bMyCC7vdDymNtpqkB6UKHDz62bDiISfv0IC8TcdvyLNFHO3HlE3iLNsO7m8o/jiiAXB8OpXjsq9XPpg2DPYQQGjPfp9tzkHJ+WjKvF37qbcyJmTlfxy9caI9deWeHYzpZQJaGV0Xa9
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:LYuJmW2eCvYJ/UvHCffUzZdT6qD+7gMrI4CwLUIEoR0NDV8PqRcaXGP9uFP0gq9YU3LIu+VMmwicqy0mn/DaZ9Czdawmfz5X3i3Z1D0Zl8UEX1gKHGoLnsarM1w70oEjXod8vs28BdyIpGoQzD+/PiXQC3CAXsO5oI2+80Gi1ZoEBh/LeYcVD2baeqzuVh4SwNYCzZdJjYfkl1BFtqn0IEM5pciPOfjmYYxIMRFH8/1S197WApAJNt69CNSws6alKQX/yhrOiHfxM41tkxGgJqCbphEHW15bkX6k5lUeDklFZdNDgdFHwcMSfNdRD/LLvzjmY/N1L1E9rnkyOa2vhiEjkma1fx8Co0eI/X5q7+O5EAf0N2eeuEC9T4sG6uXios2uzTlb9zpx7PJHG1/rPkk/Pedz+M8EIg2AbtcRTOXLIyLBbnTtCBxcaCDtyJWIQnL+KTpO4fcF7aIxsS861Q==;5:YeYO3WTVBoROu72v/fQBh7RxbR3s+ACb6OXgStp4pvueD2mdIS/wzgKbqjIYS+QW49Clx/Z5Xd+4LyKHyjqkZCYP5hDwnArwmsWNC0yr+uGknilxUkji3n/Ih0dGnM2K/qCEJ/B1IlJLYPBq0qSHYvIPpUeg79jyKiMp3v12lSo=;24:2zQgaEsS1kaGiq5tWq4MQu+S8dMA2137YqWI2aldKKFnzgFv0yFgHkBPCT+E1YSrL7ZrEyJ+6TZcwMB4bFaXzZCenh0x8pAKoUDy5DtxxJQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:j8kjDUTGWQtzf44QLUG5gKZ1aXL/RcD3yQt+Gci7afqdI82aEYO7uuyqjAx/yeCEjdv77xM/fdfvo5Da5nzBlis5sUnjceWMg+ny1eQ0ONlcPg2c50smhs6csX6RQWSnQLel5flvXThUJih75i9JfiIs9xSz+Az84QdYF9adJ2g9MaJVK1CGA1X7ChyHZobnIqyukaqM67N0sseg6rspO9sTEiFHsd7rnv/2tCerwPdyZouCB+4y0HrnouJxfP5a
X-MS-Office365-Filtering-Correlation-Id: 6a16faa1-1f9e-4a2a-9001-08d5a8eb232f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:39.1863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a16faa1-1f9e-4a2a-9001-08d5a8eb232f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
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
index 8f6e013f2b87..f9028d567ec2 100644
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
@@ -1607,12 +1613,16 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 
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
