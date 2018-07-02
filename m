Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A71C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E17124E8A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KIRpm+W0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BuMHB58i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E17124E8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeGBTxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:53:49 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34848 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeGBTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:53:47 -0400
Received: by mail-vk0-f65.google.com with SMTP id o202-v6so9826131vko.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qcHEuX7FKaKZcVGpK9KgfRsvXpi/zWmXp/QFrcZOjS0=;
        b=KIRpm+W0WXffzBTHO8vxqBM+r9Mbm4/Vf0ooOqVueKdF6rSHDX5qmrWgKHWbnwfBGE
         R/+NQXu2fmHC71BwfV4YjRh8gkVBa2kKw57Alx80Wemil5QP/I1uF47LBgN4IhhukESH
         xLYwInmTJ1Vgu/7ZVGGPaOJgJG2sKNhpTTEMcSiAiSwUIwTrIOSdykiRcIj/n8NbPE5L
         D2DyHNosTxACa9wt5SVTvA0v2zNLVH/AZDrbBgotEo6nvmNFXqZf05nHPYXaV+wHXoxU
         GK/mPJNTD58sbk0Q+CV3rgCDs7oh1HqIk+WC+y3Jks8KFQ0Xq3uFD0iH/JD2cocrdfZm
         1Mhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qcHEuX7FKaKZcVGpK9KgfRsvXpi/zWmXp/QFrcZOjS0=;
        b=BuMHB58ih+rVVfudJk6GOIbwzx2hQYEBhto0QP2gP1zWhhc5Pe/w7JuCaBuxhfBwtO
         NRtVqz9pATmb8hwy77eBwSl1Sq+kz3F1mnPD5K8raEZXhV1JCw7yw+nw6oWoulHnxgpH
         v8r52OxxjbJHzPD2AT5wom9hGORPfshg4nRtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qcHEuX7FKaKZcVGpK9KgfRsvXpi/zWmXp/QFrcZOjS0=;
        b=MiItITBYW6CpHa7DM9rAz0s8Xno3kNb+h0gB5gBeMNAxjYwv93KHcgkfyQrv3Em1kK
         r9hxdRsfwYc4hmaUzUjP7hLRVnKz/0cpCqkTpEnALXluoeOV3LSaLKZSXV9/GmmoKbFu
         EAYM+xaesAa2/vJqSiojGz1+DcumEBuKnOpW+scpY5HM2GPeJM5msSyL/EIXbs+kVbnA
         jGnrF+F0G7ynD01uoeLO07zp+/1Pbeqr4SI5oGwgZj9tkKnL5sggHqe9zGmj7M/XIEsR
         q9RXR58HeV2v45K5fm41seTrHWFgtq+pA0EV5+YP9gpAOKIzpxXQ7l/LP/88Q9FHqgb6
         uwZQ==
X-Gm-Message-State: APt69E366ZnV6q65XanP5HUkgHUk1VwjUKXgGtTq6FflR6nrdYxOkXe0
        wS+B25tUQOr7lbQNMhw/8sllQ8+IlX7/hMN8z0S9uw==
X-Google-Smtp-Source: AAOMgpdG32DLfvl7P2OJvR7lVnmyD+cjceyxgUIb4SiAqDg4gQqrIjJT6py0QnptFzCiTJ2ks5Bl7QeV3YESN+77cX8=
X-Received: by 2002:a1f:18cc:: with SMTP id 195-v6mr11922345vky.117.1530561225480;
 Mon, 02 Jul 2018 12:53:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 12:53:44 -0700 (PDT)
In-Reply-To: <20180702181005.18247-2-mka@chromium.org>
References: <20180702181005.18247-1-mka@chromium.org> <20180702181005.18247-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Jul 2018 12:53:44 -0700
X-Google-Sender-Auth: BQSmLQIg-4BhNhTSjsn4Tkdme2E
Message-ID: <CAD=FV=WH8q-3Rt89Get0N357+hWmKiEsruaKtWzo_JoE6gd_3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 2, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote=
:
> The thermal zone uses spmi-temp-alarm as sensor. If the sensor is
> configured without an IIO input it always reports 37=C2=B0C for temperatu=
res
> below the first hardware trip point at 105=C2=B0C. This hardware trip poi=
nt
> is configured as critical trip point, to initiate a system shutdown
> before the temperature reaches the next hardware trip point at 125=C2=B0C=
,
> where the PMIC performs a partial shutdown.
>
> The temperature of the critical trip point can be raised after adding
> the die temperature ADC as IIO input for spmi-temp-alarm, which
> significantly increases the precision of the temperature measurements.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - defined 'thermal-zones' node in pm8998.dtsi instead of using a label
>   to refer to it
> - use 105=C2=B0C hardware trip point as critical trip point

I'm not sure this was right.  I guess you're trying to avoid
Temperature Stage 2?  From Davi'd email in response to v1:

> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> off peripherals within the PMIC that are expected to draw significant
> current.  The set of peripherals included varies between PMICs.  This
> partial shutdown will occur simultaneously with the triggering of an
> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> driver that an over-temperature threshold has been crossed.

I think it's actually OK to use Temperature Stage 2 as the "critical"
point, which is why it still interrupts the CPU.  At "critical" the
system will shut down, right?  ...so presumably it's OK if the drivers
can't recover from having the power yanked out from underneath them as
long as they don't hang/crash the system in this case.  If I had to
guess the whole point of this stage is to give the system shutdown a
better chance of succeeding without getting to stage 3.


I do agree, however, that removing the "145" from the device tree was
the right thing to do since software will never see that.  The system
will just shut down.


> - reduced number of trip points to 2
> - lowered temperature of passive trip point

This won't actually do anything until the ADC gets hooked up, right?

I guess I would have expected:
- 105: passive
- 125: critical

...and then we could add (if we wanted) a "hot" between passive and
critical once we have the ADC hooked up?



> - updated trip point names and added labels
> - updated commit message
>
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/q=
com/pm8998.dtsi
> index 2f4989e7ef68..e7caa334e6c7 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -3,6 +3,7 @@
>
>  #include <dt-bindings/spmi/spmi.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  &spmi_bus {
>         pm8998_lsid0: pmic@0 {
> @@ -60,3 +61,27 @@
>                 #size-cells =3D <0>;
>         };
>  };
> +
> +/ {
> +       thermal-zones {
> +               pm8998 {
> +                       polling-delay-passive =3D <250>;
> +                       polling-delay =3D <1000>;
> +
> +                       thermal-sensors =3D <&pm8998_temp>;
> +
> +                       trips {
> +                               pm8998_alert0: pm8998-alert0 {
> +                                       temperature =3D <95000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +                               pm8998_crit: pm8998-crit {
> +                                       temperature =3D <105000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +       };
> +};

A nit, but I think convention is to actually put additions straight to
the root node before reference to phandles, so I would have put this
above the "&spmi_bus" part.
