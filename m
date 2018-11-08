Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F4ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4DD20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4DD20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeKIHDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:03:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46065 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKIHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:03:09 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKroB-0003Yk-4N; Thu, 08 Nov 2018 22:25:47 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKroA-0007zh-Sm; Thu, 08 Nov 2018 22:25:46 +0100
Date:   Thu, 8 Nov 2018 22:25:46 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq/irq_sim: add locking
Message-ID: <20181108212546.n5h2hssk55moyg3p@pengutronix.de>
References: <20181108164748.31222-1-brgl@bgdev.pl>
 <20181108194116.tjkku7hdqf67awuq@pengutronix.de>
 <CAMRc=McmKVcCHiZv2Vy0b6J2hUmXsR_Rs3+V81KvihHtzF4MFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McmKVcCHiZv2Vy0b6J2hUmXsR_Rs3+V81KvihHtzF4MFA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 08, 2018 at 09:55:02PM +0100, Bartosz Golaszewski wrote:
> czw., 8 lis 2018 o 20:41 Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> napisał(a):
> > > @@ -142,10 +143,14 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
> > >   */
> > >  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> > >  {
> > > +     mutex_lock(&sim->lock);
> > > +
> > >       if (sim->irqs[offset].enabled) {
> > >               sim->work_ctx.irq = irq_sim_irqnum(sim, offset);
> > >               irq_work_queue(&sim->work_ctx.work);
> > >       }
> > > +
> > > +     mutex_unlock(&sim->lock);
> >
> > This doesn't fix the issue I think. irq_work_queue() only schedules the
> > work function. If after irq_sim_fire() returned but before the worker
> > runs another irq_sim_fire() is issued the value is still overwritten.
> 
> Looking at irq_work_queue(): while there may be some arch-specific
> details deeper down the stack, it seems that unless the work is
> IRQ_WORK_LAZY, the handler should be executed immediately. I'll verify
> tomorrow though.

not considering the IRQ_WORK_LAZY case irq_work_queue adds the work
struct to a list and then calls arch_irq_work_raise(). The default
implementation for this function is empty. alpha, arm, arm64, powerpc,
sparc and x86 have alternative implementations. Quickly looking at the
arm one: It is only used on SMP. Also given that all relevant code of
irq_work_queue is protected by preempt_disable/preempt_enable this
cannot atomically call the work function, otherwise it would run with
preemption disabled which isn't the case AFAIK.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
