Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F8921717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iYdmFIkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F8921717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbeHCMHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:07:36 -0400
Received: from mail-he1eur01on0118.outbound.protection.outlook.com ([104.47.0.118]:45289
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732090AbeHCMHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR1K3Y7YCs8AAB6dEQK7G40bpwip1E6XqXJRMNXOwUM=;
 b=iYdmFIkZFvR1SMmOD9eTlt6gdV8/FGzuFZACQRt91mBoeriL6kdSEKXu2qINFodMOLDsb+5UhD35/6hA3/T7fd7GfrsbyTO9VfCl6B3D9pEfD7KjmnNbzylfIOaas1Pjj6lP5kYyB5t6ajo2w1JfYUt3CQeC+DXfLVbAfRHGG9U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 DB6PR0201MB2456.eurprd02.prod.outlook.com (2603:10a6:4:35::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 10:11:47 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v6 3/3] drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
Date:   Fri,  3 Aug 2018 12:11:24 +0200
Message-Id: <20180803101124.4622-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803101124.4622-1-peda@axentia.se>
References: <20180803101124.4622-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM6PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:209:15::16) To DB6PR0201MB2456.eurprd02.prod.outlook.com
 (2603:10a6:4:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5609ba86-a425-47e7-6ef3-08d5f9298633
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;3:vn5ItCtcoYpfTBKlFY78eqsXDAmCnzPp/UdYZGzw/q05ZnRj+QocLe9+nVE6PBj8AOXZ+JfvBQZrLrnkjhhRvqTcEe+dQduIXRjn2Qe6JALyydRMpQCMSrnI6cojuIhORdQXSiNK5bFHx06Xab2OilzXToZgbqmHoYbWZsxVpmp8/pFce5VXO6E+PIcTHIaUl5sG+0cFEDFYhQ/tsePyrUB4iM7XD7z7J+9u781rJAh/hgnA/sJ6DkaBM8PpDhcq;25:ipBJkJ6Ss1P9xb9Al04KymY/CzmZJaDxGZ5PI9KTteBYjZjYmjgGKnkcgscToYtxXCFI1V7UNjhE3OvqMakDObNhrq1gVpj37BdhabFcWcnfC4KoexsxJBhktW5z2VAFKtvtFDrFDld2yf013KjEhRofw7ibCa3Cg6sEPH6w3WjFEKvXka2syddb9eqk6jlZAc5daM6urUkc6721HmgGg7RlEEs8kPBBM7mFKqEC+6olhWBESYWocpNOXfxyco9JchFd9PpKudKJ2VmOaD5+YeIryJrspNOgqdCOetGqQG7ooJv5oCaiLxk0dFxrht4BabSpQoGz8bzeUKOZ7gUg5w==;31:hW4/6okyLxgmvMWBfma5sfcVKMj6zsSrJd8wNs1BqdtJV1CPTlDjPLZ+melDm1D8YK4h7yQyO8bv2/jsHMBg1NXWoxzC4FhfDNjYIHUpm6BdltkM9/NetZknK7AofAgCzPGVhoo6Rmq2fw6GIFhnXzRkh96C8goD5xq2VrRLwejJG51oa7wOju1el3oBHZfBputQKUNttY7pI0EDKOoR5zhwC5LxcrmxJraYPe4v4ks=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2456:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB24563BD4F5B99E6BF56E79C5BC230@DB6PR0201MB2456.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DB6PR0201MB2456;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2456;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;4:VD0naKv+uroVPk2wyCC40T+Y81Qo8agWFw1VehzhUDruHPQA9LvbxelNtK6FCTFP2paEETdbUwaEU6xAlz5e8UnwS6KcZ+hJj9j3kpPbCzllK2i0nSsAUqMF9+U0INUhbAG1wDq49BEaIoI1Qhydqon4w0L754SflT579O1PymqeDzK2fFlv1gR2ox8a++hq3EUdcb2fB1l2famnt+W+2J5tqU/ZqoJy73syZop/b7mDNMiTKkAOkCuctMG7S+PJpkocqwlIRZQVMjWJd3LE1A==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39840400004)(396003)(376002)(136003)(189003)(199004)(386003)(25786009)(3846002)(5024004)(476003)(956004)(2616005)(2906002)(16526019)(74482002)(36756003)(7416002)(1076002)(486006)(446003)(86362001)(575784001)(26005)(105586002)(186003)(11346002)(97736004)(305945005)(106356001)(6116002)(6506007)(5660300001)(66066001)(8676002)(2361001)(6666003)(81156014)(6512007)(68736007)(47776003)(7736002)(81166006)(54906003)(478600001)(2351001)(8936002)(53936002)(48376002)(16586007)(76176011)(52116002)(51416003)(6916009)(50466002)(6486002)(50226002)(4326008)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2456;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0201MB2456;23:YDOmSsDOe6ehwaaa/rlvFqNYKyu1+yCbTy3Xnsx?=
 =?us-ascii?Q?IVXpJhmCqxfFPufVKvBpyXc65AzDGoxPueJiS2TzXOWYSvC0Wg/SC0hShcDU?=
 =?us-ascii?Q?03VWhhaaM2NQ1ki1ej9WebIu4Dny0mNJUEIQ2ecIKTvUNnoe3YYQ/KyrTbS8?=
 =?us-ascii?Q?TK70l+aHaHNeZk6TlyujdQ/e2rjPDKXkrovZ/uNoHmaqV/IIvnBsVZsl+8ip?=
 =?us-ascii?Q?rHdXEqALyx6MwR6LSBhpLoj1xKJ28MwpqVCEfRs0f4dNUrps97kjKYZzFg8K?=
 =?us-ascii?Q?IqXmS74na+pyM3rIzDJBe5WBdoB/RL6ya3/b20/Y3V/VLV4yORjT1I7JXmdM?=
 =?us-ascii?Q?KHwuDSvOezfBS/B0zeMsIROcc3ZesKDVtlBUCMVxVcU5N+2PCPyFth7E1TDt?=
 =?us-ascii?Q?woT/kTfjsy2zpC/ORfxaPt04czApCgvAMjG+EUVVl6QhOvHljHC+wjKQebeb?=
 =?us-ascii?Q?lRdajaSqcO2FG5A2kY/vm098b+FdrRNvpzVmMQni8g1v3DoMzEZGIIRZwhhb?=
 =?us-ascii?Q?RPAfd3OF8MmvJKnag7znr5n+UmFBKd/wN0hfJ2Ay7qLlxI96P6PuNyF1RIGO?=
 =?us-ascii?Q?EI/rhkttDzBeMTE8YagR+HcbmT4rAQr5qzqQFutfzqM18W41raGZK8Y2QZ8S?=
 =?us-ascii?Q?Oi9upkRqiKGyR1cXhCrOLhe+2Lt8e7yPN7S922sMBk4Z2icK2QwQEKEpwTHt?=
 =?us-ascii?Q?rVuDf6gaBizM0b7Y/emS74N/d8bGbv53O1Nk4ow0EoCOoei4GZhclLjMGyMQ?=
 =?us-ascii?Q?cQKeNe6Ec68jARIWmV6WiLUptEwwM2M8zCXYNpS9E6db+ZsWpF1PinxEptS0?=
 =?us-ascii?Q?PyUgYj7EYiyOn77YNlpa2IN82Cbl/h2d+vLCBWdcVlyPyvNZjZjbJRHv0oSE?=
 =?us-ascii?Q?0NiGEv6uQ5vwR5/kEWgOUa2w48HGXw2nYL/+4H9pZijKAj32PCPxWoI5Sh5W?=
 =?us-ascii?Q?UE3jCFgPIlPUM6yW1wbLM0LcpEMYQ+qJc9c6ZZ+SY1PRJTYw30rrEhDEk/Gs?=
 =?us-ascii?Q?1m20JJjM/BzMbzWMeo+zfhGP86vc56Y7+eP46K6YBxQlWRxej75nXX3qKwfS?=
 =?us-ascii?Q?d+JL5SVu3diFtAOwstmBIGrTzs+CWtuMMDNjNvvvFoh0lWW1Lluo8UPmOjA4?=
 =?us-ascii?Q?RDh5Iw0EmgbPbdB9YhDP/cg0/OCOB0LEVq0Q+UvzV19xJVRluvXpmu5sgICd?=
 =?us-ascii?Q?hwJ7/QhMsDkcjS54jfJd0RGFK4C8rm+QJzKie8MyHubXiCi7vZAieASTj/4s?=
 =?us-ascii?Q?cFL6k+swtKacaXJxAVAjph3pzIlZV7wtHCS16QGpjDxiBWqwN1sNETnGFcpG?=
 =?us-ascii?Q?IuShWWUbf0B6ZocRU9XVMGTuXdfgX55JvWGySIN2Fc3pWEXdI2qiry5ZvKOG?=
 =?us-ascii?Q?ETF8sVQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: xqiivk4BSr+qtLfQEmK8a2boGDvYRFvvodpu59aErNNgUkPh6W/F4rIoPbp2ATu/fRfm7RPHfecxsJIYMyUifcYniLP58SaYPp7flDfNi+UnxtXsZVrfGKICzNNn9IMB+yhT/4vjs3dsB+FxRRqPpQEoFtaeXC9Na6Ta1f+83e36aNeKChYQLZwc/l8chQPxvYhdOz9PgrgyKve2r0z4YRVJVNlz98e8F93CILu+pCoVkiDUrOuiQkqZej1s2nHry60Yu+ivraHqpYq3jBP3mzgo8/ZUVZ93RLSOqKDncZb2sxcJNgfADiILnl1E2oOl/FlzTMwMN3AmebXYeSAEUo+YT174CHNrxm3ahvi7Eg4=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2456;6:zi/ZeXy9sS4ZFtUWwjch8h2/jgAxzflelrp3jCmlrEmVyOUlP1+EXbzgptip7IriansKmZ9hO+koCrvc0xnBd2foJC5s6dlikiuNkLghXbiVNuZHBMHqTvo8ET/v+I6ayYnsPjb5Be0GMjYJ4ugGrfC2KdMBJeOFFR7DNbKRQwlLfwxJ8CEkAcPEPIGuKYTolh8VXMCpzohnkqo1Zm/3xqG1BvXbJti5OKHfzPzgZI0T+VO8SnHA5kRjq8yp0uZMaxUGSItYutafI6Vfb6sHzvMwKazGZ/tUc0Tq8IREdTV8Iq66wuw4eV3wvvyxNn9Fza1reHxY4vzaJ0cdVlBUdjBvHxn7uWANyT23AAK97ilr+rqWs2cJyQuOt1tyoikc7a886ObZEUqXCy/nTsFy5RZauIUitd0S5yZ0CrjU78YkBxT0yRtS8kx2UtT+5Y53g4oHrEdUW+cqyeyE++y5Jg==;5:CTB05l3UHW3mzHgdVdGI4lTMOgLSPmOZJcNz6eeiZ4akWHZU/oxn2Ns30S8cNk+cpiRUtUjmeZ1iTtJPI6IDS8roVbpHXmCU9d2y7tESpFeK5+EEgGO5ldrzCGqyT1TfDQ7wT8CJnCwevYBphnhhRN4bbOcRJhs1nezazhfUGtk=;7:PEbdnyGl6ql7EoxUpexGLEYptv2c3eYboMLWtr9hGtf199DSpzoHPvFOxowJmtLmREgKRHC0jBfxQp7kgrU7y1jXgK7ip4KzDq/WnzmqYqL3dR/3/wq20RpFhx+DzXBVrYPwC9UAOknO5azRYS3B6nOBfDu9L6NP8vU3LthuLIsdG3CxfK1WG0/zA9HT/2RqU8SWT/5qGruycnUvOVdBu+Kr1tQN83ZCkXbE9sUZE0KQN9RtQ42Spv1OIzQrzy54
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 10:11:47.4848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5609ba86-a425-47e7-6ef3-08d5f9298633
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This beats the heuristic that the connector is involved in what format
should be output for cases where this fails.

