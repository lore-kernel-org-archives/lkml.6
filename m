Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC35A20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC35A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeGUA7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:59:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44382 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeGUA7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:59:40 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B5024F2A;
        Sat, 21 Jul 2018 00:09:03 +0000 (UTC)
Date:   Fri, 20 Jul 2018 17:09:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-Id: <20180720170902.d1137060c23802d55426aa03@linux-foundation.org>
In-Reply-To: <20180716115058.5559-1-mhocko@kernel.org>
References: <20180716115058.5559-1-mhocko@kernel.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018 13:50:58 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> There are several blockable mmu notifiers which might sleep in
> mmu_notifier_invalidate_range_start and that is a problem for the
> oom_reaper because it needs to guarantee a forward progress so it cannot
> depend on any sleepable locks.
> 
> ...
>
> @@ -571,7 +565,12 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  
>  	trace_start_task_reaping(tsk->pid);
>  
> -	__oom_reap_task_mm(mm);
> +	/* failed to reap part of the address space. Try again later */
> +	if (!__oom_reap_task_mm(mm)) {
> +		up_read(&mm->mmap_sem);
> +		ret = false;
> +		goto unlock_oom;
> +	}

This function is starting to look a bit screwy.

: static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
: {
: 	if (!down_read_trylock(&mm->mmap_sem)) {
: 		trace_skip_task_reaping(tsk->pid);
: 		return false;
: 	}
: 
: 	/*
: 	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
: 	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
: 	 * under mmap_sem for reading because it serializes against the
: 	 * down_write();up_write() cycle in exit_mmap().
: 	 */
: 	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
: 		up_read(&mm->mmap_sem);
: 		trace_skip_task_reaping(tsk->pid);
: 		return true;
: 	}
: 
: 	trace_start_task_reaping(tsk->pid);
: 
: 	/* failed to reap part of the address space. Try again later */
: 	if (!__oom_reap_task_mm(mm)) {
: 		up_read(&mm->mmap_sem);
: 		return true;
: 	}
: 
: 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
: 			task_pid_nr(tsk), tsk->comm,
: 			K(get_mm_counter(mm, MM_ANONPAGES)),
: 			K(get_mm_counter(mm, MM_FILEPAGES)),
: 			K(get_mm_counter(mm, MM_SHMEMPAGES)));
: 	up_read(&mm->mmap_sem);
: 
: 	trace_finish_task_reaping(tsk->pid);
: 	return true;
: }

- Undocumented return value.

- comment "failed to reap part..." is misleading - sounds like it's
  referring to something which happened in the past, is in fact
  referring to something which might happen in the future.

- fails to call trace_finish_task_reaping() in one case

- code duplication.


I'm thinking it wants to be something like this?

: /*
:  * Return true if we successfully acquired (then released) mmap_sem
:  */
: static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
: {
: 	if (!down_read_trylock(&mm->mmap_sem)) {
: 		trace_skip_task_reaping(tsk->pid);
: 		return false;
: 	}
: 
: 	/*
: 	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
: 	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
: 	 * under mmap_sem for reading because it serializes against the
: 	 * down_write();up_write() cycle in exit_mmap().
: 	 */
: 	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
: 		trace_skip_task_reaping(tsk->pid);
: 		goto out;
: 	}
: 
: 	trace_start_task_reaping(tsk->pid);
: 
: 	if (!__oom_reap_task_mm(mm)) {
: 		/* Failed to reap part of the address space. Try again later */
: 		goto finish;
: 	}
: 
: 	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
: 			task_pid_nr(tsk), tsk->comm,
: 			K(get_mm_counter(mm, MM_ANONPAGES)),
: 			K(get_mm_counter(mm, MM_FILEPAGES)),
: 			K(get_mm_counter(mm, MM_SHMEMPAGES)));
: finish:
: 	trace_finish_task_reaping(tsk->pid);
: out:
: 	up_read(&mm->mmap_sem);
: 	return true;
: }

- Increases mmap_sem hold time a little by moving
  trace_finish_task_reaping() inside the locked region.  So sue me ;)

- Sharing the finish: path means that the trace event won't
  distinguish between the two sources of finishing.

Please take a look?
