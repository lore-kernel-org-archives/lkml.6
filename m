Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC88C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8FA21E20
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 00:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RWnjM8VJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8FA21E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeHKCl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 22:41:28 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40221 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeHKCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 22:41:28 -0400
Received: by mail-ua1-f66.google.com with SMTP id m13-v6so3713087uaq.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 17:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WOlSMCycc3/+pGpdrWR976ZTJ1PF+/RE+twQyhlUgTE=;
        b=RWnjM8VJ2hptNOYHNUG958hLQL9xyHdkcv58v4+gza9r/fow8xkuGE/mvLgqtrb6EL
         THHk69yYdc9ITtpZoebdLugw/ObNbOIDGbhGEaJrf+I1OsCUgTb9rtTnN8qSLYQgPNpT
         0xqU4T6Pu7RoqFJFRu37UUAeh2k122OvrcMpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WOlSMCycc3/+pGpdrWR976ZTJ1PF+/RE+twQyhlUgTE=;
        b=Kd6TBe6vOcOE3eRlE/1MVqkPVm3oOVM3jNQcr+pl5ImWx9S16+K/q6tvxZ6f/1Nn3y
         IX36qYNqWDgDdW1zItS4KXcKa+rGeulaqpwVGG1IY6uWmIfza2mRL9jyUjgUXEkr8FsM
         Sv7yP1RSd1ojOEmFz3Xk3qGqz4TuGEjEv7jsLP2AacfzbHON/Unp2tVLKIbtRQOookBl
         uXEl4agA+0uTsrWr7YMTc32OBF//oBnzQQXIaMJp8FIqzriOVy/huC0UThjxMMnYdM9c
         5Yd2bO1JBoxs1MIxnP9jTish2q9F2LzalfckKRNT7255X/adKGBY0l3wKn/J9+ag1E5e
         +PVg==
X-Gm-Message-State: AOUpUlH2I8YzpCQAm16pBRwfENpRFybVnZU5AlH7avE5WB3SBBFxEAON
        pkID7rgmToO5O+1yqV+jqFcSDpD/oJQ=
X-Google-Smtp-Source: AA+uWPyEvs8V4kmYrNSr+6acn1LWbiDuUvSV6v1XdvenEhBGHzEzCjKlfnVNOYYiDX9I71Csfa+BKA==
X-Received: by 2002:a1f:a94b:: with SMTP id s72-v6mr5464109vke.122.1533946160434;
        Fri, 10 Aug 2018 17:09:20 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id b21-v6sm3124417vkb.33.2018.08.10.17.09.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 17:09:18 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id y10-v6so3711506uao.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 17:09:18 -0700 (PDT)
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr5845841uad.82.1533946157850;
 Fri, 10 Aug 2018 17:09:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 17:09:17 -0700 (PDT)
In-Reply-To: <20180808191339.16875-3-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org> <20180808191339.16875-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 17:09:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ug3oiHOLxYRXtr0LbBUyXjBB=92fAYfpfhEQ8Xih6PNA@mail.gmail.com>
Message-ID: <CAD=FV=Ug3oiHOLxYRXtr0LbBUyXjBB=92fAYfpfhEQ8Xih6PNA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: pm8998: Add adc node
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
> This adds the adc node to pm8998 based on the examples in the
> bindings. It also fixes the order of the included headers.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 92bed1e7d4bb..f70f6101bceb 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /* Copyright 2018 Google LLC. */
>
> -#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
>
>  &spmi_bus {
>         pm8998_lsid0: pmic@0 {
> @@ -11,6 +12,16 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> +               pm8998_adc: adc@3100 {
> +                       compatible = "qcom,spmi-adc-rev2";
> +                       reg = <0x3100>;
> +                       interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       #io-channel-cells = <1>;
> +                       io-channel-ranges;
> +               };

I'm a little confused about what the "io-channel-ranges" does here.
The documentation isn't clear at all to me for it.  If I'm reading it
right it's also supposed to be for iio-consumers, but you're using it
in a provider.  I see you copied this from the example.  Maybe the
example is wrong?  ...or I'm just confused...

Other than that question, this looks fine to me.


-Doug
