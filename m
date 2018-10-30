Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52472C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220F620827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220F620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJ3TKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:10:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55275 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbeJ3TKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:10:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so11140388wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iowrjOHigZyHV14gi4opNhkelmQgYGB7cDkGuQYssT8=;
        b=AhIkdactcQUVYpuspVBiTrNP8ZwsSIPWs567rbdWPiy/4QrEuz4U6Iupb/diu48t+O
         wW202RVydIoK7X7UmzQEw6qdj3VdnIFUhED2T/cLIqzPYZdjNy0hlL8XraZylHwDyzFQ
         S44ewP4SyIHVvrO5gzPSrQU+V9povPJzRVY8flGrZlZ7Z0U29YKKcHpupZ4qw7Z/ndbK
         AXLaVCrPAYEAh2FF7iLDeCOdqaJBg52I1cqJMR4wUmNBFJkTI2Xzj3ynCQpCocQVub5I
         TGu9kFLEKdlSGwTw0Iaw8bwnoUBPHDl2Ck0djVACXqJaIYQZwiddXYIkmTk/J38li62N
         mikg==
X-Gm-Message-State: AGRZ1gILR6iZCZzBDCmyMlXnnDGBJdxh2MuhNP6NrknmLY72E1bFXmaQ
        hIE/bHJ+ldRfoCnAgTsPMs71OYnMgyg=
X-Google-Smtp-Source: AJdET5fq3jY0THeP+PJ1FHkT+xNZbprkT39PzR32cQbJS2oRmOAXwWwHMx+vdn1APFKxZiag55CmSQ==
X-Received: by 2002:a1c:950f:: with SMTP id x15-v6mr1179865wmd.3.1540894666060;
        Tue, 30 Oct 2018 03:17:46 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t198-v6sm23486713wmd.9.2018.10.30.03.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 03:17:45 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181025232517.ywnw54qibemosjws@picard>
 <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ac7720fd-ed2e-dd77-d60b-7ab535daf167@redhat.com>
Date:   Tue, 30 Oct 2018 11:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Louis,

On 29-10-18 23:03, Pierre-Louis Bossart wrote:
> 
> On 10/29/18 2:08 PM, Dean Wallace wrote:
>> On 29-10-18, Andy Shevchenko wrote:
>>> On Mon, Oct 29, 2018 at 7:52 PM Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> Cc: Pierre as well.
>>>>
>>>> On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>>>> Quoting Dean Wallace (2018-10-25 16:25:17)
>>>>>> I have found a regression in 4.18.15 that means I lose sound on my old
>>>>>> Toshiba Chromebook 2 (Swanky).  My system details are:-
>>>>>>
>>>>>> Toshiba Chromebook (Swanky)
>>>>>> MrChromebox UEFI coreboot
>>>>>> Arch Linux running latest alsa/pulseaudio
>>>>>>
>>>>>> Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
>>>>>> output I mean, the card is still detected, the module loaded, all apps
>>>>>> showing sound is being playing, but no actual audible sound comes
>>>>>> through.  Upgraded to 4.18.16 same issue.
>>>>>>
>>>>>> Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f
>>>>>> clk: x86: Stop marking clocks as CLK_IS_CRITICAL
>>>>>> "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
>>>>>> devices not being able to reach S0i3 greatly decreasing their battery
>>>>>> drain when suspended."
>>>>>>
>>>>>> I reverted it and compiled 4.18.16 and have sound back again.  Could
>>>>>> this be looked into, with possibility of fix.
>>>>>>
>>>>> Thanks for the bug report. I'm adding some people involved in the commit
>>>>> you mention is causing audio regressions. The best plan is to probably
>>>>> revert the commit from the 4.18 linux stable tree. Or there may be
>>>>> another patch missing that would be useful to make this backported patch
>>>>> work. Hopefully Hans or Andy knows.
>>>> Hans has been investigating S0ix issues on Baytrail and Cherrytrail machines.
>>>> I have a feeling that the problem can be fixed by properly handling
>>>> clock in ASoC driver(s). Perhaps Hans and Pierre can figure this out
>>>> better than me.
>>> Looking to sound/soc/intel/boards/cht_bsw_rt5672.c I see no
>>> suspend-resume hooks. Perhaps, adding them like in the commit
>>> ac8bd9e13be2 ("r8169: Disable clk during suspend / resume") would
>>> help.
> 
> I missed this change while i was away. It's indeed the expectation that the audio mclk is handled by the firmware,

I believe that the statement "It's indeed the expectation that the
audio mclk is handled by the firmware" is not correct for BYT/CHT
platforms (and the commit causing the regression only affects BYT/CHT
platforms). Various machine drivers under sound/soc/intel/boards have
code to deal with the mclk themselves, like this:

         drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
...

         if (SND_SOC_DAPM_EVENT_ON(event)) {
                 ret = clk_prepare_enable(ctx->mclk);
		...
         } else {
                 clk_disable_unprepare(ctx->mclk);
         }

The above code is from sound/soc/intel/boards/cht_bsw_max98090_ti.c
which is the machine driver used on the machines for which problems
are now being reported.

And my commit introducing the problem is in essence a revert of:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=d31fd43c0f9a41e2678a1e78c0f22f0384c6edd3

Which is from 2017-07-14 and the ASoC code for BYT/CHT platforms is
much older then that.

Also I asked Carlo why he wrote that patch and it was to fix a problem
with ethernet on some laptops.

> not sure I understand why removing the CLK_IS_CRITICAL was necessary or what it has to do with S0ix.

It is necessary, because if it is set the clock never gets disabled and
on x86 platforms using suspend2idle we are responsible for *all* the hardware
power-management as OS. If we do not disable the clocks then we can only
reach S0i1 instead of S0i3 when suspended leading to increased battery
drain during suspend.

Also note that this patch is only causing problems on CHT + max98090 codec
using machines. I've tested it on many other BYT/CHT machines myself and
we've not had any other bug reports related to this.

So this clearly points to a problem with the clock management in the
cht_bsw_max98090_ti.c machine driver.

I've some ideas how to fix this and I will prepare some patches to test.

Regards,

Hans
