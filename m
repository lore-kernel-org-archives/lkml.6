Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE74BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9155F20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfAOJZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:25:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41723 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfAOJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:25:07 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjKxw-0008Bj-Hc; Tue, 15 Jan 2019 10:25:00 +0100
Date:   Tue, 15 Jan 2019 10:24:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 4/4] /proc/stat: Call kstat_irqs_usr() only for active
 IRQs
In-Reply-To: <3b863edf-1a3e-1436-93e7-717550c7256f@redhat.com>
Message-ID: <alpine.DEB.2.21.1901151023550.1865@nanos.tec.linutronix.de>
References: <1547061648-16080-1-git-send-email-longman@redhat.com> <1547061648-16080-5-git-send-email-longman@redhat.com> <alpine.DEB.2.21.1901111750280.4957@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901112017000.1661@nanos.tec.linutronix.de>
 <20190111192357.GK6310@bombadil.infradead.org> <alpine.DEB.2.21.1901112146180.1661@nanos.tec.linutronix.de> <3b863edf-1a3e-1436-93e7-717550c7256f@redhat.com>
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

Waiman,

On Mon, 14 Jan 2019, Waiman Long wrote:
> On 01/11/2019 04:02 PM, Thomas Gleixner wrote:
> > @@ -919,11 +920,15 @@ unsigned int kstat_irqs_cpu(unsigned int
> >  unsigned int kstat_irqs(unsigned int irq)
> >  {
> >  	struct irq_desc *desc = irq_to_desc(irq);
> > -	int cpu;
> >  	unsigned int sum = 0;
> > +	int cpu;
> >  
> >  	if (!desc || !desc->kstat_irqs)
> >  		return 0;
> > +	if (!irq_settings_is_per_cpu_devid(desc) &&
> > +	    !irq_settings_is_per_cpu(desc))
> > +	    return desc->tot_count;
> > +
> >  	for_each_possible_cpu(cpu)
> >  		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
> >  	return sum;
> >
> >
> That looks good to me. Thanks for providing a more simple solution.
> 
> BTW, if the percpu IRQ is known at allocation time, maybe we should just
> not allocate a percpu count for the corresponding descriptor.

Nope. You still need the per cpu accounting for /proc/interrupts ...

Thanks,

	tglx
