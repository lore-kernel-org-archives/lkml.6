Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C43ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BDF20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dG90j/k5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BDF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJZPxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:53:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43512 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJZPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:53:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id t10-v6so177060wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FUJrcpHpUpZEIpEc+xq9EoWGLTV8G0GCGqJDgZz0kjw=;
        b=dG90j/k5avtbXiw8QYS5oRaQcbj2JeRl5WS/hDErkdo5rEJsCUp4TC5tFu6v33CZ7j
         HWXWNTNdxjgb8sq3d5r7t1+hN1sJQlO87JOaz+bTDI0ZglNDSHrMG+9R6hdmcU3W8Gt4
         q4dxOKiuslRy9+kXhJBlWReQPkelgglluDzkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FUJrcpHpUpZEIpEc+xq9EoWGLTV8G0GCGqJDgZz0kjw=;
        b=UsSWxhtegkCcbGgt2Lkz2DOjSyQRVVUg5Rrsr1VATH4M8ubwru+06pEKq4eKggtkUZ
         wC16QYBfYzcqCDOYKlrbzpQPZUvcuzUuc4to7q1VB5pBxYNtGIQ+2kqV5mIjammIvHJn
         2fl+P3/YTMQ4swPFl/jGReNld/cmBLT0wB8PO/RC7xbtuyGg3ifO1hS2zJWe3+/VJFT9
         ZjU2H1RTDzishUtxrzUU6b3SVgygo12tXsOkQoZBSAyPUu+dxE9hTm003KYI5gmgmQRV
         wWzkPP1aQbDfqKmrpnD3rY3TITV8+svyKQDdSPQfJmooiAax9Iq+7pPPHFYQBLQXMPIP
         Gn1g==
X-Gm-Message-State: AGRZ1gLzcImMKL/x2ZmIFAQ06ieyWxzQWXlHhp6Gj6xZqOqXfBjk/yoU
        3a1UoYXogFCE6n/v+2cjJZi0xg==
X-Google-Smtp-Source: AJdET5cQ2wNJ7zddjhPECfDUs+tvV7Z4LDERn4IsJzoZtoNlUR5v4ahz5jdyEL6kyPqqhuB+fae+aQ==
X-Received: by 2002:adf:eb48:: with SMTP id u8-v6mr4271971wrn.22.1540538268232;
        Fri, 26 Oct 2018 00:17:48 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id 76-v6sm5795539wmf.19.2018.10.26.00.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 00:17:47 -0700 (PDT)
Date:   Fri, 26 Oct 2018 08:17:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     pascal paillet <p.paillet@st.com>, dmitry.torokhov@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, eballetbo@gmail.com
Subject: Re: [PATCH v4 2/8] mfd: stpmic1: add stpmic1 driver
Message-ID: <20181026071744.GH4870@dell>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-3-git-send-email-p.paillet@st.com>
 <20181025112156.GB4870@dell>
 <CA+M3ks6s=mhLr0Hzcym_vmPVKjsuk8AFnQQe0qj-doVaXo9VcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks6s=mhLr0Hzcym_vmPVKjsuk8AFnQQe0qj-doVaXo9VcA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018, Benjamin Gaignard wrote:

> Le jeu. 25 oct. 2018 à 13:21, Lee Jones <lee.jones@linaro.org> a écrit :
> >
> > On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:
> >
> > > From: pascal paillet <p.paillet@st.com>
> > >
> > > stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> > > regulators , 3 switches, a watchdog and an input for a power on key.
> >
> > Same comments as for the DT binding patch.
> >
> > > Signed-off-by: pascal paillet <p.paillet@st.com>
> > > ---
> > > changes in v4:
> > > * rename PONKEY_PU_ACTIVE to PONKEY_PU_INACTIVE
> > >
> > >  drivers/mfd/Kconfig         |  13 ++
> > >  drivers/mfd/Makefile        |   1 +
> > >  drivers/mfd/stpmic1.c       | 401 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/stpmic1.h | 212 +++++++++++++++++++++++
> > >  4 files changed, 627 insertions(+)
> > >  create mode 100644 drivers/mfd/stpmic1.c
> > >  create mode 100644 include/linux/mfd/stpmic1.h

