Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35883C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC70A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC70A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJaBWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:22:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:50674 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbeJaBWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:22:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 09:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="87021718"
Received: from agcho-mobl1.amr.corp.intel.com (HELO [10.254.98.112]) ([10.254.98.112])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2018 09:27:52 -0700
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
 <783f17c2-ecc6-00fc-5629-02319b965205@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fe975fde-836a-8d24-46ca-55b02db06b45@linux.intel.com>
Date:   Tue, 30 Oct 2018 11:27:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <783f17c2-ecc6-00fc-5629-02319b965205@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/30/18 11:02 AM, Hans de Goede wrote:
> Hi,
>
> On 30-10-18 16:46, Hans de Goede wrote:
>> Hi,
>>
>> On 30-10-18 16:04, Pierre-Louis Bossart wrote:
>>>
>>> On 10/30/18 9:38 AM, Dean Wallace wrote:
>>>> On 30-10-18, Hans de Goede wrote:
>>>>> Hi Dean,
>>>>>
>>>>> Attached are 2 different attempts at fixing this.
>>>>>
>>>>> When trying these patches do not forget to remove the revert of the
>>>>> "Stop-marking-clocks-as-CLK_IS_CRITICAL" commit.
>>>>>
>>>>> Please first try the 
>>>>> 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch
>>>>> patch I expect that one to do the trick indicating that the Swanky 
>>>>> model
>>>>> uses a different pmc clk then which is normally used for the codec 
>>>>> clock.
>>>>>
>>>>> If that patch does not fix things, please give the other patch a try.
>>>
>>> For Baytrail devices, the audio platform clocks are not managed by 
>>> the firmware. They are for CHT-based devices - as can be seen by 
>>> clock resources being described in the DSDT. We used to have a 
>>> if(baytrail) in the code which was replaced by this CRITICAL label, 
>>> but the point remains that there is a difference between the two SOC 
>>> versions.
>>
>> As I mentioned before the CRITICAL flag was only added a year ago to 
>> workaround
>> an issue with on board ethernet needing plt_clk_4 on some laptops, 
>> this never
>> had anything to do with sound.
>
> Ah I see now that you later made some changes based on the patch to 
> fix the ethernet:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=7735bce05a9c0bb0eb0f08c9002d65843a7c5798 
>
>
> Note though that that does not touch the machine driver which we are 
> discussing
> now and the reporters machine is also BYT based.
>
> As explained below (in my original reply) I think it is fine to always
> manage the clk from within the kernel. But if you think this is a bad
> idea, we could re-introduce the is_valleyview() checks in machine
> drivers which are used on CHT devices.

I am having difficulties following the proposal

for audio, managing the platform clocks from the kernel is only useful 
for Baytrail, and the code handling the CRITICAL flags is really 
equivalent to having a is_valleyview() test in the machine drivers. I 
don't quite understand the S0ix-related changes and I also don't get how 
using plt_clk_0 makes things better or wonder if audio on Swanky worked 
before the commit 7735bce05a9c ('ASoC: Intel: boards: use devm_clk_get() 
unconditionally'.

In other words, I don't know if we are dealing with a platform that only 
started working with 7735bce05a9c and does need a quirk to make use of 
plt_clk_0 or a fundamental issue with clock/power management.


>
>>> In addition I am not aware of any baytrail device using plt_clk_0, 
>>> so moving a common machine driver such a cht_bsw_max98090_ti to use 
>>> plt_clk0 only would break other devices (e.g. Rambi/Orco). Asking 
>>> for both clocks to be on might work though, 
>>
>> Ok, so we need to have a DMI based quirk for the Swanky and maybe also
>> the clapper to use plt_clk_0 there. Asking for 2 clks if we only need
>> one does not seem like a good plan.
>>
>>> however you still have the problem of trying to manage from the 
>>> kernel what the firmware already manages.
>>
>> The firmware only manages it when going to D3 state, with ASoC most of
>> the codecs gets turned off (and we no longer need the clock) but we do
>> not put the device in D3 / execute the _PS3 method. So from a pm pov
>> it is better if we manage the clk ourselves.
>>
>> Once we do actually put the device in D3 (on suspend) the kernel will 
>> have
>> already turned off the clk and the _OFF method of the CLK3 power 
>> resource
>> which directly pokes mmio, will just set the enable bit to 0 when it
>> already is 0, so no problem.
>
> Regards,
>
> Hans
