Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933927AbeCEJy2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:54:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:42041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933903AbeCEJyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:54:20 -0500
Date: Mon, 5 Mar 2018 10:54:16 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] livepatch: Correctly handle atomic replace for
 not yet loaded modules
In-Reply-To: <7f920ec3-dfe0-6a4d-dd25-5d5c4fa75714@redhat.com>
Message-ID: <alpine.LSU.2.21.1803051050330.26605@pobox.suse.cz>
References: <20180221132914.4809-1-pmladek@suse.com> <20180221132914.4809-8-pmladek@suse.com> <alpine.LSU.2.21.1802222145160.21576@pobox.suse.cz> <20180301102859.zwrt6w36ub474nb2@pathway.suse.cz> <7f920ec3-dfe0-6a4d-dd25-5d5c4fa75714@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2018, Joe Lawrence wrote:

> On 03/01/2018 05:28 AM, Petr Mladek wrote:
> > On Thu 2018-02-22 22:00:28, Miroslav Benes wrote:
> >> On Wed, 21 Feb 2018, Petr Mladek wrote:
> >>> This patch allows the late initialization.
> >>>
> >>> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> >>> index ad508a86b2f9..da1438d47d83 100644
> >>> --- a/kernel/livepatch/core.c
> >>> +++ b/kernel/livepatch/core.c
> >>> @@ -984,7 +988,12 @@ static void klp_free_patch(struct klp_patch *patch)
> >>>  
> >>>  static int klp_init_func(struct klp_object *obj, struct klp_func *func)
> >>>  {
> >>> -	if (!func->old_name || !func->new_func)
> >>> +	if (!func->old_name)
> >>> +		return -EINVAL;
> >>> +
> >>> +	/* NOPs do not know the address until the patched module is loaded. */
> >>> +	if (!func->new_func &&
> >>> +	    (!klp_is_func_type(func, KLP_FUNC_NOP) || klp_is_object_loaded(obj)))
> >>>  		return -EINVAL;
> >>
> >> If we changed the order of klp_init_func() and klp_init_object_loaded() 
> >> calls in klp_init_object(), the hunk would not be needed. Is that correct? 
> > 
> > Not really. klp_init_object_loaded() would set func->new_func only
> > when the object was loaded. But we want to proceed here and create
> > the kobject for NOPs even when it was not loaded.
> > 
> > 
> >>>  	INIT_LIST_HEAD(&func->stack_node);
> >>> @@ -1039,6 +1048,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> >>>  			return -ENOENT;
> >>>  		}
> >>>  
> >>> +		if (klp_is_func_type(func, KLP_FUNC_NOP))
> >>> +			func->new_func = (void *)func->old_addr;
> >>
> >> Is there a reason why you left the same assignment in 
> >> klp_alloc_func_nop()? This one is enough, no?
> > 
> > Good point! I am going to replace the obsolete assignment
> > with a comment in v8.
> 
> Hi Petr, Miroslav,
> 
> I don't think the assignment in klp_alloc_func_nop() was necessarily
> redundant.  It was removed in v9 and that breaks my atomic replace
> sample module when I try to load it.  (Perhaps the sample patch has
> issues, but here are my debug notes):
> 
> To recap:
> 
>   patch 1 - modifies cmdline_proc_show()
>   patch 2 - modifies only meminfo_proc_show()
> 
> when I load patch 2 with .replace=1, klp_add_nops() is called and this
> adds a nop function to patch 2 so it reverts cmdline_proc_show():
> 
> klp_init_patch()
>   if (patch->replace)
>     klp_add_nops()
>       list_for_each_entry(old_patch, &klp_patches, list) {
>         klp_for_each_object(old_patch, old_obj) {
>           klp_add_object_nops()
>             klp_add_func_nop()
>               klp_alloc_func_nop()
> 
> the patch continues initialization and I hit the second -EINVAL
> condition on that nop function in klp_init_func():
> 
>   klp_init_object
>     klp_init_func
> 
> (from added debug):
> [   48.456980] livepatch: func->old_name=cmdline_proc_show
> [   48.457620] livepatch: func->new_func=          (null)
> [   48.458042] livepatch: klp_is_func_type(func, KLP_FUNC_NOP)=1
> [   48.458573] livepatch: klp_is_object_loaded(obj)=1
> 
> If I restore the assignment of func->new_func to klp_alloc_func_nop()
> then the replacement patch properly loads.  (Reordering the code may
> have similar effect?)

Ok, so it was not redundant. Or... I think it should be redundant, but we 
need to define the if condition in klp_init_func() properly.
 
> I think this problem is contained to only replacement patches that need
> the nop-revert feature... if the replacement patch provides a new
> function definition, then it shouldn't be affected.
> 
> Man, we need a regression test suite for all these cases :)

Any volunteer?

Miroslav
