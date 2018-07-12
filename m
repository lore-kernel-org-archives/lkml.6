Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8CBC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB6A208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M3GAyHYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB6A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeGLQlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:41:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45986 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbeGLQl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:41:29 -0400
Received: by mail-lf0-f67.google.com with SMTP id m13-v6so24757910lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uuNC52hLfp2hE8x//wzjD1ojc09zKUUXloOIRszoOn4=;
        b=M3GAyHYGtHClu/ZjET3RU4nOtaelQCrO7k4gMKHvMehTg3OOJiIPlmK7BDh29LDdwY
         f4SjqeqUuuwb8M2bAUM36S1AV4cLbjseI0TTuFQjcQaZpKjQCzQ3x7pV0dzqcXr9wXUi
         IauuXKKqm1jan/1/XI6b64uqz9Dy5729uH3QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuNC52hLfp2hE8x//wzjD1ojc09zKUUXloOIRszoOn4=;
        b=ICZL+aLTjjRSevw8ySdGjA/iXQwOHQ0y6gImHFfEwXvDNPtoxfwMjqPr6k8JAFeAE6
         jQppfCyXmJCX7TKWpyI+3aBc0sS9cPUazpbxbVv82m7Q2Y+cq3vlWgw2oWE2dWO0MDKU
         1JBfxQtLsNRSij35Z1pvM59rsmkEsfNZJ31Dk3lnEyxiXBMwRLhFgKNP2vK0PcxHF06S
         ySv6rD71KEFA6AJ5lQuUEFoJux0tFBisy5petp/UJvHNACrEiw/QS6iX0O0lwCfLNmLL
         huX0szGLQsfPr3hAokUQRDW54AFCANlHHxJqH2HI8Z3DPIYSM5aJa854L9663otBU+6R
         Ptyg==
X-Gm-Message-State: AOUpUlEWQm8Ul85pVu6tvBbqeTYhMZDkeySjtdYQBinsj/AmNpa/5ATC
        qfk0mclCMWYtrUb8IwN8gkZ6hJZFiS8=
X-Google-Smtp-Source: AAOMgpcvmfixF8O7bpG+k/pTXPGMdobm620BvO1Mx9Za4r7O23l8LIQkUoG1nf5ZQSK4afRSZ2RmiQ==
X-Received: by 2002:a19:1f4b:: with SMTP id f72-v6mr2337788lff.42.1531413071314;
        Thu, 12 Jul 2018 09:31:11 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q65-v6sm3866376lfb.80.2018.07.12.09.31.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 09:31:09 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id r13-v6so22433154ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:31:08 -0700 (PDT)
X-Received: by 2002:a2e:5519:: with SMTP id j25-v6mr1042788ljb.124.1531413068588;
 Thu, 12 Jul 2018 09:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180619234349.166190-1-evgreen@chromium.org> <20180709173022.GH2050@tuxbook-pro>
 <CAE=gft5+oOFv8y-XCtiQ8mc7gQ1FFSK0+bPk=mJu--ovLfDDJg@mail.gmail.com> <20180710203805.GA14825@codeaurora.org>
In-Reply-To: <20180710203805.GA14825@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 12 Jul 2018 09:30:30 -0700
X-Gmail-Original-Message-ID: <CAE=gft7RURCr0Lj8qO+i5EjwD25xkdqS+UB5RC_02-7FLdM1fg@mail.gmail.com>
Message-ID: <CAE=gft7RURCr0Lj8qO+i5EjwD25xkdqS+UB5RC_02-7FLdM1fg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: Pass along set_wake failures
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 1:38 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Tue, Jul 10 2018 at 12:53 -0600, Evan Green wrote:
> >On Mon, Jul 9, 2018 at 10:27 AM Bjorn Andersson
> ><bjorn.andersson@linaro.org> wrote:
> >>
> >> Sorry for not getting back to you in a timely manner Evan, I wanted to
> >> read up more on the details of how this is supposed to work. I still
> >> haven't done so, but here's my concern:
> >>
> >> When we power down the SoC we're no longer powering either the TLMM or
> >> the GIC, so the MPM or PDC is used to waking the system on some set of
> >> triggers. As such set_wake on an individual pin or irq should be routed
> >> to the MPM/PDC driver, which (in the PDC case) is implemented using
> >> hierarchical irq domains.
> >>
> >> As such I think that we shouldn't toggle the wake property of the
> >> summary pin at all; i.e. the patch should remove that call rather than
> >> propagating what I believe is a constant failure.
> >>
> >> Regards,
> >> Bjorn
> >
> >Hi Bjorn,
> >That's okay, I always feel bad pinging. Thanks for the thoughtful
> >response. Stephen and I are starting to think about how wake
> >interrupts should work with regard to the PDC, and we're at a place
> >where we're a bit unsure of the path forward.
> >
> >Our understanding is the downstream kernel had an interrupt hierarchy
> >of GIC > PDC > TLMM & everybody else. In the downstream world PDC
> >acted transparently, forwarding most requests directly onto the GIC,
> >but quietly handling wake interrupts as well. With the upstream PDC
> >driver, the #interrupt-cells got changed to 2, and it seemed like
> >folks didn't like the idea that PDC was acting transparently. Correct
> >me if I'm wrong there. So now we're sort of unsure about how to wire
> >in PDC. If we make everybody an interrupt child of PDC, then we lose
> >the ability to specify the third GIC parameter, and we're stuck
> >expressing interrupts with respect to PDC pins, which is an awkward
> >mental translation.
> Its an unfortunate side effect of the design. Drivers will have to
> request the PDC pin for wakeup IRQs.

Would they use the PDC pin to request their regular interrupt, and the
PDC would turn around and ask the GIC for them, and also enable the
wakeup interrupt? Or would devices have some sort of separate entry
for wakeup interrupts?

>
> >In this world, does TLMM need to do direct-connect
> >stuff to get wake-able GPIO interrupts working? It would kind of have
> >a foot in both worlds, with its summary interrupt as a GIC interrupt
> >but the wakeable ones as parented by PDC?
> >
> With GPIOs, I am trying to hack the TLMM driver to request a PDC pin,
> when the IRQ associated with the GPIO is requested as a wakeup
> interrupt. In that case, the TLMM driver would do the GPIO->PDC pin
> translation and request it. There is no hierarchy between TLMM and PDC.
>
> Will try a RFC patch in a week or two.

Thanks Lina. Looking forward to it. Please CC me.

>
> -- Lina
>
> >So anyway, with regard to this patch, I'm happy to create a second
> >spin that simply removes this function, but for me at least it brought
> >up some larger questions we've been wrestling with.

Bjorn, Linus,
If there's a spin of this you'd like to see, I'm happy to provide
that. If not, that's fine too.
-Evan
