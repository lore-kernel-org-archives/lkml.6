Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeB1Nvi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:51:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49798 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752441AbeB1Nvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:51:37 -0500
Subject: Re: [PATCH] arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs,
 wifi reset)
To: Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
References: <20180227204711.29357-1-dianders@chromium.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <8ea0415b-6069-a548-0272-67fcdbc08d39@arm.com>
Date: Wed, 28 Feb 2018 13:51:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227204711.29357-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/18 20:47, Douglas Anderson wrote:
> Back in the early days when gru devices were still under development
> we found an issue where the WiFi reset line needed to be configured as
> early as possible during the boot process to avoid the WiFi module
> being in a bad state.
> 
> We found that the way to get the kernel to do this in the earliest
> possible place was to configure this line in the pinctrl hogs, so
> that's what we did.  For some history here you can see
> <http://crosreview.com/368770>.  After the time that change landed in
> the kernel, we landed a firmware change to configure this line even
> earlier.  See <http://crosreview.com/399919>.  However, even after the
> firmware change landed we kept the kernel change to deal with the fact
> that some people working on devices might take a little while to
> update their firmware.
> 
> At this there are definitely zero devices out in the wild that have
> firmware without the fix in it.  Specifically looking in the firmware
> branch several critically important fixes for memory stability landed
> after the patch in coreboot and I know we didn't ship without those.
> Thus, by now, everyone should have the new firmware and it's safe to
> not have the kernel set this up in a pinctrl hog.
> 
> Historically, even though it wasn't needed to have this in a pinctrl
> hog, we still kept it since it didn't hurt.  Pinctrl would apply the
> default hog at bootup and then would never touch things again.  That
> all changed with commit 981ed1bfbc6c ("pinctrl: Really force states
> during suspend/resume").  After that commit then we'll re-apply the
> default hog at resume time and that can screw up the reset state of
> WiFi.  ...and on rk3399 if you touch a device on PCIe in the wrong way
> then the whole system can go haywire.  That's what was happening.
> Specifically you'd resume a rk3399-gru-* device and it would mostly
> resume, then would crash with some crazy weird crash.
> 
> One could say, perhaps, that the recent pinctrl change was at fault
> (and should be fixed) since it changed behavior.  ...but that's not
> really true.  The device tree for rk3399-gru is really to blame.
> Specifically since the pinctrl is defined in the hog and not in the
> "wlan-pd-n" node then the actual user of this pin doesn't have a
> pinctrl entry for it.  That's bad.
> 
> Let's fix our problems by just moving the control of
> "wlan_module_reset_l pinctrl" out of the hog and put them in the
> proper place.
> 
> NOTE: in theory, I think it should actually be possible to have a pin
> controlled _both_ by the hog and by an actual device.  Once the device
> claims the pin I think the hog is supposed to let go.  I'm not 100%
> sure that this works and in any case this solution would be more
> complex than is necessary.
> 
> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> Fixes: 48f4d9796d99 ("arm64: dts: rockchip: add Gru/Kevin DTS")
> Fixes: 981ed1bfbc6c ("pinctrl: Really force states during suspend/resume")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
