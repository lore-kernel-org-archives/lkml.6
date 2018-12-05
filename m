Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9A7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C0A20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C0A20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeLETc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:32:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLETcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:32:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DF6A89ACA;
        Wed,  5 Dec 2018 19:32:55 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25E1F60E3F;
        Wed,  5 Dec 2018 19:32:54 +0000 (UTC)
Date:   Wed, 5 Dec 2018 14:32:53 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing
 registration step
Message-ID: <20181205193253.mhlqj37r4o6ukkhp@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-6-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-6-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 05 Dec 2018 19:32:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:25AM +0100, Petr Mladek wrote:
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
                                                ^^^^^^^^^^^
s/patch patch/patch

> by writing '0' into /sys/kernel/livepatch/<patch>/enabled. Then the module
> can be removed once the transition finishes and sysfs interface is freed.
> 
> The only problem is how to free the structures and kobjects a safe way.
> The operation is triggered from the sysfs interface. We could not put
> the related kobject from there because it would cause lock inversion
> between klp_mutex and kernfs locks, see kn->count lockdep map.
> 
> This patch solved the problem by offloading the free task to
> a workqueue. It is perfectly fine:
> 
>   + The patch cannot not longer be used in the livepatch operations.
> 
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

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

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
>  
> [ ... snip ... ]
>
> +5.1. Loading
> +------------
>  
> -5.1. Registration
> ------------------
> +The only reasonable way is to enable the patch when the livepatch kernel
> +module is being loaded. For this, klp_enable_patch() has to be called
> +in module_init() callback. There are two main reasons:
   ^^^^^^^^^^^^^^^^

s/in module_init()/in the module_init()

>  
> [ ... snip ... ]
>
> +5.4. Removing
> +-------------
>  
> -At this stage, all the relevant sys-fs entries are removed and the patch
> -is removed from the list of known patches.
> +Module removal is only safe when there are no users of the underlying
                                                              ^^^^^^^^^^
Could a reader confuse "underlying functions" for functions in the
livepatching-core?  Would "modified functions" or adding "(struct
klp_func) " make this more specific?

> +functions. This is the reason why the force feature permanently disables
> +the removal. The forced tasks entered the functions but we cannot say
                                         ^^^^^^^^^^^^^
Same ambiguity here.

> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index b71892693da5..1366dbb159ab 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -144,6 +144,7 @@ struct klp_object {
>   * @kobj_alive: @kobj has been added and needs freeing
>   * @enabled:	the patch is enabled (but operation may be incomplete)
>   * @forced:	was involved in a forced transition
> + * @free_work:	work freeing the patch that has to be done in another context
                                                                      ^^^^^^^^^^^^^^^
Can we just state the context here?  ie:

 * @free_work:	patch cleanup from workqueue-context

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 972520144713..e01dfa3b58d2 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -45,7 +45,7 @@
>   */
>  DEFINE_MUTEX(klp_mutex);
>  
> -/* Registered patches */
> +/* Actively used patches. */
>  LIST_HEAD(klp_patches);

By itself, this comment makes me wonder if there are un-active and/or
un-used patches that I need to worry about.  After this patchset,
klp_patches will include patches that have been enabled and those that
have been replaced, but the replacement transition is still in progress.  

If that sounds accurate, how about adding to the comment:

/* Actively used patches: enabled or replaced and awaiting transition */


-- Joe
