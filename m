Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C634C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B058120850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B058120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeLEIW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:22:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42432 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeLEIW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:22:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so17473346lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 00:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BauKcVkOkrXCO3T15qQrevS+Ue8tEqZQXwwA3dKlOw8=;
        b=AZNB2WabmqYU25U7/eqe9oqpIJZBFC92m0Ps4Fdd7MoYFvk7B6uhIqJGYSRZ2lj/TD
         RBr21Hn6QJWCaLJq+iyVpanjHcW78DIEDEHsFp2QE/Akh5jpat4T6APsLNnSrICBecly
         4LfEvT+SMZORFXjlMF0xxmen3iahvwtwKnZSOOTvYSCMVi30bVxdr73PsJFN7yVHX781
         5moWM9old8EVo26dqaLqocVKTDbVDbSls1pU7Yp8fOy8Jly6Wu7UMw0cqPh6sALE7wEc
         p+xfKmdAtM0Ul+dF7zL9IaLuAq34sVBu4TCDUbMEVpad8Gkh2az5UvS1mfcgrhrIKOeZ
         Q/5g==
X-Gm-Message-State: AA+aEWZ2uSKW5LX9HjG3+CDKrR53kJG/fkYSK5/2f6/v5YR4dBX+NN2X
        QWQUd2Amsgy5whW0a37QfnVoZl1w
X-Google-Smtp-Source: AFSGD/UhMVofAdP4ynZf1YgoX7lVacj6KPFxeElps7icfYsOB7jtpBuTxDp3CGmVI/lqRmQ9xhFCRQ==
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr16233902lji.133.1543998174016;
        Wed, 05 Dec 2018 00:22:54 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o72sm3515383lfg.33.2018.12.05.00.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 00:22:53 -0800 (PST)
Date:   Wed, 5 Dec 2018 10:22:51 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap-irq: add "main register" and level-irq support
Message-ID: <20181205082251.GE31204@localhost.localdomain>
References: <20181130085908.GA24983@localhost.localdomain>
 <20181204172137.GE6809@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204172137.GE6809@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thank you for taking the time and checking this! Highly appreciated!

On Tue, Dec 04, 2018 at 05:21:37PM +0000, Mark Brown wrote:
> On Fri, Nov 30, 2018 at 10:59:08AM +0200, Matti Vaittinen wrote:
> 
> > IRQ handling is implemented so that each sub block has own
> > status/ack/mask registers and then there is one main status
> > register. When any of the sub blocks gets unmasked IRQ,
> > corresponding 'main status register' bit is set in main status
> > register.
> 
> This sounds exactly like the wm831x which uses cascaded irqchips for
> this, though not regmap-irq.

Yep. I guess I could do cascaded chips - but I would like to use the
regmap-irq for this driver. Maybe we could change regmap-irq so that it
would be possible to not give the DT node from regmap for this chip?
This was actually my first thought - but then I felt that having two irq
chips for one device is a bit hacky - and hence I decided to see how
regmap-irq could be changed to support the 'main irq status' register
usage. I think this 'main register' setup is pretty common design.

> > Problem I faced is that I don't know how to create two regmap-irq chips for
> > the same i2c decvice - because the regmap-irq gets the DT node from regmnap
> > - and thus both of the irq chips would have same DT node. My assumption is
> > that the DT - xlate functionality for this setup would not be quite correct,
> > right? I guess the "main irq" interrupts would be hookable via DT? But
> > the devices are interested in "sub IRQs". So I thought that the correct
> > solution would be to model the interrupts from this PMIC as just one
> > irq-chip. So I wonder if addin this "main IRQ register" support for
> 
> I suspect the idiomatic way to handle this in DT is to make DT nodes
> (and devices) for the subfunction interrupt controllers and expose the
> internal structure of the chip to the DT.

Yes. This would be one approach - but I am not sure how DT guys see
this. I may be wrong but I have a feeling Rob prefers having only one DT
node describing single device. But for me it would make sense to have
own node for GPIO - especially because the GPIO is only IRQ controller
which really is visible outside the chip. But here we still hit the same
problem if we want to use regmap-irq. Regmap-irq still knows only the
i2c device DT node. Currently there is no way to tell regmap-irq to use
the sub-node.

>  This does make some sense as
> the individual interrupt controllers within the chip are clearly
> reusable IP blocks though it means that the chip starts looking a bit
> weird externally so perhaps that's not ideal and your suggestion makes
> sense.

