Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeDQNLt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:11:49 -0400
Received: from mail-he1eur01on0125.outbound.protection.outlook.com ([104.47.0.125]:48343
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753164AbeDQNLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:11:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/6] drm/atmel-hlcdc: add support for connecting to tda998x HDMI encoder
Date: Tue, 17 Apr 2018 15:10:51 +0200
Message-Id: <20180417131052.16336-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417131052.16336-1-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0270.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::22) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:9s5hIYSOMWRP3i3kpZ8JZie7aw0iXRsFn+mj+RooRSVNi+3qYDLm0k1yDvggIBUcza0hytQ46umC7cZcF2A1N7KdycNP33f7WEO7dsPafuvA36E0WR5FDRZoR0/DLMJQCVyl0NT3I0+FShXo/FJq1iHQ1a4o1FYpGOHsAnKqVcusPOtDa12Qr5L0N5mu2vUGBS9L1akUd3qBSdBBS1UoF8QJdN+0cdbijlJQLiu9l7QWG8+QDALfJSO5NxngtEsy;25:U0SqpA2X+sARX3pTDDaytOd0QAdo/jvxTdk6fo4F09srXv02UDC3TFdJfUcMjRcuFfO77+HG9PZe4LlfsKlGNGHxOJbH6eiaePlHmnwgz2Z9NbYl8YNDd4OPqEk/GTq8p42Zd08Wkp5MrZNsQL4OuR+t9aIePfa8FJOwMwo/Hiu+Hdcfw8fbnPQOH+xmmnIyo4ro15EEK1WR+ZjPpS+5FQdsiJg3zkqVkBKWXjiXFhjDlJAxKRNKm34GK7taHU97A0qfHdgHn1cw2ip80gXdnBi58uvlMnW6gdyJ6JLcXpLXX0M1dO1BvFE+W9n+V7z8pessnlYpiHag0Nl5xxMrWQ==;31:imyoVWhK5GUj9GDl6d/De/WFWxmKdrq+y/Np2lgT/Hel/C5WQ7CcdmmVERKhNC85QYyYpaOpcaszgNHsn2EiPyTXK5JpfxyB4+Fqof3z71tbZ4lagdPkKxPR4MsFesTZMe7vIWGRzPccCHYkYSEqnU7jbV6JAYxngPJKm+c5aUqIVeHIeylZ7Qak6QRWVgoJKS/DI9kDbXNPWYBaXfeiFCY4gzQFomcfAgrJ+s09JAk=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277857D83B8C78AA4F631F2BBCB70@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(31051911155226)(22074186197030)(58145275503218);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:DDEDKS0SmLpFGgePRPDZ95XfDJqmPaXi+D3CqN+ME9Nf+Ds5lNokhg/xZVFL+JXyUI97feT91YS/LpOQoWX1ZYbfbk24sHxCY/7jsUVTJeBqSX6sBft5rMJMux2A4JRQLruY3lo4qPyz/afFMVDvPDdYXuFZd66vDOhfbP8+fXkqMeOVlpBbP7DIW4lF+ja7NN0mHi8QUnL0O77iEFLltV/UD3/xkDHfRgmycjmi9WqS6AXbcWUrmLqmO3EB78V/kYKkQumWZh2YrCIyF7pyJESJqo5RI4dCRfaSkjRGba8wgxg1xRR9QHnwIPyL6yUHgYj7+YzvwmXIICsm6zVYkfbw0buLUAPlgprJ/uNUWp8fsXlYk53g4uLCXOhS2+QxrYd12GSpwilS1rY3KzDM70UnDCCnC2NHefvzlGNoUUo=
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(346002)(396003)(39380400002)(366004)(189003)(199004)(47776003)(81156014)(36756003)(66066001)(74482002)(2361001)(2351001)(50466002)(105586002)(316002)(48376002)(81166006)(478600001)(25786009)(54906003)(50226002)(16526019)(186003)(68736007)(7736002)(16586007)(8936002)(5660300001)(6306002)(6512007)(3846002)(4326008)(53936002)(956004)(476003)(486006)(2616005)(446003)(11346002)(106356001)(97736004)(76176011)(386003)(6116002)(51416003)(6506007)(8676002)(52116002)(26005)(86362001)(1076002)(2906002)(6666003)(305945005)(6486002)(6916009)(7416002)(59450400001)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2778;23:al+5MSsJUwHYgZ700zgXBL3pYiQjkXP0qRjdaYn?=
 =?us-ascii?Q?KxTe076sMSGchrcuDIInlgQmXQBTGlB5oCxArvWZRdhDpjAZi1N2Xa7RDHiM?=
 =?us-ascii?Q?7/17JjltI6JgKLc7g9Tj96Z6g24DTwYT2nG9Ip0z9TxxeQkRsjjUP1y3AECP?=
 =?us-ascii?Q?JpMaaSEFhAEpa5FZl3F3O23wv56wTJCJLHe47oDPICTQMd3mVSaRq3+SYWhb?=
 =?us-ascii?Q?5vJ2uGzcAheIpwcQgpC4JkdjnMg9ztYkwSOEnryOLotLiPEWa/Fy2r/AfCtA?=
 =?us-ascii?Q?5Ur1D3FIUFajNCntyKVcZNXEWX1kabFEH5jrMZxSC3QH9vAs5d1m9dhl0357?=
 =?us-ascii?Q?S6BKg1bovis1U1tRpA/7t4PQPnQC3iBq5WDcpRup++tA3PSY/KMSorr7ccF8?=
 =?us-ascii?Q?VILWCDdR4I38u6QsJg3kiNHPbyjD6yZ8tDSKCY0ku87t8GRyvcL21xga2nvC?=
 =?us-ascii?Q?UWeC8Syk4ccY/hyHUj7LQofzGZTHM55lIuJRF7gXZtdoDOTtioaG30NOxBOw?=
 =?us-ascii?Q?20vbagQOiYw1WAUrxpaGF9IWM2NteWfezyvB6a3vVRkIskWM/Plhc201n+ve?=
 =?us-ascii?Q?kyUYiTIyAgYaRZ3oivK+tCIbP8ng/Q9+P5F5ZOXqJ8lDzOlv7Hlr8sBHP06D?=
 =?us-ascii?Q?80lORmQzr0ay1PHJZvjywOnKh73vk6SfWVlMVVWLd7Wjm0tKlb4vUXR4eqFS?=
 =?us-ascii?Q?1CMO87P6fe2ws8k2n/ODFRooU0wIKAyEGJsKRtC1IAOK5CYtn3skDjWPWH0o?=
 =?us-ascii?Q?pxxSW3aTgEug5ShoL4OvyhhUBn5hj9b5YddE7NRaSXTzHKMFGnDgqEja2gbX?=
 =?us-ascii?Q?eSxEkqFiBcb0Y1fyk18yzWMKajR6p8T4Hmotr3MTvDJqMiZmmKoy9Xx9+gvy?=
 =?us-ascii?Q?QN5lJaKLduKXs2NsC36TIpm2C0xrQnh1Y9UX7jlrK/tsQ08xzXPopsj8A4gd?=
 =?us-ascii?Q?6HNhDE54EhEpI+VPGzaUSiR9J8jonRe6hJELkkexXQpjoWPbNFnYej3ggkI2?=
 =?us-ascii?Q?l/PoMkMyg8WK9BhMtuFM4+YMyKZAl9u/cgcY5a6kflh3GNV5ODn/cIKXtFdL?=
 =?us-ascii?Q?aoQ15bgahkaJwrXpn1BGAtPE+l3l2+VKKPfKGgaghhL1RwWK0aS3Hrvw4MMX?=
 =?us-ascii?Q?v+gSgRNZ2OZZHY117AKc8dtdX2Us4KOHbIdvozSjQLyVOUIwLfDgNhDkLksn?=
 =?us-ascii?Q?JIXioe61/S5lr6WwigLG/ZVFOsibLTDstpipnzfd+DRi0fGU2IuVMdKYWZ6S?=
 =?us-ascii?Q?SMZJgxdg3bj/XJK8axPaoaJ7aU0TPjTEH1p58rFunJ8mgZ7nly+rILM/0laF?=
 =?us-ascii?Q?UmC0iWhZsbel2mjlsVGhkRmetzaigXhIxH/edrnhIaB4ovsO3BJdudALqLvi?=
 =?us-ascii?Q?uems4JMFyoyjMYDCRXkYCIWmEBZo=3D?=
