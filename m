Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvYHlHtPhzhwRm9O3CzocixFiWTtz0exQ8ivDZek3+CthsYIDTpzRfgfklU1ztyxfzW+iDo
ARC-Seal: i=1; a=rsa-sha256; t=1520955486; cv=none;
        d=google.com; s=arc-20160816;
        b=lf8NepSy182K5P4/ZhJdAi+i/GQBy3ozxeuiAZckfw6P5hl2fr3qwNOE0aal6Y8Qb7
         g3Z5ezTiY4NsAUx7Hc06IiWlGt98YCvD0zThp/1VEutxyBA41UC1ugO5F7dSItZ70Es/
         VzsxKq3b3QAWfmUCyUFMMluZqd+fLee4KwXBXWu70C9V7xX5QopPeB7jkrTc5IKg13P7
         HYJTOzY11A2wYffhM0Odjl/jwGfsJVZRAJyRIMm9j5SbDANqG7hQN1fYrztz/ZeVuNx5
         35dIl+LAtK7yj4jmyWc/1uAkq17SLxaCjDWU1ygjshDapgmvKbAfCjh3L5iZ5JGPhjGy
         CRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fCIfpkg/cVmH7goAZ/mB+fnoDHFZuoP16hwXPghZ1ME=;
        b=VD4YkLjaQjablbLaS/CHz+K0Hp12eGE4TcEkPYtdnPzqh9Os9b3wZWmib4NU6E3OPH
         rh+x9l6Hzo7ZIRiKHgtgx9jH8/vgvq5LCjyXccrjuJes0Jr67rO5M3vlQyBD0GX5KjtQ
         FuCw7riomYLyT2t554gLIhKf7IYL1AZkq8kmFcg0C+jYuBQkWRFdKijyq6glIR/8P+wA
         JlkKerDpbx/RLFE7RGoKiLu9lbroliHs58e9UeQUwS5mSxETRY1W57V5zDCiJO8Qc4wR
         iiui3jKAE9JrN1oGjYnvfWAAxGxkVd6xME4VpB5I0F5N/qHgjmqZ7AIiYI+eYFhIQ4+r
         0tzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilia Mirkin <imirkin@alum.mit.edu>,
	Ben Skeggs <bskeggs@redhat.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.14 066/140] drm/nouveau: prefer XBGR2101010 for addfb ioctl
Date: Tue, 13 Mar 2018 16:24:29 +0100
Message-Id: <20180313152502.645542034@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836816640363428?=
X-GMAIL-MSGID: =?utf-8?q?1594837420016642588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilia Mirkin <imirkin@alum.mit.edu>

commit c20bb155c2c5acb775f68be5d84fe679687c3c1e upstream.

Nouveau only exposes support for XBGR2101010. Prior to the atomic
conversion, drm would pass in the wrong format in the framebuffer, but
it was always ignored -- both userspace (xf86-video-nouveau) and the
kernel driver agreed on the layout, so the fact that the format was
wrong didn't matter.

With the atomic conversion, nouveau all of a sudden started caring about
the exact format, and so the previously-working code in
xf86-video-nouveau no longer functioned since the (internally-assigned)
format from the addfb ioctl was wrong.

This change adds infrastructure to allow a drm driver to specify that it
prefers the XBGR format variant for the addfb ioctl, and makes nouveau's
nv50 display driver set it. (Prior gens had no support for 30bpp at all.)

Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: stable@vger.kernel.org # v4.10+
Acked-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180203191123.31507-1-imirkin@alum.mit.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_framebuffer.c      |    4 ++++
 drivers/gpu/drm/nouveau/nv50_display.c |    1 +
 include/drm/drm_drv.h                  |    1 +
 3 files changed, 6 insertions(+)

--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -118,6 +118,10 @@ int drm_mode_addfb(struct drm_device *de
 	r.pixel_format = drm_mode_legacy_fb_format(or->bpp, or->depth);
 	r.handles[0] = or->handle;
 
+	if (r.pixel_format == DRM_FORMAT_XRGB2101010 &&
+	    dev->driver->driver_features & DRIVER_PREFER_XBGR_30BPP)
+		r.pixel_format = DRM_FORMAT_XBGR2101010;
+
 	ret = drm_mode_addfb2(dev, &r, file_priv);
 	if (ret)
 		return ret;
--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -4426,6 +4426,7 @@ nv50_display_create(struct drm_device *d
 	nouveau_display(dev)->fini = nv50_display_fini;
 	disp->disp = &nouveau_display(dev)->disp;
 	dev->mode_config.funcs = &nv50_disp_func;
+	dev->driver->driver_features |= DRIVER_PREFER_XBGR_30BPP;
 	if (nouveau_atomic)
 		dev->driver->driver_features |= DRIVER_ATOMIC;
 
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -55,6 +55,7 @@ struct drm_mode_create_dumb;
 #define DRIVER_ATOMIC			0x10000
 #define DRIVER_KMS_LEGACY_CONTEXT	0x20000
 #define DRIVER_SYNCOBJ                  0x40000
+#define DRIVER_PREFER_XBGR_30BPP        0x80000
 
 /**
  * struct drm_driver - DRM driver structure
