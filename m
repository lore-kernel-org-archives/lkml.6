Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C90ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD6D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bu3EipF/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iu2IYDHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD6D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbeGTTcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:32:14 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33696 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388128AbeGTTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:32:14 -0400
Received: by mail-ua0-f193.google.com with SMTP id i4-v6so8067901uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dE7Ej/7V+ZxaRbUXM/7mt8dW+W6rnWVcRqwu5/1JAhI=;
        b=bu3EipF/tWl1Cq5rHGXLS9sBgbL8rqK+lmAzPI6cxAYSAwmqla5+XCGGa6gKwBLnxR
         mEkpOw74rQPjgxMjxEqo13b5V8H5UhePBUWDY39RAV4AstWNnN57vmHyh39ZHKuzBVNy
         tpy7TfGUQBCVYXAPcjHG5cZRK39J2+fSv1HovdXa6LbFByG4mUSHPaZL0NxmckQ0Mdkd
         KiVwYPnf+84ZVevg8klma1AXAixSxUQLuqhP4C/RJXm6QiMTWE1CCHbaea1OVIN7bmzc
         Lsrr+KQc55yxJOSUeBDB8+XwO3jSW59MQABYXkAnvNDeLV0qaI4u+AGidRQHPzw/Zngi
         kB6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dE7Ej/7V+ZxaRbUXM/7mt8dW+W6rnWVcRqwu5/1JAhI=;
        b=Iu2IYDHfAKvQks88TiFx81qE0V6DEPwa79UfaJdGna16WDEpvRfNQwaBKsBtF5+j6B
         /EyvkgFqf8A1rfcy4kMOdbtHRg2CyHyFAbXlMUXNZJbgkLoppxAkXivTORZsXRqxX1Cu
         0kMBMySC6Iah90KoFE3MkJ4wbACBFeSMmHq7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dE7Ej/7V+ZxaRbUXM/7mt8dW+W6rnWVcRqwu5/1JAhI=;
        b=BoOLqu9YQRCoHH0/c29wgm7xpfXVVo1LUD1YU1B8x+hUMp2EOomC6EWddBHxQAdyfk
         z+mQdnLdxU5iSjKvzA8GooFIVlL8Ibi5mg/u8N72fD3ockcB7RoKWCUMFifZLNpOQsjd
         hdFoR8OvGnbWSFdygzUR16FXUPDd2SpBKsMyjB6UiKeMV8FL4caIKsjCAxgG1Q0o4MTL
         X3HMQFrH2kUeAEaYWaX3fiVUN3/+XgSoeYCik0T5caPGQpkr8U+ncDio5x8nQqs+F4/E
         A/SNo1CYEDzb+jAoqnKbnSXD/gpct8ok/3pFwXb1WAGibwQhyQaVOCSlQaTxO3lLtwT8
         czaw==
X-Gm-Message-State: AOUpUlGOHPPKfuoTL0Gyaec8DwXeg5GFNULYcL8Awb3GKy1GsRXEXoqB
        KY3GYc4hjhrIc1MHzMrvwbuDIixqI0IEJEHa+O6wMg==
X-Google-Smtp-Source: AAOMgpfogYGhaZfImY6FYF//QT3rZ3LzKx1WE58isonAgf9yEpmlgqpxWxv2Peh4exGlR3CutiU/RiTmt7uJkNszS68=
X-Received: by 2002:a9f:3b69:: with SMTP id j41-v6mr2058916uah.37.1532112161891;
 Fri, 20 Jul 2018 11:42:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 11:42:40 -0700 (PDT)
