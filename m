Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27096C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3FD20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3FD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeLDMzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:55:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:33966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbeLDMzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:55:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48588AFC0;
        Tue,  4 Dec 2018 12:54:56 +0000 (UTC)
Date:   Tue, 4 Dec 2018 13:54:55 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing registration
 step
In-Reply-To: <20181129094431.7801-6-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1812031643120.22317@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <20181129094431.7801-6-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mainly nits below. Overall it looks good.

> The possibility to re-enable a registered patch was useful for immediate
> patches where the livepatch module had to stay until the system reboot.
> The improved consistency model allows to achieve the same result by
> unloading and loading the livepatch module again.
> 
> Also we are going to add a feature called atomic replace. It will allow
> to create a patch that would replace all already registered patches.
> The aim is to handle dependent patches more securely. It will obsolete
> the stack of patches that helped to handle the dependencies so far.
> Then it might be unclear when a cumulative patch re-enabling is safe.
> 
> It would be complicated to support the many modes. Instead we could
> actually make the API and code easier to understand.
> 
> This patch removes the two step public API. All the checks and init calls

I know there are two different meanings of patch used in the changelog and 
you need to distinguish between them. "This patch" however does not look 
good. Could you change the sentence (and probably fix the changelog then a 
bit) to imperative mood? It sounds better anyway. Something like 
"Therefore, remove the two step public API" for example.

> are moved from klp_register_patch() to klp_enabled_patch(). Also the patch
> is automatically freed, including the sysfs interface when the transition
> to the disabled state is completed.
> 
> As a result, there is never a disabled patch on the top of the stack.
> Therefore we do not need to check the stack in __klp_enable_patch().
> And we could simplify the check in __klp_disable_patch().
> 
> Also the API and logic is much easier. It is enough to call
> klp_enable_patch() in module_init() call. The patch patch can be disabled

s/The patch patch/patch/

> by writing '0' into /sys/kernel/livepatch/<patch>/enabled. Then the module
> can be removed once the transition finishes and sysfs interface is freed.
> 
> The only problem is how to free the structures and kobjects a safe way.

s/a safe way/safely/

> The operation is triggered from the sysfs interface. We could not put
> the related kobject from there because it would cause lock inversion
> between klp_mutex and kernfs locks, see kn->count lockdep map.
> 
> This patch solved the problem by offloading the free task to

"This patch" again.

> a workqueue. It is perfectly fine:
> 
>   + The patch cannot not longer be used in the livepatch operations.

s/cannot not longer/can no longer/

>   + The module could not be removed until the free operation finishes
>     and module_put() is called.
> 
>   + The operation is asynchronous already when the first
>     klp_try_complete_transition() fails and another call
>     is queued with a delay.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  Documentation/livepatch/livepatch.txt        | 137 ++++++-------
>  include/linux/livepatch.h                    |   5 +-
>  kernel/livepatch/core.c                      | 275 +++++++++------------------
>  kernel/livepatch/core.h                      |   2 +
>  kernel/livepatch/transition.c                |  19 +-
>  samples/livepatch/livepatch-callbacks-demo.c |  13 +-
>  samples/livepatch/livepatch-sample.c         |  13 +-
>  samples/livepatch/livepatch-shadow-fix1.c    |  14 +-
>  samples/livepatch/livepatch-shadow-fix2.c    |  14 +-
>  9 files changed, 166 insertions(+), 326 deletions(-)
> 
> diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> index 2d7ed09dbd59..d849af312576 100644
> --- a/Documentation/livepatch/livepatch.txt
> +++ b/Documentation/livepatch/livepatch.txt
> @@ -12,12 +12,11 @@ Table of Contents:
>  4. Livepatch module
>     4.1. New functions
>     4.2. Metadata
> -   4.3. Livepatch module handling
>  5. Livepatch life-cycle
> -   5.1. Registration
> +   5.1. Loading
>     5.2. Enabling
>     5.3. Disabling
> -   5.4. Unregistration
> +   5.4. Removing
>  6. Sysfs
>  7. Limitations
>  
> @@ -298,117 +297,91 @@ into three levels:
>      see the "Consistency model" section.
>  
>  
> -4.3. Livepatch module handling
> -------------------------------
> -
> -The usual behavior is that the new functions will get used when
> -the livepatch module is loaded. For this, the module init() function
> -has to register the patch (struct klp_patch) and enable it. See the
> -section "Livepatch life-cycle" below for more details about these
> -two operations.
> -
> -Module removal is only safe when there are no users of the underlying
> -functions. This is the reason why the force feature permanently disables
> -the removal. The forced tasks entered the functions but we cannot say
> -that they returned back.  Therefore it cannot be decided when the
> -livepatch module can be safely removed. When the system is successfully
> -transitioned to a new patch state (patched/unpatched) without being
> -forced it is guaranteed that no task sleeps or runs in the old code.

