Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754340AbeDWHYM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:24:12 -0400
Received: from mail-db5eur01on0096.outbound.protection.outlook.com ([104.47.2.96]:14240
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754293AbeDWHX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
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
Subject: [RFC PATCH v4 8/8] drm/tilcdc: decomponentize now that tda998x is a bridge
Date: Mon, 23 Apr 2018 09:23:01 +0200
Message-Id: <20180423072301.11962-9-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:Hy5q6oMYbZGTpNywpJotGI/2DboGdVid9VOdfg4px9jYrwipT+TnHn0IcRF7GlHFXn/n77ZEmeGh+n8tNjz00OcbkUt5PFNWD1ZLfV7htHyBmiU47KexelG7EGSqDNMCCnTTLzr46JRUCaNc7tKo1E7uOlayNrDJeM62PYutqLOP2GDTU7vZVpmFQrrbhvfIaM9gFqIQLlSWELv9LBs+B4Se9pcu4HGVpa0afrIbtUoU0Z95+Mj3Im78aaqqc5rG;25:N+HXvZkYTIQC7sVZe2GLJLvavpg4RZfeseewB4jM6l33aoC9rHEgUVHyWonPJ38l3l/MW1yoSUvFgp4rV+Ih1relmfOt3qv/jRdp4tTxy09Z1+5027ghN4BGkSsDehLEJeSeA6Qkrdi0IRIjh9K3F2GIXACKK2fpliOjmFYkEj9+GdJGE8VO+jW1t1+DrhW27yzKuvg6HsCZfOSw2X454Ztxq7C3xtuL8NnHAuf6SSB7HbmndjTQ6u22/Afjts/dlUgj5jhTuOg4tcYJu4xgorO30d1SUvcH4dVTmXD6RnaT01R4O1Z0zJXTsxYBKROBYG07U2S9tasMQjZ7is/pAg==;31:7yxLnBlv/gstF6Uhjgw88ukZ03W3xGb6lyvylIKx0EniBj6o43+uxPXVfgsISwtuoS2r2zBGccjfmeSmclZyxgGYgy8Cmgv9DnSi4pJkXnSUokTZSubSHYaPravSNLp0sX8RW9GDanYV9MMcaiWwjptcikT2aRjQZkaxgV2R1VWzMsPvH83VWqN+ufytaaVYwyIhZg+mBcKWUT6yMsMryrQSPmKFQKhEXEjTRlb6LJY=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2774E52F8378F9BE1C2C1F46BC890@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:+i8A78WtKo3o7+serKL2bgVPoZtKKyeTA3VUH6TpMwRAoRjT/JC/PsEiaGrUJv3pZgl8jstt4KuZFXfICjpILJYdNNpv+QHfURPo6UTL39KPN7u7HAeGwPbv3v1K+a2Gxk3WvNABZ9F0qbGCLpOFAQJUmvz+gWn8Ttea48e6YbDczl0mrF+3nqvxvOmScvSHo9gglxB1Kk1vIYnYzdpzA4ASRPlqdfx/lv0fZK18ISIE2chtZtTHeazHTGxL6xyq7D066Y4Ia5IjXSUkVFK32Q==
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(376002)(396003)(39380400002)(39840400004)(6506007)(386003)(59450400001)(2351001)(25786009)(2361001)(1076002)(26005)(476003)(3846002)(6116002)(956004)(2616005)(11346002)(76176011)(51416003)(478600001)(52116002)(66066001)(86362001)(2906002)(446003)(16526019)(81166006)(48376002)(5660300001)(305945005)(8936002)(6486002)(6916009)(74482002)(36756003)(7736002)(53936002)(6666003)(316002)(54906003)(7416002)(4326008)(5890100001)(16586007)(50466002)(186003)(50226002)(47776003)(8676002)(6512007)(42262002)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:zDXXQyMSA9B5kqbSMZ9moRrgb/L3gP2CsfqYEJx?=
 =?us-ascii?Q?PE/b3fx9z/gQxilVu0OPH3C1Fo2l+dl8mt/Edn+uo3zG6mQZ4BJT+ta+gtqV?=
 =?us-ascii?Q?yfbIdz9QJ5gh5u9JGZeLAklEzAeRSd++XX53Gn1tCuhrh44EWw2QHUIkWp4l?=
 =?us-ascii?Q?Zodcla5EdYbWSfpyiZ4JwpDf5TUynWi6YFgG41aRO2a767hfJGFOtgLh7TSl?=
 =?us-ascii?Q?u821Hs8fCLMU4xcT7sW0sfYBflnsmmYGjl45AfuQ+fQTp/GRfU3Na5epVRzY?=
 =?us-ascii?Q?KltU2O221aCbfo6mFwmnPnGF2DjaUewH++2Omr5m/bG2/C5cswbIyLs1BV4k?=
 =?us-ascii?Q?BUvVITGaMLncMho9tEKpTuX2xKXnqJ0DxjWBW0KOfwwFXnn1Suai0bteskYE?=
 =?us-ascii?Q?IO2Gw97oafyX5hp82hcxCB7fSFC6OAigcFG/1lT1Vq6l72HMZYQ44ggQrw1+?=
 =?us-ascii?Q?FMLibxV/VuuVoWkynIJiitLwcKBq/uAJHDA43bBb39tTCuZ65kwHLR+z6JsX?=
 =?us-ascii?Q?0HU7y7Xcg8puEhuAK+CYa8oJXXn/+qKDdkLgS7GnNOMP0tnZNHYpwrpzOeSc?=
 =?us-ascii?Q?y3hsK9Bx3EWi5/TCcPfCRrAShCE884j5ZUzNSoKgGwTQLHt/yhyW+nCgmpou?=
 =?us-ascii?Q?HGb0wtAuBwCa4ieFQ287jUtQazCwP2+KBwFGTXGH70PM20Qxj0e8nIsnxvHA?=
 =?us-ascii?Q?+4ZtwZLcjpOvDKs2v3RG2JnJggqJcKcxTEBOHiWl2mibUdQjj0eXeDgTsI4g?=
 =?us-ascii?Q?4YTBljd09u7YJ5HBmpTlNHsekbYV6zmAJFrlexy3rktpAjGIrDX2k+zpTGFE?=
 =?us-ascii?Q?M1ma9KSa7HzsGuEDRVoZLywyjYmJ1nhxD/nYJ5bfnkbEvoSRbYw1z/Wo2thc?=
 =?us-ascii?Q?9C5W+B8tc1IBCGE3PmZqQezRKcnid3c8s4xPXKpAezBxpExKr/x7twmXsJoV?=
 =?us-ascii?Q?agQrAakzeCQJj/v2i2WYk5ao/AB9eYewnbeMP2bCZ7x/fR+F4YBYpX1yn+vk?=
 =?us-ascii?Q?By7s047YShQinky9HLXeVPOkj/lsqGqZXVEgTCE42YUHTUlzNKA3yCMrjk38?=
 =?us-ascii?Q?wud9R5geoDU9SDOS4dJjlHCiIHvcapd63MuQ3Q/7ttcIupdvy/PbHk/8Bu6u?=
 =?us-ascii?Q?p1FzTeKGqKjX2S9pi425PkQ8It4nvEdX1zQB/W+/7nOGAaUkXL5LxfPKL/PE?=
 =?us-ascii?Q?ADxI5I01v5CIrnuiMS+chJFEhJwYYeTuOtWQbXmvlzesxS5JSQQVyUB5HESB?=
 =?us-ascii?Q?tskj3N0O9YS5JsE5Bp4ewgc35uQiPgOs3zsxVnDzRBpVyDc28Q54Dy+F2wXT?=
 =?us-ascii?Q?jOcj0NscmbMtyCPBxR3TYYDBHlf9iZMdIxSwCCD2Cpcqw?=
X-Microsoft-Antispam-Message-Info: OTVZcuPkJSLKSEaEI+WVsDcBpkaJKELh9rNi3Oy5x2cQrVDiLvnatLQY+ntY3TVzdnFhqM4A/yNfdryYJrPC1VCJd4mUYm6OTsBJ7UkgI4y/KvZjTga8PnGl8UlrWoEYOcELjCgellqd/sJsQtpuQ6PHu37CcntT7Jr5De6mFf+cPm9Zk1MQt0M0+I/aKo2n
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:Ttqt4zC/maEg5PhWvpnbj7F87RiIw02whLLaIVqQU+K3WqYnOwzR7+IZmRNFumKQ2mIzWYSbho5rPSloM92ABVt/5lNCqc8MSMkmKNjjdHeA5lcT3jnY63oRn36h/95lYY1rAFRcS7+aH0rc7i97zhHzdeHMb+4hc8t6taHOvLH80JBq7togYm9k4Ua0YNS8b++3B/45wvpFDg6s4k7N0PtCKAJRf9JCnnzPhoq6rO+TetJbwZSsmFCleA92cj+ubeEYwwbM+n6LiyIHDm+BUJdx50gNB/f7/FZKkJ049Fw7Gp42QN33otXxshNLcebEBJXJ2pLF/CS5mnmQmhsvJ2mVUJXCKznZp6Qo7KLIXwgJlGmtt6ZCXIF+XZofiateX6aDD3tOlZsa76xFerLZLabZ+LW2wgfst0GXqT1D1qBTL41DjYbtWX9/3nP+2CIjpazQ8s6tb9XM7n7slSQj/A==;5:a4wmhYhSDZSefnZLdTiJKkdUteCD+mkAjEuZwK5WBctH9AHMXIxeIGz7Q9D3TrsJRjmSwuUo5m1jMJIdyDLEUjJEqZ75I4wtlhAoCH8V2oR0D81zHe1pg7PcrfkGuqbExnSgKG3FooybIu11wjy4B7uAPiBZ40ulPk846pAToQ0=;24:pvOWAOyMr6nNPrsNAaR2Zb92lWEgxD8RMscQxEc+4NqZx3Yb3GXoDVX3WfdhaOA2rY847sRUI5RO0YQYCs+NcR5TdHtzo/CO9iuwS1VF0eE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:b94jJjPhJbw4fzj7ViaVVO3eF9TUbG+fwedksgWic+EN+/V42+6fL1An923smeTT3WXNP5CQlWmiUOcmOH6j621E7W2sYykX8HzGjB1VhHd6eNN80BI0lEv/4AlkHl+l9SSaqH4q1HiPKRURIFNGm7M4syBIb2k7ZBAgnL81etPWVE7dWLFy1ZcdfcjEdqSecOA08M3mD5jPXBHlvtjQlcx0tkku1c6ecNQnnhX62Wg05DKbtchVQp+sGvrTJJzP
X-MS-Office365-Filtering-Correlation-Id: e1f2c7c3-469c-48cb-156c-08d5a8eb2c50
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 07:23:54.4988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f2c7c3-469c-48cb-156c-08d5a8eb2c50
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only registered as a component master when connected
to a tda998x device, but that driver is now not only a component
but also a drm_bridge. Since drm_bridges are also handled, it
serves no purpose to register as a component master for the
special case of tda998x (which is no longer special).

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c     | 11 ------
 drivers/gpu/drm/tilcdc/tilcdc_drv.c      | 67 +++-----------------------------
 drivers/gpu/drm/tilcdc/tilcdc_drv.h      |  1 -
 drivers/gpu/drm/tilcdc/tilcdc_external.c | 51 ------------------------
 drivers/gpu/drm/tilcdc/tilcdc_external.h |  4 +-
 5 files changed, 6 insertions(+), 128 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 8bf6bb93dc79..b410939a3458 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -1030,17 +1030,6 @@ int tilcdc_crtc_create(struct drm_device *dev)
 		goto fail;
 
 	drm_crtc_helper_add(crtc, &tilcdc_crtc_helper_funcs);
-
-	if (priv->is_componentized) {
-		crtc->port = of_graph_get_port_by_id(dev->dev->of_node, 0);
-		if (!crtc->port) { /* This should never happen */
-			dev_err(dev->dev, "Port node not found in %pOF\n",
-				dev->dev->of_node);
-			ret = -EINVAL;
-			goto fail;
-		}
-	}
-
 	priv->crtc = crtc;
 	return 0;
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 1afde61f1247..d9d2e86c9430 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -17,7 +17,6 @@
 
 /* LCDC DRM driver, based on da8xx-fb */
 
-#include <linux/component.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/suspend.h>
 #include <drm/drm_atomic.h>
@@ -246,9 +245,6 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 	platform_set_drvdata(pdev, ddev);
 	drm_mode_config_init(ddev);
 
-	priv->is_componentized =
-		tilcdc_get_external_components(dev, NULL) > 0;
-
 	priv->wq = alloc_ordered_workqueue("tilcdc", 0);
 	if (!priv->wq) {
 		ret = -ENOMEM;
@@ -363,19 +359,9 @@ static int tilcdc_init(struct drm_driver *ddrv, struct device *dev)
 	}
 	modeset_init(ddev);
 
-	if (priv->is_componentized) {
-		ret = component_bind_all(dev, ddev);
-		if (ret < 0)
-			goto init_failed;
-
-		ret = tilcdc_add_component_encoder(ddev);
-		if (ret < 0)
-			goto init_failed;
-	} else {
-		ret = tilcdc_attach_external_device(ddev);
-		if (ret)
-			goto init_failed;
-	}
+	ret = tilcdc_attach_external_device(ddev);
+	if (ret)
+		goto init_failed;
 
 	if (!priv->external_connector &&
 	    ((priv->num_encoders == 0) || (priv->num_connectors == 0))) {
@@ -586,63 +572,20 @@ static const struct dev_pm_ops tilcdc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tilcdc_pm_suspend, tilcdc_pm_resume)
 };
 
