Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeCFS65 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:58:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753308AbeCFS6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:58:55 -0500
Subject: Re: [PATCH] arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs,
 wifi reset)
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
References: <20180227204711.29357-1-dianders@chromium.org>
 <CAD=FV=Wr6_U9c1qFRgx3=JhMg8US20_oMEmEfCdpVyGKek_8gQ@mail.gmail.com>
 <16f41a01-2ac2-c4c0-6989-990612b467d1@arm.com> <13699528.5LUGj0SynH@diego>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <fd5716fa-1861-210e-73c3-cbe2b01a756c@arm.com>
Date: Tue, 6 Mar 2018 18:58:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <13699528.5LUGj0SynH@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/18 18:49, Heiko Stübner wrote:
> Am Dienstag, 6. März 2018, 19:15:18 CET schrieb Marc Zyngier:
>> Hi Doug,
>>
>> On 06/03/18 18:00, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Tue, Mar 6, 2018 at 3:58 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> Hi all,
>>>>
>>>> On 01/03/18 08:43, Heiko Stübner wrote:
>>>>> Am Dienstag, 27. Februar 2018, 21:47:11 CET schrieb Douglas Anderson:
>>>>>> Back in the early days when gru devices were still under development
>>>>>> we found an issue where the WiFi reset line needed to be configured as
>>>>>> early as possible during the boot process to avoid the WiFi module
>>>>>> being in a bad state.
>>>>>>
>>>>>> We found that the way to get the kernel to do this in the earliest
>>>>>> possible place was to configure this line in the pinctrl hogs, so
>>>>>> that's what we did.  For some history here you can see
>>>>>> <http://crosreview.com/368770>.  After the time that change landed in
>>>>>> the kernel, we landed a firmware change to configure this line even
>>>>>> earlier.  See <http://crosreview.com/399919>.  However, even after the
>>>>>> firmware change landed we kept the kernel change to deal with the fact
>>>>>> that some people working on devices might take a little while to
>>>>>> update their firmware.
>>>>>>
>>>>>> At this there are definitely zero devices out in the wild that have
>>>>>> firmware without the fix in it.  Specifically looking in the firmware
>>>>>> branch several critically important fixes for memory stability landed
>>>>>> after the patch in coreboot and I know we didn't ship without those.
>>>>>> Thus, by now, everyone should have the new firmware and it's safe to
>>>>>> not have the kernel set this up in a pinctrl hog.
>>>>>>
>>>>>> Historically, even though it wasn't needed to have this in a pinctrl
>>>>>> hog, we still kept it since it didn't hurt.  Pinctrl would apply the
>>>>>> default hog at bootup and then would never touch things again.  That
>>>>>> all changed with commit 981ed1bfbc6c ("pinctrl: Really force states
>>>>>> during suspend/resume").  After that commit then we'll re-apply the
>>>>>> default hog at resume time and that can screw up the reset state of
>>>>>> WiFi.  ...and on rk3399 if you touch a device on PCIe in the wrong way
>>>>>> then the whole system can go haywire.  That's what was happening.
>>>>>> Specifically you'd resume a rk3399-gru-* device and it would mostly
>>>>>> resume, then would crash with some crazy weird crash.
>>>>>>
>>>>>> One could say, perhaps, that the recent pinctrl change was at fault
>>>>>> (and should be fixed) since it changed behavior.  ...but that's not
>>>>>> really true.  The device tree for rk3399-gru is really to blame.
>>>>>> Specifically since the pinctrl is defined in the hog and not in the
>>>>>> "wlan-pd-n" node then the actual user of this pin doesn't have a
>>>>>> pinctrl entry for it.  That's bad.
>>>>>>
>>>>>> Let's fix our problems by just moving the control of
>>>>>> "wlan_module_reset_l pinctrl" out of the hog and put them in the
>>>>>> proper place.
>>>>>>
>>>>>> NOTE: in theory, I think it should actually be possible to have a pin
>>>>>> controlled _both_ by the hog and by an actual device.  Once the device
>>>>>> claims the pin I think the hog is supposed to let go.  I'm not 100%
>>>>>> sure that this works and in any case this solution would be more
>>>>>> complex than is necessary.
>>>>>>
>>>>>> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>>> Fixes: 48f4d9796d99 ("arm64: dts: rockchip: add Gru/Kevin DTS")
>>>>>> Fixes: 981ed1bfbc6c ("pinctrl: Really force states during
>>>>>> suspend/resume")
>>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>>>
>>>>> applied as fix for 4.16 with the 2 Tested-tags
>>>>
>>>> Sorry to rain on everyone's parade, but further testing shows that this
>>>> patch may not be enough to restore a reliable s2r. My initial testing
>>>> did show that we were resuming without the VOP errors, but there seem to
>>>> be further issues (I'm loosing the keyboard and the trackpad after
>>>> resume on Kevin).
>>>>
>>>> Applying my initial hack makes it work again. I suspect that there are
>>>> more hog pins that need tweaking, but I'm a bit out of my depth here.
>>>
>>> Are you positive you weren't just wearing your lucky hat when you
>>> tested your patch and then took it off when you tested mine?  As far
>>
>> So far, I seem to have a 100% success rate in resuming with my silly
>> hack, whist your DT patch alone only gives me a 50% rate at best.
>>
>>> as I can see the only hogs left on kevin are:
>>>   &ap_pwroff      /* AP will auto-assert this when in S3 */
>>>   &clk_32k        /* This pin is always 32k on gru boards */
>>>
>>> Those map to:
>>>   ap_pwroff: ap-pwroff {
>>>   
>>>      rockchip,pins = <1 5 RK_FUNC_1 &pcfg_pull_none>;
>>>   
>>>   };
>>>   
>>>   clk_32k: clk-32k {
>>>   
>>>     rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
>>>   
>>>   };
>>>
>>> So I added some printouts at suspend/resume time.  Specifically I set
>>> a boolean to "true" for the duration rockchip_pinctrl_suspend() and
>>> rockchip_pinctrl_resume() and this turned on a printout in
>>> rockchip_set_mux().  My printout looked like this (yeah, I know it's a
>>> whitespace-damaged patch just to show what I'm doing):
>>>
>>> +       regmap_read(regmap, reg, &before);
>>>
>>>         data = (mask << (bit + 16));
>>>         rmask = data | (data >> 16);
>>>         data |= (mux & mask) << bit;
>>>         ret = regmap_update_bits(regmap, reg, rmask, data);
>>>
>>> +       regmap_read(regmap, reg, &after);
>>> +
>>> +       if (DOUG) {
>>> +               dev_info(info->dev,
>>> +                        "setting mux of GPIO%d-%d to %d;
>>> %#010x=>%#010x\n", +                        bank->bank_num, pin, mux,
>>> reg, before, after); +       }
>>>
>>> ...and a similar one in rockchip_set_pull().  That showed this at resume
>>> time:
>>>
>>> [   62.284427] rockchip-pinctrl pinctrl: setting mux of GPIO1-5 to 1;
>>> 0x00009400=>0x00009400
>>> [   62.294423] rockchip-pinctrl pinctrl: setting pull of GPIO1-5;
>>> 0x000041aa=>0x000041aa
>>> [   62.303343] rockchip-pinctrl pinctrl: setting mux of GPIO0-0 to 2;
>>> 0x00005002=>0x00005002
>>> [   62.313240] rockchip-pinctrl pinctrl: setting pull of GPIO0-0;
>>> 0x00000ddc=>0x00000ddc
>>> [
>>>
>>> Said another way: pinmux and pull isn't actually changing due to the
>>> hogs.  We can see if something else could be changing, but I'd really
>>> want to be sure you're certain that the hogs are causing you
>>> problems...
>>
>> I cannot say for sure that the hogs are the issue. But I thought that
>> they were the only pins affected by 981ed1bfbc6c... If this patch can
>> affect other pins, then I'm probably barking up the wrong tree.
> 
> On Kevin I see something like
> 
> [   60.764129] cros-ec-spi spi2.0: spi transfer failed: -108
> [   60.764132] cros-ec-spi spi2.0: cs-deassert spi transfer failed: -108
> [   60.764136] cros-ec-spi spi2.0: Command xfer error (err:-108)
> [   60.764365] cros-ec-spi spi2.0: spi transfer failed: -108
> [   60.764368] cros-ec-spi spi2.0: cs-deassert spi transfer failed: -108
> [   60.764371] cros-ec-spi spi2.0: Command xfer error (err:-108)
> 
> on resume with my current for-next. So maybe your hack just
> happened to change some timing during resume?

No, I carry yet another patch to make that one work[1].

> Suspend/Resume also disconnects my usb-ethernet, making me lose my
> nfsroot, so I can test this once every boot only.

I use my kevin as a "real" laptop, which means it gets suspended/resumed 
at least 20 times a day, no reboots involved (unless I'm actually testing
arm64 code on it).

	M.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=hack/kevin-4.16&id=4e95dc697ec6b66579f8747c917dfe675bb771b2
-- 
Jazz is not dead. It just smells funny...
