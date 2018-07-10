Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3BDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CCB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DTiI5fTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CCB208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933421AbeGJNT7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:19:59 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:35472
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933342AbeGJNTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9Z4Pzx9VKGHMGJwI06x+L9k9FQL4Oj+bAU2JrjtjL4=;
 b=DTiI5fTqZMDGcERIFQHsM/IqdccVU0u4bc2sYSPUOE5cRBAdGQhqOAbTTCajukGE+HFeuvp3JmN+1uHxDP3n1/Bkekr/R9Ti2XRtLkG2vfx5yy8PQdtLoOEQQBPEAdLnXRfVJMjC7V4nPJOb5qluenzD84Wu9ELeKA0b3tv54/s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 DB6PR0801MB1384.eurprd08.prod.outlook.com (2603:10a6:4:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 10 Jul 2018 13:19:27 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com
Subject: [PATCH v2 3/4] drm/arm/malidp: Set the AFBC register bits if the framebuffer has AFBC modifier
Date:   Tue, 10 Jul 2018 14:18:56 +0100
Message-Id: <1531228737-5450-4-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
References: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: DB7PR03CA0037.eurprd03.prod.outlook.com
 (2603:10a6:5:2a::14) To DB6PR0801MB1384.eurprd08.prod.outlook.com
 (2603:10a6:4:b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba76262-43cd-4473-4a4a-08d5e667c35d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1384;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;3:c0J3qDYZV2OuuDDUMf/Mux5mECXnVriI03nLPjYnnRWdeR1PS2OBWA6pzpM8F2DN6u6LvPmI7DDzJdxioQpWVvsMVquvmt3xBkhSgBfViu2RGCNKrozPHw1h/irH6Ggyp+sTtO/5YJ7FF0BHukXafb2fiJGSUCx3+HbrnLpROV5VMDaFh22TKot4nftrskYZATPEmskh3OAD94wvU+b7dSgWAiEkBxdU/LRTWcxGIOY8ZQ/7oFxxP7277jYUWEIF;25:wGUOfJWMbz5Qyk0fXeJkO1P0pQP4/XmKqPnzBE338bo/t0uvvVis0cMW4ZtPohpReFhY6yRrY0R2ZqWC2P2tRYNJ7ewVHJX4lyJGgLcnkSvKhEyi3ngjYf3ccoSOf6BVu79O75UwoTSjjSnDdcgHmaNZjIdoh1ipeVtqf145AzcNDzCZd0XgydQO6WQe5OWixV+Evlavg0deZB62ptwSXBaF7vUAJGXYUIfGwk6KV4oIsd0u6ZckfkBGnsr8hC2biQICgBtGJvbISSUzAg4y6EUag3X0inaaq2UhxmhoqsJ+fGfsEZFgGEPVk7on7tBMGXXsO4aQj7UWuvz+HpIMMw==;31:q4U8BxNaLmADB8ZVHhgBGRI/lPw9Hv9gAHEwcdErDdQDsbf3FyJn1qNSK1vNpgthsFqSGDNGl/UryeBnNN+clhKL9n+EypqiKKOo04s1dxKVIX65Hy5TIkMCapz9p38jklciSd8TRs9i9KnvUplt8Bs4XClc3zBapUXd9UJ1ka5t4qQXhBoztek9V5JgFqDEv1VpDCDmf5IUWjG3njlFpzykN2xs6X1Wz/SfWUiiFsA=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1384:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;20:QDqX3kg1qaDEGG02TtQSCIdfOd5qZIBJ8wtFhzBX62anyWwI4Q14A44Ulcnlvtg+osFK5+SAlji9Whfj6mtdSTG7YtpnE/onCNWcpxE3vbh301OE929V/+Q/2GDYYpZR+8RssBRZiLJlqcysjaK7/1BDg2TjIa2rQyX1NqQ6AHA=;4:yi6Ar844J39qlq5jPBWgFQXZotLozzSVhuHZWRWP6Q2Zc0AukqGjob8vyuyvyS5IXbRFLIXZ00JoQWWA6ooPG+En0aOvSTU2bZ/1tRrVX83noWtubKJJxbmI9TI5SGhc3bQsrrNRyL9PdusRf7Ahu33Hjds5kinFnFAypVvRj5jKAgWZu+0MwQ/xCLuGgmCspd277/hDtbEsJPUNgUX0ei84M7b6dNp54BOxQNNjuibncKkEC/tn6s8BYWoms5z87GJn8dGhmoW+Bv9bsMdxXYbZsLmdVtVxx6sYz13TPFNmfT1rytfeMeFdDY0U66zC
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1384A427CE20788D20705BC6E45B0@DB6PR0801MB1384.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1384;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1384;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(51416003)(7696005)(52116002)(5660300001)(26005)(386003)(36756003)(7736002)(305945005)(6666003)(68736007)(16526019)(76176011)(8676002)(106356001)(446003)(50466002)(97736004)(14444005)(2616005)(486006)(11346002)(956004)(476003)(72206003)(48376002)(3846002)(105586002)(4326008)(25786009)(2906002)(6116002)(53936002)(50226002)(81166006)(81156014)(66066001)(8936002)(47776003)(16586007)(575784001)(86362001)(45080400002)(478600001)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1384;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1384;23:AFzMfTZaB1AyzR6x+aE3+zcHsMWu1pnyMIFPcy5?=
 =?us-ascii?Q?nCpcp+A0mynXG9R2vHvhctbi/ggym7aqXSGCaFQNOrt8leyKmBxyi4g0Ywwy?=
 =?us-ascii?Q?YtTffmx33u6prB2ySzL3r+/+ba8g3TJRaiUBg4J5X9qU9DNlPwQCbdrCKn38?=
 =?us-ascii?Q?x7x5cdFZhgbtezfLCQenBMYKqpoqOAYAU2D3y4lCP7xkNkx4oTUqyvIAQ70W?=
 =?us-ascii?Q?ORFBwP3TsA2PDzA/ZyKRCYGWNiaJh9hYs1BuRPBDIeuylEn+QDgJDT92S6oK?=
 =?us-ascii?Q?9LtAUc1L9EIaz8r+RazdbKRuHxsjB6xZ/unp9RkyFWFYoCQ+D+y4LlL5lADn?=
 =?us-ascii?Q?ZsHHr5GmsT7m/lfDDvn2sitb+wWmzr1uQTrwhqno6X/zuZvPGnCrxVaI28Bg?=
 =?us-ascii?Q?gnRC2D6INu/idrVt8JvSkv6l3hmhRX2xMU0/jnw85z/TB8p7ant0HwWtc11q?=
 =?us-ascii?Q?SKZH/fltG+czZXymnpFZ/dcX1c6mqZDcJHcSSUWGp4vLxXL3loR79q1degdO?=
 =?us-ascii?Q?ooe8kOnysllr0aNEir8ZYg7kMMb7atX1TUGm7bw8Y+JaCZufBwulTjpxoh35?=
 =?us-ascii?Q?lBapbU+Tq6LX3drZAWwTc9NaRkPqM7v/FDLEZndcoBzRgaCUKrX2nJ4q2Tdo?=
 =?us-ascii?Q?+rOt02jKOr0vz9DwJ5r/DvSdOfB/XeSf2k1BtQOsbi64Kr7WwvUgTGI9hYNg?=
 =?us-ascii?Q?khtGOIS2cnklh6BTNAWNT3hNRxoy1pDRf3ci5uno8zm60A3j1WFAQiIhH42x?=
 =?us-ascii?Q?NHbFDbRnxSMBUh6LEIg/9RhaFlQXnTQTe+IHWiKlDQaIfwV8YNDds9/m6Yih?=
 =?us-ascii?Q?7+D3Thprxr05k436CAytHShARiLFfJDpamuTtbMAWNdSMuVtj9pHeKiuu2AX?=
 =?us-ascii?Q?oP4inLCN538+jDoUH646LReAeYOYKkZBQs/KT9WTMwGUvaKK9NEvkOzIvk+J?=
 =?us-ascii?Q?lB5Ywipri3W8mK6S1A/zSDCmU2OG8IWoogCpUCKmoX5pHrtREU34wEpaIAlV?=
 =?us-ascii?Q?Y0mGqeUe6u4irZ7tpssyOHFIu4SMEQcH823kkZWpZybBhd00rzGn/8M3ZqTY?=
 =?us-ascii?Q?eYipoHhlav08VkOOkDJRnUrboW52kDMKwZQvVdf01eVh20ebynUC8Thace6u?=
 =?us-ascii?Q?Gi+a6xIGbdyco2io0L6BiPcDTIPRg2asrxdlViKuxemh/o1pfGSsJWQorsFm?=
 =?us-ascii?Q?bJrkwM70L9qLQdsd0Ab/Dd6pvKq/HsVBYlEXg?=
X-Microsoft-Antispam-Message-Info: U/h9gbw57hALzvb2A9RUHTyX8kLvuiMaQYBW7E/QwA6O1SoyxpUvRbDmY/YtkiglGS5whyx91750+xaL4VPet52qDht9/N+KDKuAz7B5gWV/nxHUjvXp5cMAW/oikYLiALjZ30NCDmEV0745YjjD0ZY4BI05alLxPqBMIwQgTMgbhn9+FGy8aMG1uTHZ0HG4UaMw/IUZC95dRCsXefwbrItQAPLZPFUR/yKOh6aJM9DEjUMuBXceksmYW7godEKoR+yRBr6BUscd7RB6M9x9mFsG+es+ye+6ifEdqc4i6SPBzX4zSKFxfVLGt7uGjYmp8spHBNhtg4fonD4ESfGC0RuOetvlBtUNSrJcBGXfr1I=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;6:mMwDo1WjBI5PLM47xyQ2TRroRIA+l/lcmM5/myJcKxnPGppa1uh+47bOGDqD5EOfI4GL68aHQUMKsDS7/vQ+oKy83x9OJOAYfM9sP73htxj8Va5/rFFBWCy9T7B76BPCqVovxjigP6heoTNMCW3aCgPohy5UkD30Nh5ZVL8rBFlm8E/0/vDfncUhvtcbOMzspfwwkZDDeGh1u59R55uMAApZmzdihP7XWHB1wvsz5o3FxKciZjIRfkG+YN6EKqiuIdT5s1jLMuDd+kMeJ8pijk+4yBQN4TEii+YhnQg1BH5gvFU9zZgO1cXwl5+xC9JRp59gV723i9Fy4XWTGRH+vCz04JsUvbTvx7ZNbMvww/+EOhPuuH23/OmaEP2CX2RmEwPMRugrivlP7LF2r+E9OKD1edp/COoVqWW4g0AgDE/yeHWypDiRhSe23K/Tl+LIfr7DizkUknq2tXlzOrdOug==;5:Gv8hQoNomYzoBkub96CYaWnXlJXNsqQMb5tBsMT/7hXIUJLiEPt/qnLn09qBl2UiVpNSby2w4zOLNf1KZlItm2GhVCPpZ883tYyjuciw7IxCBR2+mfdRIZ+cYnj8RGELbG8KS9QgOQZUvpRLhVChGlZImLef7ZRyVJ4yDHJwuDk=;24:EnQY6xOkRmsZoLQtt/wqKuVkLAx0dYOBRGr8WlUheg5IfhEhFfwD6UPCWReEXy9qAIOirNkFQAhl0VFLRUHeZLVt2IkeP+lNWFABLDwn95Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;7:he0K7aEKzz2R2I7CYrHm+C/DMI3TdigMj5d52vKtPdiDVTwgLv+M4RXaCUXLKzNVTo69P6cCmsdWAFoI+Kq40nz0zYJk1RIjab90O7dPvg6g+kVzFskMn6DXgdQcGCCObeaN6+XSAEo3uoVyzEjyuFlHyBcPn3yO7B3649YpYr52cy1OoI22DsghMHn/K7pCbAWf/C49OMGNeqdT0FxI0WKm10MhiUNO1QrT3kTPRJEFwH5YGMQgbhLjO4+wnhUU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 13:19:27.3771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba76262-43cd-4473-4a4a-08d5e667c35d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the AFBC decoder registers for DP500 , DP550 and DP650.
These registers control the processing of AFBC buffers. It controls various
features like AFBC decoder enable, lossless transformation and block split
as well as setting of the left, right, top and bottom cropping of AFBC buffers
(in number of pixels).
All the layers (except DE_SMART) support framebuffers with AFBC modifiers.
One needs to set the pixel values of the top, left, bottom and right cropping
for the AFBC framebuffer.
Added the functionality in malidp_de_plane_update() to set the various
registers for AFBC decoder, depending on the modifiers.

Changes from v2:-
- Removed the "if (fb->modifier)" check from malidp_de_plane_update()
and added it in malidp_de_set_plane_afbc(). This will consolidate all the
AFBC specific register configurations in a single function ie
malidp_de_set_plane_afbc().

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c     | 27 +++++++-----
 drivers/gpu/drm/arm/malidp_hw.h     |  2 +
 drivers/gpu/drm/arm/malidp_planes.c | 83 +++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/arm/malidp_regs.h   | 20 +++++++++
 4 files changed, 113 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 4dbf39f..fd6b510 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -76,33 +76,38 @@ static const struct malidp_format_id malidp550_de_formats[] = {
 
 static const struct malidp_layer malidp500_layers[] = {
 	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP500_DE_LV_AD_CTRL },
 	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG1_AD_CTRL },
 	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP500_DE_LG2_AD_CTRL },
 };
 
 static const struct malidp_layer malidp550_layers[] = {
 	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP550_DE_LV1_AD_CTRL },
 	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY },
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_ANY, MALIDP550_DE_LG_AD_CTRL },
 	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP550_DE_LV2_AD_CTRL },
 	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
