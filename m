Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86579ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404AF205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404AF205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJYJ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:29:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeJYJ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:29:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D795874F0B;
        Thu, 25 Oct 2018 00:59:00 +0000 (UTC)
Received: from redhat.com (ovpn-120-69.rdu2.redhat.com [10.10.120.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 535AF19748;
        Thu, 25 Oct 2018 00:58:53 +0000 (UTC)
Date:   Wed, 24 Oct 2018 20:58:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dgilbert@redhat.com, torvalds@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, peterx@redhat.com, quintela@redhat.com
Subject: Re: [PATCH v37 0/3] Virtio-balloon: support free page reporting
Message-ID: <20181024205759-mutt-send-email-mst@kernel.org>
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 25 Oct 2018 00:59:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:32:16AM +0800, Wei Wang wrote:
> The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT, implemented by this
> series enables the virtio-balloon driver to report hints of guest free
> pages to host. It can be used to accelerate virtual machine (VM) live
> migration. Here is an introduction of this usage:
> 
> Live migration needs to transfer the VM's memory from the source machine
> to the destination round by round. For the 1st round, all the VM's memory
> is transferred. From the 2nd round, only the pieces of memory that were
> written by the guest (after the 1st round) are transferred. One method
> that is popularly used by the hypervisor to track which part of memory is
> written is to have the hypervisor write-protect all the guest memory.
> 
> This feature enables the optimization by skipping the transfer of guest
> free pages during VM live migration. It is not concerned that the memory
> pages are used after they are given to the hypervisor as a hint of the
> free pages, because they will be tracked by the hypervisor and transferred
> in the subsequent round if they are used and written.

OK so it will be in linux-next.  Now can I trouble you for a virtio spec
patch with the description please?


> * Tests
> 1 Test Environment
>     Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>     Migration setup: migrate_set_speed 100G, migrate_set_downtime 400ms
> 
> 2 Test Results (results are averaged over several repeated runs)
>     2.1 Guest setup: 8G RAM, 4 vCPU
>         2.1.1 Idle guest live migration time
>             Optimization v.s. Legacy = 620ms vs 2970ms
>             --> ~79% reduction
>         2.1.2 Guest live migration with Linux compilation workload
>           (i.e. make bzImage -j4) running
>           1) Live Migration Time:
>              Optimization v.s. Legacy = 2273ms v.s. 4502ms
>              --> ~50% reduction
>           2) Linux Compilation Time:
>              Optimization v.s. Legacy = 8min42s v.s. 8min43s
>              --> no obvious difference
> 
>     2.2 Guest setup: 128G RAM, 4 vCPU
>         2.2.1 Idle guest live migration time
>             Optimization v.s. Legacy = 5294ms vs 41651ms
>             --> ~87% reduction
>         2.2.2 Guest live migration with Linux compilation workload
>           1) Live Migration Time:
>             Optimization v.s. Legacy = 8816ms v.s. 54201ms
>             --> 84% reduction
>           2) Linux Compilation Time:
>              Optimization v.s. Legacy = 8min30s v.s. 8min36s
>              --> no obvious difference
> 
> ChangeLog:
> v36->v37:
>     - free the reported pages to mm when receives a DONE cmd from host.
>       Please see patch 1's commit log for reasons. Please see patch 1's
>       commit for detailed explanations.
> 
> For ChangeLogs from v22 to v36, please reference
> https://lkml.org/lkml/2018/7/20/199
> 
> For ChangeLogs before v21, please reference
> https://lwn.net/Articles/743660/
> 
> Wei Wang (3):
>   virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>   mm/page_poison: expose page_poisoning_enabled to kernel modules
>   virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
> 
>  drivers/virtio/virtio_balloon.c     | 374 ++++++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_balloon.h |   8 +
>  mm/page_poison.c                    |   6 +
>  3 files changed, 355 insertions(+), 33 deletions(-)
> 
> -- 
> 2.7.4
