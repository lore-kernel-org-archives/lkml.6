Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeDJJOY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:14:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:48456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752426AbeDJJOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:14:23 -0400
Date: Tue, 10 Apr 2018 11:14:21 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] livepatch: Remove Nop structures when unused
In-Reply-To: <20180323120028.31451-7-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1804091632440.20943@pobox.suse.cz>
References: <20180323120028.31451-1-pmladek@suse.com> <20180323120028.31451-7-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Petr Mladek wrote:

> Replaced patches are removed from the stack when the transition is
> finished. It means that Nop structures will never be needed again
> and can be removed. Why should we care?
> 
>   + Nop structures make false feeling that the function is patched
>     even though the ftrace handler has no effect.
> 
>   + Ftrace handlers are not completely for free. They cause slowdown that
>     might be visible in some workloads. The ftrace-related slowdown might
>     actually be the reason why the function is not longer patched in
>     the new cumulative patch. One would expect that cumulative patch
>     would allow to solve these problems as well.
> 
>   + Cumulative patches are supposed to replace any earlier version of
>     the patch. The amount of NOPs depends on which version was replaced.
>     This multiplies the amount of scenarios that might happen.
> 
>     One might say that NOPs are innocent. But there are even optimized
>     NOP instructions for different processor, for example, see
>     arch/x86/kernel/alternative.c. And klp_ftrace_handler() is much
>     more complicated.
> 
>   + It sounds natural to clean up a mess that is not longer needed.
>     It could only be worse if we do not do it.
> 
> This patch allows to unpatch and free the dynamic structures independently
> when the transition finishes.
> 
> The free part is a bit tricky because kobject free callbacks are called
> asynchronously. We could not wait for them easily. Fortunately, we do
> not have to. Any further access can be avoided by removing them from
> the dynamic lists.
> 
> Finally, the patch become the first on the stack when enabled. The replace
> functionality will not longer be needed. Let's clear patch->replace to
> avoid the special handling when it is eventually disabled/enabled again.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/livepatch.h     |  6 ++++++
>  kernel/livepatch/core.c       | 42 +++++++++++++++++++++++++++++++++++-------
>  kernel/livepatch/core.h       |  1 +
>  kernel/livepatch/patch.c      | 31 ++++++++++++++++++++++++++-----
>  kernel/livepatch/patch.h      |  1 +
>  kernel/livepatch/transition.c | 26 +++++++++++++++++++++++++-
>  6 files changed, 94 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index d6e6d8176995..1635b30bb1ec 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -172,6 +172,9 @@ struct klp_patch {
>  #define klp_for_each_object_static(patch, obj) \
>  	for (obj = patch->objs; obj->funcs || obj->name; obj++)
>  
> +#define klp_for_each_object_safe(patch, obj, tmp_obj)		\
> +	list_for_each_entry_safe(obj, tmp_obj, &patch->obj_list, node)
> +
>  #define klp_for_each_object(patch, obj)	\
>  	list_for_each_entry(obj, &patch->obj_list, node)
>  
> @@ -180,6 +183,9 @@ struct klp_patch {
>  	     func->old_name || func->new_func || func->old_sympos; \
>  	     func++)
>  
> +#define klp_for_each_func_safe(obj, func, tmp_func)			\
> +	list_for_each_entry_safe(func, tmp_func, &obj->func_list, node)
> +
>  #define klp_for_each_func(obj, func)	\
>  	list_for_each_entry(func, &obj->func_list, node)

Is there a benefit of the newly added iterators?

Miroslav
