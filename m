Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeDJLJ0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:09:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:60645 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeDJLJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:09:25 -0400
Date: Tue, 10 Apr 2018 13:09:22 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] livepatch: Remove Nop structures when unused
Message-ID: <20180410110922.vg3fsgnsdfe6wu34@pathway.suse.cz>
References: <20180323120028.31451-1-pmladek@suse.com>
 <20180323120028.31451-7-pmladek@suse.com>
 <alpine.LSU.2.21.1804091632440.20943@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1804091632440.20943@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-04-10 11:14:21, Miroslav Benes wrote:
> On Fri, 23 Mar 2018, Petr Mladek wrote:
> > This patch allows to unpatch and free the dynamic structures independently
> > when the transition finishes.
> > 
> > The free part is a bit tricky because kobject free callbacks are called
> > asynchronously. We could not wait for them easily. Fortunately, we do
> > not have to. Any further access can be avoided by removing them from
> > the dynamic lists.
> > 
> > Finally, the patch become the first on the stack when enabled. The replace
> > functionality will not longer be needed. Let's clear patch->replace to
> > avoid the special handling when it is eventually disabled/enabled again.
> > 
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index d6e6d8176995..1635b30bb1ec 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -172,6 +172,9 @@ struct klp_patch {
> >  #define klp_for_each_object_static(patch, obj) \
> >  	for (obj = patch->objs; obj->funcs || obj->name; obj++)
> >  
> > +#define klp_for_each_object_safe(patch, obj, tmp_obj)		\
> > +	list_for_each_entry_safe(obj, tmp_obj, &patch->obj_list, node)
> > +
> >  #define klp_for_each_object(patch, obj)	\
> >  	list_for_each_entry(obj, &patch->obj_list, node)
> >  
> > @@ -180,6 +183,9 @@ struct klp_patch {
> >  	     func->old_name || func->new_func || func->old_sympos; \
> >  	     func++)
> >  
> > +#define klp_for_each_func_safe(obj, func, tmp_func)			\
> > +	list_for_each_entry_safe(func, tmp_func, &obj->func_list, node)
> > +
> >  #define klp_for_each_func(obj, func)	\
> >  	list_for_each_entry(func, &obj->func_list, node)
> 
> Is there a benefit of the newly added iterators?

You are right that there is nothing special and it is used
on a single place only.

Well, it increases the chance that you will catch it when looking
for the iterators. Also it makes it easier to see the difference
against the non-safe iterators. I'll keep it if you are not
strongly against it.

Best Regards,
Petr
