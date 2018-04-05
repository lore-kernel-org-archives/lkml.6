Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeDEWL0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 18:11:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeDEWLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 18:11:25 -0400
Date: Thu, 5 Apr 2018 15:11:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
Message-Id: <20180405151123.df20d12168d8a38f7a6b02b5@linux-foundation.org>
In-Reply-To: <20180313004532.GU30522@ZenIV.linux.org.uk>
References: <20180305133743.12746-1-guro@fb.com>
        <20180305133743.12746-5-guro@fb.com>
        <20180312211742.GR30522@ZenIV.linux.org.uk>
        <20180312223632.GA6124@castle>
        <20180313004532.GU30522@ZenIV.linux.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 00:45:32 +0000 Al Viro <viro@ZenIV.linux.org.uk> wrote:

> On Mon, Mar 12, 2018 at 10:36:38PM +0000, Roman Gushchin wrote:
> 
> > Ah, I see...
> > 
> > I think, it's better to account them when we're actually freeing,
> > otherwise we will have strange path:
> > (indirectly) reclaimable -> unreclaimable -> free
> > 
> > Do you agree?
> 
> > +static void __d_free_external_name(struct rcu_head *head)
> > +{
> > +	struct external_name *name;
> > +
> > +	name = container_of(head, struct external_name, u.head);
> > +
> > +	mod_node_page_state(page_pgdat(virt_to_page(name)),
> > +			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
> > +			    -ksize(name));
> > +
> > +	kfree(name);
> > +}
> 
> Maybe, but then you want to call that from __d_free_external() and from
> failure path in __d_alloc() as well.  Duplicating something that convoluted
> and easy to get out of sync is just asking for trouble.

So.. where are we at with this issue?
