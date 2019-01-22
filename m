Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F40C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C6120879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfAVKHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:07:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:39064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbfAVKG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:06:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F008AD23;
        Tue, 22 Jan 2019 10:06:58 +0000 (UTC)
Date:   Tue, 22 Jan 2019 11:06:56 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] livepatch: Remove the redundant enabled flag in
 struct klp_patch
In-Reply-To: <20190116161720.796-5-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1901221100020.16809@pobox.suse.cz>
References: <20190116161720.796-1-pmladek@suse.com> <20190116161720.796-5-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019, Petr Mladek wrote:

> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 684766d306ad..8e644837e668 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -59,6 +59,17 @@ static bool klp_is_module(struct klp_object *obj)
>  	return obj->name;
>  }
>  
> +static bool klp_patch_enabled(struct klp_patch *patch)
> +{
> +	if (patch == klp_transition_patch) {
> +		WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);

I think we'd have a race in the code then. enabled_show() does not take 
klp_mutex() when calling klp_patch_enabled().

A patch sysfs attributes are added quite early during its enablement. 
klp_init_transition() first sets klp_transition_patch, then 
klp_target_state. It means one can call enabled_show() with patch == 
klp_transition_patch and klp_target_state == KLP_UNDEFINED. No?

The similar applies the disablement. klp_complete_transition() first 
clears klp_target_state (sets it to KLP_UNDEFINED), then it clears 
klp_transition_patch.

We could add locking to enabled_show() or swap the assignments with some 
barriers on top.

Or we could remove WARN_ON_ONCE() and live with false results in 
enabled_show(). It does not matter much, I think. All the other call sites 
of klp_patch_enabled() should be fine.

> +		return klp_target_state == KLP_PATCHED;
> +	}
> +
> +	return !list_empty(&patch->list);
> +}

Shouldn't we also change list_del(&patch->list) in klp_free_patch_start() 
to list_del_init(&patch->list)?

[...]

> @@ -955,7 +964,7 @@ static int __klp_enable_patch(struct klp_patch *patch)
>  	if (klp_transition_patch)
>  		return -EBUSY;
>  
> -	if (WARN_ON(patch->enabled))
> +	if (list_empty(&patch->list))
>  		return -EINVAL;

I wanted to ask why there is list_empty() and not klp_patch_enabled(), so 
just to be sure... the patch was added to klp_patches list, so patch->list 
is not empty (should not be). We could achieve the same by calling 
!klp_patch_enabled() given its implementation, but it would look 
counter-intuitive here.

The rest looks fine.

However, I am not sure if the outcome is better than what we have. Yes, 
patch->enabled is not technically necessary and we can live with that (as 
the patch proves). On the other hand, it gives the reader clear guidance 
about the patch's state. klp_patch_enabled() is not a complete 
replacement. We have to call list_empty() in __klp_enable_patch() or check 
the original klp_target_state in klp_try_complete_transition().

I am not against the change, I am glad to see it is achievable, but I am 
not sure if the code is better with it. Joe acked it. What do the others 
think?

Thanks,
Miroslav
