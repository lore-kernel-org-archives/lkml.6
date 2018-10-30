Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42B3C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD0120664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD0120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJaA6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:58:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:41196 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeJaA6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:58:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 09:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="92418107"
Received: from mevans-mobl2.amr.corp.intel.com (HELO [10.255.70.41]) ([10.255.70.41])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Oct 2018 09:03:55 -0700
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Hans de Goede <hdegoede@redhat.com>,
        Dean Wallace <duffydack73@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eb36638a-fd76-cb69-ba9f-b02248301702@linux.intel.com>
Date:   Tue, 30 Oct 2018 11:03:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/30/18 10:46 AM, Hans de Goede wrote:
> Hi,
>
> On 30-10-18 16:04, Pierre-Louis Bossart wrote:
>>
>> On 10/30/18 9:38 AM, Dean Wallace wrote:
>>> On 30-10-18, Hans de Goede wrote:
>>>> Hi Dean,
>>>>
>>>> Attached are 2 different attempts at fixing this.
>>>>
>>>> When trying these patches do not forget to remove the revert of the
>>>> "Stop-marking-clocks-as-CLK_IS_CRITICAL" commit.
>>>>
>>>> Please first try the 
>>>> 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch
>>>> patch I expect that one to do the trick indicating that the Swanky 
>>>> model
>>>> uses a different pmc clk then which is normally used for the codec 
>>>> clock.
>>>>
>>>> If that patch does not fix things, please give the other patch a try.
>>
>> For Baytrail devices, the audio platform clocks are not managed by 
>> the firmware. They are for CHT-based devices - as can be seen by 
>> clock resources being described in the DSDT. We used to have a 
>> if(baytrail) in the code which was replaced by this CRITICAL label, 
>> but the point remains that there is a difference between the two SOC 
>> versions.
>
> As I mentioned before the CRITICAL flag was only added a year ago to 
> workaround
> an issue with on board ethernet needing plt_clk_4 on some laptops, 
> this never
> had anything to do with sound.

