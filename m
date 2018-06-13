Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4DE44C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB7D20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="ADycsJse";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwIaxhPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB7D20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeFMINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:13:16 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35371 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754495AbeFMINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:13:11 -0400
Received: by mail-ot0-f196.google.com with SMTP id q17-v6so1981676otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9MV/ItVzMmJXWaz308SYtRyRPaWVhi1bsWeAx57JmuQ=;
        b=ADycsJseD4XbWvGcOhOJUUWo7Xe5eG3fL+MoIth+LjhlWATIlHW/foX6hvooo6egXr
         w/AlckuVcWeHnGSF21ZTNilTHvvcemsCor+aQXBejlwk/85EFgyDmQ9u01Mrb8zyBVVR
         b35PwV3t4UdLJciONspaW1Jd2QaoShiOf7FiNZen9YDQgPv3XriDjrdc9eoV+WhzmVow
         edn+7i1eeWNlZ6E6wBTyfB+4JUnVBurAYxJ71J+Dams4wiv8ZILQSj+GdIha2Ypx9mft
         YXFMco9s6qCjSscu/rObKx3vBHDXosCPb3Ep8/kLIjWPs0ybHOMXrMEwpDNxyjHuwIPj
         P5aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9MV/ItVzMmJXWaz308SYtRyRPaWVhi1bsWeAx57JmuQ=;
        b=kwIaxhPXmrUWefOlVZyktqyrsk5osi3vI1Z6SVNDb13eQ86DTYcSy5KD1ohRig/pHH
         LpWQoOrjA65tRs32i+m68Z2585phdxx8M8mXYuulObrRjoqnx6QJVASzJiBs0YpMz6+d
         hwkFq8bbdCe/wiJhYqfVbSnDq7aVC5KZpmm8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9MV/ItVzMmJXWaz308SYtRyRPaWVhi1bsWeAx57JmuQ=;
        b=uFFJRuAu27aDllit/cNoxhZ0U5WRyIkxYXUW6thj1iYhVS9I76GBLuTu6IYu+ovBnm
         0k83TWYtH6VMPxwmWbp61E+UHV5+fRpFBz6uNvD6HZs5HngffoUdO11Sn6GmOv52LNI/
         t50hzDgLAOA5lo8g4XLI4pQ7fzvjhRVHMeTbzytNwcP6iHLICIj0QV4ens43l6cDb+eJ
         DL9VqJKGlgOs80n3sej1ZvAXO1GrP6ueV80HgOUCFSpozt6aDkHh/gWAAKHb1q9jvbmC
         NV9xS0/prnADDbpXQovFxnra568+IeHtOwiMyLvErTDJVKAYlchlS1hVGb4p78NU5H5b
         zdIw==
X-Gm-Message-State: APt69E3bIlpMuvG4nHhcjFuG7RIljyCnAhOngHtOyqWK8uexWt6RAfVy
        fzWof0gOSFjtiaK3O+46ccFl6byaS9diSBqiPcqw/g==
X-Google-Smtp-Source: ADUXVKJjnY7BL6LvSgRCxG4hURi+2lW/6Exyc5orSl7YXj4nykFxAMdkQkI4/ARdRBOxBG+dpv7rAcRwm1WjZkAoyz8=
X-Received: by 2002:a9d:3803:: with SMTP id i3-v6mr2311613otc.59.1528877590768;
 Wed, 13 Jun 2018 01:13:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:99ab:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:13:10
 -0700 (PDT)
In-Reply-To: <20180612193507.GO14924@minitux>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <683ceb9a7d283bcad47fc6e8e4fcfbd7e76c1018.1528799892.git.amit.kucheria@linaro.org>
 <20180612193507.GO14924@minitux>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 13 Jun 2018 11:13:10 +0300
X-Google-Sender-Auth: QFjmco7sEFf-V6Wz2iDANlwYnD0
Message-ID: <CAHLCerOaQ6LmuGkBNu6SuVXXX8hQ+yJJ9-N6NAyLhtTp_yCK-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt: qcom: 8996: thermal: Move to DT initialisation
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:35 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 12 Jun 03:54 PDT 2018, Amit Kucheria wrote:
>
>> We also split up the regmap address space into two, one for the TM
>> registers, the other for the SROT registers. This was required to deal with
>> different address offsets for the TM and SROT registers across different
>> SoC families.
>>
>> Since tsens-common.c/init_common() currently only registers one address space, the order is important (TM before SROT).This is OK since the code doesn't really use the SROT functionality yet.
>
> Please line wrap this.
>
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
>>  drivers/thermal/qcom/tsens-8996.c     |  1 -
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index 410ae78..b4aab18 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -451,7 +451,17 @@
>>
>>               tsens0: thermal-sensor@4a8000 {
>>                       compatible = "qcom,msm8996-tsens";
>> -                     reg = <0x4a8000 0x2000>;
>> +                     reg = <0x4a9000 0x1000>, /* TM */
>> +                           <0x4a8000 0x1000>; /* SROT */
>> +                     #qcom,sensors = <13>;
>> +                     #thermal-sensor-cells = <1>;
>> +             };
>> +
>> +             tsens1: thermal-sensor@4ac000 {
>> +                     compatible = "qcom,msm8996-tsens";
>> +                     reg = <0x4ad000 0x1000>, /* TM */
>> +                           <0x4ac000 0x1000>; /* SROT */
>> +                     #qcom,sensors = <8>;
>>                       #thermal-sensor-cells = <1>;
>>               };
>>
>> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
>> index e1f7781..6e59078 100644
>> --- a/drivers/thermal/qcom/tsens-8996.c
>> +++ b/drivers/thermal/qcom/tsens-8996.c
>> @@ -79,6 +79,5 @@ static const struct tsens_ops ops_8996 = {
>>  };
>>
>>  const struct tsens_data data_8996 = {
>> -     .num_sensors    = 13,
>
> This will cause the current 8996 dts to fail probing the tsens. I think
> you should just leave this as is, because specifying qcom,sensors in dts
> will overwrite this number regardless.

Ack, I didn't consider backword compatility of the code with the
current dts. Will fix.

> It also would make this change dts specific, which is convenient as it
> breaks the interdependency between the different subsystems.
>
>>       .ops            = &ops_8996,
>
> Regards,
> Bjorn
