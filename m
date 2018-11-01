Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41882ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11FD20664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gwDk/IpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11FD20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeKAJOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:14:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45308 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:14:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id s3-v6so8134778pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=WoxJcE5euy/BEp6dcM4CO82IMHqtkWgaz67wmj1xeLQ=;
        b=gwDk/IpNHuMZ0fsqhZlTb/T0+Ec6RIGaX5EQG35OMKOSv1N+APOHresCOZDsJl+VO0
         AasgM2tg2/EIBjxU+ESZkyGLIFTm+tidLXJEGF9YXl0KjhkBv9kNLAOvHbuzxEo7iUgP
         uxmvS2CFPMbe6GISL8NVJjMUM9Wtt2pZm3T7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=WoxJcE5euy/BEp6dcM4CO82IMHqtkWgaz67wmj1xeLQ=;
        b=BcyZ27LERz5dGwt6/YafgLflC/hw7cYOYnaOn2Sg7jDr5GY3nRaiwaopBXHL1n6rhK
         ZHdgsQuBI3wviUw0bpjZxm1qX08eP4/ocwt9wSWSLN4/5pBxuxkrW8lr1J1Mp3MQiFIc
         muR/JdY90gnTtGqRFtzkVfT5IavJJjg5JlDRklMZOxup4IgtWFb0arUMLZvKoRc+SJ/e
         k98Jsx9BcumDMKds1r1GG/dC7b4gIVQr4X3zV0syHlmpxpWoeIoTrQkmi+KDEP2rQHE9
         uHIyegROx7ukiHLI77ZRGTGsOISrEWroILcLoh1OXpokVXB6bafOPowUo7YO0dBTYh+a
         kLfA==
X-Gm-Message-State: AGRZ1gK5XpNzrxow5WIu4nG0Zgr8YxZ1hqOv6WXYJ1pFJ5f55zwYnLEW
        6Nkte+ezcB/aT0IsSwniYS2oK5Tkd9U=
X-Google-Smtp-Source: AJdET5cdtDywClDFWEvRHL02wbL1Wd+/1cuG0jqCHqXABHwpyZBnXDlDdwR5eT/wE1xRYFCSLRdVHg==
X-Received: by 2002:a63:4c4e:: with SMTP id m14-v6mr5115206pgl.173.1541031214884;
        Wed, 31 Oct 2018 17:13:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id z9-v6sm1640975pfg.174.2018.10.31.17.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 17:13:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181031164650.GJ17444@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, evgreen@chromium.org,
        marc.zyngier@arm.com
References: <20181011002958.2597-1-ilina@codeaurora.org>
 <20181011002958.2597-2-ilina@codeaurora.org>
 <154096954339.98144.12348474096990107321@swboyd.mtv.corp.google.com>
 <20181031164650.GJ17444@codeaurora.org>
Message-ID: <154103121313.98144.17090840121035743646@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RFC 1/1] drivers: pinctrl: qcom: add wakeup capability to GPIO
Date:   Wed, 31 Oct 2018 17:13:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-10-31 09:46:50)
> On Wed, Oct 31 2018 at 01:05 -0600, Stephen Boyd wrote:
> >Hi Lina,
> >
> >Quoting Lina Iyer (2018-10-10 17:29:58)
> >> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-=
on
> >> domain can wakeup the SoC, when interrupts and GPIOs are routed to its
> >> interrupt controller. Only select GPIOs that are deemed wakeup capable
> >> are routed to specific PDC pins. During low power state, the pinmux
> >> interrupt controller may be non-functional but the PDC would be. The P=
DC
> >> can detect the wakeup GPIO is triggered and bring the TLMM to an
> >> operational state.
> >>
> >> Interrupts that are level triggered will be detected at the TLMM when
> >> the controller becomes operational. Edge interrupts however need to be
> >> replayed again.
> >>
> >> Request the corresponding PDC IRQ, when the GPIO is requested as an IR=
Q,
> >> but keep it disabled. During suspend, we can enable the PDC IRQ instead
> >> of the GPIO IRQ, which may or not be detected.
> >>
> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> ---
> >
> >I spoke with Marc about this at ELCE last week and I think we came up
> >with a plan for how to make this all work while keeping the TLMM driver
> >largely unaware of what's happening. One important point that we need to
> >keep in mind is that we don't want the interrupt to appear twice at the
> >GIC for the same TLMM irq, once in TLMM and once in PDC. That situation
> >would be quite bad and confuse things.
> >
> >So the plan is as follows:
> >
> > 1) Split PDC irqdomain into two domains. One for GIC interrupts and one
> >    for TLMM interrupts
> >
> > 2) Support hierarchical irq domains in the TLMM driver and/or gpiolib
> >
> > 3) Stack the irq controllers into a hierarchy so that GIC is the parent
> >    of PDC and PDC is the parent of TLMM while also leaving the TLMM
> >    summary IRQ chained directly from the GIC irqdomain
> >
> > 4) Mask a TLMM irq in the TLMM driver and unmask the PDC irq in the PDC
> >    driver when an irq_set_wake() call is made on a TLMM gpio irq that
> >    PDC can monitor (and vice versa)
> >
> > 5) Have the PDC driver be the only driver that knows if a TLMM pin is
> >    wakeup capable or not expressed in some DT table
> >
> >Implementing #4 will require changing TLMM irqchip to call
> >irq_chip_set_wake_parent() for the .irq_set_wake op and then checking
> >the return value to figure out if PDC is monitoring the pin or not and
> >doing the mask/unmask dance. Furthermore, implementing #2 will be a bit
> >of work that Thierry has already started for Nvidia Tegra pinctrl
> >drivers.
> >
> We have been doing something similar downstream. But it has been quite
> lot of code. The approach was to treat PDC-GPIO as a separate as
> interrupt controller whose parent is the PDC. GPIOs that have PDC lines,
> will be handled by the PDC-GPIO, while other GPIOs will continue to use
> summary line. The hierarchy helps with the masking/unmasking and
> prevents PDC interrupt from being detected as a separate interrupt than
> the TLMM.
> =

