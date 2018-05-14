Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbeENHIF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:08:05 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:45326 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753913AbeENHHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:07:50 -0400
X-Google-Smtp-Source: AB8JxZr8VkgIgE2/MxoKJnj8FLyUFVlBdqdMACIL0NpLtHw6/F71FAl7F8S6C3vNxYsOD4ScVC6ODsrnAHtCf8CdVRc=
MIME-Version: 1.0
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 14 May 2018 12:37:49 +0530
Message-ID: <CAMty3ZCNyuEwmLGdDZLM_9qKJ2NsT33rodug7ZpKAE-OHymVEg@mail.gmail.com>
Subject: Allwinner A64: Issue on external rtc clock to wifi chip
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime and All,

We are trying to bring-up AP6330 Wifi chip for A64 board. We noticed
to have an external rtc clock has driven from wifi chip.

So the devicetree is configured according to this as below.

/ {
        wifi_pwrseq: wifi-pwrseq {
                compatible = "mmc-pwrseq-simple";
                clocks = <&rtc 1>;
                clock-names = "ext_clock";
                reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
                post-power-on-delay-ms = <400>;
        };
};

&rtc {
        clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
        clocks = <&osc32k>;
        #clock-cells = <1>;
};

&mmc1 {
        pinctrl-names = "default";
        pinctrl-0 = <&mmc1_pins>;
        vmmc-supply = <&reg_dcdc1>;
        vqmmc-supply = <&reg_eldo1>;
        mmc-pwrseq = <&wifi_pwrseq>;
        bus-width = <4>;
        non-removable;
        status = "okay";

        brcmf: wifi@1 {
                reg = <1>;
                compatible = "brcm,bcm4329-fmac";
                interrupt-parent = <&r_pio>;
                interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>;  /* WL-WAKE-AP: PL3 */
                interrupt-names = "host-wake";
        };
};

And observed rtc-osc32k-out clock is never enabled[1] and the value of
LOSC_OUT_GATING is 0x0 which eventually not enabling
LOSC_OUT_GATING_EN

Pls. let us know if we miss anything here?

[1] https://paste.ubuntu.com/p/X2By4q8kD2/

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
