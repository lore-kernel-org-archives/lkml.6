Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934617AbeCHBed (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933575AbeCHBec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:34:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F8F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELsjwLm4HBRpcdgGD48BD8DDnfiN49ALxFQ0aoph8EYwg3Id5qWJ+CEFyHUM7e7ZNkeXS+q4/giniT/H08wDxOc=
MIME-Version: 1.0
In-Reply-To: <1520471460.55728.73.camel@intel.com>
References: <cover.1520450752.git.ivan.gorinov@intel.com> <3a0359afad71abc0c0d682bfcd0dd66055f5d7e5.1520450752.git.ivan.gorinov@intel.com>
 <CAL_JsqJ=CPRxCMzTyxhPvSXiT2MNQdfc1tmzXD0utikqqCp+Bw@mail.gmail.com> <1520471460.55728.73.camel@intel.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 7 Mar 2018 19:34:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+raaenSBMWYE-Qzc+Y7xVpur0UZj5X47n+64ipwAWhg@mail.gmail.com>
Message-ID: <CAL_JsqK+raaenSBMWYE-Qzc+Y7xVpur0UZj5X47n+64ipwAWhg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] of: Documentation: Add x86 local APIC ID property
To: Ivan Gorinov <ivan.gorinov@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 7:11 PM, Ivan Gorinov <ivan.gorinov@intel.com> wrote:
> On Wed, 2018-03-07 at 14:23 -0600, Rob Herring wrote:
>
>> > Add new "intel,apic-id" property to allow using CPU descriptions
>> > in Device Tree data provided by the U-Boot loader.
>> > Address specified in 'reg' to be used as default local APIC ID
>> > to avoid breaking existing systems with DTB provided by firmware.
>> Is there some reason to not always use reg? For when the numbering of
>> cpus and timers is different?
>
> Yes, local APIC ID may differ from CPU number.
> For example, in Atom E38xx (u-boot/arch/x86/dts/minnowmax.dts):
>
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 cpu@0 {
>                         device_type = "cpu";
>                         compatible = "intel,baytrail-cpu";
>                         reg = <0>;
>                         intel,apic-id = <0>;
>                 };
>
>                 cpu@1 {
>                         device_type = "cpu";
>                         compatible = "intel,baytrail-cpu";
>                         reg = <1>;
>                         intel,apic-id = <4>;
>                 };
>         };
>
>> Of course, we do have the situation on ARM with the GIC that the GIC
>> CPU IDs may be
>> >
>> >
>> > Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
>> > ---
>> >  Documentation/devicetree/bindings/x86/ce4100.txt | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
>> > index b49ae59..d15de48 100644
>> > --- a/Documentation/devicetree/bindings/x86/ce4100.txt
>> > +++ b/Documentation/devicetree/bindings/x86/ce4100.txt
>> > @@ -14,11 +14,17 @@ The CPU node
>> >                 compatible = "intel,ce4100";
>> >                 reg = <0>;
>> >                 lapic = <&lapic0>;
>> Isn't this enough? I can't tell because whatever this points to has no
>> binding documentation.
>
> Local APIC is a part of CPU, not an external device (except for 486 and early Pentium).
> Every CPU has access to its own local APIC registers at the same base address (0xfee00000).
> Therefore, one "lapic" device node can work for all processors in the system.

Do you need a lapic node then? If you typically don't have a node,
then just having the id should be fine.

> With more changes in the code, the local APIC description could be made optional
> because every processor can always read its local APIC base address from MSR 0x1b.
> And when x2APIC mode is enabled, the local APIC registers are accessed as model
> specific registers instead of memory-mapped I/O.
>
>> You could perhaps extend it and add a cell with the id value.
>
> This may require different DT data for Linux and U-Boot, or changes in the latter.

The latter case. There's one upstream for DT binding reviews.

Rob
