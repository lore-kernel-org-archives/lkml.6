Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AFAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813E32098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813E32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeJLTPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:15:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:60472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeJLTPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:15:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 476E1AE17;
        Fri, 12 Oct 2018 11:43:06 +0000 (UTC)
Date:   Fri, 12 Oct 2018 13:43:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 04/12] livepatch: Consolidate klp_free functions
Message-ID: <20181012114305.tj72zxridkyayyq3@pathway.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com>
 <20180828143603.4442-5-pmladek@suse.com>
 <alpine.LSU.2.21.1808311232050.4783@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1808311232050.4783@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-08-31 12:39:23, Miroslav Benes wrote:
> On Tue, 28 Aug 2018, Petr Mladek wrote:
> 
> > The code for freeing livepatch structures is a bit scattered and tricky:
> > 
> >   + direct calls to klp_free_*_limited() and kobject_put() are
> >     used to release partially initialized objects
> > 
> >   + klp_free_patch() removes the patch from the public list
> >     and releases all objects except for patch->kobj
> > 
> >   + object_put(&patch->kobj) and the related wait_for_completion()
> >     are called directly outside klp_mutex; this code is duplicated;
> > 
> > Now, we are going to remove the registration stage to simplify the API
> > and the code. This would require handling more situations in
> > klp_enable_patch() error paths.
> > 
> > More importantly, we are going to add a feature called atomic replace.
> > It will need to dynamically create func and object structures. We will
> > want to reuse the existing init() and free() functions. This would
> > create even more error path scenarios.
> > 
> > This patch implements a more clever free functions:
> > 
> >   + checks kobj.state_initialized instead of @limit
> > 
> >   + initializes patch->list early so that the check for empty list
> >     always works
> > 
> >   + The action(s) that has to be done outside klp_mutex are done
> >     in separate klp_free_patch_end() function. It waits only
> >     when patch->kobj was really released via the _begin() part.
> > 
> > Note that it is safe to put patch->kobj under klp_mutex. It calls
> > the release callback only when the reference count reaches zero.
> > Therefore it does not block any related sysfs operation that took
> > a reference and might eventually wait for klp_mutex.
> 
> This seems to be the reason of the issue which lockdep reported. The patch 
> moved kobject_put(&patch->kobj) under klp_mutex. Perhaps I cannot read 
> kernfs code properly today, but I fail to understand why it is supposed to 
> be safe.

My expectation was that any read/write operation on the related
sysfs interface took reference of the kobject. Then kobject_put()
would just decrement a reference counter and postpone the real
removal until all other operations were finished.

But it seems that the read/write operations take reference on
another (kernfs_node) object and do not block releasing the kobject
by kobject_put().

> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index b3956cce239e..3ca404545150 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -465,17 +465,15 @@ static struct kobj_type klp_ktype_func = {
> >  	.sysfs_ops = &kobj_sysfs_ops,
> >  };
> >  
> > -/*
> > - * Free all functions' kobjects in the array up to some limit. When limit is
> > - * NULL, all kobjects are freed.
> > - */
> > -static void klp_free_funcs_limited(struct klp_object *obj,
> > -				   struct klp_func *limit)
> > +static void klp_free_funcs(struct klp_object *obj)
> >  {
> >  	struct klp_func *func;
> >  
> > -	for (func = obj->funcs; func->old_name && func != limit; func++)
> > -		kobject_put(&func->kobj);
> > +	klp_for_each_func(obj, func) {
> > +		/* Might be called from klp_init_patch() error path. */
> > +		if (func->kobj.state_initialized)
> > +			kobject_put(&func->kobj);
> > +	}
> >  }
> 
> Just for the record, it is a slightly suboptimal because now we iterate 
> through the whole list. We could add break to else branch, I think, but 
> it's not necessary.

Interesting optimization. It would keep the limit and work at this
stage.

But it would stop working once we add the dynamically allocated
structures. They are allocated and initialized in two separate cycles.
We need to free all allocated structures when any initialization
fails.

Best Regards,
Petr
