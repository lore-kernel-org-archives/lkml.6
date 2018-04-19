Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeDSATD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 20:19:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752391AbeDSATC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 20:19:02 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org
Cc: Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/3] resource: Use list_head to link sibling resource
Date: Thu, 19 Apr 2018 08:18:45 +0800
Message-Id: <20180419001848.3041-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset mainly converts strut resource's sibling list from singly
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

V2 post and discussions can be found here:
https://lkml.org/lkml/2018/4/7/169

Remaining issue:
Rob raised issue that if we can make an common tree struct and helpers
defined on top of list_head or a new struct, quote his saying as below.
I didn't do much investigation, we may have a new struct like 

struct tlist {
        void                    *parent;
        struct list_head        sibling;
        struct list_head        child;
}

Since I have some rhel dev things right now, may consider this later, put
it in my TODO list. In kernel, like task_struct, task_group, they all have
this kind of tree list, and have used list_head. If anyone is interested,
feel free to have a try on this.

==========
The DT struct device_node also has the same tree structure with
parent, child, sibling pointers and converting to list_head had been
on the todo list for a while. ACPI also has some tree walking
functions (drivers/acpi/acpica/pstree.c). Perhaps there should be a
common tree struct and helpers defined either on top of list_head or a
new struct if that saves some size.
==========


Changelog:
v2->v3:
  Rename resource functions first_child() and sibling() to
  resource_first_chils() and resource_sibling(). Dan suggested this.

  Move resource_first_chils() and resource_sibling() to linux/ioport.h
  and make them as inline function. Rob suggested this. Accordingly add
  linux/list.h including in linux/ioport.h, please help review if this
  bring efficiency degradation or code redundancy.

  The change on struct resource {} bring two pointers of size increase,
  mention this in git log to make it more specifically, Rob suggested
  this.

v1->v2:
  Use list_head instead to link resource siblings. This is suggested by
  Andrew.

  Rewrite walk_system_ram_res_rev() after list_head is taken to link
  resouce siblings.

Baoquan He (3):
  resource: Use list_head to link sibling resource
  resource: add walk_system_ram_res_rev()
  kexec_file: Load kernel at top of system RAM if required

 arch/sparc/kernel/ioport.c                  |   2 +-
 drivers/gpu/drm/drm_memory.c                |   3 +-
 drivers/gpu/drm/gma500/gtt.c                |   5 +-
 drivers/hv/vmbus_drv.c                      |  52 +++----
 drivers/input/joystick/iforce/iforce-main.c |   4 +-
 drivers/nvdimm/e820.c                       |   2 +-
 drivers/nvdimm/namespace_devs.c             |   6 +-
 drivers/nvdimm/nd.h                         |   5 +-
 drivers/of/address.c                        |   4 +-
 drivers/parisc/lba_pci.c                    |   4 +-
 drivers/pci/host/vmd.c                      |   8 +-
 drivers/pci/probe.c                         |   2 +
 drivers/pci/setup-bus.c                     |   2 +-
 include/linux/ioport.h                      |  20 ++-
 kernel/kexec_file.c                         |   2 +
 kernel/resource.c                           | 221 ++++++++++++++++------------
 16 files changed, 193 insertions(+), 149 deletions(-)

-- 
2.13.6
