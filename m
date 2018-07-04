Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9590C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73340208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73340208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933643AbeGDGng (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:43:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753518AbeGDGnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:43:35 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fabVi-0008FK-SP; Wed, 04 Jul 2018 08:43:31 +0200
Date:   Wed, 4 Jul 2018 08:43:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Guo Ren <ren_guo@c-sky.com>
cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
In-Reply-To: <20180704050822.GA23536@guoren>
Message-ID: <alpine.DEB.2.21.1807040841080.1816@nanos.tec.linutronix.de>
References: <cover.1530465325.git.ren_guo@c-sky.com> <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com> <alpine.DEB.2.21.1807031100280.1601@nanos.tec.linutronix.de> <20180704050822.GA23536@guoren>
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

On Wed, 4 Jul 2018, Guo Ren wrote:
> On Tue, Jul 03, 2018 at 11:28:03AM +0200, Thomas Gleixner wrote:
> That's Ok. And here is my implementation:
> 
> static inline u32 build_intc_ctrl(u32 idx)
> {
> 	/*
> 	 * One channel is one byte in a word-width register, so
> 	 * there are four channels in a word-width register.
> 	 *
> 	 * Set the same index for each channel and it will make
> 	 * "irq num = channel num".
> 	 */
> 	return (idx             | ((idx + 1) << 8) |
> 	      ((idx + 2) << 16) | ((idx + 3) << 24));
> }
> Hmm? (No magic number)

Ok :)

> > > +	static void __iomem	*reg_base;
> > > +	irq_hw_number_t		hwirq;
> > > +
> > > +	reg_base = *this_cpu_ptr(&intcl_reg);
> > 
> > Wheee!
> > 
> > 	static void __iomem *reg_base = this_cpu_read(intcl_reg);
> > 	irq_hw_number_t	hwirq;
> > 
> > Hmm?
> Thx for the tips and I'll use this_cpu_read() without static.
>  	void __iomem *reg_base = this_cpu_read(intcl_reg);

Yeah, I surely missed to drop the static ...

> > 
> > Aside of that the whole thing might share the code with the other one, but
> > it might not be worth it. At least this wants to be documented in the
> > changelog why sharing the code is not useful...
>
> Do you mean merge irq-csky-v1.c irq-csky-v2.c irq-nationalchip.c into
> one file eg: irq-csky.c? 

Yes, but only if there is enough code to share without creating an ifdef
mess. But that looks doable

Thanks,

	tglx
