Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23494C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68952133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HjzXrJtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68952133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeLEVTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:19:04 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43617 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEVTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:19:03 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so12980470vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKntb6jWYnnYGxZxcPUupv3wWwNM1eoyjl1rlXxYI6c=;
        b=HjzXrJtPYCk1Q9UW8YjHx6oZxd7CGjR94OuNKt8Zzl0i2YxubKCcDXxhyirfIBvxl2
         iHAZ3eDZMym56Oq6Cmw4lKIxc2UnxeDio1zvrCkZz5/FeW9MCcOY6bSxz3BoifI5EmGR
         3Z45tz8kGKWcVkqaof5fsJkrRLYz7fYwW+7WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKntb6jWYnnYGxZxcPUupv3wWwNM1eoyjl1rlXxYI6c=;
        b=dBbG4sgQFFi5Nbi5W7iZLPwaY2/mpzoh4zu3hkSj57BAOkqtNM0ujc2y8QXqO7GOna
         2Zk3XXCZLgAoNIt9wCOcU96ePifgz5FdE2WsDNyuw40JKE+4XpuMU/Zq6bwL9Wft9FCG
         kCgO1coCgYu83/NMPz//C/SwNGWvZHHydYNwHP8swPRHBVTeoFb4n+MTvR852X9Zjqix
         S3ApJ/AcETOkn+k0+1soV87u+VZuQtM5a9k3XfeNMy76LIpa5MOTi4LuzahoRkTcfEnm
         u8sUQG/rDiMder8+fEef222n6ndQoVvJ5oR1LuxxE+e+5zixPz+DeC6HJ3J6KTJTTEAm
         h59g==
X-Gm-Message-State: AA+aEWZhHUyQ/BTC7y/HBLDR95040bJQzwtce35/STBp1AaWtjWpihny
        3vR8PyHwHPGn9w1FlTAmH1xGjDRX5p0=
X-Google-Smtp-Source: AFSGD/UQxBHw8BTkvsLbvXzvmDwFH0X87jRSc89lkmI/vDeGujBqDi1Ao5O0HFN4V8b+zSi7BfuA+w==
X-Received: by 2002:a67:bc06:: with SMTP id t6mr11868366vsn.70.1544044742028;
        Wed, 05 Dec 2018 13:19:02 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id j25sm10111937uag.8.2018.12.05.13.19.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:19:01 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id h78so13007596vsi.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:19:00 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr10226108vsv.20.1544044740418;
 Wed, 05 Dec 2018 13:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20181128223428.177313-1-evgreen@chromium.org> <20181128223428.177313-4-evgreen@chromium.org>
In-Reply-To: <20181128223428.177313-4-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Dec 2018 13:18:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VtKpbL3-Wt8ctcmTG0_-YzgEv3xXZGd8xV=RsgAhof1A@mail.gmail.com>
Message-ID: <CAD=FV=VtKpbL3-Wt8ctcmTG0_-YzgEv3xXZGd8xV=RsgAhof1A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 28, 2018 at 2:34 PM Evan Green <evgreen@chromium.org> wrote:
> +&sdhc_2 {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data &sd_cd_odl>;
> +
> +       vmmc-supply = <&vreg_l21a_2p95>;
> +       vqmmc-supply = <&vddpx_2>;
> +
> +       cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
> +};
> +
>  &qupv3_id_1 {

Please sort alphabetically.  "s" comes after "q".


> +       /* It seems that mmc_test reports errors if drive strength is not 16. */

Possibly put this comment right next to one of the the "drive-strength" lines?


> +       sd_cd_odl: sd-cd-odl {

"sd_cd_odl" is the name on a different board.  On sdm845 this is
'sd_card_det_n", so it'd be better to use that name.


> +               pinmux {
> +                       pins = "gpio126";
> +                       function = "gpio";
> +               };
> +
> +               pinconf {
> +                       pins = "gpio126";
> +                       bias-pull-up;
> +                       drive-strength = <2>;

Maybe leave this off?  According to Bjorn's research "drive-strength"
has no affect on inputs and this is most certainly an input.

-Doug
