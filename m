Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC871C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B417217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="JquZUAnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B417217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeHDNPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:15:32 -0400
Received: from mail-eopbgr50090.outbound.protection.outlook.com ([40.107.5.90]:42739
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726581AbeHDNPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR1K3Y7YCs8AAB6dEQK7G40bpwip1E6XqXJRMNXOwUM=;
 b=JquZUAnM8dG6RGZ0STB/J4J045sh1GyPklZihnFwvuGV124GJ1YBs+O4cuFRq8MOMVZz8pGhWhF8SzTA+k9Yqy3VfVZPNSE15rXPQJHAq4b2+KkBaPNRlWph+14biAkrSPmrbyaM2o8GJYqjHBf5Wa6Mgij6XGSxptGfpoDmVtA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Sat, 4 Aug
 2018 11:15:02 +0000
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
Subject: [PATCH v7 3/3] drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
Date:   Sat,  4 Aug 2018 13:14:39 +0200
Message-Id: <20180804111439.7455-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180804111439.7455-1-peda@axentia.se>
References: <20180804111439.7455-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0301CA0043.eurprd03.prod.outlook.com
 (2603:10a6:4:54::11) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e76233-9e61-47c1-d7a4-08d5f9fb8717
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:bQGRuQmRFdfpYlYZpObhB4CX2zFQfE5SI0jsO4pDFS+IGgD+n2KgMgc1789iHeY/pGuELAiUG0dqn/ofR/m4OFGiF5SgEgSh1aDrj75EH4PZta9BpWo1UYJjwak31XIbIaXccu4bC6Uzfr+cL9wOM3K2f+YL2NxeXA2J/lE2nM8+FooHXjc7bP8DsTCZmLSXyZ4u4HPCL+HnbiYjlTJo1HjP3FHuOIUWnyUxjK48Rt1wkC2Ux45rA5H+gRiKiONR;25:hwFF3suO5WNba0GchFFgt+YU8wlovmTPlFcP9FfyUrV1gAie1vmnvgAYuHTmFZejbaD4GsbhQbFjiKhB+lCsKe485QBO32+EDW6M9e7kbVcmkSiewMIFY92NAPxoQ57Qkgv2A7j1ZblrP0cSlPQrezgjA7hL/363fZW423ZHDNZN6wIVEJwKPxanfQDWvUZk1ADFSJjgCkOcm4j99tv+uQ6QUWBrc4Jl8Csb2zB4g1YELjifnxrtVXsfdc8VzCGxvhvm24R3DcJ1qOIycNkJj+iwW0FaOZX0etEdLVUfSZeDLM1KkVqblL29Uw726thpM+xkHbbaG12jAqKfoRx9Nw==;31:561ALEw4SwennvnAAJkFEIWt1fY8Mkij1eElRbA9d67Vs5b1CMrtKkOIY4OeGgWuPWFIX4lu6FV23D8wa3AoyaTM4rR1RRWifnS9gfP37LeCG77LVRGlAuzKA0x4RLTJ/9txNl2yaNvvJP10lsTzwk7nMcKUCTwZSQxkqzlwdD7jRj46Sjg2WrX6IBydnc2tZU1PuTmCKGTosXfsZIj4DEK31luNF0LS0fyLyxxY5uw=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2451FE126AC6BF5169AE9DDEBC220@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:+RsI6A/+VIAgEelY7BHTXsVomtnBwYmcV2O+2QWb6NuuqSO1hoE+UJbrVttUE2e96XeBOdSMY2go7kCobHiCNElkHuoPxSUYNIAertJB/rR3iDmYpdlyhjGsZYO+USDDwerQiz07cBg1iTtJrWKd0XOhCiRvOxV5EmbLQLSm/B3hH8PagvGZu3c0wn8CAhiRyHefh+1lP76fiKRBB2y6GaXnhf1lOd0w9C4yJyOFHcg813A3DQNJ4GVuOVauAobp7T7yBCkktk/RIapE6KDLTA==
X-Forefront-PRVS: 0754F7E325
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39830400003)(366004)(346002)(189003)(199004)(76176011)(51416003)(106356001)(52116002)(50466002)(48376002)(2351001)(50226002)(4326008)(25786009)(2906002)(68736007)(47776003)(5024004)(478600001)(5660300001)(6666003)(7416002)(66066001)(11346002)(956004)(2616005)(486006)(476003)(6916009)(97736004)(3846002)(1076002)(305945005)(74482002)(6116002)(446003)(7736002)(16586007)(316002)(54906003)(8676002)(81166006)(81156014)(575784001)(8936002)(6486002)(86362001)(2361001)(26005)(16526019)(6512007)(186003)(386003)(6506007)(105586002)(53936002)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:7heloZISNmCHFb18SIAB73BTRIDxbnp7Gzi6/6C?=
 =?us-ascii?Q?xzXWm7WPe3d/TJy8o/0byizbE3Vy4mDcLrRMl+hgepdcvNFIMMcwLb/0z/Ur?=
 =?us-ascii?Q?BbIcDTw7kFsCb56jLq4DALdD0tLGK4VeZolRTOTjEkvAvANIn0UN/IVuPE2e?=
 =?us-ascii?Q?fVyH9eHgL3h0P2vVwkG1DSWuQvEz7fUVXUTwfARUQET0XcaEzspASp6bOU6G?=
 =?us-ascii?Q?uB/4dyb5oJgsmC6sJl6wQ2odnYF7CqIw7kzcPRiA8HpC3VhyPmLM9RKXdpWp?=
 =?us-ascii?Q?Rha9hZTNnlzCKEBjb73x9rImfs/0G/1aFctrZ6kEuE7Zt23YfHhxSHsd98S+?=
 =?us-ascii?Q?tg0bmH3P4At5QI0Vx/8+3Sxk3LWvYiFEtPX/yDbnQDyClcugy5c2V23DzNDJ?=
 =?us-ascii?Q?/CYTUMwrptFYkVnIJt65gIFIuKWFmCw3QQf4dUX00gnnY45zcYXOk1qEK2jm?=
 =?us-ascii?Q?cnGtNoZEffGeWjdJ0DR7aMBbnOWVZlE/flrNpCtWJUDLCGQqeiT7K5Z6e15Q?=
 =?us-ascii?Q?HaOg3i1XoRyOak+TPAh1b1OvhWSACxpvGryzEIyMQX31YF80cPvGBxh/nLAo?=
 =?us-ascii?Q?NUWA9qAv2I+g1qYLTrztKoOlyqLk3ytyyJEt4Va3qahrWcC5R0JecHxAXf92?=
 =?us-ascii?Q?zkYZvSJPh8rTU3BwfAkJRjaAtbC/10PSfAChasxw7DXWX2E/E9Xp0l/AAuAG?=
 =?us-ascii?Q?+57P/Jhr27P5GpeF8TZwoPhtMrz5sDfA0G0RYHarjU12lvXdinI0NblsABvG?=
 =?us-ascii?Q?OeMvf2auiTRwQL4EG8Wn2IYqOAgjTVLXRTx2D97XVjp9+3tIaLk+0DbxjmaC?=
 =?us-ascii?Q?HWKfrVhZM/2uJHMpCCA0MD02rWbdhOffmpYGORZ+yTMSF+cXffCAHgxMc+I6?=
 =?us-ascii?Q?c648WODbOS2wyXEsrqGLqMmmNMVjuXZWSiD5KUGnQMxeq13v82N0C3CDvner?=
 =?us-ascii?Q?2H1hu1OPZAvJcLTFlKrQo/Hj6imKDkJhQc9HL5FtnOK20lIAw9al/a3+D5mg?=
 =?us-ascii?Q?aga9iHG0KboC5fcV3Ouzle2mMCT4J/lLRLQmeTHeVROA8EGAYTaaxVU2lpt5?=
 =?us-ascii?Q?Z9XLQNn2NrwGX8DFcJ+6Fc/ItxfGpjE78a/KW5So903f5/NlJybucEqMeW7H?=
 =?us-ascii?Q?AAjumtbozKTrhhzgGH9jl3U3pHknLnf70HdhrnJ5hPfZKDHWRXzzEEcNNQG4?=
 =?us-ascii?Q?nEKkxRdl9TsxaZfoMzpAf3XocVCUQEXo9jBi9hRU/QexucenvIqkaFEI7jU1?=
 =?us-ascii?Q?UlyJsvx8NouO8XJ/A6ldPZkK7LwQfe+gn1XwtguRHifBm9Mqw9XpAlMrd+uS?=
 =?us-ascii?Q?sZUfW108vk1FstjwCsrpF3nO5nPJb4bPUk6tRdEILT1mLYkA1DwyEIHpgX51?=
 =?us-ascii?Q?BdTg4cA=3D=3D?=
