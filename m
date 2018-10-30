Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15602C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A092081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A092081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeJaD00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:26:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33051 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbeJaD0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:26:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so12507944wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DFsFFLjRXDGHuUWoOloyRgpJvoEH8MXDHnD+qyam8/4=;
        b=CkNfFP/SS8p4TG+0B3Cp2FiEmsDu0uHb+fp4yzq70gJRjS4hRdGSUiyEPVAETJLx/w
         LHqCZNItVeIKD6lNszfJTn5jw+tYS/NoSoZhBhJcL3zIInDAstG69YQzvSbMEjT6DxHh
         Uj4U35UiQ7upYei6QHfa6Jw/ppWbg/YyOHMcm5Zfw3fJP2WuZTCcdnDAftvjDJ9jGGDQ
         EZtub9gdV3CQ3lOb4oZKi1JC36QW0iNIVe0Hg2v4J9LvafXqXZb4cAgmHXp1GSK4AO1j
         sFIoeqrgSDE9/P5VRNM8q2MftqA0vvZf9cKleBjwQYLzXhKLPBaxjXeoea12Pxtk3a6F
         5ijw==
X-Gm-Message-State: AGRZ1gKQnx336o+9yCdyMvILKHRw1FK5kbSsWsy61LnoV4Pnx+7HUaYm
        F3PXWhjHCY/1azQT8M+9Ibv37g==
X-Google-Smtp-Source: AJdET5dOfR/+itHEF2hfqEdIn6ADZ3mt1Tz2WeLCQS/L20kTmZXjJ4tiZB8GtheM08vc2DVBFiVZZw==
X-Received: by 2002:a1c:9b4b:: with SMTP id d72-v6mr15816wme.72.1540924306273;
        Tue, 30 Oct 2018 11:31:46 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x8-v6sm61689685wrd.54.2018.10.30.11.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:31:45 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
 <fe975fde-836a-8d24-46ca-55b02db06b45@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <be955ec5-7f37-3fd8-658d-c2070e46a0cb@redhat.com>
Date:   Tue, 30 Oct 2018 19:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fe975fde-836a-8d24-46ca-55b02db06b45@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Louis,

On 30-10-18 17:27, Pierre-Louis Bossart wrote:
> 
> On 10/30/18 11:02 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 30-10-18 16:46, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 30-10-18 16:04, Pierre-Louis Bossart wrote:
>>>>
>>>> On 10/30/18 9:38 AM, Dean Wallace wrote:
>>>>> On 30-10-18, Hans de Goede wrote:
>>>>>> Hi Dean,
>>>>>>
>>>>>> Attached are 2 different attempts at fixing this.
>>>>>>
>>>>>> When trying these patches do not forget to remove the revert of the
>>>>>> "Stop-marking-clocks-as-CLK_IS_CRITICAL" commit.
>>>>>>
>>>>>> Please first try the 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch
>>>>>> patch I expect that one to do the trick indicating that the Swanky model
>>>>>> uses a different pmc clk then which is normally used for the codec clock.
>>>>>>
>>>>>> If that patch does not fix things, please give the other patch a try.
>>>>
>>>> For Baytrail devices, the audio platform clocks are not managed by the firmware. They are for CHT-based devices - as can be seen by clock resources being described in the DSDT. We used to have a if(baytrail) in the code which was replaced by this CRITICAL label, but the point remains that there is a difference between the two SOC versions.
>>>
>>> As I mentioned before the CRITICAL flag was only added a year ago to workaround
>>> an issue with on board ethernet needing plt_clk_4 on some laptops, this never
>>> had anything to do with sound.
>>
>> Ah I see now that you later made some changes based on the patch to fix the ethernet:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=7735bce05a9c0bb0eb0f08c9002d65843a7c5798
>>
>> Note though that that does not touch the machine driver which we are discussing
>> now and the reporters machine is also BYT based.
>>
>> As explained below (in my original reply) I think it is fine to always
>> manage the clk from within the kernel. But if you think this is a bad
>> idea, we could re-introduce the is_valleyview() checks in machine
>> drivers which are used on CHT devices.
> 
> I am having difficulties following the proposal
> 
> for audio, managing the platform clocks from the kernel is only useful for Baytrail, and the code handling the CRITICAL flags is really equivalent to having a is_valleyview() test in the machine drivers. I don't quite understand the S0ix-related changes and I also don't get how using plt_clk_0 makes things better or wonder if audio on Swanky worked before the commit 7735bce05a9c ('ASoC: Intel: boards: use devm_clk_get() unconditionally'.
> 
> In other words, I don't know if we are dealing with a platform that only started working with 7735bce05a9c and does need a quirk to make use of plt_clk_0 or a fundamental issue with clock/power management.

Ok let me try to clarify this by breaking this out into the 3 separate
things which I believe are in play here:


1) The PMC clocks should NOT be marked as CLK_IS_CRITICAL

