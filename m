Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeBVVAd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:00:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:36747 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbeBVVAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:00:32 -0500
Date: Thu, 22 Feb 2018 22:00:28 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] livepatch: Correctly handle atomic replace for
 not yet loaded modules
In-Reply-To: <20180221132914.4809-8-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802222145160.21576@pobox.suse.cz>
References: <20180221132914.4809-1-pmladek@suse.com> <20180221132914.4809-8-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Petr Mladek wrote:

> The atomic replace feature uses dynamically allocated struct klp_func to
> handle functions that will not longer be patched. These structures are

s/not longer/no longer/, but "handle functions that will not be patched 
any longer" may be even better.

> of the type KLP_FUNC_NOP. They cause the ftrace handler to jump to
> the original code. But the address of the original code is not known
> until the patched module is loaded.
> 
> This patch allows the late initialization. Also it adds a sanity check
> into the ftrace handler.
> 
> Alternative solution would be to do not set the address at all. The ftrace

"Alternative solution would be not to set the address at all." ?

> handler could just return to the original code when NOP struct klp_func
> is used. But this would require another changes. For example, in the stack
> checking. Note that NOP structures might be available even when the patch
> is being disabled. This would happen when the patch enable transition is
> reverted.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/livepatch/core.c  | 16 ++++++++++++++--
>  kernel/livepatch/patch.c |  5 +++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index ad508a86b2f9..da1438d47d83 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -945,8 +945,12 @@ static void klp_free_object_loaded(struct klp_object *obj)
>  
>  	obj->mod = NULL;
>  
> -	klp_for_each_func(obj, func)
> +	klp_for_each_func(obj, func) {
>  		func->old_addr = 0;
> +
> +		if (klp_is_func_type(func, KLP_FUNC_NOP))
> +			func->new_func = NULL;
> +	}
>  }
>  
>  /*
> @@ -984,7 +988,12 @@ static void klp_free_patch(struct klp_patch *patch)
>  
>  static int klp_init_func(struct klp_object *obj, struct klp_func *func)
>  {
> -	if (!func->old_name || !func->new_func)
> +	if (!func->old_name)
> +		return -EINVAL;
> +
> +	/* NOPs do not know the address until the patched module is loaded. */
> +	if (!func->new_func &&
> +	    (!klp_is_func_type(func, KLP_FUNC_NOP) || klp_is_object_loaded(obj)))
>  		return -EINVAL;

If we changed the order of klp_init_func() and klp_init_object_loaded() 
calls in klp_init_object(), the hunk would not be needed. Is that correct? 
But that would require more changes elsewhere, so it's not worth it, I 
think.

>  	INIT_LIST_HEAD(&func->stack_node);
> @@ -1039,6 +1048,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
>  			return -ENOENT;
>  		}
>  
> +		if (klp_is_func_type(func, KLP_FUNC_NOP))
> +			func->new_func = (void *)func->old_addr;

Is there a reason why you left the same assignment in 
klp_alloc_func_nop()? This one is enough, no?

Miroslav
