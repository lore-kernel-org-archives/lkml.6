Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeC2JYi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:24:38 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36754 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2JYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:24:37 -0400
X-Google-Smtp-Source: AIpwx48KCnAtXux9WbMLQ6xetneJ7jNHLe5Vnol1mj68yOM0h0T2045UGQZdA6IpTyQumf3gQmfyCA==
Subject: Re: [PATCH v5 0/1] drm/xen-front: Add support for Xen PV display
 frontend
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180329092247.23905-1-andr2000@gmail.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <7d9511c8-c3ed-b834-3f23-9664281d4468@gmail.com>
Date: Thu, 29 Mar 2018 12:24:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329092247.23905-1-andr2000@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------B0F36CF2C88CD34800597A42"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B0F36CF2C88CD34800597A42
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/29/2018 12:22 PM, Oleksandr Andrushchenko wrote:
> Changes since v4:
For your convenience I am attaching diff between v4..v5

--------------B0F36CF2C88CD34800597A42
Content-Type: text/x-patch;
 name="v4_v5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4_v5.diff"

diff --git a/Documentation/gpu/xen-front.rst b/Documentation/gpu/xen-front.rst
index 8188e03c9d23..009d942386c5 100644
--- a/Documentation/gpu/xen-front.rst
+++ b/Documentation/gpu/xen-front.rst
@@ -1,6 +1,6 @@
-====================================
-Xen para-virtualized frontend driver
-====================================
+====================================================
+ drm/xen-front Xen para-virtualized frontend driver
+====================================================
 
 This frontend driver implements Xen para-virtualized display
 according to the display protocol described at
diff --git a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
index e521785fd22b..02b6f3d9fe4c 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
@@ -186,8 +186,10 @@ static int evtchnl_alloc(struct xen_drm_front_info *front_info, int index,
 				sring, XEN_PAGE_SIZE);
 
 		ret = xenbus_grant_ring(xb_dev, sring, 1, &gref);
-		if (ret < 0)
+		if (ret < 0) {
+			free_page(page);
 			goto fail;
+		}
 
 		handler = evtchnl_interrupt_ctrl;
 	} else {
@@ -195,8 +197,10 @@ static int evtchnl_alloc(struct xen_drm_front_info *front_info, int index,
 
 		ret = gnttab_grant_foreign_access(xb_dev->otherend_id,
 				virt_to_gfn((void *)page), 0);
-		if (ret < 0)
+		if (ret < 0) {
+			free_page(page);
 			goto fail;
+		}
 
 		gref = ret;
 		handler = evtchnl_interrupt_evt;
diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index 545049dfaf0a..f3ef9dfb4dfb 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -107,12 +107,13 @@ static void send_pending_event(struct xen_drm_front_drm_pipeline *pipeline)
 }
 
 static void display_enable(struct drm_simple_display_pipe *pipe,
-		struct drm_crtc_state *crtc_state)
+		struct drm_crtc_state *crtc_state,
+		struct drm_plane_state *plane_state)
 {
 	struct xen_drm_front_drm_pipeline *pipeline =
 			to_xen_drm_pipeline(pipe);
 	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_framebuffer *fb = pipe->plane.state->fb;
+	struct drm_framebuffer *fb = plane_state->fb;
 	int ret, idx;
 
 	if (!drm_dev_enter(pipe->crtc.dev, &idx))
@@ -273,7 +274,7 @@ static void display_update(struct drm_simple_display_pipe *pipe,
 	drm_dev_exit(idx);
 }
 
-enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
+static enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
 		const struct drm_display_mode *mode)
 {
 	struct xen_drm_front_drm_pipeline *pipeline =

--------------B0F36CF2C88CD34800597A42--
