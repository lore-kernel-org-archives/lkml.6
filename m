Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAB6248DE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAB6248DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754514AbeFVVHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:07:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42790 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeFVVHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:07:04 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWTGo-00040z-Vj; Fri, 22 Jun 2018 23:07:03 +0200
Date:   Fri, 22 Jun 2018 23:07:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
cc:     linux-kernel@vger.kernel.org
Subject: Re: Nested IRQs resend
In-Reply-To: <36d5120d61939c98f4c6f2d160d22ef7@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1806222245490.1589@nanos.tec.linutronix.de>
References: <36d5120d61939c98f4c6f2d160d22ef7@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2018, Sodagudi Prasad wrote:
> 
> Trying to use IRQ resend support with simple driver. I observed that,
> re-triggering of nested threaded IRQs is not working. After digging into
> "kernel/irq/resend.c" file more,
> parent IRQ is needed for re-trigger to work.  I could not get much details,
> why parent_irq is needed for threaded IRQs resend?

The whole resend stuff was written way before threaded irqs or even nested
threaded irqs existed at all.

> 1)	Could you please provide more details about resend of nested threaded
> IRQs ?
> 2)	What should be the parent_irq handler in the case of nested IRQs ?
> threaded IRQ ?
> 3)	Are you expecting that parent_irq handler should know pending nesting
> IRQs  for resend?

Well, the point is that a nested threaded irq runs in the context of some
other irq. Ignore the parent irq concept in the resend code as that is
completely misleading. That's a corner case which has nothing to do with
nested threading at all.

Lets look at how nested threaded irqs work. The thread in which they nest
is usually a demultiplexing interrupt of some sort, which looks at a status
register to figure out which sub interrupt is pending and then executes
that interrupt in its own context. The reason why this is done is because
the whole handling of the underlying irq chip needs threaded context and
synchronization so running everything from the demultiplex thread makes a
lot of things simpler.

But there is no established relationship between the nested irq and the
demultiplex irq at least not from the nested irqs point of view. And even
if you'd know the irq number of the demultiplex irq and you could resend
it, then still you need a way to tell it that you want your particular
nested one resent in its context.

The proper solution to this is to actually implement the irq_retrigger()
callback for the underlying irq chip. That callback then has to set a
software maintained 'pending' bit for the interrupt in question and
retrigger the demultiplex interrupt. That works because the irq chip has
been populated by the facility which also requested the demultiplex
interrupt so the relationship is known there or can be made known
easily. Note, that in that case it's not even strictly required to use the
resend mechanism for the demultiplex interrupt. The irq chip providing
facilty knows that this is a nested thread case so it can simply wake the
demultiplex thread via irq_wake_thread().

Hope that helps. If you have further questions, don't hesitate to ask.

Thanks,

	tglx


