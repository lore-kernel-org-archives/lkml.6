Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C56C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63D92084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STI9eOLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63D92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJHOZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:25:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46932 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJHOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:25:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id a5-v6so7381794pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=AzE5QfCN8kCcvddF0vX9J6EZnmkXQZKv2EkDTgb3Kvc=;
        b=STI9eOLJW/p91mxfGlFnVH9rYb5l6RMaLvGMhP4AoKhj9SJJSlucyBQs4qqQd8/2HK
         oslQcivl6jKq07Z+dVNJ3BOCd2y2xSwuJidoJvXIo/71QIQOa5v6MOLlDM0eSwizvP7n
         VtiYG226f6lnFp791VxVMf9+0DnwvSPmVX2Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=AzE5QfCN8kCcvddF0vX9J6EZnmkXQZKv2EkDTgb3Kvc=;
        b=ZT12G49LoHfiK1FLGB9Dt3oKaRw35ndyUhEIy3x6AwzdX8w3ynJxcyK/dDLtcNf/Mx
         vPNh3NO63qyvEJt0WDg1rOs+Bhu1KP5tIvX6rfqlZrpMoAk3REFk8LuuFvqLGti9IhOa
         ESLP58olWciby7/C8QIjGO4Qvne/Ur48Sat4Tap72joFJkwRlbAUjTX40wXgS4kAoc85
         p0bDvuiueNCbIQY0n17dKvzc0eHOwuA/DaCcao8O7YB+0bHeMn2adP9W2KoiVzcYXELE
         MWNjHdwkgHTwE5MS/t16TuHnzCnvV0KsbojadOZPZqjWzJXazGo1gs+XXx0kPRZQz4fm
         K0OA==
X-Gm-Message-State: ABuFfoj8oTVHrcgy4u/w6tDrMYi2xTWI9Ap1/+8sS0U8mBUlZGMjF6EQ
        Tr4XjU50+KsNDk8nJzX9UekZ+g==
X-Google-Smtp-Source: ACcGV61mHaxXKHTkNeSSfShirhgDnii09TNJjL2oAN9icoU5oytSHGV43JZoG284F2IsrQ710+oibQ==
X-Received: by 2002:aa7:8191:: with SMTP id g17-v6mr23637304pfi.71.1538982895164;
        Mon, 08 Oct 2018 00:14:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id e22-v6sm18353353pfi.61.2018.10.08.00.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 00:14:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180925171605.GK17420@codeaurora.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <CACRpkdbLoz+gSFa292OFNszeS6tNywpBRHyGwL9SK2u5s=UhZw@mail.gmail.com>
 <20180925095723.GC7097@ulmo> <20180925171605.GK17420@codeaurora.org>
Message-ID: <153898289355.119890.15326986475278938009@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/9] Implement wake event support on Tegra186 and later
Date:   Mon, 08 Oct 2018 00:14:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-09-25 10:16:05)
> Thanks Linus, for bringing this to my attention.
> =

> Hi Thierry,
> =

> On Tue, Sep 25 2018 at 03:57 -0600, Thierry Reding wrote:
> >On Tue, Sep 25, 2018 at 10:48:39AM +0200, Linus Walleij wrote:
> >> Hi Thierry,
> >>
> >> thanks for working on the wakeup business!
> >>
> >> This patch gets me a bit confused on our different approaches
> >> toward wakeups in the kernel, so I included Lina, Marc and Ulf
> >> to see if we can get some common understanding.
> >>
> >> On Fri, Sep 21, 2018 at 12:25 PM Thierry Reding
> >> <thierry.reding@gmail.com> wrote:
> >>
> >> > The following is a set of patches that allow certain interrupts to be
> >> > used as wakeup sources on Tegra186 and later. To implement this, each
> >> > of the GPIO controllers' IRQ domain needs to become hierarchical, and
> >> > parented to the PMC domain. The PMC domain in turn implements a new
> >> > IRQ domain that is a child to the GIC IRQ domain.
> >> >
> >> > The above ensures that the interrupt chip implementation of the PMC =
is
> >> > called at the correct time. The ->irq_set_type() and ->irq_set_wake()
> >> > implementations program the PMC wake registers in a way to enable the
> >> > given interrupts as wakeup sources.
> >> >
> >> > This is based on a suggestion from Thomas Gleixner that resulted from
> >> > the following thread:
> >> >
> >> >         https://lkml.org/lkml/2018/9/13/1042
[...]
> >
> >Yes, there was some good discussion in that thread which helped me come
> >up with this solution. I think it's pretty elegant because it allows all
> >of this interaction to happen almost automatically via the existing
> >infrastructure. I'm not sure the same could be applied to the PDC,
> >though, because of the need to manually replay the interrupt. That's not
> >something I think can be done with just the simple parent/child
> >relationship that we use on Tegra.
> >
> I wasn't able to use the hierarchy because not all GPIOs and the summary
> line are routed to the PDC. But I am exploring options of hierarchy as
> well.
> =


From=20reading this thread (and https://lkml.org/lkml/2018/9/17/756) it
looks almost exactly the same. The only difference is that Nvidia Tegra
does the replay in hardware whereas Qualcomm SDM845 decided to replay
the irq in software. Either way, the gpio controller has two parent
domains, one is wakeup capable (PDC or PMC) and the other is not (GIC)
and some wakeup capable irqs only go through the PDC/PMC and then to the
GIC (e.g. RTC) instead of through gpio first. And it sounds like not all
gpios are wakeup capable in both designs.

The plan to have the gpio to wakeup capable irq map live in DT for the
PMC sounds good too. That way, the wakeup domain alloc function can
figure things out and redirect gpios by itself while the gpio controller
doesn't need to do anything special besides ask for wakeup to be set and
fail if the parent can't support it.

Can hierarchical irq domains entirely replace the chained irqchip code
in gpiolib? That would be interesting.

