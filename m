Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591112-2-7515025857745973084
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
    t=1517591111; b=cn6UHL9E5RyS4399PQ1XaRtmjR4XtPM2vc+e19OmMJqX18v
    hKnVGeIURxbF1/2pckcneP/HPxAEC5NwVSOjyNiIEBZt/rS2NtquTYqyYabFUqLi
    5U7Q4dAxSNJfjLe/uqLbM421ZAGfzYZiBS5Wo2+AMKjODj2fxjbNfIV/oeo4ABfq
    HrSiV1Vcf+9hw7Uik2xhQ6PzNE+QGkVU0IgJ6zxPYFufQAYgu89x5rcKSvHgDneA
    T6u3e09RZW4mlwbTMZQDgCUsUfEVtdOUtIreH4dXP5PFONBG7jqmB7UBPLBgRqB3
    jphSjkVF9eBVuIqOWlGK8JxVI6IGcKkuKCKhRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591111; bh=ME0CzJTpgjFUto6U92HSH1Zi6E
    4vELVambrL3ZPLui0=; b=kUpV1VQE2f2t6ef2a3tjr9Xw61vIP4gP6xTJ6htruW
    htGYJ4AXw6npRQQ2vZkTzWMTvB+4gNap7A1zOGENJzue7Bta4se0GTES/i4WO5KX
    I93H1LkdgWy7iPBAUprkAlEoOPb3vdQqhOksA1qd6aDJgbhHXfISbrOdT1pIDR0a
    UuCsMJypeoYJNV2TBDxdrcguBagN+YjlqKLdvD72CT/rXv+gDx/adtc7iQXX1zoN
    9BJCvKsfapAw0h024tInSJdVGk+DpBJWAI/phQDq1M5nN2Za1BAGxXJGmYrgChBW
    XPIT8XTERarI5w0hxcALLhxNWsNJXJ1YlzWuu0uwyYGA==
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
        id S1752951AbeBBRFI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:05:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36326 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbeBBREz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:04:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Schake <stschake@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 17/86] drm/vc4: Account for interrupts in flight
Date: Fri,  2 Feb 2018 17:57:37 +0100
Message-Id: <20180202140824.410233044@linuxfoundation.org>
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


[ Upstream commit 253696ccd613fbdaa5aba1de44c461a058e0a114 ]

Synchronously disable the IRQ to make the following cancel_work_sync
invocation effective.

An interrupt in flight could enqueue further overflow mem work. As we
free the binner BO immediately following vc4_irq_uninstall this caused
a NULL pointer dereference in the work callback vc4_overflow_mem_work.

Link: https://github.com/anholt/linux/issues/114
Signed-off-by: Stefan Schake <stschake@gmail.com>
Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/1510275907-993-2-git-send-email-stschake@gmail.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vc4/vc4_irq.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -208,6 +208,9 @@ vc4_irq_postinstall(struct drm_device *d
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
+	/* Undo the effects of a previous vc4_irq_uninstall. */
+	enable_irq(dev->irq);
+
 	/* Enable both the render done and out of memory interrupts. */
 	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
 
@@ -225,6 +228,9 @@ vc4_irq_uninstall(struct drm_device *dev
 	/* Clear any pending interrupts we might have left. */
 	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
 
+	/* Finish any interrupt handler still in flight. */
+	disable_irq(dev->irq);
+
 	cancel_work_sync(&vc4->overflow_mem_work);
 }
 
