Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA753C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DE92082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DE92082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeJ3Gxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:53:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:1494 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbeJ3Gxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:53:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 15:03:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="99794029"
Received: from skoshy-mobl.amr.corp.intel.com (HELO [10.254.176.31]) ([10.254.176.31])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2018 15:03:12 -0700
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Dean Wallace <duffydack73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181025232517.ywnw54qibemosjws@picard>
 <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
Date:   Mon, 29 Oct 2018 17:03:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029190819.2ivlx73n6y6sx4vk@picard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/29/18 2:08 PM, Dean Wallace wrote:
> On 29-10-18, Andy Shevchenko wrote:
>> On Mon, Oct 29, 2018 at 7:52 PM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> Cc: Pierre as well.
>>>
>>> On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>>> Quoting Dean Wallace (2018-10-25 16:25:17)
>>>>> I have found a regression in 4.18.15 that means I lose sound on my old
>>>>> Toshiba Chromebook 2 (Swanky).  My system details are:-
>>>>>
>>>>> Toshiba Chromebook (Swanky)
>>>>> MrChromebox UEFI coreboot
>>>>> Arch Linux running latest alsa/pulseaudio
>>>>>
>>>>> Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
>>>>> output I mean, the card is still detected, the module loaded, all apps
>>>>> showing sound is being playing, but no actual audible sound comes
>>>>> through.  Upgraded to 4.18.16 same issue.
>>>>>
>>>>> Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f
>>>>> clk: x86: Stop marking clocks as CLK_IS_CRITICAL
>>>>> "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
>>>>> devices not being able to reach S0i3 greatly decreasing their battery
>>>>> drain when suspended."
>>>>>
>>>>> I reverted it and compiled 4.18.16 and have sound back again.  Could
>>>>> this be looked into, with possibility of fix.
>>>>>
>>>> Thanks for the bug report. I'm adding some people involved in the commit
>>>> you mention is causing audio regressions. The best plan is to probably
>>>> revert the commit from the 4.18 linux stable tree. Or there may be
>>>> another patch missing that would be useful to make this backported patch
>>>> work. Hopefully Hans or Andy knows.
>>> Hans has been investigating S0ix issues on Baytrail and Cherrytrail machines.
>>> I have a feeling that the problem can be fixed by properly handling
>>> clock in ASoC driver(s). Perhaps Hans and Pierre can figure this out
>>> better than me.
>> Looking to sound/soc/intel/boards/cht_bsw_rt5672.c I see no
>> suspend-resume hooks. Perhaps, adding them like in the commit
>> ac8bd9e13be2 ("r8169: Disable clk during suspend / resume") would
>> help.

I missed this change while i was away. It's indeed the expectation that 
the audio mclk is handled by the firmware, not sure I understand why 
removing the CLK_IS_CRITICAL was necessary or what it has to do with S0ix.


>>
>> Btw, what the drivers are in use for the machine you have? It's better
>> you run alsa-info.sh or alike to collect necessary information along
>> with output of `lsmod`, `dmesg`, etc.
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
> alsa-info.txt [1], cpuinfo [2], dmesg [3], and 'ls /sys/bus/i2c/devices' [4]
> [1] https://gist.github.com/duffydack/480be8ddced44515dbf981dc09f593ec#file-alsa-info
> [2] https://gist.github.com/duffydack/480be8ddced44515dbf981dc09f593ec#file-cpuinfo-log
> [3] https://gist.github.com/duffydack/480be8ddced44515dbf981dc09f593ec#file-dmesg-log
> [4] https://gist.github.com/duffydack/480be8ddced44515dbf981dc09f593ec#file-sys-bus-i2c-devices-log
>
> Regards
