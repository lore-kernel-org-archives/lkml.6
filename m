Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77A720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77A720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeIMSm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:42:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:42:57 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D95A2D10;
        Thu, 13 Sep 2018 13:33:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manoil Claudiu <claudiu.manoil@freescale.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 4.4 43/60] genirq: Delay incrementing interrupt count if its disabled/pending
Date:   Thu, 13 Sep 2018 15:30:50 +0200
Message-Id: <20180913131747.453952836@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@arm.com>

commit a946e8c717f9355d1abd5408ed0adc0002d1aed1 upstream.

In case of a wakeup interrupt, irq_pm_check_wakeup disables the interrupt
and marks it pending and suspended, disables it and notifies the pm core
about the wake event. The interrupt gets handled later once the system
is resumed.

However the irq stats is updated twice: once when it's disabled waiting
for the system to resume and later when it's handled, resulting in wrong
counting of the wakeup interrupt when waking up the system.

This patch updates the interrupt count so that it's updated only when
the interrupt gets handled. It's already handled correctly in
handle_edge_irq and handle_edge_eoi_irq.

Reported-by: Manoil Claudiu <claudiu.manoil@freescale.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/1446661957-1019-1-git-send-email-sudeep.holla@arm.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/chip.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -338,7 +338,6 @@ void handle_nested_irq(unsigned int irq)
 	raw_spin_lock_irq(&desc->lock);
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-	kstat_incr_irqs_this_cpu(desc);
 
 	action = desc->action;
 	if (unlikely(!action || irqd_irq_disabled(&desc->irq_data))) {
@@ -346,6 +345,7 @@ void handle_nested_irq(unsigned int irq)
 		goto out_unlock;
 	}
 
+	kstat_incr_irqs_this_cpu(desc);
 	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	raw_spin_unlock_irq(&desc->lock);
 
@@ -412,13 +412,13 @@ void handle_simple_irq(struct irq_desc *
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-	kstat_incr_irqs_this_cpu(desc);
 
 	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
 		desc->istate |= IRQS_PENDING;
 		goto out_unlock;
 	}
 
+	kstat_incr_irqs_this_cpu(desc);
 	handle_irq_event(desc);
 
 out_unlock:
@@ -462,7 +462,6 @@ void handle_level_irq(struct irq_desc *d
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-	kstat_incr_irqs_this_cpu(desc);
 
 	/*
 	 * If its disabled or no action available
@@ -473,6 +472,7 @@ void handle_level_irq(struct irq_desc *d
 		goto out_unlock;
 	}
 
+	kstat_incr_irqs_this_cpu(desc);
 	handle_irq_event(desc);
 
 	cond_unmask_irq(desc);
@@ -532,7 +532,6 @@ void handle_fasteoi_irq(struct irq_desc
 		goto out;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
-	kstat_incr_irqs_this_cpu(desc);
 
 	/*
 	 * If its disabled or no action available
@@ -544,6 +543,7 @@ void handle_fasteoi_irq(struct irq_desc
 		goto out;
 	}
 
+	kstat_incr_irqs_this_cpu(desc);
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 


