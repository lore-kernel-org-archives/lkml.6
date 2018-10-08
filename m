Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E0C6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7F62089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RV6DGgJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7F62089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJIHHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:07:04 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39431 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeJIHHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:07:04 -0400
Received: by mail-vs1-f68.google.com with SMTP id m5so5884568vsk.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DdNmpRbk95JOLLRforiBceMLEdU3Qgy458szwJyea0E=;
        b=RV6DGgJYrPPInBGzaTItAwnP5lFCA0uHHfV04DGtGOHUhZYU5KRsD3Qy/RJeD8yz0w
         G/EagxGm4IAKSIqrfSlP0VxADkX8Cis6hmpKO+jlCuQ+8+p4WeXrUqhq2BwcPToKaXcL
         ktx00wWScuZMou63OKun9Au6dovmz8bJFK0x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdNmpRbk95JOLLRforiBceMLEdU3Qgy458szwJyea0E=;
        b=XuZ+L914zGxry0ZmgVPrbGphwTxd9+QFTvq1u6HH4Ck2UiZFWsJ6aYhz+Ung07324x
         4qMq+aYGREldm1aQpaDmdCsrBqRF59k2EEOf8/nrzSHXB8pAZyYYfrh05CSgHuLg+3zG
         8OrUvrZX+0vSZ47HyXso6qo8pOUaQyhi0c5cjs6uVWBmGbQlpq+Hilg3O3y+M2rC4Ami
         VJHve9FX6NAYJ329xbpaoEkujdZ12S7nHw01GsBjqtC47QiaDMmskM9AaANm7V0ONJiw
         gnvxM7HiH4rgvqGaXs/3j9GWHQO/ALvhWbP+KL2eBAvAGeIDUGNokF4pDg0DAUgLs9l1
         agmw==
X-Gm-Message-State: ABuFfoioK1z2Ile7C9qiaupwwtbvu8/8Zs/8x9jldSUmTeJSQfG0RhaJ
        QD1QuTPhsAuiDFwwNkQ3OXFH8qpojtM=
X-Google-Smtp-Source: ACcGV60pHVk+w7JCE2sUVcIOZEeq8yDUPcoRfCIJ7L45YfJG0glbRnMO/tRdh9ClLdFj3BdthFVnGg==
X-Received: by 2002:a67:f84:: with SMTP id 126-v6mr9368490vsp.197.1539042771979;
        Mon, 08 Oct 2018 16:52:51 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id h76-v6sm1481709vsa.2.2018.10.08.16.52.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 16:52:51 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id r20so5304571uam.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:52:50 -0700 (PDT)
X-Received: by 2002:a9f:344d:: with SMTP id s13mr9872325uab.27.1539042770484;
 Mon, 08 Oct 2018 16:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org> <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
In-Reply-To: <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 Oct 2018 16:52:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
Message-ID: <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 8, 2018 at 4:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > +       mas->irq = platform_get_irq(pdev, 0);
> > +       if (mas->irq < 0) {
> > +               ret = mas->irq;
> > +               dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
> > +               goto spi_geni_probe_runtime_disable;
> > +       }
>
> Nitpick: If you got the irq earlier before allocating anything then nothing has
> to be put on failure path.

I think this might have been in response to previous feedback from you
suggesting that we should get the irq as late as possible.  Ah, here
ya go:

https://lkml.kernel.org/r/153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com

> Can you request this irq as late as possible in the probe function? I
> worry there may be some pending irq line set and then this will cause an
> interrupt storm with IRQ_NONE returned because the device is runtime
> suspended.

I'd rather handle the failure path then get the IRQ too early.

-Doug
