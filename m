Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710863-2-14079620174804751993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710862; b=ktPguxZZJllbZijpXj+o/X2arSM/T2Fl92YAcTztIe3Bl/l
    cugFU27yi1ovojcxnSYiDUyUIION/njWevPH7o3194njMeoKOo7mBrPLx0GGHKGV
    Gcgqi5WMbZOTaQfPEuz/ZNGHUfj4FoyuMrLvNdjjRjzA4Pjtt+tCIMGIkmCM6KPU
    lVqEevOwRSwVnUA/Diq912p4R64amC+P2m34CRBaz8EeKxq3Baj8BMlhrubkTYdx
    HblVc6nFe16p+mJ9c/fNfXv8S5yjtOp17HkR1LbJkpAGpl+qI9/nQV0IZoA4KLKi
    DSj0NQ195iFAwsiBQ7F1XqY4cirNthzVRo98mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710862; bh=3kk+TmTqTp3Dki0yj/oMOfLGLo
    nFLPfYWGnpajvL76k=; b=v9iaJhBI1zYLzByxSIJECm9MSOTcgCPCzL/pCl0VRa
    zM122ImkREMwlzr9GKqJqE0HYcDJrgnJSItqdomV6CZlcXe4od1P2Z4knAxtym2U
    zkyBfehlEiCr2NequHwLNkB1T+H5NUNgnBw7SFi43hOvb34Fiv2RLseRuWH0TmPP
    QtkoeWxZfUy76L3USOoWVtrHlFFSMI1voPXS7A+ll7WfMl9UaCmQSpnPl8xArjuX
    KWJFllmL5o2AD27AZrQWczof4Gyi3MUFkArXo5+a7DXyDUbzkzS4RxZtD83TUaOS
    BUlUBFDzV164YyGILxceXePLeTQ1onvT/o3uKETQKKUA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424204AbeBOPpo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:45:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033898AbeBOPpn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 154/202] media: vivid: fix module load error when enabling fb and no_error_inj=1
Date: Thu, 15 Feb 2018 16:17:34 +0100
Message-Id: <20180215151720.995799072@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 0fa2c5f954c41e870fe327907c01cb8f7ea8d5a2 upstream.

If the framebuffer is enabled and error injection is disabled, then
creating the controls for the video output device would fail with an
error.

This is because the Clear Framebuffer control uses the 'vivid control
class' and that control class isn't added if error injection is disabled.

In addition, this control was added to e.g. vbi devices as well, which
makes no sense.

Move this control to its own control handler and handle it correctly.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-core.h  |    1 
 drivers/media/platform/vivid/vivid-ctrls.c |   35 ++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 6 deletions(-)

