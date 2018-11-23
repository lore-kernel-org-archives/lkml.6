Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119F2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62CD20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yivc6QOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62CD20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503269AbeKWVQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:16:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43449 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390639AbeKWVQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:16:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so11809489wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 02:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VAptEt8cRcnUr8KKnpmh3SAuON7v9IwmkhCWuFtd+UA=;
        b=Yivc6QOIzC8KYeFO0XKz0lYBs6eS3w+4lzV5l9Lw4hChAL8g8OBd0ojdCeksuLjWvY
         1uNowfqWIBIpEz3IVV1JDjy0grX47cz81UXHdvlyyRtThxQRRN9EYddYZJzuuzUcjtY9
         /oLxw2Gemc0OlFD921O3cKDOHQQuzAjJCLb28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VAptEt8cRcnUr8KKnpmh3SAuON7v9IwmkhCWuFtd+UA=;
        b=ImOAThrIBNnw/VnS74I76AE99xQkIUzbBJOmGEgDB0+77d5diWMvpCvr4uvgbeo0uF
         GVOFsfTNO1qAk5YseXZAnQQuzy+Mi1ZICYx+U1WYJcwc9Q1kAio8iO0Qlq75zbLLEeeZ
         LGiI+mLqgc+TiOM/D0uTTNV4yYSug39Oqf2nsxT6eAA2NFdJrvECLL1bnmP0GWgsVFj1
         FXYC8V6YIdD8a3V0S6voFC6NUIVUSfGFeZQaCtlDX/e14cEXUhEz5Ut6zebcEaPd9NTN
         PkP1xIU7ZoVn1kLU8acl0OW0BQRkvWh+vITnlNH+L9qZnZfP1pBcOHOOPW/Z5+w6F18C
         /3jg==
X-Gm-Message-State: AA+aEWYF68mXHgi8vtn/ouz4byLmCxmDUYy0o4tIVC8uO+H3GAuKXZ9p
        iy0cydB1Nx7ntcgBg5nd9/NVCA==
X-Google-Smtp-Source: AFSGD/VcjGB+72QRRTQ3C1FrcYygRAtztnyh1i2Zzo/+UkKz1p8swbR5M0IhiAAuE9D1eGji1nAAyQ==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr13565068wru.28.1542969146481;
        Fri, 23 Nov 2018 02:32:26 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id k73sm10645196wmd.36.2018.11.23.02.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 02:32:25 -0800 (PST)
Subject: Re: [PATCH V2 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1542890209-3263-1-git-send-email-daniel.lezcano@linaro.org>
 <1542890209-3263-2-git-send-email-daniel.lezcano@linaro.org>
 <20181123100441.nlapxupdcqehwj6m@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <400c34c5-18f4-70ab-d660-8b4c45c8eec4@linaro.org>
Date:   Fri, 23 Nov 2018 11:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123100441.nlapxupdcqehwj6m@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2018 11:04, Viresh Kumar wrote:
> On 22-11-18, 13:36, Daniel Lezcano wrote:
>> In the case of asymmetric SoC with the same micro-architecture, we
>> have a group of CPUs with smaller OPPs than the other group. One
>> example is the 96boards dragonboard 820c. There is no dmips/MHz
>> difference between both groups, so no need to specify the values in
>> the DT. Unfortunately, without these defined, there is no scaling
>> capacity computation triggered, so we need to write
>> 'capacity-dmips-mhz' for each CPU with the same value in order to
>> force the scaled capacity computation.
>>
>> Fix this by setting a default capacity to SCHED_CAPACITY_SCALE, if no
>> 'capacity-dmips-mhz' is defined in the DT.
> 
> We aren't doing this anymore. You should rather explain that we just
> allocate raw_capacity now and rest is left for
> init_cpu_capacity_callback() to fix.

What about?

"In the case of asymmetric SoC with the same micro-architecture, we
have a group of CPUs with smaller OPPs than the other group. One
example is the 96boards dragonboard 820c. There is no dmips/MHz
difference between both groups, so no need to specify the values in
the DT. Unfortunately, without these defined, there is no scaling
capacity computation triggered, so we need to write
'capacity-dmips-mhz' for each CPU with the same value in order to
force the scaled capacity computation.

In order to fix this situation, allocate 'raw_capacity' so the pointer
is set and the init_cpu_capacity_callback() function can be called."

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

