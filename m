Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C81BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D0D218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeLRVom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:44:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43443 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeLRVom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:44:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so15154744eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4YM38h5I7FYM3fZcCUxJRlotVc6EBl5uu1FPsKe3r8=;
        b=iaxnHPYrohHIqQiqvJvMt6D3mj+qxvJa9ucXky7kpA6ASDxvkZUSgN8a2cNLk5qyjv
         haDN6bLb3UsUMayA3mbbmRWr7KeGKZ+DJewQ0QIyGvhxDGZmfVHejIby/2dywuImiKl9
         6gtrtAC7SJGp9Yx1g4y4zfloFTsvRiBO9cZM1WfdpmR07FZjEm6ISbMu6unwyxdT7E4G
         RHEDpedP+WsIgm1mDP+7g0tXOYyEX33LZygwElfzynrc5fwiC/CZ+mT4rIWepFOGSoDR
         3gj1D47S0DFkIAXfpnuL4nRXqRckxrdZpnW8IH5HnRVdAeRpatMQ3XDI1rAIfWUpC8w2
         boFQ==
X-Gm-Message-State: AA+aEWZMX4BbQu9j+SxdZEsqnfOVaFvgeSep0sGxRqkrFBROaMRIjc+Y
        +z61/hd5Yysr6+l7kP9J41/vsA==
X-Google-Smtp-Source: AFSGD/VHkxHMyI/ltmGdbYIuLESE9T25ZVzawZaz1WNlpDqyn8n1Mb+Jxvt12rWJR7J5C+DetMFWVg==
X-Received: by 2002:a05:6402:758:: with SMTP id p24mr18247129edy.92.1545169480431;
        Tue, 18 Dec 2018 13:44:40 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 24sm4713243eds.97.2018.12.18.13.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:44:39 -0800 (PST)
Subject: Re: [RFC/RFT 00/10] i2c: move handling of suspended adapters to the
 core
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <2094a0d4-733f-7f74-abd2-bdb28edd0f80@redhat.com>
 <20181211234102.GA6701@kunai>
 <e8c68ef5-5085-e304-4959-82c4959f4511@redhat.com>
 <20181218201725.2uqfmsethlkasdvc@ninjato>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e6b0ea6-e472-19f2-bb2f-61a1d66e6091@redhat.com>
Date:   Tue, 18 Dec 2018 22:44:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181218201725.2uqfmsethlkasdvc@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-12-18 21:17, Wolfram Sang wrote:
> Hans, all,
> 
>>> ... this. I don't know what these flags do (and reading SMART in there
>>> gives me more a 'uh-oh' feeling)
>>
>> On x86 the lines between runtime suspend and system-suspend are blurring
>> with technologies like "connected standby" and in general devices moving
>> to suspend2idle as system-suspend state, I guess this also applies to
>> modern smartphone platforms but I'm not following those closely.
> 
> I'd guess so, too. I am not aware of any existing mechanism for that at
> the moment, though. If somebody does, please enlighten us.
> 
>> The "SMART" bit is really not all that smart, SMART_PREPARE means that
>> the drivers pm prepare callback will return positive non 0 (e.g. 1) to
>> indicate that the device may not be kept in its runtime suspended
>> state when transitioning to system-suspend, otoh when the prepare
>> callback returns 0 and the SMART_PREPARE flag is set then *all* suspend/
>> resume handling can be skipped during a system suspend.
> 
> Thanks for the detailed explanation! Much appreciated.
> 
>>> Looking at the open coded version you did for the designware driver, I
>>> wonder now if it is better to just leave it at driver level? Need to
>>> sleep over it, though.
>>
>> I myself was thinking in the same direction (leave the entire suspended
>> check at the driver level).
> 
> So, I was giving it some more thoughts, and my feeling is to still apply
> this series with the review comments addressed. Plus, clearly mark the
> new 'is_suspended' flag and the helper function as *optional* to allow
> for driver specific solutions as well. The then-to-be-added
> documentation would state that it is mostly useful for seperated system
> suspend and runtime suspend. For more complex situations, custom
> solutions are accepted, too. Which means your patch for designware
> should be added to the series.
> 
> My take is there are enough drivers out there already which can benefit
> from this new helper. If it turns out to be useless somewhen in the
> future, we can still remove it.
> 
> What do you (and all others, of course) think?

I've been thinking along the same lines: your series for the drivers
with separate runtime and system suspend handlers, "custom" driver
specific code for troublesome cases like i2c-designware.

Do you want me to send out a new version of my patch for the i2c-designware
code?

Regards,

Hans
