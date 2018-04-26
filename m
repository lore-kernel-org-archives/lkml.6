Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbeDZTyI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 15:54:08 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3449 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeDZTyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:54:07 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Apr 2018 12:54:07 -0700
From: Rohit Khanna <rokhanna@nvidia.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC: "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>, Bo Yan <byan@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vignesh Radhakrishnan <vigneshr@nvidia.com>,
        "Krishna Sitaraman" <ksitaraman@nvidia.com>
Subject: Re: [PATCH] arm64: skip cpu nodes marked as disabled in DT
Thread-Topic: [PATCH] arm64: skip cpu nodes marked as disabled in DT
Thread-Index: AQHT3Zcio9w1W4aYuUavUnngqtv8oQ==
Date: Thu, 26 Apr 2018 19:54:06 +0000
Message-ID: <1524772461183.61914@nvidia.com>
References: <1524697712-20208-1-git-send-email-rokhanna@nvidia.com>
 <1524699380207.85374@nvidia.com>
 <20180426072514.GA33476@MBP.local>,<20180426101802.GA1646@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180426101802.GA1646@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.17.136.184]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Lorenzo for pulling out the old thread.

So just to make sure my understanding is correct from the discussion on that thread, below is not a preferred approach.

"If CPUs are marked as disabled in the devicetree, make sure they do
not exist in the system CPU information and CPU topology information."


The reason is because - "The meaning of disabled for cpus in ePAPR is that the cpu is offline
(i.e. in a spinloop or wfi), not that the cpu is unavailable."


Preferred approach is -
"Since with this approach the DT should change anyway if on different
>    hardware devices based on the same chip you want to allow booting a
>    different number of CPUs, why do not we remove the cpu nodes instead of
>    disabling them"

Thanks
Rohit
________________________________________
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sent: Thursday, April 26, 2018 3:18 AM
To: Catalin Marinas; Rohit Khanna
Cc: will.deacon@arm.com; linux-kernel@vger.kernel.org; Thierry Reding; Alexander Van Brunt; Bo Yan; Jason Sequeira; Mark Rutland
Subject: Re: [PATCH] arm64: skip cpu nodes marked as disabled in DT

On Thu, Apr 26, 2018 at 08:25:14AM +0100, Catalin Marinas wrote:
> On Wed, Apr 25, 2018 at 11:36:06PM +0000, Rohit Khanna wrote:
> > Adding few other folks.
>
> It looks fine to me but cc'ing Mark and Lorenzo (and it should have been
> posted on linux-arm-kernel@lists.infradead.org).
>
> > From: Rohit Khanna
> > Sent: Wednesday, April 25, 2018 4:08 PM
> > To: catalin.marinas@arm.com; will.deacon@arm.com
> > Cc: linux-kernel@vger.kernel.org; Rohit Khanna
> > Subject: [PATCH] arm64: skip cpu nodes marked as disabled in DT
> >
> > Skip the CPU nodes that are marked as disabled in DT.
> >
> > Bug 1828570

That's not information that can be used in its current form, which
bug-tracking system ?

> > Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
> > Reviewed-on: http://git-master/r/1245333

If it is a public mailing list discussion the

Link:

tag and the lkml redirector should be used, I do not know what the
redirector used here is though.

Process is defined here:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> > Reviewed-by: Alexander Van Brunt <avanbrunt@nvidia.com>
> > ---
> >  arch/arm64/kernel/smp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index f3e2e3aec0b0..2b4371b0948d 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -578,6 +578,10 @@ static void __init of_parse_and_init_cpus(void)
> >         for_each_node_by_type(dn, "cpu") {
> >                 u64 hwid = of_get_cpu_mpidr(dn);
> >
> > +               /* Check to see if the cpu is disabled */
> > +               if (!of_device_is_available(dn))
> > +                       goto next;
> > +

This was discussed a long time ago and kind of dropped - I digged the
thread out of archives for everyone's information:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/174324.html

Lorenzo