see commit 7735bce05a9c ('ASoC: Intel: boards: use devm_clk_get() 
unconditionally')

>
>> In addition I am not aware of any baytrail device using plt_clk_0, so 
>> moving a common machine driver such a cht_bsw_max98090_ti to use 
>> plt_clk0 only would break other devices (e.g. Rambi/Orco). Asking for 
>> both clocks to be on might work though, 
>
> Ok, so we need to have a DMI based quirk for the Swanky and maybe also
> the clapper to use plt_clk_0 there. Asking for 2 clks if we only need
> one does not seem like a good plan.
>
>> however you still have the problem of trying to manage from the 
>> kernel what the firmware already manages.
>
> The firmware only manages it when going to D3 state, with ASoC most of
> the codecs gets turned off (and we no longer need the clock) but we do
> not put the device in D3 / execute the _PS3 method. So from a pm pov
> it is better if we manage the clk ourselves.
>
> Once we do actually put the device in D3 (on suspend) the kernel will 
> have
> already turned off the clk and the _OFF method of the CLK3 power resource
> which directly pokes mmio, will just set the enable bit to 0 when it
> already is 0, so no problem.
>
> Regards,
>
> Hans
>
>
>
>
>
>
>
>>
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>>>
>>>>
>>>> On 29-10-18 23:03, Pierre-Louis Bossart wrote:
>>>>> On 10/29/18 2:08 PM, Dean Wallace wrote:
>>>>>> On 29-10-18, Andy Shevchenko wrote:
>>>>>>> On Mon, Oct 29, 2018 at 7:52 PM Andy Shevchenko
>>>>>>> <andy.shevchenko@gmail.com> wrote:
>>>>>>>> Cc: Pierre as well.
>>>>>>>>
>>>>>>>> On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> 
>>>>>>>> wrote:
>>>>>>>>> Quoting Dean Wallace (2018-10-25 16:25:17)
>>>>>>>>>> I have found a regression in 4.18.15 that means I lose sound 
>>>>>>>>>> on my old
>>>>>>>>>> Toshiba Chromebook 2 (Swanky).  My system details are:-
>>>>>>>>>>
>>>>>>>>>> Toshiba Chromebook (Swanky)
>>>>>>>>>> MrChromebox UEFI coreboot
>>>>>>>>>> Arch Linux running latest alsa/pulseaudio
>>>>>>>>>>
>>>>>>>>>> Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound 
>>>>>>>>>> output.  By
>>>>>>>>>> output I mean, the card is still detected, the module loaded, 
>>>>>>>>>> all apps
>>>>>>>>>> showing sound is being playing, but no actual audible sound 
>>>>>>>>>> comes
>>>>>>>>>> through.  Upgraded to 4.18.16 same issue.
>>>>>>>>>>
>>>>>>>>>> Dug around and found Upstream commit 
>>>>>>>>>> 648e921888ad96ea3dc922739e96716ad3225d7f
>>>>>>>>>> clk: x86: Stop marking clocks as CLK_IS_CRITICAL
>>>>>>>>>> "This commit removes the CLK_IS_CRITICAL marking, fixing 
>>>>>>>>>> Cherry Trail
>>>>>>>>>> devices not being able to reach S0i3 greatly decreasing their 
>>>>>>>>>> battery
>>>>>>>>>> drain when suspended."
>>>>>>>>>>
>>>>>>>>>> I reverted it and compiled 4.18.16 and have sound back 
>>>>>>>>>> again.  Could
>>>>>>>>>> this be looked into, with possibility of fix.
>>>>>>>>>>
>>>>>>>>> Thanks for the bug report. I'm adding some people involved in 
>>>>>>>>> the commit
>>>>>>>>> you mention is causing audio regressions. The best plan is to 
>>>>>>>>> probably
>>>>>>>>> revert the commit from the 4.18 linux stable tree. Or there 
>>>>>>>>> may be
>>>>>>>>> another patch missing that would be useful to make this 
>>>>>>>>> backported patch
>>>>>>>>> work. Hopefully Hans or Andy knows.
>>>>>>>> Hans has been investigating S0ix issues on Baytrail and 
>>>>>>>> Cherrytrail machines.
>>>>>>>> I have a feeling that the problem can be fixed by properly 
>>>>>>>> handling
>>>>>>>> clock in ASoC driver(s). Perhaps Hans and Pierre can figure 
>>>>>>>> this out
>>>>>>>> better than me.
>>>>>>> Looking to sound/soc/intel/boards/cht_bsw_rt5672.c I see no
>>>>>>> suspend-resume hooks. Perhaps, adding them like in the commit
>>>>>>> ac8bd9e13be2 ("r8169: Disable clk during suspend / resume") would
>>>>>>> help.
>>>>> I missed this change while i was away. It's indeed the expectation 
>>>>> that the audio mclk is handled by the firmware,
>>>> I believe that the statement "It's indeed the expectation that the
>>>> audio mclk is handled by the firmware" is not correct for BYT/CHT
>>>> platforms (and the commit causing the regression only affects BYT/CHT
>>>> platforms). Various machine drivers under sound/soc/intel/boards have
>>>> code to deal with the mclk themselves, like this:
>>>>
>>>>          drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
>>>> ...
>>>>
>>>>          if (SND_SOC_DAPM_EVENT_ON(event)) {
>>>>                  ret = clk_prepare_enable(ctx->mclk);
>>>>         ...
>>>>          } else {
>>>>                  clk_disable_unprepare(ctx->mclk);
>>>>          }
>>>>
>>>> The above code is from sound/soc/intel/boards/cht_bsw_max98090_ti.c
>>>> which is the machine driver used on the machines for which problems
>>>> are now being reported.
>>>>
>>>> And my commit introducing the problem is in essence a revert of:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=d31fd43c0f9a41e2678a1e78c0f22f0384c6edd3 
>>>>
>>>>
>>>> Which is from 2017-07-14 and the ASoC code for BYT/CHT platforms is
>>>> much older then that.
>>>>
>>>> Also I asked Carlo why he wrote that patch and it was to fix a problem
>>>> with ethernet on some laptops.
>>>>
>>>>> not sure I understand why removing the CLK_IS_CRITICAL was 
>>>>> necessary or what it has to do with S0ix.
>>>> It is necessary, because if it is set the clock never gets disabled 
>>>> and
>>>> on x86 platforms using suspend2idle we are responsible for *all* 
>>>> the hardware
>>>> power-management as OS. If we do not disable the clocks then we can 
>>>> only
>>>> reach S0i1 instead of S0i3 when suspended leading to increased battery
>>>> drain during suspend.
>>>>
>>>> Also note that this patch is only causing problems on CHT + 
>>>> max98090 codec
>>>> using machines. I've tested it on many other BYT/CHT machines 
>>>> myself and
>>>> we've not had any other bug reports related to this.
>>>>
>>>> So this clearly points to a problem with the clock management in the
>>>> cht_bsw_max98090_ti.c machine driver.
>>>>
>>>> I've some ideas how to fix this and I will prepare some patches to 
>>>> test.
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>> Excellent work Hans.  Compiled 4.19 with
>>> 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch, sound
>>> works as before.
>>>
>>> for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat 
>>> $i/clk_flags; echo; done
>>> /sys/kernel/debug/clk/pmc_plt_clk_0:
>>> /sys/kernel/debug/clk/pmc_plt_clk_1:
>>> /sys/kernel/debug/clk/pmc_plt_clk_2:
>>> /sys/kernel/debug/clk/pmc_plt_clk_3:
>>> /sys/kernel/debug/clk/pmc_plt_clk_4:
>>> /sys/kernel/debug/clk/pmc_plt_clk_5:
>>>
>>> Regards
