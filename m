Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591593-2-15218829309318431788
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
    t=1517591592; b=pOqmgEPDVE77Lv4fO8Ky5f3I2P56BL/cWzADq58XsA9Emxu
    4pv0V9w//puk6ZeY84azDrouSlL978OALuElmQBXTuS7fuLK1r+LUfFZiOVlRBZI
    BvHQURHf8ckY01nnWDVCQDgExFetCKhHI/tprG+mskYDdGD4m7SjQjLH55Mr392f
    vI1FWROu8d6X1xyXZhB9pvSA4gykn50uY7MIOMHRzIBY1S8+cwzV/GfXZyyo7NXI
    EWZB5+BguGg2pWe8EtmKjXsMealRvzizpVzDIQUreS0NLp030TPw2bvlNAZZ1rZJ
    G+HiR0/QH78aUsPoDjByDvlJZGDfKe8t4XMIsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591592; bh=WZwEYmKtPt7Qn0kXEJ3IKl7B/X
    xrFA4J3PBu7aT17cQ=; b=T3S4LePYxXUvdGUDU3o2CsMNdtzcqUfOeYMbfbwX1t
    koD2UxQHF4PSa1fuI6/1XZd/8ZfQkooo633VWYuUhCPe56fXrcJbMtdV8DbC7qoj
    gFAiSjKh9I+v+F6toxTwBiGnJagoQPNQIFrPSOPo89lGBs4ATNKCK2f0NUK3rxJu
    5iYTvWKQTIlJOj9i0EyO2vn7MbiBFbLnaYOM6mSqdcx/qWfQagUaX7U81CKIePD/
    wV7NN3R9808CmbWBd22sQOWbYAi178JpbYftMg+NLKEaIkcd2NKWCQzSOB8mZs+A
    lyv4FWJnwEOSRW+wUI5qYMrxfj613beMB3Dgy/UnxYsg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbeBBRNK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:13:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbeBBRM4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:12:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Schake <stschake@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 127/156] drm/vc4: Move IRQ enable to PM path
Date: Fri,  2 Feb 2018 17:58:28 +0100
Message-Id: <20180202140846.119895785@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -327,6 +327,9 @@ static int vc4_v3d_runtime_resume(struct
 		return ret;
 
 	vc4_v3d_init_hw(vc4->dev);
+
+	/* We disabled the IRQ as part of vc4_irq_uninstall in suspend. */
+	enable_irq(vc4->dev->irq);
 	vc4_irq_postinstall(vc4->dev);
 
 	return 0;
