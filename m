Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8392C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794DF2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="nmpUUcO3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKtxG6LK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794DF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeH1T3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:29:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37855 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeH1T3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:29:18 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so3633657oic.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R65JaroNyOP8yMoYYXXJFKYU+i9kCWsnfydN48y4BzY=;
        b=nmpUUcO31mj5XWM5QwcsDWS200oqjBu1rhIyjeoJ1sYb2Y+8+Bzx8JNZwKlfF11O+z
         A3xM98MrDipXAqzCe0mBs4fl/qnGCF6XLzpCLiUyo4B78l8BmTtxeMVRwiWrTmf/Wuj0
         RxticIav8p8V6LOerP8jYRHxuMvjYUTEPwlAFvxO7o/lveyOdRCELX1E243Er0Bim1GF
         bo1oiVSGhNlHaoftj5lI71Q86waRPR7N6tXUYBhEZz8ra91BKZ8fnGq9M/JT5BFwYqaL
         6+JFDk/U28U9Vm/SFFDsQ3tNi6iVo59lRxBrFsWS1m331R4I5Jc3cScdAYfZn0UEeMWX
         s00g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R65JaroNyOP8yMoYYXXJFKYU+i9kCWsnfydN48y4BzY=;
        b=VKtxG6LKzuLaBpxHPnbcXv988SUWLW67cqksOMjTL1YYphbR3Lir87ISdcJ5F9Fpnb
         xx8NHRP8/kJaCnPH684VSXSjdMg+1lOSH5eIVk3Y3xyWrjJuOw9q0fYV6jJ19sX9dpPO
         YrgppvzqXxr+wKYIMslZ5p7yrPGv3NS8qeWQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=R65JaroNyOP8yMoYYXXJFKYU+i9kCWsnfydN48y4BzY=;
        b=DYVohvGNH3TQmZ33ezukMpvjiSMusJMUt6l97Dx0JIwpHN1mXvR6wR5yLVt7RgXbag
         DXw7C11lOaLu0VMdsL5xzMrHXSPGmJQzdpg+Hxno3PsmoJ8CIFcu07wYcJOnLalAMNzj
         ILuqEkAkuZ8DBUUbTNjdja0u6EEAMYnKYHa+TZAymvX99AlB9IU+xn8slh2e3HjQ3S65
         UaUNzmhzClPT/KUHBTQo0u3h11hU5MooVdba1ULZyt/jbbDmTUBol0PBbBlzk7BsLaXL
         O0xR8l2woR75SnGY0UUQ/yY+e4vjRCN0ZxCB0bjmWfAhIA+eAWp0GkmhD59fTtHWo/W9
         LKyA==
X-Gm-Message-State: APzg51BUAhph+eVhSbIqnbb/wkTs/PCvDjgpBPFxY6/hW35L8czfl1pv
        g1NXyvi0Y2KY/2mYnIaZZxDVKeHHrNGid8+ADplr0Q==
X-Google-Smtp-Source: ANB0VdZ2sSReV55BWcjZHEH/JMD6CWDW7kLfGtTUhbJnPEWfP4fdAnsVr5kqMk6V05q9mpeEtYXX4qWDHJyQjaEck4s=
X-Received: by 2002:aca:b154:: with SMTP id a81-v6mr1852845oif.34.1535470624767;
 Tue, 28 Aug 2018 08:37:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:190f:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 08:37:03
 -0700 (PDT)
In-Reply-To: <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
References: <cover.1531899325.git.amit.kucheria@linaro.org> <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 28 Aug 2018 21:07:03 +0530
X-Google-Sender-Auth: uzcXCjozpfslP84PNcvrD2xvhbU
Message-ID: <CAHLCerOxDvueVoCn7H197x01-kJ2C7C+hNqYT5T1yCNHJAioTQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: sdm845: enable tsens thermal zones
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

Do you have any feedback for this patch?

Regards,
Amit

On Wed, Jul 18, 2018 at 1:19 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> One thermal zone per cpu is defined
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 170 +++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 01ff146..a75be7c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -340,4 +340,174 @@
>                         };
>                 };
>         };
> +
> +       thermal-zones {
> +               cpu0-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 1>;
> +
> +                       trips {
> +                               cpu_alert0: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit0: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu1-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 2>;
> +
> +                       trips {
> +                               cpu_alert1: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit1: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu2-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 3>;
> +
> +                       trips {
> +                               cpu_alert2: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit2: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu3-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 4>;
> +
> +                       trips {
> +                               cpu_alert3: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit3: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu4-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 7>;
> +
> +                       trips {
> +                               cpu_alert4: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit4: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu5-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 8>;
> +
> +                       trips {
> +                               cpu_alert5: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit5: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu6-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 9>;
> +
> +                       trips {
> +                               cpu_alert6: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit6: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cpu7-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&tsens0 10>;
> +
> +                       trips {
> +                               cpu_alert7: trip0 {
> +                                       temperature = <75000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cpu_crit7: trip1 {
> +                                       temperature = <110000>;
> +                                       hysteresis = <1000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +       };
>  };
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
