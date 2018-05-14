Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeENJu0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:50:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:34041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752115AbeENJuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:50:24 -0400
Date: Mon, 14 May 2018 11:50:22 +0200
From: Jan Kara <jack@suse.cz>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: DEBUG_RWSEMS warning from thaw_super()
Message-ID: <20180514095022.nfp7vuepz4kfshni@quack2.suse.cz>
References: <CAOQ4uxgxP-0OZzT866=RR5rGQZ89EOy-mFF50v_5Y644OrV7tA@mail.gmail.com>
 <20180513160404.GA19620@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513160404.GA19620@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13-05-18 18:04:04, Oleg Nesterov wrote:
> On 05/13, Amir Goldstein wrote:
> >
> > Since kernel v4.17-rc1 and DEBUG_RWSEMS, I see the
> > warning below after filesystem freeze/thaw.
> >
> > This is a case where one process acquires a bunch of rwsem
> > and another process releases them.
> >
> > To convey this use case to lockdep, freeze_super() calls
> > lockdep_sb_freeze_release() on exit and thaw_super()
> > calls lockdep_sb_freeze_acquire() on entry.
> 
> This was already discussed, but I forgot the result...
> 
> So once again, why we can't simply update percpu_rwsem_acquire() ?
> Or we can check CONFIG_RWSEM_SPIN_ON_OWNER to match percpu_rwsem_release(),
> but CONFIG_DEBUG_RWSEMS explains the purpose better.

Yeah, what you suggests seems reasonable to me. So feel free to add:

Acked-by: Jan Kara <jack@suse.cz>
	
								Honza

> --- x/include/linux/percpu-rwsem.h
> +++ x/include/linux/percpu-rwsem.h
> @@ -141,6 +141,10 @@ static inline void percpu_rwsem_acquire(
>  					bool read, unsigned long ip)
>  {
>  	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
> +#ifdef CONFIG_DEBUG_RWSEMS
> +	if (!read)
> +		sem->rw_sem.owner = current;
> +#endif
>  }
>  
>  #endif
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
