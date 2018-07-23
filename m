Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E076EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9300B20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9300B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbeGWPJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:09:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387999AbeGWPJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:09:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79D6481663F1;
        Mon, 23 Jul 2018 14:07:38 +0000 (UTC)
Received: from redhat.com (ovpn-123-242.rdu2.redhat.com [10.10.123.242])
        by smtp.corp.redhat.com (Postfix) with SMTP id 82CB62156892;
        Mon, 23 Jul 2018 14:07:24 +0000 (UTC)
Date:   Mon, 23 Jul 2018 17:07:23 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com, dgilbert@redhat.com
Subject: Re: [PATCH v36 0/5] Virtio-balloon: support free page reporting
Message-ID: <20180723122342-mutt-send-email-mst@kernel.org>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 23 Jul 2018 14:07:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 23 Jul 2018 14:07:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 04:33:00PM +0800, Wei Wang wrote:
> This patch series is separated from the previous "Virtio-balloon
> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,  
> implemented by this series enables the virtio-balloon driver to report
> hints of guest free pages to the host. It can be used to accelerate live
> migration of VMs. Here is an introduction of this usage:
> 
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
>         - Optimization v.s. Legacy = 409ms vs 1757ms --> ~77% reduction
> 	(setting page poisoning zero and enabling ksm don't affect the
>          comparison result)
>     - Guest with Linux Compilation Workload (make bzImage -j4):
>         - Live Migration Time (average)
>           Optimization v.s. Legacy = 1407ms v.s. 2528ms --> ~44% reduction
>         - Linux Compilation Time
>           Optimization v.s. Legacy = 5min4s v.s. 5min12s
>           --> no obvious difference

I'd like to see dgilbert's take on whether this kind of gain
justifies adding a PV interfaces, and what kind of guest workload
is appropriate.

Cc'd.


> ChangeLog:
> v35->v36:
>     - remove the mm patch, as Linus has a suggestion to get free page
>       addresses via allocation, instead of reading from the free page
>       list.
>     - virtio-balloon:
>         - replace oom notifier with shrinker;
>         - the guest to host communication interface remains the same as
>           v32.
> 	- allocate free page blocks and send to host one by one, and free
>           them after sending all the pages.
> 
> For ChangeLogs from v22 to v35, please reference
> https://lwn.net/Articles/759413/
> 
> For ChangeLogs before v21, please reference
> https://lwn.net/Articles/743660/
> 
> Wei Wang (5):
>   virtio-balloon: remove BUG() in init_vqs
>   virtio_balloon: replace oom notifier with shrinker
>   virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>   mm/page_poison: expose page_poisoning_enabled to kernel modules
>   virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
> 
>  drivers/virtio/virtio_balloon.c     | 456 ++++++++++++++++++++++++++++++------
>  include/uapi/linux/virtio_balloon.h |   7 +
>  mm/page_poison.c                    |   6 +
>  3 files changed, 394 insertions(+), 75 deletions(-)
> 
> -- 
> 2.7.4
