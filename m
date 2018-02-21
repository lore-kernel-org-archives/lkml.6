Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225wnj6cR6S1D6+qo7O5QBvbkqXjVvbohIumS2DajMqDAwoirBLgFMdFRtbsHwy+BqNs9tNG
ARC-Seal: i=1; a=rsa-sha256; t=1519218212; cv=none;
        d=google.com; s=arc-20160816;
        b=Xjr3PhJJOcjh2RbC/b5eJx0N2w0ItC8Gf27+n7Lha3pVF9O9LBC6y5AGz/VbEHoz6Y
         C4U97B3yn5bkzUFsd3yEMPTK25mjBr96S1k5vO+KP9C5Sxv+DncuCo8C7RZalWmQjtrj
         wbpv2YwaTZwkZkJgMNxHPRO2egzYnBaK47ZXE7U/YVmxsomhRzzXQFvSFE4RGdPGsN9r
         kMWrMmOMiznpBhl7ifOKLU4fl+SNgI45BpE+vcaA2zTo2VEtN8ahK0C7caoMACaADTD0
         ehNeN81Hx/Xibm3ap0+vKWoOoWmaKDVKrFCJ/v5QxLAXRiLiYJzz5VS7ay626XiTJo3C
         Sg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LSMoOVMZnwwT49qmKVPieRU91rShICp5ufRs3bQAa84=;
        b=dAkTJPelPaART5EmUysKoLUndvpsbVVT7ADmTKKU0R74URo0BcCoGiAxAG46b4lraT
         9zU2/7qMbPJ0wKtriVeOt2Hh8d1qxWB87uI3bBSpvjbhYyHAnCFy1WrduemTUgGdGtzX
         uoP68eQukkbbEjQCvA+QnXt9K5wmZtyhzuObwh83YygM0BgmRVMRfLd/q1ltp1ESLl1k
         4vgS/SyOPFEqdlQzxEPmTAZn0MnQ9dQqWx2gp0ZWiySSd2eC1QnPzA5mDqMILU+pQt6g
         /h6Fe30pJ7xnThffMccEO8Kn5Cmuh+DqjmhvT+Azo1y3idQy4s5berhHV3BWMme0RmXI
         SMZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.14 126/167] qxl: alloc & use shadow for dumb buffers
Date: Wed, 21 Feb 2018 13:48:57 +0100
Message-Id: <20180221124531.476918701@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015756109039861?=
X-GMAIL-MSGID: =?utf-8?q?1593015756109039861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerd Hoffmann <kraxel@redhat.com>

commit 62676d10b483a2ff6e8b08c5e7c7d63a831343f5 upstream.

This patch changes the way the primary surface is used for dumb
framebuffers.  Instead of configuring the bo itself as primary surface
a shadow bo is created and used instead.  Framebuffers can share the
shadow bo in case they have the same format and resolution.

On atomic plane updates we don't have to update the primary surface in
case we pageflip from one framebuffer to another framebuffer which
shares the same shadow.  This in turn avoids the flicker caused by the
primary-destroy + primary-create cycle, which is very annonying when
running wayland on qxl.

