Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvUN+4Ux42K7QPMrfHXG1W3bkCeJDiGHhlVbyHBHez05MY8Rq7oA63aELM4xi+Un5cr2ktG
ARC-Seal: i=1; a=rsa-sha256; t=1522168296; cv=none;
        d=google.com; s=arc-20160816;
        b=evedOMXz4WqZLmzUIDvgt628vrMX0Y8Kj8EIUeHz1lPBnjiI3VSJumPJbGZIu6c2DD
         GFggrkPoW8Cst4fCl1Qz8sxdp81XLw5WHxEiEEZk/vPbceniorf2eb4dNNtsGyXwWEon
         tWLVMJA/iRVIkSt0/GG1lFxa8NYTKlCXz/jkGYF404c/n1/7RBeo24U7SptDB/CU5F0j
         vQ1rzKogBxpG2Z+nwMSkxMCA8GlW99P6rBOIIrZOLt+D68CC+RmmCZLRNeSMhj5e8Vwr
         Tmh76wZv56p021OqoFdzR3llJDh1Xw7RjQXiRcP2u8r2f1fs2yGsDg3fzkLxAYlaROyO
         HEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k8p/tiuH89iF5/9hmvkfVZ4vvpY6bFMDqYxVnwTQPEg=;
        b=fy4k2V3BcshZ+je0w2SrI+xvUxZh3A1c4oY3UUZBtPGwcSYCoNBxEf4tklMvxCHtA1
         DJiSot0Frd5LbxBbLQ4h8fsCyDDe6PB1J1h2uBGAaIPK5Gp0+Ph1Y2GgvLfozaCSl9OV
         ulsJwWI5z3jlitfal5LcWU3Ey8JvpbJVngi29e/tn+1VnduZToMAHYXcBpCH05cIH+S9
         a3LsVQsYg/oMgAg34RxLZJOAgk+LlsauLqgjlrGKoLeHMKetUwL2KMaX8f6vAiDwRY9p
         MGDlkfhbMj5S1MgWhTxmfW0Knj4Vs4mjzPlcv1B9So+x2XvmlX/6w4uzf9qiCqPIMdC3
         vq2w==
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
Subject: [PATCH 4.9 29/67] drm/vmwgfx: Fix a destoy-while-held mutex problem.
Date: Tue, 27 Mar 2018 18:27:21 +0200
Message-Id: <20180327162728.594877139@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108994397345632?=
X-GMAIL-MSGID: =?utf-8?q?1596109143133270688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -27,7 +27,6 @@
 
 #include "vmwgfx_kms.h"
 
-
 /* Might need a hrtimer here? */
 #define VMWGFX_PRESENT_RATE ((HZ / 60 > 0) ? HZ / 60 : 1)
 
@@ -1933,9 +1932,12 @@ void vmw_kms_helper_buffer_finish(struct
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
@@ -1952,10 +1954,14 @@ void vmw_kms_helper_resource_revert(stru
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
@@ -1974,6 +1980,8 @@ int vmw_kms_helper_resource_prepare(stru
 						    res->dev_priv->has_mob);
 		if (ret)
 			goto out_unreserve;
+
+		ctx->buf = vmw_dmabuf_reference(res->backup);
 	}
 	ret = vmw_resource_validate(res);
 	if (ret)
@@ -1981,7 +1989,7 @@ int vmw_kms_helper_resource_prepare(stru
 	return 0;
 
 out_revert:
-	vmw_kms_helper_buffer_revert(res->backup);
+	vmw_kms_helper_buffer_revert(ctx->buf);
 out_unreserve:
 	vmw_resource_unreserve(res, false, NULL, 0);
 out_unlock:
@@ -1997,11 +2005,13 @@ out_unlock:
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
@@ -183,6 +183,11 @@ struct vmw_display_unit {
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
@@ -233,9 +238,10 @@ void vmw_kms_helper_buffer_finish(struct
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
@@ -753,12 +753,13 @@ int vmw_kms_sou_do_surface_dirty(struct
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
 
@@ -777,7 +778,7 @@ int vmw_kms_sou_do_surface_dirty(struct
 	ret = vmw_kms_helper_dirty(dev_priv, framebuffer, clips, vclips,
 				   dest_x, dest_y, num_clips, inc,
 				   &sdirty.base);
-	vmw_kms_helper_resource_finish(srf, out_fence);
+	vmw_kms_helper_resource_finish(&ctx, out_fence);
 
 	return ret;
 }
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -977,12 +977,13 @@ int vmw_kms_stdu_surface_dirty(struct vm
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
 
@@ -1005,7 +1006,7 @@ int vmw_kms_stdu_surface_dirty(struct vm
 				   dest_x, dest_y, num_clips, inc,
 				   &sdirty.base);
 out_finish:
-	vmw_kms_helper_resource_finish(srf, out_fence);
+	vmw_kms_helper_resource_finish(&ctx, out_fence);
 
 	return ret;
 }
