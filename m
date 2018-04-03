Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbeDCU6Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:58:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753308AbeDCU6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:58:23 -0400
Date: Tue, 3 Apr 2018 13:58:22 -0700
From: Matthew Wilcox <willy@infradead.org>
To: rao.shoaib@oracle.com
Cc: linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        joe@perches.com, brouer@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kfree_rcu() should use kfree_bulk() interface
Message-ID: <20180403205822.GB30145@bombadil.infradead.org>
References: <1522776173-7190-1-git-send-email-rao.shoaib@oracle.com>
 <1522776173-7190-3-git-send-email-rao.shoaib@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522776173-7190-3-git-send-email-rao.shoaib@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 10:22:53AM -0700, rao.shoaib@oracle.com wrote:
> +++ b/mm/slab.h
> @@ -80,6 +80,29 @@ extern const struct kmalloc_info_struct {
>  	unsigned long size;
>  } kmalloc_info[];
>  
> +#define	RCU_MAX_ACCUMULATE_SIZE	25
> +
> +struct rcu_bulk_free_container {
> +	struct	rcu_head rbfc_rcu;
> +	int	rbfc_entries;
> +	void	*rbfc_data[RCU_MAX_ACCUMULATE_SIZE];
> +	struct	rcu_bulk_free *rbfc_rbf;
> +};
> +
> +struct rcu_bulk_free {
> +	struct	rcu_head rbf_rcu; /* used to schedule monitor process */
> +	spinlock_t	rbf_lock;
> +	struct		rcu_bulk_free_container *rbf_container;
> +	struct		rcu_bulk_free_container *rbf_cached_container;
> +	struct		rcu_head *rbf_list_head;
> +	int		rbf_list_size;
> +	int		rbf_cpu;
> +	int		rbf_empty;
> +	int		rbf_polled;
> +	bool		rbf_init;
> +	bool		rbf_monitor;
> +};

I think you might be better off with an IDR.  The IDR can always
contain one entry, so there's no need for this 'rbf_list_head' or
__rcu_bulk_schedule_list.  The IDR contains its first 64 entries in
an array (if that array can be allocated), so it's compatible with the
kfree_bulk() interface.
