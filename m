Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1953C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937842147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DA7jd/oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937842147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeHWL7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:59:45 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:25461
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730887AbeHWL7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7N1gtDtopN9Bj5hi02mic7VQhDI6D1BJ8W5RGT04Z0=;
 b=DA7jd/oObqy/yJtDc81YQRujIpLFZRAoP+eU2ZfL3z3m8iDqredRrzWG2j92socvPqPzX2WimYjxqPpeB/4zIvLsnXjxzjZoapPpExjr3Kau03THTXZ2YoF5Y62nIl4PbhA20EwKpgUX+71sEQAdFTxmEG/0YTxr7dDj18DMX1Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 DB7PR08MB3530.eurprd08.prod.outlook.com (2603:10a6:10:49::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 23 Aug 2018 08:31:01 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v5 2/2] drm/mali-dp: Implement plane alpha and pixel blend on malidp
Date:   Thu, 23 Aug 2018 16:30:20 +0800
Message-Id: <1535013020-23737-3-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535013020-23737-1-git-send-email-lowry.li@arm.com>
References: <1535013020-23737-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR06CA0129.apcprd06.prod.outlook.com
 (2603:1096:1:1d::31) To DB7PR08MB3530.eurprd08.prod.outlook.com
 (2603:10a6:10:49::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 134b3b61-bf43-4e9a-8abf-08d608d2c570
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3530;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3530;3:ZDiPzyw7hx+fIt5xBHb6a2nkrJT95h5Y7cInfkvWvkiUumCADGUZNLC3yHBQf3ONFbIjhP9vCxgj8zx69IbGcnu8Hb+Z1ksBJRrmCPq/lM42Mg1lB+HgmPJlOUokdKatHxJ3Cn35aPe+2XHaTxDzMq9ktEpThT/TFFE1VqYUAzinojgYPR+1JQuNj189KfUMliGg4dC4ShpBvSOHMIwXXYugtgI7fUzXSLksBs7/uqgB1q//VsIKIVR2faKIwpLW;25:Jc8S+3152OiyZL2ZgPd7nBo9zp4hjjeqYemIIEI7LBiIFI5IqkEMk7sHKSEpnvu9TQVtHV6eL5X01G9bJf9Qz0f1lLLm7pM39jOnnQNontzdXRHll9l++6IZ5feplDgxzUlLSmGwYASlrfXNUTjG2dDAFeFecJckqw+VV9zsEtW/fTFTwuOeVaZkDY33UxtmuETrLOvM3MQg8SYCVek/2WOwERg6GVt7GT05HgCNSHfNVHIZMZlOKp0DBtecAbsGKLFONz3/0nqxsuprFq8aeDQdjiZj3VOE+/c/fA+G6zzvaY7btn2ea5dtOin1qJrwjloZGWkXVONwSa4ENMIi4g==;31:jFgDnNqz5ysGKFVMQO+3Y4KnORPgBHGIKvf00OEDwrkx/tMc7BymqTXFitUFOp4mh9lYxUb743jZ+yXBdDP+cSeMpN6Ss1RMq0OrefNig5zAiYkQwMKluhe0aHbmLH57FMF3CusGQZ3dEekdg2Swh4qErkKKv/QI7ZNy2N+txsSxuglG6oX06gZaKveXzlrws8kqP6L48Y5zD9Bm1+KeemPZMbRmCeqhD8k+PmPKB8o=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3530:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3530;20:k1j7dYuct+RtohsAopqzILgoUkW/a5aQE31DxgovUf7HSRE49m7J1+XsUy4nfPiIe+goBnnvwJgumHXuBERvs7wO6V+d7fGuOkOEEOmm3GjdRFVpVyoZiHk55HGFKzEljaPHukiU4qA16nD+thoVK1IAQqShEHwLbPfyiE2CpI7VeC1o5wl1k45QWVtfD4kgrkJK3MFgCPh8Mm2Nwnl50ke+Rm5ofFIGaiH4wUh85UfcOH1q8GtU0WVBH69U4/9bHI6FcDWB/dvAu/DuBsH2Qyt3O+KSBsCQgIJ0hyb6ZHwI+vq8g+8I2IwzDoHKytMIp/HUfk/5E+zWF7jSHwBtOA==;4:8jB2rnd/l5cYfzRzgkwJMN+0DM+INP00bvSqCsBIMHlqXn+VDN91Q1GRkks0rMD2zT/t+HSp182jQprlK3ye8XTC4IlwrA8HWhoQaXBu60bCTFADKjMW9wxgex1vDuO8WRDUs3c9XF+Va4IFCHs8EJLe6OHLn+rbx6C7obpRbJMRNzWNzx9h35Hncymfps8zYxvQ7eIlpwbLLB9Ku32vdFagGHFPLcGlIo5T1qs1HRPg5Agbq4+zgxeGj4a89CtGcWBO4yHLROSgGY9uP4ZTFrDwOBYBkPgTWkQNIwd1WogJZZL7AgQIj1XAkGwfHNPh
X-Microsoft-Antispam-PRVS: <DB7PR08MB35302CC6B61A7E8F7B8236089F370@DB7PR08MB3530.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR08MB3530;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3530;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(305945005)(16586007)(476003)(37006003)(8936002)(106356001)(14444005)(5024004)(5660300001)(446003)(50226002)(2616005)(25786009)(956004)(72206003)(11346002)(39060400002)(81166006)(36756003)(2351001)(4326008)(8676002)(48376002)(6486002)(34206002)(81156014)(486006)(105586002)(316002)(7736002)(76176011)(51416003)(52116002)(2361001)(7696005)(53936002)(97736004)(16526019)(386003)(26005)(44832011)(68736007)(2906002)(6116002)(6666003)(45080400002)(6636002)(478600001)(86362001)(66066001)(3846002)(47776003)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3530;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3530;23:uXtk7XIo305O9WnCaZLJedscrM6HEmCmGMzf6WxA6?=
 =?us-ascii?Q?PK2QXP7i1Aw4AuGEZBEIoBkH/kBDkvBsBP6+5ICjZN3448SgnBHvrRlmmwCK?=
 =?us-ascii?Q?OTWUS6J9KrEpiVK1bJ8Hn/Bl0oT2cpRlLMgNRBLJckMFR13/oQsssiC9j+gz?=
 =?us-ascii?Q?QozPKZVEeR/lm1zEURfnS2EyzDw1xS5pvyPHO+6TCxi2nGgHubXWSf87lQBZ?=
 =?us-ascii?Q?j4D5s9tAS8bSwFMJbZMNRD8E9grVByJBqvO44PHnl9RNNdMnoX4tNA0zwNt2?=
 =?us-ascii?Q?HN4zxmAFzAIie1r+SXLkVg8M567MLor+rOWRhiD2/W7R8N4Hi5tAmUEokHuE?=
 =?us-ascii?Q?edW4s6Ngu5Aycw6woZKQAfnyQ8xFWLuWxbPtJWSgyJGp1yx/GU7Zyxq6Tnqi?=
 =?us-ascii?Q?6c34ngQjN7vlzb7NkgImFZM4yw5IFDCd7UA1kipiIjBk/r792d/23IKuOkOp?=
 =?us-ascii?Q?F4tFVzMvxeyMwKFqQsBG6pU3mpUzg3TYZud+jNh738OORwjrJbEdoPwWTYRP?=
 =?us-ascii?Q?kTm3/2TJnVzesr4Q9+TSStcq+VS7RlItb0ZxSWRLUBb/p3rFuOWvB+MHhfHZ?=
 =?us-ascii?Q?Kg9trA8GWPfWBHJLpgoP9dLJFUqbRv38WSVmQfxI7ussBDTW8j/SZ/Xkv6ss?=
 =?us-ascii?Q?GkhqmBNHDSaXTrZQEg420CZc4SrRXpq9sZ3deM80T+F8e7Fz0T5bdPa0WTZO?=
 =?us-ascii?Q?ygOUamuxxC6Q3Vdu5q1yNju5nKPM8gcfXBDzdHWJztnf3IG2cQxX/83fZogH?=
 =?us-ascii?Q?xLLArPrpF1bJnBfLseEWJnGk0/h8YuujsIX9lQPrBUI6Pu0BzokoWhTWLsFF?=
 =?us-ascii?Q?GfCQljcRBRHGUw73bjzFq9O/7grOt6wxHW6//FA3Nbo/Ao6kE9efaUSplYCx?=
 =?us-ascii?Q?2rvHfznTSJwyUalBKW8Mv2tTBrOlEPxymY1wtZk2os1vLXTzIcALSnS+mptq?=
 =?us-ascii?Q?mX6SgW3V3lt50g4X8IgTj7Y8148bS4RHnitXub6yE1KuwNU/hfZmOuS1mfP4?=
 =?us-ascii?Q?utHQnHYUh9QnKkvVSFDDkE9QopK9naDhjFxzU5f3/HdB/lnP6zkkfxkIcvaQ?=
 =?us-ascii?Q?zoVYB5xr28Kvpu65bXGrYMvV3wcq5MFCOpsX31kM0X/6T+lW3QbJ5XCqub6y?=
 =?us-ascii?Q?6ctGIhLOf+ZrAmUqD4vNijjDQOmCKgf7HIHEGf+hqXghgiaqsJhscLlTEVb4?=
 =?us-ascii?Q?LF75E/I4U19GvL1Fw/mBPH2E5IeOHrMR3v/BWOsLxa9C4uznmV0Jh5Nfrrm6?=
 =?us-ascii?Q?+WGaoKbudBfFLPHjTyXecC7oJ4pmyNWpeDcNCxGFkb1GAgFjvRYFQvaFfnF/?=
 =?us-ascii?Q?khGxsEKK4BvGk47pGdphlEFAX3evAUSHcMosk4SnCGe8yfLymZrr1tbVz20T?=
 =?us-ascii?Q?s6YSQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: CNRaAx+OXoVzH1C/JExDAisZRs6tE1tT1nYBer5azedyk9yxYVydeb5+lllmxvFDV1Np1mj+pfvQ5tWM9WZR/fStQbAuAt6ZnJG/wbnIH929F2mMSNDuzNZEF8NpwnxZQCmc5vz0JIZKlkJE5Hq+C4zTSOMKHvN7/yHbuUrpdrbJuCbsZLUqPEssoiKSlKUanq2BI3zHsXb32qjSnPXFx2QSoc04o44ykZDD7jrDFciilZ8L4d5Y9tnHOT7Cx/13mOhWCK/qC5tNNuqrqPL0G3h0x80s73HjOTuaasG7QEHcBmHb1xqLNMJ2TXaM8lM7Dht5Jf5XRY4wVUCQqs/xKE8vDh+zJT5D5mCDOE7JNE4=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3530;6:o9raxz/XZzQXlElotpPS1pBHJtAf+Yl3Ya1NpYVUkRnRkq5U5bLL50E/qvCKs4HpydObyr0TIO/7tPYfWE4MKnm6Xsdj0Ay49DagIxld9ltiRZ8+e2Z5DrXWIk8jTnzVWWwUlPsLUuvItok4SyILWiKCxiX7kr4Y9js3rDIjt2drWI3OvvEG4waK87wToSTOQMbD0i38mv0ZIuZjjhlD3AQIUtRGkjk3T8XGaRU0X80TIZ3OZa2MoYC+4Q+3z1JYVWdkiNPsQReZzTcbEuo0SA4+jsp83ezE8+nTNYbvrFBeq88g3Nx6VO4KEIpLiR1Fx2pGd120Lw5TdmdqF/vLOQGQ7ex2SpR0hTwb34OwMls7U+NcEdMwHVPGdxt1RvfFLHZiS/q6MdpYc/tf2uV5wf974yIltS6gNdc2p783Cs8UD6wQwxK8Bk1o5Lm7eubAeJ7itQUg1yZq0EQtRCqb5w==;5:8npZAEFRiTU+F0v7Cqodo0MSQmZot3b+DN5fTjsUvllilkvgldpTIW3n+CotQjy288QCVOnNfvEarAAA/8ruvcqbbuRn1cvhUkR1ql8wqXULjFuE1nB1gLIx6Jzz+rP+52bRI4FtP8h+M+ObPzLk50mJvQ6FJZ75UwhQzS7WMRg=;7:dFIV/LjUeuHFC9b9/DYtdxg6NpeYuN6IZk+jou0mGyTgun7idwmC0tSEEsDusnBwaeMsd+gccsUIdmmVW6R6e76oYQbqgp6xgQaO9HvmkYJ0bhzeW4BkjgjV+x65VT+HO7buFLlXT/r+izUIerU16q5ZjDVcCeMgRZSY4JEP++0OBS1V61MPI+XP7YoykWyunTwS5lnOPd6ipU8dO3TrUG1qluyvhjdLoy0JUG7lX4JbcTMyugjF0da4mX45Rqpj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 08:31:01.5958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 134b3b61-bf43-4e9a-8abf-08d608d2c570
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3530
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
 drivers/gpu/drm/arm/malidp_planes.c | 74 +++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 49c37f6..17be123 100644
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
@@ -242,6 +244,11 @@ static int malidp_de_plane_check(struct drm_plane *plane,
 		ms->rotmem_size = val;
 	}
 
+	/* HW can't support plane + pixel blending */
+	if ((state->alpha != DRM_BLEND_ALPHA_OPAQUE) &&
+	    (pixel_alpha != DRM_MODE_BLEND_PIXEL_NONE))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -323,17 +330,19 @@ static void malidp_de_plane_update(struct drm_plane *plane,
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
@@ -342,14 +351,14 @@ static void malidp_de_plane_update(struct drm_plane *plane,
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
@@ -362,8 +371,8 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	malidp_hw_write(mp->hwdev, LAYER_H_VAL(dest_w) | LAYER_V_VAL(dest_h),
 			mp->layer->base + MALIDP_LAYER_COMP_SIZE);
 
-	malidp_hw_write(mp->hwdev, LAYER_H_VAL(plane->state->crtc_x) |
-			LAYER_V_VAL(plane->state->crtc_y),
+	malidp_hw_write(mp->hwdev, LAYER_H_VAL(state->crtc_x) |
+			LAYER_V_VAL(state->crtc_y),
 			mp->layer->base + MALIDP_LAYER_OFFSET);
 
 	if (mp->layer->id == DE_SMART)
@@ -376,38 +385,35 @@ static void malidp_de_plane_update(struct drm_plane *plane,
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
@@ -446,6 +452,9 @@ int malidp_de_planes_init(struct drm_device *drm)
 	unsigned long crtcs = 1 << drm->mode_config.num_crtc;
 	unsigned long flags = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
 			      DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
+	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+				  BIT(DRM_MODE_BLEND_PREMULTI)   |
+				  BIT(DRM_MODE_BLEND_COVERAGE);
 	u32 *formats;
 	int ret, i, j, n;
 
@@ -498,6 +507,9 @@ int malidp_de_planes_init(struct drm_device *drm)
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

