Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+tKenT79ft3VwHdGN/TeUkj9l9FwdSOaBfGo/CZ9RRtn+sEo1+g81lqKkMvIdZ+4sNkhVb
ARC-Seal: i=1; a=rsa-sha256; t=1522168565; cv=none;
        d=google.com; s=arc-20160816;
        b=sERgbiF0bNt97OMIG6ukLjkSxTAqE2KJ+QOvy4GfmfQciprUrEBGTueRffrDGC6i5B
         IqznD/Wv0cUqXPNghoMyOGYIya5EGTSU8YTWrvStawUX5089ZHrYnY7OVgwMjdZapT2/
         9GJncjaxGsdgJbKHJWmNwH9Z46KWRroKhB91+ju3ZlDEy62TG5oTLuGRg4TUFLaC92AE
         s/AQ7MwM+FuDCOo7HPy3nPLsd61Yvr3cfZGW8eJkOAI3/ZyropXxdX+jNMv+WhN4V1I0
         3CDWPf3m5c88pUPMhX73HRBxSf4WbcEhgdrC1hzTDNfiPrBlfE7+YO78C9OBR7O87JMh
         S6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=T+yd+owuX2oTl9HOmTVLsTs7ukjeIhwiJr+N2cTvhgQ=;
        b=JOzXBOZ0N6k/gpb8JY+XYktqKrINY5gJAHvO6VMJqQPOdW51FzPR1go35vwkLxEMkR
         Lq7/Vo7dcKGYodE1BLeAUa2uNE7wJ4abwP7SpRwypfLXkij3uNCaDUvU9Vpml9L3ALCA
         9FwzTAzHcYHkb0YyknzkeX8J8hyXzxQr522vELosCTR2j3R6pu/thK52SZCaRqk09yGu
         Tce3q+VM9I7AcHy/EXSY4OBgV/N6vF1Mr4xDO7jRotFBxZV+ozzYtWbDMgOGukE9bfoL
         gJc/X3n1OFqz5AvY7pwvxSvQB07mupQikbniQ2MMR1H6WT8lKpg/PAB/pAkJnuVJL9Fw
         BLFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Brian Paul <brianp@vmware.com>,
	Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.14 054/101] drm/vmwgfx: Fix a destoy-while-held mutex problem.
Date: Tue, 27 Mar 2018 18:27:26 +0200
Message-Id: <20180327162753.332475352@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108994397345632?=
X-GMAIL-MSGID: =?utf-8?q?1596109425608628189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 73a88250b70954a8f27c2444e1c2411bba3c29d9 upstream.

When validating legacy surfaces, the backup bo might be destroyed at
surface validate time. However, the kms resource validation code may have
the bo reserved, so we will destroy a locked mutex. While there shouldn't
be any other users of that mutex when it is destroyed, it causes a lock
leak and thus throws a lockdep error.

Fix this by having the kms resource validation code hold a reference to
the bo while we have it reserved. We do this by introducing a validation
context which might come in handy when the kms code is extended to validate
multiple resources or buffers.

Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Brian Paul <brianp@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  |   28 +++++++++++++++++++---------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |   12 +++++++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |    5 +++--
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |    5 +++--
 4 files changed, 34 insertions(+), 16 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -31,7 +31,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_rect.h>
 
-
 /* Might need a hrtimer here? */
 #define VMWGFX_PRESENT_RATE ((HZ / 60 > 0) ? HZ / 60 : 1)
 
