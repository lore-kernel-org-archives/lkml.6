Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B69CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1C220871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0Ozc4K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1C220871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389828AbeGKQnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:43:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41317 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389802AbeGKQno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:43:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so12304140wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3SdATeP30n2V0jNC44caM3P41JjZ0DgAt5rUkZgkeVM=;
        b=f0Ozc4K6YasvN6A1McLsSDad4tYijWKFps2YC3Icm4XAP6ieHKQbQpD9Bp3TCUxeLg
         +ZQidSJKu16jOoY8jBed09AupjOmRbfjBfiNC1EDaAHEECQUIolSOksAlGTc/R5xzTSa
         eFAPC+KNv1sguv209RclIPcXC9TGmq9kovKx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3SdATeP30n2V0jNC44caM3P41JjZ0DgAt5rUkZgkeVM=;
        b=XcO5KwxpI1vDDrOVDIEfL1pIeER8++XlvPGfHGi7CyGKpK4pYRpP75xTN6xQX8vX4j
         EohAYChNmLKU7IhdFi9XUozZyZSm1TG3/WV8n+WQe9eO49vOXNlh8oMLegqBuU2PDFn1
         vyxR8BL4VCnkpTwuTvoqCYo+QLJR/qXihjfENOUY5kR9VdvXmZ5jqQyYo+Wx4nrWaZTY
         PrXSkyjog3Q2+4UaOZWEfe0otEBvnj1Mfgql/54acbk5Z5+0ExrEQtKZjOOeQFZ2HaSW
         d8/d08jcy16OvofcFKUARIeuUBlMQ7iO/6yuN7V6M6pYCn2Z4gWTx/SglK2WdnkVAQMu
         1bHA==
X-Gm-Message-State: APt69E1nkWdKFzBwDWT9y/8zBGpCVyaPywW75u5x33Ro67VSBAwnlXKH
        XvW9diXXUKpGpZ5V4k2NtlURIuQn9Zs=
X-Google-Smtp-Source: AAOMgper9vzPjzUieKpRUECBE7F+q6kZtRLKm1kJ1buKTuOL3iAA2AmS6v5X4YxI9GgjUFwKkBXeDg==
X-Received: by 2002:adf:9345:: with SMTP id 63-v6mr22485430wro.60.1531327114824;
        Wed, 11 Jul 2018 09:38:34 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.205.99])
        by smtp.googlemail.com with ESMTPSA id 131-v6sm4332062wmm.31.2018.07.11.09.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 09:38:34 -0700 (PDT)
Subject: Re: [PATCH 1/3] clocksource: drivers: set clockevent device cpumask
 to cpu_possible_mask
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
 <2009eeb1-e925-fe5c-ac4a-9f3e41945127@linaro.org>
 <229f0ac1-16b5-3fcf-3d0d-60ad59ea40f8@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f58d0930-19fc-bb5f-960f-56aa48ced79a@linaro.org>
Date:   Wed, 11 Jul 2018 18:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <229f0ac1-16b5-3fcf-3d0d-60ad59ea40f8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2018 15:42, Sudeep Holla wrote:
> Hi Daniel,
> 
> On 11/07/18 12:36, Daniel Lezcano wrote:
>> On 11/07/2018 13:24, Sudeep Holla wrote:
>>> Currently, quite a few clockevent devices have cpumask set to
>>> cpu_all_mask which should be fine. However, cpu_possible_mask is more
>>> accurate and if there are any other clockevent devices in the system
>>> which have cpumask set to cpu_possible_mask, then having cpu_all_mask
>>> may result in issues (mostly boot hang with forever loops in
>>> clockevents_notify_released).
>>>
>>> So, lets replace all the clockevent device cpu_all_mask to
>>> cpu_possible_mask in order to prevent above mentioned possible issue.
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>> Cc: Jonathan Hunter <jonathanh@nvidia.com>
>>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>
>> Applied, thanks for the fix.
>>
> 
> Thomas was planning to take this, see [1]

Thomas ?

Do you want to take all the series ? Or shall I take this one ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

