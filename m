Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C79EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F068C2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dWB/An40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F068C2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389990AbeKQCOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:14:08 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36917 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKQCOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:14:07 -0500
Received: by mail-ua1-f66.google.com with SMTP id u19so8425364uae.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jROpRz/qw81gEmwPcnv7AvyRx0cA2DY3+X1wAHEBRyQ=;
        b=dWB/An40MOfik+wKA8KxSY2mFe+T/tAH1wGMT8lDO+wILEKT9GMfzFKSlpm9nJORgc
         DPaXgWRoWATI7RvK8GZxRs1nVlgmiiKGTGIV9UFHxG9gqWIfVpknHHPhVpqtMz8EOtdR
         uQDFVCeEnHIVA2U9OxxU8eodQWX2R/nkvtLVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jROpRz/qw81gEmwPcnv7AvyRx0cA2DY3+X1wAHEBRyQ=;
        b=a/0Ii2x/utHOJiuf+cYUyRkg99EeM8HAkhb9LeO7PmS4nN/t700vj+jIqMM3Z0tdxT
         VcDH8ENCayIE0fBiZELHCHUcxsQHxLExL2luPTTBdQgrud1lQZ0D4VQySdmHqUkt2hP0
         IRgbicc/bhE0Q62oD8eMUGczoBDTaagywSvtPfpsf3N2kjFqQB+HGu8oJRlQy+cRQU36
         JAJlvp0Bw4q+zoL5Ib2W+uvmJ6OfGLmpDk+pZAQLqrYHk73Ov0AekVcL23B9+a8NfrRv
         8DqLn4Me77MP2dy5EyRqjTheirul0OGaBJWQPwdQE9xUoylQCr+nojDBWITELnht2lMR
         LVqw==
X-Gm-Message-State: AGRZ1gJ9sALwUIPRJO896ztzwiK5f1mh0nFW4h+hIztU1npWdE95m/NZ
        jRhI+Pa5AtvxelfRzALx0ly1o15qE8s=
X-Google-Smtp-Source: AJdET5dMxhRlkKhzUmp7ZMzQ8j9Z4vLtMCyrYBuxpy6yWnogZ3sP4yojnRv3t5Utbh+eITsH5v+Y2A==
X-Received: by 2002:ab0:49ee:: with SMTP id f43mr4855213uad.29.1542384071194;
        Fri, 16 Nov 2018 08:01:11 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id h2sm7533928vka.8.2018.11.16.08.01.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:01:10 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id v70so5352614vkv.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:01:09 -0800 (PST)
X-Received: by 2002:a1f:4301:: with SMTP id q1mr4825044vka.70.1542384069318;
 Fri, 16 Nov 2018 08:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20181116051719.23376-1-dbasehore@chromium.org>
In-Reply-To: <20181116051719.23376-1-dbasehore@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Nov 2018 08:00:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W7sYY5n609erPpTxux+0Efad_0YpPkoVZB14Kqm=baXA@mail.gmail.com>
Message-ID: <CAD=FV=W7sYY5n609erPpTxux+0Efad_0YpPkoVZB14Kqm=baXA@mail.gmail.com>
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

On Thu, Nov 15, 2018 at 9:17 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> This adds the xin32k clock to the RK3399 CPU. Even though it's not
> directly used, muxes will end up traversing the entire clk tree on
> calls to determine_rate if it doesn't exist.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

nit: I would have expected ${SUBJECT} to have v2 in it somewhere.


> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 99e7f65c1779..3d09472978f8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi

Aww crud.  I was at the airport yesterday and so I didn't notice that
you were touching rk3399, not rk3399-gru.  This belongs in the gru
device tree file, not in the top level rk3399.  As you have written
this it will break rk3399 boards that have an rk808 on them, AKA:

arch/arm64/boot/dts/rockchip/rk3399-ficus.dts:
arch/arm64/boot/dts/rockchip/rk3399-firefly.dts:
arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi:
arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi:

-Doug
