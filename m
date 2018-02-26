Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226P8D0DQo7dJ3I+wk1uBWtONEPyjrKkO/SUQ4CFpm0DHutV544uMgs36m3AB41K6jKi9DPC
ARC-Seal: i=1; a=rsa-sha256; t=1519676708; cv=none;
        d=google.com; s=arc-20160816;
        b=OIrxE2Ecq2omLgLZoFNN54mly/t2NX+GMaALzfnyL8P/tO5hvzM6bLFHhMa3X5oVK3
         KFQutxe59sULdkrtx8M5yRwlnqk01NswZHX52LyNmFTtHMQzs9R48Qq9Yklld0n4NpIo
         qz9ZZToENmKQsNpLGTpCzu0kc96e4iX0vgH/2VeVP/ZyzG/lX3VUozhADR4S3cUue1nH
         wSgR/sj/RyuYsQqVUoRr1vtIl1ZnmR9UJdNVXKSi3a2SLeZ2/v5sL33+HaIRz0v2zjqn
         f48w5fLia10HuurlroFUgVQkwnEklUBufg/83GeYgcEyDBnLZ6yrXtpLbnm9YwX0yPnj
         oE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q4wB0YmSDwOBztRFjaFk/5uyfCzB2WIoX1yGuQK4+PM=;
        b=aN2YQ3tZMrr8VtJ1XhoDrwZldE+U0VFgXNE1D1wbaglALYWBGxps5lYJ+V2XrNOMum
         goEg5ZPx56lHVZxNO1oTQICyCQkDNwYA5xYvZsQTgLlY82IvrqZT0lAhNtHHkiJQ/6Ah
         Tdo88J5jpgWDZPrOnzYy8uhNGudMTLhbhbPeUM0us1PX5wO0ycBntEMBuFuPRJWEo2+E
         Tiu0gCEiTtWMki5xOavtxoK6M5cB5X6Ky978ox/G1U3bb4XLiFbGfJI7V/Ixywc/pzHT
         LRjivhO5H/EdDvM+8VIzn9BDIF7Acdj15gTpQQn5MplTfrRMgKptgJwaXqlIEn4UXx3E
         ce8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Rosin <peda@axenita.se>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4.14 46/54] drm/cirrus: Load lut in crtc_commit
Date: Mon, 26 Feb 2018 21:22:23 +0100
Message-Id: <20180226202146.715891524@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496524480353186?=
X-GMAIL-MSGID: =?utf-8?q?1593496524480353186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vetter <daniel.vetter@ffwll.ch>

commit 745fd50f3b044db6a3922e1718306555613164b0 upstream.

In the past the ast driver relied upon the fbdev emulation helpers to
call ->load_lut at boot-up. But since

commit b8e2b0199cc377617dc238f5106352c06dcd3fa2
Author: Peter Rosin <peda@axentia.se>
Date:   Tue Jul 4 12:36:57 2017 +0200

drm/fb-helper: factor out pseudo-palette

that's cleaned up and drivers are expected to boot into a consistent
lut state. This patch fixes that.

Fixes: b8e2b0199cc3 ("drm/fb-helper: factor out pseudo-palette")
Cc: Peter Rosin <peda@axenita.se>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: <stable@vger.kernel.org> # v4.14+
References: https://bugzilla.kernel.org/show_bug.cgi?id=198123
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20180131110450.22153-1-daniel.vetter@ffwll.ch
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/cirrus/cirrus_mode.c |   40 ++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 17 deletions(-)

--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -294,22 +294,7 @@ static void cirrus_crtc_prepare(struct d
 {
 }
 
-/*
- * This is called after a mode is programmed. It should reverse anything done
- * by the prepare function
- */
-static void cirrus_crtc_commit(struct drm_crtc *crtc)
-{
-}
-
-/*
- * The core can pass us a set of gamma values to program. We actually only
- * use this for 8-bit mode so can't perform smooth fades on deeper modes,
- * but it's a requirement that we provide the function
- */
-static int cirrus_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
-				 u16 *blue, uint32_t size,
-				 struct drm_modeset_acquire_ctx *ctx)
+static void cirrus_crtc_load_lut(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
 	struct cirrus_device *cdev = dev->dev_private;
@@ -317,7 +302,7 @@ static int cirrus_crtc_gamma_set(struct
 	int i;
 
 	if (!crtc->enabled)
-		return 0;
+		return;
 
 	r = crtc->gamma_store;
 	g = r + crtc->gamma_size;
@@ -330,6 +315,27 @@ static int cirrus_crtc_gamma_set(struct
 		WREG8(PALETTE_DATA, *g++ >> 8);
 		WREG8(PALETTE_DATA, *b++ >> 8);
 	}
+}
+
+/*
+ * This is called after a mode is programmed. It should reverse anything done
+ * by the prepare function
+ */
+static void cirrus_crtc_commit(struct drm_crtc *crtc)
+{
+	cirrus_crtc_load_lut(crtc);
+}
+
+/*
+ * The core can pass us a set of gamma values to program. We actually only
+ * use this for 8-bit mode so can't perform smooth fades on deeper modes,
+ * but it's a requirement that we provide the function
+ */
+static int cirrus_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
+				 u16 *blue, uint32_t size,
+				 struct drm_modeset_acquire_ctx *ctx)
+{
+	cirrus_crtc_load_lut(crtc);
 
 	return 0;
 }