In-Reply-To: <20180717210815.245639-1-mka@chromium.org>
References: <20180717210815.245639-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Jul 2018 11:42:40 -0700
X-Google-Sender-Auth: N-YYQCgqGYraacwlKVklkmZfXbg
Message-ID: <CAD=FV=V1=P-Vq-VFXDfZGPMTVFvZK5cwaK_-Kxf8MwATJNwQSg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] thermal: qcom-spmi: Allow to disable stage 2 shutdown
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 17, 2018 at 2:08 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> When the temperature reaches stage 2 the PMIC performs by default a
> 'partial shutdown', unless software override is enabled. It is not well
> defined which peripherals are affected by a 'partial shutdown'. Drivers
> might be unhappy when their devices suddenly disappear and prevent an
> orderly shutdown.
>
> Add an optional device tree property that allows to disable stage 2
> shutdown.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v4:
> - patch added to the series
> ---
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt |  3 ++
>  drivers/thermal/qcom-spmi-temp-alarm.c        | 28 +++++++++++++------
>  2 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> index 290ec06fa33a..377c94fa1821 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> @@ -15,6 +15,8 @@ Optional properties:
>  - io-channels:     Should contain IIO channel specifier for the ADC channel,
>                     which report chip die temperature.
>  - io-channel-names: Should contain "thermal".
> +- stage2-shutdown-disabled: boolean to disable a partial shutdown of the PMIC
> +                            when the temperature reaches stage 2

With my understanding of device tree I believe that this should be
"qcom,stage2-shutdown-disabled".  If something isn't a generic
property affecting a whole group of bindings I believe it's supposed
to have a company prefix.

From the device tree specification (wow, this exists now?  ...and is public?)

https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.2

I find:

> Nonstandard property names should specify a unique string prefix, such
> as a stock ticker symbol, identifying the name of the company or
> organization that defined the property. Examples:
  fsl,channel-fifo-len
  ibm,ppc-interrupt-server#s
  linux,network-index

=====

I would also perhaps add a bit more verbose justification to your
description of this property.  Specifically there should be some
indication in the bindings doc of when you'd want this property.  From
what David Collins said, I'd maybe write something like:

---

You want to disable the partial "stage 2" shutdown any time you've
properly defined thermal zones in such a way that the OS will try to
shut down at that stage anyway.  Said another way, there are three
thermal stages defined in the PMIC:

stage 1: warning
stage 2: system should shut down
stage 3: emergency shut down

By default the PMIC assumes that the OS isn't doing anything and thus
at stage 2 it does the partial PMIC shutdown and at stage 3 it kills
all power.  If we have thermal zones defined such that the OS will
initiate the shutdown at stage 2 then we want to disable the PMIC's
automatic mode for stage 2.  That still leaves us with the emergency
at stage 3.

===

Actually, after writing all the above I wonder if perhaps there's a
way to do this all automatically.  AKA: if someone has specified a
"critical" level can we automatically disable the partial PMIC
shutdown and we don't need the extra property?  Bonus points if we can
check to see if the thermal zones defined actually match reality and
even more bonus points if you can automatically adjust the settings in
the PMIC based on the thermal zones...

I did find that in "struct thermal_zone_of_device_ops" there appears
to be a "set_trip_temp" function you can fill in.  When I tried that
quickly I saw that I got called when I echoed into
"/sys/class/thermal/thermal_zone0/trip_point_1_temp" but not at
bootup, but I didn't debug more than that...


>  Example:
>
> @@ -23,6 +25,7 @@ Example:
>                 reg = <0x2400 0x100>;
>                 interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
>                 #thermal-sensor-cells = <0>;
> +               stage2-shutdown-disabled;
>
>                 io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
>                 io-channel-names = "thermal";

BTW: can you update the "example" in this file?  Based on the PMIC
docs I saw it's likely that it should be:

stage1 {
  temperature = <1050000>;
  hysteresis = <2000>;
  type = "passive";
};
stage2 {
  temperature = <125000>;
  hysteresis = <2000>;
  type = "critical";
};

...and I guess we don't specify the final one because by that time
Linux is kaput.


> diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
> index ad4f3a8d6560..acbb0dbec79e 100644
> --- a/drivers/thermal/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom-spmi-temp-alarm.c

Sometimes people like bindings and code change to be separate patches.
Maintainer can specify what's desired in this case, but I find it
generally pleases more people to make them separate.

...though I guess if we can figure out how to do this automatically we
will have no bindings change...


-Doug