So I take this as a suggestion to continue tinkering with the 'main irq
register support'. Or how do you see my suggestion of making iot
possible to instruct the regmap-irq to not use DT for 'main irq
controller'? Then we could probably do cascaded controllers where only
the controller handling the externally visible 'sub-irqs' would be
bound to DT? The pitfall here is case where more than one sub-irq
controllers needs to be exposed to other devices. In that sense the
'main irq thing' would have better 'case coverage' =) (Wow, what a fancy
words, maybe I am turning into a manager here :p )

> > configuring IRQ pins as level triggered. So I thought we could add
> > support for setting the type to level_low or level_high. This change
> > would require adding 'supported_types' information to all drivers which
> > are currently using regmap-irq for supporting type-setting - but quick
> > grep for drivers allow me to think that it is currently only the 
> > gpio-max77620 which uses the type setting in-tree.
> 
> That seems pluasible but definitely seems like a separate change.

All right. I will create a separate patch (set) out of this.

> 
> > + * @main_status: Base main status register address. For chips which have
> > + *		 interrupts arranged in separate sub-irq blocks with own IRQ
> > + *		 registers and which have a main IRQ registers indicating
> > + *		 sub-irq blocks with unhandled interrupts. For such chips fill
> > + *		 sub-irq register information in status_base, mask_base and
> > + *		 ack_base.
> > + * @sub_reg_offsets: arrays of mappings from main register bits to sub irq
> > + *		 registers. First item in array describes the registers
> > + *		 for first main status bit. Second array for second bit etc.
> > + *		 Offset is given as sub register status offset to status_base.
> > + *		 Should contain num_regs arrays. Can be provided for chips with
> > + *		 more complex mapping than 1.st bit to 1.st sub-reg, 2.nd bit to
> > + *		 2.nd sub-reg, ...
> 
> This interface feels a little awkward in that we define the sub
> interrupts in this separate array and require them all to be in separate
> single registers which probably won't be true in general (IIRC it wasn't
> how the wm831x worked).

So my implementation here was just the simplest solution to 'glue' the
main status register on top of existing implementation. If we do it this
way, then the 'main status register' is completely optional - chip would
work just fine even without the 'main register' - main register only
saves some reads as subregisters with no irqs can be left unread. But
you are correct - this only supports limited amount of HWs. Many chips I
have seen (prior to the one I am now working with) actually require
acking also the main status register. They also may support masking the
main status register. But I guess trying to support all such cases would
make the regmap-irq really complex and hard to understand.

> How about instead we have the individual
> interrupts mark which main status bits flag them, then build up a
> mapping in the other direction during init of subregisters to read?

I am not sure if I understand your idea correctly - but for me it feels
that the 'main status register' is only benefical when we can do direct
mapping from main register bit/value to sub-register(s). 

But as we must really read whole sub register at once, it really does
not matter which interrupts inside the sub register did activate the
main status - we go through all bits in the sub register anyways. Hence
it may not be needed to have mapping from individual interrupts to the
main status register value? I guess looping through all the sub
register bits is negligible source of latency compared to the time the
register access takes. So identifying the sub register(s) based on main
status is the thing - not mapping the individual interrupts in sub
register(s), right? I think that having to specify the main status
register value for each interrupt would be quite a overkill.

So what do you think, would changing the
> > + * @sub_reg_offsets: arrays of mappings from main register bits to sub irq
> > + *		 registers. First item in array describes the registers
> > + *		 for first main status bit. Second array for second bit etc.
> > + *		 Offset is given as sub register status offset to status_base.
> > + *		 Should contain num_regs arrays. Can be provided for chips with
> > + *		 more complex mapping than 1.st bit to 1.st sub-reg, 2.nd bit to
> > + *		 2.nd sub-reg, ...
to

@sub_reg_offsets: arrays of mappings from main register _value_ to to
		  sub irq registers ...

be the (simplest) way to go? And maybe changing the description for
main_status to:

 * @main_status: Optional base main status register address. Some chips have
 *		 "main status register(s)" which indicate actual irq registers
 *		 with unhandled interrupts. Provide main status register
 *		 address here to avoid reading irq registers with no
 *		 active interrupts. Mapping from main status value to
 *		 interrupt register can be provided in sub_reg_offsets.

Perhaps this would clarify that the status_base, mask_base, ack_base,
etc. should still be used normally?

Best Regards
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
