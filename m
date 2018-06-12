Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 49824C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EDC208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EDC208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeFLD3B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:29:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932460AbeFLD26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:28:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2626E805A532;
        Tue, 12 Jun 2018 03:28:57 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B90F91134CA2;
        Tue, 12 Jun 2018 03:28:34 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com,
        nicolas.pitre@linaro.org, josh@joshtriplett.org,
        fengguang.wu@intel.com, bp@suse.de
Cc:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        dmitry.torokhov@gmail.com, frowand.list@gmail.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, tglx@linutronix.de,
        brijesh.singh@amd.com, jglisse@redhat.com, thomas.lendacky@amd.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, devel@linuxdriverproject.org,
        linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
        yinghai@kernel.org, kexec@lists.infradead.org, monstr@monstr.eu,
        davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 0/4] resource: Use list_head to link sibling resource
Date:   Tue, 12 Jun 2018 11:28:27 +0800
Message-Id: <20180612032831.29747-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 12 Jun 2018 03:28:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 12 Jun 2018 03:28:57 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is doing:
1) Replace struct resource's sibling list from singly linked list to
list_head. Clearing out those pointer operation within singly linked
list for better code readability.
2) Based on list_head replacement, add a new function
walk_system_ram_res_rev() which can does reversed iteration on
iomem_resource's siblings.
3) Change kexec_file loading to search system RAM top down for kernel
loadin, using walk_system_ram_res_rev().

Note:
This patchset passed testing on my kvm guest, x86_64 arch with network
enabling. The thing we need pay attetion to is that a root resource's
child member need be initialized specifically with LIST_HEAD_INIT() if
statically defined or INIT_LIST_HEAD() for dynamically definition. Here
Just like we do for iomem_resource/ioport_resource, or the change in
get_pci_domain_busn_res().


Links of the old post (Boris pointed out that we should use
https://lkml.kernel.org/r/Message-ID, while it can't be opened from
my side, so paste all of them here.):
v4:
https://lkml.kernel.org/r/20180507063224.24229-1-bhe@redhat.com
https://lkml.org/lkml/2018/5/7/36

v3:
https://lkml.kernel.org/r/20180419001848.3041-1-bhe@redhat.com
https://lkml.org/lkml/2018/4/18/767

v2:
https://lkml.kernel.org/r/20180408024724.16812-1-bhe@redhat.com
https://lkml.org/lkml/2018/4/7/169

v1:
https://lkml.kernel.org/r/20180322033722.9279-1-bhe@redhat.com
https://lkml.org/lkml/2018/3/21/952

Changelog:
v4->v5:
  Add new patch 0001 to move duplicated reparent_resources() to
  kernel/resource.c to make it be shared by different ARCH-es.

  Fix several code bugs reported by test robot on ARCH powerpc and
  microblaze.
v3->v4:
  Fix several bugs test robot reported. Rewrite cover letter and patch
  log according to reviewer's comment.

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

Baoquan He (4):
  resource: Move reparent_resources() to kernel/resource.c and make it
    public
  resource: Use list_head to link sibling resource
  resource: add walk_system_ram_res_rev()
  kexec_file: Load kernel at top of system RAM if required

 arch/arm/plat-samsung/pm-check.c            |   6 +-
 arch/microblaze/pci/pci-common.c            |  41 +----
 arch/powerpc/kernel/pci-common.c            |  39 +----
 arch/sparc/kernel/ioport.c                  |   2 +-
 arch/xtensa/include/asm/pci-bridge.h        |   4 +-
 drivers/eisa/eisa-bus.c                     |   2 +
 drivers/gpu/drm/drm_memory.c                |   3 +-
 drivers/gpu/drm/gma500/gtt.c                |   5 +-
 drivers/hv/vmbus_drv.c                      |  52 +++---
 drivers/input/joystick/iforce/iforce-main.c |   4 +-
 drivers/nvdimm/namespace_devs.c             |   6 +-
 drivers/nvdimm/nd.h                         |   5 +-
 drivers/of/address.c                        |   4 +-
 drivers/parisc/lba_pci.c                    |   4 +-
 drivers/pci/host/vmd.c                      |   8 +-
 drivers/pci/probe.c                         |   2 +
 drivers/pci/setup-bus.c                     |   2 +-
 include/linux/ioport.h                      |  21 ++-
 kernel/kexec_file.c                         |   2 +
 kernel/resource.c                           | 259 ++++++++++++++++++----------
 20 files changed, 244 insertions(+), 227 deletions(-)

-- 
2.13.6

