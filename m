Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeCPMnq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:43:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:45443 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbeCPMno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:43:44 -0400
Date: Fri, 16 Mar 2018 13:43:42 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] seq_file: account everything
Message-ID: <20180316124342.GB11461@dhcp22.suse.cz>
References: <20180310085252.GB17121@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310085252.GB17121@avx2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10-03-18 11:52:52, Alexey Dobriyan wrote:
> All it takes to open a file and read 1 byte from it.
> 
> seq_file will be allocated along with any private allocations,
> and more importantly seq file buffer which is 1 page by default.
 
OOM badness heuristic will not know about this memory when choosing an
oom victim so we might kill a wrong victim which is not all that great
but at least the consumption will be contained within a memcg which
sounds like the sufficient protection for now. This is the case
basically for all kmem charges...

The seq file life time should be bound to a process life time so this is
OK.

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
>  fs/seq_file.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -29,7 +29,7 @@ static void seq_set_overflow(struct seq_file *m)
>  
>  static void *seq_buf_alloc(unsigned long size)
>  {
> -	return kvmalloc(size, GFP_KERNEL);
> +	return kvmalloc(size, GFP_KERNEL_ACCOUNT);
>  }
>  
>  /**
> @@ -566,7 +566,7 @@ static void single_stop(struct seq_file *p, void *v)
>  int single_open(struct file *file, int (*show)(struct seq_file *, void *),
>  		void *data)
>  {
> -	struct seq_operations *op = kmalloc(sizeof(*op), GFP_KERNEL);
> +	struct seq_operations *op = kmalloc(sizeof(*op), GFP_KERNEL_ACCOUNT);
>  	int res = -ENOMEM;
>  
>  	if (op) {
> @@ -628,7 +628,7 @@ void *__seq_open_private(struct file *f, const struct seq_operations *ops,
>  	void *private;
>  	struct seq_file *seq;
>  
> -	private = kzalloc(psize, GFP_KERNEL);
> +	private = kzalloc(psize, GFP_KERNEL_ACCOUNT);
>  	if (private == NULL)
>  		goto out;
>  
> @@ -1112,5 +1112,5 @@ EXPORT_SYMBOL(seq_hlist_next_percpu);
>  
>  void __init seq_file_init(void)
>  {
> -	seq_file_cache = KMEM_CACHE(seq_file, SLAB_PANIC);
> +	seq_file_cache = KMEM_CACHE(seq_file, SLAB_ACCOUNT|SLAB_PANIC);
>  }

-- 
Michal Hocko
SUSE Labs
