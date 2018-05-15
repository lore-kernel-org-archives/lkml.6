Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeEORtE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:49:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57118 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeEORtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:49:02 -0400
Date: Tue, 15 May 2018 19:48:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
Message-ID: <20180515174837.GL12217@hirez.programming.kicks-ass.net>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526405884-4860-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 01:38:03PM -0400, Waiman Long wrote:
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 30465a2..b7208e1 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -130,7 +130,8 @@ void up_read(struct rw_semaphore *sem)
>  void up_write(struct rw_semaphore *sem)
>  {
>  	rwsem_release(&sem->dep_map, 1, _RET_IP_);
> -	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
> +	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
> +			     !rwsem_has_anonymous_owner(sem->owner));

Why? Don't we always do percpu_rwsem_acquire() before up?

>  
>  	rwsem_clear_owner(sem);
>  	__up_write(sem);
