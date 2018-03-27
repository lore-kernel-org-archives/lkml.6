Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+KhmBo+bQ5IppIe/KjD1fFW2vgpgEvy88OCrkxjx4VWdf8j6EdEMC4VJPayS1y9EmB34t4
ARC-Seal: i=1; a=rsa-sha256; t=1522168562; cv=none;
        d=google.com; s=arc-20160816;
        b=ph9i3WK69GExSAvXtaNwdgPD9j/lo6jST6L4Gvk20S8lTxXgWJzLgf3AxupMFwDRHY
         8KdBgVW0NhU63VjYYj1Esu72lwdEW54LJ4NPOVg0eAXCIDdfrxTn7y+bDbhFWZhqy3x7
         phA/Bt9xgfsfippXDVyvVY6+2jdygcXlUrg2kDVquq38Oj9e6etNwWbaMwgVkuVT4Oe4
         8t73HloDLJHf3+ErAjFnACwSK4hSVxo2BJg7sWZ1R39ln3iekE6etD/evJ1Wm7kloqpi
         YZ/t/zycWYSa8/x6iJ1d/S7v4Iy76Tj9TrbWEmKgn1biA1ZB6mFBSqgrYMZLrUCrZ9/z
         fmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d4lMeYYT97FHUsJPJwFsJrZQMMvh2OeVRLNdaWK2o6Y=;
        b=WrVGe61mtLF4dC2LMqjfLCbNkYOFPGHuye7soOgFIhr3Tx0CRQV4euvXeqzXQpgwMZ
         wTFyMwL5E4TOcdSEOdzPSGPBtpfgS28DpA8SqRLd4BVEylZqvKeEipRsTnSurH/nNv7p
         5eu15X0A/njR+DHmaGDu/Dij2QnDPhFB+Ar5aic0ZiLGmR83Hpqz40+EU+FIVDbKWXIH
         Lc3gkUk+T1+1MBZV0JirqTCxRy1M4br1T2ss4VZyV7OGv8zXr4s4S1edgBBuXO9E06j1
         6LglUE2ORzF4zlRCz9FTI9QiAB3X1wBSByLhOSmJ03vGSRZJeNwoQrvGW36xSb48QaZ3
         DmqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.14 053/101] drm/vmwgfx: Fix black screen and device errors when running without fbdev
Date: Tue, 27 Mar 2018 18:27:25 +0200
Message-Id: <20180327162753.284543437@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109422329865784?=
X-GMAIL-MSGID: =?utf-8?q?1596109422329865784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 140bcaa23a1c37b694910424075a15e009120dbe upstream.

When we are running without fbdev, transitioning from the login screen to
X or gnome-shell/wayland will cause a vt switch and the driver will disable
svga mode, losing all modesetting resources. However, the kms atomic state
does not reflect that and may think that a crtc is still turned on, which
will cause device errors when we try to bind an fb to the crtc, and the
screen will remain black.

Fix this by turning off all kms resources before disabling svga mode.

Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c |   13 +++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |    1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c |   11 +++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h |    1 -
 4 files changed, 25 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1337,6 +1337,19 @@ static void __vmw_svga_disable(struct vm
  */
 void vmw_svga_disable(struct vmw_private *dev_priv)
 {
+	/*
+	 * Disabling SVGA will turn off device modesetting capabilities, so
+	 * notify KMS about that so that it doesn't cache atomic state that
+	 * isn't valid anymore, for example crtcs turned on.
+	 * Strictly we'd want to do this under the SVGA lock (or an SVGA mutex),
+	 * but vmw_kms_lost_device() takes the reservation sem and thus we'll
+	 * end up with lock order reversal. Thus, a master may actually perform
+	 * a new modeset just after we call vmw_kms_lost_device() and race with
+	 * vmw_svga_disable(), but that should at worst cause atomic KMS state
+	 * to be inconsistent with the device, causing modesetting problems.
+	 *
+	 */
+	vmw_kms_lost_device(dev_priv->dev);
 	ttm_write_lock(&dev_priv->reservation_sem, false);
 	spin_lock(&dev_priv->svga_lock);
 	if (dev_priv->bdev.man[TTM_PL_VRAM].use_type) {
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -938,6 +938,7 @@ int vmw_kms_present(struct vmw_private *
 int vmw_kms_update_layout_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv);
 void vmw_kms_legacy_hotspot_clear(struct vmw_private *dev_priv);
+void vmw_kms_lost_device(struct drm_device *dev);
 
 int vmw_dumb_create(struct drm_file *file_priv,
 		    struct drm_device *dev,
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -2865,3 +2865,14 @@ int vmw_kms_set_config(struct drm_mode_s
 
 	return drm_atomic_helper_set_config(set, ctx);
 }
+
+
+/**
+ * vmw_kms_lost_device - Notify kms that modesetting capabilities will be lost
+ *
+ * @dev: Pointer to the drm device
+ */
+void vmw_kms_lost_device(struct drm_device *dev)
+{
+	drm_atomic_helper_shutdown(dev);
+}
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -439,5 +439,4 @@ int vmw_kms_stdu_dma(struct vmw_private
 
 int vmw_kms_set_config(struct drm_mode_set *set,
 		       struct drm_modeset_acquire_ctx *ctx);
-
 #endif
