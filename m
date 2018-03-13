Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeCMApj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:45:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59946 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbeCMApi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:45:38 -0400
Date: Tue, 13 Mar 2018 00:45:32 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
Message-ID: <20180313004532.GU30522@ZenIV.linux.org.uk>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-5-guro@fb.com>
 <20180312211742.GR30522@ZenIV.linux.org.uk>
 <20180312223632.GA6124@castle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312223632.GA6124@castle>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:36:38PM +0000, Roman Gushchin wrote:

> Ah, I see...
> 
> I think, it's better to account them when we're actually freeing,
> otherwise we will have strange path:
> (indirectly) reclaimable -> unreclaimable -> free
> 
> Do you agree?

> +static void __d_free_external_name(struct rcu_head *head)
> +{
> +	struct external_name *name;
> +
> +	name = container_of(head, struct external_name, u.head);
> +
> +	mod_node_page_state(page_pgdat(virt_to_page(name)),
> +			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
> +			    -ksize(name));
> +
> +	kfree(name);
> +}

Maybe, but then you want to call that from __d_free_external() and from
failure path in __d_alloc() as well.  Duplicating something that convoluted
and easy to get out of sync is just asking for trouble.