[...]

> > > +static const struct regmap_irq stpmic1_irqs[] = {
> > > +     [IT_PONKEY_F]           = { .mask = 0x01 },
> > > +     [IT_PONKEY_R]           = { .mask = 0x02 },
> > > +     [IT_WAKEUP_F]           = { .mask = 0x04 },
> > > +     [IT_WAKEUP_R]           = { .mask = 0x08 },
> > > +     [IT_VBUS_OTG_F]         = { .mask = 0x10 },
> > > +     [IT_VBUS_OTG_R]         = { .mask = 0x20 },
> > > +     [IT_SWOUT_F]            = { .mask = 0x40 },
> > > +     [IT_SWOUT_R]            = { .mask = 0x80 },
> > > +
> > > +     [IT_CURLIM_BUCK1]       = { .reg_offset = 1, .mask = 0x01 },
> > > +     [IT_CURLIM_BUCK2]       = { .reg_offset = 1, .mask = 0x02 },
> > > +     [IT_CURLIM_BUCK3]       = { .reg_offset = 1, .mask = 0x04 },
> > > +     [IT_CURLIM_BUCK4]       = { .reg_offset = 1, .mask = 0x08 },
> > > +     [IT_OCP_OTG]            = { .reg_offset = 1, .mask = 0x10 },
> > > +     [IT_OCP_SWOUT]          = { .reg_offset = 1, .mask = 0x20 },
> > > +     [IT_OCP_BOOST]          = { .reg_offset = 1, .mask = 0x40 },
> > > +     [IT_OVP_BOOST]          = { .reg_offset = 1, .mask = 0x80 },
> > > +
> > > +     [IT_CURLIM_LDO1]        = { .reg_offset = 2, .mask = 0x01 },
> > > +     [IT_CURLIM_LDO2]        = { .reg_offset = 2, .mask = 0x02 },
> > > +     [IT_CURLIM_LDO3]        = { .reg_offset = 2, .mask = 0x04 },
> > > +     [IT_CURLIM_LDO4]        = { .reg_offset = 2, .mask = 0x08 },
> > > +     [IT_CURLIM_LDO5]        = { .reg_offset = 2, .mask = 0x10 },
> > > +     [IT_CURLIM_LDO6]        = { .reg_offset = 2, .mask = 0x20 },
> > > +     [IT_SHORT_SWOTG]        = { .reg_offset = 2, .mask = 0x40 },
> > > +     [IT_SHORT_SWOUT]        = { .reg_offset = 2, .mask = 0x80 },
> > > +
> > > +     [IT_TWARN_F]            = { .reg_offset = 3, .mask = 0x01 },
> > > +     [IT_TWARN_R]            = { .reg_offset = 3, .mask = 0x02 },
> > > +     [IT_VINLOW_F]           = { .reg_offset = 3, .mask = 0x04 },
> > > +     [IT_VINLOW_R]           = { .reg_offset = 3, .mask = 0x08 },
> > > +     [IT_SWIN_F]             = { .reg_offset = 3, .mask = 0x40 },
> > > +     [IT_SWIN_R]             = { .reg_offset = 3, .mask = 0x80 },
> > > +};
> >
> > There should be a MACRO for doing this.
> >
> > If there isn't, you should author one and put it in the Regmap header.

> I don't understand why you want to put this MACRO in regmap header.

REGMAP_IRQ_REG()

> Offsets and masks are custom from this hardware block.
> How can this become generic enough to be put in regmap ?

When replying to only a small section of driver/review like this,
would you mind trimming any unrelated quoting (as I have now done),
please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
