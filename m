Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B50FDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2E3208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSJP2/02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2E3208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964806AbeFMUT5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:19:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44634 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935448AbeFMUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:19:55 -0400
Received: by mail-wr0-f195.google.com with SMTP id x4-v6so4041688wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UwzYd+/acZipdMmeiNeTmeIcT12XuShSgccPhbcZjuA=;
        b=aSJP2/028Lr+wB8RmN1Xup8k06nI0NlIN/hJJ7gCQwF0+tiAdE0oDh6qK4hp2uMYY4
         HKgBybC+1fhVZrv5qubbp+QtpUT++7THw8aMN7FjVlBYB6g3MUa9hMgH0wexlL4NSiIE
         smCWl7USAFzsPfuP9T5CcdOyD5WVoNpV53wRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UwzYd+/acZipdMmeiNeTmeIcT12XuShSgccPhbcZjuA=;
        b=gvtWvlX6pjHw91b+95ubn66p7yyXmid0Tykcb6SMhrt8r/qdQsOkuVTwWJEiQHvsF7
         +sEfsJejbC9lY0IsYV50DUp5PUVXKoCxyJdgVh5E2h846xpfPPPJG1PPq8an8gdIQahc
         7uocSTOPMEtYd7XuUI0QmMw+3+0YVrMU7cQmk0OTPZusubXJ8Md8CUjXyipogZfOg8rh
         hZrWpsilOy3aAyWVxm4KZX33KN2aVZgD26R4D9NBwH5maNdxLa7ZLlwuqSOVTFn5c6SP
         GqeYsCf6SCHW0noKivR9qKp1MpQDa/RFAij1k3gPcbrPJuuYJRTyVzPmINUTB5lfYPE/
         +OiQ==
X-Gm-Message-State: APt69E0euwQTB/iT4EHTwOJT563yVGJIilwD9LnSlOFujj6aa5jlCH5f
        gcnpm6Qb8UhthkynvkwWxPzeO965/t0=
X-Google-Smtp-Source: ADUXVKJhgJz3660GNFQRjyDJp2NXhc2SHfZNnzSwajpObd15iZGJqFDAl7BzhyP/bRFnUVBNDnuMoQ==
X-Received: by 2002:adf:e6d0:: with SMTP id y16-v6mr5687652wrm.35.1528921194456;
        Wed, 13 Jun 2018 13:19:54 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:b0fb:9cfa:79ac:305e? ([2001:41d0:fe90:b800:b0fb:9cfa:79ac:305e])
        by smtp.googlemail.com with ESMTPSA id w67-v6sm4341580wmw.0.2018.06.13.13.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 13:19:53 -0700 (PDT)
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "kevin.wangtao@linaro.org" <kevin.wangtao@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "javi.merino@kernel.org" <javi.merino@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <1528905257.48473.4.camel@intel.com>
 <0b72e862-6bbe-e706-79f8-e1b690982920@linaro.org>
 <1528920447.48473.11.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ac38f5d9-80d1-09f2-6f8e-c58085f9a32a@linaro.org>
Date:   Wed, 13 Jun 2018 22:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528920447.48473.11.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2018 22:07, Pandruvada, Srinivas wrote:
> On Wed, 2018-06-13 at 22:00 +0200, Daniel Lezcano wrote:
>> On 13/06/2018 17:54, Pandruvada, Srinivas wrote:
>>> On Tue, 2018-06-12 at 14:00 +0200, Daniel Lezcano wrote:
>>>> Initially, the cpu_cooling device for ARM was changed by adding a
>>>> new
>>>> policy inserting idle cycles. The intel_powerclamp driver does a
>>>> similar action.
>>>>
>>>> Instead of implementing idle injections privately in the
>>>> cpu_cooling
>>>> device, move the idle injection code in a dedicated framework and
>>>> give
>>>> the opportunity to other frameworks to make use of it.
>>>>
>>>> The framework relies on the smpboot kthreads which handles via
>>>> its
>>>> main loop the common code for hotplugging and [un]parking.
>>>>
>>>> This code was previously tested with the cpu cooling device and
>>>> went
>>>> through several iterations. It results now in split code and API
>>>> exported in the header file. It was tested with the cpu cooling
>>>> device
>>>> with success.
>>>>
>>>
>>> May be I have missed, but I don't see any use of powercap sysfs.
>>>
>>> We created powercap sys that user space is presented a common
>>> interface
>>> for power capping. The RAPL driver was also submitted as cooling
>>> device
>>> before, but suggestion was to create this powercap.
>>>
>>> So if powercap interface is not enough then may be we should
>>> enhance
>>> that.
>>
>> We are creating a framework for idle injection. This framework can
>> then
>> be used by the cpu_cooling device, the power_clamp and in addition a
>> power capping for ARM (if it makes sense).
> But in this case, why in drivers/powercap folder as this is another
> framework?

I presented at OSPM 2nd the cpu idle cooling device. It is ARM specific
but has some similarities with the power clamp driver.

Some board come with power numbers defined in their DT and from there we
are able to compute a targeted power by injecting idle cycles.

As the idle injection allows to do also power capping, Rafael told me to
move that to a framework (may be better say a component with exported
services or library) and put it in drivers/powercap.

From there we can implement a power capping, a cpu idle cooling device
and power_clamp (if the maintainer is willing to) using the same API.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

