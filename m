Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FFDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC62F20665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V1aJ+AxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC62F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeK1Lme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:42:34 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45924 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1Lmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:42:33 -0500
Received: by mail-vs1-f66.google.com with SMTP id v10so14995306vsv.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+45M9KX0qCFH4GRr3LXJuBGL7wbqSnB/SCW2DaFwLio=;
        b=V1aJ+AxV4YmT8c+Cl1E63qPOkyjbzP+hUzo5LeB0xpHwGDgfyS9nHqI3px9ozG7H/A
         zvdflbVrUM43GxLIm509osV3xhALA5mOc/K6FYqI2ECLqM9RKCGL8JEwRRrrN617P3Hx
         MB3jyNtKxwrRZGyidkriDoMYO9Go4V7x/54aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+45M9KX0qCFH4GRr3LXJuBGL7wbqSnB/SCW2DaFwLio=;
        b=SsokI1lqBMU/IZXfiB4r1Qk8FeIQ5hzJsO3nW0pwMagM60vzWlv+k8r8frJseAyH3J
         Rs0MYRmu4GA2bM5GWIkSi0J78Crnlr4RV0+FixSFlg8MwMGlbwb3dYExHhcF8i6vsiQS
         gbV48A8SGr3NA+cllrjXypJHMl6IyOUjqQ8pIfhlXc+uOVDbdxhIzcWq4Wd0Y06BsR04
         UW8SpBJdp2zy9e0EXlUrBVj5XfjPMs/BEYihP0qR3BsL37ahREbvFdz8XAeneQBMBeJG
         DHRW6gwI8UgxMDhWFGQA9bGmnwAeURPMC5r4Q1yweb8Tk2F5oUi/MeellVP6oYO9OR49
         fojA==
X-Gm-Message-State: AA+aEWZtycsuhviYiGzQIgC4lGTsJU7vKCK8ezBYbBMROH3SgbdQd9Pj
        RPwYL2RYDCldkvjw0X/UwjY1CQO+F0I=
X-Google-Smtp-Source: AFSGD/U67o5eLD6Rbg4ytRQ71/wjg88erRO4aOCnAHv7qhybvLDZJ5q7vS9koXC13bSr3BHLM9v/VQ==
X-Received: by 2002:a67:6002:: with SMTP id u2mr9353150vsb.115.1543365771428;
        Tue, 27 Nov 2018 16:42:51 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id x132sm1658170vke.52.2018.11.27.16.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 16:42:50 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id b74so14981019vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:42:50 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr12382489vsj.144.1543365769686;
 Tue, 27 Nov 2018 16:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20181127232331.49628-1-dbasehore@chromium.org>
In-Reply-To: <20181127232331.49628-1-dbasehore@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 16:42:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WJCvt-Ez_F+gTJaLWnOOY2J0fXxgq8vy0ojKoHv+AQ7w@mail.gmail.com>
Message-ID: <CAD=FV=WJCvt-Ez_F+gTJaLWnOOY2J0fXxgq8vy0ojKoHv+AQ7w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add 32k clk on rk3399-gru
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

On Tue, Nov 27, 2018 at 3:23 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> This adds the 32k clock to the RK3399 Gru board file. Even though it's
> not directly used, muxes will end up traversing the entire clk tree on
> calls to determine_rate if it doesn't exist. This is because the 32k
> clk is listed as a possible parent on some clks. Since the clk doesn't
> know about the 32k clk (it was never registered), it triggers a global
> search for it. This can happen about 40 times per second, which isn't
> great for power.

I seem to remember Heiko requesting something be added to the commit
message.  Ah yes, he said:

> That would also be a great part of the commit message, like
> "...on Gru boards the 32kHz clock gets produced by a Silego oscillator"
> or so when you move it over to rk3399-gru.dtsi .

Presumably Heiko could add that to the commit message when he applies
the patch, so maybe wait to see if he wants you to respin it?


> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index ca07f6032200..a07aa4c570c0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -14,6 +14,13 @@
>                 stdout-path = "serial2:115200n8";
>         };
>
> +       ap_rtc_clk: ap-rtc-clk {
> +               compatible = "fixed-clock";
> +               clock-frequency = <32768>;
> +               clock-output-names = "xin32k";
> +               #clock-cells = <0>;
> +       };
> +
>         /*
>          * Power Tree

Really this should be below the power tree, AKA right above
"gpio-keys".  Convention has typically been that only "special" nodes
like "chosen" go all the way at the top here.  Then the power tree
(parents first), then other nodes.

In the Chrome OS tree we had an "/* END REGULATORS */ comment to try
to separate out the power tree from the rest of the nodes, but I guess
Heiko didn't like that when this went upstream so now you just have to
know the convention.  :-P

Possibly Heiko would re-sort this for you himself when applying the
change if he agrees with my understanding of the conventions.

Other than my nits:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
