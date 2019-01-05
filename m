Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E8C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7662218EA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Vl1ZsChj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfAEBpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 20:45:06 -0500
Received: from onstation.org ([52.200.56.107]:41706 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAEBpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 20:45:05 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 0DB48152;
        Sat,  5 Jan 2019 01:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546652704;
        bh=4Xtsesp5l6kcT3qPr6yojfUAhvIkHBr1Luh7aTZxYl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vl1ZsChjYXE/QYkUcDwDopOghcicgiQJZDiNYcVUm62lH5iOfy4KlLfnOCfaGJSBe
         XXTTta4PIiU6BzaFnx8vyQRI/Rhyhx4mXqxbdUDCv/0440AErgJ7MgikOybNKWNTQ9
         n7dcL7Ur3JYjYKDc7s8YMXvrTbh9t54OdDnR4suQ=
Date:   Fri, 4 Jan 2019 20:45:03 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] spmi: pmic-arb: convert to v2 irq interfaces to
 support hierarchical IRQ chips
Message-ID: <20190105014503.GA32383@basecamp>
References: <20181229114755.8711-1-masneyb@onstation.org>
 <20181229114755.8711-2-masneyb@onstation.org>
 <154664792383.15366.9346249356552958882@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154664792383.15366.9346249356552958882@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 04:25:23PM -0800, Stephen Boyd wrote:
> > +       /*
> > +        * Check to see if the hwirq is already associated with another virq on
> > +        * this IRQ domain. If so, then disassociate it before associating the
> > +        * hwirq with the new virq. IRQs are all initially setup without an IRQ
> > +        * hierarchy when this driver is probed and when mfd/qcom-spmi-pmic.c is
> > +        * probed. Later in the boot process, an IRQ hierarchy is requested by
> > +        * pinctrl-spmi-gpio.c, and the same hwirq is now associated with a new
> > +        * virq.
> 
> Is that because we count the irqs in the pmic gpio driver?

Yes.

The call to devm_of_platform_populate() in drivers/mfd/qcom-spmi-pmic.c
also triggers this condition. I'll experiment with this some more this
weekend.

> Otherwise patch looks good to me. Thanks for working on this. Are you
> going to convert the ssbi master and gpio chip too?

Yes, I will do that work as well once this patch series is accepted.
I currently don't have the hardware to test it, but I'm willing to pick
up a cheap device on ebay. Any suggestions for something that boots a
mainline kernel with the ssbi? It looks like the Sony Xperia Z phone is
one of the supported devices.

Thanks for your review on the other patches. It all makes sense.

Brian
