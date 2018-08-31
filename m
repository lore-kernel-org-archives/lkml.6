Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9DCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E25320837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EzzKhTuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E25320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeHaPnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:43:23 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:21952
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeHaPnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=538aCF+S9dKiP8cxQ+yApx0uKTGj49FhIL5yureZJA4=;
 b=EzzKhTuRVG8+jrsHv9jg//fVTE4Zsk/o2eN+ynJ3GFeWQA/7+GZ00k+9Wn/+YdjxO3qhjeVTaHeiypeoi3y8lTikkeSqvbATzNaZ8fSdAq8x1Da1HSwAo26n/pW8+LflBOpTOx63fRYZzf6maFduj3nypBFvBQiGkoZQYxr58KY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 AM0PR08MB3522.eurprd08.prod.outlook.com (2603:10a6:208:dd::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Fri, 31 Aug 2018 11:36:08 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v5 2/2] drm/mali-dp: Implement plane alpha and pixel blend on malidp
Date:   Fri, 31 Aug 2018 19:35:30 +0800
Message-Id: <1535715330-25859-1-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535013020-23737-3-git-send-email-lowry.li@arm.com>
References: <1535013020-23737-3-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR06CA0131.apcprd06.prod.outlook.com
 (2603:1096:1:1d::33) To AM0PR08MB3522.eurprd08.prod.outlook.com
 (2603:10a6:208:dd::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6605109d-a4f9-4df8-3490-08d60f35f44e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3522;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3522;3:+78MUBmaRf0pANbJo+SmsH229jaGUWJnl4DtbyiOjT9N1MHuE0aeIyunc7oapGn/SI/0vwiJelbMEO0tQHfMlod1Ex5htAOsTJrtgjq9HLlbO2eg2pd9W7oUKNOYtWb6cHFJtSIN1fabjXthWsk9gAWu/BjfKXq2EHD7ILyszXQwgHzB+Z5n4U1ebHeGibWuKXQ0vPizk4GwR60lmv2KDzz5dIUG/7EsWPDJHjaGqDwH1b/b6CPzNQ4JzfMTi0SZ;25:W8qKnaKMtgPDWukjtLZlkyUUucCj3+qMhyOSQdumpx5TeJwOwV+e6wh3zApPumi1m0tJbfazqoeVEgKW3CM22KRwmRFLbP1zVBOiYpaRVWd4nDpIhyIjAtne3CO0QfoezlT1njR4I3t9fHmvMnuiGHFnbsFgoN5tOK1T0UaC8V9+5OXvIAb4VTGDzYKo9biWJR/UYKNN6m7TIKOnEXMx0Pfql08ijJQD/zl5O3NeWaEvsEFuZA+9BC93lloLF3HJGNHDxGWOsCTSnxs3RRJJ4xtDPURBv6fTBBth5Zx0iO19JHEiSu5Tz2u82QG1VAnN0gsIlAXkVWdj7t014qQzcg==;31:kapXBcMqHspECEL30LxqM3xoQZ0Sk0xom1ZRwScvzlW/ruk3WfjiskkRvKgGVv20KDuuVwrbv0La05A+nzTvkow5hLBR1xlZoc+eGq4sso2GAdw1j5DcO4/apsIYLuiwATfhlC2Fe6koseD71/VbYOiCszcbpZOv0S/225r6LMS9d9es8MqEh+Hz4CvZx8DhT5wBBq9JAiGjvHhyC/LG+lF1JE+lLiXDAM0a+YB8rB4=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3522:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3522;20:Rvh+lOwHVy7+SuHenfK1QU5Eqn2vTWDSa9k4XDLwdL5+O1n4IKFzXKuo354/57L4YSo/485bulfMBu+OPHQW7nzPwR1b3IQKaN78DwbjSGB8eEOeSRHYxPu1o86xgsPrYi/L8+jg94M5xli41tVaeWyV7eoED1Bm/PEtMwhbU1A21cLiLc2PiPAlqQ1XTZVm6J3BDoYuAkaIGQ0IG/VT2WqstvsH5vKiqaKM3xahstg9/7RJfDOQV6GtWwQyfhwMSu0HTa05gRxmUVr93S/zB3OXgoWdmXeq6e166Bndj1c4ib2OGlq7bCQMtT6eZ/IDBqI4uinYMRYKd64r91I2p2BVnXswLLiaDxh953xGRuJ8fE1IdYClkQQZ0T33gdK09dJpz0N83BkGFFOSPRK0XYZSt6dRGMV/2JB0Py6pK7Y=;4:LWHx2riLWnJw7bSbXabZLU+DS1HU3crKHHeWsJC3RLgSMDuWdZJcgbCZU9dYwUeMSv7GGkBy4wtUfpYK30zqveQQZQbcFv0XNX+nLEnhkugApx0lKCewXsxXKW4enGN/TYPN0hFReyTzPpGBIMJMunbCkIUwf6M6jkQmI9h2pIUMv4/gbVOjteR5KqwqCjVudqw2d50rimwroFPM4KUvnARlUoX4kFYcaKTLWdIDhnIWrQYqALdy70FDyPsTbgF/cDn7MWuN2g8+ji5KzthlSkYHs53zmVuSdQoobWxku89OjA5YMllKRwsnNw/25cjX
X-Microsoft-Antispam-PRVS: <AM0PR08MB352299C6574D9B0EEDCAAB0B9F0F0@AM0PR08MB3522.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR08MB3522;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3522;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(486006)(2616005)(956004)(6636002)(6666003)(86362001)(68736007)(16586007)(316002)(44832011)(14444005)(53936002)(26005)(5024004)(37006003)(5660300001)(6116002)(476003)(51416003)(52116002)(7696005)(3846002)(6486002)(76176011)(97736004)(36756003)(81166006)(81156014)(386003)(2906002)(39060400002)(50466002)(11346002)(34206002)(8936002)(446003)(4326008)(72206003)(8676002)(305945005)(25786009)(45080400002)(47776003)(66066001)(478600001)(105586002)(2361001)(2351001)(106356001)(7736002)(16526019)(50226002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3522;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3522;23:0lWHURwm9lZnNmkEypBrJHgjxoAmRbeG14k/NBGYJ?=
 =?us-ascii?Q?x7c30teEBKd5uqnAJd+1I/6pXDi273q4n8zGyWrXwUbdCMReZ5AncxoYzey/?=
 =?us-ascii?Q?5a70uWHZ2zY7pFXVn6VIeiOef7WULsPVgplsKGRW83DHhPcfxTaMUKD3R9WT?=
 =?us-ascii?Q?OxX+SC/hhJCkzKjcc4EFUg0qg9QcOen8+D1GBJOlyi6OvVW/O6FCXLlZQpqS?=
 =?us-ascii?Q?G0lPfAa3z9sta9kNTdyV4gerThXWr4Ubj9ikePEJLS8gnsm58IgzMIKfDHI5?=
 =?us-ascii?Q?kyL9E+9/O56J6HAfHeqrNspkZ1VoJFUFwtCfH4MAzi8XGYiyPiIPdPUI5xdT?=
 =?us-ascii?Q?zCmhp7CN8aHqKExIabaYEy7Ym72d7CF3tR8/7OmT8RCk0NEXWrYh4gral+Lc?=
 =?us-ascii?Q?Q+9CYfnkEfUFNl+qDQUkDpFkMPv0qT/038zYyutJ+Y0qLVIrT7RZOiLg9a0z?=
 =?us-ascii?Q?yd12U3C53dYltYmI/QbtKlxNy4yzZI8TyiTDBG50/WQdEfM2CyyJwqB/+TV2?=
 =?us-ascii?Q?Ib0xkMtXiT7kuOjIrkTzog/6ir5Mn2ReFE/PsM4lzroyW7uZPTX99vugZHM0?=
 =?us-ascii?Q?P8HorAETnvcE1pCxAfml+hxjjG69EDCXaVknlu/ZSQflnN/V0zKikbNJ80vB?=
 =?us-ascii?Q?PBJlQ3gquVzC906fT8dAmSqA8fv4MgSmblWY8oDEqx1Nznc8/3z6MutByZ7Q?=
 =?us-ascii?Q?dE9pIG3Q4AwlPlayGtih87uH3iIVRQs9jPtwGIPZc2iLBDX/IQ+/LS+9nCal?=
 =?us-ascii?Q?Ttu8IOxL/YmfAVR3f3TK6nsyjM5/3r9r8vNG4ao25YrtXfGMMzqwFLmYeKsB?=
 =?us-ascii?Q?00zog4E4+ppRw/kduYPKQkw9jUyUXgFvbRvQ5OwGw2+EUX+hacmGvEtb+OT9?=
 =?us-ascii?Q?Xikjy+GII5qBrHVJ+hmvLJktBoxM01HyYlqAPXWbwH1O/o6OS4YiM64lPxtO?=
 =?us-ascii?Q?VYq8qP9JGFGtHs1Fx8OeZmL5orLRSsPsTpdYH7QcCcoE9kHhYBEJignIl7m0?=
 =?us-ascii?Q?/lzN86NxNyakOkNlee/6A/ogYZgeswoA4VHvlGZxObMGlGbKlaI8fv58jkoS?=
 =?us-ascii?Q?RgWz4SKrpbSHX5MzWom59Q0mRhLxcmXmJOMEP0L0uLm/J1NAD1j2L6scgozi?=
 =?us-ascii?Q?unzRIDb7jHa9ktDsZiWMMajz7Hs4yRWBYTdsgjpxeSthQjeun95Z9NOIoNZ/?=
 =?us-ascii?Q?5ayfBAFcJAaNEZIfxBlTN28H9rDKHXIXlD72j0UleIKhGzz5ekHKkebtA5Us?=
 =?us-ascii?Q?2cqzzyck5YpmQ/OB/Ac7vcUS/sTxkcJ+T9/19E6YNsdVMM8BSA8ikrCZmOVh?=
 =?us-ascii?Q?X+PVPl9l99TIPeivC2uZjKorvrhMbNoIMICEvw2bNbl92nKuFlH6roUKZVmc?=
 =?us-ascii?Q?2orqg=3D=3D?=
X-Microsoft-Antispam-Message-Info: nx82y775SDbBo9jOUs3ov7+SpkuG5jeFSG1oNPVwxtSNyB0DgJxqamaSoKaOIEenyrhSRGHpz25iU0e2Fnznm7EpUHTQ8Hez4iE/wZk5E2qQx2p1cZHUDmdVz9hmmclEIXgW8oNZ8X3nRXviF1y6HjEtTfCEeE3H81KiYRIkFum5h7hZFimK9uvh8nHGsfjDQl6DvCtplmHAzxfk19TMUJBdSU25HcxknEyLRaa8awlVFEYi5yLMknGOlPX2hLc46CMX24Fw/fQhGVuqTnG//VIt2za8haMhpdZqr2mY0d75AZKbXI0CVVwvxlEYo8vVrT74rTH/GRluloUpxN8jJ13m+VoQxONbTJtfQcWfAjQ=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3522;6:dGUw5X1iLtDsFtEBQmRBV0bK/G6Tdn8eJSkt6AQUX00mbotuKrUpNiPsZKPrtyjKoJ4zhtvwgeIwOkiXdhq6gKjNlCh7ZtJwwIpjS5U0bMVRHaaHY0INCBeoEAZAFk2MvF8M7MpAvtObg9uGZpKcD2tZz8jkOezVgaQSf+ZxLC6QowDXBadgSyjdg3OnNNA1Jih345UOC1lpV5UAC/BQpiZE4LI6Gmu9Fk3f6oiHvegHFMOVaGmabo45fGGAY3DIJMe06o8ez5asScIacXED6QqIN2pGM4DWwhAWENw1HlTFkAz+ux8Kb9wgIGpSofDOkKa4yXivN2N1GqaJGCapeJge0rrSi5tA8YvP8wpDWVlrgRT7uEvdbqUARTtDtlzRjIol94MJ4FFY1gyENyLSZkNK/Hj8KbZ+fCfWYphKkA6Sjdq6SvPzm+mkBOa6e05R+FXw48P9Ts5TTkX2xI2xlg==;5:9wCAswYRfbY/vrgVl4bjUN6PbnNpGVpoAePjW1Wk8wUFpNv5E8rmZ2bywLRBeRZWGDTxPOTSMzKtlO01AG0wYy6V5X+1HNvt3gabJ+un7xTUrOIJA5LjbKKVvo5YGCYCDnGecC5R2ghn+8aTeIeDS/1L1s2oBzLj4jWiSOuS8ug=;7:nACr6cZQMG00WbGVsg5S60/1dGkiGGM8PELZCShfz4hioIDCdExH+vv3hP6T56PjNEBMulY/PxP1MrVMgh3WsHQmBkhxTI2Z+f4oN5aAv4gioqyuq/Vre4OW/FgB2fbIhtlYO3SBSSeTYdNmqxLT2rGP+3CvexsfW8lHrZ+Cu/+gIlqM4HdrRMVb+X62KCzKvyUa3H0wAkmCvt9vijJmd4mj9bQkPFea8SjQekorGpwCM9XFBLVTE/0C7Si5Vbsr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 11:36:08.4389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6605109d-a4f9-4df8-3490-08d60f35f44e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3522
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks the pixel blending mode and plane alpha value when
do the plane_check. Mali DP supports blending the current plane
with the background either based on the pixel alpha blending
mode or by using the layer's alpha value, but not both at the
same time. If both case, plane_check will return failed.

Sets the HW when doing plane_update accordingly. If plane alpha
is the 0xffff, set the pixel blending bits accordingly. If not
we'd set ALPHA bit as zero and layer alpha value.

Changes since v1:
 - Introduces to use it in the malidp driver, which depends on
   the plane alpha patch
Changes since v2:
 - Refines the comments of drm/mali-dp patchset
Changes since v3:
 - Adds hardware limitation check
Changes since v4:
 - Updates on drm/malidp, hardware limitation check only when
   the format has alpha pixel.
 - Rebases on drm-misc-next.

Signed-off-by: Lowry Li <lowry.li@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 75 ++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 49c37f6..96ee429 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -36,6 +36,7 @@
 #define   LAYER_COMP_MASK		(0x3 << 12)
 #define   LAYER_COMP_PIXEL		(0x3 << 12)
 #define   LAYER_COMP_PLANE		(0x2 << 12)
+#define   LAYER_PMUL_ENABLE		(0x1 << 14)
 #define   LAYER_ALPHA_OFFSET		(16)
 #define   LAYER_ALPHA_MASK		(0xff)
 #define   LAYER_ALPHA(x)		(((x) & LAYER_ALPHA_MASK) << LAYER_ALPHA_OFFSET)
@@ -180,6 +181,7 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 	struct malidp_plane_state *ms = to_malidp_plane_state(state);
 	bool rotated = state->rotation & MALIDP_ROTATED_MASK;
 	struct drm_framebuffer *fb;
+	u16 pixel_alpha = state->pixel_blend_mode;
 	int i, ret;
 
 	if (!state->crtc || !state->fb)
@@ -242,6 +244,12 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 		ms->rotmem_size = val;
 	}
 
+	/* HW can't support plane + pixel blending */
+	if ((state->alpha != DRM_BLEND_ALPHA_OPAQUE) &&
+	    (pixel_alpha != DRM_MODE_BLEND_PIXEL_NONE) &&
+	    fb->format->has_alpha)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -323,17 +331,19 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 {
 	struct malidp_plane *mp;
 	struct malidp_plane_state *ms = to_malidp_plane_state(plane->state);
+	struct drm_plane_state *state = plane->state;
+	u16 pixel_alpha = state->pixel_blend_mode;
+	u8 plane_alpha = state->alpha >> 8;
 	u32 src_w, src_h, dest_w, dest_h, val;
 	int i;
-	bool format_has_alpha = plane->state->fb->format->has_alpha;
 
 	mp = to_malidp_plane(plane);
 
 	/* convert src values from Q16 fixed point to integer */
-	src_w = plane->state->src_w >> 16;
-	src_h = plane->state->src_h >> 16;
-	dest_w = plane->state->crtc_w;
-	dest_h = plane->state->crtc_h;
+	src_w = state->src_w >> 16;
+	src_h = state->src_h >> 16;
+	dest_w = state->crtc_w;
+	dest_h = state->crtc_h;
 
 	val = malidp_hw_read(mp->hwdev, mp->layer->base);
 	val = (val & ~LAYER_FORMAT_MASK) | ms->format;
@@ -342,14 +352,14 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	for (i = 0; i < ms->n_planes; i++) {
 		/* calculate the offset for the layer's plane registers */
 		u16 ptr = mp->layer->ptr + (i << 4);
-		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(plane->state->fb,
-							     plane->state, i);
+		dma_addr_t fb_addr = drm_fb_cma_get_gem_addr(state->fb,
+							     state, i);
 
 		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
 		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
 	}
 	malidp_de_set_plane_pitches(mp, ms->n_planes,
-				    plane->state->fb->pitches);
+				    state->fb->pitches);
 
 	if ((plane->state->color_encoding != old_state->color_encoding) ||
 	    (plane->state->color_range != old_state->color_range))
@@ -362,8 +372,8 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	malidp_hw_write(mp->hwdev, LAYER_H_VAL(dest_w) | LAYER_V_VAL(dest_h),
 			mp->layer->base + MALIDP_LAYER_COMP_SIZE);
 
-	malidp_hw_write(mp->hwdev, LAYER_H_VAL(plane->state->crtc_x) |
-			LAYER_V_VAL(plane->state->crtc_y),
+	malidp_hw_write(mp->hwdev, LAYER_H_VAL(state->crtc_x) |
+			LAYER_V_VAL(state->crtc_y),
 			mp->layer->base + MALIDP_LAYER_OFFSET);
 
 	if (mp->layer->id == DE_SMART)
@@ -376,38 +386,35 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	val &= ~LAYER_ROT_MASK;
 
 	/* setup the rotation and axis flip bits */
-	if (plane->state->rotation & DRM_MODE_ROTATE_MASK)
+	if (state->rotation & DRM_MODE_ROTATE_MASK)
 		val |= ilog2(plane->state->rotation & DRM_MODE_ROTATE_MASK) <<
 		       LAYER_ROT_OFFSET;
-	if (plane->state->rotation & DRM_MODE_REFLECT_X)
+	if (state->rotation & DRM_MODE_REFLECT_X)
 		val |= LAYER_H_FLIP;
-	if (plane->state->rotation & DRM_MODE_REFLECT_Y)
+	if (state->rotation & DRM_MODE_REFLECT_Y)
 		val |= LAYER_V_FLIP;
 
-	val &= ~LAYER_COMP_MASK;
-	if (format_has_alpha) {
-
-		/*
-		 * always enable pixel alpha blending until we have a way
-		 * to change blend modes
-		 */
-		val |= LAYER_COMP_PIXEL;
-	} else {
+	val &= ~(LAYER_COMP_MASK | LAYER_PMUL_ENABLE | LAYER_ALPHA(0xff));
 
-		/*
-		 * do not enable pixel alpha blending as the color channel
-		 * does not have any alpha information
-		 */
+	if (state->alpha != DRM_BLEND_ALPHA_OPAQUE) {
 		val |= LAYER_COMP_PLANE;
-
-		/* Set layer alpha coefficient to 0xff ie fully opaque */
-		val |= LAYER_ALPHA(0xff);
+	} else if (state->fb->format->has_alpha) {
+		/* We only care about blend mode if the format has alpha */
+		switch (pixel_alpha) {
+		case DRM_MODE_BLEND_PREMULTI:
+			val |= LAYER_COMP_PIXEL | LAYER_PMUL_ENABLE;
+			break;
+		case DRM_MODE_BLEND_COVERAGE:
+			val |= LAYER_COMP_PIXEL;
+			break;
+		}
 	}
+	val |= LAYER_ALPHA(plane_alpha);
 
 	val &= ~LAYER_FLOWCFG(LAYER_FLOWCFG_MASK);
-	if (plane->state->crtc) {
+	if (state->crtc) {
 		struct malidp_crtc_state *m =
-			to_malidp_crtc_state(plane->state->crtc->state);
+			to_malidp_crtc_state(state->crtc->state);
 
 		if (m->scaler_config.scale_enable &&
 		    m->scaler_config.plane_src_id == mp->layer->id)
@@ -446,6 +453,9 @@ int malidp_de_planes_init(struct drm_device *drm)
 	unsigned long crtcs = 1 << drm->mode_config.num_crtc;
 	unsigned long flags = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
 			      DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+				  BIT(DRM_MODE_BLEND_PREMULTI)   |
+				  BIT(DRM_MODE_BLEND_COVERAGE);
 	u32 *formats;
 	int ret, i, j, n;
 
@@ -498,6 +508,9 @@ int malidp_de_planes_init(struct drm_device *drm)
 		malidp_hw_write(malidp->dev, MALIDP_ALPHA_LUT,
 				plane->layer->base + MALIDP_LAYER_COMPOSE);
 
+		drm_plane_create_alpha_property(&plane->base);
+		drm_plane_create_blend_mode_property(&plane->base, blend_caps);
+
 		/* Attach the YUV->RGB property only to video layers */
 		if (id & (DE_VIDEO1 | DE_VIDEO2)) {
 			/* default encoding for YUV->RGB is BT601 NARROW */
-- 
1.9.1

