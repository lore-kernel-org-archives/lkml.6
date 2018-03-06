Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeCFPcM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:32:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:34579 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFPcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:32:10 -0500
Date: Tue, 6 Mar 2018 16:32:08 +0100
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/8] livepatch: Atomic replace feature
Message-ID: <20180306153208.35cmwo7wcdfwa2hd@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1803051352300.26605@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-03-05 13:54:38, Miroslav Benes wrote:
> On Mon, 5 Mar 2018, Evgenii Shatokhin wrote:
> 
> > Hi,
> 
> Hi,
>  
> > > The atomic replace allows to create cumulative patches. They
> > > are useful when you maintain many livepatches and want to remove
> > > one that is lower on the stack. In addition it is very useful when
> > > more patches touch the same function and there are dependencies
> > > between them.
> > 
> > I have experimented with this updated patchset a bit.
> > It looks like replace operation fails if there is a loaded but disabled patch.
> > 
> > Suppose there are 2 binary patches changing the same kernel functions. Load
> > patch1, then disable it (echo 0 > /sys/kernel/livepatch/patch1/enabled), then
> > try load patch2 with atomic replace. I get "Device or resource busy" error at
> > this point.
> > 
> > It seems, __klp_enable_patch() returns -EBUSY for some reason. I haven't dug
> > deeper into that code yet.
> 
> Yes, it is "enforce stacking" check in __klp_enable_patch():
> 
>         /* enforce stacking: only the first disabled patch can be enabled */
>         if (patch->list.prev != &klp_patches &&
>             !list_prev_entry(patch, list)->enabled)
>                 return -EBUSY;
> 
> So not connected to this patch set. We've had the behaviour for quite some 
> time.

We actually wanted to enabled this for the patches with the replace
flag. It is even described in
Documentation/livepatch/cumulative-patches.txt.

Of course, you could always unregister all the disabled patches that
block the new one. But it might be inconvenient.

I do not see any big reason why this should be disabled:

  + klp_add_nops() takes into account even disabled patches.
    In the worst case, we might enable some NOPs that are
    not really needed.

  + klp_throw_away_replaced_patches() removes all patches down
    the stack.

I am going to enable this in a separate patch in v10.

Best Regards,
Petr
