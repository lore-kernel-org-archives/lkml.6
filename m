Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591163-2-13476047487085185003
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
    t=1517591163; b=muhw5jzly0FOMadnrkPYcE7c0mCqOrJlZ7cyQMmLG0vOAGP
    DkkjziFOFLGD+wXOFojyacSLuU+gCwqdxUGMPwbY1KoPzIqp4XTfeAnWLBrH86bT
    jfCTGkLD/4PSv3EimWKmzDrNnWdAp2tpivq9sk0CuKIIUOOchqIptkM91Ii45uTS
    /QrGnrWzzNH0ZdsQoaVVAO5flJ860FeESMH3/tnwZekBin3RUM6PJh0Q1A5W95Gw
    C3BYA7dCg4smpCmUEOhvU+VgX4nST1oNB/5YVh0yIL5X7Mq47ZXLYwn0/ogWR1BT
    GoO8rHewfT7PlAH/e6HhZNj3CYMxU82q4hZDD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591163; bh=6CmlIMMCabzsoWBpzMQAef6OWv
    07legF6SrrDuu03B4=; b=hC5Jz7Jf+1cxapWhTWJ/8JAM19vMpfQEJjiLJX2eSi
    JzgwRMIcsFlz4t2+2isq/QM4ozqdRoKg+X18Os2nGyGLBc3HEBaR8v4mxRuYMeMp
    T0jataspbP4g1qyGsCkrdJft6qnF+pL08UcXhT+ZN690eLg6s3HhKy7bzqzvPkgq
    CszsC7JlhXxP0sTTU6X30SRntVvw3Q8patoEbxk4haMOAmpWXsyarvxOtIzC1r5E
    ugYJS5sTOZlXmmpQM9TGvgFXAaaeRZLUA7XZofH/UPXmeJGgdFh08PkeW98pfYMg
    B1kPsk1tdCxgY/6iGw743v1F0qtv0B1rAYoWBSZ8iSpw==
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
        id S1753026AbeBBRF4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:05:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbeBBRFz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:05:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Schake <stschake@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 70/86] drm/vc4: Move IRQ enable to PM path
Date: Fri,  2 Feb 2018 17:58:30 +0100
Message-Id: <20180202140829.135557701@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Schake <stschake@gmail.com>


[ Upstream commit ce9caf2f79a5aa170a4b6456a03db639eed9c988 ]

We were calling enable_irq on bind, where it was already enabled previously
by the IRQ helper. Additionally, dev->irq is not set correctly until after
postinstall and so was always zero here, triggering a warning in 4.15.
Fix both by moving the enable to the power management resume path, where we
know there was a previous disable invocation during suspend.

Fixes: 253696ccd613 ("drm/vc4: Account for interrupts in flight")
Signed-off-by: Stefan Schake <stschake@gmail.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/1514563543-32511-1-git-send-email-stschake@gmail.com
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vc4/vc4_irq.c |    3 ---
 drivers/gpu/drm/vc4/vc4_v3d.c |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -208,9 +208,6 @@ vc4_irq_postinstall(struct drm_device *d
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
-	/* Undo the effects of a previous vc4_irq_uninstall. */
-	enable_irq(dev->irq);
-
 	/* Enable both the render done and out of memory interrupts. */
 	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
 
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -173,6 +173,9 @@ static int vc4_v3d_runtime_resume(struct
 	struct vc4_dev *vc4 = v3d->vc4;
 
 	vc4_v3d_init_hw(vc4->dev);
+
+	/* We disabled the IRQ as part of vc4_irq_uninstall in suspend. */
+	enable_irq(vc4->dev->irq);
 	vc4_irq_postinstall(vc4->dev);
 
 	return 0;
