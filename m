Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F391FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E2A20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="P7f9Nt++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E2A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbeGQRr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:47:59 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:36100
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730745AbeGQRr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdamPcwMdfIl9sVe9SEIJU76oiKblhRfaSANUH5EIyQ=;
 b=P7f9Nt+++XNT0F1cQIyPe/JeiATuaa+axompvuSMzqY8FQ8J4otIfqa0wCzNny1mnfPjm7wzUZBYMZaCjo1Pi6QOB0S+5CPPvYfMcapYtk5V/lAc7TLs5jNSCJIzmcxJgWc5oxZE0VMD9TIShGym8A4GUnuCd8aLe8YLBYDU32A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from e113505-lin.cambridge.arm.com (217.140.96.140) by
 AM5PR0801MB1377.eurprd08.prod.outlook.com (2603:10a6:203:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 17:14:16 +0000
From:   Ayan Kumar Halder <ayan.halder@arm.com>
To:     ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        hjc@rock-chips.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com,
        sre@kernel.org, bparrot@ti.com, peter.ujfalusi@ti.com, afd@ti.com,
        dri-devel@lists.freedesktop.org, maxime.ripard@bootlin.com,
        wens@csie.org, malidp@foss.arm.com
Cc:     nd@arm.com
Subject: [PATCH 5/5] drm/sun4i: Substitute sun4i_backend_format_is_yuv() with format->is_yuv
Date:   Tue, 17 Jul 2018 18:13:46 +0100
Message-Id: <1531847626-22248-5-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: MRXP264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::24) To AM5PR0801MB1377.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba6022ea-fdd7-4067-feb1-08d5ec08bac0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1377;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;3:FMwLEpzaZdrWXC+lEDgL+wlbqtgSCiN1M3i3Rkc/yA3fT2lcABO5FnasapjyN81wJIRMqO4iD7he3/pIjJffOYU+2LNx4yEQ5b/QmmqxJDUbLXT1p2HP+BekzaSQJ8tC1hVVlhzUKRJaOW2Zyaz/ngQC6cgEyGhmIbL95g/otQ40DuCn0SgD+h2Q2MirsBVxVn5ToRaJ0z2bPaf8cvD6Y2kSxoomldVotkWCA3MV4di6vzfq85lWBYqNQHQMpv2j;25:cIM/JBnQCAqxlQtn2j7xjZCIdip1pXZYAx9ayuzzjXn1nqFBY9ZqsFpzT2uqpwrIqBw7anRgQ+xd+PM6xbnhOqB3EwHvgN0vc+rq787hAzD1GTvR/k2rhLb50xIYAQiHQT2+VokmQi+hPbJ4Op6McamySj1QUXzvtgyi2d9Wx7zlZwAZNfaYb+y5sRRMrwQiMQdltMoNCNsE7aJ2A10WlZPr6d25nNoj6303gCc/FpfjiH20bj81P4GvPTrq18rDjfZ5bG1/kULQSoTUBoWHwh1E+6jlgCIMaehp2DQ/NKtqFjkzRc1JG30YgtGZKAfymEWUB0Ak5kfr/u6Z/dg3xQ==;31:lo+4Y+7frtc4IO4wE8VT/uHRWayDQAxbdaF03O6/EBOhVkcR112VIx8TtU6iUj29VZmlpMnmWW05vz9VlZOTQtJWc48irEY8El//QGUqvbr/gQNQk0Qj8AfZ8pm8x30DX5yU/X0YglxGlzfs/YtcvJvCzIl9sTRhoHbydni5oxptSDRSNPK/ad4ot/v29S1jKVWvz3jWSSTpaOqHOrA5us5V3kj/MkKhbX9Xcyu0QC0=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1377:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;20:W8nySYisBNBbYbMTR3JYAE/t3d1TESvfNGyky2YAY0ACk+bAMDfq3ERTOyxpRQk1jojvmdtOhZl8+uC5RHOFt2qawxoFfZKuoLZyZymZu/RJI5DhRh1F0K//wMTuZfAxj5GYBaF6Gsk3n6CSQrpnQFyGCyEYO8XPaAv/xLL0hUk=;4:qm+t7c+HlPPwjoQcK+XdPVjKhdjKOcmKn2gHKCi5M2oZ21CIEEKOLmM9ZkqBvFX8psozpbjRIv/hzLzeX43/DLiEg+/vbmz0JQnTdxZ0XZ5qYN8bxEh0fciQktQE8+S6pV4n1+FdhHgVZUc1u+xEMKSvlBceVt+WWgW0Fbu1z4moFr1bn1omdUX2SzrXldli+jp331U/1ZBrP3lOtAmCubFkKCtG8UJHk1ymllL9SWMqZZ6dOsljKKFBl5lJ+Ch0FFvQ2ZO2QzHtdXoq65fBQKOcwWY46RZkO/8C1eBcICCrAacei60PQXDGOetgu9xA
X-Microsoft-Antispam-PRVS: <AM5PR0801MB137714087806024A4CFAB832E45C0@AM5PR0801MB1377.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1377;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1377;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(7416002)(316002)(305945005)(36756003)(5660300001)(76176011)(486006)(4326008)(446003)(50466002)(51416003)(48376002)(386003)(2906002)(52116002)(7696005)(476003)(53936002)(11346002)(2616005)(6486002)(66066001)(3846002)(575784001)(72206003)(68736007)(16586007)(478600001)(25786009)(956004)(105586002)(81156014)(8936002)(50226002)(26005)(86362001)(15760500003)(6116002)(47776003)(16526019)(8676002)(97736004)(14444005)(81166006)(7736002)(6666003)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1377;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1377;23:q5nRHzn2AEAbzgji+cYbbmOK20yoK1ijegk6HYN?=
 =?us-ascii?Q?aK7+BoDuUHpqQbCyXD/6pEqgpHIZwiU7EJ6U1BQXlluQ3m7UWgy/VKM1Dw+s?=
 =?us-ascii?Q?o16Y2TmCR7458Z/heqEHqLAvsPV/1Z4xFxJjis+utZkcAADlpPYBVldfr+bP?=
 =?us-ascii?Q?XvV5ra9/QHCOoH/OY2vPm4QiFStRh6EpmezmqmChhdZNW0Rg227+BgSBAX8d?=
 =?us-ascii?Q?jBM0IIUfutq41fX2Cxbk61AugDUIwJrmPjZ/S0alJ7/pJTzc3T3i0ttBrxGg?=
 =?us-ascii?Q?2Kxb3fjMs/9XCHW0vgOVyLoLDRFe9WAy1NmQpi9kKNo2smmQjRMYckzFVa11?=
 =?us-ascii?Q?oyaZqic5LjHdzZCaZa71KjckjvTDTTww4m9DSJ9IBLZV9feq2irpJsguU8l8?=
 =?us-ascii?Q?VRF9j2Rtvo45HeKbl4JcCC+PuVJKPWtV5rbHF7lnkIHrcdMLm5cIFlii1UsT?=
 =?us-ascii?Q?YpFnwVkrDaLlGaTvQ9UWOgnbJyq4WOxCkHTC5MyCSAA20Ms0VAoYkk1A3Vcu?=
 =?us-ascii?Q?oEpLpVWo42JiBvMQtXb+apeRFyKYUsiiLx33JVysY0DVivdEIc4cSiI4ks67?=
 =?us-ascii?Q?bv4pBwsnX772IbcNP/rFrXP8v8pasbY+mFZM53uNkKusLMxy35dZ1df5WzWP?=
 =?us-ascii?Q?bMrbL2fpqiPKd4P5YLIIXrkm6NdC8ZREMSvd04kBtQB5/vYIXadrT5k2Mf5g?=
 =?us-ascii?Q?4dYqtgEScu2eZ5/B0xaFG61raQxkcvozaMHTNGwfuP7Jq7OXhqeZu0h3l3i3?=
 =?us-ascii?Q?xQb/1XsWuYU507FwG2mChogPEwSraI9YOTbzAtoDcLY0fagaJFsGwz/o27ox?=
 =?us-ascii?Q?l3GX2l5t+w1LRhFkByPRnlv/ggBSS9GOwzyomb6BnUK2TQV62fHEFGNbihup?=
 =?us-ascii?Q?a6uUKT0wNP9LLfYd6XTpBr/n+ARXmpBF5Kqfzbci8d3cmLcwwZlCSdaZllbn?=
 =?us-ascii?Q?Pw08y1gVkw9g65dQK4BNTp9sf0JIdUDTYLcMb0KrZLg5mezbrAFAXxj18IY0?=
 =?us-ascii?Q?YEH1/c8OGOwyOVNhavdlLqJG5uyV4r7MnHj2x58Lh8EDHwvSNEiwaPvVHhKf?=
 =?us-ascii?Q?01Q8IgZ1l3qV45MZHPthE/UlHbwxSK6B6z6zWNtAxwKbMWKjSfAQ9y8XpNcl?=
 =?us-ascii?Q?dkLGBlpPoCAtS4/kz3mIExiMJl1/GmW5cgTbbH+nFIBop8sTSFtEf58AHicJ?=
 =?us-ascii?Q?i8jhIW/FD8KXFi0nm+pLzR7eTHfVcSTq+t9gmBC6YsspKC3B55wHtfRno6Jj?=
 =?us-ascii?Q?kTfsWkImDa5cpyWS7u88=3D?=
