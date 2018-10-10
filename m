Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51711C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E74A2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E74A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJJUJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:09:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45396 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:09:34 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gADtW-0007vN-7o; Wed, 10 Oct 2018 14:47:18 +0200
Date:   Wed, 10 Oct 2018 14:47:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Woodhouse <dwmw2@infradead.org>
cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        boris.ostrovsky@oracle.com, hpa@zytor.com, mingo@redhat.com,
        bp@alien8.de, stable@vger.kernel.org, Waiman.Long@hp.com,
        peterz@infradead.org
Subject: Re: [PATCH 2/2] xen: make xen_qlock_wait() nestable
In-Reply-To: <eb9250d00cf9095913a7ecc3a2c575b9ed40fd6f.camel@infradead.org>
Message-ID: <alpine.DEB.2.21.1810101445530.10278@nanos.tec.linutronix.de>
References: <20181001071641.19282-1-jgross@suse.com>          <20181001071641.19282-3-jgross@suse.com>  <47686a61dfc06aa5afb05a893b9a56e6eb46763d.camel@infradead.org>  <alpine.DEB.2.21.1810101426080.10278@nanos.tec.linutronix.de>
 <eb9250d00cf9095913a7ecc3a2c575b9ed40fd6f.camel@infradead.org>
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

On Wed, 10 Oct 2018, David Woodhouse wrote:
> On Wed, 2018-10-10 at 14:30 +0200, Thomas Gleixner wrote:
> > On Wed, 10 Oct 2018, David Woodhouse wrote:
> > 
> > > On Mon, 2018-10-01 at 09:16 +0200, Juergen Gross wrote:
> > > > -       /* If irq pending already clear it and return. */
> > > > +       /* Guard against reentry. */
> > > > +       local_irq_save(flags);
> > > > +
> > > > +       /* If irq pending already clear it. */
> > > >         if (xen_test_irq_pending(irq)) {
> > > >                 xen_clear_irq_pending(irq);
> > > > -               return;
> > > > +       } else if (READ_ONCE(*byte) == val) {
> > > > +               /* Block until irq becomes pending (or a spurious wakeup) */
> > > > +               xen_poll_irq(irq);
> > > >         }
> > > 
> > > 
> > > Does this still allow other IRQs to wake it from xen_poll_irq()?
> > > 
> > > In the case where process-context code is spinning for a lock without
> > > disabling interrupts, we *should* allow interrupts to occur still...
> > > does this?
> > 
> > Yes. Look at it like idle HLT or WFI. You have to disable interrupt before
> > checking the condition and then the hardware or in this case the hypervisor
> > has to bring you back when an interrupt is raised.
> > 
> > If that would not work then the check would be racy, because the interrupt
> > could hit and be handled after the check and before going into
> > HLT/WFI/hypercall and then the thing is out until the next interrupt comes
> > along, which might be never.
> 
> Right, but in this case we're calling into the hypervisor to poll for
> one *specific* IRQ. Everything you say is true for that specific IRQ.
> 
> My question is what happens to *other* IRQs. We want them, but are they
> masked? I'm staring at the Xen do_poll() code and haven't quite worked
> that out...

Ah, sorry. That of course has to come back like HLT/WFI for any interrupt,
but I have no idea what the Xen HV is doing there.

Thanks,

	tglx
