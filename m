Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231C6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE05D2146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE05D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeLETCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:02:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLETCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:02:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FAE2811A9;
        Wed,  5 Dec 2018 19:02:22 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6C1219C7B;
        Wed,  5 Dec 2018 19:02:21 +0000 (UTC)
Date:   Wed, 5 Dec 2018 14:02:20 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 03/11] livepatch: Consolidate klp_free functions
Message-ID: <20181205190220.vterzx33opvvijne@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-4-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-4-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 05 Dec 2018 19:02:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:23AM +0100, Petr Mladek wrote:
> The code for freeing livepatch structures is a bit scattered and tricky:
> 
>   + direct calls to klp_free_*_limited() and kobject_put() are
>     used to release partially initialized objects
> 
>   + klp_free_patch() removes the patch from the public list
>     and releases all objects except for patch->kobj
> 
>   + object_put(&patch->kobj) and the related wait_for_completion()
>     are called directly outside klp_mutex; this code is duplicated;
> 
> Now, we are going to remove the registration stage to simplify the API
> and the code. This would require handling more situations in
> klp_enable_patch() error paths.
> 
> More importantly, we are going to add a feature called atomic replace.
> It will need to dynamically create func and object structures. We will
> want to reuse the existing init() and free() functions. This would
> create even more error path scenarios.
> 
> [*] We need our own flag. Note that kobject_put() cannot be called safely
>     when kobj.state_initialized is set. This flag is true when kobject_add()
>     part failed. And it is never cleared.
> [*] We need our own flag. Note that kobject_put() cannot be called safely
>     when kobj.state_initialized is set. This flag is true when kobject_add()
>     part failed. And it is never cleared.
> This patch implements a more clever free functions:
                        ^^^^^^^^^^^^^
re-wording suggestions: "simpler", "clearer", "more straightforward"

> 
>   + checks kobj_alive flag instead of @limit[*]
> 
>   + initializes patch->list early so that the check for empty list
>     always works
> 
>   + The action(s) that has to be done outside klp_mutex are done
>     in separate klp_free_patch_finish() function. It waits only
>     when patch->kobj was really released via the _start() part.
> 
> The patch does not change the existing behavior.
> 
> [*] We need our own flag. Note that kobject_put() cannot be called safely
>     when kobj.state_initialized is set. This flag is true when kobject_add()
>     part failed. And it is never cleared.

Isn't kobj.state_initialized also true in the ordinary kobject_put() case
where kobject_add() succeeded?

If so, this note could be modified slightly:

(minimal change)

[*] We need our own flag. Note that kobject_put() cannot be called safely
    just because kobj.state_initialized is set. This flag is even true when kobject_add()
    part failed. And it is never cleared.

 -- or --

(rewording)

[*] We need our own flag to track that the kobject was successfully
    added to the hierarchy.  Note that kobj.state_initialized only
    indicates that kobject has been initialized, not whether is has been
    added (and needs to be removed on cleanup).

> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jason Baron <jbaron@akamai.com>
> ---

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

> 
> [ ... snip ... ]
>
> +static int klp_init_patch(struct klp_patch *patch)
> +{
> +	struct klp_object *obj;
> +	int ret;
> +
> +	mutex_lock(&klp_mutex);
> +
> +	ret = klp_init_patch_before_free(patch);
>  	if (ret) {
>  		mutex_unlock(&klp_mutex);
>  		return ret;
>  	}
> 

I believe klp_init_patch_before_free() accumulates more responsibilities
later in the patchset, but I'll ask here: does it really need the
klp_mutex since it looks to be operating only on the klp_patch, its
objects and functions? 

-- Joe
