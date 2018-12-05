Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B47C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760D520892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SpTqPDrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760D520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeLEVHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:07:51 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46964 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbeLEVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:07:51 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so4164656vso.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOyS1jdrqnGKq/u+nEMoAh6bIy98pQEi+djMhAtHh6Y=;
        b=SpTqPDrPAlzbpykSx9N1WroVz9xZi4ruj+ESVHC0fsAflue/9kONAyfzHI0Sb69lI2
         ozviojsN3Oov8wRy2xJtKbJhzVqmcLhzUiVGsCiLBYzauHYDz1V9YSw3aBFP5lNzIDgm
         WGngVE+JtXXdD9POXK0E9EQLLnPdX1V3vRf94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOyS1jdrqnGKq/u+nEMoAh6bIy98pQEi+djMhAtHh6Y=;
        b=fs64QEGPrkuS0PtTF7AySAmbhDaWasEYH7kcEeONoEUBPurzYJVjjSpRbq2xTiz/Tz
         ySiprNqdeiINsdUUcm4+N9reKf0uZ0wd/qY3HJK9OWUXKdFcBfnjX5c1/tqoT6jDNniM
         fJvrf2oBOm/jgZOqzeOnKo2GCFH8PW91HVt4sr2RbzzimrowkeL/4J94R89HxI6hIu9c
         b+J2HP0jv8HhYq41h6quR0/k8Mw2ZdR4xIgM3IzP3CTmmpMMqpl+E/hMvg4vz+5j8VaQ
         wEJaHq8UePbP99i9YQGvyvMzVYGShv+NF/nNFVmv8Jv8HlZEn8reCDcBKiBmOZJDAtl3
         OdzQ==
X-Gm-Message-State: AA+aEWaTGpsd5bSXFQwnflLeXh9ygTs5nI/B3JFpIEgBuIcH+E+qbxec
        /ZZuqdGd2ipjZQLkTdawOxDkj1URtmA=
X-Google-Smtp-Source: AFSGD/WzVF7MFmPDtmNK2V31c7LsOaKesW8OxeP8i8dmeBztRXz0nUJCFjDKct1RInbT4KP02ZWhVA==
X-Received: by 2002:a67:7d06:: with SMTP id y6mr11562375vsc.22.1544044069261;
        Wed, 05 Dec 2018 13:07:49 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 80sm6303411vkn.30.2018.12.05.13.07.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:07:48 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id b74so12977959vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:07:48 -0800 (PST)
X-Received: by 2002:a67:f598:: with SMTP id i24mr11455629vso.87.1544044067617;
 Wed, 05 Dec 2018 13:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20181128223428.177313-1-evgreen@chromium.org> <20181128223428.177313-3-evgreen@chromium.org>
In-Reply-To: <20181128223428.177313-3-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Dec 2018 13:07:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wqrje73K+o0NvHSriVatnDu44jGqvc_nB7PMhjH6-cvA@mail.gmail.com>
Message-ID: <CAD=FV=Wqrje73K+o0NvHSriVatnDu44jGqvc_nB7PMhjH6-cvA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: sdm845: Add SD nodes
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 28, 2018 at 2:34 PM Evan Green <evgreen@chromium.org> wrote:
>
> Add the SD controller to SDM845.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Looks right to me.  Possibly you might want to make it known in the
subject and description that this is only sdhc_2 since there are two
SD controllers in SDM845 (oddly numbered sdc2 and sdc4 in the
documentation).  sdc2 (the one you're supporting here) is the
dual-voltage one (supports higher speeds) and also the only one hooked
up on MTP I think.  ...so maybe nobody will ever use sdhc_4, but it
might be worth mentioning anyway.  ;-)

Other than that suggestion this looks good to me.

[note to Andy: please double-check that this ends up in the right sort
order when applying.  If you happen to apply the Quad SPI patch first
then "git am" might end up putting the SDHC_2 node _after_ the Quad
SPI but it should sort numerically before it]

Reviewed-by: Douglas Anderson <dianders@chromium.org>
