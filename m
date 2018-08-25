Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2694C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686D9208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="HrJffNT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686D9208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHYMfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:35:16 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:33188
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbeHYMfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A80Qjg3KyL330hXEsf05dpMGBLmMDUUnUzKimA1QRhU=;
 b=HrJffNT0mVrFag5+hXNVK21F297P8Fof6iH/ZuECv9vFWdjmdX/1wsRPpIO+7k2KW1Zd+iiKpUsJKUs8sD6SjiDS7Y2MfxsqAdPoWrvOeprRFFU41ase16dEb4uSLj+PhIFyTEWd1M7RXlCpkjM7oaap7fdZ4Jskhf2EgZ4WGdw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Sat, 25 Aug
 2018 08:56:50 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH v9 4/4] drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
Date:   Sat, 25 Aug 2018 10:56:20 +0200
Message-Id: <20180825085620.10566-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180825085620.10566-1-peda@axentia.se>
References: <20180825085620.10566-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:6:46::17) To VI1PR0201MB2463.eurprd02.prod.outlook.com
 (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbd1f048-c180-4952-312f-08d60a68b353
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:84KpITmWMirRwQm4mgPNkGZy8k3S5H6yITcwykGKcv/dyQ957mEQXQGvjPciZdXaNo62MqwQXpkesEDRiL401yvIUfRmndxmeehvvnYIQqc+rB5emcCS3YOXyYJKWWEoiTTFWTGmqyavVZGI5nUenM38tO4J7NWswvlH5EuMcRfgDOFkJH1sugiFbgZRWOmi/le8FnZDZaastBCH50gfjGXLU1qfbfF3K7Mz0QRe6V+4r68K+cBKMS6UMrHB26DV;25:fnH3xA6HoOPGC3SD/RCcM7NQgh+Kbw1Ej0/As3ZqIpwb2DH5z7nvf8xSVJypNrwfp8gsnCmruVztOxUSVywGCde+o7k0YQnt4L7T4mqJUT6IiqH6LKLue4RauW+F0X22xgHMXU9uJ5pXNMIAHum1ehCf2NDmkb9mQLgrK2wR37ULld5DDqxxEOyupD1+yQhB/nRtQpxGgTamwjGx/+a6gZC3GQaLTzz9fGdVVFW2vmHWYKivjTnkqWhFdN5XINHGgCgDe6giVL9+U7NOmbiO/TQDhp+CdBJjwARXpWlzoUFeEt/V2ODCYDaqPAwJUqcrTzQW9P/1GaZuqfCm5musww==;31:ELdONSrqshLWvpBDjQTbIfTU1CBubGAi1G8j//nb3CSfE9yax8pTYQ5XDq614rndvAhLE8ln86265na47IkETTztwJTSYuRo6nIrfVLdRxoGB1+oQ+m77igraz4QWIkkPJOa/jC0Mug8O7Mt07xaglQUE5TXagBcJgD6oTOVM5eiutz9zNkRjYM6+xV2vyA1o+z2aJalZmikS1WiCbJ4l4m2PoaELMAWV45ZlzentYw=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24632E6C67FD95CEF8B71C12BC350@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:BjM4G53a5/z5GoYUHMikbjGvHWhacMKR6tHWblSQ5bnsCwK+Mjmb/pckG+gWPB6EWU/w1/DUYXIwRVDavWTv8ZvZz/dfuOO5xOYnWEzHxU96VBOogEZmWSDXRivGORbMq7DpBESq0FwfHqN5yakR6cleZk1/p94oCz7jdgfROQAHR4kB9uWhRsOS1FQkZBiyHY+f2pMc0K2B1sNp5ulYHdkjkF1i0F78gxl5a6+RjFyYrwUs1a71D/oZAGNDdCfWLVDo4SZUz9TNZJasbmno2g==
X-Forefront-PRVS: 0775716B9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39830400003)(199004)(189003)(52116002)(54906003)(105586002)(50226002)(478600001)(476003)(11346002)(446003)(2616005)(2351001)(956004)(106356001)(316002)(16586007)(74482002)(486006)(6666003)(6916009)(81166006)(81156014)(8936002)(8676002)(7736002)(7416002)(5660300001)(2361001)(305945005)(97736004)(386003)(186003)(68736007)(26005)(6506007)(16526019)(47776003)(50466002)(51416003)(6512007)(66066001)(48376002)(2906002)(53936002)(3846002)(6116002)(5024004)(25786009)(36756003)(575784001)(86362001)(4326008)(6486002)(76176011)(1076002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2463;23:JVuTeg79fWwLXCpQCW/Ga0V7lMOjfJ+LFpxohBM?=
 =?us-ascii?Q?E8mH41HWKyJvkYkYm9oL8ERqAto/rCZhGu6M9DFWklnZFK3TvusdLlQklLVi?=
 =?us-ascii?Q?BuWMdL7DiaT/v9d4ffkEBoQwxe9hgCJya9ScC4iRVk/SdgwmPU+02MpEPH/n?=
 =?us-ascii?Q?Yav6pNDoAbHvS0jI65Wl7z/jQmclV/PtjWDTmBdABfIC1S6GDSeNsVxw6vHE?=
 =?us-ascii?Q?hjNh1Lfb1ToYZJCII9E4+jO0MBXJ1Y8VPhKiOSZf8xd8Yli8dKCfQfavf4Rd?=
 =?us-ascii?Q?tb7wTYKmd6+RJWDEiv9FTqKg0mDrdh4/lRiQOanNFKAlYhAmu+JJFT6htGlv?=
 =?us-ascii?Q?9l9IGuwRmPemeSYbUPZcnGOVVsQRvBylHfb+S5u45eXH0tVMuXKNqOpRMZTc?=
 =?us-ascii?Q?AX1TPQ4dJlWIZQbbHAb+V8DwSR7WTsLQ2ZKyA+HoDVIyDaX4vonqmjEPIA1q?=
 =?us-ascii?Q?KoLEBORN2Z7BSMVBp4mGVdHGT6ZF4IFweU3ibzuf2hF4A+Tff9xXWGJEKgNd?=
 =?us-ascii?Q?mtjI5e9jZHJbz39uPG3o2lm55N5QEuZKj6oLCwH/G6y1L2jLiGKnOYznlC8W?=
 =?us-ascii?Q?XdPRJl5doN7xFrJ3VBJbGcw6FxOxtgaVnBi4aE/rFKKOondD7bqfFdGk+bFR?=
 =?us-ascii?Q?FzwvPoSjbPcorwXKNBx97gISdLyWXi9Lh4FT04UG1843fzWRZf+3c6F2Ez0z?=
 =?us-ascii?Q?hD8uME/7/O5xUepsYY2aALMm58jOjMzu9gRNM21MY9iCE2T4E2jcYenNwG7i?=
 =?us-ascii?Q?bSkBq9GCNW/8rbKsl88HBwGn1ZVxujQAn7YC6u7Pa6dLW0j63N9vSs0dXLvU?=
 =?us-ascii?Q?qFPEwXG4Asr7TpQTB5maIXrP8nb14eFXAoUxJn5igrUfjsTQ/UbLuC8OR71j?=
 =?us-ascii?Q?2FIhfUCVocNliU7mxssq3J3ZyuzrKd95QS+ofR3P8l0JV+qiEk9y9+FR9oTT?=
 =?us-ascii?Q?zfkJaEMso0MwLCRQc7AT8oDqovsfE9tF2CqJZVdOdUZH9/BeV0RiuDYFuCGZ?=
 =?us-ascii?Q?VGfzgz0P+KHSPlSVlPktXow5r/hEglSR1Rtm+npVMKjcv4G8kIOYFAxvLGwJ?=
 =?us-ascii?Q?AF/pxdwaDtOEJgB926xpVOFUKl+9nYmc6zTB0tKXd3VT1RbnYbtBac1uadcN?=
 =?us-ascii?Q?AzWRgJ3XzPzsLXppDnc28ZUTUiA5LopWGwQTrR9EC4BzVaEMitguhqcL5Xir?=
 =?us-ascii?Q?d2MyGF3b2XAxn2WnKfet7c7JydBnJFw39f3wXRbh2X573dKgTGVhJ13TLVzi?=
 =?us-ascii?Q?fUxMLfFGa55pYGpjp+na+u+1onMAg0lueJONAC3r6eY8IviCD60IG6qN9PAS?=
 =?us-ascii?Q?ER5jpTaLSNJdMxOKrigxfNCQ9QIXmaM6VGaqHbjgL0IIxaJc25qtsaPcGKSX?=
 =?us-ascii?Q?d/5FLuA=3D=3D?=
X-Microsoft-Antispam-Message-Info: /B5X+mU6UZorOnm+gEkw7j1gbl6k1s0tCRtt4TS12h1CW24hCjvJE8+NHR/ZSzp0VoykW4LUWGYWNfipij4qDpYJ1TWblhYjkynzBNZELgh5qUuO5aTOCbsAUiIrr+KFDI9mwCDRs0bXv5/HZFqRMVDSeC/Sh+GQa424LD1wG5SkgW3fMRS1RGuRBiztLVfx2Xeepxm1LUEAMA622wfwVN2RMPvFSDLLiXJU5MjYM1bu71du/rxI58Vt/kEXjFo4jdvzPspKgMNGPDsbsD+a/lTRf3CvwKCf0KoXvsMp7jLpju4ndncOdd7D9xtCXRAiZqTrM3KTpsfN0YIGwPJXi+HS3nHPMTpIl/HyUMfg/DA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:12uRxuM2IF2srFfKi5RPQwJkeHeDomZQUfFITgv0r1XJrWmtSUcaKHHWVQTixrYW7sXcoG6W/MEWE4IE4FrctIGiys+uFh9DxmjIZQJj9ngGKNMTmycevCn45kdYEWa/2BQc1iIdo6ghkn/WOK320dvJQirFd2M2MR+5zoChC16MsTApS983mlGJc1NkDz9rrqdKubL3T4tcxdYCKEGtNxgneh8PrVDZQ5sTPLvWBC6+rbsKoxyKkiKRbkOQ6uN9cfz+6+Pi9/wPs44wabmNeFeLsSlBBpMhXVfhsgwbyTcrQ+ZBBH0KXoCfwMVPDMR1X4OPZYGui0ZfnJE1BtxOvj92y+S9HBgwgBbkOXSOdeJ7pLETils2G1iVZPEh+AwbRrIzdQw3ZOXx4ZheeLTcYNV22HW9cLZgRxuKqToajnbfY2VZ5if/wfUtZVkq0+NuskEisKr9v4GKa3APmlgXhA==;5:di4w8Dy8kIehcK+QBEu5CnQg7pLiZ1aPRap8jgTi3UYXo4wjOsiATUQADQnh4SsmCtPVeRxiPMPoVSLj2QfBMiwc1uk9Fo8lNqBzDdn2gybbx0Bdbw1o/67psLx0Wf9N7avyi49uvzbwsxv2Dp4YpXi+06u+i6qmNb3oIIz8V9M=;7:MYHm933CkxE0Voh0BSOBl4anxh52HLKG7w0z+OetFBMoCz2MijYKZLJcbTxaQ1gRBGa9Opbwfls0OAW9RlDO22RSuOkc7zOtytECWBoN35iRMqgZg9+2WdTZXjbVrbTGS9jCM4zX8u0vnG7HQ3rMpVoyY52y0w/R3miDccIXMRBGKyNUo8PNz61F0MW0Qwdojz7UB+WM6WVoJ940qgq4ECZh8WNbp+5wNdPoUGD+4T6nB1JhI8MlcVYs3zGBa7Bg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2018 08:56:50.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd1f048-c180-4952-312f-08d60a68b353
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
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
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 70 +++++++++++++++------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 77 +++++++++++++++++++++---
 3 files changed, 120 insertions(+), 28 deletions(-)

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
index c05c2b744981..f73d8a92274e 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -27,33 +27,94 @@
 
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
+static int atmel_hlcdc_of_bus_fmt(const struct device_node *ep)
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
-	if (ret)
+	if (ret) {
+		of_node_put(ep);
 		return ret;
+	}
 
-	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder)
+	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
+	if (!output) {
+		of_node_put(ep);
+		return -ENOMEM;
+	}
+
+	output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
+	of_node_put(ep);
+	if (output->bus_fmt < 0) {
+		dev_err(dev->dev, "endpoint %d: invalid bus width\n", endpoint);
 		return -EINVAL;
+	}
 
-	ret = drm_encoder_init(dev, encoder,
+	ret = drm_encoder_init(dev, &output->encoder,
 			       &atmel_hlcdc_panel_encoder_funcs,
 			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
-	encoder->possible_crtcs = 0x1;
+	output->encoder.possible_crtcs = 0x1;
 
 	if (panel) {
 		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);
@@ -62,7 +123,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 	}
 
 	if (bridge) {
-		ret = drm_bridge_attach(encoder, bridge, NULL);
+		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
 		if (!ret)
 			return 0;
 
@@ -70,7 +131,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 			drm_panel_bridge_remove(bridge);
 	}
 
-	drm_encoder_cleanup(encoder);
+	drm_encoder_cleanup(&output->encoder);
 
 	return ret;
 }
-- 
2.11.0

