Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B15C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4FB213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4FB213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeHUKa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:30:59 -0400
Received: from foss.arm.com ([217.140.101.70]:45572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeHUKa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:30:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 197E3ED1;
        Tue, 21 Aug 2018 00:12:02 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE4173F2EA;
        Tue, 21 Aug 2018 00:11:59 -0700 (PDT)
Date:   Tue, 21 Aug 2018 08:11:55 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
Subject: Re: [PATCH RESEND v1 2/5] drivers: pinctrl: msm: enable PDC
 interrupt only during suspend
Message-ID: <20180821081155.1865db14@why.wild-wind.fr.eu.org>
In-Reply-To: <20180820154959.GS5081@codeaurora.org>
References: <20180817191026.32245-1-ilina@codeaurora.org>
        <20180817191026.32245-3-ilina@codeaurora.org>
        <86a7pjq0l1.wl-marc.zyngier@arm.com>
        <20180820152629.GR5081@codeaurora.org>
        <047d37fb-1011-0650-6517-e6052ba47a18@arm.com>
        <20180820154959.GS5081@codeaurora.org>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 09:49:59 -0600
Lina Iyer <ilina@codeaurora.org> wrote:

> On Mon, Aug 20 2018 at 09:34 -0600, Marc Zyngier wrote:
> >On 20/08/18 16:26, Lina Iyer wrote:  
> >> On Sat, Aug 18 2018 at 07:13 -0600, Marc Zyngier wrote:  
> >>> Hi Lina,
> >>>
> >>> On Fri, 17 Aug 2018 20:10:23 +0100,
> >>> Lina Iyer <ilina@codeaurora.org> wrote:  
> >
> >[...]
> >  
> >>>> @@ -920,6 +928,8 @@ static int msm_gpio_pdc_pin_request(struct irq_data *d)
> >>>>  	}
> >>>>
> >>>>  	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
> >>>> +	irq_set_handler_data(irq, d);
> >>>> +	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);  
> >>>
> >>> Could you explain what this is trying to do? I'm trying to understand
> >>> this code, but this function isn't in 4.18...
> >>>  
> >> Oh, I have been able to test only on 4.14 so far. The flag does seem to
> >> exist at least, I didn't get a compiler error.
> >>
> >> I read this in kernel/irq/chip.c -
> >>
> >> If the interrupt chip does not implement the irq_disable callback,
> >> a driver can disable the lazy approach for a particular irq line by
> >> calling 'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'. This can
> >> be used for devices which cannot disable the interrupt at the
> >> device level under certain circumstances and have to use
> >> disable_irq[_nosync] instead.
> >>
> >> And interpreted this as something that this would prevent 'relaxed'
> >> disable. I am enabling and disabling the IRQ in suspend path, that I
> >> thought this would help avoid issues caused by late disable. Am I
> >> mistaken?  
> >
> >Sorry, I wasn't clear enough. I'm talking about what you're trying to do
> >in this particular function (msm_gpio_pdc_pin_request), which doesn't
> >exist in 4.18. Short of having a bit of context, I can hardly review this.
> >  
> Sorry, my patch generation during the resend is messed up. Seems like I
> didn't send that patch out during the resend.

Please make sure you test with mainline. Basing your developments on
something as old as 4.14 makes no sense for something that targets
mainline. You should write your code on mainline, test it there, and
eventually backport it to whatever version you want to use.

Otherwise, we are guaranteed to merge something that will not work.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
