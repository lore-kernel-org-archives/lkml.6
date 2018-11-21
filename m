Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7303FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445B42146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445B42146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbeKVBPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:15:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:43844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbeKVBPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:15:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20E83AD9C;
        Wed, 21 Nov 2018 14:41:02 +0000 (UTC)
Date:   Wed, 21 Nov 2018 15:40:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v13 04/12] livepatch: Consolidate klp_free functions
Message-ID: <20181121144059.gv7sbzca55jvztgi@pathway.suse.cz>
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-5-pmladek@suse.com>
 <alpine.LSU.2.21.1811211450280.7578@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1811211450280.7578@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-11-21 14:59:29, Miroslav Benes wrote:
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
> I have not noticed till today, but state_initialized is probably not the 
> best idea. kobject_init_and_add() sets it to 1 in kobject_init() part but 
> then _add() is called which could result in error. So we would end up with 
> state_initialized equal to 1 and kobject reference equal to 0. Later call 
> to kobject_put() in klp_free_funcs() (or elsewhere) would not call 
> ->release method, because refcount would be 0 by then.
> 
> I think that all would end up well, but that does not mean we should not 
> fix it.
> 
> We could use state_in_sysfs, but I do not think it guarantees anything. 
> Both are internal states and maybe we should not rely on them.
> 
> So kref_read() and check the reference?

I have discussed it a bit more with Miroslav in person. It seems that
the best solution is to add our own .initialized flag into
the affected structures.

The thing is that kobject should be used for dynamically allocated
structures. We use them for static structures just to get the sysfs
interface. Let's still use the sysfs functionality but let's
handle the freeing on our own (reduce hijacking kobject
free machinery).

Best Regards,
Petr
