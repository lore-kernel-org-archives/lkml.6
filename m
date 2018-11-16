Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAC0208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S9fe7+0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAC0208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbeKPPOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:14:32 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45939 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeKPPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:14:31 -0500
Received: by mail-vs1-f66.google.com with SMTP id v10so5671838vsv.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 21:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbTGX7jTjM3mFVlhKI5w1XE1KgMp5DkMTJobe/defSk=;
        b=S9fe7+0RqXdy6DikKQCtD3Vmfru5/KrtCa1qI7Zorm5WRL7JS066k2ZJMqaWefvqnU
         +qb674p/PP4wcpI1vEQnKcqSkEC5hJebr4/oP5mD3lmVRSTZFpHZ1ZeDkwndH1mrroWP
         lX6eK8FyBy6kw8pWty9vHrGUeSuZ5MxFEzIgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbTGX7jTjM3mFVlhKI5w1XE1KgMp5DkMTJobe/defSk=;
        b=N/fsSqmuYJZa/DocuhwbcEZ+2zCeqcDqj9LhqyG7LQB4992M/OX8/2QsPic96uSw2j
         HjPItr5I+UwBavKUEtZy0COxR+28VFt0y0B5TgU+0xJjira/9rOyK+oaLv2LMrsZ3N+w
         mMu99T/IGmgZcdj43ao1KCzapa2EJh63vfvjVtUsJfkPiVezMKMLGgMquKCvak5Cx60s
         1EWxaypOcGf1R19D+rprfA6EH7dPVPHqKGz+5fP3n1S93mQrDsGlhkNqADF2+XtoBU5g
         rMx+9t5OaryXW1S8Pj01NoEph557DO2dTeBwdlrW/xBSPJHoZIq1A6Kye0xb8EEd9O80
         REgw==
X-Gm-Message-State: AGRZ1gJLoy1qX8R2VzUMo3UaEPgIwWL84Qhur/SOJEXPydPw8ysH+hRw
        YHPziiHPIGWrtiecI6eu22Gib3v5yJU=
X-Google-Smtp-Source: AJdET5eL80f+EYEpwgWDeQcuWHUS6hvxa5QLmsgqk2uccup/pdRtgCxbPwzaokB26Gfa2fC0sPPIcQ==
X-Received: by 2002:a67:ca0c:: with SMTP id z12mr3463838vsk.83.1542344619598;
        Thu, 15 Nov 2018 21:03:39 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id d195sm7286880vka.29.2018.11.15.21.03.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 21:03:38 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id p193so12727720vsd.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 21:03:38 -0800 (PST)
X-Received: by 2002:a67:f598:: with SMTP id i24mr3932394vso.87.1542344617863;
 Thu, 15 Nov 2018 21:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20181116004247.172977-1-dbasehore@chromium.org>
In-Reply-To: <20181116004247.172977-1-dbasehore@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Nov 2018 21:03:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VjN3J66wv2LGhQYD+-_W1q+KCzvo3V_1F9ktAb-T-i4A@mail.gmail.com>
Message-ID: <CAD=FV=VjN3J66wv2LGhQYD+-_W1q+KCzvo3V_1F9ktAb-T-i4A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Tony Xie <tony.xie@rock-chips.com>,
        Chris <zyw@rock-chips.com>, ayaka@soulik.info,
        "nickey.yang" <nickey.yang@rock-chips.com>,
        =?UTF-8?B?6YOR6Iic5Lm+?= <zhengsq@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Brian Norris <briannorris@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 15, 2018 at 4:42 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> This adds the xin32k clock to the RK3399 CPU. Even though it's not
> directly used, muxes will end up traversing the entire clk tree on
> calls to determine_rate if it doesn't exist.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 99e7f65c1779..6a32293982d0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -191,6 +191,13 @@
>                 #clock-cells = <0>;
>         };
>
> +       xin32k: xin32k {

nit: xin32k is the name of the clock that rk3399 consumes.  It seems a
little weird to name this node with that name.  Can you call this:

ap_rtc_clk: ap-rtc-clk

...after the gru schematic?  You wouldn't change the
clock-output-names, just the node name / label.


> +               compatible = "fixed-clock";
> +               clock-frequency = <32000>;

I checked the datasheet for the 32K clock and it shows that this is a
32768 Hz clock, not a 32000 Hz one.  I also checked the rk808 clock
driver (which is supposed to be compatible with rk3399) and it
produces a 32768 clock.
