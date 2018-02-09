Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeBIKNk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:13:40 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35099 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeBIKNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:13:38 -0500
X-Google-Smtp-Source: AH8x225cT6WiRERVeGEwG2FmRexmlgmzv4hGUTZeCItmMhBQ5EWvt3kCiMBQMg0UaI0HifUxU0DGjA==
MIME-Version: 1.0
In-Reply-To: <20180208204043.mqryuqhx7a6z4v3b@flea>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan> <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com> <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180207103905.mtyzgu73mmifyvvj@flea> <653f0438-c55a-02a5-dffb-2ee8e6d9ef4a@micronovasrl.com>
 <20180208204043.mqryuqhx7a6z4v3b@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 9 Feb 2018 18:13:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v662tX+rN5DuA+VSX_RMJ8ENx_EXfZe8mQgLVtHd-3885w@mail.gmail.com>
Message-ID: <CAGb2v662tX+rN5DuA+VSX_RMJ8ENx_EXfZe8mQgLVtHd-3885w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE correctly
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 4:40 AM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Wed, Feb 07, 2018 at 01:49:59PM +0100, Giulio Benetti wrote:
>> Hi,
>>
>> Il 07/02/2018 11:39, Maxime Ripard ha scritto:
>> > On Wed, Jan 24, 2018 at 08:37:28PM +0100, Giulio Benetti wrote:
>> >>>>> Also, how was it tested? This seems quite weird that we haven't caught
>> >>>>> that one sooner, and I'm a bit worried about the possible regressions
>> >>>>> here.
>> >>>>
>> >>>> It sounds really strange to me too,
>> >>>> because everybody under uboot use "sync:3"(HIGH).
>> >>>> I will retry to measure,
>> >>>> unfortunately at home I don't have a scope,
>> >>>> but I think I'm going to have one soon, because of this. :)
>> >>>
>> >>> Here I am with scope captures and tcon0 registers dump:
>> >>> tcon0_regs => https://pasteboard.co/H4r8Zcs.png
>> >>> dclk_d0 => https://pasteboard.co/H4r8QRe.png
>> >>> dclk_de => https://pasteboard.co/H4r8zh4R.png
>> >>> dclk_vsnc => https://pasteboard.co/H4r8Hye.png
>> >>>
>> >>> As you can see circled in reg on registers,
>> >>> TCON0_IO_POL_REG = 0x00000000.
>> >>> But on all the waveforms you can see:
>> >>> - dclk_d0: clock phase is 0, but it starts with falling edge, otherwise
>> >>> the rising front overlaps dclk rising edge(not good), so to me this is
>> >>> falling, then I mean it Negative.
>> >>> - dclk_de: de pulse is clearly negative, even if register is 0 and its'
>> >>> polarity bit is 0.
>> >>> - dclk_vsnc: same as dclk_de
>> >>> - dclk_hsync: I didn't take scope screenshot but I can assure you it's
>> >>> negative.
>> >>>
>> >>> You can also check all the other registers about TCON0.
>> >>>
>> >>> Now I proceed testing it on A33, maybe the peripheral is slightly
>> >>> different between Axx SoCs, if I find it that way,
>> >>> it should be only a check about SoC or peripheral ID,
>> >>> and treat polarity as it should be done.
>> >>
>> >> Here I am with A33 waveforms:
>> >> tcon0_regs => https://pasteboard.co/H4rXfN0M.png
>> >> dclk_d0 => https://pasteboard.co/H4rVXwy.png
>> >> dclk_de => https://pasteboard.co/H4rWDt8.png
>> >> dclk_vsnc => https://pasteboard.co/H4rWRACu.png
>> >> dclk_hsync => https://pasteboard.co/H4rWK6I.png
>> >>
>> >> It behaves the same way as A20, so as I mean IO polarity,
>> >> all signals(except D0-D23), are inverted.
>> >> For A33 I've used A33-OLinuXino.
>> >> For A20 our LiNova1.
>> >
>> > If you have an A33 handy, you probably want to read that mail:
>> > https://lists.freedesktop.org/archives/dri-devel/2017-July/147951.html
>> >
>> > Especially the 90-phase part.
>>
>> Here is a summary of different SoCs TCON:
>> With DCLK_Sel:
>> 0x0 => normal phase
>> 0x1 => 1/3 phase
>> 0x2 => 2/3 phase
>>
>> A10, A20
>
> Have you tested the option 4 and 5 there too?
>
>> With DCLK_Sel:
>> 0x0 => normal phase
>> 0x1 => 1/3 phase
>> 0x2 => 2/3 phase
>> 0x5 => DCLK/2 phase 0
>> 0x4 => DCLK/2 phase 90
>>
>> A31, A31s, A33, A80, A83T
>
> Ok, great, so Chen-Yu was right :)
>
> I guess the option 5 (DCLK/2 phase 0) is still to early, just like
> you've shown in the previous captures?
>
>> Also I've found that TCON1 has not this feature,
>> nor first, nor second case(at least is not described on user manuals).
>
> At lot of things are not described, unfortunately...

On some SoCs, TCON1 does not have channel 0 (LCD), so it does
not have a configurable dot clock, so no settings.

ChenYu

>> So I could handle differently according to SoC.
>> Unfortunately there is not TCON register keeping IP version,
>> so the only way I see is to create a long if-or statement to understand
>> which kind of TCON we're using.
>
> You can base that on the compatible, and add a field in the
> sun4i_tcon_quirks structure, that will avoid the if statements you
> mentionned.
>
>> But what sounds not the best to me, is that DCLK is divided by 2 if
>> using phase 90. So we need to reconsider also bitclock driver according
>> to this.
>> I don't know if it make sense.
>>
>> IMHO, I would keep only:
>> - As normal => "0x1 => 1/3 phase"
>
> So that would mean sampling at raising edge on this one??
>
>> - As inverted => "0x0 => normal phase"
>
> And falling edge?
>
> If so, and if remember the captures properly, the sampling would occur
> right before the rise, and not really around the fall.
>
> Would 2/3 be better here?
>
>> According to scope captures above on both A20 and A33.
>> Unfortunately I don't have other boards for the other SoCs to take captures.
>>
>> What do you think?
>
> I guess we can make that part applicable to all SoCs, we haven't seen
> any significant differences on those part.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
