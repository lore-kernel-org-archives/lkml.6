Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4306218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a04zSWp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfAaKoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:44:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55945 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:44:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so1923961wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t3WDURB6Ww4pRbO/GC6ksDsE7A9QytnEYKjc5c7Svy8=;
        b=a04zSWp9TvECYK4CnmJHZwWNPJGt8QLhWzOqRWLUxMlvYbYEjwTyLblFcBIEuYJ1B5
         FuU110SDCEqvDxdevmYNTVkep2lkK5a9hT6fVfiKT+7F5e9o6dEfGgHe4utaRYn6GX26
         Sv4vRucMYWBJv2dAzHI26xh0pJy0iQAZbiU00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t3WDURB6Ww4pRbO/GC6ksDsE7A9QytnEYKjc5c7Svy8=;
        b=EGbgXc5+hNvliTsilwqQO4IJX0W2wXu1dMPhWKs0T/L5gLQiF7Js/E2unjzSxToXO+
         F8Een0cfjK5qs8CZCoL07dIMo6Bwl2UrdngSq6oJEi2CW7rvFs1Qdppl8J77trTIO4wA
         7/INblrK+1DHfVQ428gNektsZloqXAlAMH/tK2UnH2hl4U5pEmmbr3UzXZvXU+SLih7F
         ETW8uZp+6mZ9uODP6gLkk0vtn4Uxmsu29lusYvxA4Dft44nt0wkszpMc8t8+SG9K9NKl
         Cp4/oVv7y/UwoXhJ94E7o3tJvzlKo+m7uwo08Z+ouZKybeq7f7RZs2bO65DgcLsOd40P
         ieRw==
X-Gm-Message-State: AJcUukcnf3YCL3bTxDgCHHVnyIlWtf8XBuNysXOLIPhjIkkNkM6sMvRR
        /q+M6cJYMeBqOS9rLXs3pDe1gsqC3lc=
X-Google-Smtp-Source: ALg8bN4aWaG/3LrYA1q2HOlF6jIPM4HInsp5wgGVa6LSEhQpJdRwryUwtbkBhz3Poqo8tQ0zs9np3w==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr28978345wmf.8.1548931442269;
        Thu, 31 Jan 2019 02:44:02 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k19sm9110164wre.5.2019.01.31.02.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 02:44:01 -0800 (PST)
Subject: Re: [PATCH] qcom: apr: Make apr callbacks in non-atomic context
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org
References: <20181115184904.27223-1-srinivas.kandagatla@linaro.org>
 <20190131011649.GA27190@builder>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7555094b-350b-b4c6-47c6-507f7ce99dc5@linaro.org>
Date:   Thu, 31 Jan 2019 10:44:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131011649.GA27190@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2019 01:16, Bjorn Andersson wrote:
> On Thu 15 Nov 10:49 PST 2018, Srinivas Kandagatla wrote:
> 
>> APR communication with DSP is not atomic in nature.
>> Its request-response type. Trying to pretend that these are atomic
>> and invoking apr client callbacks directly under atomic/irq context has
>> endless issues with soundcard. It makes more sense to convert these
>> to nonatomic calls. This also coverts all the dais to be nonatomic.
>>
> Hi Srinivas,
> 
> Sorry for not looking at this before.
> 
NP, thanks for the review!

> Are you sure that you're meeting the latency requirements of low-latency
> audio with this change?

Low and Ultra Low Latency audio is not supported in the exiting upstream 
qdsp drivers.

Also it depends on definition of "latency", is the latency referring to 
"filling the data" or "latency between DSP command and response".

For former case as long as we have more samples in our ring buffer there 
should be no latency in filling the data.
For later case it should not really matter as long as former case is 
taken care off.

Low latency audio involves smaller sample sizes and no or minimal 
preprocessing in DSP so am guessing that we should be okay with 
responses in workqueue as long as we have good size ring buffer.

> 
> [..]
>> @@ -303,6 +363,10 @@ static int apr_remove_device(struct device *dev, void *null)
>>   
>>   static void apr_remove(struct rpmsg_device *rpdev)
>>   {
>> +	struct apr *apr = dev_get_drvdata(&rpdev->dev);
>> +
>> +	flush_workqueue(apr->rxwq);
>> +	destroy_workqueue(apr->rxwq);
> The devices may still be communicating until you remove them on the next
> line, wouldn't it make more sense to destroy the work queue after
> removing the APR devices?

Yes, that makes sense!

--srini
> 
>>   	device_for_each_child(&rpdev->dev, NULL, apr_remove_device);
>>   }
> Regards,
> Bjorn
