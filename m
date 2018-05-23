Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932230AbeEWJcp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:32:45 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:55616
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932229AbeEWJcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:32:04 -0400
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
Subject: [PATCH v5 6/7] drm/i2c: tda998x: split encoder and component functions from the work
Date: Wed, 23 May 2018 11:31:21 +0200
Message-Id: <20180523093122.27859-7-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:ikEklB8ajNVJA2lrtQaS3MNAJlowpsUwgDs26j1XEW4SD9NW+a/7CVn7ncZnbmfLlLlQ/6KhsNrFBjYff0UoMpK9TyVVElTEgY/aJiliTTlSobevaqICItPj7Qr+JgSN2uq9VatNYwJq7RuvZeoPu62PPQrvJtcnLTca43MgGQwyEuKZ/wZH66y46GvFmG9BR5YgOhg3qRww1uBIm+yBmLnYnH4DWx+cFKnCd5mRQfeIWJvggb68ElWhfybuqRj8;25:N8MHyzRwWe7FfDW7bEemX0IIKGx7C3/YaX6JgnJZDfnONVEvOSwmQh9LjvYeXc+fZQkIxI17ky4KyoZ9WgxNtGT+c/ErUYNG/ooiwryNSko9j7cqE+NTnUZt4Aj2sUM2zNthRXC9HJsxczS/y7QuFSxAqkQI5TtZAvxirm1QVv27u9mW2Ov4IAQ+kj0iLzNwkSsPgnDxn/c0hIpkfHYpdVpThVrpYoZCC1HoPGh0jM50DRWxZ/U/24fPrmSrFJikMIdZv0Cw/yBZgP2etVsXpACWG3HZu0P9HIajRsi4L8KsKkYXkBoC/C6mCFrWLu7hG/92Qwb1usenLMGVkU9hVw==;31:fPHD2P1jrHJ5b4H6zdhHA1eorErlWdZMMCnqKcRkYt8lKGH01o9vc8+QFXyu9Uet3yaSh9j2jc0arUw2opEVPTJgpGFS8dbdm8c72PDXIBe29/3mIGlhORxfFQ8SZ69Z1U5HYOx9O6G7R3GGMboc6Ln8XKqOayX3paktSYHGW2y1KzBQ+gJE6ngIk3eAjpjfCQUbQLfGkEVIPDeiJlrCGAKsSGONsusV79lP+hnm75E=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278251E082D70D53624EDED1BC6B0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:RTddQUtCPzgtWsWxh/GXDnw9aKqjCHCWHWlAdyS8enCv711ZQrwh3uVCCxHu6obTfzHP6R8AVdJqVxopP+KJIWIBBwflXUBPAIZVnPyH3p4QTwaWUW5gyLmWvOocTKgzoV5ecot+a0X1RK0nwgU8o4tYsDfN+479ViC/Vkjo/EJxy1yMOKUeQQIxe7ZL0mwO7nEVx65yctWWGgr3Wii7fULycBT+NzXSWWDaVUt1T7h+sTDOPn/GeVYEMoH04W1256wD3y6YciDwIHukTeXqSA==
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(39840400004)(366004)(189003)(199004)(486006)(68736007)(956004)(476003)(3846002)(97736004)(6116002)(478600001)(2616005)(5660300001)(6916009)(6666003)(53936002)(2906002)(4326008)(11346002)(6512007)(446003)(1076002)(36756003)(86362001)(16586007)(7736002)(76176011)(52116002)(51416003)(25786009)(7416002)(305945005)(8936002)(6486002)(2361001)(48376002)(106356001)(66066001)(74482002)(50466002)(47776003)(26005)(316002)(6506007)(81156014)(105586002)(16526019)(186003)(386003)(8676002)(81166006)(50226002)(2351001)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:WottyMq9eEM2MxgulYQh4yrT68+e0Ijw/X2nDJv?=
 =?us-ascii?Q?A81Wl3SOpVkOUhJCoyKk28qLf8NNXOW1hX10rS8MQImjsHirZ6fWUv+anh70?=
 =?us-ascii?Q?sxNkyjSAXN7WXPwNKU80EhJPf1Xhnm67o7xwW2bj9tvkuROCH7USZ0bQ9xyH?=
 =?us-ascii?Q?hX+ex0URHsszwKGJPDNOUc31zN1UxJ9xRWqBGWxxWTpgNXFgzsNueoa0HK5d?=
 =?us-ascii?Q?Kex7hjfsd5Vfif4RqMvlhBqnfzoLeJvGGB88RIPuS+qf8LLBe5OLf2WPhFJn?=
 =?us-ascii?Q?rqoBs8/IEl1Pba3Ol05bAcU46tpnJyn2k+xN1Vy+NaTude2rdzRc3k91hrHi?=
 =?us-ascii?Q?i2ALLsye2sfFGStWGAREXFrlo9wJQ1ie8DYGxHLkEiGAbE+pYEFqF1FPvL+k?=
 =?us-ascii?Q?ef3oQUbMq+EhG9MPeaD93nUsIdmpqbKUCqmRipW+yj0oGD24Tl9UilzAlOXG?=
 =?us-ascii?Q?hkscaWZd1yNduNdZ/J72pX4WgwPmqWN/n3WwZnW7wk0u6M+qDtFTS+YxvAVh?=
 =?us-ascii?Q?QgcpqzievKWrZlz88j9HDbBoG4Adpfi56Jln5wCYhIoFp5DL5Zz1XBZbRTwJ?=
 =?us-ascii?Q?5V0WuNGtmfgc4HmzIC7vqgTMkDrG/qQKSflaZytT9v7ssohcnEs5beJq8NOb?=
 =?us-ascii?Q?mcdkFtPyUcCXkDsvZs7oXtgZ2P5TvoB8r38hPDzrPqnYtX0fb1M5JAp6Z3D7?=
 =?us-ascii?Q?boKSca0YdsplwdjDBrYp+dl+MB8AbhuREWgmkWUMWW0rgQ+j5K/eJdCFdQVQ?=
 =?us-ascii?Q?NlsGg73vA/1s0/JJuXY+f74gPgmMhMCHiNU9lf6TdVi9tiMmSWVpcL0wXaH/?=
 =?us-ascii?Q?LChIP6eQ7P1yZyIHXkRO9xJOJabJ091kGCNS8CJwhp+Eq4Fxihy+feVICGy6?=
 =?us-ascii?Q?MAKdTPr2S1WDnapokQvGFrebSbrD+kC2aD5fFSyitNoyOWMG6xzU/VT4VQv1?=
 =?us-ascii?Q?icgKozNINcMwAA+YYHiq5lOv727/LSM2B1t7z3ucS6VYZ4/eMefLlIc8WEzh?=
 =?us-ascii?Q?PfiSF3kowQJ8A+UittxKavNuKBoXL8SOVsC58XtLIQ67PcgNapR1cjXmIa9L?=
 =?us-ascii?Q?4RnPFlq4EH1TiurUCaHc+wy1L5aX8xAvo8dNc3H6WLzM6M4h6ZzaJTi0GCTz?=
 =?us-ascii?Q?cRpZzG6yTSXYQRehOCE59rkUSyPBoC5ag6qVyty/n4wCFkT+XkKh+QRRpph9?=
 =?us-ascii?Q?m9hljkERGeAFozi88i4q4BeSYAMCLQAM/9lcj1C7A4GYFIVqKidqYek74Yka?=
 =?us-ascii?Q?tMholZOe5VdRvkvGAvDLxSR1Yvm9/cF6rMs4J12nTUfsOdnlnLI4W0nlmNaq?=
 =?us-ascii?Q?1vxvJHtJBXvr9KL83epkxFUA=3D?=
