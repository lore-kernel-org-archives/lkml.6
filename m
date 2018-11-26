Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7DBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F95320663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMaGllHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F95320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeKZWa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:30:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53074 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeKZWa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:30:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so17811940wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 03:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W0wyodnQmKrtvN1vfpkNF02rK9J9GLCvcTT1JgDHsE4=;
        b=UMaGllHGmcHkCvkwCK15K4Rg1WPfJml5IM7HBKFEB0lNkzNcQQR02P981lHwtNwn+I
         D10wj7HhifXO6Ovu0YaXVg0hcbfw9e4lMXbQUIDo8Yp3bl4Q7RCU5Q3iD07O2Hdi9dx0
         a5SxKVayWW6MqN7I6WLZKfROEbWqVOqWSY2hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W0wyodnQmKrtvN1vfpkNF02rK9J9GLCvcTT1JgDHsE4=;
        b=EZxiBtV+BvAR9wUltV9lBEvJ7tV6jsGsy9B+VzJCGsJ5quOogM9LmEOXlWUGdI1WHK
         K5yzHz9buF2nfGsjGG/mM2OUAK4HUrzxcpSlpmZBsQlNpNK1x63ULfPFEhU6oUvQfQcE
         1movgvTqp2gCpmV7De/lr7ymgl9E9iKYADiXny5+YKtp+O8YDhDsJNkXl4PaRaeYRWhi
         bOS+rgu6Km6X7Gp1pLk6Q0ZKvV8szO/QLTi1ErN5M7tyyHCyFysk/9Gj45Qo5JbBjhdg
         LGGzYWxwGNbKqpYmVfypNpTMYuyoXvCV9yy+yuJTuAD6QNUqn7ZclCZrTPoMDSl0Vm+N
         Giag==
X-Gm-Message-State: AA+aEWazkn1WnWNVyhuw+Tvig7fyk0VVARqjOpYjKtDD8NQhAcriRaY1
        VqSM6510r8WphwfjOlfr7KKcug==
X-Google-Smtp-Source: AFSGD/UMofeJi5gxaz8trzSRKxudd/EeoUk12E++dlrRkCLk0mJzJEqQNJIZp+TV4lloMRCQ/6kxhg==
X-Received: by 2002:a1c:3b82:: with SMTP id i124-v6mr22019146wma.34.1543232193674;
        Mon, 26 Nov 2018 03:36:33 -0800 (PST)
Received: from [192.168.0.40] (72.224.136.77.rev.sfr.net. [77.136.224.72])
        by smtp.googlemail.com with ESMTPSA id f192sm599309wmd.12.2018.11.26.03.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 03:36:33 -0800 (PST)
Subject: Re: [PATCH V3 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
To:     Quentin Perret <quentin.perret@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
 <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
 <20181126095224.i5se3n5lavww4a2n@queper01-ThinkPad-T460s>
 <97f85a4b-efb6-b26f-94d0-cd538c83a03e@linaro.org>
 <20181126101955.pdn76f2ujeb6urxz@vireshk-i7>
 <20181126110915.372tanwevpfcr7zp@queper01-ThinkPad-T460s>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <44e471b6-d58c-310a-0883-bf9f444ddcce@linaro.org>
Date:   Mon, 26 Nov 2018 12:36:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126110915.372tanwevpfcr7zp@queper01-ThinkPad-T460s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2018 12:09, Quentin Perret wrote:
> On Monday 26 Nov 2018 at 15:49:55 (+0530), Viresh Kumar wrote:
>> On 26-11-18, 11:08, Daniel Lezcano wrote:
>>> On 26/11/2018 10:52, Quentin Perret wrote:
>>>> Maybe you want to test 'if (!raw_capacity || cap_parsing_failed)' at the
>>>> top of topology_parse_cpu_capacity() ?
>>>
>>> I prefer to update the documentation, it makes more sense than adding
>>> more cumbersome tests in the current code.
>>
>> +1
>>
>> Throwing an error and ignoring DT number completely for the capacity
>> are good enough in my opinion as well.
>>
>> And who cares for the platforms that can't even fill the DT properly :)
> 
> Right, I think we all agree the case with a partially filled DT is
> broken. I don't actually care too much about the behaviour in this case,
> but it needs to be consistent with the doc.
> 
> So, as long as you fix the doc, that change is fine by me :-)

Ok what about the following change ?

"

If capacity-dmips-mhz is not specified or if the parsing fails, the
default capacity value will be computed against the highest frequency,
it will result most of the time on the same capacity value. However on
some platform with different OPP set but the same micro-architecture,
the capacity will be scaled down for CPUs having lower frequencies.

"



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

