Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FCC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D2D20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D2D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJ3T6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:58:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39678 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeJ3T6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:58:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so12087842wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 04:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pq3egYQUyuuJbhC2nWzxHhInwWV28VvPoPKdYpujsls=;
        b=cQnR4NQP4RtA65+gQK2KPaUzuhropX32uLHzE8M0YgM07Rr4ArCGICSdmQWzKsA6Xl
         uBepBRvSKcAksTcNDy2VP6/S+tQaEpaoN8/AyqiBSY1hwkwiSY02742zzEN0XI1dqwCI
         EVSnLzSWxONIQLF4tY3yXvcIlX5tJMAuj7uLoQE1rf4vkdPkqEkDYLeyQsA3a4WHeXqu
         7dpfpOwMs7idqBevBkb38RpCq1JF6Y9qh2pBJfyKMGMFNiG5vdCd1+5B4T/irEKXW8KM
         d35VfnyD/Qac4qvqJxyay4RVIndzlhZsGW0/cEOj+01dgWSO1z957NQvktAo8XIw30BE
         UA/A==
X-Gm-Message-State: AGRZ1gLmqo2EUW+tA4WPrMyhmeuBGxhNMSwg9Ur+P2pDZIi0rh/tXS+y
        vMBE1Wbw1/RPW9sTVNzD4Quw0g==
X-Google-Smtp-Source: AJdET5fVVcRKSuITJ04gkn74HBq3qrHApzt948QR12YD8cvI1N1pX1/4/MmOGkoHC9Zs8yNkWMI3kA==
X-Received: by 2002:a5d:4d81:: with SMTP id b1-v6mr19230463wru.80.1540897505393;
        Tue, 30 Oct 2018 04:05:05 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r16-v6sm21258596wrv.21.2018.10.30.04.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 04:05:04 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dean Wallace <duffydack73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
References: <20181025232517.ywnw54qibemosjws@picard>
 <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <ac7720fd-ed2e-dd77-d60b-7ab535daf167@redhat.com>
Message-ID: <2696c9c2-29f7-18cf-1893-bd2fc2f203f9@redhat.com>
Date:   Tue, 30 Oct 2018 12:05:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ac7720fd-ed2e-dd77-d60b-7ab535daf167@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-10-18 11:17, Hans de Goede wrote:
> Hi Pierre-Louis,
> 
> On 29-10-18 23:03, Pierre-Louis Bossart wrote:
>>
>> On 10/29/18 2:08 PM, Dean Wallace wrote:
>>> On 29-10-18, Andy Shevchenko wrote:
>>>> On Mon, Oct 29, 2018 at 7:52 PM Andy Shevchenko
>>>> <andy.shevchenko@gmail.com> wrote:
>>>>> Cc: Pierre as well.
>>>>>
>>>>> On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>>>>> Quoting Dean Wallace (2018-10-25 16:25:17)
>>>>>>> I have found a regression in 4.18.15 that means I lose sound on my old
>>>>>>> Toshiba Chromebook 2 (Swanky).  My system details are:-
>>>>>>>
>>>>>>> Toshiba Chromebook (Swanky)
>>>>>>> MrChromebox UEFI coreboot
>>>>>>> Arch Linux running latest alsa/pulseaudio
>>>>>>>
>>>>>>> Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
>>>>>>> output I mean, the card is still detected, the module loaded, all apps
>>>>>>> showing sound is being playing, but no actual audible sound comes
>>>>>>> through.  Upgraded to 4.18.16 same issue.
>>>>>>>
>>>>>>> Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f
>>>>>>> clk: x86: Stop marking clocks as CLK_IS_CRITICAL
>>>>>>> "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
>>>>>>> devices not being able to reach S0i3 greatly decreasing their battery
>>>>>>> drain when suspended."
>>>>>>>
>>>>>>> I reverted it and compiled 4.18.16 and have sound back again.  Could
>>>>>>> this be looked into, with possibility of fix.
>>>>>>>
>>>>>> Thanks for the bug report. I'm adding some people involved in the commit
>>>>>> you mention is causing audio regressions. The best plan is to probably
>>>>>> revert the commit from the 4.18 linux stable tree. Or there may be
>>>>>> another patch missing that would be useful to make this backported patch
>>>>>> work. Hopefully Hans or Andy knows.
>>>>> Hans has been investigating S0ix issues on Baytrail and Cherrytrail machines.
>>>>> I have a feeling that the problem can be fixed by properly handling
>>>>> clock in ASoC driver(s). Perhaps Hans and Pierre can figure this out
>>>>> better than me.
>>>> Looking to sound/soc/intel/boards/cht_bsw_rt5672.c I see no
>>>> suspend-resume hooks. Perhaps, adding them like in the commit
>>>> ac8bd9e13be2 ("r8169: Disable clk during suspend / resume") would
>>>> help.
>>
>> I missed this change while i was away. It's indeed the expectation that the audio mclk is handled by the firmware,
> 
> I believe that the statement "It's indeed the expectation that the
> audio mclk is handled by the firmware" is not correct for BYT/CHT
> platforms (and the commit causing the regression only affects BYT/CHT
> platforms). Various machine drivers under sound/soc/intel/boards have
> code to deal with the mclk themselves, like this:
> 
>          drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
> ...
> 
>          if (SND_SOC_DAPM_EVENT_ON(event)) {
>                  ret = clk_prepare_enable(ctx->mclk);
>          ...
>          } else {
>                  clk_disable_unprepare(ctx->mclk);
>          }
> 
> The above code is from sound/soc/intel/boards/cht_bsw_max98090_ti.c
> which is the machine driver used on the machines for which problems
> are now being reported.
> 
> And my commit introducing the problem is in essence a revert of:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=d31fd43c0f9a41e2678a1e78c0f22f0384c6edd3
> 
> Which is from 2017-07-14 and the ASoC code for BYT/CHT platforms is
> much older then that.
> 
> Also I asked Carlo why he wrote that patch and it was to fix a problem
> with ethernet on some laptops.
> 
>> not sure I understand why removing the CLK_IS_CRITICAL was necessary or what it has to do with S0ix.
> 
> It is necessary, because if it is set the clock never gets disabled and
> on x86 platforms using suspend2idle we are responsible for *all* the hardware
> power-management as OS. If we do not disable the clocks then we can only
> reach S0i1 instead of S0i3 when suspended leading to increased battery
> drain during suspend.
> 
> Also note that this patch is only causing problems on CHT + max98090 codec
> using machines. I've tested it on many other BYT/CHT machines myself and
> we've not had any other bug reports related to this.
> 
> So this clearly points to a problem with the clock management in the
> cht_bsw_max98090_ti.c machine driver.
> 
> I've some ideas how to fix this and I will prepare some patches to test.

p.s.

It seems that a sub-thread of this thread where me and the reporter have
been working on debugging this has lost most of the people in the Cc.

So here is a quick status update. So far this issue has been seen on
Swanky and Clapper model chromebooks.

Reverting the patch causing this regression and then doing:

for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat $i/clk_flags; echo; done

has shown that before my patch to not set CLK_IS_CRITICAL the
CLK_IS_CRITICAL was being set on pmc_plt_clk_0. Which shows
that that clock is somehow being used for sounds on these boards.

I think that pmc_plt_clk_0 is being used instead of pmc_plt_clk_3,
but it could also be the case that both are being used.

I'm currently preparing patches to test both scenarios.

Regards,

Hans
