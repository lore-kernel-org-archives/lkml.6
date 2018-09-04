Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F2DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0338020661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CV2cRVbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0338020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeIEEJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:09:59 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45808 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeIEEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:09:59 -0400
Received: by mail-vk0-f68.google.com with SMTP id b78-v6so2008294vka.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 16:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LZkswWpmSyfw4IH/noU3QDigFuFv1ydvwG5ZLGEfw0k=;
        b=CV2cRVbUaQ7KAXHv7XldpP/qK+6USKCbidn6SFmJ+e+Inw2DQokR9fjX6OlJkMC+sI
         yCB+jrkjh6hpGrD2GlFswoaHCqAuy0qKjD8nzw9GQczpTCaw0pJ7V84jnbf9+FOOpvdz
         6xKCMFRS3A6beXKoxh8eT6gGna5k/P4d8c87U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LZkswWpmSyfw4IH/noU3QDigFuFv1ydvwG5ZLGEfw0k=;
        b=ZCjMzgSuWt2DGRy5y3hV+F2fgtwZev66JdcxfH0s39iGB5syVTI5fhCHnRCpIfTTBI
         3UAxc6XOqeMDxGsY3z8fdn0dUL/J3vamQviTlk5BaloUtHIm/nOzsljyPVQ/EyuNbrhs
         rSMhKrbPOnTdMqurrTo6OA39Vp2g3tLgglIzZLjSBRNAtND1tAMgZ7Cn/OrBPMN+r+Tr
         r311kTxoWe8PWaMyV64a1WP9/yQe1DKZiyl94ZoUAqRJ0bmovC2+Ajgp5mHgbpvZZzv8
         q/jc9PTmI9PHUe91duB4F/vk0v+wc7JXI13Y6gysxqEzk7JpWouwr/9QgT+NxCCoZDUn
         wd1A==
X-Gm-Message-State: APzg51CzA2PZ8knPDNWDWFWm6p0hErSLVxekkfRTjHmADKAczdzm6Xxc
        3hSDFN2hPUqVEwiE5n6lf+D+o7qX6rQ=
X-Google-Smtp-Source: ANB0VdabUErtUcJ5mhMiJPb0/dVFL2phHhtWtQjw4r8y/cN0ErMOhIVNmQ4nIizSqqnrwAA4GTGziQ==
X-Received: by 2002:a1f:8093:: with SMTP id b141-v6mr16639649vkd.45.1536104553753;
        Tue, 04 Sep 2018 16:42:33 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id t7-v6sm43608vsj.1.2018.09.04.16.42.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 16:42:32 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id i4-v6so4367250uak.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 16:42:32 -0700 (PDT)
X-Received: by 2002:ab0:7055:: with SMTP id v21-v6mr19211446ual.44.1536104552090;
 Tue, 04 Sep 2018 16:42:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 16:42:31 -0700 (PDT)
In-Reply-To: <20180903203405.GT3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <c49d9f13b3d6849604ae3eb00a92b80948ef1534.1535462942.git.amit.kucheria@linaro.org>
 <20180903203405.GT3456@tuxbook-pro>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Sep 2018 16:42:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WoQnSLj0RvrKfjgJCKkDKrEnKG2F5XQxQjFaJbhH1gjQ@mail.gmail.com>
Message-ID: <CAD=FV=WoQnSLj0RvrKfjgJCKkDKrEnKG2F5XQxQjFaJbhH1gjQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] arm64: dts: qcom: Add reg-names for all tsens nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 3, 2018 at 1:34 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:
>
>> Instead of showing up as thermal-sensor@<addr>, the nodes will show up as
>> tsens0_tm, tsen1_tm, tsens1_srot, etc. in /proc/iomem making it easier to
>> read.
>>
>> IOW,
>>
>> 0c222000-0c2221fe : thermal-sensor@c263000
>> 0c223000-0c2231fe : thermal-sensor@c265000
>> 0c263000-0c2631fe : thermal-sensor@c263000
>> 0c265000-0c2651fe : thermal-sensor@c265000
>>
>> becomes
>>
>> 0c222000-0c2221fe : tsens0_srot
>> 0c223000-0c2231fe : tsens1_srot
>> 0c263000-0c2631fe : tsens0_tm
>> 0c265000-0c2651fe : tsens1_tm
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 1 +
>>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 ++
>>  4 files changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index 3c4b81c29798..64c9f81ddd90 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -431,6 +431,7 @@
>>                       compatible = "qcom,msm8974-tsens";
>>                       reg = <0xfc4a9000 0x1000>, /* TM */
>>                             <0xfc4a8000 0x1000>; /* SROT */
>> +                     reg-names = "tsens_tm", "tsens_srot";
>
> While the iomem output seems more convenient this way, these register
> names are a contract between the DT binding and the particular tsens
> instance.
>
> As such this is a good idea, but with the names should not include the
> instance information. They should be "tm", "srot".

Rob Herring doesn't seem to think so.  As per
<http://lkml.kernel.org/r/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com>

I said:

> From what you're saying the _only_ reason you'd ever want to use
> reg-names is if there is an optional register range.  Is that right?

Rob said:

> IMO, yes.

It sounds like Rob won't NAK a change that adds reg-names if there is
more than one reg, but in general he's not a fan.  I'd vote to keep
things consistent with Rob's worldview and just drop this change.


-Doug
