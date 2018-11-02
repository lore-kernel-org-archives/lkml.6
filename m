Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C09EC6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C5920657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C5920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeKBTeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:34:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38525 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeKBTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:34:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so1444741ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 03:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7oCk1O+cWkPqj8Gi3ahKN8ni52VvJ/3QPKygPx8VqcY=;
        b=hS2+8llSWadO8vaFC9wQLjC4Lk8+aSxDmljpZbFuCfRGCbwtAKP/GJMiLpySlx0J8y
         xVyjzztjeaj04ryvm+CGqsDHtshzsCAob6+iqplPUQ5utV1aN54j5qamGPwd6Bj34BC/
         VDA/r2at8PMgB8L6kya2RLKuMsK/OvqzWvc3AIbYuJPJM5EKcdGZV6XMtp6eZuReEMQ3
         BCdUizjbrIVA4pXjM+w19SQapbQ6LlLBcmthBPCFe538z946ZMkCc1XJwaUT8KpZDsbK
         vBUngGZEvHzhrylqm4FNx/QS6ohTrVsKLttfSfB386z7VL1YjBxQ86gC9F/9LEpWRqEd
         qlsg==
X-Gm-Message-State: AGRZ1gI3iJ+9AN8Ggaq6fWWhrC1RZ0pbSX7Yy0xT7VkvdQyAV64Fg7hq
        Oq2AIYb1+x7vqDCM9oknF78lkw==
X-Google-Smtp-Source: AJdET5ctJ4iJ8rhpTZykmbyBC/epehNAPHAQm9Slwq5SacL3zrL2YZTNAzTPbfR5WeIHrfY34EtJrA==
X-Received: by 2002:a05:6402:759:: with SMTP id p25mr8280840edy.92.1541154458560;
        Fri, 02 Nov 2018 03:27:38 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z11-v6sm710692edh.6.2018.11.02.03.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 03:27:37 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Dean Wallace <duffydack73@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
References: <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
 <20181031200709.xrmu6wsdel7dtcjq@picard>
 <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
 <20181101103705.ay36te4qr5pxtgop@picard>
 <37e44480-44d3-9355-6119-ae46bb38678a@redhat.com>
 <20181101142859.oxtuhbwtt44h2u3r@picard>
 <67a7d54b-49cc-aa4e-fe47-bb6277f02bc8@redhat.com>
 <20181101155036.vkdrc7ajmkyd73o5@picard>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <685e6291-7064-af8d-1211-72796d880f5b@redhat.com>
Date:   Fri, 2 Nov 2018 11:27:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181101155036.vkdrc7ajmkyd73o5@picard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01-11-18 16:50, Dean Wallace wrote:
> On 01-11-18, Hans de Goede wrote:
>> Hi,
>>
>> On 01-11-18 15:28, Dean Wallace wrote:
>>> On 01-11-18, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 01-11-18 11:37, Dean Wallace wrote:
>>>>> On 31-10-18, Pierre-Louis Bossart wrote:
>>>>>>
>>>>>>> Just thought it worth mentioning, this new patch that fixes sound
>>>>>>> again, seems to have ressurected an old issue with PLL unlock.  I'm
>>>>>>> seeing journal entries after fresh boot ......
>>>>>>>
>>>>>>> ```
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> picard systemd[462]: Started Sound Service.
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> picard kernel: max98090_pll_work: 141 callbacks suppressed
>>>>>>> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
>>>>>>> ```
>>>>>>>
>>>>>>> sound is ok, but sometimes plugging in headphones spams journal with
>>>>>>> those PLL messages, and sound turns into "daleks", and I have to
>>>>>>> remove/insert headphones few times or stop/start audio to fix it.
>>>>>>> It's a very old issue, maybe you'd know more about it.
>>>>>>
>>>>>> I noticed this error on my Orco device used for tests many moons ago, but I
>>>>>> could never find out what led to this error case, it wasn't deterministic
>>>>>> and didn't impact the audio quality. All I could do is rate_limit it... If
>>>>>> we have an A vs. B situation it'd be really helpful to diagnose further.
>>>>>>
>>>>>> Is there really a causality between the changes from Hans and this PLL
>>>>>> unlock error? Are you 100% sure this was not present in the previous install
>>>>>> you used (4.18.14 as mentioned earlier in the thread)?
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> -Pierre
>>>>>>
>>>>> Well, numerous boots, kernels, headphone inserting - no PLL or
>>>>> 'Daleks'.  My laptop must have been haunted that day (halloween).
>>>>> I'll put it to bed.
>>>>
>>>> So you can no longer reproduce. Bummer. Note this might be caused by
>>>> the temperature of the laptop when you were running the tests...
>>>>
>>>> Anyways if you hit this again and you can reproduce it, please
>>>> give adding a msleep(10) after code mucking with the clk a try.
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>> Right then, I can make it unlock and 'daleks' by going into
>>> pavucontrol and switching the Profile back and forth from Stereo
>>> Output to Stereo Output+Analog Mono Input, which is actually something
>>> I've done to make it correct itself as well.  I don't use the mic or
>>> anything so I've had it set to Stereo Ouput only which I 'think' has
>>> somehow made it more stable for me.  With all my playing around, one
>>> of the things I did was clean out my .config/pulse folder which meant
>>> by default the 'Profile' in pavucontrol was set to Output+Input, which
>>> seems to help trigger the PLL issue when inserting headphones.
>>>
>>> So what would you like me to do, as I can trigger it on demand it
>>> seems.
>>
>> Please give the attached patch a try (on top of my patch for the clk quirk)
>> and let us know if that fixes these errors.
>>
>> Regards,
>>
>> Hans
>>
> Sorry, it's not being consistent with me  Now, fresh boot again, no errors
> in journal, no errors while plugging/unplugging earphones.  I think it's
> definitely more stable with the profile in pavucontrol set to Output
> only (no + Input), but I can still trigger it by switching it, and it
> never corrects itself until I switch a few more times.

Ok, so there are 2 issues here as I see it:

1) It does not always reproduce
2) It does still reproduce sometimes with the patch, so the patch does not
fix it.

So I think we just have to live with this for now.

Regards,

Hans