Is the change necessary? The documentation in v13 looked ok and I am not 
sure if it is better now. Only my opinion though and I understand why you 
changed it.

>  5. Livepatch life-cycle
>  =======================
>  
> -Livepatching defines four basic operations that define the life cycle of each
> -live patch: registration, enabling, disabling and unregistration.  There are
> -several reasons why it is done this way.
> -
> -First, the patch is applied only when all patched symbols for already
> -loaded objects are found. The error handling is much easier if this
> -check is done before particular functions get redirected.
> +Livepatching can be described by four basic operations:
> +loading, enabling, disabling, removing.
>  
> -Second, it might take some time until the entire system is migrated with
> -the hybrid consistency model being used. The patch revert might block
> -the livepatch module removal for too long. Therefore it is useful to
> -revert the patch using a separate operation that might be called
> -explicitly. But it does not make sense to remove all information until
> -the livepatch module is really removed.
>  
> +5.1. Loading
> +------------
>  
> -5.1. Registration
> ------------------
> +The only reasonable way is to enable the patch when the livepatch kernel
> +module is being loaded. For this, klp_enable_patch() has to be called
> +in module_init() callback. There are two main reasons:
>  
> -Each patch first has to be registered using klp_register_patch(). This makes
> -the patch known to the livepatch framework. Also it does some preliminary
> -computing and checks.
> +First, only the module has an easy access to the related struct klp_patch.
>  
> -In particular, the patch is added into the list of known patches. The
> -addresses of the patched functions are found according to their names.
> -The special relocations, mentioned in the section "New functions", are
> -applied. The relevant entries are created under
> -/sys/kernel/livepatch/<name>. The patch is rejected when any operation
> -fails.
> +Second, the error code might be used to refuse loading the module when
> +the patch cannot get enabled.
>  
>  
>  5.2. Enabling
>  -------------
>  
> -Registered patches might be enabled either by calling klp_enable_patch() or
> -by writing '1' to /sys/kernel/livepatch/<name>/enabled. The system will
> -start using the new implementation of the patched functions at this stage.
> +The livepatch gets enabled by calling klp_enable_patch() typically from
> +module_init() callback. The system will start using the new implementation
> +of the patched functions at this stage.

5.1 is now saying that klp_enable_patch() has to be called in 
module_init() callback and we should be consistent.

> @@ -309,40 +297,33 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  	mutex_lock(&klp_mutex);
>  
> -	if (!klp_is_patch_registered(patch)) {
> -		/*
> -		 * Module with the patch could either disappear meanwhile or is
> -		 * not properly initialized yet.
> -		 */
> -		ret = -EINVAL;
> -		goto err;
> -	}
> -
>  	if (patch->enabled == enabled) {
>  		/* already in requested state */
>  		ret = -EINVAL;
> -		goto err;
> +		goto out;
>  	}
>  
> -	if (patch == klp_transition_patch) {
> +	/*
> +	 * Allow to reverse a pending transition in both ways. It might be
> +	 * necessary to complete the transition without forcing and breaking
> +	 * the system integrity.
> +	 *
> +	 * Do not allow to re-enable a disabled patch because this interface
> +	 * is being destroyed.

A nit, but I think the second part is not necessary and may be confusing.

"Do not allow to re-enable a disabled patch." should be sufficient.

Regards,
Miroslav
