Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934529AbeB1UOn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:14:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934224AbeB1UOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:14:41 -0500
Subject: [PATCH 0/3] vfio/pci: ioeventfd support
From: Alex Williamson <alex.williamson@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        alex.williamson@redhat.com, peterx@redhat.com, eric.auger@redhat.com,
        aik@ozlabs.ru
Date: Wed, 28 Feb 2018 13:14:34 -0700
Message-ID: <20180228195504.25283.45666.stgit@gimli.home>
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


 drivers/vfio/pci/vfio_pci.c         |   34 ++++++
 drivers/vfio/pci/vfio_pci_private.h |   18 +++
 drivers/vfio/pci/vfio_pci_rdwr.c    |  188 +++++++++++++++++++++++++++++++----
 include/uapi/linux/vfio.h           |   27 +++++
 4 files changed, 247 insertions(+), 20 deletions(-)
