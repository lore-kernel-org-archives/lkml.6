Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1C5C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5D423E0D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="jfJxgBIi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3KAd9DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5D423E0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeGDR0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:26:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41474 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeGDR02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:26:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so11983950oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pJvdtml0ozgf2W4NRn1dD3GM0OzcZz/gFbRC2rb9k80=;
        b=jfJxgBIitkLhsXycBb/RRygvXFVEvmfGeyB0l4Xp3AsPXY8JR4L1tYAWK4hfpLo1JW
         /oAvHCfjyG+EPomahwzvZsuLVWSJXUEvctjP9Kvh2H/GhSYpdmHmaDadirVpAEuh95/4
         Ttvz0VPogMwRevDZ4yW5zjGh6YrYBDw63eK8lwj32RFdHo9z1fSVX+pCJvv9IIgntZ3K
         Pr1vxr8iC6t3j/SqSDSntYAUjWQ99bVeZLY3vXGqwcpeAeQsn2SpfCYy0oD0n0qRRipi
         wxYrfr2Vi319kW7QCLaUtEe+VIQ+hMEyYcYg211D1szeYS8vajnBfbZf7/Qyd/ZmQZy4
         ELLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pJvdtml0ozgf2W4NRn1dD3GM0OzcZz/gFbRC2rb9k80=;
        b=R3KAd9DPwmu9JZE+8yv4FUemV51MedVcktyxbNzYfRkcnqBh7Dk1dU4A3AtfNd2oSG
         GcFeva72XedL/pDJ2g6+ox71fXn8KnDQArNdJVSAikvdTXoDRmw2oZiZ2c4yLjjpLXNq
         eZ+SbXI920C1KLoLPG4o9CmJ2SkKVJhLs/Xjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pJvdtml0ozgf2W4NRn1dD3GM0OzcZz/gFbRC2rb9k80=;
        b=o4sczKyfQJyiNapRLGfhxRayjCFQggWr5A38qDTIGi/wLWWIEOyUvuYsx1nLCpM6cg
         C96kyF1eC52Ky1dHzMwHppLhIHKsTfB86qICqDID/dXS4y0FXV8OLKl/2pnbr9zWMjGl
         Aq8odQiYwDBOfeChZo0iPild3k3HZZnqe7ECu42jZxO0585m+cytASWazkL0klEr0gDV
         6Aol+SkopwMlJyOVhdMSHTGLQ2kx6C8YaxPZB/ETm8/d0v6pC2MXYRkUOvL6hNVl0CUK
         +8jBBXUm7kSi78MHaHo1DmeV7ZqzIwOv5n5eKSo8UNcqtiTdToJpEMlgtcB4uvzw+RY6
         FzuQ==
X-Gm-Message-State: APt69E2a7n8n6y8cfgOQs2SCi6pfMTO//m1ppDRciy6Mnf7Pl7f8NhVp
        1D1O+5wHhjV178qU0zel+JAyq06ZhC8vsPJEClR8Gg==
X-Google-Smtp-Source: AAOMgpdLhnIMIU6wIijd8i/w2goy53MpfCWFs7e89R5X//Digf9pWk19CS+a8GZxLrxofUgs4tKlwWkrct55wQEZf+Y=
X-Received: by 2002:aca:abd2:: with SMTP id u201-v6mr2982546oie.171.1530725187474;
 Wed, 04 Jul 2018 10:26:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:26:26 -0700 (PDT)
In-Reply-To: <20180703162619.GA17238@rob-hp-laptop>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <43e3ae530334efab3fa0151430879f03731e9daa.1530533998.git.amit.kucheria@linaro.org>
 <20180703162619.GA17238@rob-hp-laptop>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 4 Jul 2018 22:56:26 +0530
X-Google-Sender-Auth: KV4o-bLX7gG5w0Rrx5mIXodbJIc
Message-ID: <CAHLCerNpifvM9nGXiE63-DQ0okP8+1wdxq52qo-K1TWzoYzjtQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] thermal: tsens: Add support for SDM845
To:     Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:56 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Jul 02, 2018 at 06:14:07PM +0530, Amit Kucheria wrote:
>> SDM845 uses v2.4.0 of the TSENS IP block but the get_temp() function
>> appears to be identical across v2.x.y in code seen so far. We use the
>> generic get_temp() function.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 2 ++
>>  drivers/thermal/qcom/tsens-v2.c                          | 6 +++++-
>>  drivers/thermal/qcom/tsens.c                             | 6 ++++++
>>  drivers/thermal/qcom/tsens.h                             | 5 ++++-
>>  4 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> index 06195e8..075182e 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>> @@ -5,6 +5,8 @@ Required properties:
>>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
>>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
>>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
>> + - "qcom,tsens-v2.4.0"  : For SDM845 Family of SoCs
>> + - "qcom,tsens-v2"      : Generic fallback binding for any Soc using 2.x.y version of the tsens IP
>
> You need to show what are valid combinations of compatibles. Does v2
> apply to 8996? One valid combination per line.

I've restructured qcom-tsens.txt to look like this:

-----%<-------

* QCOM SoC Temperature Sensor (TSENS)

Required properties:
- compatible: must be one of the following:
    - "qcom,msm8916-tsens" (MSM8916)
    - "qcom,msm8974-tsens" (MSM8974)
    - "qcom,msm8996-tsens" (MSM8996)
    - "qcom,tsens-<ip_version>", "qcom,tsens-v2" (TSENS IP version and a
       generic v2 property as fallback except for MSM8996)

  Examples with ip_version are:
    - "qcom,tsens-v2.4.0", "qcom,tsens-v2" (SDM845)
    - "qcom,tsens-v2.2.1", "qcom,tsens-v2" (MSM8998)

-----%<-------

8996 would end up being something like this if needed, though we're
stuck with "qcom,msm8996-tsens":
"qcom,msm8996-tsens", "qcom,tsens-v2.1.0", "qcom,tsens-v2" (MSM8996)

If this looks good, I'll respin the patches.

Regards,
Amit
