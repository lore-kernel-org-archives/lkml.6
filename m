Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031283AbeBOMqg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:46:36 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33646 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030245AbeBOMqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:46:33 -0500
X-Google-Smtp-Source: AH8x224PHmabG3ZdBjnk/j7bypfMswgauhYx+8ndut6ysxaiSDvElx4Th/ReNM3Rfdf3JfgUqYvUzKbpz05kTLZMLuE=
MIME-Version: 1.0
In-Reply-To: <b8cc84ad-0a64-38f0-d8ac-ad9ae88c5912@ideasonboard.com>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-6-git-send-email-kbingham@kernel.org> <CAMuHMdVKczZpoXgSDOSEJZb59LAZtbWsopRaa8PtHDoZcFEMTQ@mail.gmail.com>
 <b8cc84ad-0a64-38f0-d8ac-ad9ae88c5912@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2018 13:46:32 +0100
X-Google-Sender-Auth: PSrgo-SDzUiZGIgX-DFfn0kXPag
Message-ID: <CAMuHMdVUQ5c3rEG7-eYCQRPK=si8OSz-o+7z8qPsSOd5y7URww@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: renesas: r8a77995: Add LVDS support
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Thu, Feb 15, 2018 at 1:41 PM, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
> On 15/02/18 09:07, Geert Uytterhoeven wrote:
>> On Thu, Feb 15, 2018 at 9:38 AM, Kieran Bingham <kbingham@kernel.org> wrote:
>>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>>
>>> The r8a77995 D3 platform has 2 LVDS channels connected to the DU.
>>>
>>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> I love your patch!
>> Yet something to improve...
>>
>>> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>>> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>>> @@ -773,18 +773,70 @@
>>>                                 port@1 {
>>>                                         reg = <1>;
>>>                                         du_out_lvds0: endpoint {
>>> +                                               remote-endpoint = <&du_out_lvds0>;
>>>                                         };
>>>                                 };
>>>
>>>                                 port@2 {
>>>                                         reg = <2>;
>>>                                         du_out_lvds1: endpoint {
>>> +                                               remote-endpoint = <&du_out_lvds1>;
>>>                                         };
>>>                                 };
>>>                         };
>>>                 };
>>>         };
>>>
>>> +       lvds0: lvds@feb90000 {
>>> +               compatible = "renesas,lvds-r8a77995";
>>> +               reg = <0 0xfeb90000 0 0x20>;
>>> +               clocks = <&cpg CPG_MOD 727>;
>>> +               status = "disabled";
>>
>> Missing resets, power-domains
>
> Both lvds0, and lvds1 are actually the same 'module' (just different mappings
> within the same IP block).
>
> That means they will share clock, reset etc.
>
> Will specifying the resets cause one to affect the other unduly?
>
> like if one becomes un-used, will it power down? or is it refcounted, and will
> gracefully handle both device nodes from the same device?
>
> I'm already fairly sure clocks is fine for this - but it's just the reset's that
> worry me. If the reset module tries to reset lvds0 for some reason - would lvds1
> get reset as a side effect ...

Clocks handle sharing fine, they do refcounting.

For resets, there is some sharing/exclusive support, but we don't have that
much experience with resets as we don't use it that much yet (USB uses it).
So for now it's mostly about "describing the hardware".

Triggering a reset will indeed reset all modules using the same reset.
The same is true for e.g. PWM.

> Or perhaps that won't ever happen with an :
>
>                 power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>                 resets = <&cpg 727>;

The power-domains property is related to power management (in this case
clock domain only, as it's the "always-on" domain), not reset.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
