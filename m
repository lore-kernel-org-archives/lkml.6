Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB67ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDCE205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="umN3ikdN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpuKiN1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDCE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeGRHTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:19:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32900 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeGRHTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:19:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id l10-v6so6777566oii.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PuKgzCOE9m3+ecEbOOo5+SdWRBmwQZ1kG5/r49EIDDU=;
        b=umN3ikdNjMamC6uEMzpVfNasBpB4YKVmz8XfFAhLTJtS2318g0jfVcby+Ys8Wk1h/a
         m2o6UEaVSSGYA0EgYshm/HbcF5KXd0IA4U+pJBX+6ddcn6t/dUiHVMdByiT2uOuYHo5L
         4kh/+dWGLO7AZW4MThwJIOM2K2hsNHLFZrdYLdvnOFtvtQ1U/Ij69bNCN9nlxBpHL0wR
         TOkpX5FfZJ1TeoOPAzPdJAz3PSFvut3P7P+lv+mHuknGNrvvTUOMs+wtlO6yQxrblv3u
         8yXQ5gYoyV+1cVSiim4f6YG1Yu/Z7B+wHRRT7ubUTSEbOrNpMPB4k3G3+b3Rw9/b1WZ5
         tfSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PuKgzCOE9m3+ecEbOOo5+SdWRBmwQZ1kG5/r49EIDDU=;
        b=fpuKiN1Hl+bCgJ2Ge1o8g9FPxr8wPlWIXXH2NwGTNZ0t1R6cSNkLSMhpof87EaDQcM
         jfbquGczljrtEvaK2zB+5skTpT4t1fPJx3bMfQahep6qBJHftb9LkAoT/E0ctkCPGArs
         kp9Ku99G32ZoE+XQ9OqZHlX6x+B69VHkY5+us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PuKgzCOE9m3+ecEbOOo5+SdWRBmwQZ1kG5/r49EIDDU=;
        b=K5bUeWE/Q94B6zRbNqj6d7FAXH4JUzypixzq9kcL/q9pVI8A7+QRqLVOuOor23rmxM
         4SG/5DT/9wPzntW/h0K0/VUaebHUWR6zVX6A8L8m1Y10dqUiw2La00bGKIdDx/+pqPDs
         96C/l+TpfR51TO6rXrK7JE+usHOmuj3EbBEc6hIJAiMA69LVi0ozbH7ccP27t1QcbT6j
         e3vtXP9LSiBeVsudcxcjbDxkb31YMnSFugkgLouB/XpTAaqvmaw/ZGZIIRApk3VAHGlJ
         wIos1XP1F8ia9b+m+SoYGbz0sWzzg6hhmz7j9AxYTSdnvYObhHqWt8qleGi62rVynQ4J
         1LJw==
X-Gm-Message-State: AOUpUlHdwrQd1kjLBo6H2823z6Oot1yU7dMtM1ILs9QCjhp2Dkkt+rWB
        87oWvZY3jNg4KHoIlMSkJ0mbcl2PprrCQjM73rtXgQ==
X-Google-Smtp-Source: AAOMgpeglPe0F4O5PU2FPKdyEfGyTT1GnPzWBITYOmOwa8hWEk+zVvfbXyo5ZKJOUH7fQlwp3272Ax/AlLhuXLgYvQ4=
X-Received: by 2002:aca:b1c1:: with SMTP id a184-v6mr5742951oif.182.1531896179981;
 Tue, 17 Jul 2018 23:42:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 23:42:59
 -0700 (PDT)
In-Reply-To: <20180718000918.GG129942@google.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <a385dfac661b04befd221f3012b2ca56576aada9.1531384019.git.amit.kucheria@linaro.org>
 <20180718000918.GG129942@google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 18 Jul 2018 12:12:59 +0530
X-Google-Sender-Auth: EjE7bhAPGgvczM284y-kNf6e4g4
Message-ID: <CAHLCerOWYzx0BJDrLZnXwcxWUbYnX=D_bwtUApmZrAKHW8L42A@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 5:39 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Thu, Jul 12, 2018 at 02:09:06PM +0530, Amit Kucheria wrote:
>> We want to create common code for v2 of the TSENS IP block that is used in
>> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
>> most of the common functionality start with a common get_temp() function.
>>
>> It is also necessary to split out the memory regions for the TM and SROT
>> register banks because their offsets are not constant across SoC families.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Tested-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> index 06195e8..b5312a8 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> @@ -1,18 +1,28 @@
>>  * QCOM SoC Temperature Sensor (TSENS)
>>
>>  Required properties:
>> -- compatible :
>> - - "qcom,msm8916-tsens" : For 8916 Family of SoCs
>> - - "qcom,msm8974-tsens" : For 8974 Family of SoCs
>> - - "qcom,msm8996-tsens" : For 8996 Family of SoCs
>> +- compatible:
>> +  Must be one of the following:
>> +    - "qcom,msm8916-tsens" (MSM8916)
>> +    - "qcom,msm8974-tsens" (MSM8974)
>> +    - "qcom,msm8996-tsens" (MSM8996)
>> +    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
>> +    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
>> +  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
>> +  with version 2 of the TSENS IP. MSM8996 is the only exception beacause the
>
> s/beacause/because/
>
>> +  generic property did not exist when support was added.
>> +
>> +- reg: Address range of the thermal registers.
>> +  New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
>> +  register spaces separately, with order being TM before SROT.
>> +  See Example 2, below.
>>
>> -- reg: Address range of the thermal registers
>>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
>>  - #qcom,sensors: Number of sensors in tsens block
>>  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
>>  nvmem cells
>>
>> -Example:
>> +Example 1 (legacy support before a fallback tsens-v2 propoerty was introduced):
>
> s/propoerty/property/
>
>>  tsens: thermal-sensor@900000 {
>>               compatible = "qcom,msm8916-tsens";
>>               reg = <0x4a8000 0x2000>;
>> @@ -20,3 +30,12 @@ tsens: thermal-sensor@900000 {
>>               nvmem-cell-names = "caldata", "calsel";
>>               #thermal-sensor-cells = <1>;
>>       };
>> +
>> +Example 2 (for any platform containing v2 of the TSENS IP):
>> +tsens0: thermal-sensor@c263000 {
>> +             compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>> +             reg = <0xc263000 0x1ff>, /* TM */
>> +                     <0xc222000 0x1ff>; /* SROT */
>> +             #qcom,sensors = <13>;
>> +             #thermal-sensor-cells = <1>;
>> +     };
>
> Besides the typos:
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>
> Oh, and you also might want to reorder the patches as suggested by
> Doug on v6 to put the changes in the binding before the code changes.

Ahh, sorry I missed that reordering.