@@ -2531,9 +2530,12 @@ void vmw_kms_helper_buffer_finish(struct
  * Helper to be used if an error forces the caller to undo the actions of
  * vmw_kms_helper_resource_prepare.
  */
-void vmw_kms_helper_resource_revert(struct vmw_resource *res)
+void vmw_kms_helper_resource_revert(struct vmw_validation_ctx *ctx)
 {
-	vmw_kms_helper_buffer_revert(res->backup);
+	struct vmw_resource *res = ctx->res;
+
+	vmw_kms_helper_buffer_revert(ctx->buf);
+	vmw_dmabuf_unreference(&ctx->buf);
 	vmw_resource_unreserve(res, false, NULL, 0);
 	mutex_unlock(&res->dev_priv->cmdbuf_mutex);
 }
@@ -2550,10 +2552,14 @@ void vmw_kms_helper_resource_revert(stru
  * interrupted by a signal.
  */
 int vmw_kms_helper_resource_prepare(struct vmw_resource *res,
-				    bool interruptible)
+				    bool interruptible,
+				    struct vmw_validation_ctx *ctx)
 {
 	int ret = 0;
 
+	ctx->buf = NULL;
+	ctx->res = res;
+
 	if (interruptible)
 		ret = mutex_lock_interruptible(&res->dev_priv->cmdbuf_mutex);
 	else
@@ -2572,6 +2578,8 @@ int vmw_kms_helper_resource_prepare(stru
 						    res->dev_priv->has_mob);
 		if (ret)
 			goto out_unreserve;
+
+		ctx->buf = vmw_dmabuf_reference(res->backup);
 	}
 	ret = vmw_resource_validate(res);
 	if (ret)
@@ -2579,7 +2587,7 @@ int vmw_kms_helper_resource_prepare(stru
 	return 0;
 
 out_revert:
-	vmw_kms_helper_buffer_revert(res->backup);
+	vmw_kms_helper_buffer_revert(ctx->buf);
 out_unreserve:
 	vmw_resource_unreserve(res, false, NULL, 0);
 out_unlock:
@@ -2595,11 +2603,13 @@ out_unlock:
  * @out_fence: Optional pointer to a fence pointer. If non-NULL, a
  * ref-counted fence pointer is returned here.
  */
-void vmw_kms_helper_resource_finish(struct vmw_resource *res,
-			     struct vmw_fence_obj **out_fence)
+void vmw_kms_helper_resource_finish(struct vmw_validation_ctx *ctx,
+				    struct vmw_fence_obj **out_fence)
 {
-	if (res->backup || out_fence)
-		vmw_kms_helper_buffer_finish(res->dev_priv, NULL, res->backup,
+	struct vmw_resource *res = ctx->res;
+
+	if (ctx->buf || out_fence)
+		vmw_kms_helper_buffer_finish(res->dev_priv, NULL, ctx->buf,
 					     out_fence, NULL);
 
 	vmw_resource_unreserve(res, false, NULL, 0);
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -240,6 +240,11 @@ struct vmw_display_unit {
 	int set_gui_y;
 };
 
+struct vmw_validation_ctx {
+	struct vmw_resource *res;
+	struct vmw_dma_buffer *buf;
+};
+
 #define vmw_crtc_to_du(x) \
 	container_of(x, struct vmw_display_unit, crtc)
 #define vmw_connector_to_du(x) \
@@ -296,9 +301,10 @@ void vmw_kms_helper_buffer_finish(struct
 				  struct drm_vmw_fence_rep __user *
 				  user_fence_rep);
 int vmw_kms_helper_resource_prepare(struct vmw_resource *res,
-				    bool interruptible);
-void vmw_kms_helper_resource_revert(struct vmw_resource *res);
-void vmw_kms_helper_resource_finish(struct vmw_resource *res,
+				    bool interruptible,
+				    struct vmw_validation_ctx *ctx);
+void vmw_kms_helper_resource_revert(struct vmw_validation_ctx *ctx);
+void vmw_kms_helper_resource_finish(struct vmw_validation_ctx *ctx,
 				    struct vmw_fence_obj **out_fence);
 int vmw_kms_readback(struct vmw_private *dev_priv,
 		     struct drm_file *file_priv,
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -909,12 +909,13 @@ int vmw_kms_sou_do_surface_dirty(struct
 	struct vmw_framebuffer_surface *vfbs =
 		container_of(framebuffer, typeof(*vfbs), base);
 	struct vmw_kms_sou_surface_dirty sdirty;
+	struct vmw_validation_ctx ctx;
 	int ret;
 
 	if (!srf)
 		srf = &vfbs->surface->res;
 
-	ret = vmw_kms_helper_resource_prepare(srf, true);
+	ret = vmw_kms_helper_resource_prepare(srf, true, &ctx);
 	if (ret)
 		return ret;
 
@@ -933,7 +934,7 @@ int vmw_kms_sou_do_surface_dirty(struct
 	ret = vmw_kms_helper_dirty(dev_priv, framebuffer, clips, vclips,
 				   dest_x, dest_y, num_clips, inc,
 				   &sdirty.base);
-	vmw_kms_helper_resource_finish(srf, out_fence);
+	vmw_kms_helper_resource_finish(&ctx, out_fence);
 
 	return ret;
 }
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -980,12 +980,13 @@ int vmw_kms_stdu_surface_dirty(struct vm
 	struct vmw_framebuffer_surface *vfbs =
 		container_of(framebuffer, typeof(*vfbs), base);
 	struct vmw_stdu_dirty sdirty;
+	struct vmw_validation_ctx ctx;
 	int ret;
 
 	if (!srf)
 		srf = &vfbs->surface->res;
 
-	ret = vmw_kms_helper_resource_prepare(srf, true);
+	ret = vmw_kms_helper_resource_prepare(srf, true, &ctx);
 	if (ret)
 		return ret;
 
@@ -1008,7 +1009,7 @@ int vmw_kms_stdu_surface_dirty(struct vm
 				   dest_x, dest_y, num_clips, inc,
 				   &sdirty.base);
 out_finish:
-	vmw_kms_helper_resource_finish(srf, out_fence);
+	vmw_kms_helper_resource_finish(&ctx, out_fence);
 
 	return ret;
 }
