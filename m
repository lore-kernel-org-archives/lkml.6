Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3641323-1519411548-2-16873530042470764930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411548; b=RCFLRNmcfSUxfSzJLtyP5UOacauh/eVkbTM1DT0PCZd4pHy
    FHJjNzmYWrIO6Q+XkZ8/dDWeIUJGIosJM8aVbS1s+k4i4KBkDoUtAm970WR2cKzP
    L240j/WmS5j4SYRtvgiqvm8RjqXMsRWRuNOHq2Z3VJZM6jsCc/lUTF3eGxwfTMYU
    xPLgSSqz7divwCyrcpL4wOu+kvB4p2PcHEvHz9C2SbzZ5LXNOo7H0RJEnoAm6ZBM
    U+MGtOFaKDncZaIF74B9HXEji0MnNAG9iRtucVhbqvSjIr5xC0xFGRe2gN+3jg9p
    DG8AG8DZcF8IRNujrAxOQ2wNSvIk7pQ/0fCIcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411548; bh=8A6l1YrtC8x6jzNDsaFQOasb43
    lMKWL9Y5beqUIvTaA=; b=GTpS/AJdXfJ66Ctc0WN3xrQEUvVZcCd1N+rJUkaO8A
    Cd5skdfLg/djoE/cKXG0raM3Ssv5x0LGeZAFCXhPX/Bzx11ccYf3B66a8bSLyBBh
    VbP8LnCi8R+JMhU/seJFh7Xkp81nILPcF1YLmpqTmFy2W5A1n8uJkrncv/ZQnBq/
    guUSo5IIhWowJnT1yXyVggcu2YKF9a89eTfbfsLpdsHO5GKuH4xIeILn+Wf+Tfeu
    MWZ/Qc+dOhrTYhmSSBX306dLKiuO9M0n4cprulmfm3B0ZU4M0pYCIwVYBGQCT7Vj
    uNfWHk7dWYsARJvbjndlBH04mGzBoLiVBHBq5Kf7+Lfg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeBWSpr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:45:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbeBWSpo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 078/145] drm/armada: fix leak of crtc structure
Date: Fri, 23 Feb 2018 19:26:24 +0100
Message-Id: <20180223170734.813849392@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>


[ Upstream commit 33cd3c07a976e11c3c4cc6b0b3db6760ad1590c5 ]

Fix the leak of the CRTC structure in the failure paths of
armada_drm_crtc_create().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/armada/armada_crtc.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1178,17 +1178,13 @@ static int armada_drm_crtc_create(struct
 
 	ret = devm_request_irq(dev, irq, armada_drm_irq, 0, "armada_drm_crtc",
 			       dcrtc);
-	if (ret < 0) {
-		kfree(dcrtc);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_crtc;
 
 	if (dcrtc->variant->init) {
 		ret = dcrtc->variant->init(dcrtc, dev);
-		if (ret) {
-			kfree(dcrtc);
-			return ret;
-		}
+		if (ret)
+			goto err_crtc;
 	}
 
 	/* Ensure AXI pipeline is enabled */
@@ -1199,13 +1195,15 @@ static int armada_drm_crtc_create(struct
 	dcrtc->crtc.port = port;
 
 	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
-	if (!primary)
-		return -ENOMEM;
+	if (!primary) {
+		ret = -ENOMEM;
+		goto err_crtc;
+	}
 
 	ret = armada_drm_plane_init(primary);
 	if (ret) {
 		kfree(primary);
-		return ret;
+		goto err_crtc;
 	}
 
 	ret = drm_universal_plane_init(drm, &primary->base, 0,
@@ -1215,7 +1213,7 @@ static int armada_drm_crtc_create(struct
 				       DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret) {
 		kfree(primary);
-		return ret;
+		goto err_crtc;
 	}
 
 	ret = drm_crtc_init_with_planes(drm, &dcrtc->crtc, &primary->base, NULL,
@@ -1234,6 +1232,9 @@ static int armada_drm_crtc_create(struct
 
 err_crtc_init:
 	primary->base.funcs->destroy(&primary->base);
+err_crtc:
+	kfree(dcrtc);
+
 	return ret;
 }
 
