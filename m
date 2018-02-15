Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1518708092-5-7477128147779959100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708092; b=wfffcHkmyR4KMhEzK2XOXZTKMnxM0caPOH0YdS2fTVLZfw8
    ZayI8vg/tsmgDZ823BPfuRFt34XZHMFCPDlsNpijapitKvj19VjGH8NfPccRlpOI
    ZJYMi9KklSR/6QWIe3WQEagHlds734RCJtkAoCK+lbczCZORpKwybbRagbNI0iow
    no+GHwyz3NRvW4Uub38U0O5XHokGxVnfLyqhjYJsI2X3W6zNnu/z5sA5ELmbzqcl
    rnK+zrI0hOdL1zaX+kcpSklADXFQOhTzJaiQYc6YcE2zzQsYD/TWxPRzWNLp8gIM
    Oub274icjzmI4GECT0e+CYTbPYruvMhvZAB9qHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708092; bh=ngFZC4OhjR8raqX8m3ym+HUlqX
    vp9ETRfL7HIvRqziY=; b=aoD5pF30F5E6QWeFlRNMRVpzSgU2IHOiyYCe0G97Vp
    QIqGEukJNLF/KjeQlMrxJxDBHBtqG9euih6c340JG0Q+LfN+SXBbHnHphFmwQXMc
    OYNGUcHJaVGoRyV7hz2rgXCRvu3SAiauf/py3OYUU9wLjZEa4m8pnQZZTQSZ3mvF
    pE3mngzQfZtW7jaJEu4pjwuSFRLtJGGtWtVLJOl+DhiCTmL9d3ovBPGjt7wMbUm6
    tu6K9xkE/VwtnwfOIMBuVuMDLxOaRJuIN4kihKHd/xmXOQC/pKfvt7HKRHXKsPP7
    N87kBBFzt+cnASx8R+fvMzUovcNVL11s9z5cxGiUv/sQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162063AbeBOPV2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162036AbeBOPV0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        thongsyho <thong.ho.px@rvc.renesas.com>,
        Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Subject: [PATCH 4.4 024/108] drm: rcar-du: Use the VBK interrupt for vblank events
Date: Thu, 15 Feb 2018 16:16:21 +0100
Message-Id: <20180215151225.926384928@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit cbbb90b0c084d7dfb2ed8e3fecf8df200fbdd2a0 upstream.

When implementing support for interlaced modes, the driver switched from
reporting vblank events on the vertical blanking (VBK) interrupt to the
frame end interrupt (FRM). This incorrectly divided the reported refresh
rate by two. Fix it by moving back to the VBK interrupt.

Fixes: 906eff7fcada ("drm: rcar-du: Implement support for interlaced modes")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: thongsyho <thong.ho.px@rvc.renesas.com>
Signed-off-by: Nhan Nguyen <nhan.nguyen.yb@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -531,7 +531,7 @@ static irqreturn_t rcar_du_crtc_irq(int
 	status = rcar_du_crtc_read(rcrtc, DSSR);
 	rcar_du_crtc_write(rcrtc, DSRCR, status & DSRCR_MASK);
 
-	if (status & DSSR_FRM) {
+	if (status & DSSR_VBK) {
 		drm_handle_vblank(rcrtc->crtc.dev, rcrtc->index);
 		rcar_du_crtc_finish_page_flip(rcrtc);
 		ret = IRQ_HANDLED;
