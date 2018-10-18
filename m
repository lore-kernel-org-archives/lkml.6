Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BD6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8433B2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8433B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJRUeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:34:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:52716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbeJRUeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:34:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB51FAE30;
        Thu, 18 Oct 2018 12:33:29 +0000 (UTC)
Date:   Thu, 18 Oct 2018 14:33:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 06/12] livepatch: Simplify API by removing
 registration step
Message-ID: <20181018123329.5xvo5hjtqpbih4d2@pathway.suse.cz>
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-7-pmladek@suse.com>
 <20181017190657.dv3kwx467brzhdnz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017190657.dv3kwx467brzhdnz@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-10-17 14:06:57, Josh Poimboeuf wrote:
> On Mon, Oct 15, 2018 at 02:37:07PM +0200, Petr Mladek wrote:
> > @@ -319,96 +316,66 @@ forced it is guaranteed that no task sleeps or runs in the old code.
> >  5. Livepatch life-cycle
> >  =======================
> >  
> > -Livepatching defines four basic operations that define the life cycle of each
> > -live patch: registration, enabling, disabling and unregistration.  There are
> > -several reasons why it is done this way.
> > +Livepatches get automatically enabled when the respective module is loaded.
> 
> (only true if the module enables the patch in its init function)

Great catch! Will fix it.

> > @@ -502,6 +483,9 @@ static void klp_free_objects(struct klp_patch *patch)
> >  }
> >  
> >  /*
> > + * The synchronous variant is needed when the patch is freed in
> > + * the klp_enable_patch() error paths.
> > + *
> 
> Hm?  This comment seems confusingly out of context.

Ah, the comment is just a left over from the previous version. It does
not longer make sense. I'll remove it.


> > @@ -528,6 +512,23 @@ static void klp_free_patch_finish(struct klp_patch *patch)
> >  		kobject_put(&patch->kobj);
> >  		wait_for_completion(&patch->finish);
> >  	}
> > +
> > +	/* Put the module after the last access to struct klp_patch. */
> > +	if (patch->module_put)
> > +		module_put(patch->mod);
> > +}
> > +
> > +/*
> > + * The livepatch might be freed from sysfs interface created by the patch.
> > + * This work allows to wait until the interface is destroyed in a separate
> > + * context.
> > + */
> > +static void klp_free_patch_fn(struct work_struct *work)
> 
> To clarify that it's a work function, how about calling it
> "klp_free_patch_work_fn"?

OK

> >  static int klp_init_func(struct klp_object *obj, struct klp_func *func)
> > @@ -642,116 +643,38 @@ static int klp_init_patch(struct klp_patch *patch)
> >  	struct klp_object *obj;
> >  	int ret;
> >  
> > -	if (!patch->objs)
> > -		return -EINVAL;
> > -
> > -	mutex_lock(&klp_mutex);
> > -
> >  	patch->enabled = false;
> > -	patch->forced = false;
> > +	patch->module_put = false;
> >  	INIT_LIST_HEAD(&patch->list);
> > +	INIT_WORK(&patch->free_work, klp_free_patch_fn);
> >  	init_completion(&patch->finish);
> >  
> > +	if (!patch->objs)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * A reference is taken on the patch module to prevent it from being
> > +	 * unloaded.
> > +	 */
> > +	if (!try_module_get(patch->mod))
> > +		return -ENODEV;
> 
> This comment isn't needed.  It describes what try_module_get() does,
> which is common kernel knowledge.

Yup. I'll remove it. Note that it was there even before. I have just
moved it with the code.


> > +	patch->module_put = true;
> 
> The naming and semantics of the 'module_put' field are a little
> confusing.  It's false in two cases:
> 
> 1) try_module_get() failure
> 2) forced patch
> 
> Maybe we can get rid of the need for the first case by moving the
> try_module_get() call to klp_enable_patch(), before calling
> klp_init_lists().  Then klp_free_patch_finish() will always be called
> with a module reference, so it doesn't have to check the 'module_put'
> field.
> 
> We'd still need it for the force case, but then it can just be called
> 'forced' again.

Great idea! I'll do it in v14.


> > --- a/samples/livepatch/livepatch-callbacks-demo.c
> > +++ b/samples/livepatch/livepatch-callbacks-demo.c
> > @@ -184,22 +184,11 @@ static struct klp_patch patch = {
> >  
> >  static int livepatch_callbacks_demo_init(void)
> >  {
> > -	int ret;
> > -
> > -	ret = klp_register_patch(&patch);
> > -	if (ret)
> > -		return ret;
> > -	ret = klp_enable_patch(&patch);
> > -	if (ret) {
> > -		WARN_ON(klp_unregister_patch(&patch));
> > -		return ret;
> > -	}
> > -	return 0;
> > +	return klp_enable_patch(&patch);
> >  }
> >  
> >  static void livepatch_callbacks_demo_exit(void)
> >  {
> > -	WARN_ON(klp_unregister_patch(&patch));
> >  }
> 
> This module exit function is no longer needed.

I have been there ;-) It is required. Otherewise the module
can't get removed. See the following code in kernel/module.c:

SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
		unsigned int, flags)
{
[...]
	/* If it has an init func, it must have an exit func to unload */
	if (mod->init && !mod->exit) {
		forced = try_force_unload(flags);
		if (!forced) {
			/* This module can't be removed */
			ret = -EBUSY;
			goto out;
		}
	}


Best Regards,
Petr
