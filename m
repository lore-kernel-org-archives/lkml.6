Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5173CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE3C2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE3C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeJLTor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:44:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:38762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728145AbeJLToq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:44:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC875AE29;
        Fri, 12 Oct 2018 12:12:34 +0000 (UTC)
Date:   Fri, 12 Oct 2018 14:12:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 07/12] livepatch: Use lists to manage patches,
 objects and functions
Message-ID: <20181012121234.rgaamxlumrgz6ohb@pathway.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com>
 <20180828143603.4442-8-pmladek@suse.com>
 <alpine.LSU.2.21.1809031757220.14361@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1809031757220.14361@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-09-03 18:00:45, Miroslav Benes wrote:
> 
> > -#define klp_for_each_object(patch, obj) \
> > +#define klp_for_each_object_static(patch, obj) \
> >  	for (obj = patch->objs; obj->funcs || obj->name; obj++)
> >  
> > -#define klp_for_each_func(obj, func) \
> > +#define klp_for_each_object(patch, obj)	\
> > +	list_for_each_entry(obj, &patch->obj_list, node)
> > +
> > +#define klp_for_each_func_static(obj, func) \
> >  	for (func = obj->funcs; \
> >  	     func->old_name || func->new_addr || func->old_sympos; \
> >  	     func++)
> >  
> > +#define klp_for_each_func(obj, func)	\
> > +	list_for_each_entry(func, &obj->func_list, node)
> > +
> >  int klp_enable_patch(struct klp_patch *);
> >  
> >  void arch_klp_init_object_loaded(struct klp_patch *patch,
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 6a47b36a6c9a..7bc23a106b5b 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -50,6 +50,21 @@ LIST_HEAD(klp_patches);
> >  
> >  static struct kobject *klp_root_kobj;
> >  
> > +static void klp_init_lists(struct klp_patch *patch)
> > +{
> > +	struct klp_object *obj;
> > +	struct klp_func *func;
> > +
> > +	INIT_LIST_HEAD(&patch->obj_list);
> > +	klp_for_each_object_static(patch, obj) {
> > +		list_add(&obj->node, &patch->obj_list);
> > +
> > +		INIT_LIST_HEAD(&obj->func_list);
> > +		klp_for_each_func_static(obj, func)
> > +			list_add(&func->node, &obj->func_list);
> > +	}
> > +}
> > +
> >  static bool klp_is_module(struct klp_object *obj)
> >  {
> >  	return obj->name;
> > @@ -664,6 +679,7 @@ static int klp_init_patch(struct klp_patch *patch)
> >  	patch->module_put = false;
> >  	INIT_LIST_HEAD(&patch->list);
> >  	init_completion(&patch->finish);
> > +	klp_init_lists(patch);
> 
> This could explode easily if patch->objs is NULL. The check is just below.
>   
> >  	if (!patch->objs)
> >  		return -EINVAL;
> 
> Here.
> 
> klp_init_lists() calls klp_for_each_object_static() which accesses 
> obj->name without a check for obj.

Great catch!

> since the check is already there, could you move klp_init_lists()
> call after the check?

The same problem is with accessing obj->funcs by
klp_for_each_func_static().

I have moved both checks into klp_init_lists(). I made sure that
the lists were initialized to be usable with the free functions
even in case of error.

Best Regards,
Petr
