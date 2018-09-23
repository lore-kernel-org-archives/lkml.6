Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB45ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 02:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E082146E
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 02:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU6ImiH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E082146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeIWICs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 04:02:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40073 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeIWICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 04:02:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so796491pgm.7;
        Sat, 22 Sep 2018 19:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nzdPTYtIcSavV6H0ciUPs+KTqcsTJVvCjZAN4K2mW0A=;
        b=OU6ImiH7MpG+l0EpzPQ0JvqpWbA56GcogEav39KYYdfpwauu8qETsoihK+9rAsMW/x
         H0ckIipzakxgU87PTwEXAM0sX5lFoU42GP6xycYp3cDsaDjj18PsDlFqeNWffaSzMNEb
         TBbBclSkoZ4iK8oGcmFD0MyzXqsdaaipjVR5g1ICmxGEqrNtJVd/j3vyvs816a6/SKZf
         SK2zHr3fL9E5oEu5To+5ZhujJNR2IWdIelXw+d9qddedR59VSzN7uTbuA1kJKcMS8NeS
         oOsy31AYpYuwq4HZRzhQBs0oV3SGjsyqJxQIPfXs45MOU1JqJI3+u88r1qKb3SVqr7Y7
         QnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nzdPTYtIcSavV6H0ciUPs+KTqcsTJVvCjZAN4K2mW0A=;
        b=efvPIWBWqGGIkGVepQMVIX06yPDiSU/l7LkDI2V7caDd1L3yMqBWdK5NxFAm3xrbvD
         qxO4hE7ZUisY8QhJ0oTdwm8+pQ5UrGrvI3aRtWvkW4tbBej6Ui10qAUFa6CvTQZDQqhv
         RtjhkanxO+QKpqND/YigeVuTsh4p/l88qgkMpDHHYkWnbts8XujLSCCU970J4ZwG9o1V
         OjDAczG+P3WnLcROrSXwMOEZ7N9LR6Lqv3BzsQ+VQzzDA+1cl69YOLvo6EGwd4wzToCP
         mJ+Lu8i5gi8lEfJLlQFgnuY/AUYhyPlYtNP1ONkRLKD872JnIh9WM77pfUrWUuDcIOKP
         jN9g==
X-Gm-Message-State: APzg51DQGOqOpx/02F/R6ddE8nVIJQAAfFQU3WUlzvlO471RL97VZQWo
        CKIgCBA4ycEa5AdRi95qRo+DSHbi
X-Google-Smtp-Source: ANB0VdY5hiOohnGmwoUGTfNNPJGIqPuPtcKHbE/kckq2Oi7QpUXG8d3mqg8bjUgyipNyKPfxGT9cOg==
X-Received: by 2002:a62:ee06:: with SMTP id e6-v6mr4450743pfi.2.1537668424965;
        Sat, 22 Sep 2018 19:07:04 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y4-v6sm43906493pfn.123.2018.09.22.19.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 19:07:03 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] hwmon: ina3221: Read channel input source info
 from DT
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
 <20180921223216.634-3-nicoleotsuka@gmail.com>
 <a7e6c311-eba4-e9b2-df64-9d02882a1dcb@roeck-us.net>
 <20180922184650.GB9092@Asurada>
 <f8e017c4-10dd-2d0d-84df-b05d3ed03bbf@roeck-us.net>
 <20180923003841.GA10071@Asurada-Nvidia.nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <80510b08-0e89-03ce-7d69-fe51f8b6a7b5@roeck-us.net>
Date:   Sat, 22 Sep 2018 19:07:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923003841.GA10071@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/2018 05:38 PM, Nicolin Chen wrote:
> On Sat, Sep 22, 2018 at 04:59:55PM -0700, Guenter Roeck wrote:
> 
>>>>> +	/* Disable channels if their inputs are disconnected */
>>>>> +	for (i = 0, mask = 0; i < INA3221_NUM_CHANNELS; i++) {
>>>>> +		if (ina->inputs[i].disconnected)
>>>>> +			mask |= INA3221_CONFIG_CHx_EN(i);
>>>>> +	}
>>>>
>>>> Consequently, you should also _enable_ channels which are not explicitly disabled.
>>>
>>> The register has enabled all channels by default. So I felt it'd
>>> be neat to have disabling code only. My v1 actually had enabling
>>> part as well, but I can add it back if you think it'd be better.
>>>
>>>> This can be tricky since you'll have to distinguish non-DT and DT configuration
>>>> and retain the original configuration if no channel configuration data is available
>>>> from devicetree.
> 
>>> For non-DT configurations, input->disconnected is always false by
>>> default unless someone adds config for it (through platform_data).
>>> If regmap_update_bits only does disabling like this version does,
>>> non-DT configurations will not get affected since mask = 0. Or if
>>> we change it to do both enabling and disabling, regmap_update_bits
>>> will still ignore since there's no register value changed, though
>>> it won't really hurt even if regmap writes correct configurations
>>> to the register.
>>>
>>> For DT configurations (without channel input source defined), it's
>>> like the same as non-DT configurations. As we have platforms only
>>> enabled ina3221 via DT while they don't have this new DT binding,
>>> the driver has to be backward compatible, so my change only sets
>>> input->disconnected=true when a status="disabled" is present, i.e.
>>> those platforms are treated as all channels getting enabled until
>>> they update their DTs.
> 
>> I think your assumption may be that the chip is always in its reset state
>> when Linux is loaded. This is not necessarily the case; it may be
>> preconfigured by BIOS or ROMMON, or even by someone using i2cset before
>> loading the driver. If you add enable/disable functionality, you can
>> not make an assumption about the original state of the chip at probe time;
>> you have to read it from the chip itself.
> 
> I see. That made a point. In that case, I think the simplest way
> is probably to do software reset before having configurations.
> 
No. If the chip was configured by the BIOS/ROMMON, it is supposed
to be that way. We can not just override that.

Guenter

> The "disconnected" here is to describe the physical connection,
> not exact the switch control status because a channel could be
> connected but disabled. However, a channel would not be enabled
> if it's disconnected. So I think it'd be safe to just disable
> the disconnected channels here as this version does, meanwhile,
> I will add a soft reset to make sure all channels are enabled.
> 
> Thanks
> Nicolin
> 

