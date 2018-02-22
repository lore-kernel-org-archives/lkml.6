Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933653AbeBVSLV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:11:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46176 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933441AbeBVSLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:11:19 -0500
Subject: Re: [PATCH fixes v3] pinctrl: Really force states during
 suspend/resume
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Warren <swarren@nvidia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <20170301183257.6554-1-f.fainelli@gmail.com>
 <83d6bd0da9254d868d3f713bd3bc282c@www.loen.fr>
 <913ED32F-36F8-4F31-9221-263DD5599FB2@gmail.com> <3136391.js9qjGvjLN@phil>
 <86o9kkdbr3.wl-marc.zyngier@arm.com>
 <CACRpkdZhMN-ZaVaveWPyrh03M1QveWP_6M+oQ5Bj=aZ3V_3u0Q@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <da0c7692-1068-11be-a388-f9fc0d17ec27@arm.com>
Date: Thu, 22 Feb 2018 18:11:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZhMN-ZaVaveWPyrh03M1QveWP_6M+oQ5Bj=aZ3V_3u0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 22/02/18 15:30, Linus Walleij wrote:
> On Mon, Feb 19, 2018 at 8:23 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> Am Montag, 19. Februar 2018, 19:03:27 CET schrieb Florian Fainelli:
> 
>>>> Can you indicate which DTS file is used for your Chromebook model? Sorry about the breakage.
>>>
>>> that should be
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>>>
>>> I'm vacationing right now, so don't think I'll find time to dive into
>>> Rockchip pinctrl this week. But I'd guess it could be somehow
>>> related to the ATF touching pins during suspend/resume?
>>
>> That'd be really unfortunate. I would have assumed that ATF would
>> leave things as they were instead of re-configuring them to whatever
>> default.
>>
>> The most annoying thing is that if that's indeed the case, we need to
>> find a solution that will cope with the current state of the
>> firmware. I guess that'd mean eagerly saving/restoring the pin state
>> across suspend/resume, irrespective of what firmware could do?
> 
> What is ATF? Asus Touch Firmware?

More like "ARM Trusted Firmware", aka the firmware that runs on the
secure side of most 64bit ARM systems.

> Does it in effect mean that when the Rockchip pinctrl driver
> says pinctrl_force_sleep() and pinctrl_force_default()
> it expects those to be a noop?
> 
> Then the real patch to apply is something deleting the
> pinctrl_force* calls from the pinctrl-rockchip driver,
> is it not?

Quite possibly. Unravelling this bit of code, I came to a similar
conclusion. The question is then: what is this call supposed to be used
for? I'm pretty sure it is not completely gratuitous, but it makes no
sense on my platform.

I'll give it a go later today.

	M.
-- 
Jazz is not dead. It just smells funny...
