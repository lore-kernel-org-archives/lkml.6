Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FB420857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FB420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeIEODb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:03:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:39778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeIEODb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:03:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24991AE98;
        Wed,  5 Sep 2018 09:34:07 +0000 (UTC)
Date:   Wed, 5 Sep 2018 11:34:06 +0200 (CEST)
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
In-Reply-To: <20180828143603.4442-7-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1809051108440.7768@pobox.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com> <20180828143603.4442-7-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Petr Mladek wrote:

> The possibility to re-enable a registered patch was useful for immediate
> patches where the livepatch module had to stay until the system reboot.
> The improved consistency model allows to achieve the same result by
> unloading and loading the livepatch module again.
> 
> Also we are going to add a feature called atomic replace. It will allow
> to create a patch that would replace all already registered patches. The
> aim is to handle dependent patches a more secure way. It will obsolete

"in a more secure way", or "more securely" is maybe even better.

> the stack of patches that helped to handle the dependencies so far.
> Then it might be unclear when a cumulative patch re-enabling is safe.
> 
> It would be complicated to support the many modes. Instead we could
> actually make the API and code easier.

s/easier/simpler/ ?

or "easier to understand" ?
 
> This patch removes the two step public API. All the checks and init calls
> are moved from klp_register_patch() to klp_enabled_patch(). Also the patch
> is automatically freed, including the sysfs interface when the transition
> to the disabled state is completed.
> 
> As a result, there is newer a disabled patch on the top of the stack.

s/newer/never/

> Therefore we do not need to check the stack in __klp_enable_patch().
> And we could simplify the check in __klp_disable_patch().
> 
> Also the API and logic is much easier. It is enough to call
> klp_enable_patch() in module_init() call. The patch patch can be disabled
> by writing '0' into /sys/kernel/livepatch/<patch>/enabled. Then the module
> can be removed once the transition finishes and sysfs interface is freed.

I think it would be good to discuss our sysfs interface here as well.

Writing '1' to enabled attribute now makes sense only when you need to 
reverse an unpatching transition. Writing '0' means "disable" or a 
reversion again.

Wouldn't be better to split it to two different attributes? Something like 
"disable" and "reverse"? It could be more intuitive.

Maybe we'd also find out that even patch->enabled member is not useful 
anymore in such case.

> diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> index 2d7ed09dbd59..7fb01d27d81d 100644
> --- a/Documentation/livepatch/livepatch.txt
> +++ b/Documentation/livepatch/livepatch.txt
> @@ -14,10 +14,8 @@ Table of Contents:

[...]

> -5.2. Enabling
> +5.1. Enabling
>  -------------
>  
> -Registered patches might be enabled either by calling klp_enable_patch() or
> -by writing '1' to /sys/kernel/livepatch/<name>/enabled. The system will
> -start using the new implementation of the patched functions at this stage.
> +Livepatch modules have to call klp_enable_patch() in module_init() callback.
> +This function is rather complex and might even fail in the early phase.
>  
> -When a patch is enabled, livepatch enters into a transition state where
> -tasks are converging to the patched state.  This is indicated by a value
> -of '1' in /sys/kernel/livepatch/<name>/transition.  Once all tasks have
> -been patched, the 'transition' value changes to '0'.  For more
> -information about this process, see the "Consistency model" section.
> +First, the addresses of the patched functions are found according to their
> +names. The special relocations, mentioned in the section "New functions",
> +are applied. The relevant entries are created under
> +/sys/kernel/livepatch/<name>. The patch is rejected when any above
> +operation fails.
>  
> -If an original function is patched for the first time, a function
> -specific struct klp_ops is created and an universal ftrace handler is
> -registered.
> +Third, livepatch enters into a transition state where tasks are converging

s/Third/Second/ ?

[...]

> @@ -655,116 +660,38 @@ static int klp_init_patch(struct klp_patch *patch)
>  	struct klp_object *obj;
>  	int ret;
>  
> -	if (!patch->objs)
> -		return -EINVAL;
> -
> -	mutex_lock(&klp_mutex);
> -
>  	patch->enabled = false;
> -	patch->forced = false;
> +	patch->module_put = false;
>  	INIT_LIST_HEAD(&patch->list);
>  	init_completion(&patch->finish);
>  
> +	if (!patch->objs)
> +		return -EINVAL;
> +
> +	/*
> +	 * A reference is taken on the patch module to prevent it from being
> +	 * unloaded.
> +	 */
> +	if (!try_module_get(patch->mod))
> +		return -ENODEV;
> +	patch->module_put = true;
> +
>  	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
>  				   klp_root_kobj, "%s", patch->mod->name);
>  	if (ret) {
> -		mutex_unlock(&klp_mutex);
>  		return ret;
>  	}

{ } are not necessary after the change.

[...]

>  static int __klp_enable_patch(struct klp_patch *patch)
>  {
>  	struct klp_object *obj;
> @@ -846,17 +740,8 @@ static int __klp_enable_patch(struct klp_patch *patch)
>  	if (WARN_ON(patch->enabled))
>  		return -EINVAL;
>  
> -	/* enforce stacking: only the first disabled patch can be enabled */
> -	if (patch->list.prev != &klp_patches &&
> -	    !list_prev_entry(patch, list)->enabled)
> -		return -EBUSY;
> -
> -	/*
> -	 * A reference is taken on the patch module to prevent it from being
> -	 * unloaded.
> -	 */
> -	if (!try_module_get(patch->mod))
> -		return -ENODEV;
> +	if (!patch->kobj.state_initialized)
> +		return -EINVAL;

I think the check is not needed here. __klp_enable_patch() is called right after
klp_init_patch() in klp_enable_patch().

>  	pr_notice("enabling patch '%s'\n", patch->mod->name);
>  

[...]

> @@ -405,7 +399,11 @@ void klp_try_complete_transition(void)
>  	}
>  
>  	/* we're done, now cleanup the data structures */
> +	patch = klp_transition_patch;
>  	klp_complete_transition();
> +
> +	if (!patch->enabled)
> +		klp_free_patch_nowait(patch);
>  }

I'd welcome a comment here. I thought it was more logical to call
klp_free_patch_nowait() in klp_complete_transition(). It's not possible though.
klp_complete_transition() is also called from klp_cancel_transition() which has
its own freeing in klp_enable_patch()'s error path.
 
Regards,
Miroslav
