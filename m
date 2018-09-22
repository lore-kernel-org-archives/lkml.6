Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219DC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331882147A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7pdtO66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331882147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeIWFzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 01:55:21 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:43233 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeIWFzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 01:55:21 -0400
Received: by mail-pl1-f171.google.com with SMTP id 30-v6so878812plb.10;
        Sat, 22 Sep 2018 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ioyrqpa26KSrlAeWACHsoroxobRUGDVxuhw3SkV2mAo=;
        b=k7pdtO66JWX9HQ9RR5H2voMGG/q4rt8nPQ6nP7MFOGinTrEEtgd5bqzLYbp2w8pLkb
         SNZsqSlOYS1HyFzhjB2UOcM1sMgQrgya+0PzpKZYCJ2q6C8f33AoNKJ/coHz/mdD6N6L
         0XrZfGJUQVWhFsFR9pMlwapjSvacPoRaZ7ppATp4qiXV6RuWPBteaiKx4aK/lILc9b/S
         Dvv6J8AoE4N1j2ZCLzK1YFq0e9zrmnUsjtbxJ9nhH3KJ0XjqdvvjvkrFys42o0jTu+De
         TnxirDDfGNVeVl7iXypzMXvyefqCxw9O5qo0ILDDWGc0vKODJlhXAqu7ID1fgKXU+E2x
         wbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ioyrqpa26KSrlAeWACHsoroxobRUGDVxuhw3SkV2mAo=;
        b=RzS8O6MLD0XPHnx3JmRWsTquiFJX7kSfEdSl/R1/qX8xHxL6eN0Gtig2tkzXPtBull
         ammw6XOpSh3pNxNmcrh4Wki3hHewsUR3MBEzjBdAB2j0/ityRhs4EhqXL0rUgR9+W+qf
         eL7SF2uvfEg/AftwsS9J6K3r+STNMLJSDTJhDOD3ZHtSy0jBnRFKZtX2HCbqrW7dBuDl
         OZ7MpYtvTcLjQu0eL+YOUmZwR8GL5X7gng6hsEemvTMrSNU3S+hduiW2BtNFSey30gzB
         lVBv99tsFkhE02wVx5dfPpODhMz+qDXd4ClYFovwv2Qo24+GQAkfk3QGzasSwYIhVWS/
         6jOA==
X-Gm-Message-State: ABuFfojSJBbEy4Laco8LFpxNLpHwflJf4peOWaS03kvq7d4cnnvc1k2t
        OJ7rYfplBu0SVsGNqE9vSrNujZ2d
X-Google-Smtp-Source: ACcGV62nbMTISan79Gs1VHUMjLW1Z5IH3qgXt7Se4HhaNa+DonhapZBztXFNh0jfoQC17Ghprq001g==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1-v6mr4270677plb.129.1537660797109;
        Sat, 22 Sep 2018 16:59:57 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p3-v6sm39501546pfo.130.2018.09.22.16.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 16:59:56 -0700 (PDT)
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
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f8e017c4-10dd-2d0d-84df-b05d3ed03bbf@roeck-us.net>
Date:   Sat, 22 Sep 2018 16:59:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180922184650.GB9092@Asurada>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/2018 11:46 AM, Nicolin Chen wrote:
>>> This patch adds a new structure of input source specific
>>> information including input source label, shunt resistor
>>> value and its connection status. It exposes these labels
>>> via sysfs and also disables those channels where there's
>>> no input source being connected.
>>>
>>
>> I see you have decided to just display the disconnected channels.
>> This is misleading, and I can not accept it. Please either use the
>> is_visible callback to not display those channels at all, or have
> 
> I will add is_visible. I have almost finished it while waiting for
> the v3's review comments. Will test it and include in the v4.
> 
>> the _input attribute of disabled channels return -ENODATA (see
>> 'in[0-*]_enable' attribute in the ABI). If you implement the latter,
>> I would suggest to also implement the _enable attribute.
> 
> I will also add one separate patch for in[0-*]_enable after these
> two changes pass the review and get applied.
> 
>> As mentioned in patch 1, I can not accept an implicitly mandatory
>> label attribute. The property defining the label attribute will
>> have to be optional and well defined to ensure that it matches
>> the ABI.
> 
> I replied this in the PATCH-1. Let's discuss this topic there.
> 
>>> +	/* Disable channels if their inputs are disconnected */
>>> +	for (i = 0, mask = 0; i < INA3221_NUM_CHANNELS; i++) {
>>> +		if (ina->inputs[i].disconnected)
>>> +			mask |= INA3221_CONFIG_CHx_EN(i);
>>> +	}
>>
>> Consequently, you should also _enable_ channels which are not explicitly disabled.
> 
> The register has enabled all channels by default. So I felt it'd
> be neat to have disabling code only. My v1 actually had enabling
> part as well, but I can add it back if you think it'd be better.
> 
>> This can be tricky since you'll have to distinguish non-DT and DT configuration
>> and retain the original configuration if no channel configuration data is available
>> from devicetree.
> 
> I don't quite understand this comments. Would you please elaborate
> it?
> 
> For non-DT configurations, input->disconnected is always false by
> default unless someone adds config for it (through platform_data).
> If regmap_update_bits only does disabling like this version does,
> non-DT configurations will not get affected since mask = 0. Or if
> we change it to do both enabling and disabling, regmap_update_bits
> will still ignore since there's no register value changed, though
> it won't really hurt even if regmap writes correct configurations
> to the register.
> 
> For DT configurations (without channel input source defined), it's
> like the same as non-DT configurations. As we have platforms only
> enabled ina3221 via DT while they don't have this new DT binding,
> the driver has to be backward compatible, so my change only sets
> input->disconnected=true when a status="disabled" is present, i.e.
> those platforms are treated as all channels getting enabled until
> they update their DTs.
> 

I think your assumption may be that the chip is always in its reset state
when Linux is loaded. This is not necessarily the case; it may be
preconfigured by BIOS or ROMMON, or even by someone using i2cset before
loading the driver. If you add enable/disable functionality, you can
not make an assumption about the original state of the chip at probe time;
you have to read it from the chip itself.

Thanks,
Guenter
