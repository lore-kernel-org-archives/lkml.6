Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB69C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82F620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL8wE0Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82F620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeLCWQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:16:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40962 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeLCWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:16:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so12450801oii.8;
        Mon, 03 Dec 2018 14:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiwdSymsTj3ZtXRp/+O99gQ6bsQ4WE3Gz6qmbgXlz1U=;
        b=tL8wE0Dxey9Yhik6AWk0JB45XV0bPwcG7aIa1o0wwsmXLY91UPR+48Vk51DXshiv4s
         Iddeja1kDN2XXelx1lE+GIfYsx2Ae9Ke22Xu5EoeO4LK6o1Kb/kDJoQdbrVrKq5Vlv0t
         fnaMcaCW/0nLuiUjv66CMylpmKsw8cHd/CwRAIui72X7Q5xLEj7MnRcm58JBlj/N3LV8
         y1foLTwPtfi68cH5dyrK/NCLRDU7PnSpHvuccG+EzzwTiAAOwgTdD351TUgtoyvJOiuZ
         ohHbpEnjtk1v4C3mh6S7+OUY/ixCeylu4v9vTFHZv6WWJ0vVIxN4xryxaMHAMDyqjpVZ
         LUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiwdSymsTj3ZtXRp/+O99gQ6bsQ4WE3Gz6qmbgXlz1U=;
        b=aukEWGwrSKQ0GN9iDByjnR7J703GqX+1fBuZNKOe9CR7R+Xc2CAyoqNjzZDpVbdvbG
         4fFc9naGo9y09KRrszZQ80sBij+wInjfK+qOUoERdhR9zWCmvvKncVeKW7sawIVsjGpI
         ofb3bP6r3DE4ETE1dY78VYB0cIzgtM78hpBjkkPXv/YJNTBg1XPBdpONPX7gyQQQOgHN
         7U8RodjJKFKC881QZulPpI8/xwJM70Ylt+MTEr8aU75fPnEpRWbgE7BO704NMoabt38+
         nK+PrFc6PR2Wp4Anho6pzefUCDHPEYH8wDELCPw4OSIAoU8SwGf8dDTHWoVVI3MGtN88
         xrsQ==
X-Gm-Message-State: AA+aEWbo0qHkAxwVthvOEmUtIDnEM7aRVBxv41ILZN1RGZ2m7lEo1WZt
        rnhCkiOef8pZWFDYaQ9htp21HBX32ZOrb/EgkNQ=
X-Google-Smtp-Source: AFSGD/UtjJVaWJs3alDbTHxaigeC6s8HGas2aX3i30u705WxD/PHRtA4N0hRysMnQkVZuFMa19vjkMJtftCprGzj0ak=
X-Received: by 2002:aca:d056:: with SMTP id h83mr11499531oig.67.1543875366028;
 Mon, 03 Dec 2018 14:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20181203211816.5129-1-jonathan@marek.ca> <20181203211816.5129-4-jonathan@marek.ca>
In-Reply-To: <20181203211816.5129-4-jonathan@marek.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 3 Dec 2018 20:16:07 -0200
Message-ID: <CAOMZO5B18DyZ0zvit6AgaueMifnMf2ctSo7pE_XndRpt7+bnLw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
To:     jonathan@marek.ca
Cc:     freedreno@lists.freedesktop.org,
        Chris Healy <Chris.Healy@zii.aero>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for working on this. Really nice to see GPU support for mx51/mx53!

On Mon, Dec 3, 2018 at 7:21 PM Jonathan Marek <jonathan@marek.ca> wrote:

Please add a commit log.

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

> ---
>  arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
>  arch/arm/boot/dts/imx53.dtsi | 17 +++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 67d462715..e9a7bbce9 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -628,5 +628,22 @@
>                                 clock-names = "ipg", "ahb";
>                         };
>                 };
> +
> +               gpu: gpu@30000000 {

We put the peripheral nodes in address order, so this one should go
prior to the IPU node.

> +                       compatible = "amd,imageon-200.1", "amd,imageon";

I can't find the dt-bindings for these compatible entries. Have you
documented them?

> +                       reg = <0x30000000 0x20000>;
> +                       reg-names = "kgsl_3d0_reg_memory";
> +                       interrupts = <12>;
> +                       interrupt-names = "kgsl_3d0_irq";
> +                       clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
> +                       clock-names = "core_clk", "mem_iface_clk";
> +
> +                       qcom,gpu-pwrlevels {
> +                               compatible = "qcom,gpu-pwrlevels";
> +                               qcom,gpu-pwrlevel@0 {

You could drop this @0
