Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A5CC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 05:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4E72087D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 05:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4E72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeJMMgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeJMMgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05289D7E6A;
        Sat, 13 Oct 2018 05:00:43 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (dhcp193-42.pnq.redhat.com [10.65.193.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7A921C921;
        Sat, 13 Oct 2018 05:00:23 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org
Cc:     jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com,
        riel@surriel.com, nilal@redhat.com, kwolf@redhat.com,
        pbonzini@redhat.com, zwisler@kernel.org, vishal.l.verma@intel.com,
        dave.jiang@intel.com, david@redhat.com,
        xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com,
        lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com,
        pagupta@redhat.com
Subject: [PATCH v2 0/2] kvm "fake DAX" device
Date:   Sat, 13 Oct 2018 10:30:19 +0530
Message-Id: <20181013050021.11962-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 13 Oct 2018 05:00:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch series has implementation for "fake DAX". 
 "fake DAX" is fake persistent memory(nvdimm) in guest 
 which allows to bypass the guest page cache. This also
 implements a VIRTIO based asynchronous flush mechanism.  
 
 Sharing guest kernel driver in this patchset with the 
 changes suggested in v1. Tested with Qemu side device 
 emulation for virtio-pmem [4]. 
 
 Details of project idea for 'fake DAX' flushing interface 
 is shared [2] & [3].

 Implementation is divided into two parts:
 New virtio pmem guest driver and qemu code changes for new 
 virtio pmem paravirtualized device.

1. Guest virtio-pmem kernel driver
---------------------------------
   - Reads persistent memory range from paravirt device and 
     registers with 'nvdimm_bus'.  
   - 'nvdimm/pmem' driver uses this information to allocate 
     persistent memory region and setup filesystem operations 
     to the allocated memory. 
   - virtio pmem driver implements asynchronous flushing 
     interface to flush from guest to host.

2. Qemu virtio-pmem device
---------------------------------
   - Creates virtio pmem device and exposes a memory range to 
     KVM guest. 
   - At host side this is file backed memory which acts as 
     persistent memory. 
   - Qemu side flush uses aio thread pool API's and virtio 
     for asynchronous guest multi request handling. 

   David Hildenbrand CCed also posted a modified version[5] of 
   qemu virtio-pmem code based on updated Qemu memory device API. 

 Virtio-pmem errors handling:
 ----------------------------------------
  Checked behaviour of virtio-pmem for below types of errors
  Need suggestions on expected behaviour for handling these errors?

  - Hardware Errors: Uncorrectable recoverable Errors: 
  a] virtio-pmem: 
    - As per current logic if error page belongs to Qemu process, 
      host MCE handler isolates(hwpoison) that page and send SIGBUS. 
      Qemu SIGBUS handler injects exception to KVM guest. 
    - KVM guest then isolates the page and send SIGBUS to guest 
      userspace process which has mapped the page. 
  
  b] Existing implementation for ACPI pmem driver: 
    - Handles such errors with MCE notifier and creates a list 
      of bad blocks. Read/direct access DAX operation return EIO 
      if accessed memory page fall in bad block list.
    - It also starts backgound scrubbing.  
    - Similar functionality can be reused in virtio-pmem with MCE 
      notifier but without scrubbing(no ACPI/ARS)? Need inputs to 
      confirm if this behaviour is ok or needs any change?

Changes from PATCH v1: [1]
- 0-day build test for build dependency on libnvdimm 

 Changes suggested by - [Dan Williams]
- Split the driver into two parts virtio & pmem  
- Move queuing of async block request to block layer
- Add "sync" parameter in nvdimm_flush function
- Use indirect call for nvdimm_flush
- Don’t move declarations to common global header e.g nd.h
- nvdimm_flush() return 0 or -EIO if it fails
- Teach nsio_rw_bytes() that the flush can fail
- Rename nvdimm_flush() to generic_nvdimm_flush()
- Use 'nd_region->provider_data' for long dereferencing
- Remove virtio_pmem_freeze/restore functions
- Remove BSD license text with SPDX license text

- Add might_sleep() in virtio_pmem_flush - [Luiz]
- Make spin_lock_irqsave() narrow

Changes from RFC v3
- Rebase to latest upstream - Luiz
- Call ndregion->flush in place of nvdimm_flush- Luiz
- kmalloc return check - Luiz
- virtqueue full handling - Stefan
- Don't map entire virtio_pmem_req to device - Stefan
- request leak, correct sizeof req- Stefan
- Move declaration to virtio_pmem.c

Changes from RFC v2:
- Add flush function in the nd_region in place of switching
  on a flag - Dan & Stefan
- Add flush completion function with proper locking and wait
  for host side flush completion - Stefan & Dan
- Keep userspace API in uapi header file - Stefan, MST
- Use LE fields & New device id - MST
- Indentation & spacing suggestions - MST & Eric
- Remove extra header files & add licensing - Stefan

Changes from RFC v1:
- Reuse existing 'pmem' code for registering persistent 
  memory and other operations instead of creating an entirely 
  new block driver.
- Use VIRTIO driver to register memory information with 
  nvdimm_bus and create region_type accordingly. 
- Call VIRTIO flush from existing pmem driver.

Pankaj Gupta (2):
   libnvdimm: nd_region flush callback support
   virtio-pmem: Add virtio-pmem guest driver

[1] https://lkml.org/lkml/2018/8/31/407
[2] https://www.spinics.net/lists/kvm/msg149761.html
[3] https://www.spinics.net/lists/kvm/msg153095.html  
[4] https://lkml.org/lkml/2018/8/31/413
[5] https://marc.info/?l=qemu-devel&m=153555721901824&w=2

 drivers/acpi/nfit/core.c     |    8 ++--
 drivers/nvdimm/claim.c       |   12 ++++--
 drivers/nvdimm/nd.h          |    2 +
 drivers/nvdimm/pmem.c        |   24 +++++++++----
 drivers/nvdimm/region_devs.c |   76 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/libnvdimm.h    |   10 ++++-
 6 files changed, 110 insertions(+), 22 deletions(-)
