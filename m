Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77435C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B14C208EC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="nxq9RWaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B14C208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbeHCJSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:18:34 -0400
Received: from mail-eopbgr00126.outbound.protection.outlook.com ([40.107.0.126]:34117
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732559AbeHCJSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40eBm95wmDAmfblSHxYnQzKvC7vcwL7/NW7OyhfXZlY=;
 b=nxq9RWaHQSejWOQCf26OsyXjpW3tJ5MvML/ys2YBrr41mPF+36LQcIwhcDqf2jXI6wLpm5fPvl7mk/HTuxHjflTOvZdXJ3zJ+FUgx58HRpYB/d4Tg7PMhthy4NJLKShUAW1phU8RrtUNCn1qFXL7QDLNZJfx+X6MqTrQ9K5cYdo=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (10.168.147.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 07:23:31 +0000
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
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [RESEND PATCH v5 3/3] drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
Date:   Fri,  3 Aug 2018 09:23:08 +0200
Message-Id: <20180803072308.14962-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803072308.14962-1-peda@axentia.se>
References: <20180803072308.14962-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM (52.133.96.161) To
 HE1PR0201MB2460.eurprd02.prod.outlook.com (10.168.147.8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57991bb-42da-479a-82c5-08d5f9120507
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:AEao91U3L81WF98LtA56eg+X0DZctRYLcoZR6oCqHK1RDQx40d2ANbzDejNMtX4XrfVmwPmzlSbEsUlieYfK0Gb/IR86mDV4MBh0B5LBly4KnHpJPRNac9TDdn8Ba7comgT9ym1E/v4igt1Gvx70u8hqyYve07YQNAnMX3JuRhP6iev7QR5W1fkK1wMc4dU5aD15HfW/h37QF+E7PAvoY1jrxrGV/1sGUfL8xOES2aFR218M33wbbYYaSybo4t4x;25:q3+DQhqyiJKRyaHJEpAgbqwJfOVLbTfzDkdsbsRcQSIUhMipPjAp5YjzjNIr+ABBzvsE+KzXQtbt7A+sjezfuE5te4lyC7MHCqZrEm4OSb08KXSgmb1jjvS+VZrsIP/9RWo1t4R3zD83KYKii9vzHk/93L498xEd66nB1Pd3xBFo4xAGqP+SRZeDq1r4H1DYYuDiqsZD9YA7ZFWF3qXa3gF5OPRgmKauzfdBi8sdcR5IH7Tc4TXHOMDeX4g9PZqAF+32AO4W0S1dUb46upI90Lh7dgvEgMspKk2I+sAz9NiO1v5IwsNNMh0deE8xQPO8mdOViQ11YMJu1nJcSMb0hA==;31:CgCXJIK0AfuNoTFo5xGyW7P24+fY/izHVG5kIygcp3mr6KRebaokGLTTwALg6XDSj3hsa2GPN2PTOrG80BhPNRsoWpw52NutBBdaqUX5kb0VOdqUPjBwL7Oc390d4fYkYl5XsQL14/MtIr2gRTjJs984h7UYcuLHYbRv6UuPzlHVxR8W0dll1u6mOIPdyy/ZKkf4Jrh0PtoQi+13KW3Aq286Ax96TSDT7a1C7x8Zh2Q=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB246036C00867744EE317E0C8BC230@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:nzj6XqAVszAkRw8RR4OoL4F1cXVDpHrf+exX5DhN8xHh2XZORKzkClJ+1V7Oj1cTCDUpUKOF4VO81n8C8BxctrHrqZ7d2ngLXRe/HW/TS9ATGqy/Kp9Gp++ps4f7ukE4EtEXOgNuyAjuSlr0SIdptgC5k7o3Gl+GmkiBF8C7AMAOZFOfY9g3rESARuBXyTIzgvylAmtKEU5MKlQc9Lqw9pNOZf8/LjDFOdgMc8rOzHhtA4a3ygdpVN1sH7nPlaFLDPEXo1vp1u5BI9JtYAEMiA==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(2616005)(476003)(16586007)(2361001)(478600001)(11346002)(76176011)(51416003)(4326008)(486006)(47776003)(305945005)(52116002)(25786009)(217873002)(5024004)(54906003)(66066001)(2351001)(446003)(956004)(105586002)(68736007)(36756003)(316002)(106356001)(74482002)(186003)(50226002)(6486002)(97736004)(8936002)(1076002)(386003)(6512007)(7736002)(8676002)(2906002)(3846002)(6116002)(16526019)(53936002)(6506007)(6666003)(50466002)(86362001)(575784001)(26005)(81166006)(81156014)(6916009)(5660300001)(7416002)(48376002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:gqnwGaT+CVqvssRRF70LJsAHLGQEACjXosY4eeY?=
 =?us-ascii?Q?FOT7cspDxZTeW19fEFcilKVgNd8oGXqPDDUXDZFyAGgicBObnqmi+/BGZNDG?=
 =?us-ascii?Q?q1joAun4nDsLwEPlyQA2PobqwRYGPFWE2HY3E2N4Eh80EtuCBLQUx29TZjsk?=
 =?us-ascii?Q?IdfCPefOBfWXpPY9soI+NVYd4bG1Yf2GdU7SMoXvbJ4e8V0ms3E+aPpvByjU?=
 =?us-ascii?Q?yNhLmz9oBJXUyVrGzafVzbxQJMUSjkVKz9gxLonFy6oBwB8S35tM7Yq04W5p?=
 =?us-ascii?Q?yLqYTate8cXQVKYdrsv7v6c3GrCkLPIaWp0gEITiHwReTtkeRiEh4x4Gx9+/?=
 =?us-ascii?Q?FOp8gOpUuqZZUhJlajlebqddGSLa3Xb693UWT2aXBKpZ1xR3u3jhp00VDFFp?=
 =?us-ascii?Q?b+zgCZyjhhTzzKBnLYZk/0ai7C7+q9Szh+HhKNuU1tEkFhNCwTW3397QrAK7?=
 =?us-ascii?Q?9yrXoIdDYx7ljSZErNFEKhahFwpWz7fVznJPjLLhm6pQC8FJjbs9wegCnmN7?=
 =?us-ascii?Q?VhODg7a5/4UCRu/lTXEJTJQ4/efY2ihO0sHFIRzrdnoFzTqLCMhoRJh2ck6l?=
 =?us-ascii?Q?S/EGHvZ4G+fn7+0YeoaTodoGRlVYduK7yrya7OFyLzVaOqx5ndxvZa0hOi4v?=
 =?us-ascii?Q?GDV1nJUZwYlIXmAt+RA6gBL0AMHtd3ty+DgYv7BSHyYjE4GKtxQRbWAB+7Dt?=
 =?us-ascii?Q?b0MwS+uG90TBE7sVgCzxmHhYZMNrIC7MeJD8YxNZrEeFonRAdFpvo9YMwLra?=
 =?us-ascii?Q?xUbRneXxizz6MFmHZsmQ1fhvdrzbCDy2E2ELVQNyYKkBcHSji2ubSIha4syO?=
 =?us-ascii?Q?nBVU7Pdr2ECjBiNHkKlqFgcbCwSpvjSPhlp9yQ7eJhC9phgdUg/Th/+w9Qhf?=
 =?us-ascii?Q?C7gfR+0xsgfy+pEJvMSMmCesWVpDfoqr2ydNNHyd2hti2m4PBvXT6tl3pbBI?=
 =?us-ascii?Q?3KORLaqqFmLBy9NIje4MYzYn5DYOwUrw/TNsyyr+ituYA+WnhKkDTv6oI4q4?=
 =?us-ascii?Q?TIBBb8efELqbXWxND6ypQ3ILFdJGfEWRzb1vsmO36Cryl5+EY7mL4Ljwhveh?=
 =?us-ascii?Q?diIWe4gXurCC2rgqz7j0U0XKbScvooFW60u4UESMJP2zoBgu3DV6dg6/C5EU?=
 =?us-ascii?Q?18gqaGLH6GDP7ohjyf0wOGwvCS4Tp6lSh7zBOj6roGlSFHd928+vvzsZ/tUq?=
 =?us-ascii?Q?1tvLcLT7b+ac3UzF3Z8EYnRofcksNRCEc7EJ/6vY9IrBIBZjgMRbeoVOcbUy?=
 =?us-ascii?Q?i4Wul/+MlF6c97Q7MmSlp41MoalgVyTuRDyJc6pZzirH7ItK3/ZuEDBHelQQ?=
 =?us-ascii?Q?qsGDWEhdjqtZT1e2UPeaerEON/5sgE8aGXQspS378xboz6hIzKp4gLfnAeqi?=
 =?us-ascii?Q?FZVhVoILz8upTgrnMA6CAfmxLUVE=3D?=
X-Microsoft-Antispam-Message-Info: 270X46LXAnEn0rCBpiuspvSv78pcNcoos3hko36DCAG3sexOBkXyiqHld2mBYvhiCPz49kww/qNC1W1mhauEu76PdVSoD/bBLmiGBeKxOq6+CVURQXMkZcPzAVQ5MGsU/RdCz66yuW1yLeZnedkNdWxwR9i5AmMoTc+9HUl8daGvEb3n7K+Fq2nFBlqErzfzhZHPvtnjB2nei4sm6kz5KO5gsbpNbIs/LQIzJSamtXi6zi4Tbn/24rNXto4qQhVavq/06JPQiFQdXldkRuCsTeuvflyL9cwj4QF+IWdnCrk4okjgXRGfpLrV7voL2aMlsSgVUgaZfXrsnj6z9jvcNgtbgvEaaC2DhKaPgpkPCNA=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:UNvHGBW3bLwBTfRuIW3rJPknjhFQpJYMtQekws/hfMJgFxJTug0G+j9oQeWIkCtMj/1G0qN9Ud0AmQZfJtP+83AaPGRjJ1nEMcRTCBrmG7OYjkUft4oslv4C0SIGdxWPUjf5cLMfO6tdECVp+hNd9qWlo2yeQl5MF/wAmpzKxjl1iy+dKnlCRinhlEie2wOB+Z8uUNDewheBF3UV/GC/6HntbMCKaFKeZ7tReiXVXj3BQDal0Wtfc+6qsTi2+b5J10pKK5APyfzzdaa3v+cpgRRuTe4vP9b4X9o+0egel5Sk0W2En5cai2WBRxSA8u03v+TRekDLS5UWxUySD9FC4SCCzS2eEvZePy0B9AeXZ9zGMRnRxmKNbMHy4DIn6uUKBRav1pQbxdTa4IqvEAY6ynIR7YGitQS4zr+YuZBLdpUD10UL/9v5Qi1Zkr37eY6kNA6JpSv3ABC4WwXlEh1/qA==;5:VuhcGj1GaUJKmpzc9etOzMotwvwxU0TAOPzlzDwwYmin2iVzGkSQSW32QceSNX/XEV83Q0BHIRXvZojiGm7z7iHFNv8ygXzhfTcEg4ldzTvfwFkpALA1Ftdp5Q7Wy5ZnWmyDQOXNXoXkm5Gv+IVh0nw7k7/UZWdICVNCsy2VfCU=;7:7tYuOU7/2WodnIvGYECNRXUOPdANm9YkSgc+Q/tA29ifZyQiigHR2fPYxqrd6ZPMHivyUcoTnzPa+RR8hw7NAePDxfC+L3ZL+AtohQHN2+YM9M0VZiqlt8ksxBexXoXgpRgCdqLjvxZ2IZgPejW3vmfkQ6TrnJXN0TUT52a/VtXsAtK8JAPrWW7lhUxajMF0p6GvWUV91bS5q7lS9bvCumIHBC9fxofaHECxhY1Fo9y5r7ukvaFJVkVO7oECj1PO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 07:23:31.7368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57991bb-42da-479a-82c5-08d5f9120507
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
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
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 70 +++++++++++++++++-------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 67 ++++++++++++++++++++---
 3 files changed, 111 insertions(+), 27 deletions(-)

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
index 8db51fb131db..db4d6aaaef93 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -27,33 +27,86 @@
 
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
+	u32 bus_width = 0;
+
+	of_property_read_u32(ep, "bus-width", &bus_width);
+
+	switch (bus_width) {
+	case 0:
+		return 0;
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
@@ -62,7 +115,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 	}
 
 	if (bridge) {
-		ret = drm_bridge_attach(encoder, bridge, NULL);
+		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
 		if (!ret)
 			return 0;
 
@@ -70,7 +123,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
 			drm_panel_bridge_remove(bridge);
 	}
 
-	drm_encoder_cleanup(encoder);
+	drm_encoder_cleanup(&output->encoder);
 
 	return ret;
 }
-- 
2.11.0