X-Microsoft-Antispam-Message-Info: wMTKcXThiAC3ZiuUe9GNMk1KWJ/cTMGCuWCLnCVCkszaO4c8TqIuANO+tGF3pADF49F2Chu/CGKeAMX+lsvCcCC9PXwnF5SpBvMP085eIRTo8FKW3Bo/tJQDVhpGj/TnjKgd5WqXLjrWnu9ZZ01xUCkE4/mMhkfFpUS4r7qz3OktSwfX24UgDgUo7U/lZijY
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:60KWXKN1LOd6Tdx07hXNux61vCITKsslt8rE0BQaeeEqoSPo52dWKnPK3dm+OYaqfmGX/7pkAGsMx7xojaptZXDwI6h7SYsYu75wxSGI71KKZhYuGO0xuE8Pf+y1zcIcT+fIM87XWFwRSovBOayHNQGU2uwbQD3tt+5sWCLZhO0P06MtjIly1lVoaiPI8K2Tv+FiJb76w2HBaejE0QglpvFj7s8m4jLrPmoQhBHwQXe1ZsuuHd15gJXZkWoTatR9dJkLDeM9lgTPJKFZhhrsTvIxq/Esl78Gg6K48zfI3WgzBfqDqSSGmXjqOGdiwKVDzuw7lmCH7J7YLsFtc8hhPwtptPjNOXSpey5/wa43hx+1dveQ+++kNzr7XW3OjO9yRtLHzeqNmnXb6nhUajK5Uu/0RdFNAOys1lzl7KTyVEmw9pSh6WUX5ubiKepaII/NZFZRbEgzQrb+W5tG1ZIH+A==;5:Rxi2iNE5ZUgqzWBjeBydeSMQfpAgICk665aW4SdoyEgnieuwKh0z77VHhiR9sdrF8HCTy3QJaPGk0w8pGfsv+3ThDmiSJsaSc2vQn74U3tclVQwV/LiyXLL7uRBi9lq8z1uOzGWghFnup6aJ+dRqJln5AoZ/7JvAoOe6x3OFcX4=;24:JuC6y/r8cG1n4zUwNGfhXUK6HQtmsbzoZ6S2koDWbDAGBKl6AAtVaH9G/iUIrX1MpIHV2aGCaktQGHfdrCyw3jFHngYgRJpiI+w0S1yX2fc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:kG9ViRAgwitxva4mi5oyawh76qHfZBkqBo0wTNSYZLrPFeuR2R9dkD69nt/ljdtijX2uYC0xqVlyW2WoLWpnJwvL3c8NBJxIiKjwMpt7ERMASC3zy2ES6AXKlkc1JjoYdZ5W69H9CQKq+plCOg+txE9zufyrp6ftYx733WzxOJ7KEuVRTTyDTtpbgiOn0oR/ihXITigtXp0CpisaP+SmNNI7tTv4bh2g2K3PDG3Cd6YMSXk5zVF9rbDxyI/VQ2rX
X-MS-Office365-Filtering-Correlation-Id: 641eac58-5354-4208-f61d-08d5c0900850
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 09:31:57.8421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641eac58-5354-4208-f61d-08d5c0900850
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
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
index 3dda07a2fd2f..d401b3d0095c 100644
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
@@ -1662,11 +1671,10 @@ static void tda998x_set_config(struct tda998x_priv *priv,
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
@@ -1714,8 +1722,7 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	return ret;
 }
 
-static void tda998x_unbind(struct device *dev, struct device *master,
-			   void *data)
+static void tda998x_fini(struct device *dev)
 {
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
@@ -1724,6 +1731,19 @@ static void tda998x_unbind(struct device *dev, struct device *master,
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
