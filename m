Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeBHAt6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 19:49:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbeBHAt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 19:49:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD08217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x227mJhmV6rl9dLWfXj45tpAoSqzLMQ2m5gTyfEBP2qhI+3WMuhoMprlXtkIYuHEkD7yEE9oYqBq+6J3vHScQoxQ=
MIME-Version: 1.0
In-Reply-To: <1517821892.12510.32.camel@mtkswgap22>
References: <cover.1515639336.git.ryder.lee@mediatek.com> <8651585c91ee40f6ab3e30b893bcfb90fe5c2c25.1515639336.git.ryder.lee@mediatek.com>
 <20180205060833.p56dun5i4bvs3jye@rob-hp-laptop> <1517821892.12510.32.camel@mtkswgap22>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Feb 2018 18:49:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+kM19=+cMzfgvE3j01L9ahbf6PNh2eJJOkwd096RcFhg@mail.gmail.com>
Message-ID: <CAL_Jsq+kM19=+cMzfgvE3j01L9ahbf6PNh2eJJOkwd096RcFhg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: mediatek: update audsys
 documentation to adapt MFD device
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: devicetree@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 3:11 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> On Mon, 2018-02-05 at 00:08 -0600, Rob Herring wrote:
>> On Wed, Jan 31, 2018 at 03:42:44PM +0800, Ryder Lee wrote:
>> > As the MediaTek audio hardware block that expose functionalities that are
>> > handled by separate subsystems in the kernel, and there are registers that
>> > are shared between related drivers.
>> >
>> > Switch the current device to an MFD device, add more descriptions about the
>> > subsystem and modify example accordingly.
>> >
>> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>> > ---
>> >  .../bindings/arm/mediatek/mediatek,audsys.txt      | 37 ++++++++++++++++++----
>> >  1 file changed, 30 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
>> > index 9b8f578..677af40 100644
>> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
>> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
>> > @@ -1,22 +1,45 @@
>> > -MediaTek AUDSYS controller
>> > +MediaTek Audio Subsystem
>> >  ============================
>> > +The audio subsystem is one of the multi-function blocks of MediaTek SoCs.
>> > +It contains a system controller, which provides a number registers giving
>> > +access to two features: AUDSYS clocks and Audio Front End (AFE) components.
>> >
>> > +For the top level node:
>> > +- compatible: must be: "syscon", "simple-mfd";
>>
>> This should have some SoC specific compatible.
>
> As we don't have a specific driver (compatible string) for it and if we
> need to add that I think the term '*-audsys' is very suitable here, but
> unfortunately, it has already picked for clock driver (see child node).

Perhaps the clocks block should have "-clk" on the end or something.

Why do you really need to change this in the first place? You don't
have to have DT child nodes to create child (struct) devices and child
drivers.

>
> I also took ../../marvell/*-system-controller.txt as examples for my
> case. Thus, I'm not sure should we still need a new one here?
>
>> > +- reg: register area of the Audio Subsystem
>> > +
>> > +Required sub-nodes:
>> > +
>> > +AUDSYS clocks:
>> > +-------
>> >  The MediaTek AUDSYS controller provides various clocks to the system.
>> >
>> >  Required Properties:
>> >
>> >  - compatible: Should be one of:
>> > -   - "mediatek,mt7622-audsys", "syscon"
>> > +   - "mediatek,mt2701-audsys";
>> > +   - "mediatek,mt7622-audsys";
>> >  - #clock-cells: Must be 1
>> >
>> >  The AUDSYS controller uses the common clk binding from
>> >  Documentation/devicetree/bindings/clock/clock-bindings.txt
>> >  The available clocks are defined in dt-bindings/clock/mt*-clk.h.
>>
>> There's no register range associated with the clocks? If there is, add a
>> reg property.
>
> No, we don't need reg property here, as the two sub-drivers will obtain
> the regmap  which is propagated from the parent.

I know regmap doesn't need it. That's not what I asked. If you have a
range of registers for the clocks, then define that in reg. Only if
the clock control bits are mixed up with other functions within the
same registers, then you can omit it.

Rob
