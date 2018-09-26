Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A68C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185212150C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185212150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeI0CeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:34:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33518 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeI0CeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:34:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id f10-v6so266606wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RvKUcGuu6B3B9tJeMQc8r/WkveTyxnEYcqLLgfwoUyA=;
        b=bIbYiXMrQtkTfxrjMQYA7lasE/vrYIO55YTFy7D2j+Cex62bf2eCPd+vz/9RPXfzXF
         BYlUEFm4SXYRISPOL09SY6nEdQ92rY9KZy/Nt48GAAI/Oo3NvGyQSl+GdNkvrWH98bAc
         pMT38x7aJNvbAdjv/MOdl/gtLdobLdoxQBfPdeqlPzLZzgbWNNRe7U5RCuPWu0lTgWz3
         9ne/H2V+BraakcqKUdzqi087+2D9UXCJftXKFbqBIlxg5JywFbrLJz4bJZGyy0hLLXMA
         uwPicGaIFyxvzXTR61aculN+ApBA600mOJWEpheKJWisS99Skv19fpASRgwS7TWobLst
         MQng==
X-Gm-Message-State: ABuFfohEQmXeASfyUTkX31khe8vNnEulFcIMu8g/JxK+P//88hMI9jnn
        BbWO5suOmGdIUEc7NP9AI6uvLg==
X-Google-Smtp-Source: ACcGV62SUsjuAsd+WcSGiTNPI6/+ar9wo0lL0MkahPYy3PhwaaiW+OlUiSIgzR9ZA00dzTaj+B/h/w==
X-Received: by 2002:adf:a10c:: with SMTP id o12-v6mr6343885wro.169.1537993164130;
        Wed, 26 Sep 2018 13:19:24 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 200-v6sm738745wmv.6.2018.09.26.13.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 13:19:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
To:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        ulf.hansson@linaro.org, quentin.schulz@free-electrons.com
Cc:     gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        shawn.lin@rock-chips.com, adrian.hunter@intel.com,
        baolin.wang@linaro.org, maxime.ripard@free-electrons.com,
        thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org,
        icenowy@aosc.xyz, wens@csie.org
References: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
 <f9028dcb-c217-4efc-60a7-d0a2c1804a08@exceet.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d9795fde-6bdd-b6fa-da41-839d44df6435@redhat.com>
Date:   Wed, 26 Sep 2018 22:19:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f9028dcb-c217-4efc-60a7-d0a2c1804a08@exceet.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-09-18 16:44, Frieder Schrempf wrote:
> Hi,
> 
> On Fri, Feb 09, 2018 at 03:01:00PM +0100, Ulf Hansson wrote:
>> [...]
>>
>> >> > I'd like to know if any progress has been made on that problem 
> (I may
>> >> > have missed patches).
>> >> > Had you had the time to look at the issue?
>> >>
>> >> I have looked at the issue, but not manage to cook some patches 
> for it.
>> >>
>> >> However, it's on my top of my TODO list for mmc. No promises, but
>> >> perhaps and hopefully I manage to get something posted during the
>> >> coming release cycle.
> 
> I would be interested in a ESP8089 driver in mainline and that's why I want to pick up this discussion.
> 
> What is the current status of the "mmc_reprobe_device" implementation, that Hans was explaining and Ulf wanted to provide some months ago?

Ulf did eventually write a new way to deal with this and then Quentin
did manage to get the esp8089 driver to work with it, the new function
to use for this is added by this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core?id=1433269c4d2461be1f36db5dbb453976b38996ff

I'm not sure what the status of upstreaming the ep8089 driver is now
that we've this in place.

Quentin, do you have a version of the esp8089 driver somewhere
which will work correctly with the new mmc_sw_reset() function?

Also what is the status of adding this driver to say staging?

Regards,

Hans



> 
> BTW, I am not on any of the mailing lists involved, so I tried to recreate the proper mail headers manually for the reply to the correct thread.
> 
> Thanks,
> Frieder
> 
>> >>
>> >
>> > Cool! If you ever need some testing, I'd be glad to test your patches
>> > (even if they are in a draft/RFC state).
>> >
>> > Also, when you send patches, I'd appreciate being Cc'ed so that I can
>> > put my Tested-by :) Thanks!
>>
>> Absolutely! I appreciate it.
