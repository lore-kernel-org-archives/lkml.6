Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2093BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AE620839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AE620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeHaOqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:46:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:47770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727191AbeHaOqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:46:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9B77AF60;
        Fri, 31 Aug 2018 10:39:24 +0000 (UTC)
Date:   Fri, 31 Aug 2018 12:39:23 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 04/12] livepatch: Consolidate klp_free functions
In-Reply-To: <20180828143603.4442-5-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1808311232050.4783@pobox.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com> <20180828143603.4442-5-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Petr Mladek wrote:

> The code for freeing livepatch structures is a bit scattered and tricky:
> 
>   + direct calls to klp_free_*_limited() and kobject_put() are
>     used to release partially initialized objects
> 
>   + klp_free_patch() removes the patch from the public list
>     and releases all objects except for patch->kobj
> 
>   + object_put(&patch->kobj) and the related wait_for_completion()
>     are called directly outside klp_mutex; this code is duplicated;
> 
> Now, we are going to remove the registration stage to simplify the API
> and the code. This would require handling more situations in
> klp_enable_patch() error paths.
> 
> More importantly, we are going to add a feature called atomic replace.
> It will need to dynamically create func and object structures. We will
> want to reuse the existing init() and free() functions. This would
> create even more error path scenarios.
> 
> This patch implements a more clever free functions:
> 
>   + checks kobj.state_initialized instead of @limit
> 
>   + initializes patch->list early so that the check for empty list
>     always works
> 
>   + The action(s) that has to be done outside klp_mutex are done
>     in separate klp_free_patch_end() function. It waits only
>     when patch->kobj was really released via the _begin() part.
> 
> Note that it is safe to put patch->kobj under klp_mutex. It calls
> the release callback only when the reference count reaches zero.
> Therefore it does not block any related sysfs operation that took
> a reference and might eventually wait for klp_mutex.

This seems to be the reason of the issue which lockdep reported. The patch 
moved kobject_put(&patch->kobj) under klp_mutex. Perhaps I cannot read 
kernfs code properly today, but I fail to understand why it is supposed to 
be safe.

Indeed, if it is safe, lockdep report is false positive.

> Note that __klp_free_patch() is split because it will be later
> used in a _nowait() variant. Also klp_free_patch_end() makes
> sense because it will later get more complicated.

There are no _begin() and _end() functions in the patch.
 
> This patch does not change the existing behavior.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

My Acked-by here is a bit premature.

> ---
>  include/linux/livepatch.h |  2 ++
>  kernel/livepatch/core.c   | 92 +++++++++++++++++++++++++++++------------------
>  2 files changed, 59 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 1163742b27c0..22e0767d64b0 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -138,6 +138,7 @@ struct klp_object {
>   * @list:	list node for global list of registered patches
>   * @kobj:	kobject for sysfs resources
>   * @enabled:	the patch is enabled (but operation may be incomplete)
> + * @wait_free:	wait until the patch is freed
>   * @finish:	for waiting till it is safe to remove the patch module
>   */
>  struct klp_patch {
> @@ -149,6 +150,7 @@ struct klp_patch {
>  	struct list_head list;
>  	struct kobject kobj;
>  	bool enabled;
> +	bool wait_free;
>  	struct completion finish;
>  };
>  
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index b3956cce239e..3ca404545150 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -465,17 +465,15 @@ static struct kobj_type klp_ktype_func = {
>  	.sysfs_ops = &kobj_sysfs_ops,
>  };
>  
> -/*
> - * Free all functions' kobjects in the array up to some limit. When limit is
> - * NULL, all kobjects are freed.
> - */
> -static void klp_free_funcs_limited(struct klp_object *obj,
> -				   struct klp_func *limit)
> +static void klp_free_funcs(struct klp_object *obj)
>  {
>  	struct klp_func *func;
>  
> -	for (func = obj->funcs; func->old_name && func != limit; func++)
> -		kobject_put(&func->kobj);
> +	klp_for_each_func(obj, func) {
> +		/* Might be called from klp_init_patch() error path. */
> +		if (func->kobj.state_initialized)
> +			kobject_put(&func->kobj);
> +	}
>  }

Just for the record, it is a slightly suboptimal because now we iterate 
through the whole list. We could add break to else branch, I think, but 
it's not necessary.
  
>  /* Clean up when a patched object is unloaded */
> @@ -489,26 +487,59 @@ static void klp_free_object_loaded(struct klp_object *obj)
>  		func->old_addr = 0;
>  }
>  
> -/*
> - * Free all objects' kobjects in the array up to some limit. When limit is
> - * NULL, all kobjects are freed.
> - */
> -static void klp_free_objects_limited(struct klp_patch *patch,
> -				     struct klp_object *limit)
> +static void klp_free_objects(struct klp_patch *patch)
>  {
>  	struct klp_object *obj;
>  
> -	for (obj = patch->objs; obj->funcs && obj != limit; obj++) {
> -		klp_free_funcs_limited(obj, NULL);
> -		kobject_put(&obj->kobj);
> +	klp_for_each_object(patch, obj) {
> +		klp_free_funcs(obj);
> +
> +		/* Might be called from klp_init_patch() error path. */
> +		if (obj->kobj.state_initialized)
> +			kobject_put(&obj->kobj);
>  	}
>  }

Same here, of course.

Regards,
Miroslav
