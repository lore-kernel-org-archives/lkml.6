Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BEC208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BEC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeLGNq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:46:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55314 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:46:26 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gVGST-0000A4-68; Fri, 07 Dec 2018 14:46:21 +0100
Date:   Fri, 7 Dec 2018 14:46:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH] irq: Request and release resources for chained IRQs
In-Reply-To: <CACRpkdaRs5=Yt6fuSypeJpqdrUApFxxeBqm5sxsw+BdG=jbfBA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812071404140.14498@nanos.tec.linutronix.de>
References: <20181129133119.29387-1-linus.walleij@linaro.org> <CACRpkdbKrpWQJkL=FFis39PiHxvx5zOL0gYHuYa80yYMdP8bqw@mail.gmail.com> <alpine.DEB.2.21.1812071143480.14498@nanos.tec.linutronix.de>
 <CACRpkdaRs5=Yt6fuSypeJpqdrUApFxxeBqm5sxsw+BdG=jbfBA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Fri, 7 Dec 2018, Linus Walleij wrote:
> On Fri, Dec 7, 2018 at 12:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Needs more thought. Btw, the uninstall path does not invoke irq_deactive()
> > either.... I so hate that chained handler mess....
> 
> I think it is just extremely uncommon to remove a chained handler
> (I don't know if anything exercises that path even) that is why we
> don't see any fallout from it. It's probably just untested code.

git grep irq_set_chained.*NULL

tells that there are users. Whether any of this is ever invoked is a
different questions.

> Do you see that chained handlers have any merit at all or should
> they all be moved to nested? The question needs asking, but IIUC
> there are performance benefits with chaining as opposed to
> nesting. :/

The nested case in gpio land is about nesting in irq thread context, which
is obviously slower. So instead of nesting you can just use a regular
interrupt for demultiplexing.

The thing about chained is:

  1) It's hidden, i.e. not exposed in /proc/interrupt

  2) It's not protected against runaway interrupts, which has happened in
     x86 land. We've converted those over to use regular interrupts to
     catch that case and shutdown the offending interrupt.
     e.g. ba714a9c1dea

  3) All the chained handlers have their own flow control inside the
     handler.

The chained performance benefit compared to a regular handler is
minimal. The main difference are a few conditionals and the desc->action
indirection. You probably can measure it with a high interrupt load, but
I'm still not convinced that it outweighs the downsides for a lot of the
places which use chained interrupts. I can see the benefit for very low
level interrupts, but even there we had hard to debug issues with some ARM
SoCs which ran into interrupt storms.

But hey, we surely can fix that chained issue. It's not going to be pretty
though :)

Thanks,

	tglx






    

