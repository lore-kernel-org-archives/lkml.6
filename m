Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F3C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6654020851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6654020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeLMWqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:46:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeLMWqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:46:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57392300207A;
        Thu, 13 Dec 2018 22:46:32 +0000 (UTC)
Received: from treble (ovpn-120-195.rdu2.redhat.com [10.10.120.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D829760FE5;
        Thu, 13 Dec 2018 22:46:27 +0000 (UTC)
Date:   Thu, 13 Dec 2018 16:46:25 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing
 registration step
Message-ID: <20181213224625.65o77z75u4njocnp@treble>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-6-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-6-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 13 Dec 2018 22:46:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:25AM +0100, Petr Mladek wrote:
> @@ -309,40 +297,33 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  	mutex_lock(&klp_mutex);
>  
> -	if (!klp_is_patch_registered(patch)) {
> -		/*
> -		 * Module with the patch could either disappear meanwhile or is
> -		 * not properly initialized yet.
> -		 */
> -		ret = -EINVAL;
> -		goto err;
> -	}
> -
>  	if (patch->enabled == enabled) {
>  		/* already in requested state */
>  		ret = -EINVAL;
> -		goto err;
> +		goto out;
>  	}
>  
> -	if (patch == klp_transition_patch) {
> +	/*
> +	 * Allow to reverse a pending transition in both ways. It might be
> +	 * necessary to complete the transition without forcing and breaking
> +	 * the system integrity.
> +	 *
> +	 * Do not allow to re-enable a disabled patch because this interface
> +	 * is being destroyed.
> +	 */
> +	if (patch == klp_transition_patch)
>  		klp_reverse_transition();
> -	} else if (enabled) {
> -		ret = __klp_enable_patch(patch);
> -		if (ret)
> -			goto err;
> -	} else {
> +	else if (!enabled)
>  		ret = __klp_disable_patch(patch);
> -		if (ret)
> -			goto err;
> -	}
> +	else
> +		ret = -EINVAL;

Now that we can't re-enable a patch, I wonder if we really need both the
'patch->enabled' and 'klp_target_state' variables?

A patch is now always enabled, unless it's in transition, in which case
its 'enabled' state is the same as 'klp_target_state'.

For example I wonder if we could get rid of 'klp_target_state', since it
should be the same as 'klp_transition_patch->enabled'.

Or alternatively we could get rid of 'patch->enabled', since it should
be the same as

	patch == klp_transition_patch ? klp_target_state : true

Of course this could be a follow-on cleanup patch, which could be done
in the future, so as not to hold up the merging of these patches
anymore.

-- 
Josh
