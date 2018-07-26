Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD90C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5593220671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="nWOrE+n1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUlzFu+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5593220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbeGZLco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:32:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46611 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbeGZLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:32:43 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so1969756oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0m99Tm2vqHZakujjs4KkP+46MZPswUMdgw751HQKfCM=;
        b=nWOrE+n1cXQgCmvQbG26vehKZVxcahJDjg3Ha417slJZuils/KpQ2hHNeUOsY4YHNF
         QuqINOqRYskeIdGcCJLr7VV1YlQV+78ztnRnq5q7uBca3cgJasEx+gXADdSuK1M79aRr
         DGaF2cKu71BOrwK2V1Xxo+uWYfGQ2WVdSgav2yaM+g7c0xC2QynOo0R9enSnBvEu8JW2
         /1UPFx6FTbSAbGNz+dRJos+nysTRZ7Wl7zvmjDJxfdWTefjWc91eyjYGw1tQfWf0fcs9
         cvn963j0AGQCsrmeOVcDRNJ+NIUcYF6gLtSc3VpFq92RlYjC7gCJtQsGJ24qXZyPtCTc
         BTkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0m99Tm2vqHZakujjs4KkP+46MZPswUMdgw751HQKfCM=;
        b=aUlzFu+5BM38ONYVlDai2wwN1+ih+yOxs8MsWW9sC5ucx+8JcfMieX8yhws2v6iu0C
         2UvLlzT6MsEA0ggykNsyKuHnsenuDxaFbWyzDSi/gKU7ofCXI8N53LeiL9cFN9k+eBHn
         6yh/gcMpXXD94PV/o4cABtlh5wAhk04gG8bbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0m99Tm2vqHZakujjs4KkP+46MZPswUMdgw751HQKfCM=;
        b=W+pWIoENyJH3xQ2B807YyuitMNTasF/EA1m9DM+aM72uvBBxMPpIyD0wX4PhYVDRtj
         dcdtSPL6QwINK+vkMiOci/EXqy9Rm1E9kAGP2Tf/AAU72pctetGs76hePbWAql9fsGwk
         fQNucCoki/hLTgFGujtKk/tr19O34uAAPQZje15aDHnMdXKnlrQuBxlweDVA5D3MPuxp
         RS929c2qHfD5OzYpK2Ciww1dIkDQHp3h+nVygzQd7nENbLedNF+Cjh8K/UdGBelilCFW
         rTRbmcvbL7uflFJtNhcPISmvkGk3rXOTEUC/D225Z012RXyvdwmvTbgRGb/NfzZEIfYQ
         xrtw==
X-Gm-Message-State: AOUpUlE3pStCIV22bGgnfCFYWqd4LUAsogIIJCU3RWFjBUUs1XMrH4wO
        TmKLywD3r5t1oSIe6QzrHcjaio1sKUySh5w8I7ePrw==
X-Google-Smtp-Source: AAOMgpeVHhciThkVE96/OC2ZeX1OE1//+DBwm3inQWhE2jufvtsIjF6171Z6pvVRDeicBe2wZbv6wTpvBg5lP9nRV+E=
X-Received: by 2002:aca:d44a:: with SMTP id l71-v6mr1326665oig.199.1532600193649;
 Thu, 26 Jul 2018 03:16:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 03:16:32
 -0700 (PDT)
In-Reply-To: <20180726004738.GU129942@google.com>
References: <cover.1531899325.git.amit.kucheria@linaro.org>
 <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
 <20180726004738.GU129942@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 26 Jul 2018 15:46:32 +0530