X-Microsoft-Antispam-Message-Info: 8eLplxq8IM06wU2tModzQ2/KWYZ0Jej9lr1wTDUz0xft36s0o3IzVEJdnoPwY8SiDoNpql79+6rscO71v5RvpCBNjij6EU5IK0FypRnMXIpv4p3nNyI61dpMy81hn62+SK+xyJ3Wxl63/C8zsz1uEvaS0x3h0xcf/dX58vsIKOUCXTmVwU6fFTSCriuKcwTW
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:y0/q+lNPhqduKPrEYn4ZMiuF1vP3JNdPUp8BEztATPyBSCSiQ/YqWaEe+ZLwd+uJq+X8nGzNckVPJsyIWzh80PIV6u6Q31K/XX9KY1F4JtQL6C1vx2k0FTvEqWElN4WqjdfFbjMp1rRaFylxJRSrkH//sK7t7m+v/QKPKO7t5fW3kRxOcWRMUs281aRMrwfHz0NZFwZ1DI10Y8SrZJY9aeGXxtdLlKengGmks7SV28Qp5wUKQg/mNpza1pmfd8HlcC4J0N7ufPff29kQre0CKIgeotoATEICFFKdFtWivyVERaqM4LcJ4u/HUxiIZ1bD06bHYX3jztd/Ht9FQuMaYrCmAEWIrpQ0oPm85V12xPhle95UnwhY7SSGh/ZunbUcgviplQQcZD4RvGaZeufPgnOfiPlvXf4/QsISh4j+Nbdrh5goY8h/MoTYz7BhctjZKayKEGSYIaMaPZGHO97WJA==;5:H7G2qKzXuXM9Y8i8NS/zdl9bOCmn+wyHWna6YjsEQbjujPbQvKeI16AHXqMqtan4ULRlqa5cKPAwY+0KTsFwg6NoG6ge/70sEfM4pAqW4JlO25y+rgTlR3xn6wB1ENzVvkOeou5ja/dGplV9uI/6PNq/kv2M1VpOnxNeQ+42ZOQ=;24:hPyATYwoJgi3D3MUeqK9gEmKv6RH7onJMP5XZQBWXnVTHnVyzFmmgM1GU68A03VT6aBN0OnzFkxkO0hIzkE65zjcbz7MHhKwhZVDuTGA8EA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:ImMSUPdAkKlZUvmaA4l6wYaU5bnCWEtUsMhPzW5KlDHJrG+zY9jMKNJfpoCINCVzYTUEIAEPv4OZm/O0VHdQtNmVP92Ee1VziF9N/8Ll+lYwK7+pROEWZeFMkxeCWL4LbrtvxUb24Nh+AWrn6sGw05e9WHey6sxltiGpzlCXdGVhZ4WrZUitd1Wr3X5ern631lFVvivwqxqPqQ2zKclUTrYIm2bpQiXuN0HqZPApwC2m6rs2zLszTUzOfEWfPQS8
X-MS-Office365-Filtering-Correlation-Id: c54d0821-86f5-478f-7947-08d5a464c223
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 13:11:39.9676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54d0821-86f5-478f-7947-08d5a464c223
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the of-graph points to a tda998x-compatible HDMI encoder, register
as a component master and bind to the encoder/connector provided by
the tda998x driver.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     |  81 ++++++++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  15 +++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 130 +++++++++++++++++++++++
 3 files changed, 220 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index c1ea5c36b006..8523c40fac94 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/component.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/module.h>
