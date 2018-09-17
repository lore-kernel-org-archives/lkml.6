Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A0BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988D92098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988D92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeIQSys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:54:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54967 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeIQSys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:54:48 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1tYi-0005nk-VD; Mon, 17 Sep 2018 15:27:25 +0200
Date:   Mon, 17 Sep 2018 15:27:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Multi-parent IRQ domains
In-Reply-To: <20180917130712.GC27927@ulmo>
Message-ID: <alpine.DEB.2.21.1809171510020.16580@nanos.tec.linutronix.de>
References: <20180913155945.GA19903@ulmo> <alpine.DEB.2.21.1809141211200.1473@nanos.tec.linutronix.de> <20180917095222.GA27927@ulmo> <alpine.DEB.2.21.1809171358070.16580@nanos.tec.linutronix.de> <20180917130712.GC27927@ulmo>
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

On Mon, 17 Sep 2018, Thierry Reding wrote:
> On Mon, Sep 17, 2018 at 02:28:01PM +0200, Thomas Gleixner wrote:
> > I'm not a DT wizerd, but the GPIO cannot be linked there I think.
> > 
> >     RTC ---------------------------> [ PMC domain 1] -----> GIC
> > 
> >     Button --> [GPIO domain] ------> [ PMC domain 2]
> > 
> > The RTC is connected to PMC domain 1 and that allocates the GIC irq.
> > 
> > The button is conntected to the GPIO which connect to the PMC domain
> > 2. That PMC domain has no connection to anything. It ends there.
> 
> Interesting, I was assuming the following:
> 
>     Button --> [PMC domain 2] --> [GPIO domain]
> 
> based on the hardware documentation that maps the wake events to
> specific signals on the chip.

That might be, but there is no reason why we can't interpret that
creatively :)

> > So, I don't know how GPIOs are mapped into the PMC when they are a wakeup
> > source. It might be all of them have the ability so there is some 1:1
> > relation ship or if the whole GPIO -> PMC connection can be built at run
> > time, but that's just an implementation detail.
> 
> There's a fixed mapping for which signals go to which wake event. Some
> of those events are mapped to GPIOs, others to different signals, such
> as the RTC alarm. I think I should be able to build a GPIO -> PMC map
> at runtime using a static table.

Ok, so for the RTC and the like (which are directly GIC backed) it's easy
as you just say: RTC interrupt = PMC irq #N.

And for GPIO you can just have the GPIO domains all parented by the PMC
domain 2 and then have the allocation function of the PMC domain do the
lookup of the GPIOs which actually have a PMC connection.

If it's there then you set the hwirq in the domains irq_data to the real
PMC hwirq number and for those which are not connected you set it to some
invalid value. In the set_type() callback you can then error out when it's
called for a GPIO which is not connected to the PMC by checking the hwirq
value.

That way the GPIO code does not have any requirement to know about the PMC
connections and only the PMC domain 2 needs to know. So if in the next chip
the GPIO/PMC association changes, you don't have to worry about it at the
GPIO (driver) level, you just hand a different GPIO/PMC map to the PMC
driver via DT.

Thanks,

	tglx
