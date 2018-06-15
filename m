Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2A19AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1D1208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1D1208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755748AbeFOFIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:08:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:33113 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755636AbeFOFIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:08:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 22:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="47272173"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2018 22:08:32 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, pbonzini@redhat.com,
        wei.w.wang@intel.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, peterx@redhat.com
Subject: [PATCH v33 0/4] Virtio-balloon: support free page reporting
Date:   Fri, 15 Jun 2018 12:43:09 +0800
Message-Id: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is separated from the previous "Virtio-balloon
Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,  
implemented by this series enables the virtio-balloon driver to report
hints of guest free pages to the host. It can be used to accelerate live
migration of VMs. Here is an introduction of this usage:

Live migration needs to transfer the VM's memory from the source machine
to the destination round by round. For the 1st round, all the VM's memory
is transferred. From the 2nd round, only the pieces of memory that were
written by the guest (after the 1st round) are transferred. One method
that is popularly used by the hypervisor to track which part of memory is
written is to write-protect all the guest memory.

This feature enables the optimization by skipping the transfer of guest
free pages during VM live migration. It is not concerned that the memory
pages are used after they are given to the hypervisor as a hint of the
free pages, because they will be tracked by the hypervisor and transferred
in the subsequent round if they are used and written.

* Tests
- Test Environment
    Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
    Guest: 8G RAM, 4 vCPU
    Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second

- Test Results
    - Idle Guest Live Migration Time (results are averaged over 10 runs):
        - Optimization v.s. Legacy = 278ms vs 1757ms --> ~84% reduction
    - Guest with Linux Compilation Workload (make bzImage -j4):
        - Live Migration Time (average)
          Optimization v.s. Legacy = 1408ms v.s. 2528ms --> ~44% reduction
        - Linux Compilation Time
          Optimization v.s. Legacy = 5min3s v.s. 5min12s
          --> no obvious difference

ChangeLog:
v32->v33:
    - mm/get_from_free_page_list: The new implementation to get free page
      hints based on the suggestions from Linus:
      https://lkml.org/lkml/2018/6/11/764
      This avoids the complex call chain, and looks more prudent.
    - virtio-balloon: 
      - use a fix-sized buffer to get free page hints;
      - remove the cmd id related interface. Now host can just send a free
        page hint command to the guest (via the host_cmd config register)
        to start the reporting. Currentlty the guest reports only the max
        order free page hints to host, which has generated similar good
        results as before. But the interface used by virtio-balloon to
        report can support reporting more orders in the future when there
        is a need.
v31->v32:
    - virtio-balloon:
        - rename cmd_id_use to cmd_id_active;
        - report_free_page_func: detach used buffers after host sends a vq
          interrupt, instead of busy waiting for used buffers.
v30->v31:
    - virtio-balloon:
        - virtio_balloon_send_free_pages: return -EINTR rather than 1 to
          indicate an active stop requested by host; and add more
          comments to explain about access to cmd_id_received without
          locks;
        -  add_one_sg: add TODO to comments about possible improvement.
v29->v30:
    - mm/walk_free_mem_block: add cond_sched() for each order
v28->v29:
    - mm/page_poison: only expose page_poison_enabled(), rather than more
      changes did in v28, as we are not 100% confident about that for now.
    - virtio-balloon: use a separate buffer for the stop cmd, instead of
      having the start and stop cmd use the same buffer. This avoids the
      corner case that the start cmd is overridden by the stop cmd when
      the host has a delay in reading the start cmd.
v27->v28:
    - mm/page_poison: Move PAGE_POISON to page_poison.c and add a function
      to expose page poison val to kernel modules.
v26->v27:
    - add a new patch to expose page_poisoning_enabled to kernel modules
    - virtio-balloon: set poison_val to 0xaaaaaaaa, instead of 0xaa
v25->v26: virtio-balloon changes only
    - remove kicking free page vq since the host now polls the vq after
      initiating the reporting
    - report_free_page_func: detach all the used buffers after sending
      the stop cmd id. This avoids leaving the detaching burden (i.e.
      overhead) to the next cmd id. Detaching here isn't considered
      overhead since the stop cmd id has been sent, and host has already
      moved formard.
v24->v25:
    - mm: change walk_free_mem_block to return 0 (instead of true) on
          completing the report, and return a non-zero value from the
          callabck, which stops the reporting.
    - virtio-balloon:
        - use enum instead of define for VIRTIO_BALLOON_VQ_INFLATE etc.
        - avoid __virtio_clear_bit when bailing out;
        - a new method to avoid reporting the some cmd id to host twice
        - destroy_workqueue can cancel free page work when the feature is
          negotiated;
        - fail probe when the free page vq size is less than 2.
v23->v24:
    - change feature name VIRTIO_BALLOON_F_FREE_PAGE_VQ to
      VIRTIO_BALLOON_F_FREE_PAGE_HINT
    - kick when vq->num_free < half full, instead of "= half full"
    - replace BUG_ON with bailing out
    - check vb->balloon_wq in probe(), if null, bail out
    - add a new feature bit for page poisoning
    - solve the corner case that one cmd id being sent to host twice
v22->v23:
    - change to kick the device when the vq is half-way full;
    - open-code batch_free_page_sg into add_one_sg;
    - change cmd_id from "uint32_t" to "__virtio32";
    - reserver one entry in the vq for the driver to send cmd_id, instead
      of busywaiting for an available entry;
    - add "stop_update" check before queue_work for prudence purpose for
      now, will have a separate patch to discuss this flag check later;
    - init_vqs: change to put some variables on stack to have simpler
      implementation;
    - add destroy_workqueue(vb->balloon_wq);
v21->v22:
    - add_one_sg: some code and comment re-arrangement
    - send_cmd_id: handle a cornercase

For previous ChangeLog, please reference
https://lwn.net/Articles/743660/

Wei Wang (4):
  mm: add a function to get free page blocks
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
  mm/page_poison: expose page_poisoning_enabled to kernel modules
  virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON

 drivers/virtio/virtio_balloon.c     | 197 +++++++++++++++++++++++++++++-------
 include/linux/mm.h                  |   1 +
 include/uapi/linux/virtio_balloon.h |  16 +++
 mm/page_alloc.c                     |  52 ++++++++++
 mm/page_poison.c                    |   6 ++
 5 files changed, 235 insertions(+), 37 deletions(-)

-- 
2.7.4

