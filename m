Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618E1C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2568C23EAE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2568C23EAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFVIJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:09:15 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:51291 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeFVIJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:09:12 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jun 2018 04:09:12 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3F0782800B1DB;
        Fri, 22 Jun 2018 10:01:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D2A3C1C038; Fri, 22 Jun 2018 10:01:25 +0200 (CEST)
Date:   Fri, 22 Jun 2018 10:01:25 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] genirq: Synchronize only with single thread on free_irq()
Message-ID: <20180622080125.GA13709@wunner.de>
References: <8f770886632640321592873e4c902218d42c436b.1527194314.git.lukas@wunner.de>
 <alpine.DEB.2.21.1806212217571.1591@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806212217571.1591@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 10:21:44PM +0200, Thomas Gleixner wrote:
> On Thu, 24 May 2018, Lukas Wunner wrote:
> >  static int irq_wait_for_interrupt(struct irqaction *action)
> >  {
> > -	set_current_state(TASK_INTERRUPTIBLE);
> > +	for (;;) {
> > +		set_current_state(TASK_INTERRUPTIBLE);
> >  
> > -	while (!kthread_should_stop()) {
> > +		if (kthread_should_stop()) {
> > +			/* may need to run one last time. */
> > +			if (test_and_clear_bit(IRQTF_RUNTHREAD,
> > +					       &action->thread_flags)) {
> > +				__set_current_state(TASK_RUNNING);
> > +				return 0;
> > +			}
> > +			__set_current_state(TASK_RUNNING);
> > +			return -1;
> > +		}
> >  
> >  		if (test_and_clear_bit(IRQTF_RUNTHREAD,
> >  				       &action->thread_flags)) {
> > @@ -766,10 +776,7 @@ static int irq_wait_for_interrupt(struct irqaction *action)
> >  			return 0;
> >  		}
> >  		schedule();
> > -		set_current_state(TASK_INTERRUPTIBLE);
> >  	}
> > -	__set_current_state(TASK_RUNNING);
> > -	return -1;
> >  }
> >  
> >  /*
> > @@ -990,7 +997,7 @@ static int irq_thread(void *data)
> >  	/*
> >  	 * This is the regular exit path. __free_irq() is stopping the
> >  	 * thread via kthread_stop() after calling
> > -	 * synchronize_irq(). So neither IRQTF_RUNTHREAD nor the
> > +	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
> >  	 * oneshot mask bit can be set. We cannot verify that as we
> >  	 * cannot touch the oneshot mask at this point anymore as
> >  	 * __setup_irq() might have given out currents thread_mask
> > @@ -1595,7 +1602,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
> >  	unregister_handler_proc(irq, action);
> >  
> >  	/* Make sure it's not being used on another CPU: */
> > -	synchronize_irq(irq);
> > +	synchronize_hardirq(irq);
> 
> So after that, action can be freed and when the thread above tries to
> access it. Nice Use After Free. That needs more thought.

No, after that, kthread_stop() is called which blocks until the IRQ
thread has completed.  Only then is the action freed.

Thanks,

Lukas
