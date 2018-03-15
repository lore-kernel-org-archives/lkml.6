Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeCOTpc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:45:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbeCOTpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:45:30 -0400
Date: Thu, 15 Mar 2018 12:45:27 -0700
From: Matthew Wilcox <willy@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Waiman Long <longman@redhat.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [RFC][PATCH] ipc: Remove IPCMNI
Message-ID: <20180315194527.GB17574@bombadil.infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-5-git-send-email-longman@redhat.com>
 <87woyfyh57.fsf@xmission.com>
 <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com>
 <87o9jru3bf.fsf@xmission.com>
 <935a7c50-50cc-2dc0-33bb-92c000d039bc@redhat.com>
 <87woyego2u.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woyego2u.fsf_-_@xmission.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 07:49:29PM -0500, Eric W. Biederman wrote:
> @@ -109,20 +109,13 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
>  {
>  	struct kern_ipc_perm *perm;
>  	int next_id;
> -	int total, in_use;
>  
>  	down_write(&ids->rwsem);
> -
> -	in_use = ids->in_use;
> -
> -	for (total = 0, next_id = 0; total < in_use; next_id++) {
> -		perm = idr_find(&ids->ipcs_idr, next_id);
> -		if (perm == NULL)
> -			continue;
> +	next_id = 0;
> +	while ((perm = idr_get_next(&ids->ipcs_idr, &next_id))) {
>  		rcu_read_lock();
>  		ipc_lock_object(perm);
>  		free(ns, perm);
> -		total++;
>  	}
>  	up_write(&ids->rwsem);
>  }

We have a helper for this:

	idr_for_each_entry(&ids->ipcs_idr, perm, next_id) {
		rcu_read_lock();
		ipc_lock_object(perm);
		free(ns, perm);
	}

(using idr_get_next() is tricky because you have to remember to increment
next_id yourself, and you didn't).

> +static int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>  {
> +#ifdef CONFIG_CHECKPOINT_RESTORE
> +	if (ids->next_id >= 0) {
> +		idr_set_cursor(&ids->ipcs_idr, ids->next_id);
>  		ids->next_id = -1;
>  	}
> +#endif
> +	return idr_alloc_cyclic(&ids->ipcs_idr, (new), 0, 0, GFP_NOWAIT);
>  }
>  
> -#endif /* CONFIG_CHECKPOINT_RESTORE */

That seems a little convoluted; is there a reason to not call idr_set_cursor()
instead of assigning to ids->next_id?

> @@ -757,30 +725,20 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>  					      loff_t *new_pos)
>  {
>  	struct kern_ipc_perm *ipc;
> +	int id;
>  
> +	/* Out of range - return NULL to terminate iteration */
> +	if (pos > INT_MAX)
>  		return NULL;
>  
> +	ipc = idr_get_next(&ids->ipcs_idr, &id);
> +	if (!ipc)
> +		return NULL;
>  
> +	*new_pos = id + 1;
> +	rcu_read_lock();
> +	ipc_lock_object(ipc);
> +	return ipc;
>  }

I'm no expert on the IPC locking, but I would have thought you'd want to
call rcu_read_lock() before calling idr_get_next() to avoid a simultaneous
delete from freeing 'ipc'.

Oh, I see.  proc_start takes the rwsem for read and proc_stop releases it.
The locking here seems quite shabby and in need of renovation.
