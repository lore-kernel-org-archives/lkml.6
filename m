Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72247C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6D20894
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IOpjLd+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF6D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeHPXuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:50:22 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41547 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeHPXuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:50:22 -0400
Received: by mail-vk0-f67.google.com with SMTP id o82-v6so2122308vko.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e3/i4te2tmPG/Tt49yi+1mUNUJ0d/DXglduwz4DctVs=;
        b=IOpjLd+OssDGauJp7+xvqcWt5NKN4MF3tYs4BfXAdA2HA94HKznUf+4u1N6O2Nu6pE
         rM60Pr7yvzsEDjdQfiO7Vn6wh8pVJ0RTjDH/a6KxxAwTvPQJsbBNnCN+j1szrO2cm1q5
         Y4yCOu3tsFcYnuOmBCKTx3HlMK8OqI3S2ItlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e3/i4te2tmPG/Tt49yi+1mUNUJ0d/DXglduwz4DctVs=;
        b=Q9iPm4pXkAoKVCldEm4MlerNayfNbp9tl1KNPnboRKlYjyX2csmCNlpgxnuga6B/5d
         V3ak1D0/lwoBR3a+MnsJoa2pPQX2ETgmPJ2uTxiUtyVPG4qRj2LLu0y7dlZ5RB8meTNF
         xcM7dlCirljw/+EMNcTTmyHKHzbC8MsXMiYsWvzsNC2E2XSEcMeTkcpCNA9ebaxj/Wjd
         v36YfHVipSdgH/0EBWLxcA4onFtzcD16DppYne6ePrMpiDLtyByyY4nm48LqvIsIu/K5
         Pwf2iKUZuveVcKH0wFmVWPqoATMGVBss6uSe6OwFdhNRxl4f/59ntPaTET3ty+MGY8CS
         rf8w==
X-Gm-Message-State: AOUpUlGpcWamLlTHfwvROu4UaV0Lmv2ymsvoxKGhaIKF1LTggIqpedyI
        zZgxFzx+mkxwOUyaph59nQ54Iix1bnU=
X-Google-Smtp-Source: AA+uWPx62WmaMrwlKBXSInoA0saVYPPti1foYsMs9TQ6Me/fgaKlYT6/DGrjO03kSYqC7O3ghRYrwQ==
X-Received: by 2002:a1f:854d:: with SMTP id h74-v6mr20623578vkd.69.1534452583786;
        Thu, 16 Aug 2018 13:49:43 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id c9-v6sm54921uak.19.2018.08.16.13.49.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:49:42 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id y10-v6so4501040uao.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:49:42 -0700 (PDT)
X-Received: by 2002:ab0:5ac5:: with SMTP id x5-v6mr20881024uae.97.1534452582325;
 Thu, 16 Aug 2018 13:49:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 13:49:41 -0700 (PDT)
In-Reply-To: <20180816200648.90458-2-swboyd@chromium.org>
References: <20180816200648.90458-1-swboyd@chromium.org> <20180816200648.90458-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Aug 2018 13:49:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uk9XgP+6_4x685E0yM4kS+0HkEFtML+N-nkR6DzFfchQ@mail.gmail.com>
Message-ID: <CAD=FV=Uk9XgP+6_4x685E0yM4kS+0HkEFtML+N-nkR6DzFfchQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pinctrl: msm: Really mask level interrupts to
 prevent latching
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 16, 2018 at 1:06 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> The interrupt controller hardware in this pin controller has two status
> enable bits. The first "normal" status enable bit enables or disables
> the summary interrupt line being raised when a gpio interrupt triggers
> and the "raw" status enable bit allows or prevents the hardware from
> latching an interrupt into the status register for a gpio interrupt.
> Currently we just toggle the "normal" status enable bit in the mask and
> unmask ops so that the summary irq interrupt going to the CPU's
> interrupt controller doesn't trigger for the masked gpio interrupt.
>
> For a level triggered interrupt, the flow would be as follows: the pin
> controller sees the interrupt, latches the status into the status
> register, raises the summary irq to the CPU, summary irq handler runs
> and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
> interrupt, the interrupt handler runs, and finally unmask the interrupt.
> When the interrupt handler completes, we expect that the interrupt line
> level will go back to the deasserted state so the genirq code can unmask
> the interrupt without it triggering again.
>
> If we only mask the interrupt by clearing the "normal" status enable bit
> then we'll ack the interrupt but it will continue to show up as pending
> in the status register because the raw status bit is enabled, the
> hardware hasn't deasserted the line, and thus the asserted state latches
> into the status register again. When the hardware deasserts the
> interrupt the pin controller still thinks there is a pending unserviced
> level interrupt because it latched it earlier. This behavior causes
> software to see an extra interrupt for level type interrupts each time
> the interrupt is handled.
>
> Let's fix this by clearing the raw status enable bit for level type
> interrupts so that the hardware stops latching the status of the
> interrupt after we ack it. We don't do this for edge type interrupts
> because it seems that toggling the raw status enable bit for edge type
> interrupts causes spurious edge interrupts.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: IMO we should land this fix even if we continue to have debate
on patch #2 and #3 since this fixes a definite problem.

-Doug
