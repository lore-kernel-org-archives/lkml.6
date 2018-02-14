Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031546AbeBNVgg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:36:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:58793 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030501AbeBNVgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:36:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,514,1511856000";
   d="scan'208";a="17700445"
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Michael, Alice" <alice.michael@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>
Subject: RE: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Thread-Topic: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Thread-Index: AQHTpFslw+crNM24eUSynxqRPTqrYKOh97eAgAJsOTCAAArEUA==
Date: Wed, 14 Feb 2018 21:36:33 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882CDAA1C@ORSMSX115.amr.corp.intel.com>
References: <1518475021-3337-1-git-send-email-linux@roeck-us.net>
 <20180212234201.GB4290@saruman> <20180212235655.GC5199@roeck-us.net>
 <CD14C679C9B9B1409B02829D9B523C297C4D61@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <CD14C679C9B9B1409B02829D9B523C297C4D61@ORSMSX101.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTVjMjhjNTYtNmM5Yi00OTY2LTk5ODAtNTUwN2U5OWE4Y2QxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IjBOeFJXTHdRV0ZcLzVsN0NXNkhEQkZ3dnVqU2F1VW9IcVM1ZmJLb0ZROU40PSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michael, Alice
> Sent: Wednesday, February 14, 2018 1:03 PM
> To: Guenter Roeck <linux@roeck-us.net>; James Hogan <jhogan@kernel.org>;
> Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>; linux-mips@linux-mips.org; linux-
> kernel@vger.kernel.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Shannon
> Nelson <shannon.nelson@oracle.com>
> Subject: RE: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
> 
> As has previously been said, we're going to be removing the need for cmpxchg64.
> But it takes a little bit of time and work to do so.  I'm adding the dev that is taking
> care of the work back onto this email thread as well so he can see any concerns with
> it.
> 
> Alice
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
> Sent: Monday, February 12, 2018 3:57 PM
> To: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>; linux-mips@linux-mips.org; linux-
> kernel@vger.kernel.org; Michael, Alice <alice.michael@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Shannon Nelson <shannon.nelson@oracle.com>
> Subject: Re: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
> 
> On Mon, Feb 12, 2018 at 11:42:02PM +0000, James Hogan wrote:
> > Hi Guenter,
> >
> > On Mon, Feb 12, 2018 at 02:37:01PM -0800, Guenter Roeck wrote:
> > > Since commit 60f481b970386 ("i40e: change flags to use 64 bits"),
> > > the i40e driver uses cmpxchg64(). This causes mips:allmodconfig
> > > builds to fail with
> > >
> > > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> > > 	In function 'i40e_set_priv_flags':
> > > drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4443:2: error:
> > > 	implicit declaration of function 'cmpxchg64'
> > >
> > > Implement a poor-mans-version of cmpxchg64() to fix the problem for
> > > 32-bit mips builds. The code is derived from sparc32, but only uses
> > > a single spinlock.
> >
> > Will this be implemened for all 32-bit architectures which are
> > currently missing cmpxchg64()?
> >
> No idea.
> 
> > If so, any particular reason not to do it in generic code?
> >
> Again, no idea. When the problem was previously seen on sparc32, it was
> implemented there.
> 
> > If not then I think that driver should be fixed to either depend on
> > some appropriate Kconfig symbol or to not use this API since it
> > clearly isn't portable at the moment.
> >
> Good point.
> 
> > See also Shannon's comment about that specific driver:
> > https://lkml.kernel.org/r/e7c934d7-e5f4-ee1b-0647-c31a98d9e944@oracle.
> > com
> >
> 
> Well, this was an RFC only. Feel free to ignore it.
> 
> FWIW, this is the second time that the call was introduced in the i40 driver.
> After the first time the code was rewritten to avoid the problem, but now it came
> back. Someone must really like it ;-). For my part, I may just blacklist the offending
> driver in my builds; that is less than perfect, but much easier than having to deal with
> the same problem over and over again. Guess I'll wait for a while and do just that if
> the problem isn't fixed in a later RC.
> 
> Guenter

Hi,

I've been working on re-writing some of the code so that the need for a compare-and-exchange in the i40e_set_priv_flags() is not necessary. This mostly involved moving many flags out into an atomic bitops field instead, it should be posted to IWL soon.

Thanks,
Jake
