Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A45C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E286820880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iF6EfBvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E286820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbeH1EPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:15:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37849 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeH1EPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:15:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8-v6so351669pgs.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 17:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x+aFdiZCksyR8w1l8vEl5uC9GewOOkm4Alj262Bn08Q=;
        b=iF6EfBvWW9TyA1VZH3tI3HLs0XlEEw3Cd1ynL/QJyAjQQBuPLvYPhoyinjDcl1qeDr
         nQvTk3nHXH7SeYjCo8elfCvtoRFbwFsASBl92AXG/1ntdM4SeeGAvS6k+zbnZq3hcV7X
         ukvaj2uvHuCpWLN4TkAk/0R1odHWWPx3rO7go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+aFdiZCksyR8w1l8vEl5uC9GewOOkm4Alj262Bn08Q=;
        b=eKAq/TF1lHkZf4toCcG5rZO+Gg4tJdz4FOV7jwHfuNv5dfNZtUH5KAAI5yh7bQNyPo
         2wWGME04UI0jNuFr8iRps51wK13QdLFYOD4sNFQzijrJdBvef1aeJjiJDDP4Ims3qRM4
         R4dah6pKWVXslZ0KPfOPl3FgbguzUaHmjXJvMWRU2JCy9tf2B86eMJSDD2rXXwgzCdZp
         Qvx8tzQBsGxJlYqyi31hKUKdfGsOfJHOvvxKqrViDI1Vg0h0DSjsxXAqjS+U1TE8NEB9
         wO5522V9YMIqdkMwXQcTwxJP9Q27sjYTN4o12VgYe+4PZeR23JcUPDfUSgS1w/8JgdNk
         japg==
X-Gm-Message-State: APzg51BMj/z2Fz0J+/GUUgpr/OcJ3uJGUboVEdYE6QNhAGlLlzweZWDJ
        gweMTe2HAuf5Pv8ZXQANmhswQQ==
X-Google-Smtp-Source: ANB0VdYC8nSyyWWP69f5eWezOdI9cJTlL2ZZusc5d3/PudwLZUE7456WvzpmwByq1Lx4z9WR842Ifg==
X-Received: by 2002:a62:c218:: with SMTP id l24-v6mr16549727pfg.185.1535416004795;
        Mon, 27 Aug 2018 17:26:44 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h12-v6sm508883pfo.135.2018.08.27.17.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 17:26:43 -0700 (PDT)
Date:   Mon, 27 Aug 2018 17:26:41 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, evgreen@chromium.org,
        rplsssn@codeaurora.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/5] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20180828002641.GC2523@minitux>
References: <20180817163849.30750-1-ilina@codeaurora.org>
 <20180817163849.30750-2-ilina@codeaurora.org>
 <CACRpkdb+Opdn1eWZSRydS1Bafpqwcg83xEcT-YJC6D-kSSi1ew@mail.gmail.com>
 <20180827165644.GR5081@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827165644.GR5081@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27 Aug 09:56 PDT 2018, Lina Iyer wrote:

> On Sun, Aug 26 2018 at 08:33 -0600, Linus Walleij wrote:
> > On Fri, Aug 17, 2018 at 6:39 PM Lina Iyer <ilina@codeaurora.org> wrote:
> > 
> > > QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
> > > domain can wakeup the SoC, when interrupts and GPIOs are routed to the
> > > its interrupt controller. Only select GPIOs that are deemed wakeup
> > > capable are routed to specific PDC pins. During low power state, the
> > > pinmux interrupt controller may be non-functional but the PDC would be.
> > > The PDC can detect the wakeup GPIO is triggered and bring the TLMM to an
> > > operational state.
> > > 
> > > Interrupts that are level triggered will be detected at the TLMM when
> > > the controller becomes operational. Edge interrupts however need to be
> > > replayed again.
> > > 
> > > Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
> > > but keep it disabled. During suspend, we can enable the PDC IRQ instead
> > > of the GPIO IRQ, which may or not be detected.
> > > 
> > > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > > ---
> > > Changes in v1:
> > >         - Trigger GPIO in h/w from PDC IRQ handler
> > >         - Avoid big tables for GPIO-PDC map, pick from DT instead
> > >         - Use handler_data
> > 
> > Just for the record this is an impressive and much needed patch
> > set, no other SoC developer has yet taken on the task of making this
> > work so I very much appreciate that Qualcomm show the way.
> > 
> > > +static int msm_gpio_pdc_pin_request(struct irq_data *d)
> > > +static int msm_gpio_pdc_pin_release(struct irq_data *d)
> > > +static int msm_gpio_irq_reqres(struct irq_data *d)
> > > +{
> > (...)
> > > +       if (gpiochip_lock_as_irq(gc, irqd_to_hwirq(d))) {
> > (...)
> > > +static void msm_gpio_irq_relres(struct irq_data *d)
> > > +{
> > > +       gpiochip_unlock_as_irq(gc, irqd_to_hwirq(d));
> > > +}
> > 
> > FYI Hans Verkuil is working on a patch set that moves the
> > lock/unlock as IRQ call to the irqchip request() and release()
> > functions so we can switch a GPIO irqchip line from IRQ
> > mode to say output at runtime without too much trouble.
> > (CEC needs this.)
> > 
> Thanks, I will look into Hans's RFCv2. But what would help me would be
> to avoid creating the IRQ for the GPIO itself (I have the latent IRQ),
> if I could just return that instead in gpio_to_irq(), it might be
> easier. I understand ->to_irq() is supposed to be a translate function
> only, I can avoid the dance of enabling and diabling the PDC IRQ on
> suspend and resume.
> 

I did implement gpio_to_irq() like this in the PMIC gpio/mpp drivers and
we've since concluded that we need to move this to some hierarchical
interrupt controller, because people like Linus expect to be able to say

  interrupts = <&gpio_controller 1 IRQ_TYPE_EDGE_RISING> 

which is something used all over the place with the TLMM driver today.

Regards,
Bjorn
