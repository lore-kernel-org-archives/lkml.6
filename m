Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB69C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370ED2186B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dXsPZjwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370ED2186B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeHJPeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:34:24 -0400
Received: from mail-eopbgr00116.outbound.protection.outlook.com ([40.107.0.116]:49344
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbeHJPeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfPLsIwrVNKLO1BKglGuIeQDqcxo+xiHV/pPe7sMPfU=;
 b=dXsPZjwXCNAnZjk2P/xyQbRqGE6tFr7U90R8S4rNNxCdfMMJAVBepqM6hjO2PWKqaMB3gVw/44YhWo3Dy/R3icMHHlXPuanQeSaIwCqXdlIW8xRPPv14BrCKCN1D+qV/7cvZjnspZcJMoATlGJVDO/1bofE5WjvN3BbaZY9V2UQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Fri, 10 Aug
 2018 13:04:27 +0000
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
Subject: [PATCH v8 4/4] drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
Date:   Fri, 10 Aug 2018 15:03:59 +0200
Message-Id: <20180810130359.9882-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180810130359.9882-1-peda@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR07CA0241.eurprd07.prod.outlook.com
 (2603:10a6:802:58::44) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 082acfa9-0f5e-4d3a-b812-08d5fec1cdfc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:YFZEkYCkG+FCLUzDzi7RtpQeqryiXtX4FPaOSyVDVhvQaSzAVpsDM8L1XfkFj/paKoeN7XYs0QtT/9DmsbLVjYuepZLKNLLdoO0HoqPY75AJWwh1hhxWAQmvjMmb1YhFHbxXVIeTrli2hgc+kUaUOqmRQMzPp0X1jz0eYWQDzoU8y2/QRUm97h5y38MBqZi8u44aBFDc+wDfnTFXDE8VJnkMBTqD0KkaUvlf+fzyXFGVoQkRRNzRNZXGg1F3fwQJ;25:BqYHGuTo18WZ63pB58hqIS3V0mixqufMumRXA2oZO3PFSB7iTnw/49hr/0MoEdTO8pIDzCs22/ZE8Jt88vw3SiPxr0zcuDTzdyX7XtzHQPwT39KAeWwduL9C66B8S+q3qZCDq49Jq9zIYPVGuynx3orJxFeh5OXElMVVERe+Y/glNUU+UF4dhgQfe0g7WlTpgXbCVN5bY0IHuIcb5j73iRhsT74hPmjie3+rUb7fC/lvaQil/BOPU6u37v4UlouydaEMi2iCSbh2mH6dQplZ7prZCNy/vS1phF7DKJo/D1RxI1xRN6yrAJxqyGEfd6/jdUVtZKGrR/LpC/zoC29Zhg==;31:AzTRyfQVLAUPf+h9JWKTzTz2Zq+p89G1EUIqX/+t69ePMN9JZsm2dLNA69i4bl4W7Z2+0MebVAZfNCtGcTlMG0F5FbeL43ozaTeX5T8JhqUeVm1ca6VBroFSMrHvtEQ/SHvtpq5sa5HRoBfHond8VA3x1Vsqx9IT9w6NKLq5lFpIDjSfzEaS8Ro3reX6N5JlchoswGMQv0K+SAhNX2IgWQbSHIyAphnR3nDOpvWLgsk=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2464FB97CB5CBFE3D4AC6010BC240@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:mcLBPw/e/QWDnEt6vx8hvG9XziAvg0p/nclGM0sig+iqu3HQYni/h3J5YAu9ee6TA+/yiJoMZp93jB2y9YTVe2ZIKgu8Tjy4IiUYB2ovM5Mlht+DW4zLWemcVYqqgk85d2e//o/iuJcngMYlCZmBxWcmrllgR6Caz6FyBY6XUwJoAf0u0XJjrVwwqbTQ6u8h+k4PnidgmaYBxVS693WowUORtH6f0oKnskF1iA3hONbqY2woPampcoOLQ4aG9BLvXuCqh63neL8MpNtWJBUxZw==
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(376002)(396003)(346002)(189003)(199004)(5024004)(66066001)(3846002)(16526019)(50466002)(74482002)(50226002)(36756003)(305945005)(47776003)(8936002)(186003)(575784001)(4326008)(86362001)(26005)(54906003)(48376002)(1076002)(6116002)(68736007)(6486002)(7736002)(76176011)(16586007)(25786009)(7416002)(6666003)(105586002)(81166006)(81156014)(316002)(8676002)(478600001)(6512007)(476003)(53936002)(956004)(2616005)(2361001)(2351001)(6506007)(52116002)(386003)(51416003)(5660300001)(106356001)(6916009)(11346002)(2906002)(486006)(446003)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:lEzPdYTYI40qT+d4zpb/uxDVDbf8W6Ai6AbxAKY?=
 =?us-ascii?Q?9BOYbiZXQGccAgIXlkoa9mgbFbq8+haiXbr8DVQYB0PmmGY8LfKrUaRGIzek?=
 =?us-ascii?Q?PEcumrDkfZtRo686QefvM8vGED0Tn6huNbFxR6kTOV/0isFbYVYHhgrmJ78j?=
 =?us-ascii?Q?ar3OcPRaecYPZkE728pDDYyCndi3TSEJ3cUDBane9pz8427SsAc41PSCoq08?=
 =?us-ascii?Q?wsTr0ATkVKR0D0We3EYs4D+el9tncabsoCGyhApsoNhx7XM5Q6JGTg+9l3uZ?=
 =?us-ascii?Q?KYyOJ3IE35uiZDMoYp8VZPuyum4d9LUukmX5m3l77T3AM20z7iFLhVKryAOf?=
 =?us-ascii?Q?XPlejujKryr3vaMjFYC1SA08wwHNyqy/6U7nU4OWR6okUj0SArRgdwy5JE9r?=
 =?us-ascii?Q?44Vvo2UamY/gWume3ZEQ7yWLsZ9A4zlHsR9gJWhRqc5wpiXSpd41VkkMtyAN?=
 =?us-ascii?Q?JHbLrEdvcoEykdesOhpBZnxwPX/0ZavcN5WIZjNCRj198a3aMYgA/PwPVyJU?=
 =?us-ascii?Q?6ECBXBkLwumFURV3E/Coy+w1nD6kfYytczn89G+7NfPopvP1JSpQoy5anJpd?=
 =?us-ascii?Q?G37HbwKQCf8r/BlG27ma3UW8+gdKUS2th0crBSe39etqgRMeXG9vQhhTzKAM?=
 =?us-ascii?Q?zoE92aGxK5NvwMza/VFTX2jWVKSxlIxWWrYSU+7lJzqzcWUJtKah3gOWyRv4?=
 =?us-ascii?Q?n4bQ4S5s8cjALJn6g9g19bilnQGMwg0su5mNVOY1GXP3yWSA0vZ12N3KetkZ?=
 =?us-ascii?Q?HZgIMHQ/6W6mpTGWSOHZ0wRO6eWDRQzXLClvUyVhqBrdWA3s15D7OxwBrpl2?=
 =?us-ascii?Q?WfgKdUtK9x11wSwkffyq7puHjNCzHFA5vx/QXNmgqoPEtxkvISYlN60T8cmV?=
 =?us-ascii?Q?5ipKYP+yEt6bWu3wrkqaLnJOjuqbdqipRn3Rb9g6R8PCvqLCd/tJfcJ/6+L0?=
 =?us-ascii?Q?q90NpP+AamDDFIcUS3LYIJBxJ1vj4EHTp4yyEz+g0oaXyytiaBQfC2CEErH3?=
 =?us-ascii?Q?msSDJ9m6udWNJp7K2hRvlicaA57gs/9LJvf6yEQvVlSyewzMvXcYjUo21P0d?=
 =?us-ascii?Q?5Q7woxqM/c0nu0+Q9VS/MuFsO8W38C41CoMyCztWq2tZkzXVamCYWOSFYpyo?=
 =?us-ascii?Q?pkrxDdGhT3g8KApbbY1D4RgDr09Tf4Z3WJX4e9ntMXDDDZIzpHnKqkLR/Wbl?=
 =?us-ascii?Q?dQE3ZTXVXBnDA5/U3pEgibYHm2qKpuvlle2pEdYwEdgf81plICFV9BOt7xok?=
 =?us-ascii?Q?cHH3Wk9Gm/wtzPtBDhYWe8672pFxVBvyVjXf+xpitl1zCKQdH1LtKyFrVxcD?=
 =?us-ascii?Q?Q1p4pHjQeoELT1PV9teaSknORk7nyC0i7okqte8nLCgbuPUYaEJYudjvgb1i?=
 =?us-ascii?Q?TMdAHAw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5f0kOvlV0eK8HYsAIMnaX1eE96QC7gieCXeDoP4dY5ssemrtQrH7hksfKZjMFAPgnwYdvuMuC49mLREM0PbSUUrLmVBBtC82t7/WcC00jaMEIo/z8zbAHNA+1Zh709k1EiXAT+f+jZZ1874rqmawqpSA1oWxInYmSLdnzuU1cYACWf7uzqC/itgZ3EDrXyKNSASa74IN3DJfIJRcCICc+bblMsE1wYneIssHO04bEt30HPhAZZwT5PFK3rJYv3GmJ7SqtXC7L4sWkIRouLay5bffZ+z59AYgbEg0dKI9xupY/ySM66fVtiJ6uxypD4pSVdz2a6XfzlA9yB0KPh/WA2pmU2dCMMWpib8X4EKC5vw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:XoIqEEQ7ZOdjj4ifYKKCoF0X7EGjAyZ88MM1Bxd6xhjWd6wNYUIQlfHWcLg9R6+Y59VWUpTtOclT4XDBpZ7/OZilWYd5fNKdYIJHGnj4PfClD6iREOijyaGI5higMRyaw+LYMJlr/P+1rh/Fg020LnDTPf4DbKurvQjQJiBrKfRc+CFdLBh2Lii5J72N4gNTXfEhOB5aImouBJfMAfEA4iqpDm0RFug562Ii1+ObURGb6HAu5NE2Q43CHVSWGSlPgimmXLZkufNMxX7fC/3ffzgC1dw82fIchsVhrrv64w2i9x0A8bj5pgeJCi591fz8Xx4LnYOwO0M4ukeVV12JonW0NfLSQ8lvM1hRbJas3z31NERLhq2Po0iAkOrRhQpCje144GNpDm9Cie+2ITJdnEh+Sd4VP720DzLt4mGaITYhLhdOwMBYd/8S1alNe3TG4rPPkpFvN7OvhgU6Au/Cbw==;5:8OFoQD5bb35SKpBhool0vXVazPT7DNanwmumiRWxFuaUzaehKleUS/22Hkp54ox2kjeDjBebBVvuseYKLwXKKNwRbjvlv9Cg7LUwMGlMQvaHxsa7aFQvEAO8j1Klk1Goan4gSEvb8ge4n0T3amKemEdzrrTpjTIb2ee2GZoi3hc=;7:WCFQcCaDwRrG7Ev0BpuZaCndE42Tg8c90zC6yISf7vG8mKLIhR8lOWCzGpOPLyj8OeH2YynCIl4d6AxQF4RME8sSzLXtRWYBzMDDckE8S1F9UmIoIA17EgOB/AGU1uAMxj32tCKgE1wn0307PpgXId9mgF81TfbHU7Rr2QV/k8KZyD0wFmQNsYECVvpnKEVVD1Q9z0yKJJwZovDTmIYDqNfVd8+yaoIZvVrBMZpb43BO+W2UgCzjISt/KB/NPPob
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 13:04:27.2234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082acfa9-0f5e-4d3a-b812-08d5fec1cdfc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
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
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 66 +++++++++++++++++++---
 3 files changed, 110 insertions(+), 27 deletions(-)

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
index 16c1b2f54b42..10ed7c221a3c 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -27,14 +27,59 @@
 
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
 static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
 				       struct of_endpoint *endpoint)
 {
-	struct drm_encoder *encoder;
+	struct atmel_hlcdc_rgb_output *output;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	int ret;
@@ -45,17 +90,24 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder)
+	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
+	if (!output)
+		return -ENOMEM;
+
+	output->bus_fmt = atmel_hlcdc_of_bus_fmt(endpoint->local_node);
+	if (output->bus_fmt < 0) {
+		dev_err(dev->dev, "endpoint %d: invalid bus width\n",
+			endpoint->id);
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
@@ -64,7 +116,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
 	}
 
 	if (bridge) {
-		ret = drm_bridge_attach(encoder, bridge, NULL);
+		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
 		if (!ret)
 			return 0;
 
@@ -72,7 +124,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
 			drm_panel_bridge_remove(bridge);
 	}
 
-	drm_encoder_cleanup(encoder);
+	drm_encoder_cleanup(&output->encoder);
 
 	return ret;
 }
-- 
2.11.0

