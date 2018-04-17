Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeDQIbv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:31:51 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34484 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeDQIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:31:40 -0400
X-Google-Smtp-Source: AIpwx4/9o/jI82AsUICG8J6knfGCUhILHftAcuNV0cIxPziEUOE9AIVBgrVgJGtWo/oMzuW6WxSB15gXrdDap8JZAhw=
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB20548CE7A728549EFA2B9ADBD2B70@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523349015-37985-4-git-send-email-michel.pollet@bp.renesas.com>
 <20180413180549.yjzkl2yf7osz7myt@rob-hp-laptop> <OSBPR01MB20548CE7A728549EFA2B9ADBD2B70@OSBPR01MB2054.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Apr 2018 10:31:38 +0200
X-Google-Sender-Auth: 6ZCRYeM791BNk5VnNMKAVO3BUwI
Message-ID: <CAMuHMdWoW6QXofvS0Ju5VL1WivmWWMx8c=ppVbKe1+2eO6LsFg@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] dt-bindings: mfd: renesas,rzn1-sysctrl: document
 RZ/N1 sysctrl node
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Rob Herring <robh@kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "buserror+upstream@gmail.com" <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Tue, Apr 17, 2018 at 9:56 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> On 13 April 2018 19:06, Rob Herring:
>> On Tue, Apr 10, 2018 at 09:30:03AM +0100, Michel Pollet wrote:
>> > The Renesas RZ/N1 Family (Part #R9A06G0xx) has a multi-function system
>> > controller. This documents the node used to encapsulate it's sub
>> > drivers.
>> >
>> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>> > ---
>> >  .../bindings/mfd/renesas,rzn1-sysctrl.txt          | 23
>> ++++++++++++++++++++++
>> >  1 file changed, 23 insertions(+)
>> >  create mode 100644
>> > Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
>> >
>> > diff --git
>> > a/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
>> > b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
>> > new file mode 100644
>> > index 0000000..9897f8f
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
>> > @@ -0,0 +1,23 @@
>> > +DT bindings for the Renesas RZ/N1 System Controller
>> > +
>> > +== System Controller Node ==
>> > +
>> > +The system controller node currently only hosts a single sub-node to
>> > +handle the rebooting of the CPU. Eventually it will host the clock
>> > +driver, SMP start handler, watchdog etc.
>>
>> Please submit a complete binding for the h/w block.
>>
>> Again, if the only reason you have sub nodes is to define compatible strings
>> and in turn enumerate drivers, then you don't need the nodes in DT. DT is
>> not the only way to instantiate drivers.
>
> I can't document it before I have the code. There is 0.000% chance of my clock
> driver for example to be upstreamed the way I would imagine making it -- in
> fact pretty much any other driver will have to be reworked to fit, so documenting
> bindings first is impossible.
>
> So, if I understand correctly, you are telling me to make a 'sysctrl' driver and use
> platform_device to instantiate my sub-drivers? Isn't that what machine files used
> to do? And they are now banned?
>
> Geert, any guidance here?

It depends on how many and which subnodes you want to add to  the sysctrl
node. Without a complete binding for the block, we cannot know.
If the major part will be the clock driver, I would make that the main
driver for the sysctrl node. The clock driver can easily register
e.g. a simple reset handler.

Cfr. the renesas-cpg-mssr driver, which also handles (module) resets.
There are plenty of other examples of drivers providing multiple
functionalities (e.g. pinctrl drivers also registering GPIO controllers).

If a monolithic driver becomes too large, it can still be split using the
MFD framework.
E.g. the BD9571 PMIC driver is split in an MFD core driver, and 2 drivers
for different functionalities:

   drivers/gpio/gpio-bd9571mwv.c
   drivers/mfd/bd9571mwv.c
   drivers/regulator/bd9571mwv-regulator.c
   include/linux/mfd/bd9571mwv.h

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
