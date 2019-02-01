Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31F021726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4QsXFQ0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfBAQtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:49:36 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35952 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfBAQtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FrASSau5whcmJbSBX8zSNBpR4rwOiIXg5ImlLCH1zco=; b=4QsXFQ0vSLtveheNCUg17D+y/v
        bZNe/fPizU+0+8TtZUnAaRI3hrnslx55b0RCBM8RMCtzsbhTArxRUcB5uU6e7DfYvR7OXEHSZ3r3Q
        WdBzn72XvGhd+GLH5lOczwxFxrYVlMvD7Nv2v+1XZwTUzMMEjwHS340p09XdX44vGvwA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gpc0T-0001NP-Av; Fri, 01 Feb 2019 17:49:33 +0100
Date:   Fri, 1 Feb 2019 17:49:33 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v4] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190201164933.GH30115@lunn.ch>
References: <20190129204224.17951-1-andrew@lunn.ch>
 <20190201141540.GI783@dell>
 <20190201144410.GG30908@lunn.ch>
 <20190201150549.GA4973@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201150549.GA4973@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > For platform data, it should be "*_platform_data" or "*_pdata".
> > 
> > It would of been useful if you had said this in the first review,
> > rather than s/data/ddata/, which is rather ambiguous.
> 
> How is that ambiguous?  I guess it would be confusing if you didn't
> know the syntax, in which case you should have asked.
> 
> s/this/that/ simply means, replace 'this' with 'that'.

It is ambiguous if you mean just that one line, one variable, or the
whole file.

> For platform data, it should be "*_platform_data" or "*_pdata".

This is very unambiguous.

> > > > +static uint gpio_irq;
> > > > +module_param(gpio_irq, uint, 0);
> > > > +MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
> > > 
> > > What is the purpose of providing the IRQ number via a module param?
> > > 
> > > These seems like a very bad idea.
> > 
> > I explained this in my reply to your review comments for version 2.
> > 
> > > Can this driver be built-in?
> > 
> > Yes it can. But you can pass module parameters on the command line, so
> > that is not an issue. This is something i actually use.
> 
> What is connected to these IRQs?

MODULE_PARM_DESC says:

"GPIO IRQ number (7, 9, 12)"

One of the devices this MFD instantiates is a GPIO controller. Linus
Walleij accepted it a few days ago:

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=for-next&id=b868db94a6a704755a33a362cfcf4625abdda115

It can generate interrupts on its GPI's. Unfortunately, the interrupt
the GPIO device uses needs to be configured in the io_ext_int register
which is shared by all devices in the MFD, and it has to unique across
all devices in the MFD. So the module parameter is here, and it then
gets passed to the GPIO driver as a resource in the usual way.

     Andrew
