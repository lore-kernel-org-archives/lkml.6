Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD2CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1B520827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfAHPBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:01:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfAHPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:01:41 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ggssn-0004Dy-Q8; Tue, 08 Jan 2019 16:01:33 +0100
Date:   Tue, 8 Jan 2019 16:01:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
cc:     Leonard Crestez <cdleonard@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Daniel Drake <drake@endlessm.com>,
        Nitesh Kumar Agrawal <Nitesh-kumar.Agrawal@amd.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Interrupt storm from pinctrl-amd on Acer AN515-42
In-Reply-To: <CACRpkdaDT9xZe6r3pJvYqubrvHh4+PkV8D38yYMEbv8fhdHMKQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901081558460.10743@nanos.tec.linutronix.de>
References: <4085fc648ff5086bd6e6237d74d2a11e945a617b.camel@gmail.com> <CACRpkdaDT9xZe6r3pJvYqubrvHh4+PkV8D38yYMEbv8fhdHMKQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018, Linus Walleij wrote:

> On Fri, Dec 28, 2018 at 12:02 AM Leonard Crestez <cdleonard@gmail.com> wrote:
> 
> > Digging a little deeper it seems the touchpad interrupt is active on
> > boot and since it's configured as "level" and no touchpad driver is
> > available yet there does not seem to be any way to clear it.
> 
> I think these are called "spurious interrupts".
> 
> > I don't know how this should be handled, booting with an active enabled but
> > unclearable interrupt seems like a platform bug to me. There is even an
> > option to set touchpad to "basic" which does some sort of ps2 emulation
> > but the IRQ issue still happens!
> >
> > One workaround is to explicitly disable the interrupt from the handler
> > if no mapping is found; this will keep it disabled until
> > amd_gpio_irq_set_type is called later.
> 
> I don't know how x86 and ACPI systems usually deal with this stuff
> so I'm kind of lost. On the embedded systems that I develop on,
> I would just disable all interrupts on probe() (usually writing 0x0 in
> some interrupt enable register) and then they will get enabled
> once consumers need them.

That's the right thing to do.

> But I have come to understand that maybe ACPI systems are
> not so happy about drivers doing things like that?

Each driver has to invoke a request_irq() variant, which enables the
interrupt line. So there should be no problem when disabling all interrupts
on probe.

Thanks,

	tglx

