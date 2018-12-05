Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BBCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E06F214DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E06F214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeLEUYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:24:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeLEUYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:24:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 369193082A34;
        Wed,  5 Dec 2018 20:24:17 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 392485D756;
        Wed,  5 Dec 2018 20:24:15 +0000 (UTC)
Date:   Wed, 5 Dec 2018 15:24:14 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 10/11] livepatch: Remove ordering and refuse loading
 conflicting patches
Message-ID: <20181205202414.ba3an6q24cj6hxmf@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-11-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-11-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 05 Dec 2018 20:24:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:30AM +0100, Petr Mladek wrote:
> The atomic replace and cumulative patches were introduced as a more secure
> way to handle dependent patches. They simplify the logic:
> 
>   + Any new cumulative patch is supposed to take over shadow variables
>     and changes made by callbacks from previous livepatches.
> 
>   + All replaced patches are discarded and the modules can be unloaded.
>     As a result, there is only one scenario when a cumulative livepatch
>     gets disabled.
> 
> The different handling of "normal" and cumulative patches might cause
> confusion. It would make sense to keep only one mode. On the other hand,
> it would be rude to enforce using the cumulative livepatches even for
> trivial and independent (hot) fixes.
> 
> This patch removes the stack of patches. The list of enabled patches
> is still needed but the ordering is not longer enforced.
                                      ^^^^^^^^^^
s/not longer/no longer

> 
> Note that it is not possible to catch all possible dependencies. It is
> the responsibility of the livepatch authors to decide.
> 
> Nevertheless this patch prevents having two patches for the same function
> enabled at the same time after the transition finishes. It might help
> to catch obvious mistakes. But more importantly, we do not need to
> handle situation when a patch in the middle of the function stack
  ^^^^^^^^^^^^^^^^
s/handle situation/handle a situation

> (ops->func_stack) is being removed.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

>  Documentation/livepatch/cumulative-patches.txt | 11 ++----
>  Documentation/livepatch/livepatch.txt          | 30 ++++++++-------
>  kernel/livepatch/core.c                        | 51 ++++++++++++++++++++++++--
>  3 files changed, 68 insertions(+), 24 deletions(-)
> 
>
> [ ... snip ... ]
>
> diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> index ba6e83a08209..3c150ab19b99 100644
> --- a/Documentation/livepatch/livepatch.txt
> +++ b/Documentation/livepatch/livepatch.txt
> @@ -143,9 +143,9 @@ without HAVE_RELIABLE_STACKTRACE are not considered fully supported by
>  the kernel livepatching.
>  
>  The /sys/kernel/livepatch/<patch>/transition file shows whether a patch
> -is in transition.  Only a single patch (the topmost patch on the stack)
> -can be in transition at a given time.  A patch can remain in transition
> -indefinitely, if any of the tasks are stuck in the initial patch state.
> +is in transition.  Only a single patch can be in transition at a given
> +time.  A patch can remain in transition indefinitely, if any of the tasks
> +are stuck in the initial patch state.
>  
>  A transition can be reversed and effectively canceled by writing the
>  opposite value to the /sys/kernel/livepatch/<patch>/enabled file while
> @@ -329,9 +329,10 @@ The livepatch gets enabled by calling klp_enable_patch() typically from
>  module_init() callback. The system will start using the new implementation
>  of the patched functions at this stage.
>  
> -First, the addresses of the patched functions are found according to their
> -names. The special relocations, mentioned in the section "New functions",
> -are applied. The relevant entries are created under
> +First, possible conflicts are checked for non-cummulative patches with
                                             ^^^^^^^^^^^^^^^
s/non-cummulative/non-cumulative

>
> [ ... snip ... ]
>
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 0ce752e9e8bb..d8f6f49ac6b3 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -122,6 +122,47 @@ static struct klp_object *klp_find_object(struct klp_patch *patch,
>  	return NULL;
>  }
>  
> +static int klp_check_obj_conflict(struct klp_patch *patch,
> +				  struct klp_object *old_obj)
> +{
> +	struct klp_object *obj;
> +	struct klp_func *func, *old_func;
> +
> +	obj = klp_find_object(patch, old_obj);
> +	if (!obj)
> +		return 0;
> +
> +	klp_for_each_func(old_obj, old_func) {
> +		func = klp_find_func(obj, old_func);
> +		if (!func)
> +			continue;
> +
> +		pr_err("Function '%s,%lu' in object '%s' has already been livepatched.\n",
> +		       func->old_name, func->old_sympos ? func->old_sympos : 1,
> +		       obj->name ? obj->name : "vmlinux");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Should we add a self-test check for this condition?  Let me know and I
can give it a go if you want to include with v15.

-- Joe
