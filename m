Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933104AbeCSNLD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:11:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54659 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932989AbeCSNK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:10:59 -0400
Date: Mon, 19 Mar 2018 14:10:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/10] livepatch: Initial support for dynamic
 structures
Message-ID: <20180319131057.wpxiftuiieitdk7d@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-4-pmladek@suse.com>
 <20180313224417.h7akqufvjxuwxp5e@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313224417.h7akqufvjxuwxp5e@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-03-13 17:44:17, Josh Poimboeuf wrote:
> On Wed, Mar 07, 2018 at 09:20:32AM +0100, Petr Mladek wrote:
> > From: Jason Baron <jbaron@akamai.com>
> > 
> > We are going to add a feature called atomic replace. It will allow to
> > create a patch that would replace all already registered patches.
> > For this, we will need to dynamically create funcs and objects
> > for functions that are no longer patched.
> > 
> > This patch adds basic framework to handle such dynamic structures.
> > 
> > It adds enum klp_func_type that allows to distinguish the dynamically
> > allocated funcs' structures. Note that objects' structures do not have
> > a clear type. Namely the static objects' structures might list both static
> > and dynamic funcs' structures.
> > 
> > The function type is then used to limit klp_free() functions. We will
> > want to free the dynamic structures separately when they are no longer
> > needed. At the same time, we also want to make our life easier,
> > and introduce _any_ type that will allow to process all existing
> > structures in one go.
> > 
> > We need to be careful here. First, objects' structures must be freed
> > only when all listed funcs' structures are freed. Also we must avoid
> > double free. Both problems are solved by removing the freed structures
> > from the list.
> > 
> > Also note that klp_free*() functions are called also in klp_init_patch()
> > error path when only some kobjects have been initialized. The other
> > dynamic structures must be freed immediately by calling the respective
> > klp_free_*_dynamic() functions.
> > 
> > Finally, the dynamic objects' structures are generic. The respective
> > klp_allocate_object_dynamic() and klp_free_object_dynamic() can
> > be implemented here. On the other hand, klp_free_func_dynamic()
> > is empty. It must be updated when a particular dynamic
> > klp_func_type is introduced.
> > 
> > Signed-off-by: Jason Baron <jbaron@akamai.com>
> > [pmladek@suse.com: Converted into a generic API]
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Acked-by: Miroslav Benes <mbenes@suse.cz>
> 
> I appreciate the split out patches, but I feel like they're split up
> *too* much.  I found that it was hard to make sense of patches 3-5
> without looking at patch 6.  So I'd suggest combining 3-6 into a single
> patch.

I have squashed the patchset to 5 patches as of this writing. Well,
the main motivation was that it was much easier to do the other
suggested changes this way.

Otherwise I do not have a strong opinion. I think that preparatory
patches are useful if they help to split a huge change into some
logical steps. Everything usually makes much more sense in 2nd
review... ;-)


> Also, since patches 7-8 seem to be bug fixes for patch 6, they should be
> squashed in, so we don't break bisectability unnecessarily.

All the bugs were visible only with patches using the atomic replace.
Therefore they did not affect the bisectability. I guess that they
helped people who reviewed the earlier revisions. Anyway, they will
be squashed in v11.

 
> > ---
> >  include/linux/livepatch.h |  37 +++++++++++-
> >  kernel/livepatch/core.c   | 141 +++++++++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 163 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index e5db2ba7e2a5..7fb76e7d2693 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -35,12 +35,22 @@
> >  #define KLP_UNPATCHED	 0
> >  #define KLP_PATCHED	 1
> >  
> > +/*
> > + * Function type is used to distinguish dynamically allocated structures
> > + * and limit some operations.
> > + */
> > +enum klp_func_type {
> > +	KLP_FUNC_ANY = -1,	/* Substitute any type */
> > +	KLP_FUNC_STATIC = 0,    /* Original statically defined structure */
> > +};
> > +
> >  /**
> >   * struct klp_func - function structure for live patching
> >   * @old_name:	name of the function to be patched
> >   * @new_func:	pointer to the patched function code
> >   * @old_sympos: a hint indicating which symbol position the old function
> >   *		can be found (optional)
> > + * @ftype:	distinguish static and dynamic structures
> 
> The "f" in ftype is redundant because it's already in a klp_func struct.

The type item will be gone in v11.


> Also, I wonder if a 'dynamic' bool would be cleaner / more legible than
> the enum.  Instead of e.g.
> 
>   klp_free_objects(patch, KLP_FUNC_ANY);
>   klp_free_objects(patch, KLP_FUNC_NOP);
> 
> it could be
> 
>   klp_free_objects(patch)
>   klp_free_objects_dynamic(patch);
> 
> with the klp_free_objects*() functions calling a __klp_free_objects()
> helper which takes a bool as an argument.
>
> There would need to be other changes, so I'm not sure it would be
> better, but it could be worth trying out and seeing if it's cleaner.

I gave it a chance. Somewhere it helped, somewhere it made it worse.
The overall result looks better to me, so I will use it in v11.

The main challenge was that I wanted to use "bool nop" in struct klp_func
and "bool dynamic" in struct klp_object. Then I needed to pass a
common flag to handle only these structures to klp_free_objects(),
klp_free_funcs(), klp_unpatch_objects(), klp_unpatch_func().
I solved this by using the inverse logic, for example, by passing
"bool free_all" to the free() functions.


> >   * @old_addr:	the address of the function being patched
> >   * @kobj:	kobject for sysfs resources
> >   * @stack_node:	list node for klp_ops func_stack list
> > @@ -164,17 +175,41 @@ struct klp_patch {
[...]
> > +static inline bool klp_is_func_dynamic(struct klp_func *func)
> > +{
> > +	WARN_ON_ONCE(func->ftype == KLP_FUNC_ANY);
> 
> This seems like a silly warning.  Surely such a condition wouldn't get
> past code review :-)
>
> > +	return func->ftype != KLP_FUNC_STATIC;
> > +}
> 
> I think this would be clearer:
> 
> 	return func->ftype == KLP_FUNC_NOP;
> 
> and perhaps KLP_FUNC_NOP should be renamed to KLP_FUNC_DYNAMIC?
> 
> 	return func->ftype == KLP_FUNC_DYNAMIC;
> 
> (though I realize this patch doesn't have KLP_FUNC_NOP yet)

All these helpers are gone in v11. They are not needed with
the booleans.


> > +
> > +static inline bool klp_is_func_type(struct klp_func *func,
> > +				    enum klp_func_type ftype)
> > +{
> > +	return ftype == KLP_FUNC_ANY || ftype == func->ftype;
> > +}
> > +
> >  int klp_register_patch(struct klp_patch *);
> >  int klp_unregister_patch(struct klp_patch *);
> >  int klp_enable_patch(struct klp_patch *);

I followed also the other suggestions from this mail.


Best Regardsm
Petr
