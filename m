Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A74EECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B9D20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B9D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJaS0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:26:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43800 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeJaS0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:26:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so12985781eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LSDLSqkZwnwfLo7WPhPqkqH6UiOLAwoxdtNxltf3vrc=;
        b=XUWqE6QbyBExFV0K7ReVGkZ/xZ9Wx+rxyX/zUS53tFXOiLUnNH6dB0GV/uKzCTE66I
         08qJUAAsOAO7m1WAnW6vb3QervWC+8vYjlXm6cKW76ULJcK61GLCGRzuD9yiPZhuAh4D
         mC9Y9UCpPP+ygAxA4N0mJdthf7ubpZfB9/4VVNGst7sq8qrwWxuEr0GPYUDPqYk6BO6P
         z3i0MQOxkLLA4wqfYqy0l4mPgOj7aaCgrM/VWt4DZf3JKEBDo0SndtrVG5Ik0JKx5CiZ
         ZQZhd7lG5GduBzz7krvS85IxZ2kFZpaEZQ3Rs2qsZnfOc5izZWBWZx/amLkcwCBBeDWG
         Uklg==
X-Gm-Message-State: AGRZ1gKw1QG0TUGIBnFrAN22mTkUHyIH7EAWlVRG+wMqgeGdYTZZxhTs
        IEv9c7/lt224Xx21RAgFnGLuhdVhS6M=
X-Google-Smtp-Source: AJdET5fxkXE8MHnPLcPJW5FdL0IUVXE7BWhqakbEhNbU1gxjbClwSfflY30juRy/b57IxPob9RXXpg==
X-Received: by 2002:a17:906:f285:: with SMTP id gu5-v6mr1023889ejb.64.1540978173735;
        Wed, 31 Oct 2018 02:29:33 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id d23-v6sm50968ejk.21.2018.10.31.02.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 02:29:33 -0700 (PDT)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Mogens Jensen <mogens-jensen@protonmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dean Wallace <duffydack73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181025232517.ywnw54qibemosjws@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
Date:   Wed, 31 Oct 2018 10:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31-10-18 07:02, Mogens Jensen wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Tuesday, October 30, 2018 7:10 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 30-10-18 19:56, Mogens Jensen wrote:
>>
>>> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
>>> On Tuesday, October 30, 2018 4:04 PM, Hans de Goede hdegoede@redhat.com wrote:
>>>
>>>> Hi,
>>>> On 30-10-18 16:46, Hans de Goede wrote:
>>>>
>>>>> Hi,
>>>>> On 30-10-18 16:04, Pierre-Louis Bossart wrote:
>>>>>
>>>>>> In addition I am not aware of any baytrail device using plt_clk_0, so moving a common machine driver such a cht_bsw_max98090_ti to use plt_clk0 only would break other devices (e.g. Rambi/Orco). Asking for both clocks to be on might work though,
>>>>>
>>>>> Ok, so we need to have a DMI based quirk for the Swanky and maybe also
>>>>> the clapper to use plt_clk_0 there. Asking for 2 clks if we only need
>>>>> one does not seem like a good plan.
>>>>
>>>> Dean, Mogens,
>>>> To write a proper patch for this I'm going to need DMI strings
>>>> from your devices.
>>>> Can you please run (as normal user):
>>>> grep . /sys/class/dmi/id/* 2> /dev/null
>>>> And reply with the output of this command?
>>>> I have attached the output from a coreboot seabios based clapper.
>>
>> Thank you.
>>
>>> Should I still test 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and asoundrc from Dean? There seems to have been some development in the case since that request was made.
>>
>> Yes please test that, I expect that to also fix things for the
>> Clapper, but I need to have that confirmed before submitting a
>> patch upstream adding a quirk for the Clapper to use pmc_plt_clk_0
>> instead of pmc_plt_clk_3.
>>
>> Regards,
>>
>> Hans
>>
> Unfortunately I only have access to longterm kernel 4.14 for building/running on this system, and 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch does not patch against 4.14.78. Can a test patch for 4.14 be created?

Can you run (as root):

for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat $i/clk_flags; echo; done

When running a kernel with working audio?

Then I can confirm that the Clapper is also using pmc_plt_clk_0, so that I can
fix this for the clapper for 4.18+

I've just checked the 4.14 sources and in 4.14 the SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
driver does not support mclk control yet, so for the 4.14 kernel the only way to
fix this is to revert the 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
commit.

Regards,

Hans

