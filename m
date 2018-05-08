Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpbU4gArM1GF8nvTkFeddRioZ7xD/gH6uxYcg76uJOKIbIYtwx7qI5zUFjKv0C0nOx/akGN
ARC-Seal: i=1; a=rsa-sha256; t=1525767163; cv=none;
        d=google.com; s=arc-20160816;
        b=q5ESbCHGKM4ff6/bJvnO7VHLGNanbqgx10I5oMiPQImxCTU9fceEpfwPgsjm4E5PIl
         DE6Py62oi2H2fWvrpW57+nnvEjkuLycibsTcVkCNo8iJd+iZDbZNxWldVNkX0UyWIgue
         guHvNbbpQwoSpYQV3IjtdbHeJmHJCAHd3PyQYrpmA6DCB5swmIXURnxbX23NtiJrfg+k
         FSYkgro1D4k/RBnpuJ18wU7Q8aLnvqhqMKUJKPHB+2uhO4QnPFZUW+rH7t1NICa1VC0i
         eEKBPOdurxIVtyHvwb95B2HVHYKwAQK8jfI9F4+sG2kmlrWfFO0xGi3CPMRgoAdTfOoT
         YG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=kIKGCFibsyYlejizzZqmSJnuPszuINA0GkrFaO2H0IU=;
        b=XbSqcD2G8qglRUHg16/0+Xrjv/vE4tynBF6y7yDU3RAdYjH6SoW9oi6IW8jYiq3jzh
         ZhO+iyL53NqK6y0xuKRJvItns7PIRX1gD3bghiO2Dx/7Gf1BOB4y7XOpydDkcti4snvG
         GlI2W8DI8DmYh2Aal9Ht7w5giIRyPWSAD+9NSXajxwBdi2R/S+n4Oa+KC/yeNeBtMGHO
         Jqw09A5z0RLks7w7PCctcOQ0OjIqv8Q8Cup5tSBWzcSySe/nvZkF8ZMUy559/RODDjSs
         TPZxRUT0QA746nHR2iVqCHt+nOpUit5Zg7nKdaeNbQ+Yb+FIDvoFhAQO32K63zki3C5q
         uvvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=u0NeHQCi;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=u0NeHQCi;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Robinson <pbrobinson@gmail.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.16 31/52] drm/vc4: Make sure vc4_bo_{inc,dec}_usecnt() calls are balanced
Date: Tue,  8 May 2018 10:10:29 +0200
Message-Id: <20180508073932.363555470@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882829357506462?=
X-GMAIL-MSGID: =?utf-8?q?1599882829357506462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit f7aef1c207092770d06d0df21dceafdca2b49c39 upstream.

Commit b9f19259b84d ("drm/vc4: Add the DRM_IOCTL_VC4_GEM_MADVISE ioctl")
introduced a mechanism to mark some BOs as purgeable to allow the driver
to drop them under memory pressure. In order to implement this feature
we had to add a mechanism to mark BOs as currently used by a piece of
hardware which materialized through the ->usecnt counter.

Plane code is supposed to increment usecnt when it attaches a BO to a
plane and decrement it when it's done with this BO, which was done in
the ->prepare_fb() and ->cleanup_fb() hooks. The problem is, async page
flip logic does not go through the regular atomic update path, and
->prepare_fb() and ->cleanup_fb() are not called in this case.

Fix that by manually calling vc4_bo_{inc,dec}_usecnt() in the
async-page-flip path.

Note that all this should go away as soon as we get generic async page
flip support in the core, in the meantime, this fix should do the
trick.

Fixes: b9f19259b84d ("drm/vc4: Add the DRM_IOCTL_VC4_GEM_MADVISE ioctl")
Reported-by: Peter Robinson <pbrobinson@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180430133232.32457-1-boris.brezillon@bootlin.com
Link: https://patchwork.freedesktop.org/patch/msgid/20180430133232.32457-1-boris.brezillon@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_crtc.c |   46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -735,6 +735,7 @@ static irqreturn_t vc4_crtc_irq_handler(
 struct vc4_async_flip_state {
 	struct drm_crtc *crtc;
 	struct drm_framebuffer *fb;
+	struct drm_framebuffer *old_fb;
 	struct drm_pending_vblank_event *event;
 
 	struct vc4_seqno_cb cb;
@@ -764,6 +765,23 @@ vc4_async_page_flip_complete(struct vc4_
 
 	drm_crtc_vblank_put(crtc);
 	drm_framebuffer_put(flip_state->fb);
+
+	/* Decrement the BO usecnt in order to keep the inc/dec calls balanced
+	 * when the planes are updated through the async update path.
+	 * FIXME: we should move to generic async-page-flip when it's
+	 * available, so that we can get rid of this hand-made cleanup_fb()
+	 * logic.
+	 */
+	if (flip_state->old_fb) {
+		struct drm_gem_cma_object *cma_bo;
+		struct vc4_bo *bo;
+
+		cma_bo = drm_fb_cma_get_gem_obj(flip_state->old_fb, 0);
+		bo = to_vc4_bo(&cma_bo->base);
+		vc4_bo_dec_usecnt(bo);
+		drm_framebuffer_put(flip_state->old_fb);
+	}
+
 	kfree(flip_state);
 
 	up(&vc4->async_modeset);
@@ -788,9 +806,22 @@ static int vc4_async_page_flip(struct dr
 	struct drm_gem_cma_object *cma_bo = drm_fb_cma_get_gem_obj(fb, 0);
 	struct vc4_bo *bo = to_vc4_bo(&cma_bo->base);
 
+	/* Increment the BO usecnt here, so that we never end up with an
+	 * unbalanced number of vc4_bo_{dec,inc}_usecnt() calls when the
+	 * plane is later updated through the non-async path.
+	 * FIXME: we should move to generic async-page-flip when it's
+	 * available, so that we can get rid of this hand-made prepare_fb()
+	 * logic.
+	 */
+	ret = vc4_bo_inc_usecnt(bo);
+	if (ret)
+		return ret;
+
 	flip_state = kzalloc(sizeof(*flip_state), GFP_KERNEL);
-	if (!flip_state)
+	if (!flip_state) {
+		vc4_bo_dec_usecnt(bo);
 		return -ENOMEM;
+	}
 
 	drm_framebuffer_get(fb);
 	flip_state->fb = fb;
@@ -801,10 +832,23 @@ static int vc4_async_page_flip(struct dr
 	ret = down_interruptible(&vc4->async_modeset);
 	if (ret) {
 		drm_framebuffer_put(fb);
+		vc4_bo_dec_usecnt(bo);
 		kfree(flip_state);
 		return ret;
 	}
 
+	/* Save the current FB before it's replaced by the new one in
+	 * drm_atomic_set_fb_for_plane(). We'll need the old FB in
+	 * vc4_async_page_flip_complete() to decrement the BO usecnt and keep
+	 * it consistent.
+	 * FIXME: we should move to generic async-page-flip when it's
+	 * available, so that we can get rid of this hand-made cleanup_fb()
+	 * logic.
+	 */
+	flip_state->old_fb = plane->state->fb;
+	if (flip_state->old_fb)
+		drm_framebuffer_get(flip_state->old_fb);
+
 	WARN_ON(drm_crtc_vblank_get(crtc) != 0);
 
 	/* Immediately update the plane's legacy fb pointer, so that later
