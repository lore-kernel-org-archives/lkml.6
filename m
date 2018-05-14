Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeENJmx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:42:53 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:34789 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeENJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:42:50 -0400
X-Google-Smtp-Source: AB8JxZqMLjIrsDyJ18dmcERid0mRjTzAtEnkwO0Ps0KpN1y1HOOqkEoGiMDyW/cK8hcPZTEg8irAIwcYLJt+c6K37bk=
MIME-Version: 1.0
In-Reply-To: <20180514090618.r5xc3elzpvfp47f4@flea>
References: <CAMty3ZCNyuEwmLGdDZLM_9qKJ2NsT33rodug7ZpKAE-OHymVEg@mail.gmail.com>
 <20180514075727.uxggyhmbahvhestx@flea> <CAMty3ZDew=+zytKUx5+nX27CjCe0UfJpyYOy2s07NoJvbe57mQ@mail.gmail.com>
 <20180514082744.ydmfg5mzsbol5onu@flea> <CAMty3ZC3ggxkZwirpQ-aRP8Udg=aYypBArb0KcR0_Z0AG8wATA@mail.gmail.com>
 <20180514090618.r5xc3elzpvfp47f4@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 14 May 2018 15:12:49 +0530
Message-ID: <CAMty3ZCAWBHtemeeWcgLy5PoYLn10MwxpHdirqpsxFY3BA7=4g@mail.gmail.com>
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

On Mon, May 14, 2018 at 2:36 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, May 14, 2018 at 02:34:22PM +0530, Jagan Teki wrote:
>> On Mon, May 14, 2018 at 1:57 PM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > On Mon, May 14, 2018 at 01:34:56PM +0530, Jagan Teki wrote:
>> >> On Mon, May 14, 2018 at 1:27 PM, Maxime Ripard
>> >> <maxime.ripard@bootlin.com> wrote:
>> >> > Hi,
>> >> >
>> >> > On Mon, May 14, 2018 at 12:37:49PM +0530, Jagan Teki wrote:
>> >> >> Hi Maxime and All,
>> >> >>
>> >> >> We are trying to bring-up AP6330 Wifi chip for A64 board. We noticed
>> >> >> to have an external rtc clock has driven from wifi chip.
>> >> >>
>> >> >> So the devicetree is configured according to this as below.
>> >> >>
>> >> >> / {
>> >> >>         wifi_pwrseq: wifi-pwrseq {
>> >> >>                 compatible = "mmc-pwrseq-simple";
>> >> >>                 clocks = <&rtc 1>;
>> >> >>                 clock-names = "ext_clock";
>> >> >>                 reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>> >> >>                 post-power-on-delay-ms = <400>;
>> >> >>         };
>> >> >> };
>> >> >>
>> >> >> &rtc {
>> >> >>         clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
>> >> >>         clocks = <&osc32k>;
>> >> >>         #clock-cells = <1>;
>> >> >> };
>> >> >>
>> >> >> &mmc1 {
>> >> >>         pinctrl-names = "default";
>> >> >>         pinctrl-0 = <&mmc1_pins>;
>> >> >>         vmmc-supply = <&reg_dcdc1>;
>> >> >>         vqmmc-supply = <&reg_eldo1>;
>> >> >>         mmc-pwrseq = <&wifi_pwrseq>;
>> >> >>         bus-width = <4>;
>> >> >>         non-removable;
>> >> >>         status = "okay";
>> >> >>
>> >> >>         brcmf: wifi@1 {
>> >> >>                 reg = <1>;
>> >> >>                 compatible = "brcm,bcm4329-fmac";
>> >> >>                 interrupt-parent = <&r_pio>;
>> >> >>                 interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>;  /* WL-WAKE-AP: PL3 */
>> >> >>                 interrupt-names = "host-wake";
>> >> >>         };
>> >> >> };
>> >> >>
>> >> >> And observed rtc-osc32k-out clock is never enabled[1] and the value of
>> >> >> LOSC_OUT_GATING is 0x0 which eventually not enabling
>> >> >> LOSC_OUT_GATING_EN
>> >> >>
>> >> >> Pls. let us know if we miss anything here?
>> >> >>
>> >> >> [1] https://paste.ubuntu.com/p/X2By4q8kD2/
>> >> >
>> >> > Could you paste your config and the logs from a boot to?
>> >>
>> >> .config
>> >> https://paste.ubuntu.com/p/w9w2KB7RFc/
>> >>
>> >> dmesg
>> >> https://paste.ubuntu.com/p/mrZGk5bWRR/
>> >
>> > This is kind of weird. Have you tested with a 4.17 kernel? We have
>> > runtime_pm changes lined up in next, so that might be a regression
>> > there, even though we tested it with Quentin at some point.
>>
>> This is 4.17-rc4 do you want to try it on 4.16 ?
>
> No, this is next-20180503. Please try with 4.17-rc4

Couldn't find any different in behaviour [2]

[2] https://paste.ubuntu.com/p/m3PGBwrv6W/
