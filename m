Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A190C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4071B21E20
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aETVaHkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4071B21E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeHKCmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 22:42:32 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33606 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeHKCmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 22:42:31 -0400
Received: by mail-ua1-f68.google.com with SMTP id i4-v6so3709567uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dBcOzPxgsDsgY/0J292gIancZF+R+JOXoOwlFmL7Dns=;
        b=aETVaHkX+YaTloHCYF0gH2KDx/MF6bAIqtJqGiD7cNyvxmS8W2AwVEoT+r2L2ueFek
         y3KDDKn8Mfsc/yk/pkTNW3B8U8ybjLu9GMTudpU8rS33wiawyExYChb6ndYctL3TphgV
         YZyMawebFEhMyjhXWYhqJYkaAHcIEiI7kykYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dBcOzPxgsDsgY/0J292gIancZF+R+JOXoOwlFmL7Dns=;
        b=MJAxQM5Fd/DKWzdqmH0ExBZmZevlZ+zSoDNItnC90Y9v/lFQ3O82mFHMW1k06ZL/Ef
         nSk4DtG92bWQPXUKV3YOqRub1lL47siUly39gUqjXRZSpnRPfqOIuYIgRSex0rHTeoHq
         qwvIK9Ra40HYoD5Tdx3szwBa5AtG/tG3cuTmFLdgW47MCzEAR4bR3cwPIdwdGVOAl4np
         K7BvOv0Kd9ymlo+VeDYoPgZwnK6X5GRJDOThM/oqT+LRfP+J1ePhzS0y+WVmaD425Bs2
         0dozXOx9cd0wYs6qOkRre8vnyBlJRe9/L/cvrYfa1JW093AIVkZuqHWGmQiHm7RqrPqi
         3eQQ==
X-Gm-Message-State: AOUpUlGUWPLHtTCn0DWhqgdZdCgcmjbaDAktSgTGPJ7fdUEUyWf56Ozy
        FLA4d0HW+PFmnXJ53mtWp9d03WSDf9Q=
X-Google-Smtp-Source: AA+uWPx+xCqwomz4NIO1LIj2rruFX/f3Z8kWBHcNLvXpx8iI9PQOxqzLlwn2oYhmv96TiGemvbx91w==
X-Received: by 2002:ab0:80e:: with SMTP id a14-v6mr5981521uaf.114.1533946223992;
        Fri, 10 Aug 2018 17:10:23 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id q19-v6sm1682258uap.13.2018.08.10.17.10.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 17:10:23 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id m13-v6so3714801uaq.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 17:10:23 -0700 (PDT)
X-Received: by 2002:a1f:854d:: with SMTP id h74-v6mr5402051vkd.69.1533946223061;
 Fri, 10 Aug 2018 17:10:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:de84:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 17:10:22
 -0700 (PDT)
In-Reply-To: <20180808191339.16875-4-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org> <20180808191339.16875-4-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 17:10:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VOhqHTnxJaF5d+qLYyy=QARQq+Y8Q+Oxyyqacnnt-grQ@mail.gmail.com>
Message-ID: <CAD=FV=VOhqHTnxJaF5d+qLYyy=QARQq+Y8Q+Oxyyqacnnt-grQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add die temperature channel
 node to the ADC
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 8, 2018 at 12:13 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> Add a channel node for the die temperature to the ADC.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index f70f6101bceb..499bae0afb7f 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -20,6 +20,11 @@
>                         #size-cells = <0>;
>                         #io-channel-cells = <1>;
>                         io-channel-ranges;
> +
> +                       die-temp {
> +                               reg = <ADC5_DIE_TEMP>;
> +                               label = "die_temp";
> +                       };

Seems to match the binding.

I'm no expert, but FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
