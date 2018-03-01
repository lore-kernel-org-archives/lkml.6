Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965389AbeCAI0v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:26:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964841AbeCAI0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:26:50 -0500
Date: Thu, 1 Mar 2018 09:26:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH 0/9] drm/xen-front: Add support for Xen PV display
 frontend
Message-ID: <20180301082648.frnslqyhffj2bkwl@sirius.home.kraxel.org>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <4c7e6f65-1787-3815-22b5-f9495e388c06@gmail.com>
 <7e265c53-db9a-0946-6b1c-b946bcbb4100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e265c53-db9a-0946-6b1c-b946bcbb4100@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> 1. Possible security issues - VirtIO devices are PCI bus masters, thus
> allowing real device (running, for example, in untrusted driver domain)
> to get control over guest's memory by writing to its memory
>
> 2. VirtIO currently uses GFNs written into the shared ring, without Xen
> grants support. This will require generic grant-mapping/sharing layer
> to be added to VirtIO.
> 
> 3. VirtIO requires QEMU PCI emulation for setting up a device. Xen PV
> (and PVH) domains don't use QEMU for platform emulation in order to
> reduce attack surface.  (PVH is in the process of gaining PCI config
> space emulation though, but it is optional, not a requirement)

Well, that is wrong.  virtio doesn't require pci.  There are other
transports (mmio, ccw), and it should be possible to create a xen
specific transport which uses grant tables properly.  Seems there even
was an attempt to implement that in 2011, see 
https://wiki.xenproject.org/wiki/Virtio_On_Xen

> 4. Most of the PV drivers a guest uses at the moment are Xen PV drivers,
> e.g. net,
> block, console, so only virtio-gpu will require QEMU to run.

You are not forced to use qemu, you can certainly create an alternative
host side implementation (and still use on the existing virtio guest
drivers).

Whenever writing a xenbus implementation for both guest and host or
writing a virtio implementation for the host only is better -- dunno.
The virtio path obviously needs some infrastructure work for virtio
support in Xen, which may pay off long term.  Your call.

cheers,
  Gerd
