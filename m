Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E37C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9EF208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9EF208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJOXrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:47:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbeJOXrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:47:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAC63AFD9;
        Mon, 15 Oct 2018 16:01:44 +0000 (UTC)
Date:   Mon, 15 Oct 2018 18:01:43 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 06/12] livepatch: Simplify API by removing registration
 step
In-Reply-To: <20181012130120.f5berowklyccd7lj@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1810151756290.11383@pobox.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com> <20180828143603.4442-7-pmladek@suse.com> <alpine.LSU.2.21.1809051108440.7768@pobox.suse.cz> <20181012130120.f5berowklyccd7lj@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Petr Mladek wrote:

> On Wed 2018-09-05 11:34:06, Miroslav Benes wrote:
> > On Tue, 28 Aug 2018, Petr Mladek wrote:
> > > Also the API and logic is much easier. It is enough to call
> > > klp_enable_patch() in module_init() call. The patch patch can be disabled
> > > by writing '0' into /sys/kernel/livepatch/<patch>/enabled. Then the module
> > > can be removed once the transition finishes and sysfs interface is freed.
> > 
> > I think it would be good to discuss our sysfs interface here as well.
> > 
> > Writing '1' to enabled attribute now makes sense only when you need to 
> > reverse an unpatching transition. Writing '0' means "disable" or a 
> > reversion again.
> > 
> > Wouldn't be better to split it to two different attributes? Something like 
> > "disable" and "reverse"? It could be more intuitive.
> > 
> > Maybe we'd also find out that even patch->enabled member is not useful 
> > anymore in such case.
> 
> I though about this as well. I kept "enabled" because:
> 
>   + It keeps the public interface the same as before. Most people
>     would not notice any change in the behavior except maybe that
>     the interface disappears when the patch gets disabled.

Well our sysfs interface is still in a testing phase as far as ABI is 
involved. Moreover, each live patch is bound to its base kernel by 
definition anyway. So we can change this without remorse, I think.
 
>   + The reverse operation makes most sense when the transition
>     cannot get finished. In theory, it might be problem to
>     finish even the reversed one. People might want to
>     reverse once again and force it. Then "reverse" file
>     might be confusing. They might not know in which direction
>     they do the reverse.

I still think it would be better to have a less confusing interface and it 
would outweigh the second remark.
 
> > > @@ -846,17 +740,8 @@ static int __klp_enable_patch(struct klp_patch *patch)
> > >  	if (WARN_ON(patch->enabled))
> > >  		return -EINVAL;
> > >  
> > > -	/* enforce stacking: only the first disabled patch can be enabled */
> > > -	if (patch->list.prev != &klp_patches &&
> > > -	    !list_prev_entry(patch, list)->enabled)
> > > -		return -EBUSY;
> > > -
> > > -	/*
> > > -	 * A reference is taken on the patch module to prevent it from being
> > > -	 * unloaded.
> > > -	 */
> > > -	if (!try_module_get(patch->mod))
> > > -		return -ENODEV;
> > > +	if (!patch->kobj.state_initialized)
> > > +		return -EINVAL;
> > 
> > I think the check is not needed here. __klp_enable_patch() is called right after
> > klp_init_patch() in klp_enable_patch().
> 
> I would keep it. Someone might want to call this also from other
> location. Even we used to do it from enable_store() ;-)

Ok, I don't mind in the end.

Miroslav
