Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030397AbeBPNPk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:15:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33578 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030316AbeBPNPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:15:39 -0500
X-Google-Smtp-Source: AH8x225S7KV6MFkwLk4wX2/AgffWdaxjCKAvgQd6l8zM/83t4Op7jgOYt31rfgo5nRnI+FMNbShbbA==
MIME-Version: 1.0
In-Reply-To: <20180216130741.jjtjwbnjcmsnz3ds@flea.lan>
References: <20180214135612.21356-1-embed3d@gmail.com> <20180215141154.monvwx25awwetqrc@flea.lan>
 <00ece3d8-52ac-c51d-1867-97f7fd84dadf@gmail.com> <CAGb2v67fP4-xxAAPWAa0+YtWY3xvQX=5XX7koq-h8USvT+YA-A@mail.gmail.com>
 <20180216130741.jjtjwbnjcmsnz3ds@flea.lan>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 16 Feb 2018 21:15:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v64xzVO0n8vTx9TfaoPPXv-85OoDk9y4k5KgLfkz70w2FA@mail.gmail.com>
Message-ID: <CAGb2v64xzVO0n8vTx9TfaoPPXv-85OoDk9y4k5KgLfkz70w2FA@mail.gmail.com>
Subject: Re: [PATCH v3] rtc: ac100: Fix ac100 determine rate bug
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Philipp Rossak <embed3d@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>, alexandre.belloni@bootlin.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>, linux-rtc@vger.kernel.org,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 9:07 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Fri, Feb 16, 2018 at 12:10:18PM +0800, Chen-Yu Tsai wrote:
>> > diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> > b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> > index 6550bf0e594b..6f56d429f17e 100644
>> > --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> > +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
>> > @@ -175,11 +175,18 @@
>> >                         compatible = "x-powers,ac100-rtc";
>> >                         interrupt-parent = <&r_intc>;
>> >                         interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> > -                       clocks = <&ac100_codec>;
>> > +                       clocks = <&ac100_rtc_32k>;
>> >                         #clock-cells = <1>;
>> >                         clock-output-names = "cko1_rtc",
>> >                                              "cko2_rtc",
>> >                                              "cko3_rtc";
>> > +
>> > +                       ac100_rtc_32k: rtc-32k-oscillator {
>> > +                               compatible = "fixed-clock";
>> > +                               #clock-cells = <0>;
>> > +                               clock-frequency  = <32768>;
>> > +                               clock-output-names = "ac100-rtc-32k";
>> > +                       };
>> >                 };
>> >         };
>> >  };
>> >
>> > What do you think about that solution?
>>
>> That's not quite right either. As I mentioned before, the
>> RTC block has two clock inputs, one 4MHz signal from the
>> codec block, and one 32.768 kHz signal from an external
>> crystal. The original device tree binding describes the
>> first one, and the 32.768 kHz clock was registered by
>> the RTC driver internally.
>>
>> If you're going to add the crystal clock, you still need
>> to keep the codec one. Note that this does not fix what
>> Maxime is asking you. I've already provided an explanation:
>>
>> The clock core allows registering clocks with not-yet-existing
>> clock parents. Parents are matches by string names. If no
>> clock by that name is registered yet, the clock core simply
>> orphans the new clock if the unregistered parent is its
>> current parent or simply ignores that parent if its not the
>> current parent. This is entirely valid and is what we are
>> counting on here, as we haven't implemented the codec-side
>> driver.
>
> So, we end up in a situation where clk_hw_get_num_parents returns the
> amount of clocks we can be parented to (orphans or not), but
> clk_hw_get_parent_by_index will not return the orphan clocks?

There is no placeholder for missing parents, unlike the regulator
subsystem that has a dummy regulator for this purpose.

> That's pretty bad :/

Yeah. I didn't expect this to happen. But to be fair, I should
have done the check on clk_hw_get_parent_by_index.

> Is there a way to test before registering that all our parents are
> actually there? clk_get?

That's probably the way to do it. However in the AC100 RTC case,
I left it open to be missing on purpose, so we could use the RTC
without waiting for the codec to be supported.

ChenYu
