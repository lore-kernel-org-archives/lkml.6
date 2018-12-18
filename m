Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF70C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CF7214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLREii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:38:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLREii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 23:38:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CA7386668;
        Tue, 18 Dec 2018 04:38:37 +0000 (UTC)
Received: from redhat.com (ovpn-120-67.rdu2.redhat.com [10.10.120.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC8661001F50;
        Tue, 18 Dec 2018 04:38:35 +0000 (UTC)
Date:   Mon, 17 Dec 2018 23:38:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     gchen.guomin@gmail.com
Cc:     Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, guominchen@tencent.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] Export mm_update_next_owner function for unuse_mm.
Message-ID: <20181217233821-mutt-send-email-mst@kernel.org>
References: <1545104531-30658-1-git-send-email-gchen.guomin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545104531-30658-1-git-send-email-gchen.guomin@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 18 Dec 2018 04:38:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:42:11AM +0800, gchen.guomin@gmail.com wrote:
> From: guomin chen <gchen.guomin@gmail.com>
> 
> When mm->owner is modified by exit_mm, if the new owner directly calls
> unuse_mm to exit, it will cause Use-After-Free. Due to the unuse_mm()
> directly sets tsk->mm=NULL.
> 
>  Under normal circumstances,When do_exit exits, mm->owner will
>  be updated on exit_mm(). but when the kernel process calls
>  unuse_mm() and then exits,mm->owner cannot be updated. And it
>  will point to a task that has been released.
> 
> The current issue flow is as follows:
> Process C              Process A         Process B
> qemu-system-x86_64:     kernel:vhost_net  kernel: vhost_net
> open /dev/vhost-net
>   VHOST_SET_OWNER   create kthread vhost-%d  create kthread vhost-%d
>   network init           use_mm()          use_mm()
>    ...                   ...
>    Abnormal exited
>    ...
>   do_exit
>   exit_mm()
>   update mm->owner to A
>   exit_files()
>    close_files()
>    kthread_should_stop() unuse_mm()
>     Stop Process A       tsk->mm=NULL
>                          do_exit()
>                          can't update owner
>                          A exit completed  vhost-%d  rcv first package
>                                            vhost-%d build rcv buffer for vq
>                                            page fault
>                                            access mm & mm->owner
>                                            NOW,mm->owner still pointer A
>                                            kernel UAF
>     stop Process B
> 
> Although I am having this issue on vhost_net,But it affects all users of
> unuse_mm.
> 
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: guomin chen <gchen.guomin@gmail.com>
> ---
>  kernel/exit.c    | 1 +
>  mm/mmu_context.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 0e21e6d..9e046dd 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -486,6 +486,7 @@ void mm_update_next_owner(struct mm_struct *mm)
>  	task_unlock(c);
>  	put_task_struct(c);
>  }
> +EXPORT_SYMBOL(mm_update_next_owner);
>  #endif /* CONFIG_MEMCG */
>  
>  /*

So why export it? Is that still needed?

> diff --git a/mm/mmu_context.c b/mm/mmu_context.c
> index 3e612ae..9eb81aa 100644
> --- a/mm/mmu_context.c
> +++ b/mm/mmu_context.c
> @@ -60,5 +60,6 @@ void unuse_mm(struct mm_struct *mm)
>  	/* active_mm is still 'mm' */
>  	enter_lazy_tlb(mm, tsk);
>  	task_unlock(tsk);
> +	mm_update_next_owner(mm);
>  }
>  EXPORT_SYMBOL_GPL(unuse_mm);
> -- 
> 1.8.3.1
