Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeC0UwB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:52:01 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:42597 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeC0Uv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:51:58 -0400
X-Google-Smtp-Source: AIpwx4/jiL5U0e29AiBvjQJ135tqjUQIQi252M10TrAmN+G0n+cXygV4ER89ciMX/feKJjvYIBfpaugLlmBsK/lpJ7M=
MIME-Version: 1.0
In-Reply-To: <20180327115606.GC29239@sirena.org.uk>
References: <cover.1521246069.git.collinsd@codeaurora.org> <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <CAD=FV=Xz01ra=WS--vtA+dkb1H8wcw3UnFzXPS=zYWAQCPP5eg@mail.gmail.com>
 <184378e4-caf8-6ce3-e089-3690588fcb28@codeaurora.org> <CAD=FV=WsVDDaV-mMUvQWUomyBFCJZunKiyDt_K81_syoNhGRZQ@mail.gmail.com>
 <20180327115606.GC29239@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Mar 2018 13:51:56 -0700
X-Google-Sender-Auth: Eh0-Thhm5GGEnuCFS2CUxAGa8eU
Message-ID: <CAD=FV=XELzjc6h06MhwW-8XCOvH4vhMk1zzK_aD+94RdbCzUtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: Mark Brown <broonie@kernel.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, sboyd@kernel.org,
        ilina@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 27, 2018 at 4:56 AM, Mark Brown <broonie@kernel.org> wrote:
>> > Here is an explanation for why the "device tree mode" abstraction is
>> > present in the first place.  Between different Qualcomm Technologies, Inc.
>> > PMICs, regulators support a subset of the same modes (HPM/PWM, AUTO,
>> > LPM/PFM, Retention, and pass-through).  However, the register values for
>> > the same modes vary between different regulator types and different PMIC
>> > families.  This patch is adding support for several PMIC4 family PMICs.
>> > The values needed for to-be-released PMIC5 PMIC regulators are different.
>> > As an example, here are the different values for LPM/PFM across PMIC
>> > families and regulator types: PMIC4 LDO/SMPS = 5, PMIC4 BOB = 1, PMIC5
>> > LDO/HFSMPS/BOB = 4, PMIC5 FTSMPS = N/A.  Having the "device tree mode"
>> > ensures that it is not possible to inadvertently specify a PMIC specific
>> > mode in device tree which corresponds to the wrong type or family but
>> > which aliases a value that would be accepted as correct.
>
>> I'm OK with having the "device tree mode" abstraction, and in fact the
>> current regulator framework seems to want you to have this anyway.  If
>> I read the code correctly, you're required to have the conversion
>> function and there's no default.
>
> I didn't spot this in the code but something called "device tree mode"
> sounds like it's going to be awfully confusing...

Just to clarify this bit: The regulator framework allows for a
callback function of_map_mode() in regulator drivers.  My reading of
the code shows that if you wish to use the property
"regulator-initial-mode" (like this regulator does) that it is
_required_ to provide an of_map_mode() function.

Assuming I didn't mess up my analysis, the entire job of of_map_mode()
is to convert from one integer to another.  It should take the number
that was specified in the device tree and convert it to a
REGULATOR_MODE_XXX.  That means that the regulator framework is
enforcing a distinct and per-regulator numbering system for the mode
(I called this "device tree mode").


Just for kicks, right now these are the REGULATOR_MODEs:

#define REGULATOR_MODE_FAST 0x1
#define REGULATOR_MODE_NORMAL 0x2
#define REGULATOR_MODE_IDLE 0x4
#define REGULATOR_MODE_STANDBY 0x8

--

In cpcap_map_mode():

0 (CPCAP_BIT_AUDIO_NORMAL_MODE) => 0x2 (normal)
0x40 (CPCAP_BIT_AUDIO_LOW_PWR) ==> 0x8 (standby)
else => error

--

In max77802_map_mode():

3 (MAX77802_OPMODE_NORMAL) ==> 0x2 (normal)
else (intends 1 or MAX77802_OPMODE_LP) ==> 0x8 (standby)

--

In spmi_regulator_of_map_mode():

1 => 0x2 (normal)
2 => 0x1 (fast)
else => 0x4 (idle)

--

In twl4030reg_map_mode():

0xe (RES_STATE_ACTIVE) => 0x2 (normal)
0x8 (RES_STATE_SLEEP) => 0x8 (standby)
else => error

--

So basically it sounds like everyone makes up some arbitrary numbering
system that is only used in their device tree files and needs to be
mapped into the standard numbering system...

Perhaps the right answer is to improve the regulator core to make
of_map_mode() optional?  We'd have to figure out where to place the
#defines for the default of_map_mode() so they could be used in .dts
files, but that should be possible.  Presumably it would be wise to
add a new property that was a bitmask of valid modes...


-Doug
