Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeCMOzk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:55:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:33164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751720AbeCMOzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:55:38 -0400
Date: Tue, 13 Mar 2018 15:55:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 07/10] livepatch: Correctly handle atomic replace for
 not yet loaded modules
Message-ID: <20180313145536.t55ogbwumaub7nqu@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307082039.10196-8-pmladek@suse.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-03-07 09:20:36, Petr Mladek wrote:
> The atomic replace feature uses dynamically allocated struct klp_func to
> handle functions that will no longer be patched. These structures are
> of the type KLP_FUNC_NOP. They cause the ftrace handler to jump to
> the original code. But the address of the original code is not known
> until the patched module is loaded.
> 
> This patch allows the late initialization. Also it adds a sanity check
> into the ftrace handler.
> 
> diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> index 54b3c379bb0f..1f5c3eea9ee1 100644
> --- a/kernel/livepatch/patch.c
> +++ b/kernel/livepatch/patch.c
> @@ -118,7 +118,12 @@ static void notrace klp_ftrace_handler(unsigned long ip,
>  		}
>  	}
>  
> +	/* Survive ugly mistakes, for example, when handling NOPs. */
> +	if (WARN_ON_ONCE(!func->new_func))
> +		goto unlock;

JFYI, this is not enough. We really have to skip klp_arch_set_pc()
for NOPs. Otherwise, we end up in an infinite loop. NOPs cause that
we go back to the beginning of the original function, enter
the ftrace handler again, ...

I am going to fix this in v11.

> +
>  	klp_arch_set_pc(regs, (unsigned long)func->new_func);
> +
>  unlock:
>  	preempt_enable_notrace();

Kudos to Mirek for testing and hitting the problem.

Best Regards,
Petr
