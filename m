Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBB1ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D9A2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D9A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJ3Xlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:41:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40063 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJ3Xlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:41:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id b203-v6so11635662wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJaGbOdp3+rEMlsEEHHjHKrXU3Zr97J4XEMPjDbKUN0=;
        b=fNRolmCwFzx/D7w7viCPo+37sI9Xw60TTsSpEMdZoMKLv6BBgeM22DoAzy8Qb1dylQ
         tNmFjnZw8k/y4eMGnZK2kMpnnpu+uF6J66mnfCq2CSLzyisVinAE1DQcVUo//3N67SRc
         443lo79kqwcbIQCj5TRzTTjvrbW4eVAMsH9tDgKzhYWLZuplVsLGWf3hgIF7NJDpwJYy
         /KtUzjnn0IesQ0zWZxBw7VZ6BQBVKz6OHyRoTpPPo1sxU4qrd+EwpRFyBsqwMdZwZza6
         FE7a4PuX3jwSttKAkJAXY4FeE6VqrrRV7RO8nGM1Tc0c958IdaOkvVeGYDp7NErXhBSc
         IyDA==
X-Gm-Message-State: AGRZ1gJFP9JUS1xjlCWPFXaemgARdv3kv17xuEy9GU7LOq57pgb47tyF
        +irLhmF04+ee7v0CTJh73/fEkg==
