Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF0A21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2bM+8LQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF0A21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeK0T3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:29:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33554 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbeK0T3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:29:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so16055705wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 00:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cy3EPSKQvU7HDmJuAjp+6myuj4f5LoYcWdNvPv7qc+A=;
        b=e2bM+8LQ8TIByPMFx/lxkRze56Jx/U4I3m8vqJrU4p3dspFoYbiNRklYTnJyvqLOfu
         fj3vefUIBJbKZUqZh5N14UjWH0+vvWSsvQIdqRGa9JIjdTypa/29GQLARaMVPt2Xtmwf
         35zd3S/i2yOO/UvoTRaUyMN8tNV/ABBc9UMV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cy3EPSKQvU7HDmJuAjp+6myuj4f5LoYcWdNvPv7qc+A=;
        b=EkC0B9YJlkHpclA/nc11hNAjf3YT4ntOFrU5aPYRKZo7HnVY0DXZgzpaJ3muDlM7IQ
         Du93LxfAhLY8bWNZp0BDBQBFVNrXRA8ww/CQVD3iAJHySoQF8m6gA23+TK4t8BSYCO+r
         CTZMVCJ+KWTDz1a4wcDs+g6PqOaaACLDBnyHMu0SgslX6kueRsPFBZ/yGhrHnn9e+lmF
         kyNVBICi1mcGAL6odJIXRPcNO0SzOuKi95NcMEFyRcjLTEFybftiMKoqnAdKRqEK9ic4
         M+i9GOaX2KNYePzRaNbk3RtIoUabgvr4oYa0rQWkFX6lFSQh8dQsj/jh/r75BAp1olii
         0Alw==
X-Gm-Message-State: AA+aEWYbjQPFzU/pXSEl3GuxhvQl5Wn1lTM62kXCUpIgigFmYzx+YOBn
        2kLlxKCBhQDOzQcS78W2HURyLg==
X-Google-Smtp-Source: AFSGD/V2gJsoJCJRLLP0ANjV2WOfQYlcSrg2Uihmq8iG7wfAHT4jV+K5BqwukB2BCDPBeDGD2TyLmA==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr26019417wrm.238.1543307512449;
        Tue, 27 Nov 2018 00:31:52 -0800 (PST)
Received: from [192.168.0.40] (67.214.136.77.rev.sfr.net. [77.136.214.67])
        by smtp.googlemail.com with ESMTPSA id c13sm5263920wrb.38.2018.11.27.00.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 00:31:51 -0800 (PST)
Subject: Re: [PATCH V4 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
 <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
 <20181127035735.keqirmzjfbw4cq64@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0a9dc628-bae0-9d31-7a7a-3ecd788ed511@linaro.org>
Date:   Tue, 27 Nov 2018 09:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127035735.keqirmzjfbw4cq64@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2018 04:57, Viresh Kumar wrote:
> On 26-11-18, 13:20, Daniel Lezcano wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
>> index 84262cd..f53a3c9 100644
>> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
>> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
>> @@ -54,6 +54,12 @@ fall back to the default capacity value for every CPU. If cpufreq is not
>>  available, final capacities are calculated by directly using capacity-dmips-
>>  mhz values (normalized w.r.t. the highest value found while parsing the DT).
>>  
>> +If capacity-dmips-mhz is not specified or if the parsing fails, the
>> +default capacity value will be computed against the highest frequency.
>> +When all CPUs have the same OPP, they will have the same capacity
>> +value otherwise the capacity will be scaled down for CPUs having lower
>> +frequencies.
> 
> I know you added this based on Quentin's feedback, but I wonder if this is
> really required and if it is improving anything at all. This is what the
> documentation says currently without this patch:
> 
> "
> capacity-dmips-mhz is an optional cpu node [1] property: u32 value
> representing CPU capacity expressed in normalized DMIPS/MHz. At boot time, the
> maximum frequency available to the cpu is then used to calculate the capacity
> value internally used by the kernel.
> 
> capacity-dmips-mhz property is all-or-nothing: if it is specified for a cpu
> node, it has to be specified for every other cpu nodes, or the system will
> fall back to the default capacity value for every CPU. If cpufreq is not
> available, final capacities are calculated by directly using capacity-dmips-
> mhz values (normalized w.r.t. the highest value found while parsing the DT).
> "
> 
> So it already clearly says two things:
> - If all CPUs don't have this property, we fallback to default capacity for
>   every CPU.
> - And the OS may also normalize the capacity based on the maximum frequency.
> 
> What more do we want to add here ?

I think what is new is the silver-gold platform. I agree the description
above gives us the information but in a condensed way. With this extra
paragraph we elaborate a bit and make it more clear for SMP/AMP systems.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

