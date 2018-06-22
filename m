Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DAAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64480246F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWQTxB+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64480246F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934133AbeFVRxu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:53:50 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38783 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933549AbeFVRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:53:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so3288188pgf.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5XoHa7CwdfTgCpV0hD+Ovs0JDGCUnmV2jOCTLkxwTjs=;
        b=CWQTxB+VpUGZ+4XFRwA6N5Y8F0ifDvcTPTky0SQ1cAHl422mVokjXTC0qPAGgeBCyT
         sT8D62tje0SMF9yLRnj2nrCHufj+QRYKbSkw6pOu8W3tWQ9p0fjo80M4V0CFTFpw6c4l
         HEid6CLarSeoK4mgywA+VI9Ylr9RKsIFX74Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5XoHa7CwdfTgCpV0hD+Ovs0JDGCUnmV2jOCTLkxwTjs=;
        b=O9LsFv4B6o8GVHB0kUL1ecbICbhbCrIihp7KXQ7MnQAI4edJpYFOPewDd1ByeDtORW
         P1/sQZNLQpmHGLbW8p4wKCURlhnL1myK0GdAR4eszu/wTtkWiXPn2fC64FBVnMBIo4G7
         kVE9r9ZaTNJXH4WXBO3HsZMv3UzxNZKRSk8js2tEGwFUR6B8YdWPYZ/JAF5evdzpCkhO
         5evVvyzrLPJQr9xm3Rr7LE8xr6OwiUfKVRFcJr56yNB/2xobYawdkivIdYRBUV+K+RYO
         fNDlFeFFkiITTVxUZtejb1JRTnNt8oZIlmtWvmjAk+a9ITU2Fns3vDKpjdqasqKpRmB9
         j9Bg==
X-Gm-Message-State: APt69E0Ntp9w5sxt3iByB+QITluIMJ+Gf26VGsvo8BxAfWYohABfKspL
        3lSkrrybhHr15UaDj0JyZvb73g==
X-Google-Smtp-Source: ADUXVKJREvm8nyrzf8HEgUsEEwTliHI4Znmk7wS9FcGlCKKmVKuDj8Yx8hpz3BfaMCqxbvMYnjDzlg==
X-Received: by 2002:a62:249b:: with SMTP id k27-v6mr2788281pfk.143.1529690027475;
        Fri, 22 Jun 2018 10:53:47 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c191-v6sm16042441pfg.48.2018.06.22.10.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:53:46 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:56:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] pinctrl: msm: Really mask level interrupts to
 prevent latching
Message-ID: <20180622175608.GB3402@tuxbook-pro>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-2-swboyd@chromium.org>
 <20180620064509.GL15126@tuxbook-pro>
 <152959405220.16708.279861218299564639@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152959405220.16708.279861218299564639@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Jun 08:14 PDT 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-06-19 23:45:09)
> > On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
> > > @@ -647,6 +660,10 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
> > >       raw_spin_lock_irqsave(&pctrl->lock, flags);
> > >  
> > >       val = readl(pctrl->regs + g->intr_cfg_reg);
> > > +     if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> > > +             val |= BIT(g->intr_raw_status_bit);
> > > +             writel(val, pctrl->regs + g->intr_cfg_reg);
> > > +     }
> > >       val |= BIT(g->intr_enable_bit);
> > >       writel(val, pctrl->regs + g->intr_cfg_reg);
> > 
> > I looked at the TLMM documentation, which states that the status bit
> > should be cleared after handling the interrupt and this driver used to
> > do this.
> 
> Nice!
> 
> > 
> > But Timur managed to hit the race where we lost edge triggered
> > interrupts with this behavior, so we changed it in the following commit:
> > 
> > a6566710adaa ("pinctrl: qcom: Don't clear status bit on irq_unmask")
> > 
> > 
> > But the reason that I had this in the driver originally is that msm-3.10
> > does this (clear status bit in unmask), so perhaps the appropriate way
> > to solve is to follow the documentation and the downstream driver and
> > ack the interrupt in unmask - but do so only for level triggered
> > interrupts?
> > 
> 
> Clearing the status bit (basically acking the gpio irq) can be done in
> unmask for level triggered interrupts. That works and as you say it's
> even documented.
> 
> I didn't implement that because it felt better to prevent the status
> from latching in the hardware while the interrupt is masked. My
> understanding of irq mask semantics is that the interrupt shouldn't be
> "pending" during the time between mask and unmask and clearing the raw
> status allows us to do that properly without messing with the status bit
> on the unmask path. It also means that the ack operation really does ack
> the irq status bit and cause it to go away. I suppose there is one case
> where I'm wrong though, and that is when the irq is unmasked on irq
> startup where we don't want to see a spurious latched level interrupt
> that occurred before we booted.
> 

I took another pass through the irq code and I agree, while the late ack
does solve the problem it's more intuitive if we can prevent the
latching.

> That problem may be possible with bad bootloaders that are leaving some
> status bit latched in there, but also we would want to fix that for edge
> type interrupts too, so we would need to clear the status bit regardless
> of the level on irq startup and hope an edge isn't lost on startup.
> 

I would prefer that we handle that case explicitly.


There are some concerns from msm-3.10 regarding writing the intr-raw bit
at the same time as the other bits, but I think that relates to the fact
that the downstream driver used to configure and enabled raw-state in
the same write. So please respin v2 as you planned.

Regards,
Bjorn
