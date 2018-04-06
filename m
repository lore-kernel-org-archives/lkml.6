Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeDFWFd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:05:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751488AbeDFWFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:05:32 -0400
Date: Fri, 6 Apr 2018 17:05:30 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] livepatch: Add atomic replace
Message-ID: <20180406220530.snglx7m3quye34wp@treble>
References: <20180323120028.31451-1-pmladek@suse.com>
 <20180323120028.31451-4-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180323120028.31451-4-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 01:00:23PM +0100, Petr Mladek wrote:
> @@ -687,7 +858,14 @@ static void klp_free_patch(struct klp_patch *patch)
>  
>  static int klp_init_func(struct klp_object *obj, struct klp_func *func)
>  {
> -	if (!func->old_name || !func->new_func)
> +	if (!func->old_name)
> +		return -EINVAL;
> +
> +	/*
> +	 * NOPs get the address later. The the patched module must be loaded,

"The the" -> "the"

> +	 * see klp_init_object_loaded().
> +	 */
> +	if (!func->new_func && !func->nop)
>  		return -EINVAL;

>  
>  	INIT_LIST_HEAD(&func->stack_node);
> @@ -742,6 +920,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
>  			return -ENOENT;
>  		}
>  
> +		if (func->nop)
> +			func->new_func = (void *)func->old_addr;
> +

These changes make it more obvious that 'new_func' isn't quite the right
name.  It should really be 'new_addr' IMO.

-- 
Josh