> >The important part of #4 is that the irq can only happen in TLMM or in
> >PDC, and not in both places because of how we mask and unmask in
> >different drivers. The TLMM summary irq line can't be triggered when the
> >PDC is monitoring the line.
> >
> >This also limits the usage of PDC to pins that are really waking up the
> >system from some sort of sleep mode. Either the device driver is trying
> >to wakeup from suspend so it's setting irq wake in the driver suspend
> >path, or it's runtime suspending a device and wanting to wakeup from
> >that device suspend state so it's again setting irq wake in runtime
> >suspend. Either way, in "normal" active modes the irq path will be
> >through the TLMM summary irq line and not through PDC. I don't know if
> >a similar design would work for pre-PDC qcom hardware where the MPM is
> >handled by RPM software.
> >
> Yes, we need a solution that works with both. But we can be assured that
> the architecture will have either MPM or PDC, never both. The PDC is a
> parallel line that is always active, while the MPM line is enabled only
> when the SoC is in sleep mode.
> =

> >And finally, thinking about this after writing this mail I'm a little
> >concerned that doing any sort of mask/unmask or irq movement from TLMM
> >to PDC at runtime will miss edges for edge triggered interrupts. Is that
> >also your concern? How is this handled with MPM? We would leave the TLMM
> >interrupt enabled in that case and then have to replay the edge in
> >software when resuming from suspend or idle paths but otherwise ignore
> >the level type interrupts that MPM sees? I suppose MPM never gets an
> >edge if TLMM gets the edge so this just works.
> >
> This is partly correct. Let me explain the key differences between the
> current and the previous generation of the hardware to help with that.
> (Let's call them PDC-based and MPM-based architectures respectively).
> =

> In MPM-based solution, the TLMM is active and is solely responsible for
> notifying the CPU of the GPIOs until powered off (as part of
> idle/suspend). At which point, the always-on MPM is configured for
> wakeup from the GPIO. Upon sensing a signal will wake up the application
> CPU using a separate MPM interrupt. The TLMM is powered on at the same
> time. The CPU is interrupted by the MPM and if the GPIO was a level
> interrupt the TLMM summary line will handle the GPIO. If the GPIO was an
> edge interrupt the Linux MPM driver will replay the interrupt at TLMM.
> Note that the MPM is not active after sending the interrupt to wakeup
> the CPU.
> =

> With PDC-based solutions, the PDC is always active and can be used to
> detect the interrupt even when the TLMM is active. But it could be a
> problem if both the interrupt lines are configured. If we could use the
> PDC interrupt line always for such GPIOs, it will solve the problem.
> This patch does just that.

Right. Let's scrap the plan to do the wakeup based mask/unmask in both
chips. It won't work because of the edge trigger type.

The difference I see is that this patch does the irq "forwarding" by
making the TLMM driver highly aware of the PDC irq domain. It explicitly
lists each PDC irq as interrupts in DT. Why are we doing that? If we
used hierarchical irq domains then only the PDC would be aware of what
irqs are wakeup capable, and TLMM would just need to be told to mask or
not mask the irq when an irq is monitored by the PDC (and maybe not even
that).

This is also the only major difference I see between MPM and PDC based
designs. In the PDC case, we need to mask the irq in TLMM when PDC can
monitor it, while in the MPM case we want to keep it unmasked in TLMM
all the time and only have MPM configure the wakeup on irq_set_wake().
In the end, supporting MPM is simpler because it sits in-between TLMM
and GIC, watches all TLMM irqs get allocated and hooks the irq_set_wake
calls for the ones that it cares to wakeup with and masks the non-wakeup
irqs during suspend, and then does edge trigger replays when the MPM
interrupt handler runs by poking the TLMM hardware directly. That poke
causes the summary irq line to go high and the GIC SPI line for TLMM
summary services the GPIO irq. We would leave the level type irqs alone
because hardware takes care of it all for us.

Can PDC be made to do the same thing as MPM? On resume we can replay any
pending irq that's edge triggered by replaying the edge into the TLMM.
That will cause the summary irq line at the GIC to go high and then the
chained irq handler will run as normal. As long as we don't need to
replay edges during deep idle states I think this can work, and given
that MPM isn't replaying edges during deep idle I suspect this is all
fine. Yes we have a GIC SPI line for each pin that PDC can monitor, but
that's largely an implementation detail here.

It would be nice to make MPM and PDC the same, so that we don't need to
decide to mask or not mask in TLMM or move a GPIO irq out of the TLMM
summary GIC SPI to some other GIC SPI from PDC. Then supporting both
designs is nothing more than parenting the MPM or PDC to TLMM and having
those drivers poke the edges into the hardware on resume.

> =

> By using the PDC line for the PDC-based architectures, we will not
> intersect the MPM-based architectures and they both can continue to use
> the same driver. Only in the PDC-based architecture we will find a map
> of the PDC interrupts in DT for the corresponding GPIOs. If the map is
> missing or the PDC is not available, it will not be a error.
> =


Well given that we don't have any MPM based solutions upstream I'm not
sure how well we can make sure both designs work together, but yes, we
should strive to do this in case MPM solutions get upstreamed.