-		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
+		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
 };
 
 static const struct malidp_layer malidp650_layers[] = {
 	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP550_DE_LV1_AD_CTRL },
 	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED },
+		MALIDP_DE_LG_STRIDE, 0, ROTATE_COMPRESSED, MALIDP550_DE_LG_AD_CTRL },
 	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, ROTATE_ANY,
+		MALIDP550_DE_LV2_AD_CTRL },
 	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
-		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE },
+		MALIDP550_DE_LS_R1_STRIDE, 0, ROTATE_NONE, 0 },
 };
 
 #define SE_N_SCALING_COEFFS	96
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 4390243..bbe6883 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -67,6 +67,8 @@ struct malidp_layer {
 	u16 stride_offset;	/* offset to the first stride register. */
 	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
 	enum rotation_features rot;    /* type of rotation supported */
+	/* address offset for the AFBC decoder registers */
+	u16 afbc_decoder_offset;
 };
 
 enum malidp_scaling_coeff_set {
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 533cdde..0122091 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -330,6 +330,76 @@ static void malidp_de_set_color_encoding(struct malidp_plane *plane,
 	}
 }
 
+static void malidp_set_plane_base_addr(struct drm_framebuffer *fb,
+				       struct malidp_plane *mp,
+				       int plane_index)
+{
+	dma_addr_t paddr;
+	u16 ptr;
+	struct drm_plane *plane = &mp->base;
+	bool afbc = fb->modifier ? true : false;
+
+	ptr = mp->layer->ptr + (plane_index << 4);
+
+	/*
+	 * For AFBC buffers, cropping is handled by AFBC decoder rather than
+	 * pointer manipulation.
+	 */
+	if (!afbc) {
+		paddr = drm_fb_cma_get_gem_addr(fb, plane->state,
+						plane_index);
+	} else {
+		struct drm_gem_cma_object *obj;
+
+		obj = drm_fb_cma_get_gem_obj(fb, plane_index);
+
+		if (WARN_ON(!obj))
+			return;
+		paddr = obj->paddr;
+	}
+
+	malidp_hw_write(mp->hwdev, lower_32_bits(paddr), ptr);
+	malidp_hw_write(mp->hwdev, upper_32_bits(paddr), ptr + 4);
+}
+
+static void malidp_de_set_plane_afbc(struct drm_plane *plane)
+{
+	struct malidp_plane *mp;
+	u32 src_w, src_h, val = 0, src_x, src_y;
+	struct drm_framebuffer *fb = plane->state->fb;
+
+	mp = to_malidp_plane(plane);
+
+	if (!fb->modifier) {
+		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
+		return;
+	}
+
+	/* convert src values from Q16 fixed point to integer */
+	src_w = plane->state->src_w >> 16;
+	src_h = plane->state->src_h >> 16;
+	src_x = plane->state->src_x >> 16;
+	src_y = plane->state->src_y >> 16;
+
+	val = ((fb->width - (src_x + src_w)) << MALIDP_AD_CROP_RIGHT_OFFSET) |
+		   src_x;
+	malidp_hw_write(mp->hwdev, val,
+			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_H);
+
+	val = ((fb->height - (src_y + src_h)) << MALIDP_AD_CROP_BOTTOM_OFFSET) |
+		   src_y;
+	malidp_hw_write(mp->hwdev, val,
+			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_V);
+
+	val = MALIDP_AD_EN;
+	if (fb->modifier & AFBC_FORMAT_MOD_SPLIT)
+		val |= MALIDP_AD_BS;
+	if (fb->modifier & AFBC_FORMAT_MOD_YTR)
+		val |= MALIDP_AD_YTR;
+
+	malidp_hw_write(mp->hwdev, val, mp->layer->afbc_decoder_offset);
+}
+
 static void malidp_de_plane_update(struct drm_plane *plane,
 				   struct drm_plane_state *old_state)
 {
@@ -338,6 +408,7 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	u32 src_w, src_h, dest_w, dest_h, val;
 	int i;
 	bool format_has_alpha = plane->state->fb->format->has_alpha;
+	struct drm_framebuffer *fb = plane->state->fb;
 
 	mp = to_malidp_plane(plane);
 
@@ -349,15 +420,9 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 
 	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
 
-	for (i = 0; i < ms->n_planes; i++) {
-		/* calculate the offset for the layer's plane registers */
-		u16 ptr = mp->layer->ptr + (i << 4);
-		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
-							     plane->state, i);
+	for (i = 0; i < ms->n_planes; i++)
+		malidp_set_plane_base_addr(fb, mp, i);
 
-		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
-		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
-	}
 	malidp_de_set_plane_pitches(mp, ms->n_planes,
 				    plane->state->fb->pitches);
 
