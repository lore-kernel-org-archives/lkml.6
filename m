Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeCNPvA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:51:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:42358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbeCNPun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:50:43 -0400
Date: Wed, 14 Mar 2018 16:50:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 02/10] livepatch: Free only structures with
 initialized kobject
Message-ID: <20180314155040.54sqxtkxidihl6sn@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-3-pmladek@suse.com>
 <20180313223858.p32bicvp4ohj5mk6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313223858.p32bicvp4ohj5mk6@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-03-13 17:38:58, Josh Poimboeuf wrote:
> On Wed, Mar 07, 2018 at 09:20:31AM +0100, Petr Mladek wrote:
> > We are going to add a feature called atomic replace. It will allow to
> > create a patch that would replace all already registered patches.
> > For this, we will need to dynamically create funcs and objects
> > for functions that are no longer patched.
> > 
> > We will want to reuse the existing init() and free() functions. Up to now,
> > the free() functions checked a limit and were called only for structures
> > with initialized kobject. But we will want to call them also for structures
> > that were allocated but where the kobject was not initialized yet.
> > 
> > This patch removes the limit. It calls klp_free*() functions for all
> > structures. But only the ones with initialized kobject are freed.
> > The handling of un-initialized structures will be added later with
> > the support for dynamic structures.
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 1d525f4a270a..69bde95e76f8 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -653,17 +653,15 @@ static struct kobj_type klp_ktype_func = {
> >  	.sysfs_ops = &kobj_sysfs_ops,
> >  };
> >  
> > -/*
> > - * Free all functions' kobjects in the array up to some limit. When limit is
> > - * NULL, all kobjects are freed.
> > - */
> > -static void klp_free_funcs_limited(struct klp_object *obj,
> > -				   struct klp_func *limit)
> > +/* Free all funcs that have the kobject initialized. */
> > +static void klp_free_funcs(struct klp_object *obj)
> >  {
> >  	struct klp_func *func;
> >  
> > -	for (func = obj->funcs; func->old_name && func != limit; func++)
> > -		kobject_put(&func->kobj);
> > +	klp_for_each_func(obj, func) {
> > +		if (func->kobj.state_initialized)
> > +			kobject_put(&func->kobj);
> > +	}
> >  }
> 
> Now that this function only has a single caller, personally I think it
> would become more readable if klp_free_funcs() were inlined into its
> caller (klp_free_objects()).  At the very least it should be moved to be
> right above it.

I would keep it as is. The function will get later more complicated by
adding support for dynamically allocated structures.

I still have to think about squashing the patches. I'll reply
on this in the other mail where you opened this question.

Best regards,
Petr

PS: Thank you for review. I took some pills against functionitis and
already applied all changes suggested for the 1st patch.
