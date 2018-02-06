Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeBFOfB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752061AbeBFOey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:34:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D546E208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Feb 2018 09:34:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Message-ID: <20180206093451.0de5ceeb@gandalf.local.home>
In-Reply-To: <151791238553.5994.4933976056810745303.stgit@localhost.localdomain>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
        <151791238553.5994.4933976056810745303.stgit@localhost.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Feb 2018 13:19:45 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> /**
> - * kfree_rcu() - kfree an object after a grace period.
> - * @ptr:	pointer to kfree
> + * kvfree_rcu() - kvfree an object after a grace period.
> + * @ptr:	pointer to kvfree
>   * @rcu_head:	the name of the struct rcu_head within the type of @ptr.
>   *

You may want to add a big comment here that states this works for both
free vmalloc and kmalloc data. Because if I saw this, I would think it
only works for vmalloc, and start implementing a custom one for kmalloc
data.

-- Steve


> - * Many rcu callbacks functions just call kfree() on the base structure.
> + * Many rcu callbacks functions just call kvfree() on the base structure.
>   * These functions are trivial, but their size adds up, and furthermore
>   * when they are used in a kernel module, that module must invoke the
>   * high-latency rcu_barrier() function at module-unload time.
>   *
> - * The kfree_rcu() function handles this issue.  Rather than encoding a
> - * function address in the embedded rcu_head structure, kfree_rcu() instead
> + * The kvfree_rcu() function handles this issue.  Rather than encoding a
> + * function address in the embedded rcu_head structure, kvfree_rcu() instead
>   * encodes the offset of the rcu_head structure within the base structure.
>   * Because the functions are not allowed in the low-order 4096 bytes of
>   * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
>   * If the offset is larger than 4095 bytes, a compile-time error will
> - * be generated in __kfree_rcu().  If this error is triggered, you can
> + * be generated in __kvfree_rcu().  If this error is triggered, you can
>   * either fall back to use of call_rcu() or rearrange the structure to
>   * position the rcu_head structure into the first 4096 bytes.
>   *
> @@ -871,9 +871,12 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>   * The BUILD_BUG_ON check must not involve any function calls, hence the
>   * checks are done in macros here.
>   */
> -#define kfree_rcu(ptr, rcu_head)					\
> -	__kfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
> +#define kvfree_rcu(ptr, rcu_head)					\
> +	__kvfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
>  
> +#define kfree_rcu(ptr, rcu_head) kvfree_rcu(ptr, rcu_head)
> +
> +#define vfree_rcu(ptr, rcu_head) kvfree_rcu(ptr, rcu_head)
>  
>  /*
>   * Place this after a lock-acquisition primitive to guarantee that
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index ce9beec35e34..2e484aaa534f 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -84,8 +84,8 @@ static inline void synchronize_sched_expedited(void)
>  	synchronize_sched();
>  }
>  
> -static inline void kfree_call_rcu(struct rcu_head *head,
> -				  rcu_callback_t func)
> +static inline void kvfree_call_rcu(struct rcu_head *head,
> +				   rcu_callback_t func)
>  {
>  	call_rcu(head, func);
>  }
