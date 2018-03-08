Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755156AbeCHBSc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:18:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:45875 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754963AbeCHBSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:18:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,438,1515484800";
   d="scan'208";a="32184272"
Message-ID: <1520471460.55728.73.camel@intel.com>
Subject: Re: [PATCH v4 3/4] of: Documentation: Add x86 local APIC ID property
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Date: Wed, 07 Mar 2018 17:11:00 -0800
In-Reply-To: <CAL_JsqJ=CPRxCMzTyxhPvSXiT2MNQdfc1tmzXD0utikqqCp+Bw@mail.gmail.com>
References: <cover.1520450752.git.ivan.gorinov@intel.com>
         <3a0359afad71abc0c0d682bfcd0dd66055f5d7e5.1520450752.git.ivan.gorinov@intel.com>
         <CAL_JsqJ=CPRxCMzTyxhPvSXiT2MNQdfc1tmzXD0utikqqCp+Bw@mail.gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 14:23 -0600, Rob Herring wrote:

> > Add new "intel,apic-id" property to allow using CPU descriptions
> > in Device Tree data provided by the U-Boot loader.
> > Address specified in 'reg' to be used as default local APIC ID
> > to avoid breaking existing systems with DTB provided by firmware.
> Is there some reason to not always use reg? For when the numbering of
> cpus and timers is different?

Yes, local APIC ID may differ from CPU number.
For example, in Atom E38xx (u-boot/arch/x86/dts/minnowmax.dts):

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu@0 {
			device_type = "cpu";
			compatible = "intel,baytrail-cpu";
			reg = <0>;
			intel,apic-id = <0>;
		};

		cpu@1 {
			device_type = "cpu";
			compatible = "intel,baytrail-cpu";
			reg = <1>;
			intel,apic-id = <4>;
		};
	};

> Of course, we do have the situation on ARM with the GIC that the GIC
> CPU IDs may be
> > 
> > 
> > Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> > ---
> >  Documentation/devicetree/bindings/x86/ce4100.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
> > index b49ae59..d15de48 100644
> > --- a/Documentation/devicetree/bindings/x86/ce4100.txt
> > +++ b/Documentation/devicetree/bindings/x86/ce4100.txt
> > @@ -14,11 +14,17 @@ The CPU node
> >                 compatible = "intel,ce4100";
> >                 reg = <0>;
> >                 lapic = <&lapic0>;
> Isn't this enough? I can't tell because whatever this points to has no
> binding documentation.

Local APIC is a part of CPU, not an external device (except for 486 and early Pentium).
Every CPU has access to its own local APIC registers at the same base address (0xfee00000).
Therefore, one "lapic" device node can work for all processors in the system.

With more changes in the code, the local APIC description could be made optional
because every processor can always read its local APIC base address from MSR 0x1b.
And when x2APIC mode is enabled, the local APIC registers are accessed as model
specific registers instead of memory-mapped I/O.

> You could perhaps extend it and add a cell with the id value.

This may require different DT data for Linux and U-Boot, or changes in the latter.
