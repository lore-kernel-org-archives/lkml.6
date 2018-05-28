Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165276AbeE1NTf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163541AbeE1Kth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 189/496] arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs, wifi reset)
Date: Mon, 28 May 2018 11:59:34 +0200
Message-Id: <20180528100327.914885708@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 2560da49de5d0cfec22e9564023aebfffa094732 ]

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
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

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
 
@@ -940,12 +941,6 @@ ap_i2c_audio: &i2c8 {
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
@@ -1125,12 +1120,7 @@ ap_i2c_audio: &i2c8 {
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
