Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeDJMnh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:43:37 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50892 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753150AbeDJMnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:43:31 -0400
Date: Tue, 10 Apr 2018 08:44:59 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Fries <cfries@google.com>
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Message-ID: <20180410124459.GB6334@cmpxchg.org>
References: <20180409015815.235943-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409015815.235943-1-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 10:58:15AM +0900, Minchan Kim wrote:
> @@ -428,6 +428,7 @@ radix_tree_node_alloc(gfp_t gfp_mask, struct radix_tree_node *parent,
>  		ret->exceptional = exceptional;
>  		ret->parent = parent;
>  		ret->root = root;
> +		INIT_LIST_HEAD(&ret->private_list);
>  	}
>  	return ret;
>  }
> @@ -2234,7 +2235,6 @@ radix_tree_node_ctor(void *arg)
>  	struct radix_tree_node *node = arg;
>  
>  	memset(node, 0, sizeof(*node));
> -	INIT_LIST_HEAD(&node->private_list);
>  }

I have to NAK this.

The slab constructor protocol requires objects to be in their initial
allocation state at the time of being freed. If this isn't the case
here, we need to fix whoever isn't doing this, not the alloc site.
