Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3641323-1519411997-2-2896701077011284869
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
    t=1519411997; b=fXkLX+lkKWtBzV80xGvihyywTT1f8dlF8rW4HZsZkqGgJfH
    JdIKI05AzNdH7BA0d5389AyWqT4MLLd6aRKW/nGzSNYKGY0DxHpjLv8LhMlLyjv1
    CZv28cb1sPvAnj7CIUpWQegOD27qS6zXGZGx4pE+Cy6jmP2lsKlNg0SD80UKA31F
    IeoXuDorIgBopG3pWy5d025RD0Tb/eWCAw6rIzRt15tWtWign0Vdybdy0Bd+cv08
    kwnWqLzKT6ZS3lnUQVMUl9NB2aD9KZOwQg/vwEtHNZVv2xI9WOuD3bOI1+fnCMqI
    jJUqrHz31Kd8yl0lVwyzALQsDsJCbR9tkps9z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411997; bh=UftxCZgHxG+iw5FHasfhdS5IGr
    xDubPsvNvsmR0t5X0=; b=hArmrjkrIcA7t3LvsaOBEnk19haW/73hNLVXOmE4VA
    vpQ7midmZfRH6IEgue4dBQWnJqrmRM9+R/kEYfqn8OFksseHvK2LuIb96LthVRDx
    R9uafWZxQc2LojhM9NezIuizlPxBV5s0c1Ez58jcuu1TQl7383FOqSI911nAnR/s
    Dd/OfWkGyr8b7xKGyJo0E17tZabXYDGLOUhVB/zXedQkc74sv/4ZoLHXJ+iGHZgl
    9ru6gwqoAWm/R3BnzKDTVfloz0JQEMGrnasuk3q6/IOGXfyEXlz1y17SwA7f9b0t
    smVwXiR17ftRpIFO6nGd4Ho2G8BBetZYx9Rnn4aDaFyQ==
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
        id S935346AbeBWSxM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935345AbeBWSxL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 088/159] KVM: arm/arm64: Fix spinlock acquisition in vgic_set_owner
Date: Fri, 23 Feb 2018 19:26:36 +0100
Message-Id: <20180223170754.163578815@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


[ Upstream commit 7465894e90e5a47e0e52aa5f1f708653fc40020f ]

vgic_set_owner acquires the irq lock without disabling interrupts,
resulting in a lockdep splat (an interrupt could fire and result
in the same lock being taken if the same virtual irq is to be
injected).

In practice, it is almost impossible to trigger this bug, but
better safe than sorry. Convert the lock acquisition to a
spin_lock_irqsave() and keep lockdep happy.

Reported-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/arm/vgic/vgic.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -454,6 +454,7 @@ int kvm_vgic_unmap_phys_irq(struct kvm_v
 int kvm_vgic_set_owner(struct kvm_vcpu *vcpu, unsigned int intid, void *owner)
 {
 	struct vgic_irq *irq;
+	unsigned long flags;
 	int ret = 0;
 
 	if (!vgic_initialized(vcpu->kvm))
@@ -464,12 +465,12 @@ int kvm_vgic_set_owner(struct kvm_vcpu *
 		return -EINVAL;
 
 	irq = vgic_get_irq(vcpu->kvm, vcpu, intid);
-	spin_lock(&irq->irq_lock);
+	spin_lock_irqsave(&irq->irq_lock, flags);
 	if (irq->owner && irq->owner != owner)
 		ret = -EEXIST;
 	else
 		irq->owner = owner;
-	spin_unlock(&irq->irq_lock);
+	spin_unlock_irqrestore(&irq->irq_lock, flags);
 
 	return ret;
 }
