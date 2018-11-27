Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9485FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5771F20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L7oOyrgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5771F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeK0LcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:32:06 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41888 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeK0LcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:32:06 -0500
Received: by mail-vk1-f196.google.com with SMTP id t127so4644361vke.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uocru8YNlXjDg4tMK+cyR2KXVJ22a1eJncYGvv17luA=;
        b=L7oOyrgUu4+JFDVrcMxgHSy19UbDynexrue5PUZUp+gd4j/uC4z6uqIXd9A39OZF3v
         Hw5wur4CT5qxUb4Np/n4w7sEOH2pFGDxvOuNwegEU7iexPjfIuVM3kJ7BLecIZ5+dzGZ
         llXp3t7Dlq3P+vLvmtngGNfxZvBu4nrelN2dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uocru8YNlXjDg4tMK+cyR2KXVJ22a1eJncYGvv17luA=;
        b=qUyShK+aklV6iDRjnHLsU8XxSuXOWWl6MI8JWLJ/2uAzk/FMY9vGouD+4irvruJ4ff
         KS94Xv3E+YCk4Ok1BwWDosq/aEdoKHekA29eEBad/mVbW2v2X1kBN6zyUdMwMTmtaH8G
         4mZR595qHHFW5FLYP8J63oJ0tQ/7QblIfe90nyK/jgxrCkiHTruqQecC8Hm16E4iO0oH
         wDqzRuRNtOvYn8DU3XeDFtZ2X1Pu2GN9YwwQwsPm5DkvcT+IKTAn+/RlRMTqWMK5QJuK
         yvXCWJzS9v1mH6/WgCKruLbz3FNlDs6ujDjO+nOEBmc+qFzI1vV7ZESjx/QzVsfjO6uT
         Kyeg==
X-Gm-Message-State: AA+aEWZ23Vktkw6Q6CcxKQ9aIJqR/a/6ygtqKwyLcV7A2qyPp5D8wveq
        RGWuZmlRFG9m9sVrWtoRIr7yYNDI804=
X-Google-Smtp-Source: AFSGD/U2C2YL4Jq6+Rwg7DSf+TRJKu8L/onqQwgp0Igm3nlcQ795sMC4t+AwfPYLjFqwxF2UZ/GawA==
X-Received: by 2002:a1f:5941:: with SMTP id n62mr12505319vkb.14.1543278965490;
        Mon, 26 Nov 2018 16:36:05 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id g195sm921571vka.5.2018.11.26.16.36.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 16:36:04 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id g68so12638351vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:36:04 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr11492552vsv.20.1543278963545;
 Mon, 26 Nov 2018 16:36:03 -0800 (PST)
MIME-Version: 1.0
References: <1541414117-27864-1-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1541414117-27864-1-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Nov 2018 16:35:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X3C=oKep1kPWjasLDZdFKfhCs0JMWTOensgYDj=apvuQ@mail.gmail.com>
Message-ID: <CAD=FV=X3C=oKep1kPWjasLDZdFKfhCs0JMWTOensgYDj=apvuQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add videocc node
To:     Taniya Das <tdas@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 5, 2018 at 2:35 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> This adds the video clock controller node to sdm845 based on the examples
> in the bindings.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0..91a281b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,videocc-sdm845.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> @@ -1256,6 +1257,13 @@
>                         #power-domain-cells = <1>;
>                 };
>
> +               videocc: clock-controller@ab00000 {
> +                       compatible = "qcom,sdm845-videocc";
> +                       reg = <0xab00000 0x10000>;
> +                       #clock-cells = <1>;
> +                       #power-domain-cells = <1>;

Any reason not to include "#reset-cells = <1>;" here?  The bindings
list it as optional but I see no reason why we should leave it off.
The file "include/dt-bindings/clock/qcom,videocc-sdm845.h" seems to
include some #defines for resets.  Even though the driver doesn't seem
like it supports it yet, it still should be fine to list it here.


> +               };
> +
>                 tsens0: thermal-sensor@c263000 {

Please sort your new node by unit address.  Specifically "ab00000"
comes before "af00000", thus I would expect you to have your node
right before the dispcc.


-Doug
