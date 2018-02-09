Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeBIM3v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:29:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:43587 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbeBIM3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:29:50 -0500
Date: Fri, 9 Feb 2018 13:29:46 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] livepatch: Allow to unpatch only functions of
 the given type
In-Reply-To: <20180206103424.10829-5-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802091326490.30746@pobox.suse.cz>
References: <20180206103424.10829-1-pmladek@suse.com> <20180206103424.10829-5-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +/*
> + * Remove ftrace handler for the given object and function type.

Isn't it imprecise? It does not necessarily remove ftrace handler. It 
removes a function of given ftype from func_stack. I'd remove the 
sentence.

> + *
> + * It keeps obj->patched flag true when any listed function is still patched.
> + * The caller is responsible for removing the unpatched functions to
> + * make the flag clean again.
> + */
> +void klp_unpatch_object(struct klp_object *obj, enum klp_func_type ftype)
>  {
>  	struct klp_func *func;
> +	bool patched = false;
>  
> -	klp_for_each_func(obj, func)
> -		if (func->patched)
> +	klp_for_each_func(obj, func) {
> +		if (!func->patched)
> +			continue;
> +
> +		if (klp_is_func_type(func, ftype))
>  			klp_unpatch_func(func);
> +		else
> +			patched = true;
> +	}
>  
> -	obj->patched = false;
> +	obj->patched = patched;
>  }
>  
>  int klp_patch_object(struct klp_object *obj)
> @@ -258,7 +272,7 @@ int klp_patch_object(struct klp_object *obj)
>  	klp_for_each_func(obj, func) {
>  		ret = klp_patch_func(func);
>  		if (ret) {
> -			klp_unpatch_object(obj);
> +			klp_unpatch_object(obj, KLP_FUNC_ANY);
>  			return ret;
>  		}
>  	}
> @@ -267,11 +281,12 @@ int klp_patch_object(struct klp_object *obj)
>  	return 0;
>  }
>  
> -void klp_unpatch_objects(struct klp_patch *patch)
> +/* Removes ftrace handler in all objects for the given function type. */

Same here.

> +void klp_unpatch_objects(struct klp_patch *patch, enum klp_func_type ftype)
>  {
>  	struct klp_object *obj;
>  
>  	klp_for_each_object(patch, obj)
>  		if (obj->patched)
> -			klp_unpatch_object(obj);
> +			klp_unpatch_object(obj, ftype);
>  }

Miroslav
