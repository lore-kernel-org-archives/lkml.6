Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B033C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB62206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dtEA8Km+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB62206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeK2EPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:15:22 -0500
Received: from mail-vs1-f46.google.com ([209.85.217.46]:43512 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbeK2EPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:15:21 -0500
Received: by mail-vs1-f46.google.com with SMTP id x1so16484016vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WYJexwOpz+TgRLYNAda2a0BvfcK2DWc32Umfl/L+Pvg=;
        b=dtEA8Km+nxwdEPXDkjQEYke3V68e25qzKO/zsWa0PyMoc7RX8fj20FF8/MSY1L7MaH
         Clk0PzJ5q6amIgB1Cxox9cD9izMLTHfRPttJWhCaRre4akUzFx1qilZGu9l56Bj1fRqZ
         rd4SjKsct8XKZvcmPhFAhDDRtUA6VC24qV3i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WYJexwOpz+TgRLYNAda2a0BvfcK2DWc32Umfl/L+Pvg=;
        b=d+lTX2Vv1lnzb/XJDmnZmeBLruskB5FXFWxzvliPQyYwbDi1HLTFua6TvZXnUKcinz
         u5Di7SyfPApIVXlbz+ch/u1cXb2V6POlip5wTk2tTuOoJQlJ6826C1FVO52lU27edLpE
         DHt/atte0O/MviwIk9bdt5h3ek+237s7781iF7xjBCFf/KJyaTWAoKYsEU8tLv63C5/z
         wzTQ/YZ7LjFI3ONefNy+0WUSkiNzYn1gqFz0Iz4yHwTlqB67eHov0ZuUIhDzQrB3fKQ5
         e4ZQYwLYVg3He/M49+t1KsXLsXegac7yppsaseQPgfxdptTFEn7EVZCMm6m7R0AeLHck
         FY3g==
X-Gm-Message-State: AA+aEWZCYZmlyAVmG/IJzy0vSbAJDu8rLCmFVV7mtD0gQ7I40soLsQzs
        owtwTtxkx+zXY4zIicY40R3lNdXhaDw=
X-Google-Smtp-Source: AFSGD/VpOwLI3vYXcJ1QH5od4yzIQekIBuODtOuAvvIybpYtAIpu1MPSwsXeUwu5wPe3QNJTXs5Z7w==
X-Received: by 2002:a67:3cd6:: with SMTP id w83mr9504403vsh.39.1543425180092;
        Wed, 28 Nov 2018 09:13:00 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id j25sm4537562uag.8.2018.11.28.09.12.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:12:59 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id z11so9162312uaa.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:12:59 -0800 (PST)
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr14710377uaj.126.1543424699832;
 Wed, 28 Nov 2018 09:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20181127232331.49628-1-dbasehore@chromium.org>
 <CAD=FV=WJCvt-Ez_F+gTJaLWnOOY2J0fXxgq8vy0ojKoHv+AQ7w@mail.gmail.com> <6602824.AOVt5XvbUN@diego>
In-Reply-To: <6602824.AOVt5XvbUN@diego>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Nov 2018 09:04:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UwOndHQeQyj+cj8-eFTmR2jDAM=XrQpNCegH4FAUkK4A@mail.gmail.com>
Message-ID: <CAD=FV=UwOndHQeQyj+cj8-eFTmR2jDAM=XrQpNCegH4FAUkK4A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add 32k clk on rk3399-gru
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Tony Xie <tony.xie@rock-chips.com>,
        Chris <zyw@rock-chips.com>, ayaka@soulik.info,
        "nickey.yang" <nickey.yang@rock-chips.com>,
        =?UTF-8?B?6YOR6Iic5Lm+?= <zhengsq@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Brian Norris <briannorris@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 28, 2018 at 5:46 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> > Possibly Heiko would re-sort this for you himself when applying the
> > change if he agrees with my understanding of the conventions.
>
> We hashed out the dt-conventions somewhat together during veyron
> times, so I'd be surprised if we didn't agree on them :-D .

You never know!  I make stupid mistakes all the time.


> In any case, I've adapted the commit message to add the Silego part,
> moved the clock to the correct position and applied the result with
> your Reviewed-by for 4.21.

Thank you much!

-Doug
