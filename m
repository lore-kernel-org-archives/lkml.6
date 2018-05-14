Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeENJE0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:04:26 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38378 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbeENJEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:04:23 -0400
X-Google-Smtp-Source: AB8JxZpu4ViqbFM0XS/DBCSrW8Fz3kXp/6ttezciEG/7AnfBT4wnW6/PEB32Nl+9Q+1S6UL7ThgqYL0l4L125rVS0f8=
MIME-Version: 1.0
In-Reply-To: <20180514082744.ydmfg5mzsbol5onu@flea>
References: <CAMty3ZCNyuEwmLGdDZLM_9qKJ2NsT33rodug7ZpKAE-OHymVEg@mail.gmail.com>
 <20180514075727.uxggyhmbahvhestx@flea> <CAMty3ZDew=+zytKUx5+nX27CjCe0UfJpyYOy2s07NoJvbe57mQ@mail.gmail.com>
 <20180514082744.ydmfg5mzsbol5onu@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 14 May 2018 14:34:22 +0530
Message-ID: <CAMty3ZC3ggxkZwirpQ-aRP8Udg=aYypBArb0KcR0_Z0AG8wATA@mail.gmail.com>
Subject: Re: Allwinner A64: Issue on external rtc clock to wifi chip
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 1:57 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, May 14, 2018 at 01:34:56PM +0530, Jagan Teki wrote:
>> On Mon, May 14, 2018 at 1:27 PM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > Hi,
>> >
>> > On Mon, May 14, 2018 at 12:37:49PM +0530, Jagan Teki wrote:
>> >> Hi Maxime and All,
>> >>
>> >> We are trying to bring-up AP6330 Wifi chip for A64 board. We noticed
>> >> to have an external rtc clock has driven from wifi chip.
>> >>
>> >> So the devicetree is configured according to this as below.
>> >>
>> >> / {
>> >>         wifi_pwrseq: wifi-pwrseq {
>> >>                 compatible = "mmc-pwrseq-simple";
>> >>                 clocks = <&rtc 1>;
>> >>                 clock-names = "ext_clock";
>> >>                 reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>> >>                 post-power-on-delay-ms = <400>;
>> >>         };
>> >> };
>> >>
>> >> &rtc {
>> >>         clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
>> >>         clocks = <&osc32k>;
>> >>         #clock-cells = <1>;
>> >> };
>> >>
>> >> &mmc1 {
>> >>         pinctrl-names = "default";
>> >>         pinctrl-0 = <&mmc1_pins>;
>> >>         vmmc-supply = <&reg_dcdc1>;
>> >>         vqmmc-supply = <&reg_eldo1>;
>> >>         mmc-pwrseq = <&wifi_pwrseq>;
>> >>         bus-width = <4>;
>> >>         non-removable;
>> >>         status = "okay";
>> >>
>> >>         brcmf: wifi@1 {
>> >>                 reg = <1>;
>> >>                 compatible = "brcm,bcm4329-fmac";
>> >>                 interrupt-parent = <&r_pio>;
>> >>                 interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>;  /* WL-WAKE-AP: PL3 */
>> >>                 interrupt-names = "host-wake";
>> >>         };
>> >> };
>> >>
>> >> And observed rtc-osc32k-out clock is never enabled[1] and the value of
>> >> LOSC_OUT_GATING is 0x0 which eventually not enabling
>> >> LOSC_OUT_GATING_EN
>> >>
>> >> Pls. let us know if we miss anything here?
>> >>
>> >> [1] https://paste.ubuntu.com/p/X2By4q8kD2/
>> >
>> > Could you paste your config and the logs from a boot to?
>>
>> .config
>> https://paste.ubuntu.com/p/w9w2KB7RFc/
>>
>> dmesg
>> https://paste.ubuntu.com/p/mrZGk5bWRR/
>
> This is kind of weird. Have you tested with a 4.17 kernel? We have
> runtime_pm changes lined up in next, so that might be a regression
> there, even though we tested it with Quentin at some point.

This is 4.17-rc4 do you want to try it on 4.16 ?
