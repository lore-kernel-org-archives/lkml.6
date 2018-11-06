Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0F52081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hS4nnWYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0F52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeKFOmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:42:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37485 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeKFOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:42:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id u13-v6so5547989pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=/FN32IfNBeBneuLrha/fvHTEJS+mA4DtCjM9Rraiubo=;
        b=hS4nnWYRCpkAh+zlyJIHmVYmMutzcN/M5KiMM35m4QArMqxm/CSoOVFeozZE+Nk8o0
         X0XX1aRHHBsbWyw1pc7lz0YDHG9963hXtqvyp7YbNjVaLihbYPqj7XN8jF0C9AaAtCRZ
         WhrZRQph1w/0ovMAFxxkv9UOfBaUwJ+GpHq2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=/FN32IfNBeBneuLrha/fvHTEJS+mA4DtCjM9Rraiubo=;
        b=kDSiPhr9Qtp9w7xZme1IJHhx0+/a3B3bq/e2PJecwEIzl2A31KTxhjtnAqdqZkSStB
         st2l6XoMEULBX4xHOZqxu0+blgXXjvW9ldwbMraLTgc4Jd0sWEssF6I45coNwPiRnZ8K
         S7HQYKdYwv19B0z1osHYLk22tPqjTWV1xMW4trzoW0seWPg5qzkste4OBoa1E0ML4aIJ
         /hSa0y31O9XM/SVNZ/0MsBiap0ibcWiYGt9OAZcLu1BO3GNFkQJv7nn7L5X07JjDocV/
         M1AngwB2GouxR6e4YIICOKAOxjbrGbxdK4SdtIlWyJ0lcT9iM450LvZw1ut/OZhdqukx
         9lvQ==
X-Gm-Message-State: AGRZ1gK3RiOm3ElwJbqZ+jtBjF+2ed7OuVnpj73vEIqXOo3yH6SULhMC
        3tNQ738dE9EEs3++R7f52c1AbQ==
X-Google-Smtp-Source: AJdET5cJSmtWnplreh3/kiLfIpaCO5+F+2YmGRSRLmASZvbomp/Dbi7UqcnN3/PN0HIdQ/LxdmcVqg==
X-Received: by 2002:a62:89d7:: with SMTP id n84-v6mr25167970pfk.255.1541481565666;
        Mon, 05 Nov 2018 21:19:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id r1-v6sm62020963pfb.41.2018.11.05.21.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 21:19:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181101171630.GM17444@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, evgreen@chromium.org,
        marc.zyngier@arm.com
References: <20181011002958.2597-1-ilina@codeaurora.org>
 <20181011002958.2597-2-ilina@codeaurora.org>
 <154096954339.98144.12348474096990107321@swboyd.mtv.corp.google.com>
 <20181031164650.GJ17444@codeaurora.org>
 <154103121313.98144.17090840121035743646@swboyd.mtv.corp.google.com>
 <20181101171630.GM17444@codeaurora.org>
Message-ID: <154148156278.88331.3764949163056562893@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RFC 1/1] drivers: pinctrl: qcom: add wakeup capability to GPIO
Date:   Mon, 05 Nov 2018 21:19:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-11-01 10:16:30)
> On Wed, Oct 31 2018 at 18:13 -0600, Stephen Boyd wrote:
> >
> >Right. Let's scrap the plan to do the wakeup based mask/unmask in both
> >chips. It won't work because of the edge trigger type.
> >
> >The difference I see is that this patch does the irq "forwarding" by
> >making the TLMM driver highly aware of the PDC irq domain. It explicitly
> >lists each PDC irq as interrupts in DT. Why are we doing that?
> The DT interrupts are a way of mapping the GPIO to their corresponding
> PDC lines.

Agreed. One problem I see with this approach is that PDC interrupts will
have stats and affinity associated with them and that won't be the same
as the real GPIO interrupt which will also have stats and affinity, etc.

> =

> >If we used hierarchical irq domains then only the PDC would be aware of
> >what irqs are wakeup capable, and TLMM would just need to be told to
> >mask or not mask the irq when an irq is monitored by the PDC (and maybe
> >not even that).
> >
> The reason, why I didn't use hierarchical irq domains is that not all
> GPIO interrupts are routed to the PDC and the summary line doesn't go
> into the PDC.

Ok. I don't see why we need to limit ourselves here. If a GPIO interrupt
isn't routed through PDC physically why does it matter? It shouldn't be
why we avoid hierarchical irq domains.

> =

