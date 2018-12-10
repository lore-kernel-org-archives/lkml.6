Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2172C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0B42081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0B42081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeLJBg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:36:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeLJBg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 20:36:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DE698667D;
        Mon, 10 Dec 2018 01:36:28 +0000 (UTC)
Received: from redhat.com (ovpn-120-192.rdu2.redhat.com [10.10.120.192])
        by smtp.corp.redhat.com (Postfix) with SMTP id 19A325D759;
        Mon, 10 Dec 2018 01:36:27 +0000 (UTC)
Date:   Sun, 9 Dec 2018 20:36:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     gchen.guomin@gmail.com
Cc:     guominchen <guominchen@tencent.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        netdev@vger.kernel.org, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH]  Fix mm->owner point to a task that does not exists
Message-ID: <20181209201309-mutt-send-email-mst@kernel.org>
References: <1544340077-11491-1-git-send-email-gchen.guomin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544340077-11491-1-git-send-email-gchen.guomin@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 10 Dec 2018 01:36:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 03:21:17PM +0800, gchen.guomin@gmail.com wrote:
> From: guominchen <guominchen@tencent.com>
> 
>   Under normal circumstances,When do_exit exits, mm->owner will
>   be updated, but when the kernel process calls unuse_mm and exits,
>   mm->owner cannot be updated. And will point to a task that has
>   been released.
> 
>   Below is my issue on vhost_net:
>     A, B are two kernel processes(such as vhost_worker),
>     C is a user space process(such as qemu), and all
>     three use the mm of the user process C.
>     Now, because user process C exits abnormally, the owner of this
>     mm becomes A. When A calls unuse_mm and exits, this mm->ower
>     still points to the A that has been released.
>     When B accesses this mm->owner again, A has been released.
> 
>   Process A		Process B
>  vhost_worker()	       vhost_worker()
>   ---------    		---------
>   use_mm()		use_mm()
>    ...
>   unuse_mm()
>      tsk->mm=NULL
>    do_exit()     	page fault
>     exit_mm()	 	access mm->owner
>    can't update owner	kernel Oops
> 
> 			unuse_mm()
> 
> Cc: <linux-mm@kvack.org>
> Cc: <linux-kernel@vger.kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: <netdev@vger.kernel.org>
> Signed-off-by: guominchen <guominchen@tencent.com>
> ---
>  mm/mmu_context.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/mmu_context.c b/mm/mmu_context.c
> index 3e612ae..185bb23 100644
> --- a/mm/mmu_context.c
> +++ b/mm/mmu_context.c
> @@ -56,7 +56,6 @@ void unuse_mm(struct mm_struct *mm)
>  
>  	task_lock(tsk);
>  	sync_mm_rss(mm);
> -	tsk->mm = NULL;
>  	/* active_mm is still 'mm' */
>  	enter_lazy_tlb(mm, tsk);
>  	task_unlock(tsk);

So that will work for vhost because we never drop
the mm reference before destroying the task.
I wonder whether that's true for other users though.

It would seem cleaner to onvoke some callback so
tasks such as vhost can drop the reference.

And looking at all this code, I don't understand why
is mm->owner safe to change like this:
        mm->owner = NULL;

when users seem to use it under RCU.



> -- 
> 1.8.3.1
