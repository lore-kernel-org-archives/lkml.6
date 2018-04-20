Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeDTRvA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752778AbeDTRu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:50:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5069420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 13:50:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <songliubraving@fb.com>
Cc: <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>, Howard McLauchlan <hmclauchlan@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 2/2] tracing: remove igrab() iput() call from
 uprobes.c
Message-ID: <20180420135056.31bff483@gandalf.local.home>
In-Reply-To: <20180420165625.129593-2-songliubraving@fb.com>
References: <20180420165625.129593-1-songliubraving@fb.com>
        <20180420165625.129593-2-songliubraving@fb.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 09:56:25 -0700
Song Liu <songliubraving@fb.com> wrote:

> Caller of uprobe_register is required to keep the inode and containing
> mount point referenced.

I would add a little more background to why this is the case. Also a
possible link to the conversation?

Link: http://lkml.kernel.org/r/CAELBmZB2XX=qEOLAdvGG4cPx4GEntcSnWQquJLUK1ongRj35cA@mail.gmail.com

?

-- Steve

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Howard McLauchlan <hmclauchlan@fb.com>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  kernel/events/uprobes.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index ce6848e..20486bb 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -491,7 +491,6 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
>  	if (!uprobe)
>  		return NULL;
>  
> -	uprobe->inode = igrab(inode);
>  	uprobe->offset = offset;
>  	init_rwsem(&uprobe->register_rwsem);
>  	init_rwsem(&uprobe->consumer_rwsem);
> @@ -502,7 +501,6 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
>  	if (cur_uprobe) {
>  		kfree(uprobe);
>  		uprobe = cur_uprobe;
> -		iput(inode);
>  	}
>  
>  	return uprobe;
> @@ -701,7 +699,6 @@ static void delete_uprobe(struct uprobe *uprobe)
>  	rb_erase(&uprobe->rb_node, &uprobes_tree);
>  	spin_unlock(&uprobes_treelock);
>  	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> -	iput(uprobe->inode);
>  	put_uprobe(uprobe);
>  }
>  
> @@ -873,7 +870,8 @@ static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *u
>   * tuple).  Creation refcount stops uprobe_unregister from freeing the
>   * @uprobe even before the register operation is complete. Creation
>   * refcount is released when the last @uc for the @uprobe
> - * unregisters.
> + * unregisters. Caller of uprobe_register() is required to keep @inode
> + * (and the containing mount) referenced.
>   *
>   * Return errno if it cannot successully install probes
>   * else return 0 (success)
