Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A732EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B9420833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iscdICSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B9420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeIJMwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:52:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39955 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:52:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so20815999wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EOzQGXhW8BewvvW50fP2JMXUrLlSJn8ziHRnPBCQ5ag=;
        b=iscdICSjHBwCcoIsmz6u91cZ7MGQ3x+jrgB/qQxGL9r2pK2+UTwCotykzgDBgcLcYS
         X+RhxO70ZQtBrIYDXR17bLT6NVx4bTCTK6UMhrXRMhMEi975G9Z9fDapfKjy68N8PhWf
         3/YLfkufbITqK1MavyqB3yGhZ1dwxx4giLM9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EOzQGXhW8BewvvW50fP2JMXUrLlSJn8ziHRnPBCQ5ag=;
        b=lKYUlOkSefkwPPCQWKhqcYLwYX6uh9Aa/GZndKCZ1vkWaZvVPKyKlRKCgU/wzoAZ/X
         J5bvhmH9TgLhyfGZya6OCMuppw7Wp8xAkT2rYfuvAa9wOtUrkEtsYOc2vVDdKhMde4iz
         vGujTMJblnCaTlVkKIuWc5AVOYQCo5XITo/PJrW21/WRjE/HJMVMDFLBXMKnsc1xy8wd
         z29eUbtg9PWYgevKfhEcrNQHNRQ5uSGu6KUF+Ao5D/R20yawmiHA0HEK8wafFFZ3qauQ
         KFlEMTnR70D+jngzyItkv/QvsHZQ3k1pyXzWCjI0rgVa0TAXxZQKcGaA2JDCmgqJporS
         RK+A==
X-Gm-Message-State: APzg51AT6Urmn9U6mCBQw567syjsBJzhMKQq9YglnEfsgWPbUGCcxvMB
        02rEZNJwufQfHsC8JJP1tamQhA==
X-Google-Smtp-Source: ANB0VdZnfbNFNfpVTJ+Vp4E0QOuQIOeFmJiVGR1vRIUV5erWKvNoAq9CvwHbkSW0EV0WnwXMtNO7WQ==
X-Received: by 2002:adf:ce06:: with SMTP id p6-v6mr14888855wrn.118.1536566392336;
        Mon, 10 Sep 2018 00:59:52 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id m68-v6sm30083565wmb.10.2018.09.10.00.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:59:51 -0700 (PDT)
Subject: Re: [PATCH 0/2] eeprom: use devres for nvmem providers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180910074404.8041-1-brgl@bgdev.pl>
 <a25ef4b9-18cf-ab08-af8f-72b6eaa32602@linaro.org>
 <CAMRc=Md+Cr8cBQGJuy0UL+oQjatH+mLV28279-qccgvyy18CAA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <13424edc-ce9e-7785-4550-cc224ec58a9e@linaro.org>
Date:   Mon, 10 Sep 2018 08:59:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Md+Cr8cBQGJuy0UL+oQjatH+mLV28279-qccgvyy18CAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/18 08:54, Bartosz Golaszewski wrote:
> 2018-09-10 9:50 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>>
>>
>> On 10/09/18 08:44, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> While working on the nvmem framework recently I noticed that there are
>>> many providers that don't use the devm variant of nvmem_register().
>>> This series contains relevant updates for eeprom drivers.
>>>
>>> Bartosz Golaszewski (2):
>>>     eeprom: eeprom_93xx46: use resource management
>>>     eeprom: at25: use devm_nvmem_register()
>>>
>>>    drivers/misc/eeprom/at25.c          | 3 +--
>>>    drivers/misc/eeprom/eeprom_93xx46.c | 7 ++-----
>>
>>
>> Can you please consider consolidating the devm related changes in a single
>> series, to easy the review!
>>
>>
>>>    2 files changed, 3 insertions(+), 7 deletions(-)
>>>
>>
> 
> Are you referring to the devm part of the bigger nvmem series? If so:
> no, because the nvmem patches are required by the later patches in
Yes, am referring to that series.
I dont see any reason why lpc and sunxi changes should not be in this 
series? Or there is no implicit reasoning or change log that suggests 
that these have to be part of that series!


--srini

> that series. These two patches are independent and should probably go
> through Greg's tree directly.
> 
> Best regards,
> Bartosz Golaszewski
> 
