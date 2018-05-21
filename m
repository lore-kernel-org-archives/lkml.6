Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeEUU6U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:58:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751746AbeEUU6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:58:17 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org, tglx@linutronix.de, mingo@kernel.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de, jack@suse.cz,
        darrick.wong@oracle.com, rgoldwyn@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-api@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v5 1/5] block: add ioprio_check_cap function
In-Reply-To: <20180521160147.2372-2-adam.manzanares@wdc.com> (adam
        manzanares's message of "Mon, 21 May 2018 09:01:43 -0700")
References: <20180521160147.2372-1-adam.manzanares@wdc.com>
        <20180521160147.2372-2-adam.manzanares@wdc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Mon, 21 May 2018 16:58:14 -0400
Message-ID: <x49a7ssvi8p.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adam.manzanares@wdc.com writes:

> From: Adam Manzanares <adam.manzanares@wdc.com>
>
> Aio per command iopriority support introduces a second interface between
> userland and the kernel capable of passing iopriority. The aio interface also
> needs the ability to verify that the submitting context has sufficient
> priviledges to submit IOPRIO_RT commands. This patch creates the
> ioprio_check_cap function to be used by the ioprio_set system call and also by
> the aio interface.
>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>


> ---
>  block/ioprio.c         | 22 ++++++++++++++++------
>  include/linux/ioprio.h |  2 ++
>  2 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 6f5d0b6625e3..f9821080c92c 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -61,15 +61,10 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
>  }
>  EXPORT_SYMBOL_GPL(set_task_ioprio);
>  
> -SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
> +int ioprio_check_cap(int ioprio)
>  {
>  	int class = IOPRIO_PRIO_CLASS(ioprio);
>  	int data = IOPRIO_PRIO_DATA(ioprio);
> -	struct task_struct *p, *g;
> -	struct user_struct *user;
> -	struct pid *pgrp;
> -	kuid_t uid;
> -	int ret;
>  
>  	switch (class) {
>  		case IOPRIO_CLASS_RT:
> @@ -92,6 +87,21 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
>  			return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +
> +SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
> +{
> +	struct task_struct *p, *g;
> +	struct user_struct *user;
> +	struct pid *pgrp;
> +	kuid_t uid;
> +	int ret;
> +
> +	ret = ioprio_check_cap(ioprio);
> +	if (ret)
> +		return ret;
> +
>  	ret = -ESRCH;
>  	rcu_read_lock();
>  	switch (which) {
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 627efac73e6d..4a28cec49ec3 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -77,4 +77,6 @@ extern int ioprio_best(unsigned short aprio, unsigned short bprio);
>  
>  extern int set_task_ioprio(struct task_struct *task, int ioprio);
>  
> +extern int ioprio_check_cap(int ioprio);
> +
>  #endif