X-Microsoft-Antispam-Message-Info: EHO+r3+h7l8OmotepWNIkA6qb7ze2gJ5foUE6XdOj+1TImi+1a+XWuFdBUOnUXm5YKQYPxWF0nhV5r/1GoVGVG6+FDOk9VqmfANIEB1sSduhFE37dRnDJDTS8NSlMrhZVmUcpy8iiI0aHbsffN0vncwYzwPAihu9tIIRg/4adrhx9J/SxSvJpnaTI9dwMFHGwGzXP9MSzxUJwiDuXaovW38IXPDSa6C8N7yJB1vnQzZOOXgeoTFZPpMDS1jR5Kwe5veumqLv0+F6HFb1OyPNn+8Z3pJ6Fl9G/CXrwIi8gXxr3TdnjIZicrqZq0r7ppyLQB5ZM/qvcAfwvautNh1SwMpxW/SVKYSwQALCuvYfyQU=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:yc/CTu7RL0E4Li1Lm/OrbZmJBua8QaBbxg9tPL/ETklrvc40gT6UYO7LyZL2Xxuwjx0OTSRdbF/WSQa8AKcaqtOt1ljRNk5OghAdLBeuyPgUsxY1spQppAkJ7+lF9cfp8jA7S3R9CGWVbCx4aq6wUh9LzBxFikXlPv9806iW51arppUmxYk8LFVaeVUGJWgpbMh89CuFdI09kpuqXpk4eCfPhApANuBZF3dlM2GDBWky4+fJEvp+aPVgXfVqx+KijDZGzH1+RHpA3hipHYc5Rj1h+DM7lJeZ/cCJxVq3mUFdSq3QbETXnhkM9ptVVcM0dfsb2CYYlnwxYFVxMxsjsifNQyHFR9A++ajGYD0GDXZ9T4xNn8vD2p+ZT73LNKVMYNPDxbLBtPcxFRmEvt3REGvrtcVXDHri1R6gpQDJ3+TFY5gtEOAqNDPxc5WVG5LKIUsRimQTfjAqdbBYd1WjUg==;5:5vftuhH14O64kFG+cmbc3OJOUcr1Bpcr8Fboe3VDJ7phJNp/5jAMBr6YqopnZZuz0rs04zG/ZE2bJ4Tsawo342JDjvnqf+lKZmuIxlXWwqtf9Yp5z/Qp8mSyczDn9J6ij5cwmj4At8biWKnH2o9FQp58HUH6q5GBmEUolpjvC7o=;7:hULON4f/iEKdj53xPy0W+A2Qf27BXQpFB6luYUmqcD+kTybLT3nZvMLoSD9uBIRbR4+sfHgglopzUHV9gm69LEUjGoh/uAV0diUjM+kABjoTnnIpkbqnkCdGGqxX6Vq/09GVEm/ZWVM8T6Qf6m8ZvAA0wNXLo1Js1CozmdrZ0H1RQta0oTHlXoTHoiq6z3U3H65MNmPFrBspA25DvupTEeHp97+SN5NNZoJ89iQ+Uf7kW2ynxmja3KRbtkntOkws
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2018 11:15:02.9797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e76233-9e61-47c1-d7a4-08d5f9fb8717
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
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

