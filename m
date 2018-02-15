Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710545-2-8900569820485334145
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
    t=1518710544; b=HSZtYF8O0vtZZY6vKbWEIiGU8W58Wjy8g4xNEU65kevU8vC
    F7QjrsPhQtiBFKdhMKcHRq6Pk1VglR7dxDoQn3noJh+oyfTKutlJg+id92fdv+Iz
    nDKqewMPUnPNz1YNOPsRh8UojTlbP8743EDjB5gD8KF/H7wd1TjD7omH2AyiqqHE
    w1J71lN0D2avnBoYj3aNS2GkzfypGmt+/pkkaj6IxlboqcrXvpnBnKtZ8R/d1DT4
    l8dUxVra/p0WyYWlomgOe/mQcfOrWh732jOk2j/UuSf0nk3HW65uQln/BlqGWl+S
    E52WrnCJAo9mehogEDIVcYuhg+xIv1x+SCzYBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710544; bh=jNaxW92hpJ67D2hDsGRogjuhwL
    Wi54xO/FvWmccSnxs=; b=vjDgqrfGRSblU5/JifUEDx/9tDLhzFqFzFlu51Ax+C
    mTmb08Ib24oD+aq9uaj/oQFSMfexCUKOow5gEJN6MlYlZpaJ3AATr8fsj8VaGOD2
    qkmGHWyXTO+nJdVL2djSakZsY3/tQgPtmv+DCS1Komtn1CrzO1YLOcRvEuPV/WkX
    8lR4nne9zSn48Ytl+JJiBx+Gh4SBDFTX/mqcKA5q57/htJ/iucWtdrmTqDp4ZiiA
    q8d//4Q7dOpnMEYzR9rVgMZ9uIEAoeXNiZUuVKwxLntUmpLHTb+qd6JUu6xAVJvj
    ANDQfIjfrL1OVvQ8CAEsxZu0RdoCDcm9LrRy0MDXJ4Vw==
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
        id S1424705AbeBOPqn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424685AbeBOPqh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.15 175/202] genirq: Make legacy autoprobing work again
Date: Thu, 15 Feb 2018 16:17:55 +0100
Message-Id: <20180215151722.025049372@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 1beaeacdc88b537703d04d5536235d0bbb36db93 upstream.

Meelis reported the following warning on a quad P3 HP NetServer museum piece:

WARNING: CPU: 3 PID: 258 at kernel/irq/chip.c:244 __irq_startup+0x80/0x100
EIP: __irq_startup+0x80/0x100
irq_startup+0x7e/0x170
probe_irq_on+0x128/0x2b0
parport_irq_probe.constprop.18+0x8d/0x1af [parport_pc]
parport_pc_probe_port+0xf11/0x1260 [parport_pc]
parport_pc_init+0x78a/0xf10 [parport_pc]
parport_parse_param.constprop.16+0xf0/0xf0 [parport_pc]
do_one_initcall+0x45/0x1e0

This is caused by the rewrite of the irq activation/startup sequence which
missed to convert a callsite in the irq legacy auto probing code.

To fix this irq_activate_and_startup() needs to gain a return value so the
pending logic can work proper.

Fixes: c942cee46bba ("genirq: Separate activation and startup")
Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Meelis Roos <mroos@linux.ee>
Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801301935410.1797@nanos
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/autoprobe.c |    2 +-
 kernel/irq/chip.c      |    6 +++---
 kernel/irq/internals.h |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -71,7 +71,7 @@ unsigned long probe_irq_on(void)
 		raw_spin_lock_irq(&desc->lock);
 		if (!desc->action && irq_settings_can_probe(desc)) {
 			desc->istate |= IRQS_AUTODETECT | IRQS_WAITING;
-			if (irq_startup(desc, IRQ_NORESEND, IRQ_START_FORCE))
+			if (irq_activate_and_startup(desc, IRQ_NORESEND))
 				desc->istate |= IRQS_PENDING;
 		}
 		raw_spin_unlock_irq(&desc->lock);
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -294,11 +294,11 @@ int irq_activate(struct irq_desc *desc)
 	return 0;
 }
 
-void irq_activate_and_startup(struct irq_desc *desc, bool resend)
+int irq_activate_and_startup(struct irq_desc *desc, bool resend)
 {
 	if (WARN_ON(irq_activate(desc)))
-		return;
-	irq_startup(desc, resend, IRQ_START_FORCE);
+		return 0;
+	return irq_startup(desc, resend, IRQ_START_FORCE);
 }
 
 static void __irq_disable(struct irq_desc *desc, bool mask);
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -76,7 +76,7 @@ extern void __enable_irq(struct irq_desc
 #define IRQ_START_COND	false
 
 extern int irq_activate(struct irq_desc *desc);
-extern void irq_activate_and_startup(struct irq_desc *desc, bool resend);
+extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
 extern void irq_shutdown(struct irq_desc *desc);
