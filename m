Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeCOVbh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:31:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbeCOVbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:31:35 -0400
Subject: [PATCH v2 0/3] vfio/pci: ioeventfd support
From: Alex Williamson <alex.williamson@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        alex.williamson@redhat.com, peterx@redhat.com, eric.auger@redhat.com,
        aik@ozlabs.ru
Date: Thu, 15 Mar 2018 15:31:27 -0600
Message-ID: <20180315212634.15150.88094.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A vfio ioeventfd will perform the pre-specified device write on
triggering of an eventfd.  When coupled with KVM ioeventfds, this
feature allows a VM to trap a device page for virtualization, while
also registering targeted ioeventfds to maintain performance of high
frequency register writes within the trapped range.  Much like the
existing interrupt eventfd/irqfd coupling, such writes can be handled
entirely in the host kernel.

The new VFIO device ioctl may be supported by any vfio bus driver,
including mdev drivers, but the implementation here only enables
vfio-pci.  This is intended as an acceleration path, bus drivers
may choose which regions to support and userspace should always
intend to fall back to non-accelerated handling when unavailable.

v1->v2:
 * Peter & Eric Sign-offs on 1/3
 * mutex_destroy() in 3/3
 * Slight enhancement to uapi description
 * sparse clean - Sparse didn't like that we dropped the __iomem
   address space when calling iowriteXX, re-adding it via the opaque
   and data pointers of the virq was crude, and that was not a 32-bit
   friendly soluion anyway, so add the iomem address to our ioeventfd
   struct, pass that, and use a more simple, common handler.

RFC->v1:
 * An arbitrary limit is added for the number of ioeventfds supported
   per device.  The intention is to set this high enough to allow any
   reasonable use case, but limit malicious user behavior.
 * Split patches, including adding a patch for endian neutral io reads
   and writes.  This should be a nop for little-endian and avoid
   redundant swap on big-endian, and hopefully resolves Alexey's
   comments regarding the endian nature of this interface.
 * Rebase to v4.16-rc3

Thanks,
Alex

---

Alex Williamson (3):
      vfio/pci: Pull BAR mapping setup from read-write path
      vfio/pci: Use endian neutral helpers
      vfio/pci: Add ioeventfd support


 drivers/vfio/pci/vfio_pci.c         |   35 +++++++
 drivers/vfio/pci/vfio_pci_private.h |   19 ++++
 drivers/vfio/pci/vfio_pci_rdwr.c    |  184 +++++++++++++++++++++++++++++++----
 include/uapi/linux/vfio.h           |   27 +++++
 4 files changed, 245 insertions(+), 20 deletions(-)
