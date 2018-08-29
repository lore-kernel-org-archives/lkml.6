Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719CEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222052089B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/O+c7sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222052089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeH2LgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:36:08 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36284 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeH2LgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:36:08 -0400
Received: by mail-it0-f65.google.com with SMTP id u13-v6so6023257iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uONAZEG+xvWRL7/1zDHI0ovoG06Jhaf7tDWY6382jHs=;
        b=h/O+c7sbjLDPCNPyyLfH3qPbjKE4+56zKko6zcTBfhRkWd48TqqVjdGkSx/5t/R3uD
         UAm9SaIJ/Ek7rDCVT3Sc1bgkAeW/J3USFg4JT0Jb7CRMx7PudBV1ByoiTWww0b5N1vwT
         1uuB2nHgHmpHYcSYNlYOqElORxKH/XmhjYuYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uONAZEG+xvWRL7/1zDHI0ovoG06Jhaf7tDWY6382jHs=;
        b=kbrHMX/gmY1piyYNmlH7UbXwljiavMNFjzXYwSZSncSIgexfmRFeinkb80+vZUoAzp
         0ZsE8RU4q5MGyGu0kq50ulnO2FYnxRNLXZuidbkVjbHecnm3U0iqOF6SUTwbqrZ4WSDx
         U5iZ5nnIC3cEIKueJz1cY6zddscpziE+w6TChgEBbp9hb4gBpQ35pNalTPtqQnlPMH7K
         /lpI57iSqZNywT2eelAuJHLBgv7fbyk7JCjXk33LVbfxBPvQhMsS9lQhDY8Sx9P7phdu
         yUiXw5PcCAPKfHUYaWJ1lVnV2DIJDrHb61pxA6Uoy+RA3Wx4NxY1c/sEsPvnHybBch8Q
         8aNg==
X-Gm-Message-State: APzg51CLYXpk9/V6pArtTl5clS6w4rC38wtxu5vGCxUtPdnBuh7uwAgf
        +pg7JL2Unwxiu1R4jHkSmxdKv6YUcvAAVkl3b9a1pQ==
X-Google-Smtp-Source: ANB0VdYyfAYeS5Lep2yiJSpMWDbQ5/V3T/7h+s4Rkrf0Bc9ZQ9Ft/KD0vDnTCshwVmYJjqEIS7t4lagVnz0a7s9lnlg=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr4171137jab.113.1535528435058;
 Wed, 29 Aug 2018 00:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180816200648.90458-1-swboyd@chromium.org> <20180816200648.90458-2-swboyd@chromium.org>
In-Reply-To: <20180816200648.90458-2-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 09:40:23 +0200
Message-ID: <CACRpkdbGUPpwEbGqg3Q3780DiEG2fts2WRkjkuQ2kmJR1HiftA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pinctrl: msm: Really mask level interrupts to
 prevent latching
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 10:06 PM Stephen Boyd <swboyd@chromium.org> wrote:

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

This patch applied for fixes with Doug and Bjorn's ACKs.

I suppose you will respin the two others and obtain buy-in from
the same people for these.

Yours,
Linus Walleij
