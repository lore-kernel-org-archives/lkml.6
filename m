Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967196AbeCAK3E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:29:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:40607 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966146AbeCAK3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:29:01 -0500
Date: Thu, 1 Mar 2018 11:28:59 +0100
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] livepatch: Correctly handle atomic replace for
 not yet loaded modules
Message-ID: <20180301102859.zwrt6w36ub474nb2@pathway.suse.cz>
References: <20180221132914.4809-1-pmladek@suse.com>
 <20180221132914.4809-8-pmladek@suse.com>
 <alpine.LSU.2.21.1802222145160.21576@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1802222145160.21576@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-02-22 22:00:28, Miroslav Benes wrote:
> On Wed, 21 Feb 2018, Petr Mladek wrote:
> > This patch allows the late initialization.
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index ad508a86b2f9..da1438d47d83 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -984,7 +988,12 @@ static void klp_free_patch(struct klp_patch *patch)
> >  
> >  static int klp_init_func(struct klp_object *obj, struct klp_func *func)
> >  {
> > -	if (!func->old_name || !func->new_func)
> > +	if (!func->old_name)
> > +		return -EINVAL;
> > +
> > +	/* NOPs do not know the address until the patched module is loaded. */
> > +	if (!func->new_func &&
> > +	    (!klp_is_func_type(func, KLP_FUNC_NOP) || klp_is_object_loaded(obj)))
> >  		return -EINVAL;
> 
> If we changed the order of klp_init_func() and klp_init_object_loaded() 
> calls in klp_init_object(), the hunk would not be needed. Is that correct? 

Not really. klp_init_object_loaded() would set func->new_func only
when the object was loaded. But we want to proceed here and create
the kobject for NOPs even when it was not loaded.


> >  	INIT_LIST_HEAD(&func->stack_node);
> > @@ -1039,6 +1048,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> >  			return -ENOENT;
> >  		}
> >  
> > +		if (klp_is_func_type(func, KLP_FUNC_NOP))
> > +			func->new_func = (void *)func->old_addr;
> 
> Is there a reason why you left the same assignment in 
> klp_alloc_func_nop()? This one is enough, no?

Good point! I am going to replace the obsolete assignment
with a comment in v8.

Best Regards,
Petr
