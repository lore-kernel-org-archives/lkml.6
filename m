Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23757C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1A12089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfAUWrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:47:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfAUWrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:47:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E86A7F6B3;
        Mon, 21 Jan 2019 22:47:31 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 331695DD91;
        Mon, 21 Jan 2019 22:47:30 +0000 (UTC)
Date:   Mon, 21 Jan 2019 17:47:28 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] livepatch: Module coming and going callbacks can
 proceed all listed patches
Message-ID: <20190121224728.GC8766@redhat.com>
References: <20190116161720.796-1-pmladek@suse.com>
 <20190116161720.796-4-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116161720.796-4-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 21 Jan 2019 22:47:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:17:19PM +0100, Petr Mladek wrote:
> Livepatches can not longer get enabled and disabled repeatedly.

nit: s/not longer/no longer/g

> The list klp_patches contains only enabled patches and eventually
> the patch in transition.
> 
> The module coming and going callbacks do not longer need to
> check for these state. They have to proceed all listed patches.

nit: suggestion to modify "proceed all" to "proceed with" or "execute
all".  Same suggestion for the subject line.  (I keep reading it as
"precede all" and I'm wondering if there is some kind of ordering
change.)
   
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/livepatch/core.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index b716a6289204..684766d306ad 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -1141,21 +1141,14 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
>  			if (!klp_is_module(obj) || strcmp(obj->name, mod->name))
>  				continue;
>  
> -			/*
> -			 * Only unpatch the module if the patch is enabled or
> -			 * is in transition.
> -			 */
> -			if (patch->enabled || patch == klp_transition_patch) {
> -
> -				if (patch != klp_transition_patch)
> -					klp_pre_unpatch_callback(obj);
> +			if (patch != klp_transition_patch)
> +				klp_pre_unpatch_callback(obj);
>  
> -				pr_notice("reverting patch '%s' on unloading module '%s'\n",
> -					  patch->mod->name, obj->mod->name);
> -				klp_unpatch_object(obj);
> +			pr_notice("reverting patch '%s' on unloading module '%s'\n",
> +				  patch->mod->name, obj->mod->name);
> +			klp_unpatch_object(obj);
>  
> -				klp_post_unpatch_callback(obj);
> -			}
> +			klp_post_unpatch_callback(obj);
>  
>  			klp_free_object_loaded(obj);
>  			break;
> @@ -1194,13 +1187,6 @@ int klp_module_coming(struct module *mod)
>  				goto err;
>  			}
>  
> -			/*
> -			 * Only patch the module if the patch is enabled or is
> -			 * in transition.
> -			 */
> -			if (!patch->enabled && patch != klp_transition_patch)
> -				break;
> -
>  			pr_notice("applying patch '%s' to loading module '%s'\n",
>  				  patch->mod->name, obj->mod->name);
>  
> -- 
> 2.13.7
> 

Any simplication to the callback code is welcome!  Thanks for cleaning
this one up.

With a few commit msg nits,
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
