Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B163C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC24206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IjbExokM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC24206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeJBV7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:59:17 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36401 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeJBV7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:59:17 -0400
Received: by mail-vs1-f68.google.com with SMTP id z19-v6so1283489vso.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7aYHtqT4mEmo28qE4Vz2m1W1mUJzuvLFbF4Oh3dUH5c=;
        b=IjbExokMGSNodp/wxAbSrfXeGRMzVdNhmZ67zZ9NbDJwgIYGwlZGGcjbPP56PVh1sQ
         PMeTpVCM9ZCASX2xc6L4FJYVAhMQ9/P9CjcdQrcs8NbkgOxHB0DJD5uggwu9KUOjaETo
         ruuJno+MA/he4kw5+hpZNHchdikpjSNWDsYJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7aYHtqT4mEmo28qE4Vz2m1W1mUJzuvLFbF4Oh3dUH5c=;
        b=pAW3vfNQO4ljYaHd/axNGAQdiGhN+jY1iI/ZXpxGAt9nDzww2pqI8KYm2Se9np1aPS
         qNe0/oUtKVqi/AS/ddSF9ncRyMYVONgKc35WgSdCpP8LzN2hkBFsDheAb2lGa14iIQvR
         t7QUT7wR7QxkYFzCU3cXbtMUflna58xtVCG6rLOQJaz2EvzT1nZltuMmGdq/c/RQvAgt
         lEX9igqxoxheERc5C+S5C/67qB1Ik3g3MOcp8j48BqY/rk+CXzq9JbcFUzqmJ7lncZFo
         b4ZFFFSyzWsV0rmfvZd9sHK2GHldxkgS9kwndyZfLR+2WPQox0vEWg5wfJEISPFkBXGP
         bf5Q==
X-Gm-Message-State: ABuFfoiaz7LJkv2DcZe8vk3MCFBM87koWTXJMmdnEklb2RQCq80iFT0p
        40r9mWn4qVO2nCfQyaBihoaQzDubTb8=
X-Google-Smtp-Source: ACcGV60DdvfIxj9wpSxFtNRRAhJnL4MpAwrMSg8PTTZbva+roUpod4FSQXJC9trnaxQs+66ahBIg6g==
X-Received: by 2002:a67:7654:: with SMTP id r81mr1170291vsc.35.1538493323874;
        Tue, 02 Oct 2018 08:15:23 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id c198-v6sm4250388vsd.3.2018.10.02.08.15.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:15:23 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id z19-v6so1283452vso.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:15:23 -0700 (PDT)
X-Received: by 2002:a67:6604:: with SMTP id a4mr2407192vsc.42.1538493322732;
 Tue, 02 Oct 2018 08:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181002013142.209751-1-ryandcase@chromium.org>
In-Reply-To: <20181002013142.209751-1-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Oct 2018 08:15:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VArNPwqxdjCo772V7ZmBQuirHSUpaeVvziiKgdUc-meA@mail.gmail.com>
Message-ID: <CAD=FV=VArNPwqxdjCo772V7ZmBQuirHSUpaeVvziiKgdUc-meA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
To:     ryandcase@chromium.org
Cc:     Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Trent Piepho <tpiepho@impinj.com>, boris.brezillon@bootlin.com,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Oct 1, 2018 at 6:32 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v5:
> - None
>
> Changes in v4:
> - Changed qspi@ to spi@ and device@ to flash@ to match Rob's review

Rob said that with those changes you could add his reviewed by [1], so
this patch should have carried:

Reviewed-by: Rob Herring <robh@kernel.org>

I'd also say that usually when changes are minor you can make a
judgement call and carry previous reviews.  If there's any question
about whether previous reviews can be carried you can mention it
somewhere in your changelog.  In this particular case I would have
called the changes minor / non-controversial so I would have kept
Stephen and my reviews when posting the new patch.  In any case
Stephen has already re-provided his review and you can feel free to
add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


[1] https://lkml.kernel.org/r/20180927204624.GA7072@bogus