X-Google-Sender-Auth: uIKg5Z5in7lFeAttWgRbTWyRohA
Message-ID: <CAHLCerNc1J_W6as4AZsRvwdvgf-ovc17qPWNhj9J6CK8xJtkLg@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: sdm845: enable tsens thermal zones
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 6:17 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> Hi Amit,
>
> On Wed, Jul 18, 2018 at 01:19:17PM +0530, Amit Kucheria wrote:
>> One thermal zone per cpu is defined
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 170 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 170 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 01ff146..a75be7c 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -340,4 +340,174 @@
>>                       };
>>               };
>>       };
>> +
>> +     thermal-zones {
>> +             cpu0-thermal {
>> +                     polling-delay-passive = <250>;
>> +                     polling-delay = <1000>;
>
> In the context of the TSENS patches you mentioned that you are working
> on interrupt support. Can the polling delays be removed once that is merged?

Yes, that'd be the idea.

>
>> +                     thermal-sensors = <&tsens0 1>;
>> +
>> +                     trips {
>> +                             cpu_alert0: trip0 {
>> +                                     temperature = <75000>;
>> +                                     hysteresis = <2000>;
>> +                                     type = "passive";
>> +                             };
>> +
>> +                             cpu_crit0: trip1 {
>> +                                     temperature = <110000>;
>> +                                     hysteresis = <1000>;
>> +                                     type = "critical";
>> +                             };
>> +                     };
>> +             };
>> +
>> +             cpu1-thermal {
>> +                     polling-delay-passive = <250>;
>> +                     polling-delay = <1000>;
>> +
>> +                     thermal-sensors = <&tsens0 2>;
>> +
>> +                     trips {
>> +                             cpu_alert1: trip0 {
>> +                                     temperature = <75000>;
>> +                                     hysteresis = <2000>;
>> +                                     type = "passive";
>> +                             };
>> +
>> +                             cpu_crit1: trip1 {
>> +                                     temperature = <110000>;
>> +                                     hysteresis = <1000>;
>> +                                     type = "critical";
>> +                             };
>> +                     };
>> +             };
>> +
>> +             cpu2-thermal {
>> +                     polling-delay-passive = <250>;
>> +                     polling-delay = <1000>;
>> +
>> +                     thermal-sensors = <&tsens0 3>;
>> +
>> +                     trips {
>> +                             cpu_alert2: trip0 {
>> +                                     temperature = <75000>;
>> +                                     hysteresis = <2000>;
>> +                                     type = "passive";
>> +                             };
>> +
>> +                             cpu_crit2: trip1 {
>> +                                     temperature = <110000>;
>> +                                     hysteresis = <1000>;
>> +                                     type = "critical";
>> +                             };
>> +                     };
>> +             };
>> +
>> +             cpu3-thermal {
>> +                     polling-delay-passive = <250>;
>> +                     polling-delay = <1000>;
>> +
>> +                     thermal-sensors = <&tsens0 4>;
>> +
>> +                     trips {
>> +                             cpu_alert3: trip0 {
>> +                                     temperature = <75000>;
>> +                                     hysteresis = <2000>;
>> +                                     type = "passive";
>> +                             };
>> +
>> +                             cpu_crit3: trip1 {
>> +                                     temperature = <110000>;
>> +                                     hysteresis = <1000>;
>> +                                     type = "critical";
>> +                             };
>> +                     };
>> +             };
>> +
>> +             cpu4-thermal {
>> +                     polling-delay-passive = <250>;
>> +                     polling-delay = <1000>;
>> +
>> +                     thermal-sensors = <&tsens0 7>;
>> +
>> +                     trips {
>> +                             cpu_alert4: trip0 {
>> +                                     temperature = <75000>;
>> +                                     hysteresis = <2000>;
>> +                                     type = "passive";
>> +                             };
>> +
>> +                             cpu_crit4: trip1 {
>> +                                     temperature = <110000>;
>> +                                     hysteresis = <1000>;
>> +                                     type = "critical";
>> +                             };
>> +                     };
>> +             };
>> +
>> +             cpu5-thermal {
>> +                     polling-delay-passive = <250>;
>> +                     polling-delay = <1000>;
>> +
>> +                     thermal-sensors = <&tsens0 8>;
>> +
>> +                     trips {
>> +                             cpu_alert5: trip0 {
>> +                                     temperature = <75000>;
>> +                                     hysteresis = <2000>;
>> +                                     type = "passive";
>> +                             };
>> +
>> +                             cpu_crit5: trip1 {
>> +                                     temperature = <110000>;
>> +                                     hysteresis = <1000>;
>> +                                     type = "critical";
>> +                             };
>> +                     };
>> +             };
>> +
>> +             cpu6-thermal {
>> +                     polling-delay-passive = <250>;
>> +                     polling-delay = <1000>;
>> +
>> +                     thermal-sensors = <&tsens0 9>;
>> +
>> +                     trips {
>> +                             cpu_alert6: trip0 {
>> +                                     temperature = <75000>;
>> +                                     hysteresis = <2000>;
>> +                                     type = "passive";
>> +                             };
>> +
>> +                             cpu_crit6: trip1 {
>> +                                     temperature = <110000>;
>> +                                     hysteresis = <1000>;
>> +                                     type = "critical";
>> +                             };
>> +                     };
>> +             };
>> +
>> +             cpu7-thermal {
>> +                     polling-delay-passive = <250>;
>> +                     polling-delay = <1000>;
>> +
>> +                     thermal-sensors = <&tsens0 10>;
>> +
>> +                     trips {
>> +                             cpu_alert7: trip0 {
>> +                                     temperature = <75000>;
>> +                                     hysteresis = <2000>;
>> +                                     type = "passive";
>> +                             };
>> +
>> +                             cpu_crit7: trip1 {
>> +                                     temperature = <110000>;
>> +                                     hysteresis = <1000>;
>> +                                     type = "critical";
>> +                             };
>> +                     };
>
> Dumb DT question: the trip information is the same for all CPUs. Would
> it be possible to have a single node and refer to it with a phandle?

There is some work to do that for cooling maps, not for the actual
trip points though:
https://lore.kernel.org/lkml/cover.1530766981.git.viresh.kumar@linaro.org/T/#u

> I suppose the anwer is no and even if it was possible we probably
> wouldn't want it, since it would complicate overriding settings for a
> specific CPU (should that ever be needed ...) or cluster. Just wondering.
>
>> +             };
>> +     };
>>  };
>
> I don't have documentation to verify that the sensors and CPUs match,
> but it is in line with what I've seen in some Android tree, so it
> seems alright ;-)
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Thanks Matthias.

Regards,
Amit
