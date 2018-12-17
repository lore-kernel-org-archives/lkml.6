Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68156C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3DE206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbeLQP1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:27:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:60458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727738AbeLQP1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:27:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D996ACD3;
        Mon, 17 Dec 2018 15:27:42 +0000 (UTC)
Date:   Mon, 17 Dec 2018 16:27:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 07/11] livepatch: Add atomic replace
Message-ID: <20181217152741.2i2trzjk5rmofgc3@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-8-pmladek@suse.com>
 <20181213225528.ies3kxjjtzl6dmd3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213225528.ies3kxjjtzl6dmd3@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-12-13 16:55:28, Josh Poimboeuf wrote:
> On Thu, Nov 29, 2018 at 10:44:27AM +0100, Petr Mladek wrote:
> > @@ -415,6 +449,124 @@ static struct attribute *klp_patch_attrs[] = {
> >  	NULL
> >  };
> >  
> > +/*
> > + * Dynamically allocated objects and functions.
> > + */
> 
> I don't think this comment is needed.
> 
> > +static void klp_free_object_dynamic(struct klp_object *obj)
> > +{
> > +	kfree(obj->name);
> > +	kfree(obj);
> > +}
> > @@ -456,6 +620,8 @@ static void klp_free_funcs(struct klp_object *obj)
> >  		if (func->kobj_alive) {
> >  			func->kobj_alive = false;
> >  			kobject_put(&func->kobj);
> > +		} else if (func->nop) {
> > +			klp_free_func_nop(func);
> 
> This removes 'func' from the list, so it needs to do a 'safe' list
> iteration.

Good catch!

Well, note that the 'safe' list iterators were added by the very next
patch anyway. This is why I never triggered a problem with this.


> > +void klp_discard_replaced_patches(struct klp_patch *new_patch)
> > +{
> > +	struct klp_patch *old_patch, *tmp_patch;
> > +
> > +	list_for_each_entry_safe(old_patch, tmp_patch, &klp_patches, list) {
> > +		if (old_patch == new_patch)
> > +			return;
> > +
> > +		old_patch->enabled = false;
> > +		klp_unpatch_objects(old_patch);
> > +		klp_free_patch_start(old_patch);
> > +		schedule_work(&old_patch->free_work);
> > +	}
> 
> This doesn't need the "safe" list iteration because it doesn't remove
> the patch from the list.

It does need the 'safe' list. klp_free_patch_start() removes
the patch from the list.


> Side note, it would probably be useful to have a klp_for_each_patch()
> helper.

Will do.

Best Regards,
Petr
