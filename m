Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D1EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E635026EF5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtPOmCwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E635026EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934045AbeFZSXK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933164AbeFZSXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:23:08 -0400
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com [209.85.223.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8156926EF5;
        Tue, 26 Jun 2018 18:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530037387;
        bh=M/uwk1NjIHmdVTVAVug6c00vYgYTUz3rkOv8B3ojfJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NtPOmCwLRfvuZ6jejKy8BywKwXwhHMXn0lhfxe2zEohzae1PM2jJq3ebRJksi3ah9
         fvYTN3f+9gykrj6OP0QJJbGMoOC+0E0CS329jO4GqPZfRIX46nsQgR64QOVem9JZmJ
         tu6N95UH5LLzXCnrNmzZl6eX6Jdo7HM0rFtBVMeU=
Received: by mail-io0-f176.google.com with SMTP id g7-v6so16831815ioh.11;
        Tue, 26 Jun 2018 11:23:07 -0700 (PDT)
X-Gm-Message-State: APt69E1QJmK5nbLUko18O/oq5wu4vLqRG4lKLqd1svvab/gQly4AgNiT
        44kTzW7/gRa9bHuIOf4iDsOhedZuG+rJohuMww==
X-Google-Smtp-Source: AAOMgpeozJwOs7nCWcpwdXQsKlgObz30RHhfTNVFj+QYzoCOVoOTmic07kYliOXVX/5cjmTtpImT5YYtbrPLSXd5Lgc=
X-Received: by 2002:a5e:c90e:: with SMTP id z14-v6mr63047iol.268.1530037386934;
 Tue, 26 Jun 2018 11:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180626164701.1034-1-robert.jarzmik@free.fr>
In-Reply-To: <20180626164701.1034-1-robert.jarzmik@free.fr>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Jun 2018 12:22:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLo5ntGLLZzssCJo7g--WWvgZLkX0vTV0VOT7a5H0QLFg@mail.gmail.com>
Message-ID: <CAL_JsqLo5ntGLLZzssCJo7g--WWvgZLkX0vTV0VOT7a5H0QLFg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: pxa: fix the rtc controller
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:47 AM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> The RTC controller is fed by an external fixed 32kHz clock. Yet the
> driver wants to acquire this clock, even though it doesn't make any use
> of it, ie. doesn't get the rate to make calculation.
>
> Therefore, add the dummy clock in the PXA clock tree to make the driver
> happy and working.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/boot/dts/pxa25x.dtsi | 4 ++++
>  arch/arm/boot/dts/pxa27x.dtsi | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
> index 95d59be97213..c6ca07e4626b 100644
> --- a/arch/arm/boot/dts/pxa25x.dtsi
> +++ b/arch/arm/boot/dts/pxa25x.dtsi
> @@ -80,6 +80,10 @@
>                         #pwm-cells = <1>;
>                         clocks = <&clks CLK_PWM1>;
>                 };
> +
> +               rtc@40900000 {
> +                       clocks = <&clks CLK_NONE>;

Don't add fake clocks. Either add a real clock or fix the driver to
not require a clock.

Rob
