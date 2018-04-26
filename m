Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeDZN0x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:26:53 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:34174 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755928AbeDZN0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:26:50 -0400
X-Google-Smtp-Source: AB8JxZqzXk9k6btVCXYeXpO/eqoaEiBKYWdusjNqhoCITAskos00TfjN530gx+TNfYRTcfqqjLyj+ActkkPKZ8UBQTs=
MIME-Version: 1.0
In-Reply-To: <3749004.y60xFsjo5d@jernej-laptop>
References: <20180424133425.24291-1-jagan@amarulasolutions.com>
 <4355590.Ql03JAEh1C@jernej-laptop> <CAMty3ZCTtB__eWub2PbHK_DHSVQsf4V1eECX6bfwDq99pXaLJQ@mail.gmail.com>
 <3749004.y60xFsjo5d@jernej-laptop>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 26 Apr 2018 18:56:49 +0530
Message-ID: <CAMty3ZDfiqKMpesTg-oaCRNJ4-gBs48vY-TXgRFJkLB7gjKaYQ@mail.gmail.com>
Subject: Re: [RFC 00/13] arm64: allwinner: Add A64 DE2 pipeline support
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QDQvSY031514

On Wed, Apr 25, 2018 at 11:29 PM, Jernej Škrabec
<jernej.skrabec@siol.net> wrote:
> Hi,
>
> Dne sreda, 25. april 2018 ob 12:34:09 CEST je Jagan Teki napisal(a):
>> On Tue, Apr 24, 2018 at 9:02 PM, Jernej Škrabec <jernej.skrabec@siol.net>
> wrote:
>> > Hi,
>> >
>> > Dne torek, 24. april 2018 ob 15:34:12 CEST je Jagan Teki napisal(a):
>> >> Allwinner A64 has display engine pipeline like other Allwinner SOC's
>> >> A83T/H3/H5.
>> >>
>> >> A64 DE2 behaviour similar to Allwinner A83T where mixer0, connected to
>> >> tcon0 with RGB, LVDS MIPI-DSI and mixer1, connected to tcon1 with HDMI.
>> >> This series merely concentrated on HDMI pipeline and rest will add
>> >> eventually.
>> >>
>> >> patch 1: dt-bindings for a64 DE2 CCU
>> >>
>> >> patch 2: a64 DE2 CCU node addition
>> >>
>> >> patch 3: dt-bindings for a64 DE2 pipeline
>> >>
>> >> patch 4 - 5: dt-bindings for a64 mixer0 and tcon-lcd
>> >>
>> >> patch 6: a64 DE2 pipeline node addition
>> >>
>> >> patch 7 - 8: dt-bindings for a64 HDMI and HDMI PHY
>> >>
>> >> patch 9: a64 HDMI nodes addition
>> >>
>> >> patch 10 - 11: dt-bindings for a64 mixer1 and tcon-tv
>> >>
>> >> patch 12: a64 HDMI pipeline
>> >>
>> >> patch 13: enable HDMI out on bananpi-m64
>> >>
>> >> Tested HDMI on bananapi-m64 (along with DE2 SRAM C changes from [1]
>> >> thread), able to detect the HDMI but, no penguins on screen.
>> >>
>> >> Request for any suggestions.
>> >
>> > You are mising sunxi-ng clock patches. PLL_VIDEO0 and PLL_VIDEO1 need
>> > fixes by setting minimum stable frequency. Please note that datasheet may
>> > have wrong information. That was obvious in H3 case and I had to check
>> > minimum stable PLL_VIDEO frequency in BSP driver.
>>
>> Can you point me the clock patches?
>
> Here is my A64 HDMI wip repo, which includes my clock changes:
> https://github.com/jernejsk/linux-1/tree/a64_hdmi_wip
>
> At some point HDMI output worked ok, I'm not sure in what state I left the
> code.
>

Jernej, thanks for the regulator change in another mail, yes
bananapi-m64 has HVCC regulator for HDMI glue, with this I'm able to
see penguins on screen.

>> I've phadled only CLK_PLL_VIDEO0
>> on hdmi_phy So we need CLK_PLL_VIDEO1 as fourth clock?
>
> I'm not sure what is the best way. I guess some research is needed. There is
> even the possibility that one bit (SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL) in hdmi
> phy needs to be toggled depending on which clock is selected as HDMI source. I
> never finished my research since I'm waiting to SRAM C claiming patches.
>
> At the end, HDMI driver should be tested by both, PLL_VIDEO0 and PLL_VIDEO1 as
> a HDMI clock source, otherwise there is no guarantee that we got binding
> right. A83T, H3 and H5 has only one possible HDMI parent clock, so it was much
> easier in this regard.

>From Figure 3-3.Module Clock Diagram of
Allwinner_A64_User_Manual_V1.1.pdf clearly shows PLL_VIDEO1 is
connected TCON1 which intern used by HDMI. I've verified both
PLL_VIDEO0 and 1 both seems working. I'm thinking we can go for
PLL_VIDEO1 as per datasheet, any suggestions?

Jagan.