E.g. if there is a bridge that changes format between the encoder and the
connector, or if some of the RGB pins between the lcd controller and the
encoder are not routed on the PCB.

This is critical for the devices that have the "conflicting output
formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
RGB bits move around depending on the selected output mode. For
devices that do not have the "conflicting output formats" issue
(SAMA5D2, SAMA5D4), this is completely irrelevant.

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 70 +++++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 70 +++++++++++++++++++++---
 3 files changed, 114 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index d73281095fac..c38a479ada98 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -226,6 +226,55 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
 #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
 
+static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
+{
+	struct drm_connector *connector = state->connector;
+	struct drm_display_info *info = &connector->display_info;
+	struct drm_encoder *encoder;
+	unsigned int supported_fmts = 0;
+	int j;
+
+	encoder = state->best_encoder;
+	if (!encoder)
+		encoder = connector->encoder;
+
+	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+	case 0:
+		break;
+	case MEDIA_BUS_FMT_RGB444_1X12:
+		return ATMEL_HLCDC_RGB444_OUTPUT;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		return ATMEL_HLCDC_RGB565_OUTPUT;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		return ATMEL_HLCDC_RGB666_OUTPUT;
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		return ATMEL_HLCDC_RGB888_OUTPUT;
+	default:
+		return -EINVAL;
+	}
+
+	for (j = 0; j < info->num_bus_formats; j++) {
+		switch (info->bus_formats[j]) {
+		case MEDIA_BUS_FMT_RGB444_1X12:
+			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB565_1X16:
+			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB888_1X24:
+			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return supported_fmts;
+}
+
 static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 {
 	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
@@ -238,31 +287,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
 	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
 
 	for_each_new_connector_in_state(state->state, connector, cstate, i) {
-		struct drm_display_info *info = &connector->display_info;
 		unsigned int supported_fmts = 0;
-		int j;
 
 		if (!cstate->crtc)
 			continue;
 
-		for (j = 0; j < info->num_bus_formats; j++) {
-			switch (info->bus_formats[j]) {
-			case MEDIA_BUS_FMT_RGB444_1X12:
-				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB565_1X16:
-				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB666_1X18:
-				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
-				break;
-			case MEDIA_BUS_FMT_RGB888_1X24:
-				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
-				break;
-			default:
-				break;
-			}
-		}
+		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
 
 		if (crtc->dc->desc->conflicting_output_formats)
 			output_fmts &= supported_fmts;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index 60c937f42114..4cc1e03f0aee 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -441,5 +441,6 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
 int atmel_hlcdc_crtc_create(struct drm_device *dev);
 
 int atmel_hlcdc_create_outputs(struct drm_device *dev);
+int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder);
 
 #endif /* DRM_ATMEL_HLCDC_H */
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..f587ae596791 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -27,33 +27,89 @@
 
 #include "atmel_hlcdc_dc.h"
 
+struct atmel_hlcdc_rgb_output {
+	struct drm_encoder encoder;
+	int bus_fmt;
+};
+
 static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
+static struct atmel_hlcdc_rgb_output *
+atmel_hlcdc_encoder_to_rgb_output(struct drm_encoder *encoder)
+{
+	return container_of(encoder, struct atmel_hlcdc_rgb_output, encoder);
+}
+
+int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder)
+{
+	struct atmel_hlcdc_rgb_output *output;
+
+	output = atmel_hlcdc_encoder_to_rgb_output(encoder);
+
+	return output->bus_fmt;
+}
+
+static int atmel_hlcdc_of_bus_fmt(struct device_node *ep)
+{
+	u32 bus_width;
+	int ret;
+
+	ret = of_property_read_u32(ep, "bus-width", &bus_width);
+	if (ret == -EINVAL)
+		return 0;
+	if (ret)
+		return ret;
+
+	switch (bus_width) {
+	case 12:
+		return MEDIA_BUS_FMT_RGB444_1X12;
+	case 16:
+		return MEDIA_BUS_FMT_RGB565_1X16;
+	case 18:
+		return MEDIA_BUS_FMT_RGB666_1X18;
+	case 24:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 {
-	struct drm_encoder *encoder;
+	struct atmel_hlcdc_rgb_output *output;
+	struct device_node *ep;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	int ret;
 
+	ep = of_graph_get_endpoint_by_regs(dev->dev->of_node, 0, endpoint);
+	if (!ep)
+		return -ENODEV;
+
 	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
 					  &panel, &bridge);
 	if (ret)
 		return ret;
 
-	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder)
+	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
+	if (!output)
 		return -EINVAL;
 
-	ret = drm_encoder_init(dev, encoder,
+	output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
+	if (output->bus_fmt < 0) {
+		dev_err(dev->dev, "invalid bus width\n");
+		return -EINVAL;
+	}
+
+	ret = drm_encoder_init(dev, &output->encoder,
 			       &atmel_hlcdc_panel_encoder_funcs,
 			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
-	encoder->possible_crtcs = 0x1;
+	output->encoder.possible_crtcs = 0x1;
 
 	if (panel) {
 		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);
@@ -62,7 +118,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 	}
 
 	if (bridge) {
-		ret = drm_bridge_attach(encoder, bridge, NULL);
+		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
 		if (!ret)
 			return 0;
 
@@ -70,7 +126,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 			drm_panel_bridge_remove(bridge);
 	}
 
-	drm_encoder_cleanup(encoder);
+	drm_encoder_cleanup(&output->encoder);
 
 	return ret;
 }
-- 
2.11.0

