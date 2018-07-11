Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA253C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0A82145D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="flGcOmFh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCk1KgZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0A82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390619AbeGKWCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:02:50 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44534 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbeGKWCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:02:50 -0400
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so15269770vke.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RmVN5RQsg3aBgLNiRqmv1Mmx+WZA2P/U+x2136A5fcw=;
        b=flGcOmFhsqHEn0tny1xbw1WJIOZFCUiznK+CNG+Nl0rUDxTYDTComXbXxl+aXUrQjZ
         yuaS4ZHtPMbODVDKo4W96qNxrxFyzwiBhD5l/+23fm0Ejj6f80ARngVV0qlqk2SkT8tB
         8Z2VnOkcIruA4kMJQ9fZ3OwxzhRkO83otMZmuDfrFsSGTIy2L+WWhzV7264FHwE1Vmp6
         Y+7vXlMP+P8yGkwt3Mw7Q4Ny9RDyNNN/AHJLZgvY9LAL29JsNjsMTNMromiilcpDAmVY
         cSRpb6U3UmwzR0Ixld4DoNPty7YoCUGVMuWweXgfjmFa75gopLhuhkV7DQdcBZJuYaAr
         OJxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RmVN5RQsg3aBgLNiRqmv1Mmx+WZA2P/U+x2136A5fcw=;
        b=TCk1KgZI8DkKaYfgOhv3XfjG43UM+1OwPDEgyEeiYBgjeRgNJc9EIHoXQzOWxkN2uV
         vznw1TV3RWYkDPmM3Zy27R9NNHj52MK15m5+3+mvyIocZyLg9zTG3zp158wE0WUZ5pD5
         yZ3kPYrBTh8Xm3pk0KdJfRujQENWQwSrExR0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RmVN5RQsg3aBgLNiRqmv1Mmx+WZA2P/U+x2136A5fcw=;
        b=TIjCOgTmkQd3lJZTYGSIZVhMREsbvVGCOb+7l+e85DVHByDqEq3P+YHkocU47qUA4f
         FVqy+pJMpnzRlrfrZJf6NpAEcDRJvKtSUwTrfLJftjLwWpF2U1CJ/tqArtCNvrP2/SUu
         y/KnQAMitRIXRTFsYRnR80wJE0cz+aivjMSFjWL+v6foxVu8Xn/zWvk7/dyZBB/sofwG
         PzKWAk3qNl+jBIVk6jbOKU81EeVD5ud1UH/X4Yng2HaC+roRp4QRFP5wpIkKxcGa5m4j
         bOI0uPlracS3yDpbfCfJTpvBUg4CegIEcv179vh6ujgKQjaBBTqQhZAhZ9pHax0n0rvq
         NmHQ==
X-Gm-Message-State: AOUpUlE1Y6psoRG/glVC2uTsAi7guVI5tQppMncB3wIUqEIjoQteO68q
        uDfawLxK88xaI74fHE2QnJ9UTaIf+XoX2iF4nZ3Vuw==
X-Google-Smtp-Source: AAOMgpf07HQHHw0WCyqO3flskkD9DT2A7TCtpOsDJWxfmnw6L1iLYRUbReWKIPh/0k6y4iDKRwIuJj2ABK85GIVaBIM=
X-Received: by 2002:a1f:18cc:: with SMTP id 195-v6mr236869vky.117.1531346186527;
 Wed, 11 Jul 2018 14:56:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 14:56:25
 -0700 (PDT)
In-Reply-To: <8144dd3c-6138-7f16-ec17-d75e84fcfb34@codeaurora.org>
References: <20180628210915.160893-1-mka@chromium.org> <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com> <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
 <20180629235417.GY129942@google.com> <8144dd3c-6138-7f16-ec17-d75e84fcfb34@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Jul 2018 14:56:25 -0700
X-Google-Sender-Auth: dSRrDOHoQQ8ySpq6HzrAG_9xvw4
Message-ID: <CAD=FV=XqoRajjNcW8RyJfrcXQVDihfjAnAsN+O9g+6qDrLHfJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
To:     David Collins <collinsd@codeaurora.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Jul 10, 2018 at 10:45 AM, David Collins <collinsd@codeaurora.org> wrote:
> Hello Matthias,
>
> On 06/29/2018 04:54 PM, Matthias Kaehlcke wrote:
>> On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
> ...
>>> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
>>> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
>>> off peripherals within the PMIC that are expected to draw significant
>>> current.  The set of peripherals included varies between PMICs.  This
>>> partial shutdown will occur simultaneously with the triggering of an
>>> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
>>> driver that an over-temperature threshold has been crossed.
>>>
>>> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
>>> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
>>> interrupt in this case because all power is cut.
>>
>> This information is very useful, thanks David!
>>
>> The (partial) hardware shutdown seems like a good measure of last
>> resort, however I suppose we prefer Linux to initiate a shutdown
>> before losing part of the peripherals (drivers might not be happy
>> about this and probably not revover even when the temperature goes
>> down again) or reach a full PMIC shutdown.
>>
>> Please let me know if there are reasons to prefer to go the hardware
>> limits, it's also an option for device makers to overwrite these
>> settings if they want different behavior.
>
> Disabling stage 3 automatic full PMIC shutdown at 145 C is definitely a
> bad idea.  This exists as a last resort in order to save the hardware and
> ensure end user safety in case of excessive temperature even if software
> is locked up.
>
> Disabling stage 2 automatic partial PMIC shutdown at 125 C is not
> recommended as the PMIC is already outside of reasonable operating
> conditions and needs to take corrective action quickly.  However, doing so
> may be acceptable if software is taking action to shut down the system
> immediately upon receiving the stage 2 over-temperature interrupt.

Just to confirm: is it expected that at stage 2 the CPU's on the SoC
should continue running even with partial PMIC shutdown enabled?  It
sounded to me like partial PMIC shutdown was supposed to shut down
high-power rails that were not essential to the task of performing an
orderly shutdown.

I think Matthias was seeing that when he reached stage 2 and partial
PMIC shutdown happened that the system was just falling on the floor.
...maybe we just have things configured incorrectly?

-Doug
