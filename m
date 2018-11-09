Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E9E20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E9E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeKIT7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:59:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIT7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:59:20 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gL3sn-0000q8-Q2; Fri, 09 Nov 2018 11:19:22 +0100
Date:   Fri, 9 Nov 2018 11:19:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq/irq_sim: add locking
In-Reply-To: <20181108194116.tjkku7hdqf67awuq@pengutronix.de>
Message-ID: <alpine.DEB.2.21.1811091108001.1519@nanos.tec.linutronix.de>
References: <20181108164748.31222-1-brgl@bgdev.pl> <20181108194116.tjkku7hdqf67awuq@pengutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-403059147-1541758761=:1519"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-403059147-1541758761=:1519
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 8 Nov 2018, Uwe Kleine-König wrote:
> On Thu, Nov 08, 2018 at 05:47:48PM +0100, Bartosz Golaszewski wrote:
> > @@ -74,6 +74,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
> >  	}
> >  
> >  	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
> > +	mutex_init(&sim->lock);
> >  	sim->irq_count = num_irqs;
> >  
> >  	return sim->irq_base;
> > @@ -142,10 +143,14 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> >   */
> >  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> >  {
> > +	mutex_lock(&sim->lock);
> > +
> >  	if (sim->irqs[offset].enabled) {
> >  		sim->work_ctx.irq = irq_sim_irqnum(sim, offset);
> >  		irq_work_queue(&sim->work_ctx.work);
> >  	}
> > +
> > +	mutex_unlock(&sim->lock);
> 
> This doesn't fix the issue I think. irq_work_queue() only schedules the
> work function. If after irq_sim_fire() returned but before the worker
> runs another irq_sim_fire() is issued the value is still overwritten.

Right. So the obvious solution is to avoid the irq number store and use a
bitfield instead.

struct irq_sim_work_ctx {
       ...
       unsigned long	pending;
};

fire(sim, offset)
{
	if (!sim->irqs[offset].enabled)
		return;

	set_bit(offset, &sim->work_ctx.pending);
	....

and in the work handler do:

handle(work)
{
	struct irq_sim_work_ctx *ctx = container_of(work,....);

	while (ctx->pending) {
		offs = ffs(ctx->pending);
		clr_bit(offs, &ctx->pending);
		handle_simple_irq(offs);
	}
}

Or something like that.

Thanks,

	tglx
--8323329-403059147-1541758761=:1519--