-/*
- * Platform driver:
- */
-static int tilcdc_bind(struct device *dev)
-{
-	return tilcdc_init(&tilcdc_driver, dev);
-}
-
-static void tilcdc_unbind(struct device *dev)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-
-	/* Check if a subcomponent has already triggered the unloading. */
-	if (!ddev->dev_private)
-		return;
-
-	tilcdc_fini(dev_get_drvdata(dev));
-}
-
-static const struct component_master_ops tilcdc_comp_ops = {
-	.bind = tilcdc_bind,
-	.unbind = tilcdc_unbind,
-};
-
 static int tilcdc_pdev_probe(struct platform_device *pdev)
 {
-	struct component_match *match = NULL;
-	int ret;
-
 	/* bail out early if no DT data: */
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "device-tree data is missing\n");
 		return -ENXIO;
 	}
 
-	ret = tilcdc_get_external_components(&pdev->dev, &match);
-	if (ret < 0)
-		return ret;
-	else if (ret == 0)
-		return tilcdc_init(&tilcdc_driver, &pdev->dev);
-	else
-		return component_master_add_with_match(&pdev->dev,
-						       &tilcdc_comp_ops,
-						       match);
+	return tilcdc_init(&tilcdc_driver, &pdev->dev);
 }
 
 static int tilcdc_pdev_remove(struct platform_device *pdev)
 {
-	int ret;
-
-	ret = tilcdc_get_external_components(&pdev->dev, NULL);
-	if (ret < 0)
-		return ret;
-	else if (ret == 0)
-		tilcdc_fini(platform_get_drvdata(pdev));
-	else
-		component_master_del(&pdev->dev, &tilcdc_comp_ops);
+	tilcdc_fini(platform_get_drvdata(pdev));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
index ead512216669..c47a2b6e2a3a 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -92,7 +92,6 @@ struct tilcdc_drm_private {
 	const struct drm_connector_helper_funcs *connector_funcs;
 
 	bool is_registered;
-	bool is_componentized;
 };
 
 /* Sub-module for display.  Since we don't know at compile time what panels
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
index 711c7b3289d3..1471f5f8cb5c 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
@@ -8,7 +8,6 @@
  *
  */
 
-#include <linux/component.h>
 #include <linux/of_graph.h>
 #include <drm/drm_of.h>
 
@@ -116,33 +115,6 @@ struct drm_connector *tilcdc_encoder_find_connector(struct drm_device *ddev,
 	return NULL;
 }
 
-int tilcdc_add_component_encoder(struct drm_device *ddev)
-{
-	struct tilcdc_drm_private *priv = ddev->dev_private;
-	struct drm_connector *connector;
-	struct drm_encoder *encoder;
-
-	list_for_each_entry(encoder, &ddev->mode_config.encoder_list, head)
-		if (encoder->possible_crtcs & (1 << priv->crtc->index))
-			break;
-
-	if (!encoder) {
-		dev_err(ddev->dev, "%s: No suitable encoder found\n", __func__);
-		return -ENODEV;
-	}
-
-	connector = tilcdc_encoder_find_connector(ddev, encoder);
-
-	if (!connector)
-		return -ENODEV;
-
-	/* Only tda998x is supported at the moment. */
-	tilcdc_crtc_set_simulate_vesa_sync(priv->crtc, true);
-	tilcdc_crtc_set_panel_info(priv->crtc, &panel_info_tda998x);
-
-	return tilcdc_add_external_connector(ddev, connector);
-}
-
 void tilcdc_remove_external_device(struct drm_device *dev)
 {
 	struct tilcdc_drm_private *priv = dev->dev_private;
@@ -221,26 +193,3 @@ int tilcdc_attach_external_device(struct drm_device *ddev)
 
 	return ret;
 }
-
-static int dev_match_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-int tilcdc_get_external_components(struct device *dev,
-				   struct component_match **match)
-{
-	struct device_node *node;
-
-	node = of_graph_get_remote_node(dev->of_node, 0, 0);
-
-	if (!of_device_is_compatible(node, "nxp,tda998x")) {
-		of_node_put(node);
-		return 0;
-	}
-
-	if (match)
-		drm_of_component_match_add(dev, match, dev_match_of, node);
-	of_node_put(node);
-	return 1;
-}
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.h b/drivers/gpu/drm/tilcdc/tilcdc_external.h
index 763d18f006c7..1df237e227c9 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_external.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_external.h
@@ -18,9 +18,7 @@
 #ifndef __TILCDC_EXTERNAL_H__
 #define __TILCDC_EXTERNAL_H__
 
-int tilcdc_add_component_encoder(struct drm_device *dev);
 void tilcdc_remove_external_device(struct drm_device *dev);
-int tilcdc_get_external_components(struct device *dev,
-				   struct component_match **match);
 int tilcdc_attach_external_device(struct drm_device *ddev);
+
 #endif /* __TILCDC_SLAVE_H__ */
-- 
2.11.0