X-Microsoft-Antispam-Message-Info: tPGy0RwULwrAIYjpvbyD0P47YW2tr6ttj1Lkyw3NND9NI2MKETsebU6v0oD+jEDJl/+CNOQAXlucg5V/3ha9oCJ0bwieklZDbZR8MaQm/RF9BWtGT2uI2ckJGuBYhAx78NuTNnI/7xYtwCjicvrG4i/9BGtaHKN33hRGm8xi6uOQywJzVuq5pcJF4PEEyB4GoKWCvoTGqNK4APGzRDPescU/VqqG9NcwNpXfiVK9n5bkQCjvNdSWmr/3uDGa/JdsxsZfH6UOR9Ysj3sGD9Czb5sQtP+xeoCiYrodeXZAeQ16DDMZ33H+yFJiRxa3ZUFPjAgNp88rh0WJ72bTkQZq7EH8I0nU+R5uol/0olTEOTU=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;6:wBLKELGBW8K/hK27Anqp2EgU2n4e6wHp/fVgWPublALmvXV8bdDCa3zo31kU4h7ruw7qiKpu2e3s5oIPIOOGysgE00xbhdzvg93XGcyg5RoTilgElx1z4g0NiYZojMVjJh71wiUubJgXBFJoImCzt72Vzxyz3OZezoKvP4rrVU1vVaDdf5Qb3QlL44GCBDrvUuq9ztg3MGlgzgVlcdJBQRxj0ejjclCpvSBrG9+QFP43P+wlgD+1/t+U4JXQWY2OxSEKSbUKir8+JdNIUvGU8IWL2AUp+hJADrS8Kp3MJcu9sWBZHtq2zsnMU1NgKg2tyLAQUDcLv+EKXfvrRxQYlMIpbUQgQqLgn+DVKs6kOEOjdwgvMpSiEC3mytNaOdgq/7dowqtGctL7mYRwoZOoNjmqzaOlRtRWVH8KFOOpWbExsPhjxcs0wIuCpRYE/18as5jNYkYoWcnH2nk7Nfnqng==;5:fDXzzOlq6cQtuiTBG5Wi60k/zg9UevHnKO3yFLx8IsFPYzb+bk6kRMlMfBLcIEXd/eD4v5e1LzAwephtl8+oK76TDslrVC6AxBOKffREIVgs1BYNXpoab7esWLLdFDmhMzYFQmbsBjezzvkyUM5iafAXyHu7gdLH8xv7CaYY/+w=;24:O4JU637OnFEu/XUdH/G/rY9QP6XJaZ0uqITOi0Aa+kmtM5ys7cU551Vv0ghfrPGR/q0YvguV24uGmw136NlTcUQN+xk8nDg182ujEDyaB0E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1377;7:WgEc1yBR71Z00C3ewxZO76/TorDP9R0fq9fk+Y/RDyUQ27IPEjmLjtcqqS/IaZTGpM7ePBGuAQrhPpmyAAc2d3lyetYRLkq6jSxxr2BvUOW1K73tok8gntT1guDUFL/ihSpbV0cCkMjkQV5CvfMSyUzqT5mqt8AfhEYo4yWCIkARiGeFNloh8TRV9GvgEaPL1rOneECIGw7n9MJY6BfpfapPJGw7yauNsO+MjYeCVIsmMiEbrEH1Pk1cHDlrqlgv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 17:14:16.3913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6022ea-fdd7-4067-feb1-08d5ec08bac0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_format_info table has a field 'is_yuv' to denote if the format
is yuv or not. The driver is expected to use this instead of
having a function for the same purpose.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index de0a76d..d7950b5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -86,12 +86,6 @@ static inline bool sun4i_backend_format_is_packed_yuv422(uint32_t format)
 	}
 }
 
-static inline bool sun4i_backend_format_is_yuv(uint32_t format)
-{
-	return sun4i_backend_format_is_planar_yuv(format) ||
-		sun4i_backend_format_is_packed_yuv422(format);
-}
-
 static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
 {
 	int i;
@@ -304,7 +298,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN,
 			   val);
 
-	if (sun4i_backend_format_is_yuv(fb->format->format))
+	if (fb->format->is_yuv)
 		return sun4i_backend_update_yuv_format(backend, layer, plane);
 
 	ret = sun4i_backend_drm_format_to_layer(fb->format->format, &val);
@@ -384,7 +378,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	 */
 	paddr -= PHYS_OFFSET;
 
-	if (sun4i_backend_format_is_yuv(fb->format->format))
+	if (fb->format->is_yuv)
 		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
 
 	/* Write the 32 lower bits of the address (in bits) */
@@ -502,7 +496,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		if (fb->format->has_alpha || (plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
 			num_alpha_planes++;
 
-		if (sun4i_backend_format_is_yuv(fb->format->format)) {
+		if (fb->format->is_yuv) {
 			DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
 			num_yuv_planes++;
 		}
-- 
2.7.4

