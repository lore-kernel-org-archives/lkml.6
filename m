Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCEPqz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:46:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:10638 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932092AbeCEPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:46:52 -0500
X-UUID: cb59fb966ffa4e67b5565ac6019ee814-20180305
Message-ID: <1520264808.8089.261.camel@mtkswgap22>
Subject: Re: [PATCH v1 16/19] arm: dts: mt7623: fixup available memory size
 on bananapi-r2
From: Sean Wang <sean.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 5 Mar 2018 23:46:48 +0800
In-Reply-To: <CAL_JsqLO7YG+6LKa-5nvQzxpvU9MF5Y=1gZKogeCqGiW-dV3zw@mail.gmail.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
         <e49485aac14bec85c14514c1953f8d7ea5401695.1519378872.git.sean.wang@mediatek.com>
         <20180302154215.xr3b2zlmuojw5i6l@rob-hp-laptop>
         <1520033229.8089.198.camel@mtkswgap22>
         <CAL_JsqLO7YG+6LKa-5nvQzxpvU9MF5Y=1gZKogeCqGiW-dV3zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-05 at 08:16 -0600, Rob Herring wrote:
> On Fri, Mar 2, 2018 at 5:27 PM, Sean Wang <sean.wang@mediatek.com> wrote:
> > On Fri, 2018-03-02 at 09:42 -0600, Rob Herring wrote:
> >> On Fri, Feb 23, 2018 at 06:16:36PM +0800, sean.wang@mediatek.com wrote:
> >> > From: Sean Wang <sean.wang@mediatek.com>
> >> >
> >> > There is 2GB DDR3 available on bananapi-r2 board as [1] specified.
> >> >
> >> > [1] http://www.banana-pi.org/r2.html
> >> >
> >> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >> > ---
> >> >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 5 +++++
> >> >  1 file changed, 5 insertions(+)
> >> >
> >> > diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> >> > index 140ff78..3e8d02c 100644
> >> > --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> >> > +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> >> > @@ -38,6 +38,11 @@
> >> >                     default-state = "off";
> >> >             };
> >> >     };
> >> > +
> >> > +   memory {
> >>
> >> Unit address?
> >>
> >
> > If I did it with adding unit address
> >
> > -       memory {
> > +       memory@80000000 {
> >                 device_type = "memory";
> >                 reg = <0 0x80000000 0 0x80000000>;
> >         };
> >
> >
> > bad dtc blob is being generated and contains two memory nodes, one is
> > memory and the other is memory@80000000 whose blob disassembly detail is
> > as the following.
> >
> >       memory {
> >                 device_type = "memory";
> >                 reg = <0x0 0x0 0x0 0x0>;
> >         };
> >
> >
> >
> >       memory@80000000 {
> >                 device_type = "memory";
> >                 reg = <0x0 0x80000000 0x0 0x80000000>;
> >         };
> >
> >
> > and bad memory node with size 0 would cause the boot fails.
> >
> >
> > is it a dtc compiler problem ?
> 
> No, you are declaring "memory" node somewhere else. Perhaps using
> skeleton.dtsi which we are trying to remove or you have some default.
> 

Yes, your guess is right. the DTS explicitly includes skeleton64.dtsi so
two memory node is being generated.

> Using just 'memory' is fine if the base address is variable and
> determined at boot time or you have a bootloader that expects just
> 'memory'. Otherwise, this should be fixed, but you can do that after
> this patch if you want.
> 

The address where memory is located at is fixed so I should insert a
patch removing skeleton64.dtsi before adding a unit address to each
memory node.

Furthermore, the original DTS including skeleton64.dtsi seems to be a
little improper as CPU uses 32-bit addressing way to access all hardware
devices on MT7623 SoC. Thus, it seems to be better even necessary to
explicitly set both #address-cells and #size-cells to 1 at the root node
and change reg property for following the child nodes when
skeleton64.dtsi is being removed.

> Rob
