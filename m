Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9128C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAA92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAA92083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLGLwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:52:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54935 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLGLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:52:08 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gVEfs-0006ZG-N5; Fri, 07 Dec 2018 12:52:04 +0100
Date:   Fri, 7 Dec 2018 12:51:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH] irq: Request and release resources for chained IRQs
In-Reply-To: <CACRpkdbKrpWQJkL=FFis39PiHxvx5zOL0gYHuYa80yYMdP8bqw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812071143480.14498@nanos.tec.linutronix.de>
References: <20181129133119.29387-1-linus.walleij@linaro.org> <CACRpkdbKrpWQJkL=FFis39PiHxvx5zOL0gYHuYa80yYMdP8bqw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018, Linus Walleij wrote:

Sorry for answering late.

> On Thu, Nov 29, 2018 at 2:31 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > This irqchip is in drivers/pinctrl/qcom/pinctrl-msm.c and known
> > as TLMM.

TLMM == Totally Lost Manufacturer Mess?

> > However, the irqchip core helpers in GPIO assumes that
> > the .irq_request_resources() callback is always called before
> > .irq_enable(), and the latter is where module refcount and
> > also gpiochip_lock_as_irq() is normally called.
> >
> > When .irq_enable() is called without .irq_request_resources()
> > having been called first, it seems like we are enabling
> > an IRQ on a GPIO line that has not first been locked to be
> > used as IRQ and we get the above warning. This happens since
> > as of
> > commit 461c1a7d4733d ("gpiolib: override irq_enable/disable")
> > this is strictly assumed for all GPIO-based IRQs.
> >
> > As it seems reasonable to assume that .irq_request_resources()
> > is always strictly called before .irq_enable(), we add the
> > irq_[request|release]_resources() functions to the internal
> > API and call them also when adding a chained irqchip to
> > an IRQ.
> >
> > I am a bit uncertain about the call site for
> > irq_released_resources() inside chip.c, but it appears this
> > path is for uninstalling a chained handler.

You cannot invoke those callbacks from __irq_do_set_handler() as that is
holding the irq descriptor lock with interrupts disabled.

The calling convention for irq_released_resources() is that it's called
with the bus lock held (if the chip provides the bus lock callbacks), but
definitely not with desc->lock held.

Needs more thought. Btw, the uninstall path does not invoke irq_deactive()
either.... I so hate that chained handler mess....

Thanks,

	tglx
