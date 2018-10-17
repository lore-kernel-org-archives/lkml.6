Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E29ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CF921476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CF921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeJRDEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:04:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeJRDEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:04:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D133804E3;
        Wed, 17 Oct 2018 19:07:01 +0000 (UTC)
Received: from treble (ovpn-122-46.rdu2.redhat.com [10.10.122.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3311D8AB40;
        Wed, 17 Oct 2018 19:06:59 +0000 (UTC)
Date:   Wed, 17 Oct 2018 14:06:57 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 06/12] livepatch: Simplify API by removing
 registration step
Message-ID: <20181017190657.dv3kwx467brzhdnz@treble>
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-7-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015123713.25868-7-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 17 Oct 2018 19:07:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:37:07PM +0200, Petr Mladek wrote:
> @@ -319,96 +316,66 @@ forced it is guaranteed that no task sleeps or runs in the old code.
>  5. Livepatch life-cycle
>  =======================
>  
> -Livepatching defines four basic operations that define the life cycle of each
> -live patch: registration, enabling, disabling and unregistration.  There are
> -several reasons why it is done this way.
> +Livepatches get automatically enabled when the respective module is loaded.

(only true if the module enables the patch in its init function)

> @@ -502,6 +483,9 @@ static void klp_free_objects(struct klp_patch *patch)
>  }
>  
>  /*
> + * The synchronous variant is needed when the patch is freed in
> + * the klp_enable_patch() error paths.
> + *

Hm?  This comment seems confusingly out of context.

> @@ -528,6 +512,23 @@ static void klp_free_patch_finish(struct klp_patch *patch)
>  		kobject_put(&patch->kobj);
>  		wait_for_completion(&patch->finish);
>  	}
> +
> +	/* Put the module after the last access to struct klp_patch. */
> +	if (patch->module_put)
> +		module_put(patch->mod);
> +}
> +
> +/*
> + * The livepatch might be freed from sysfs interface created by the patch.
> + * This work allows to wait until the interface is destroyed in a separate
> + * context.
> + */
> +static void klp_free_patch_fn(struct work_struct *work)

To clarify that it's a work function, how about calling it
"klp_free_patch_work_fn"?

>  static int klp_init_func(struct klp_object *obj, struct klp_func *func)
> @@ -642,116 +643,38 @@ static int klp_init_patch(struct klp_patch *patch)
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
> +	INIT_WORK(&patch->free_work, klp_free_patch_fn);
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

This comment isn't needed.  It describes what try_module_get() does,
which is common kernel knowledge.

> +	patch->module_put = true;

The naming and semantics of the 'module_put' field are a little
confusing.  It's false in two cases:

1) try_module_get() failure
2) forced patch

Maybe we can get rid of the need for the first case by moving the
try_module_get() call to klp_enable_patch(), before calling
klp_init_lists().  Then klp_free_patch_finish() will always be called
with a module reference, so it doesn't have to check the 'module_put'
field.

We'd still need it for the force case, but then it can just be called
'forced' again.

> --- a/samples/livepatch/livepatch-callbacks-demo.c
> +++ b/samples/livepatch/livepatch-callbacks-demo.c
> @@ -184,22 +184,11 @@ static struct klp_patch patch = {
>  
>  static int livepatch_callbacks_demo_init(void)
>  {
> -	int ret;
> -
> -	ret = klp_register_patch(&patch);
> -	if (ret)
> -		return ret;
> -	ret = klp_enable_patch(&patch);
> -	if (ret) {
> -		WARN_ON(klp_unregister_patch(&patch));
> -		return ret;
> -	}
> -	return 0;
> +	return klp_enable_patch(&patch);
>  }
>  
>  static void livepatch_callbacks_demo_exit(void)
>  {
> -	WARN_ON(klp_unregister_patch(&patch));
>  }

This module exit function is no longer needed.

>  
>  module_init(livepatch_callbacks_demo_init);
> diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
> index de30d1ba4791..88afb708a48d 100644
> --- a/samples/livepatch/livepatch-sample.c
> +++ b/samples/livepatch/livepatch-sample.c
> @@ -66,22 +66,11 @@ static struct klp_patch patch = {
>  
>  static int livepatch_init(void)
>  {
> -	int ret;
> -
> -	ret = klp_register_patch(&patch);
> -	if (ret)
> -		return ret;
> -	ret = klp_enable_patch(&patch);
> -	if (ret) {
> -		WARN_ON(klp_unregister_patch(&patch));
> -		return ret;
> -	}
> -	return 0;
> +	return klp_enable_patch(&patch);
>  }
>  
>  static void livepatch_exit(void)
>  {
> -	WARN_ON(klp_unregister_patch(&patch));
>  }

Ditto.

-- 
Josh
