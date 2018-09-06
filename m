Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66B1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8918D2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOOPOYfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8918D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbeIFXLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:11:20 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39081 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIFXLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:11:19 -0400
Received: by mail-ua1-f66.google.com with SMTP id g18-v6so9822930uam.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kaOl//CCJ6TM2qLUZQtDDpU/llgYGkt3l6Xkuf1eeQ4=;
        b=lOOPOYfPzhu4EtaFAzi+hmcAxCqZPPv4/9qLMaytJvep6gIGHgCxNq/3m6/Dcvwf5E
         KTvZxvR4fjwKu99paR3VbwRM7mYNoEbGxWPfrzjM1WJ4zvEuhTdkYJveiaPWqqZvWysg
         ocabv+Ws49/jznMmf9RQ8RzjxaZJU6WitiNHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kaOl//CCJ6TM2qLUZQtDDpU/llgYGkt3l6Xkuf1eeQ4=;
        b=k8flSYXVV9xVTxMYd1X8APqvo9faM/s1bNceC9pqkNyWgucN3GZEejL8eov3ri/qI/
         lH/Okp8Nd6Qcwg0sFBJSeopBe/VP+rLSU21wAMLtq+L3Rz1+C8TnQLLq/AOy58kdZXhp
         78kN4xPSkUo8XEoOmSMfML6rFrLARsutCs3cUs/2W/nIdsMGwXUrnhcsAXbk3+V31QMA
         M9wN5YY03QNpGhJJoyODIDgvQmDYE5BkNrFKBbnctIVDIjxvtNL64b/y9t32aJzeHl18
         Lrl1SbLTsK/ErtpbIbAzrw8VZ05w1jSTXypDYXAI1KOnKe9/jDGrvjXbPPpabh8nUWXm
         7hZg==
X-Gm-Message-State: APzg51BczFbxhlG4kJMLgWOss3xu73S3M5+XLr/zznU8vcjGlmK3Qs1H
        UplPqXR5noFom0KOmhHbyuCreuV7Nrs=
X-Google-Smtp-Source: ANB0VdY6CLgmizNA08yhVAdEIKFVt+g0TLgtGjdGJtyY+PByORnoo7dVtPzs4LM0W8m0wW3sYK3rUA==
X-Received: by 2002:a9f:3b69:: with SMTP id j41-v6mr1563678uah.37.1536258875498;
        Thu, 06 Sep 2018 11:34:35 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id g86-v6sm1804614vkc.36.2018.09.06.11.34.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 11:34:34 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id 101-v6so9802776uav.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 11:34:34 -0700 (PDT)
X-Received: by 2002:a1f:ebc7:: with SMTP id j190-v6mr1419244vkh.114.1536258873515;
 Thu, 06 Sep 2018 11:34:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 11:34:32 -0700 (PDT)
In-Reply-To: <20180827171003.GU160295@google.com>
References: <20180808191339.16875-1-mka@chromium.org> <20180808191339.16875-3-mka@chromium.org>
 <CAD=FV=Ug3oiHOLxYRXtr0LbBUyXjBB=92fAYfpfhEQ8Xih6PNA@mail.gmail.com> <20180827171003.GU160295@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Sep 2018 11:34:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vvhjcs9UwLkyHJ+nxwRCk70SBC3eVxBXwK7DFcPeu8wQ@mail.gmail.com>
Message-ID: <CAD=FV=Vvhjcs9UwLkyHJ+nxwRCk70SBC3eVxBXwK7DFcPeu8wQ@mail.gmail.com>
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
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 27, 2018 at 10:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Fri, Aug 10, 2018 at 05:09:17PM -0700, Doug Anderson wrote:
>> Hi,
>>
>> On Wed, Aug 8, 2018 at 12:13 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>> > This adds the adc node to pm8998 based on the examples in the
>> > bindings. It also fixes the order of the included headers.
>> >
>> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> > ---
>> >  arch/arm64/boot/dts/qcom/pm8998.dtsi | 13 ++++++++++++-
>> >  1 file changed, 12 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> > index 92bed1e7d4bb..f70f6101bceb 100644
>> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> > @@ -1,8 +1,9 @@
>> >  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> >  /* Copyright 2018 Google LLC. */
>> >
>> > -#include <dt-bindings/spmi/spmi.h>
>> > +#include <dt-bindings/iio/qcom,spmi-vadc.h>
>> >  #include <dt-bindings/interrupt-controller/irq.h>
>> > +#include <dt-bindings/spmi/spmi.h>
>> >
>> >  &spmi_bus {
>> >         pm8998_lsid0: pmic@0 {
>> > @@ -11,6 +12,16 @@
>> >                 #address-cells = <1>;
>> >                 #size-cells = <0>;
>> >
>> > +               pm8998_adc: adc@3100 {
>> > +                       compatible = "qcom,spmi-adc-rev2";
>> > +                       reg = <0x3100>;
>> > +                       interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>> > +                       #address-cells = <1>;
>> > +                       #size-cells = <0>;
>> > +                       #io-channel-cells = <1>;
>> > +                       io-channel-ranges;
>> > +               };
>>
>> I'm a little confused about what the "io-channel-ranges" does here.
>> The documentation isn't clear at all to me for it.  If I'm reading it
>> right it's also supposed to be for iio-consumers, but you're using it
>> in a provider.  I see you copied this from the example.  Maybe the
>> example is wrong?  ...or I'm just confused...
>
> Yes, I copied it from the example, its use here is also not clear to
> me, other ADC providers like adc@126c0000 in exynos3250.dtsi or
> adc@180a6000 in bcm-cygnus.dtsi also specify it ...
>
> Siddartha/Jonathan, could you help to clarify if "io-channel-ranges"
> should really be specified here as the DT example suggests?

Does everything work if you just remove the "io-channel-ranges"?  We
could remove it and always add it back in later if someone could
explain what it's for or if we find a reason why it was needed?  ...or
we have any other ideas for how to get this resolved?  :(

-Doug