> >This is also the only major difference I see between MPM and PDC based
> >designs. In the PDC case, we need to mask the irq in TLMM when PDC can
> >monitor it, while in the MPM case we want to keep it unmasked in TLMM
> >all the time and only have MPM configure the wakeup on irq_set_wake().
> >
> In MPM based solutions, there is a clear handover between when MPM takes
> over and when TLMM is responsible for the GPIO interrupt. It is not the
> case with PDC. The PDC is always on and monitoring. We dont know when
> the TLMM will be rendered incapable of sensing interrupt. To avoid
> sensing two interrupts you want only one of the two active. That is the
> tricky part, to know when to switch over.

Alright, well then we need to never switch over while the irq is
active/requested.

> =

> >In the end, supporting MPM is simpler because it sits in-between TLMM
> >and GIC, watches all TLMM irqs get allocated and hooks the irq_set_wake
> >calls for the ones that it cares to wakeup with and masks the non-wakeup
> >irqs during suspend, and then does edge trigger replays when the MPM
> >interrupt handler runs by poking the TLMM hardware directly. That poke
> >causes the summary irq line to go high and the GIC SPI line for TLMM
> >summary services the GPIO irq. We would leave the level type irqs alone
> >because hardware takes care of it all for us.
> >
> Yes, but more importantly, the remote processor knows when to switch
> over to MPM and knows if we are going to lose TLMM's interrupt sensing
> capability. With PDC there is no central entity to do that.

Ok.

> =

> >Can PDC be made to do the same thing as MPM? On resume we can replay any
> >pending irq that's edge triggered by replaying the edge into the TLMM.
> >That will cause the summary irq line at the GIC to go high and then the
> >chained irq handler will run as normal. As long as we don't need to
> >replay edges during deep idle states I think this can work, and given
> >that MPM isn't replaying edges during deep idle I suspect this is all
> >fine.
> >
> MPM replays the edges during deep idle. There is no difference between
> deep idle and suspend/resume. If the devices are not in use, we would go
> into a idle state that would disable the TLMM's interrupt controller and
> when we come out of idle, we will replay the wakeup interrupt in the MPM
> driver.

Ah ok, that sort of makes having PDC act like MPM not work because
replaying from deep idle isn't going to work. I was relying on cpu
suspend state where only one CPU is online and irqs are disabled to be
the time when irqs are replayed. It's probably slower that way too on
PDC because we have to bounce through the replay and have another
register write for each GPIO interrupt.

> =

> >Yes we have a GIC SPI line for each pin that PDC can monitor, but
> >that's largely an implementation detail here.
> >
> >It would be nice to make MPM and PDC the same, so that we don't need to
> >decide to mask or not mask in TLMM or move a GPIO irq out of the TLMM
> >summary GIC SPI to some other GIC SPI from PDC. Then supporting both
> >designs is nothing more than parenting the MPM or PDC to TLMM and having
> >those drivers poke the edges into the hardware on resume.
> >
> Agreed. That should the do-able.
> =


It doesn't seem like they can be exactly the same because of deep idle
wakeup, so I suggest we go back to the beginning:

 * Split PDC into two domains, one for GIC and one for TLMM and
   associate the TLMM one with an irq_domain_bus_token enum so
   that TLMM can look it up with irq_find_matching_host()

 * Set TLMM as the child of the PDC TLMM domain

 * Allocate irqs from TLMM and have those allocate in the parent domain
   if the TLMM is in a hierarchy domain with irq_domain_alloc_irqs()

 * When allocating an irq in TLMM's irqdomain::alloc function pass a
   TLMM specific struct to irq_domain_alloc_irqs_parent() last argument

   struct qcom_tlmm_fwspec {
      bool mask;
      struct irq_fwspec spec;
   };
   =

 * Have the PDC driver set the mask bit and the MPM driver not set the
   mask bit in the qcom_tlmm_fwspec above

 * Have the TLMM driver use the mask bit to figure out if it should mask
   or not mask the interrupt in the TLMM hardware

This way we can use the last argument to irq_domain_alloc_irqs_parent()
to communicate between the PDC/MPM drivers and the TLMM driver about how
the irq is being managed by the wakeup domain.

There will be some other functions to call for the hierarchy irq calls
in the TLMM code, specifically the set_type callback and the set_wake
callback need to call up to the parent irq domain so the MPM can trap
the set_wake calls to know what to monitor and the PDC can trigger
correctly. You can look at what Thierry has done for Tegra[1] and copy a
lot of that patch series.

The main difference is that on Tegra they have hardware replay the edge
vs. on qcom platforms we'll rely on the GIC SPI line for each PDC line
to go high and then have the hierarchy replay the interrupt. Also, on
Tegra they don't really care to allocate the irq in the GIC, whereas on
qcom we'll want to allocate the interrupt in the GIC to get the replay
to work. In the MPM design I think we'll need to use the
irq_set_irqchip_state() API too so the MPM driver can replay the edge
interrupts into the TLMM hardware when the MPM summary irq runs.

[1] https://lkml.org/lkml/2018/9/21/471