@@ -381,6 +446,8 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 				LAYER_H_VAL(src_w) | LAYER_V_VAL(src_h),
 				mp->layer->base + MALIDP550_LS_R1_IN_SIZE);
 
+	malidp_de_set_plane_afbc(plane);
+
 	/* first clear the rotation bits */
 	val = malidp_hw_read(mp->hwdev, mp->layer->base + MALIDP_LAYER_CONTROL);
 	val &= ~LAYER_ROT_MASK;
diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
index 149024f..54f4ec5 100644
--- a/drivers/gpu/drm/arm/malidp_regs.h
+++ b/drivers/gpu/drm/arm/malidp_regs.h
@@ -180,10 +180,13 @@
 #define MALIDP500_LV_YUV2RGB		((s16)(-0xB8))
 #define MALIDP500_DE_LV_BASE		0x00100
 #define MALIDP500_DE_LV_PTR_BASE	0x00124
+#define MALIDP500_DE_LV_AD_CTRL		0x00400
 #define MALIDP500_DE_LG1_BASE		0x00200
 #define MALIDP500_DE_LG1_PTR_BASE	0x0021c
+#define MALIDP500_DE_LG1_AD_CTRL	0x0040c
 #define MALIDP500_DE_LG2_BASE		0x00300
 #define MALIDP500_DE_LG2_PTR_BASE	0x0031c
