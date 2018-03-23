Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-999974-1521800311-2-7711634846408041629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521800310; b=kbcsHVkb4UNhmovmvhb1TBte2yXxiUCy+OHLYj3lqeFBXX+
    ccDxHGIhtao9dR278wDY0+cta84VL+jhI3PHjiTs4AZFgVYFre4fl5ZqhATgcNiY
    83DfY5X90LGBiB8nsonso8NDPH873fHB1FUZ9wlA8jmTUcNs3U8bqUTLYg6aAzPp
    KoJIpps8uZ3CobVrxVMXoyxvthHimyt/rBLUrxOqF3juB70VUy9SLy5t2SFDsFE+
    nuq2WouEP5/4t0oAPjQLjQsSXR87RDo2pNyWG21+G2mbNCiAAHZXdSum1+UNpgzn
    FVmjLYCXMjgcfj9FUYoj6fsxfsCunqqxeCkQ89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521800310; bh=eeHu/SaUIiqDsfRXW7m2Yk8mcq
    sCtOcDN38FFjRjNR0=; b=qs6+TWWCWnU1M9vgltJBNdyRMalaDfn421eQdywaJI
    dMqd0BBrrpAU3htD+KASkaalxlg5FCG3ZGFUCxvkhgi8aDNqG7LGsbviV99+71jm
    Zcfi9Sj3M5IfqgJ2ZSuOSufht3m68rlQAzJ2E5yH6Qy0oG6ce0CsGCi1Jyh3hCIT
    G0A+tmxs6NMNQFek0CM30icqIJwbIDVxP8t+pOSUl8vK/1yibX3VOEEIrcrfdVvp
    m72UjmA7Zca2BNhRxykzExcKmkkm9oJF0u1IZhuSiyX/VtKhkaIKIdOkCVc6mj8u
    xH8Hh03mLFXurPd017QNaNMaSSrs1lgRBkQz3MbRwGjQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756102AbeCWKSX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:18:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756087AbeCWKSV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:18:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 06/47] genirq: Use irqd_get_trigger_type to compare the trigger type for shared IRQs
Date: Fri, 23 Mar 2018 10:54:57 +0100
Message-Id: <20180323094248.385615324@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 382bd4de61827dbaaf5fb4fb7b1f4be4a86505e7 ]

When requesting a shared irq with IRQF_TRIGGER_NONE then the irqaction
flags get filled with the trigger type from the irq_data:

        if (!(new->flags & IRQF_TRIGGER_MASK))
                new->flags |= irqd_get_trigger_type(&desc->irq_data);

On the first setup_irq() the trigger type in irq_data is NONE when the
above code executes, then the irq is started up for the first time and
then the actual trigger type gets established, but that's too late to fix
up new->flags.

When then a second user of the irq requests the irq with IRQF_TRIGGER_NONE
its irqaction's triggertype gets set to the actual trigger type and the
following check fails:

        if (!((old->flags ^ new->flags) & IRQF_TRIGGER_MASK))

Resulting in the request_irq failing with -EBUSY even though both
users requested the irq with IRQF_SHARED | IRQF_TRIGGER_NONE

Fix this by comparing the new irqaction's trigger type to the trigger type
stored in the irq_data which correctly reflects the actual trigger type
being used for the irq.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/20170415100831.17073-1-hdegoede@redhat.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/manage.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1058,8 +1058,10 @@ __setup_irq(unsigned int irq, struct irq
 		 * set the trigger type must match. Also all must
 		 * agree on ONESHOT.
 		 */
+		unsigned int oldtype = irqd_get_trigger_type(&desc->irq_data);
+
 		if (!((old->flags & new->flags) & IRQF_SHARED) ||
-		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
+		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)) ||
 		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
 			goto mismatch;
 
