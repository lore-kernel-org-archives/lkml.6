Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709765-1519676912-2-2851949866121941595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676911; b=QIZJEzywBoJGLbxL5J5cqxRzWcDlk3gchikfWKbpoUI4gH6
    CxrxUiiP6cUTmbQAcMNP6RseGkkXgMJTh1PhA2273fLyuykBeuIMGRDVGi9rI31o
    tjdoLSWJieiTADBkd0GJ65E9ExjfMI9CI7AdyPB6HSPrRY8NLJOnLBPLhhqBKaAy
    Xti1Q+cTO+HiGzqSeASywcpHDMRolihglKJFHb/78qz1Vj1BZGRwDGBBc+L8kHzs
    AcdDUgD9eF6g0fu6eM/2ViPgHAxeCaZHEir2nKrDlmsHKuxC6/ImqP9bY89OcgCY
    h7yCScy5XdDAe8LoxdK53r5uxKAfkjdDiCmIBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676911; bh=9alsys2IZ32X5tPFadBTe0iGPN
    WXPAN33Sygv3HS6Vs=; b=rK9EzDfv5nhFAdTErNA6jMe9lNBGQKcErSa/NmAC5I
    avR29y+yO8Kv+2W9WRdCVa5hRKbcwrlYdVkhLXHR0U/NkM7qFlywVOzqvluAlKbQ
    VK8WnVxe4T6zQEOmucEsHyQ2dNI2u3onY3D+c1X2e99tlBzeWjgrtWgShFumVrNq
    AtpjG364nyHiaQT9vzlps8vfVJocVjpobyvHI7XTl9Uy4dq1v9t2ceZZBz4Wvx43
    fU64Zlpm4bQrLuWzvrz9PPHxdbvsWhVyUJZAgOADpKuLvTh0vIpm/iPkft+dQJIb
    B0z13vhvXpOMlVvwKp3EIAGiB6OQiPIn75kGrh8uvFog==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeBZU22 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:28:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753947AbeBZU20 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:28:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axenita.se>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4.15 53/64] drm/cirrus: Load lut in crtc_commit
Date: Mon, 26 Feb 2018 21:22:30 +0100
Message-Id: <20180226202155.705573549@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
