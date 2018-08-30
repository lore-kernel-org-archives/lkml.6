Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F771C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38AC20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PxmSzWlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38AC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeH3Ozk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:55:40 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:55847
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728087AbeH3Ozk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lAo5imrL7QmLlWi9mq70pEv/Ke1jQcc49hw/t7Mc94=;
 b=PxmSzWloDN2baWU/jaFm5zCIb0bMQtMee8+1obAnAlaR73wdTcnv/wsDXTHhIXpzbyeJGp8kNZjpCDKumqGg5f0O34gG3olHmFUvhlhLLg1qSV5IXPzHaBaY2IHLt40mvw/ubVw5kHmYaDHpjzxdXXTTSQD30lmDwzmasf419gs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 AM6PR08MB3526.eurprd08.prod.outlook.com (2603:10a6:20b:4b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 30 Aug 2018 10:53:54 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v5 2/2] drm/mali-dp: Implement plane alpha and pixel blend on malidp
Date:   Thu, 30 Aug 2018 18:53:01 +0800
Message-Id: <1535626381-3578-1-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535013020-23737-3-git-send-email-lowry.li@arm.com>
References: <1535013020-23737-3-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: KL1PR0601CA0010.apcprd06.prod.outlook.com
 (2603:1096:802:1::20) To AM6PR08MB3526.eurprd08.prod.outlook.com
 (2603:10a6:20b:4b::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 042d5fd6-36cd-40e1-337b-08d60e66e419
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3526;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3526;3:cmJouwkhBFH0OZtmhafKIEu+iw+qGQhpzO2qA6sAg2F/p24nola8uskRNq/vciXMd9tckDS/WyoBARoKbSZN1z9IMprvA8EBXUkXMsKkvuCej0pkANEtV/LqLZ+d0bbxQXTpqv48z4kfbSd0w0IkBzfpmykiHDYkGNn4JW4fBpOVqCpTZ6O08oO0ghRtKPmiD4lCEDaXFny+SKcJYLVWJn0kjBoRLRlFkrE7JEHub52mnKkn/bYoAOu7q2w8QxKj;25:RULxKC6iRn/VPFxxFScBNhfceznprVm/RgD55koiO+adZ8hF1APUqE12h7sKjMEIN/FJHq8tl+2JVfB5ARF+TEMaU8Ark7BmCBVP9AbBIpSI8/P6dIU8zqlC9KI2WY7GqgRcV/7b1vqJnsE3p5smlXoii60ObOMLsBrSfNIfBX2di8wSXPtatbbkBFWN/iVL11tf8cSIhMQ5OZZ1qfEM1p4btwv7dZJIy/mc7LoNR+YBJwUVAyuORVDwDX3XILzbJOSVH0xyGmmX5HUViF/bs9O4Xafw/xH3PUMnxE/ECstQar3VLiL7XMYenM3nlcqapVfbuQx+VxYKrouGeDMnew==;31:2C1SGzbGcYlwKD3IjY5Bk2r2UaiZGYRzKoXAjoiJ0/IHH9EAOWLKXnuDfyOiQVsmfZR6UJSlnaxaDYRwb72gvHtiNZ1IokLl4g6XAFQvmpQtY9C7+P5ic/lBHqzJVxTbMRxb+9Zjy2zavOpF7Xtr9pexUFJU0bsdA5zBGfSwtXa9um+dD2jm36vd3ZUpLfARFigu0BjwbeDYW7ZhmLnwzQ1oUCgEXe2oAxnn0kp9dbs=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3526:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3526;20:c3SP9HTIdEku3KKJgSOROdnKVCopVSfhC1NdJuubc/MjncHfBa2DuCR4eNIBVuun1qN0sF3R7lZWpxHSXLXI4y1I5SL8sdzXkinXHhGmVBezPhwqOkhPsQXRYXjytHoDempgSgm3ic4woKrXuIhIulCdAbbKhmPkvmyAVpHxEbGUE55+Swm3lo/p81J7ihcfqK4+P+Tpos2hVZ+9u2JZvf3oLEPGLVRiRBg5ehd7ArmwctHN/xuCIb0IirjRudFV7i6xjUc11Pqk4Nr+E3DsCgDVNM3p8kXQxiiqxWYm/Hqztfg/ljW97PZa9/D6GjC6JpV3mz0ebjHSCossPtH0SzGJpdv31hLktevW22sS4bBGTPJ8yHoWAUNfC+jenXqAhIbHdoFXrbHy/XdY0kWz0S5hocoiz7iV2vPI54zV4ds=;4:8mGPIWIS47fwyaFaIPcu+XYP1aS7Z0T/V3z9YxlK4o6lE4TpKVsAuLf3J9yzIXKik3xb6PrlmJRHuRmav+mmYBlG6Cxb2RrCIGzdRQdUCettVDqDQf5aCEHVfJLkIjGvncOuazuXv13E/W/SUnbDqmFr7nPFxuPPQW3umv9j49d9EQgSfxEPgmsbj/cnDMSv/WYuxThoVI5l7PuwVDPJ0Jt8ConEzdZwVlAXPmpg1zpU8KNDHD6B9+Er0uZ658Oy0pz8q5X0g1FfJ0JwN3jNSt7ElkdhQ6lWa/4Y2NQn202ZgpQ7v7UxeLXfL+Phzif6
X-Microsoft-Antispam-PRVS: <AM6PR08MB35269125559689D1061464809F080@AM6PR08MB3526.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:AM6PR08MB3526;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3526;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(3846002)(47776003)(34206002)(26005)(6666003)(51416003)(6636002)(52116002)(7696005)(316002)(106356001)(97736004)(305945005)(16526019)(50226002)(16586007)(39060400002)(37006003)(76176011)(105586002)(4326008)(7736002)(6116002)(478600001)(5660300001)(45080400002)(72206003)(68736007)(2906002)(25786009)(8676002)(66066001)(386003)(86362001)(446003)(14444005)(8936002)(5024004)(81156014)(36756003)(11346002)(476003)(2616005)(48376002)(2351001)(81166006)(2361001)(6486002)(956004)(44832011)(486006)(50466002)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3526;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3526;23:jCuVWCTJ9e6SqweO7rASsFF9ZNumeKAopDc8B6kV1?=
 =?us-ascii?Q?ao9n5FFLEYQyKVrXXEstRHSrunDXc2q49erpox4a1wV5WanokBXwxwS/BQuM?=
 =?us-ascii?Q?YGQPUx0Lhrf8EPzjkGPxVEmY4Ca+yEv+CP3a+nUpg35zWl+LiT6z9q1aqwhQ?=
 =?us-ascii?Q?VaJzkGjpkjAtyqMQvnl6jGyK8n2Z4WBoJk++KCCeeHk53LBx3svTDk2b4Yak?=
 =?us-ascii?Q?7TmkUJ6FqxGcsVGKI5CV4zEMLFNXQwovj/fiRUyODDb4j/zZAU6V5oEEXETR?=
 =?us-ascii?Q?XuT7HFdDn5cMSbphTUoYHo4mXBfL2AEilsER3pD7KPtFPbtyKj54RQK46Tje?=
 =?us-ascii?Q?vaBZMzdoFAxMinisp1ZaCbyXSPQN+5BbZEFXUIT5kZtZwV2DTiFUA5UCqIz5?=
 =?us-ascii?Q?e4jl2x64tD+o2TzZQ/nv0qlhLGdE/O4Nnx7zBS5/WmvCqMjTAXDUwH6Bu7gR?=
 =?us-ascii?Q?QS9+Cd56Mi+K1cRE5jyfs6bVjTtVYAo0RD32TfY2zU/WzkxCzC6D8PxFn9b8?=
 =?us-ascii?Q?fzo0g1BhUvJHGwToj79pbipB5OlzIwU6uTkmEOVzjKs0YrE1R+useAz7Vwgs?=
 =?us-ascii?Q?il3KapsYuk2za+PuTOrwEvnbPMMIc0h79ehujgcUXKkSDCa3NLWRmRBc54Wt?=
 =?us-ascii?Q?8eTb7l5R83LjD8fYjHqwvbFG2WmQXUJx+KoKvuTVay7sMAA/yPm13T3bh2wO?=
 =?us-ascii?Q?qWdz52J6ueezelhyQrbME/rLALFM4VxO4D/Hqg7iKLRNWx6L8pvRCoFcnyEy?=
 =?us-ascii?Q?h3QEO771EfijC14JWlMAvpsZId4GQy8T7tl8Qnx1LR4PQUXzXKcR+wvOpG7U?=
 =?us-ascii?Q?U79XONoFdmx2RSDD85EX7P6HJBpSP1YakpT0otIGoyawfbUQ+6IwWg+9tIot?=
 =?us-ascii?Q?yCQ1QNUejstg0M+r+JVnrbKisgFMSwQ8ttUHcCYoCj+jlfibUFz3rvj7MbZI?=
 =?us-ascii?Q?pVDp/HsJk8Vtd63R1f0XOIrtdk4qXJv2Fs7wxJd/d+OllrlIqq/R4MOnV806?=
 =?us-ascii?Q?9tviAxt+sYjFqKznKrk69d9KX2TjtarLTdYw+Sny98KXx7NJfIAReQdRxwAW?=
 =?us-ascii?Q?DhfM63nS33LxGveouLdV1H5v5rYEq5glF4rpy+PhHo6PUb5PKo6+FbLKD3Vv?=
 =?us-ascii?Q?NI0wMchj5g2JuY0vPueawX+HE5mZFxMtyTB2nK8M4aF6s5W2WpXccgcZPma0?=
 =?us-ascii?Q?6zvvpFqXDKPC77km2x18QavjWh0skoygYDvQsXgJd+TZgaEaIhP8lV/leBJv?=
 =?us-ascii?Q?V3brhT7xjXXkEVDFM8Uc1+VNpoQ+hB3b8l68eONiPAvmRKLM5Xj9HVepRyg1?=
 =?us-ascii?Q?+amrWY3eDFXmTZMciU+dGVwE9DEo5Yxd/jcz4smGTxnQ41MYqDtOxae3K+P9?=
 =?us-ascii?Q?boA25a15maymtt2+7Dzu+hCktTp5EtlgTSQ6fShX3SMiuw/XJQm9oblMhHFH?=
 =?us-ascii?Q?diFYxu4ixvkDfMZiJrpTpE76D3HYPM=3D?=
X-Microsoft-Antispam-Message-Info: CZgq/Nuvu4aLl81W/6yJ9Xkxd2SqpJQ36O02v5Tr6AhYv7GblbZICeKBw5k50XcqNPP60gQWJO7t1P9aUhy6jap/DFrToGqUKp4oTKoLR59wMhIGL+iJZnOygkfeRRElLNSTWR6l0EcOyukjVdU3bPFts3DYBSoSZQgk3T4CofX4o3OOUXgxoU8LqDUWTgrYn0cHp4eKYs0+QU9i95oen2b1UKxvfavBZf9tJZ400ml2ZCf1JNOy7a1sz9aRugcAeONe8pZerQmqXuh85inWXovbS3ML+oPUuA58bEMJ3awuDL0iEzLvWCBj98sVF7u8kCvy9D7RcmFed0wVZq10Ml8al5uLoLLdtMI5jaQS8UI=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3526;6:2iJETuRryAM8+bm8zkaNo4lXKp4t6cVAonkEX3K1D5NLn08xt6Ojg85jjb/3IMmMni6msKnKmmkyC0TkifABrAwHfC4XnaNabAAzEoF00qy2Wkgu+2Uqn6QMxw2uUFJNb777EVH2CXuEOqqijwczYIk1eVH7D71pQgfzoFcoliWRPZgdVNIzz3wj4R6rxz0nq/3pKjZ47dyiZdlhUdIWtnTC+OhuUDhGwtSm/6ZOpIJ1SHa6zPyDKVQCZPVAWmocBHsfjG2MCqnB0CNDgPONGD2lCbtxXhPTEETzGKKSSyVA+7dCIeipJMKPYi6L6OOWffhndpg73wEDGPJ4DDdMNACTw5gDLT/zYIy/KNj/Og4tpDq2WL/d/W3Ubk7HyBses0KL/pSZX9yG5sp6ko7dEDMA6HhuiXX4FB9VW3fJPqWpSrqp6OP03xDCskazwRiP1Rchvu4NwUGDCMdSer95xg==;5:rS7kbv26UYPh+MqYVSsHLnLRvHhPNCpb7QKkYiWpGe72TFdDEuhWvxOAHKAktxGBRXq2zXQW+AwMML7lHjX5IRLVHDs6rTCVCKRR/mGA7XS8wyW59O3SaMQIx2rqgDSFnXH15patCyln7y/NQozrRxY1rBVlWmrNqBDKMYM+9wE=;7:IiubN8nr9TrdRs7o50ehbc6mRq7ec3DPiaFMSrLJjwCa6iecAvRGdmF/z/MQQcjLgFJoapNpDiRAPP+BTW+4qHAc5ZTjwRfjtOCy49gna9x7gCQPO+BCvaL8Zpl28tmBsXsjFIVNjba0LFBu/5xaDdtiJDB57xGtsLdnso/ierjzNyll3AKrAWfOKdmYEns/eP1T9tv1rhvwr+KRKPYrEFnDXgq7DVhqXIEC24dMv2bAhmhtQEO1zvYNGqjGNulN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 10:53:54.1439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 042d5fd6-36cd-40e1-337b-08d60e66e419
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3526
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
 - Updates on drm/malidp, hardware limitation check only when
   the format has alpha pixel.
Changes since v4:
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