+#define MALIDP500_DE_LG2_AD_CTRL	0x00418
 #define MALIDP500_SE_BASE		0x00c00
 #define MALIDP500_SE_CONTROL		0x00c0c
 #define MALIDP500_SE_PTR_BASE		0x00e0c
@@ -208,10 +211,13 @@
 #define MALIDP550_LV_YUV2RGB		0x00084
 #define MALIDP550_DE_LV1_BASE		0x00100
 #define MALIDP550_DE_LV1_PTR_BASE	0x00124
+#define MALIDP550_DE_LV1_AD_CTRL	0x001B8
 #define MALIDP550_DE_LV2_BASE		0x00200
 #define MALIDP550_DE_LV2_PTR_BASE	0x00224
+#define MALIDP550_DE_LV2_AD_CTRL	0x002B8
 #define MALIDP550_DE_LG_BASE		0x00300
 #define MALIDP550_DE_LG_PTR_BASE	0x0031c
+#define MALIDP550_DE_LG_AD_CTRL		0x00330
 #define MALIDP550_DE_LS_BASE		0x00400
 #define MALIDP550_DE_LS_PTR_BASE	0x0042c
 #define MALIDP550_DE_PERF_BASE		0x00500
@@ -223,6 +229,20 @@
 #define MALIDP550_CONFIG_VALID		0x0c014
 #define MALIDP550_CONFIG_ID		0x0ffd4
 
+/* AFBC register offsets relative to MALIDPXXX_DE_LX_AD_CTRL */
+/* The following register offsets are common for DP500, DP550 and DP650 */
+#define MALIDP_AD_CROP_H                0x4
+#define MALIDP_AD_CROP_V                0x8
+#define MALIDP_AD_END_PTR_LOW           0xc
+#define MALIDP_AD_END_PTR_HIGH          0x10
+
+/* AFBC decoder Registers */
+#define MALIDP_AD_EN                    BIT(0)
+#define MALIDP_AD_YTR                   BIT(4)
+#define MALIDP_AD_BS                    BIT(8)
+#define MALIDP_AD_CROP_RIGHT_OFFSET     16
+#define MALIDP_AD_CROP_BOTTOM_OFFSET    16
+
 /*
  * Starting with DP550 the register map blocks has been standardised to the
  * following layout:
-- 
2.7.4

