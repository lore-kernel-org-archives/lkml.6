Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0600AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89C520666
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89C520666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeLDOAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:00:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:45606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbeLDOAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:00:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9DB5ADD6;
        Tue,  4 Dec 2018 14:00:07 +0000 (UTC)
Date:   Tue, 4 Dec 2018 15:00:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 03/11] livepatch: Consolidate klp_free functions
Message-ID: <20181204140007.si7l2glbsgaj2dbf@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-4-pmladek@suse.com>
 <alpine.LSU.2.21.1812031542540.22317@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1812031542540.22317@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-12-03 15:59:57, Miroslav Benes wrote:
> On Thu, 29 Nov 2018, Petr Mladek wrote:
> 
> > -static int klp_init_patch(struct klp_patch *patch)
> > +/* Init operations that must succeed before klp_free_patch() can be called. */
> > +static int klp_init_patch_before_free(struct klp_patch *patch)
> 
> There is no klp_free_patch() now, so the comment is not correct. Also I 
> don't know if the function name is ideal, but I don't have a better one.
> 
> >  {
> >  	struct klp_object *obj;
> > -	int ret;
> > +	struct klp_func *func;
> >  
> >  	if (!patch->objs)
> >  		return -EINVAL;
> >  
> > -	mutex_lock(&klp_mutex);
> > -
> > +	INIT_LIST_HEAD(&patch->list);
> > +	patch->kobj_alive = false;
> >  	patch->enabled = false;
> >  	init_completion(&patch->finish);
> >  
> > -	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
> > -				   klp_root_kobj, "%s", patch->mod->name);
> > +	klp_for_each_object(patch, obj) {
> > +		if (!obj->funcs)
> > +			return -EINVAL;
> > +
> > +		obj->kobj_alive = false;
> > +
> > +		klp_for_each_func(obj, func)
> > +			func->kobj_alive = false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int klp_init_patch(struct klp_patch *patch)
> > +{
> > +	struct klp_object *obj;
> > +	int ret;
> > +
> > +	mutex_lock(&klp_mutex);
> > +
> > +	ret = klp_init_patch_before_free(patch);
> >  	if (ret) {
> >  		mutex_unlock(&klp_mutex);
> >  		return ret;
> >  	}
> >  
> > +	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
> > +				   klp_root_kobj, "%s", patch->mod->name);
> > +	if (ret)
> > +		goto free;
> 
> Is this intentional? It should be sufficient (and it was before the patch) to
> unlock the mutex and return ret. We do not need to free anything here. Only
> klp_patch instance was initialized and that is all.

It will get needed later when try_module_get() is moved into
klp_init_patch_before_free(), see the 5th patch. I'll do it
in the right order in v15.

BTW: I remember that I did this by intention. I updated the patchset
step by step according to the feedback. The init_before_free() was
growing and growing. I did many rebases, shuffling changes between
patches, just wanted to be on the safe side, and maybe save one hunk.
But it seems that no shortcut can slip the careful review ;-)


> Otherwise it looks good. kobj_alive feels safer than state_initialized.

Yup.

Best Regards,
Petr
