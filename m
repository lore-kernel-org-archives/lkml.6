Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDHCrb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 22:47:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752257AbeDHCra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 22:47:30 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/3] resource: Use list_head to link sibling resource
Date: Sun,  8 Apr 2018 10:47:21 +0800
Message-Id: <20180408024724.16812-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This post mainly converts strut resource's sibling list from singly
linked list to doubly linked list, list_head. This is suggested by
Andrew. Since I need a reversed searching on iomem_resource's
IORESOURCE_SYSTEM_RAM children,  the old singly linked list way makes
the code in v1 post really ugly.

With this change, we only need one simple list_for_each_entry_reverse()
to do reversed iteration on sibling list. The relevant codes in
kernel/resource.c are more readable since those dazzling pointer
operation codes for singly linked list are replaced. 

With the help of list_head, in patch 0002 we can have a very simple
walk_system_ram_res_rev(). And in patch 0003, will use it to search
available system RAM region for kexec_buffer of kexec_file from top to
down, just like we have been doing all along in kexec loading which is
done in kexec-tools utility.

Note:
This patchset passed testing on my kvm guest, x86_64 arch with network
enabling. The thing we need pay attetion to is that a root resource's
child member need be initialized specifically with LIST_HEAD_INIT() if
sttically defined or INIT_LIST_HEAD() for dynamically definition. Here
Just like we do for iomem_resource/ioport_resource, or the change in
get_pci_domain_busn_res().

And there are two places of change I am not very sure. One is in
drivers/hv/vmbus_drv.c, the other is in drivers/pci/host/vmd.c. So will
invite experts on these areas to help review.

v1->v2:
  Use list_head instead to link resource siblings. This is suggested by
  Andrew.

  Rewrite walk_system_ram_res_rev() after list_head is taken to link
  resouce siblings.

Baoquan He (3):
  resource: Use list_head to link sibling resource
  resource: add walk_system_ram_res_rev()
  kexec_file: Load kernel at top of system RAM if required

 drivers/gpu/drm/gma500/gtt.c                |   5 +-
 drivers/hv/vmbus_drv.c                      |  52 +++----
 drivers/input/joystick/iforce/iforce-main.c |   4 +-
 drivers/nvdimm/e820.c                       |   2 +-
 drivers/nvdimm/namespace_devs.c             |  14 +-
 drivers/nvdimm/nd.h                         |   5 +-
 drivers/of/address.c                        |   4 +-
 drivers/pci/host/vmd.c                      |   8 +-
 drivers/pci/probe.c                         |   2 +
 drivers/pci/setup-bus.c                     |   2 +-
 include/linux/ioport.h                      |   7 +-
 kernel/kexec_file.c                         |   2 +
 kernel/resource.c                           | 233 +++++++++++++++++-----------
 13 files changed, 196 insertions(+), 144 deletions(-)

-- 
2.13.6
