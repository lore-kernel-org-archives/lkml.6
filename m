Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACCFECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638EF208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638EF208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbeGMIGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:06:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729284AbeGMIGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36B2A402B032;
        Fri, 13 Jul 2018 07:52:43 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (dhcp193-70.pnq.redhat.com [10.65.193.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81B802026D74;
        Fri, 13 Jul 2018 07:52:35 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org
Cc:     jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com,
        riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com,
        kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com,
        david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org,
        mst@redhat.com, niteshnarayanlal@hotmail.com,
        lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com,
        pagupta@redhat.com
Subject: [RFC v3 0/2] kvm "fake DAX" device flushing
Date:   Fri, 13 Jul 2018 13:22:29 +0530
Message-Id: <20180713075232.9575-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 07:52:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 07:52:43 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pagupta@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is RFC V3 for 'fake DAX' flushing interface sharing
for review. This patchset has two parts:

- Guest virtio-pmem driver
  Guest driver reads persistent memory range from paravirt device 
  and registers with 'nvdimm_bus'. 'nvdimm/pmem' driver uses this 
  information to allocate persistent memory range. Also, we have 
  implemented guest side of VIRTIO flushing interface.

- Qemu virtio-pmem device
  It exposes a persistent memory range to KVM guest which at host 
  side is file backed memory and works as persistent memory device. 
  In addition to this it provides virtio device handling of flushing 
  interface. KVM guest performs Qemu side asynchronous sync using 
  this interface.

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

Details of project idea for 'fake DAX' flushing interface is 
shared [2] & [3].

Pankaj Gupta (2):
   Add virtio-pmem guest driver
   pmem: device flush over VIRTIO

[1] https://marc.info/?l=linux-mm&m=150782346802290&w=2
[2] https://www.spinics.net/lists/kvm/msg149761.html
[3] https://www.spinics.net/lists/kvm/msg153095.html  

 drivers/nvdimm/nd.h              |    1 
 drivers/nvdimm/pmem.c            |    4 
 drivers/nvdimm/region_devs.c     |   24 +++-
 drivers/virtio/Kconfig           |    9 +
 drivers/virtio/Makefile          |    1 
 drivers/virtio/virtio_pmem.c     |  190 +++++++++++++++++++++++++++++++++++++++
 include/linux/libnvdimm.h        |    5 -
 include/linux/virtio_pmem.h      |   44 +++++++++
 include/uapi/linux/virtio_ids.h  |    1 
 include/uapi/linux/virtio_pmem.h |   40 ++++++++
 10 files changed, 310 insertions(+), 9 deletions(-)

