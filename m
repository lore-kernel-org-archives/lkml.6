Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeB0Urg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:47:36 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38446 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeB0Ure (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:47:34 -0500
X-Google-Smtp-Source: AH8x224LK25pusgWH+ozTupxzIPzOK+La3jW0hK+3+1elGG8mG36rVtvO33CqFHMxulJ7lkdFdXG8g==
From: Douglas Anderson <dianders@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs, wifi reset)
Date: Tue, 27 Feb 2018 12:47:11 -0800
Message-Id: <20180227204711.29357-1-dianders@chromium.org>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in the early days when gru devices were still under development
we found an issue where the WiFi reset line needed to be configured as
early as possible during the boot process to avoid the WiFi module
being in a bad state.

We found that the way to get the kernel to do this in the earliest
possible place was to configure this line in the pinctrl hogs, so
that's what we did.  For some history here you can see
<http://crosreview.com/368770>.  After the time that change landed in
the kernel, we landed a firmware change to configure this line even
earlier.  See <http://crosreview.com/399919>.  However, even after the
firmware change landed we kept the kernel change to deal with the fact
that some people working on devices might take a little while to
update their firmware.

At this there are definitely zero devices out in the wild that have
firmware without the fix in it.  Specifically looking in the firmware
branch several critically important fixes for memory stability landed
after the patch in coreboot and I know we didn't ship without those.
Thus, by now, everyone should have the new firmware and it's safe to
not have the kernel set this up in a pinctrl hog.

Historically, even though it wasn't needed to have this in a pinctrl
hog, we still kept it since it didn't hurt.  Pinctrl would apply the
default hog at bootup and then would never touch things again.  That
all changed with commit 981ed1bfbc6c ("pinctrl: Really force states
during suspend/resume").  After that commit then we'll re-apply the
default hog at resume time and that can screw up the reset state of
WiFi.  ...and on rk3399 if you touch a device on PCIe in the wrong way
then the whole system can go haywire.  That's what was happening.
Specifically you'd resume a rk3399-gru-* device and it would mostly
resume, then would crash with some crazy weird crash.

One could say, perhaps, that the recent pinctrl change was at fault
(and should be fixed) since it changed behavior.  ...but that's not
really true.  The device tree for rk3399-gru is really to blame.
Specifically since the pinctrl is defined in the hog and not in the
"wlan-pd-n" node then the actual user of this pin doesn't have a
pinctrl entry for it.  That's bad.

Let's fix our problems by just moving the control of
"wlan_module_reset_l pinctrl" out of the hog and put them in the
proper place.

NOTE: in theory, I think it should actually be possible to have a pin
controlled _both_ by the hog and by an actual device.  Once the device
claims the pin I think the hog is supposed to let go.  I'm not 100%
sure that this works and in any case this solution would be more
complex than is necessary.

Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Fixes: 48f4d9796d99 ("arm64: dts: rockchip: add Gru/Kevin DTS")
Fixes: 981ed1bfbc6c ("pinctrl: Really force states during suspend/resume")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 6e50768a34ce..9ad54751d0d8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -406,8 +406,9 @@
 	wlan_pd_n: wlan-pd-n {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan_pd_n";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_module_reset_l>;
 
-		/* Note the wlan_module_reset_l pinctrl */
 		enable-active-high;
 		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 
@@ -988,12 +989,6 @@ ap_i2c_audio: &i2c8 {
 	pinctrl-0 = <
 		&ap_pwroff	/* AP will auto-assert this when in S3 */
 		&clk_32k	/* This pin is always 32k on gru boards */
-
-		/*
-		 * We want this driven low ASAP; firmware should help us, but
-		 * we can help ourselves too.
-		 */
-		&wlan_module_reset_l
 	>;
 
 	pcfg_output_low: pcfg-output-low {
@@ -1173,12 +1168,7 @@ ap_i2c_audio: &i2c8 {
 		};
 
 		wlan_module_reset_l: wlan-module-reset-l {
-			/*
-			 * We want this driven low ASAP (As {Soon,Strongly} As
-			 * Possible), to avoid leakage through the powered-down
-			 * WiFi.
-			 */
-			rockchip,pins = <1 11 RK_FUNC_GPIO &pcfg_output_low>;
+			rockchip,pins = <1 11 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
 		bt_host_wake_l: bt-host-wake-l {
-- 
2.16.2.395.g2e18187dfd-goog
