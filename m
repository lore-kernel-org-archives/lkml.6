Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbeCCAng convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:43:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:46462 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753006AbeCCAne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:43:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,414,1515484800";
   d="scan'208";a="208447869"
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>
Subject: RE: [PATCH 0/3] vfio/pci: ioeventfd support
Thread-Topic: [PATCH 0/3] vfio/pci: ioeventfd support
Thread-Index: AQHTsNDlMLSEP3bOBEe6xhmmuixhi6O8hlzggAAzSYCAAPKE0A==
Date: Sat, 3 Mar 2018 00:43:31 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1910274D1@SHSMSX101.ccr.corp.intel.com>
References: <20180228195504.25283.45666.stgit@gimli.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19102545C@SHSMSX101.ccr.corp.intel.com>
 <20180302110257.36cc0ed3@t450s.home>
In-Reply-To: <20180302110257.36cc0ed3@t450s.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTBhMmM1ZDItZTFkZC00NjEzLTg5OTgtMjQwNjFlMWFjZjZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6ImcrbkNKUHhHY2xxRG55bUZ4UXRXQ1JEaFhVWXJoRDZuZXhVV2dcL0czbkY4PSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Saturday, March 3, 2018 2:03 AM
> 
> On Fri, 2 Mar 2018 07:08:51 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Alex Williamson
> > > Sent: Thursday, March 1, 2018 4:15 AM
> > >
> > > A vfio ioeventfd will perform the pre-specified device write on
> > > triggering of an eventfd.  When coupled with KVM ioeventfds, this
> > > feature allows a VM to trap a device page for virtualization, while
> > > also registering targeted ioeventfds to maintain performance of high
> > > frequency register writes within the trapped range.  Much like the
> > > existing interrupt eventfd/irqfd coupling, such writes can be handled
> > > entirely in the host kernel.
> > >
> > > The new VFIO device ioctl may be supported by any vfio bus driver,
> > > including mdev drivers, but the implementation here only enables
> > > vfio-pci.  This is intended as an acceleration path, bus drivers
> > > may choose which regions to support and userspace should always
> > > intend to fall back to non-accelerated handling when unavailable.
> > >
> >
> > it's a nice feature! A curious question. Is it possible for mdev driver
> > to directly create ioeventfd on specified offset? Currently ioeventfd
> > requires quirks in Qemu, which must know the device detail to
> > create ioeventfd and then connect vfio and kvm together. However
> > mdev instance is more software defined thus I'm not sure whether
> > asking Qemu to catch up quirk with underlying software logic could
> > be overwhelmed. Also in case of vendor driver emulating mdev
> > with same DID/VID as a real device, it might be difficult for Qemu
> > to figure out whether a vfio device is a real one or mdev one to
> > apply a mdev specific quirk. On the other hand, since vendor
> > driver knows all the logic constructing mdev, it would be more
> > convenient allowing vendor driver to directly create/destroy
> > ioeventfd on its demand?
> 
> Are file descriptors the right interface between kernel components if
> userspace is not involved in connecting them?  Seems like not.  vfio is
> designed to be independent of KVM with the necessary interactions
> between them orchestrated by userspace.  KVMGT is about the only
> exception to that and TBH I'm not thrilled about extending that
> further.  Thanks,
> 

why do you think KVMGT is the only exception? Isn't above scenario
general enough to any mdev implementation, just as what you're
trying to solve, that if a trapped operation happens too frequently on
mdev then we may want to optimize it? I understand fd is not a good 
way in-between kernel components, just asking here in case you
have some good idea in mind. If adding mdev specific quirk in 
Qemu is the only way for similar optimization, I'm fine with it. One
thing which I was not sure though is still about the scenario where 
mdev is constructed same as a real device then what would happen
if Qemu applies a mdev-specific quirk to both sides - of course 
just a mental thinking, not sure whether it happens in real...

Thanks
Kevin