The qxl driver never actually writes to the shadow bo.  It sends qxl
blit commands which update it though, and the spice server might
actually execute them (and thereby write to the shadow) in case the
local rendering is kicked for some reason.  This happens for example in
case qemu is asked to write out a dump of the guest display (screendump
monitor command).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20171019062150.28090-3-kraxel@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/qxl/qxl_cmd.c     |    6 +++-
 drivers/gpu/drm/qxl/qxl_display.c |   49 +++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/qxl/qxl_drv.h     |    2 +
 drivers/gpu/drm/qxl/qxl_dumb.c    |    1 
 4 files changed, 54 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -388,7 +388,11 @@ void qxl_io_create_primary(struct qxl_de
 	create->width = bo->surf.width;
 	create->height = bo->surf.height;
 	create->stride = bo->surf.stride;
-	create->mem = qxl_bo_physical_address(qdev, bo, offset);
+	if (bo->shadow) {
+		create->mem = qxl_bo_physical_address(qdev, bo->shadow, offset);
+	} else {
+		create->mem = qxl_bo_physical_address(qdev, bo, offset);
+	}
 
 	QXL_INFO(qdev, "%s: mem = %llx, from %p\n", __func__, create->mem,
 		 bo->kptr);
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -305,7 +305,9 @@ static const struct drm_crtc_funcs qxl_c
 void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
 {
 	struct qxl_framebuffer *qxl_fb = to_qxl_framebuffer(fb);
+	struct qxl_bo *bo = gem_to_qxl_bo(qxl_fb->obj);
 
+	WARN_ON(bo->shadow);
 	drm_gem_object_unreference_unlocked(qxl_fb->obj);
 	drm_framebuffer_cleanup(fb);
 	kfree(qxl_fb);
@@ -508,6 +510,7 @@ static void qxl_primary_atomic_update(st
 	    .x2 = qfb->base.width,
 	    .y2 = qfb->base.height
 	};
+	bool same_shadow = false;
 
 	if (old_state->fb) {
 		qfb_old = to_qxl_framebuffer(old_state->fb);
@@ -519,15 +522,23 @@ static void qxl_primary_atomic_update(st
 	if (bo == bo_old)
 		return;
 
+	if (bo_old && bo_old->shadow && bo->shadow &&
+	    bo_old->shadow == bo->shadow) {
+		same_shadow = true;
+	}
+
 	if (bo_old && bo_old->is_primary) {
-		qxl_io_destroy_primary(qdev);
+		if (!same_shadow)
+			qxl_io_destroy_primary(qdev);
 		bo_old->is_primary = false;
 	}
 
 	if (!bo->is_primary) {
-		qxl_io_create_primary(qdev, 0, bo);
+		if (!same_shadow)
+			qxl_io_create_primary(qdev, 0, bo);
 		bo->is_primary = true;
 	}
+
 	qxl_draw_dirty_fb(qdev, qfb, bo, 0, 0, &norect, 1, 1);
 }
 
@@ -681,8 +692,9 @@ static void qxl_cursor_atomic_disable(st
 static int qxl_plane_prepare_fb(struct drm_plane *plane,
 				struct drm_plane_state *new_state)
 {
+	struct qxl_device *qdev = plane->dev->dev_private;
 	struct drm_gem_object *obj;
-	struct qxl_bo *user_bo;
+	struct qxl_bo *user_bo, *old_bo = NULL;
 	int ret;
 
 	if (!new_state->fb)
@@ -691,6 +703,32 @@ static int qxl_plane_prepare_fb(struct d
 	obj = to_qxl_framebuffer(new_state->fb)->obj;
 	user_bo = gem_to_qxl_bo(obj);
 
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
+	    user_bo->is_dumb && !user_bo->shadow) {
+		if (plane->state->fb) {
+			obj = to_qxl_framebuffer(plane->state->fb)->obj;
+			old_bo = gem_to_qxl_bo(obj);
+		}
+		if (old_bo && old_bo->shadow &&
+		    user_bo->gem_base.size == old_bo->gem_base.size &&
+		    plane->state->crtc     == new_state->crtc &&
+		    plane->state->crtc_w   == new_state->crtc_w &&
+		    plane->state->crtc_h   == new_state->crtc_h &&
+		    plane->state->src_x    == new_state->src_x &&
+		    plane->state->src_y    == new_state->src_y &&
+		    plane->state->src_w    == new_state->src_w &&
+		    plane->state->src_h    == new_state->src_h &&
+		    plane->state->rotation == new_state->rotation &&
+		    plane->state->zpos     == new_state->zpos) {
+			drm_gem_object_get(&old_bo->shadow->gem_base);
+			user_bo->shadow = old_bo->shadow;
+		} else {
+			qxl_bo_create(qdev, user_bo->gem_base.size,
+				      true, true, QXL_GEM_DOMAIN_VRAM, NULL,
+				      &user_bo->shadow);
+		}
+	}
+
 	ret = qxl_bo_pin(user_bo, QXL_GEM_DOMAIN_CPU, NULL);
 	if (ret)
 		return ret;
@@ -715,6 +753,11 @@ static void qxl_plane_cleanup_fb(struct
 	obj = to_qxl_framebuffer(old_state->fb)->obj;
 	user_bo = gem_to_qxl_bo(obj);
 	qxl_bo_unpin(user_bo);
+
+	if (user_bo->shadow && !user_bo->is_primary) {
+		drm_gem_object_put_unlocked(&user_bo->shadow->gem_base);
+		user_bo->shadow = NULL;
+	}
 }
 
 static const uint32_t qxl_cursor_plane_formats[] = {
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -113,6 +113,8 @@ struct qxl_bo {
 	/* Constant after initialization */
 	struct drm_gem_object		gem_base;
 	bool is_primary; /* is this now a primary surface */
+	bool is_dumb;
+	struct qxl_bo *shadow;
 	bool hw_surf_alloc;
 	struct qxl_surface surf;
 	uint32_t surface_id;
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -63,6 +63,7 @@ int qxl_mode_dumb_create(struct drm_file
 					      &handle);
 	if (r)
 		return r;
+	qobj->is_dumb = true;
 	args->pitch = pitch;
 	args->handle = handle;
 	return 0;