--- a/drivers/media/platform/vivid/vivid-core.h
+++ b/drivers/media/platform/vivid/vivid-core.h
@@ -154,6 +154,7 @@ struct vivid_dev {
 	struct v4l2_ctrl_handler	ctrl_hdl_streaming;
 	struct v4l2_ctrl_handler	ctrl_hdl_sdtv_cap;
 	struct v4l2_ctrl_handler	ctrl_hdl_loop_cap;
+	struct v4l2_ctrl_handler	ctrl_hdl_fb;
 	struct video_device		vid_cap_dev;
 	struct v4l2_ctrl_handler	ctrl_hdl_vid_cap;
 	struct video_device		vid_out_dev;
--- a/drivers/media/platform/vivid/vivid-ctrls.c
+++ b/drivers/media/platform/vivid/vivid-ctrls.c
@@ -120,9 +120,6 @@ static int vivid_user_gen_s_ctrl(struct
 		clear_bit(V4L2_FL_REGISTERED, &dev->radio_rx_dev.flags);
 		clear_bit(V4L2_FL_REGISTERED, &dev->radio_tx_dev.flags);
 		break;
-	case VIVID_CID_CLEAR_FB:
-		vivid_clear_fb(dev);
-		break;
 	case VIVID_CID_BUTTON:
 		dev->button_pressed = 30;
 		break;
@@ -274,8 +271,28 @@ static const struct v4l2_ctrl_config viv
 	.type = V4L2_CTRL_TYPE_BUTTON,
 };
 
+
+/* Framebuffer Controls */
+
+static int vivid_fb_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vivid_dev *dev = container_of(ctrl->handler,
+					     struct vivid_dev, ctrl_hdl_fb);
+
+	switch (ctrl->id) {
+	case VIVID_CID_CLEAR_FB:
+		vivid_clear_fb(dev);
+		break;
+	}
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops vivid_fb_ctrl_ops = {
+	.s_ctrl = vivid_fb_s_ctrl,
+};
+
 static const struct v4l2_ctrl_config vivid_ctrl_clear_fb = {
-	.ops = &vivid_user_gen_ctrl_ops,
+	.ops = &vivid_fb_ctrl_ops,
 	.id = VIVID_CID_CLEAR_FB,
 	.name = "Clear Framebuffer",
 	.type = V4L2_CTRL_TYPE_BUTTON,
@@ -1357,6 +1374,7 @@ int vivid_create_controls(struct vivid_d
 	struct v4l2_ctrl_handler *hdl_streaming = &dev->ctrl_hdl_streaming;
 	struct v4l2_ctrl_handler *hdl_sdtv_cap = &dev->ctrl_hdl_sdtv_cap;
 	struct v4l2_ctrl_handler *hdl_loop_cap = &dev->ctrl_hdl_loop_cap;
+	struct v4l2_ctrl_handler *hdl_fb = &dev->ctrl_hdl_fb;
 	struct v4l2_ctrl_handler *hdl_vid_cap = &dev->ctrl_hdl_vid_cap;
 	struct v4l2_ctrl_handler *hdl_vid_out = &dev->ctrl_hdl_vid_out;
 	struct v4l2_ctrl_handler *hdl_vbi_cap = &dev->ctrl_hdl_vbi_cap;
@@ -1384,10 +1402,12 @@ int vivid_create_controls(struct vivid_d
 	v4l2_ctrl_new_custom(hdl_sdtv_cap, &vivid_ctrl_class, NULL);
 	v4l2_ctrl_handler_init(hdl_loop_cap, 1);
 	v4l2_ctrl_new_custom(hdl_loop_cap, &vivid_ctrl_class, NULL);
+	v4l2_ctrl_handler_init(hdl_fb, 1);
+	v4l2_ctrl_new_custom(hdl_fb, &vivid_ctrl_class, NULL);
 	v4l2_ctrl_handler_init(hdl_vid_cap, 55);
 	v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_class, NULL);
 	v4l2_ctrl_handler_init(hdl_vid_out, 26);
-	if (!no_error_inj)
+	if (!no_error_inj || dev->has_fb)
 		v4l2_ctrl_new_custom(hdl_vid_out, &vivid_ctrl_class, NULL);
 	v4l2_ctrl_handler_init(hdl_vbi_cap, 21);
 	v4l2_ctrl_new_custom(hdl_vbi_cap, &vivid_ctrl_class, NULL);
@@ -1561,7 +1581,7 @@ int vivid_create_controls(struct vivid_d
 		v4l2_ctrl_new_custom(hdl_loop_cap, &vivid_ctrl_loop_video, NULL);
 
 	if (dev->has_fb)
-		v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_clear_fb, NULL);
+		v4l2_ctrl_new_custom(hdl_fb, &vivid_ctrl_clear_fb, NULL);
 
 	if (dev->has_radio_rx) {
 		v4l2_ctrl_new_custom(hdl_radio_rx, &vivid_ctrl_radio_hw_seek_mode, NULL);
@@ -1658,6 +1678,7 @@ int vivid_create_controls(struct vivid_d
 		v4l2_ctrl_add_handler(hdl_vid_cap, hdl_streaming, NULL);
 		v4l2_ctrl_add_handler(hdl_vid_cap, hdl_sdtv_cap, NULL);
 		v4l2_ctrl_add_handler(hdl_vid_cap, hdl_loop_cap, NULL);
+		v4l2_ctrl_add_handler(hdl_vid_cap, hdl_fb, NULL);
 		if (hdl_vid_cap->error)
 			return hdl_vid_cap->error;
 		dev->vid_cap_dev.ctrl_handler = hdl_vid_cap;
@@ -1666,6 +1687,7 @@ int vivid_create_controls(struct vivid_d
 		v4l2_ctrl_add_handler(hdl_vid_out, hdl_user_gen, NULL);
 		v4l2_ctrl_add_handler(hdl_vid_out, hdl_user_aud, NULL);
 		v4l2_ctrl_add_handler(hdl_vid_out, hdl_streaming, NULL);
+		v4l2_ctrl_add_handler(hdl_vid_out, hdl_fb, NULL);
 		if (hdl_vid_out->error)
 			return hdl_vid_out->error;
 		dev->vid_out_dev.ctrl_handler = hdl_vid_out;
@@ -1725,4 +1747,5 @@ void vivid_free_controls(struct vivid_de
 	v4l2_ctrl_handler_free(&dev->ctrl_hdl_streaming);
 	v4l2_ctrl_handler_free(&dev->ctrl_hdl_sdtv_cap);
 	v4l2_ctrl_handler_free(&dev->ctrl_hdl_loop_cap);
+	v4l2_ctrl_handler_free(&dev->ctrl_hdl_fb);
 }
