Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935678AbeCABml (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932134AbeCABmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:42:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52E021748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Wed, 28 Feb 2018 17:42:38 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Julien Grall <julien.grall@arm.com>
cc: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH 0/9] drm/xen-front: Add support for Xen PV
 display frontend
In-Reply-To: <4628e34f-5e7d-c2e6-d132-c1f4c1c25efd@arm.com>
Message-ID: <alpine.DEB.2.10.1802281735270.4239@sstabellini-ThinkPad-X260>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com> <4c7e6f65-1787-3815-22b5-f9495e388c06@gmail.com> <7e265c53-db9a-0946-6b1c-b946bcbb4100@gmail.com> <4628e34f-5e7d-c2e6-d132-c1f4c1c25efd@arm.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Julien Grall wrote:
> (+ Stefano and Wei)
> 
> Hi,
> 
> On 02/27/2018 12:40 PM, Oleksandr Andrushchenko wrote:
> > Please find some more clarifications on VirtIO use with Xen
> > (I would like to thank Xen community for helping with this)
> > 
> > 1. Possible security issues - VirtIO devices are PCI bus masters, thus
> > allowing real device (running, for example, in untrusted driver domain)
> > to get control over guest's memory by writing to its memory
> > 
> > 2. VirtIO currently uses GFNs written into the shared ring, without Xen
> > grants support. This will require generic grant-mapping/sharing layer
> > to be added to VirtIO.

This is important. VirtIO doesn't allow for driver domains (running the
backend inside a virtual machine). 


> > 3. VirtIO requires QEMU PCI emulation for setting up a device. Xen PV (and
> > PVH)
> > domains don't use QEMU for platform emulation in order to reduce attack
> > surface.
> > (PVH is in the process of gaining PCI config space emulation though, but it
> > is
> > optional, not a requirement)
> I don't think the support of PCI configuration space emulation for PVH would
> help there. The plan is to emulate in Xen, QEMU is still out of the equation
> there.

Right: there is no infrastructure to run IO emulation in userspace for
PV, PVH and ARM guests. We do have a QEMU instance running for PV, PVH
and ARM guests but only to implement PV backends, such as the vdispl
backend for example, which are handling asynchronous requests from
frontends using the traditional grant table maps/unmaps.


> > 4. Most of the PV drivers a guest uses at the moment are Xen PV drivers,
> > e.g. net,
> > block, console, so only virtio-gpu will require QEMU to run.
> > Although this use case would work on x86 it will require additional changes
> > to get this running on ARM, which is my target platform.
> 
> All type of guests but x86 HVM are not using QEMU for device emulation.
> 
> I would even be stronger here. Using QEMU would require a significant amount
> of engineering to make it work and increase the cost of safety certification
> for automotive use cases. So IHMO, the Xen PV display solution is the best.
> 
> The protocol was accepted and merged in Xen 4.9. This the standard way to have
> para-virtualized display for guests on Xen. Having the driver merged in Linux
> would help user to get out-of-box display in guest.

That's right. I don't think it really makes sense to introduce virtio
support in Xen on ARM as it is today.
