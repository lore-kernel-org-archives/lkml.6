Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAFAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21A0206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aSEQ2GhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21A0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeK2KrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43612 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeK2KrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id 83-v6so38370ljf.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yB4safdTcWcpcZlNQIgP7SVO+vxyNJ2W8+iYUZ2dKEo=;
        b=aSEQ2GhYxwlppKmw8uM1YekRZOfVfzBoZDK8duCgSDmZkltYdEjM6c2u8Ud3Yf6yTZ
         hq8KQmxqb7YHuP9ENdo2ti6+t4pxg2r0wPy8q6hAUEbV04rMgeuvJX4D6j5zMHgfGbms
         K8PCwcfv9COWJDZ1Ah4sF3xz7vQydoEEefGOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yB4safdTcWcpcZlNQIgP7SVO+vxyNJ2W8+iYUZ2dKEo=;
        b=YT3tvl29VJWs3l4923egnQjVwBwF/igskSSTpc0+IcABKR/nozaI9UXYJ9aAOFiEme
         QiF4XLGgnZEL7X1IQLUVeA9cYJMrF4orNftjQu+Y2Dnci8loGtxcw+3FSR55L5MXBxBB
         yFf+3UfzGob5MjCTxGXdEo0JIxR82FcMpSwkUU4aZI+Du4t1KQApY5C/SB0NpIG1HABW
         R7vhEirlb1pqIDVPnYCV1pB/FbX2lz0q46yHoQKA2GjtPOgvZwWZqeuYQO//WiZZq+8j
         Rt55MEfxoNjmQCmEiOjRy1rMAK+LdkWr236orON9a02TpsRRedZ5MYqEkjxQQ4GP5ZfR
         /xtA==
X-Gm-Message-State: AA+aEWYzLhu4IWSD38w7saAkb1InDf5+1tZcvYS7a7b/JklZ1vwbGHiw
        GB16jjkyL7sfgJp+w3otZtqtF7zKb+M=
X-Google-Smtp-Source: AFSGD/WiHElFcFhUFZrYCVM74sXLyRl3Vc6zVTTO4jYsEpkSHHlaj0rnOga52b8JjR5yCGevbcYBLQ==
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr23806270lji.93.1543448631869;
        Wed, 28 Nov 2018 15:43:51 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x11sm9047lfd.81.2018.11.28.15.43.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 15:43:50 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id c16so37925lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:43:50 -0800 (PST)
X-Received: by 2002:a19:1bca:: with SMTP id b193mr22124164lfb.153.1543448630074;
 Wed, 28 Nov 2018 15:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20181026173544.136037-1-evgreen@chromium.org> <20181026173544.136037-4-evgreen@chromium.org>
 <20181122071847.GL2225@minitux>
In-Reply-To: <20181122071847.GL2225@minitux>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 28 Nov 2018 15:43:13 -0800
X-Gmail-Original-Message-ID: <CAE=gft55NLPAD4Z5w5aDDPB0YRPJP9xX-RmD1sz4ZfNCxURb+Q@mail.gmail.com>
Message-ID: <CAE=gft55NLPAD4Z5w5aDDPB0YRPJP9xX-RmD1sz4ZfNCxURb+Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] arm64: dts: qcom: sdm845: add UFS controller
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robh@kernel.org, Andy Gross <andy.gross@linaro.org>, kishon@ti.com,
        Doug Anderson <dianders@chromium.org>, swboyd@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        David Brown <david.brown@linaro.org>, mark.rutland@arm.com,
        linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:18 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 26 Oct 10:35 PDT 2018, Evan Green wrote:
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index b72bdb0a31a5..9c72edb678ec 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -808,6 +808,73 @@
> >                       };
> >               };
> >
> > +             ufshc1: ufshc@1d84000 {
>
> There's only one ufshc and one ufsphy, so no need to include the index.

Aren't there two UFS controllers on SDM845, a "card" one and a "mem"
one? I'm only adding the "mem" one here since that's all I can test,
but I thought it made sense to leave the number there so someone could
add the "card" one later if needed.
>
> [..]
> > +                     resets = <&gcc GCC_UFS_PHY_BCR>;
> > +                     reset-names = "rst";
>
> I have this as well, but this is not used by the upstream driver nor is
> it mentioned in the dt-binding.

I see it in Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt,
but then the only place I see it being used is ufs-hisi.c. So you're
right, I think I should spin and remove this. Since I'm spinning, let
me know about the numbering thing above.


>
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             ufsphy1: phy@1d87000 {
>
> With reservation for the "reset" issue:
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Regards,
> Bjorn
