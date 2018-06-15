Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E31C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200AF208E5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200AF208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936386AbeFOTV1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:21:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936269AbeFOTV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:21:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88AA740122BD;
        Fri, 15 Jun 2018 19:21:25 +0000 (UTC)
Received: from doriath (ovpn-116-14.phx2.redhat.com [10.3.116.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1F612026609;
        Fri, 15 Jun 2018 19:21:21 +0000 (UTC)
Date:   Fri, 15 Jun 2018 15:21:20 -0400
From:   Luiz Capitulino <lcapitulino@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v33 0/4] Virtio-balloon: support free page reporting
Message-ID: <20180615152120.0c4a47e3@doriath>
In-Reply-To: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 19:21:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 19:21:25 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lcapitulino@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018 12:43:09 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> This patch series is separated from the previous "Virtio-balloon
> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,  
> implemented by this series enables the virtio-balloon driver to report
> hints of guest free pages to the host. It can be used to accelerate live
> migration of VMs. Here is an introduction of this usage:

So, we have two page hinting solutions being proposed. One is this
series, the other one by Nitesh is intended to improve host memory
utilization by letting the host use unused guest memory[1].

Instead of merging two similar solutions, do we want a more generic
one that solves both problems? Or maybe an unified solution?

[1] https://www.spinics.net/lists/kvm/msg170113.html

> Live migration needs to transfer the VM's memory from the source machine
> to the destination round by round. For the 1st round, all the VM's memory
> is transferred. From the 2nd round, only the pieces of memory that were
> written by the guest (after the 1st round) are transferred. One method
> that is popularly used by the hypervisor to track which part of memory is
> written is to write-protect all the guest memory.
> 
> This feature enables the optimization by skipping the transfer of guest
> free pages during VM live migration. It is not concerned that the memory
> pages are used after they are given to the hypervisor as a hint of the
> free pages, because they will be tracked by the hypervisor and transferred
> in the subsequent round if they are used and written.
> 
> * Tests
> - Test Environment
>     Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>     Guest: 8G RAM, 4 vCPU
>     Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
> 
> - Test Results
>     - Idle Guest Live Migration Time (results are averaged over 10 runs):
>         - Optimization v.s. Legacy = 278ms vs 1757ms --> ~84% reduction
>     - Guest with Linux Compilation Workload (make bzImage -j4):
>         - Live Migration Time (average)
>           Optimization v.s. Legacy = 1408ms v.s. 2528ms --> ~44% reduction
>         - Linux Compilation Time
>           Optimization v.s. Legacy = 5min3s v.s. 5min12s
>           --> no obvious difference  
> 
> ChangeLog:
> v32->v33:
>     - mm/get_from_free_page_list: The new implementation to get free page
>       hints based on the suggestions from Linus:
>       https://lkml.org/lkml/2018/6/11/764
>       This avoids the complex call chain, and looks more prudent.
>     - virtio-balloon: 
>       - use a fix-sized buffer to get free page hints;
>       - remove the cmd id related interface. Now host can just send a free
>         page hint command to the guest (via the host_cmd config register)
>         to start the reporting. Currentlty the guest reports only the max
>         order free page hints to host, which has generated similar good
>         results as before. But the interface used by virtio-balloon to
>         report can support reporting more orders in the future when there
>         is a need.
> v31->v32:
>     - virtio-balloon:
>         - rename cmd_id_use to cmd_id_active;
>         - report_free_page_func: detach used buffers after host sends a vq
>           interrupt, instead of busy waiting for used buffers.
> v30->v31:
>     - virtio-balloon:
>         - virtio_balloon_send_free_pages: return -EINTR rather than 1 to
>           indicate an active stop requested by host; and add more
>           comments to explain about access to cmd_id_received without
>           locks;
>         -  add_one_sg: add TODO to comments about possible improvement.
> v29->v30:
>     - mm/walk_free_mem_block: add cond_sched() for each order
> v28->v29:
>     - mm/page_poison: only expose page_poison_enabled(), rather than more
>       changes did in v28, as we are not 100% confident about that for now.
>     - virtio-balloon: use a separate buffer for the stop cmd, instead of
>       having the start and stop cmd use the same buffer. This avoids the
>       corner case that the start cmd is overridden by the stop cmd when
>       the host has a delay in reading the start cmd.
> v27->v28:
>     - mm/page_poison: Move PAGE_POISON to page_poison.c and add a function
>       to expose page poison val to kernel modules.
> v26->v27:
>     - add a new patch to expose page_poisoning_enabled to kernel modules
>     - virtio-balloon: set poison_val to 0xaaaaaaaa, instead of 0xaa
> v25->v26: virtio-balloon changes only
>     - remove kicking free page vq since the host now polls the vq after
>       initiating the reporting
>     - report_free_page_func: detach all the used buffers after sending
>       the stop cmd id. This avoids leaving the detaching burden (i.e.
>       overhead) to the next cmd id. Detaching here isn't considered
>       overhead since the stop cmd id has been sent, and host has already
>       moved formard.
> v24->v25:
>     - mm: change walk_free_mem_block to return 0 (instead of true) on
>           completing the report, and return a non-zero value from the
>           callabck, which stops the reporting.
>     - virtio-balloon:
>         - use enum instead of define for VIRTIO_BALLOON_VQ_INFLATE etc.
>         - avoid __virtio_clear_bit when bailing out;
>         - a new method to avoid reporting the some cmd id to host twice
>         - destroy_workqueue can cancel free page work when the feature is
>           negotiated;
>         - fail probe when the free page vq size is less than 2.
> v23->v24:
>     - change feature name VIRTIO_BALLOON_F_FREE_PAGE_VQ to
>       VIRTIO_BALLOON_F_FREE_PAGE_HINT
>     - kick when vq->num_free < half full, instead of "= half full"
>     - replace BUG_ON with bailing out
>     - check vb->balloon_wq in probe(), if null, bail out
>     - add a new feature bit for page poisoning
>     - solve the corner case that one cmd id being sent to host twice
> v22->v23:
>     - change to kick the device when the vq is half-way full;
>     - open-code batch_free_page_sg into add_one_sg;
>     - change cmd_id from "uint32_t" to "__virtio32";
>     - reserver one entry in the vq for the driver to send cmd_id, instead
>       of busywaiting for an available entry;
>     - add "stop_update" check before queue_work for prudence purpose for
>       now, will have a separate patch to discuss this flag check later;
>     - init_vqs: change to put some variables on stack to have simpler
>       implementation;
>     - add destroy_workqueue(vb->balloon_wq);
> v21->v22:
>     - add_one_sg: some code and comment re-arrangement
>     - send_cmd_id: handle a cornercase
> 
> For previous ChangeLog, please reference
> https://lwn.net/Articles/743660/
> 
> Wei Wang (4):
>   mm: add a function to get free page blocks
>   virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>   mm/page_poison: expose page_poisoning_enabled to kernel modules
>   virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
> 
>  drivers/virtio/virtio_balloon.c     | 197 +++++++++++++++++++++++++++++-------
>  include/linux/mm.h                  |   1 +
>  include/uapi/linux/virtio_balloon.h |  16 +++
>  mm/page_alloc.c                     |  52 ++++++++++
>  mm/page_poison.c                    |   6 ++
>  5 files changed, 235 insertions(+), 37 deletions(-)
> 