@@ -568,10 +569,13 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
 
 	drm_mode_config_init(dev);
 
-	ret = atmel_hlcdc_create_outputs(dev);
-	if (ret) {
-		dev_err(dev->dev, "failed to create HLCDC outputs: %d\n", ret);
-		return ret;
+	if (!dc->is_componentized) {
+		ret = atmel_hlcdc_create_outputs(dev);
+		if (ret) {
+			dev_err(dev->dev,
+				"failed to create HLCDC outputs: %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = atmel_hlcdc_create_planes(dev);
@@ -586,6 +590,16 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
 		return ret;
 	}
 
+	if (dc->is_componentized) {
+		ret = component_bind_all(dev->dev, dev);
+		if (ret < 0)
+			return ret;
+
+		ret = atmel_hlcdc_add_component_encoder(dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	dev->mode_config.min_width = dc->desc->min_width;
 	dev->mode_config.min_height = dc->desc->min_height;
 	dev->mode_config.max_width = dc->desc->max_width;
@@ -617,6 +631,9 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	if (!dc)
 		return -ENOMEM;
 
+	dc->is_componentized =
+		atmel_hlcdc_get_external_components(dev->dev, NULL) > 0;
+
 	dc->wq = alloc_ordered_workqueue("atmel-hlcdc-dc", 0);
 	if (!dc->wq)
 		return -ENOMEM;
@@ -751,7 +768,7 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
 	.minor = 0,
 };
 
-static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
+static int atmel_hlcdc_dc_drm_init(struct platform_device *pdev)
 {
 	struct drm_device *ddev;
 	int ret;
@@ -779,7 +796,7 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
+static int atmel_hlcdc_dc_drm_fini(struct platform_device *pdev)
 {
 	struct drm_device *ddev = platform_get_drvdata(pdev);
 
@@ -790,6 +807,58 @@ static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int atmel_hlcdc_bind(struct device *dev)
+{
+	return atmel_hlcdc_dc_drm_init(to_platform_device(dev));
+}
+
+static void atmel_hlcdc_unbind(struct device *dev)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+
+	/* Check if a subcomponent has already triggered the unloading. */
+	if (!ddev->dev_private)
+		return;
+
+	atmel_hlcdc_dc_drm_fini(to_platform_device(dev));
+}
+
+static const struct component_master_ops atmel_hlcdc_comp_ops = {
+	.bind = atmel_hlcdc_bind,
+	.unbind = atmel_hlcdc_unbind,
+};
+
+static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
+{
+	struct component_match *match = NULL;
+	int ret;
+
+	ret = atmel_hlcdc_get_external_components(&pdev->dev, &match);
+	if (ret < 0)
+		return ret;
+	else if (ret)
+		return component_master_add_with_match(&pdev->dev,
+						       &atmel_hlcdc_comp_ops,
+						       match);
+	else
+		return atmel_hlcdc_dc_drm_init(pdev);
+}
+
+static int atmel_hlcdc_dc_drm_remove(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = atmel_hlcdc_get_external_components(&pdev->dev, NULL);
+	if (ret < 0)
+		return ret;
+	else if (ret)
+		component_master_del(&pdev->dev, &atmel_hlcdc_comp_ops);
+	else
+		atmel_hlcdc_dc_drm_fini(pdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
 {
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index ab32d5b268d2..cae77c245661 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -370,6 +370,10 @@ struct atmel_hlcdc_plane_properties {
  * @wq: display controller workqueue
  * @suspend: used to store the HLCDC state when entering suspend
  * @commit: used for async commit handling
+ * @external_encoder: used encoder when componentized
+ * @external_connector: used connector when componentized
+ * @connector_funcs: original helper funcs of the external connector
+ * @is_componentized: operating mode
  */
 struct atmel_hlcdc_dc {
 	const struct atmel_hlcdc_dc_desc *desc;
@@ -386,6 +390,12 @@ struct atmel_hlcdc_dc {
 		wait_queue_head_t wait;
 		bool pending;
 	} commit;
+
+	struct drm_encoder *external_encoder;
+	struct drm_connector *external_connector;
+	const struct drm_connector_helper_funcs *connector_funcs;
+
+	bool is_componentized;
 };
 
 extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_formats;
@@ -455,4 +465,9 @@ int atmel_hlcdc_crtc_create(struct drm_device *dev);
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev);
 
+struct component_match;
+int atmel_hlcdc_add_component_encoder(struct drm_device *dev);
+int atmel_hlcdc_get_external_components(struct device *dev,
+					struct component_match **match);
+
 #endif /* DRM_ATMEL_HLCDC_H */
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..3f86527e0473 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -6,6 +6,11 @@
  * Author: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
  * Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
  *
+ * Handling of external components adapted from the tilcdc driver
+ * by Peter Rosin <peda@axentia.se>. That original code had:
+ *   Copyright (C) 2015 Texas Instruments
+ *   Author: Jyri Sarha <jsarha@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
@@ -19,6 +24,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/component.h>
 #include <linux/of_graph.h>
 
 #include <drm/drmP.h>
@@ -88,3 +94,127 @@ int atmel_hlcdc_create_outputs(struct drm_device *dev)
 
 	return ret;
 }
+
+static int atmel_hlcdc_external_mode_valid(struct drm_connector *connector,
+					   struct drm_display_mode *mode)
+{
+	struct atmel_hlcdc_dc *dc = connector->dev->dev_private;
+	int ret;
+
+	ret = atmel_hlcdc_dc_mode_valid(dc, mode);
+	if (ret != MODE_OK)
+		return ret;
+
+	if (WARN_ON(dc->external_connector != connector))
+		return MODE_ERROR;
+	if (WARN_ON(!dc->connector_funcs))
+		return MODE_ERROR;
+
+	if (IS_ERR(dc->connector_funcs) || !dc->connector_funcs->mode_valid)
+		return MODE_OK;
+
+	/* The connector has its own mode_valid, call it. */
+	return dc->connector_funcs->mode_valid(connector, mode);
+}
+
+static int atmel_hlcdc_add_external_connector(struct drm_device *dev,
+					      struct drm_connector *connector)
+{
+	struct atmel_hlcdc_dc *dc = dev->dev_private;
+	struct drm_connector_helper_funcs *connector_funcs;
+
+	/* There should never be more than one connector. */
+	if (WARN_ON(dc->external_connector))
+		return -EINVAL;
+
+	dc->external_connector = connector;
+	connector_funcs = devm_kzalloc(dev->dev, sizeof(*connector_funcs),
+				       GFP_KERNEL);
+	if (!connector_funcs)
+		return -ENOMEM;
+
+	/*
+	 * connector->helper_private always contains the struct
+	 * connector_helper_funcs pointer. For the atmel-hlcdc crtc
+	 * to have a say if a specific mode is Ok, we install our
+	 * own helper functions. In our helper functions we copy
+	 * everything else but use our own mode_valid() (above).
+	 */
+	if (connector->helper_private) {
+		dc->connector_funcs = connector->helper_private;
+		*connector_funcs = *dc->connector_funcs;
+	} else {
+		dc->connector_funcs = ERR_PTR(-ENOENT);
+	}
+	connector_funcs->mode_valid = atmel_hlcdc_external_mode_valid;
+	drm_connector_helper_add(connector, connector_funcs);
+
+	dev_dbg(dev->dev, "External connector '%s' connected\n",
+		connector->name);
+
+	return 0;
+}
+
+static struct drm_connector *
+atmel_hlcdc_encoder_find_connector(struct drm_device *dev,
+				   struct drm_encoder *encoder)
+{
+	struct drm_connector *connector;
+	int i;
+
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head)
+		for (i = 0; i < DRM_CONNECTOR_MAX_ENCODER; i++)
+			if (connector->encoder_ids[i] == encoder->base.id)
+				return connector;
+
+	dev_err(dev->dev, "No connector found for %s encoder (id %d)\n",
+		encoder->name, encoder->base.id);
+
+	return NULL;
+}
+
+int atmel_hlcdc_add_component_encoder(struct drm_device *dev)
+{
+	struct atmel_hlcdc_dc *dc = dev->dev_private;
+	struct drm_connector *connector;
+	struct drm_encoder *encoder;
+
+	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
+		if (encoder->possible_crtcs & (1 << dc->crtc->index))
+			break;
+	}
+
+	if (!encoder) {
+		dev_err(dev->dev, "%s: No suitable encoder found\n", __func__);
+		return -ENODEV;
+	}
+
+	connector = atmel_hlcdc_encoder_find_connector(dev, encoder);
+	if (!connector)
+		return -ENODEV;
+
+	return atmel_hlcdc_add_external_connector(dev, connector);
+}
+
+static int dev_match_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+int atmel_hlcdc_get_external_components(struct device *dev,
+					struct component_match **match)
+{
+	struct device_node *node;
+
+	node = of_graph_get_remote_node(dev->of_node, 0, 0);
+
+	if (!of_device_is_compatible(node, "nxp,tda998x")) {
+		of_node_put(node);
+		return 0;
+	}
+
+	if (match)
+		drm_of_component_match_add(dev, match, dev_match_of, node);
+	of_node_put(node);
+	return 1;
+}
-- 
2.11.0