Commit d31fd43c0f9a ("clk: x86: Do not gate clocks enabled by the firmware")
should, in hindsight, never have been merged. CLK_IS_CRITICAL disables all
management of the clk in question and is really intended for clks which are
e.g. driving the CPU core itself or DRAM. The proper fix for the ethernet
problem that patch was meant to address is for the ethernet driver to get
and enable the clock itself. As I've done in a recent series which has as
purpose to revert d31fd43c0f9a.

d31fd43c0f9a marks any PMC clock which is enabled by the firmware as boot
as critical, not only the codec mclk, but *any* clk.  This means that unless
all clks which are enabled at boot are controlled by the firmware as
either ACPI pwr-resources, or by a device's _PS3 method, some clks will
stay on during suspend, see e.g. :

https://bugzilla.kernel.org/show_bug.cgi?id=193891#c102
https://bugzilla.kernel.org/show_bug.cgi?id=196861

Also on BYT this means that if the firmware has enabled the coded mclk at
boot it will get marked as CLK_IS_CRITICAL and we will now never disable it.

If some clocks are still on during suspend then the SoC cannot reach its
deepest sleep states while suspended, which obviously is bad.

TL;DR: CLK_IS_CRITICAL block reaching the deepest sleep states so
d31fd43c0f9a needs to be reverted.


2) Dropping the CLK_IS_CRITICAL flag means we are now also controlling
the codec mclk on CHT.

Just like setting the CLK_IS_CRITICAL flag on the mclk meant that we were
effectively no longer controlling the mclk on BYT, reverting this change
combined with your 7735bce05a9c ("ASoC: Intel: boards: use devm_clk_get()
unconditionally") change means that we are now controlling the mclk on
CHT platforms.

As you point out the firmware also controls the mclk on these platforms,
so arguably this is undesirable. As I tried to explain I do not believe
that this is actually a problem. But if you think this is a problem then
we will need to revert 7735bce05a9c. If you prefer to go that route then
I can prepare a patch for this.


3) No longer marking PMC clocks enabled at boot as CLK_IS_CRITICAL has
caused a regression on Swanky and Clapper model chromebooks

You wrote: "I wonder if audio on Swanky worked before the commit 7735bce05a9c"
I don't think that that commit has impacted Swanky at all since Swanky is BYT
based. Instead I believe that d31fd43c0f9a ("clk: x86: Do not gate clocks
enabled by the firmware") has accidentally fixed audio on Swanky laptops.
This also explains why my "Stop-marking-clocks-as-CLK_IS_CRITICAL" commit
has broken it again as that is effectively a revert of d31fd43c0f9.

As I wrote before the as a result of d31fd43c0f9a the clk enable/disable
behavior is not only ignored on CHT, as you noticed when writing 7735bce05a9c,
but it also causes it to be ignored on BYT, including the initial disable of
unused clocks just before the kernel starts /sbin/init. This not only fixed
the ethernet on the laptop model that d31fd43c0f9a targeted but also caused
us to no longer disable plt_clk_0 on Swanky (debugging done outside of
this thread has shown that d31fd43c0f9a sets CLK_IS_CRITICAL on plt_clk_0).

TL;DR: d31fd43c0f9a ("clk: x86: Do not gate clocks enabled by the firmware")
caused plt_clk_0 to be marked as CLK_IS_CRITICAL on Swanky, accidentally
fixing audio. The proper fix for this is to make the cht_bsw_max98090_ti.c
code control pmc_plt_clk_0 instead of pmc_plt_clk_3 as the Swanky board is
actually using pmc_plt_clk_0 and since this is a BYT board we should be
controlling the mclk there.


I hope this helps to clarify things, if not please keep asking questions.

Regards,

Hans
