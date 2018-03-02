Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946343AbeCBSDI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:03:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426543AbeCBSDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:03:04 -0500
Date: Fri, 2 Mar 2018 11:02:57 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>
Subject: Re: [PATCH 0/3] vfio/pci: ioeventfd support
Message-ID: <20180302110257.36cc0ed3@t450s.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19102545C@SHSMSX101.ccr.corp.intel.com>
References: <20180228195504.25283.45666.stgit@gimli.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D19102545C@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2018 07:08:51 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson
> > Sent: Thursday, March 1, 2018 4:15 AM
> > 
> > A vfio ioeventfd will perform the pre-specified device write on
> > triggering of an eventfd.  When coupled with KVM ioeventfds, this
> > feature allows a VM to trap a device page for virtualization, while
> > also registering targeted ioeventfds to maintain performance of high
> > frequency register writes within the trapped range.  Much like the
> > existing interrupt eventfd/irqfd coupling, such writes can be handled
> > entirely in the host kernel.
> > 
> > The new VFIO device ioctl may be supported by any vfio bus driver,
> > including mdev drivers, but the implementation here only enables
> > vfio-pci.  This is intended as an acceleration path, bus drivers
> > may choose which regions to support and userspace should always
> > intend to fall back to non-accelerated handling when unavailable.
> >   
> 
> it's a nice feature! A curious question. Is it possible for mdev driver
> to directly create ioeventfd on specified offset? Currently ioeventfd
> requires quirks in Qemu, which must know the device detail to
> create ioeventfd and then connect vfio and kvm together. However
> mdev instance is more software defined thus I'm not sure whether 
> asking Qemu to catch up quirk with underlying software logic could
> be overwhelmed. Also in case of vendor driver emulating mdev
> with same DID/VID as a real device, it might be difficult for Qemu
> to figure out whether a vfio device is a real one or mdev one to
> apply a mdev specific quirk. On the other hand, since vendor
> driver knows all the logic constructing mdev, it would be more
> convenient allowing vendor driver to directly create/destroy
> ioeventfd on its demand?

Are file descriptors the right interface between kernel components if
userspace is not involved in connecting them?  Seems like not.  vfio is
designed to be independent of KVM with the necessary interactions
between them orchestrated by userspace.  KVMGT is about the only
exception to that and TBH I'm not thrilled about extending that
further.  Thanks,

Alex