X-Google-Smtp-Source: AJdET5f7kl17EEMjqKJ4aCGKsuy8Qatli8a6E8xfR8KbWzVxlU7CXUY1GHsCUCUVmQWM+BevG6ctXQ==
X-Received: by 2002:a1c:e456:: with SMTP id b83-v6mr2011577wmh.143.1540910887845;
        Tue, 30 Oct 2018 07:48:07 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m192-v6sm5525847wmb.29.2018.10.30.07.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 07:48:07 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Dean Wallace <duffydack73@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
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
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d21fe935-5732-7f8c-2c26-3fc3969b4c1c@redhat.com>
Date:   Tue, 30 Oct 2018 15:48:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181030143836.feo7zcxiestylxoo@picard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-10-18 15:38, Dean Wallace wrote:
> On 30-10-18, Hans de Goede wrote:
>> Hi Dean,
>>
>> Attached are 2 different attempts at fixing this.
>>
>> When trying these patches do not forget to remove the revert of the
>> "Stop-marking-clocks-as-CLK_IS_CRITICAL" commit.
>>
>> Please first try the 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch
>> patch I expect that one to do the trick indicating that the Swanky model
>> uses a different pmc clk then which is normally used for the codec clock.
>>
>> If that patch does not fix things, please give the other patch a try.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>> On 29-10-18 23:03, Pierre-Louis Bossart wrote:
>>>
>>> On 10/29/18 2:08 PM, Dean Wallace wrote:
>>>> On 29-10-18, Andy Shevchenko wrote:
>>>>> On Mon, Oct 29, 2018 at 7:52 PM Andy Shevchenko
>>>>> <andy.shevchenko@gmail.com> wrote:
>>>>>> Cc: Pierre as well.
>>>>>>
>>>>>> On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>>>>>> Quoting Dean Wallace (2018-10-25 16:25:17)
>>>>>>>> I have found a regression in 4.18.15 that means I lose sound on my old
>>>>>>>> Toshiba Chromebook 2 (Swanky).  My system details are:-
>>>>>>>>
>>>>>>>> Toshiba Chromebook (Swanky)
>>>>>>>> MrChromebox UEFI coreboot
>>>>>>>> Arch Linux running latest alsa/pulseaudio
>>>>>>>>
>>>>>>>> Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
>>>>>>>> output I mean, the card is still detected, the module loaded, all apps
>>>>>>>> showing sound is being playing, but no actual audible sound comes
>>>>>>>> through.  Upgraded to 4.18.16 same issue.
>>>>>>>>
>>>>>>>> Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f
>>>>>>>> clk: x86: Stop marking clocks as CLK_IS_CRITICAL
>>>>>>>> "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
>>>>>>>> devices not being able to reach S0i3 greatly decreasing their battery
>>>>>>>> drain when suspended."
>>>>>>>>
>>>>>>>> I reverted it and compiled 4.18.16 and have sound back again.  Could
>>>>>>>> this be looked into, with possibility of fix.
>>>>>>>>
>>>>>>> Thanks for the bug report. I'm adding some people involved in the commit
>>>>>>> you mention is causing audio regressions. The best plan is to probably
>>>>>>> revert the commit from the 4.18 linux stable tree. Or there may be
>>>>>>> another patch missing that would be useful to make this backported patch
>>>>>>> work. Hopefully Hans or Andy knows.
>>>>>> Hans has been investigating S0ix issues on Baytrail and Cherrytrail machines.
>>>>>> I have a feeling that the problem can be fixed by properly handling
>>>>>> clock in ASoC driver(s). Perhaps Hans and Pierre can figure this out
>>>>>> better than me.
>>>>> Looking to sound/soc/intel/boards/cht_bsw_rt5672.c I see no
>>>>> suspend-resume hooks. Perhaps, adding them like in the commit
>>>>> ac8bd9e13be2 ("r8169: Disable clk during suspend / resume") would
>>>>> help.
>>>
>>> I missed this change while i was away. It's indeed the expectation that the audio mclk is handled by the firmware,
>>
>> I believe that the statement "It's indeed the expectation that the
>> audio mclk is handled by the firmware" is not correct for BYT/CHT
>> platforms (and the commit causing the regression only affects BYT/CHT
>> platforms). Various machine drivers under sound/soc/intel/boards have
>> code to deal with the mclk themselves, like this:
>>
>>          drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
>> ...
>>
>>          if (SND_SOC_DAPM_EVENT_ON(event)) {
>>                  ret = clk_prepare_enable(ctx->mclk);
>> 		...
>>          } else {
>>                  clk_disable_unprepare(ctx->mclk);
>>          }
>>
>> The above code is from sound/soc/intel/boards/cht_bsw_max98090_ti.c
>> which is the machine driver used on the machines for which problems
>> are now being reported.
>>
>> And my commit introducing the problem is in essence a revert of:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=d31fd43c0f9a41e2678a1e78c0f22f0384c6edd3
>>
>> Which is from 2017-07-14 and the ASoC code for BYT/CHT platforms is
>> much older then that.
>>
>> Also I asked Carlo why he wrote that patch and it was to fix a problem
>> with ethernet on some laptops.
>>
>>> not sure I understand why removing the CLK_IS_CRITICAL was necessary or what it has to do with S0ix.
>>
>> It is necessary, because if it is set the clock never gets disabled and
>> on x86 platforms using suspend2idle we are responsible for *all* the hardware
>> power-management as OS. If we do not disable the clocks then we can only
>> reach S0i1 instead of S0i3 when suspended leading to increased battery
>> drain during suspend.
>>
>> Also note that this patch is only causing problems on CHT + max98090 codec
>> using machines. I've tested it on many other BYT/CHT machines myself and
>> we've not had any other bug reports related to this.
>>
>> So this clearly points to a problem with the clock management in the
>> cht_bsw_max98090_ti.c machine driver.
>>
>> I've some ideas how to fix this and I will prepare some patches to test.
>>
>> Regards,
>>
>> Hans
> 
> Excellent work Hans.  Compiled 4.19 with
> 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch, sound
> works as before.
> 
> for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat $i/clk_flags; echo; done
> /sys/kernel/debug/clk/pmc_plt_clk_0:
> /sys/kernel/debug/clk/pmc_plt_clk_1:
> /sys/kernel/debug/clk/pmc_plt_clk_2:
> /sys/kernel/debug/clk/pmc_plt_clk_3:
> /sys/kernel/debug/clk/pmc_plt_clk_4:
> /sys/kernel/debug/clk/pmc_plt_clk_5:

Ok, so as I expected the Swanky is using pmc_plt_clk_0
as mclk instead of pmc_plt_clk_3. Now the question
becomes is this true for all the designs using the
max98090 codec?

Mogens, can you give the 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch
a try on your Clapper model, using the SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
kernel option together with the asoundrc from Dean?

I have the feeling that your Clapper is also using the
pmc_plt_clk_0.

Pierre-Louis, as maintainer/reviewer of all the drivers under
sound/soc/intel/boards, how would you like to proceed with this?

I see 2 possible ways forwards:

1) Unconditionally use pmc_plt_clk_0 as mclk (as my test patch does)
in the cht_bsw_max98090_ti.c machine driver

2) Use DMI quirks for the Swansky (and probably also the Clapper) to
use pmc_plt_clk_0 as mclk there while keeping pmc_plt_clk_3 as the
default.

If you (Pierre-Louis) can let me know which solution you prepare then
I can prepare and submit a patch to fix this.

Regards,

Hans
