Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeCTSSM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:18:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:3785 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbeCTSSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:18:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,336,1517904000";
   d="scan'208";a="40661602"
Date: Tue, 20 Mar 2018 11:10:18 -0700
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 1/2] of: Documentation: Specify local APIC ID in "reg"
Message-ID: <20180320181018.GA8670@intel.com>
References: <cover.1520974793.git.ivan.gorinov@intel.com>
 <c5eb2fd010855d187007859e7a332c866fbd41ec.1520974793.git.ivan.gorinov@intel.com>
 <CAL_JsqLvV6-MY_4ui8T3nYnqG0q=QN6nnCVxbxD0aarhLqjNKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLvV6-MY_4ui8T3nYnqG0q=QN6nnCVxbxD0aarhLqjNKA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 07:39:52PM -0500, Rob Herring wrote:
> On Tue, Mar 13, 2018 at 5:05 PM, Ivan Gorinov <ivan.gorinov@intel.com> wrote:
> > Use the "reg" property to specify the processor's local APIC ID.
> > Local APIC ID is assigned by hardware and may differ from CPU number.
> 
> Is "CPU number" a s/w visible h/w number or has it just been an index
> for DT? In the latter case, I'm okay with this change. In the former
> case, you should stick to the existing numbering. For example on ARM,
> the number here corresponds to a core ID number in a register called
> MPIDR.

The latter case. Apparently, "CPU number" was just an index in the list.
Local APIC ID is the s/w visible h/w assigned number.
Some processor models allow local APIC ID to be changed by software, but
CPUID instruction executed with %eax = 0x0b always returns the initial ID
assigned by hardware in %edx.

APIC ID does not match index in the list in many systems.

> >
> > Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> > ---
> >  Documentation/devicetree/bindings/x86/ce4100.txt | 37 ++++++++++++++++++------
> >  1 file changed, 28 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
> > index b49ae59..1c41cbd 100644
> > --- a/Documentation/devicetree/bindings/x86/ce4100.txt
> > +++ b/Documentation/devicetree/bindings/x86/ce4100.txt
> > @@ -7,17 +7,36 @@ Many of the "generic" devices like HPET or IO APIC have the ce4100
> >  name in their compatible property because they first appeared in this
> >  SoC.
> >
> > -The CPU node
> > -------------
> > -       cpu@0 {
> > -               device_type = "cpu";
> > -               compatible = "intel,ce4100";
> > -               reg = <0>;
> > -               lapic = <&lapic0>;
> > +The CPU nodes
> > +-------------
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu@0x00 {
> 
> Drop the '0x' and leading 0s.
> 
> > +                       device_type = "cpu";
> > +                       compatible = "intel,ce4100";
> > +                       reg = <0x00>;
> > +               };
> > +
> > +               cpu@0x02 {
> > +                       device_type = "cpu";
> > +                       compatible = "intel,ce4100";
> > +                       reg = <0x02>;
> > +               };
> >         };
> >
> > -The reg property describes the CPU number. The lapic property points to
> > -the local APIC timer.
> > +A "cpu" node describes one logical processor (hardware thread).
> > +
> > +Required properties:
> > +
> > +- device_type
> > +       Device type, must be "cpu".
> > +
> > +- reg
> > +       Local APIC ID, the unique number assigned to each processor by
> > +       system hardware.
> >
> >  The SoC node
> >  ------------
> > --
> > 2.7.4
> >
