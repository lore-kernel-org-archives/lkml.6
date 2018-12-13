Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71669C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377FC208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377FC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeLMWze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:55:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbeLMWze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:55:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D59BD86673;
        Thu, 13 Dec 2018 22:55:33 +0000 (UTC)
Received: from treble (ovpn-120-195.rdu2.redhat.com [10.10.120.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 715A226349;
        Thu, 13 Dec 2018 22:55:30 +0000 (UTC)
Date:   Thu, 13 Dec 2018 16:55:28 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 07/11] livepatch: Add atomic replace
Message-ID: <20181213225528.ies3kxjjtzl6dmd3@treble>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-8-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 13 Dec 2018 22:55:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:27AM +0100, Petr Mladek wrote:
> @@ -146,6 +150,7 @@ struct klp_object {
>   * struct klp_patch - patch structure for live patching
>   * @mod:	reference to the live patch module
>   * @objs:	object entries for kernel objects to be patched
> + * @replace:	replace all already registered patches

"all already registered" -> "all existing" ?

since we don't have a concept of "registered" patches anymore.

> @@ -415,6 +449,124 @@ static struct attribute *klp_patch_attrs[] = {
>  	NULL
>  };
>  
> +/*
> + * Dynamically allocated objects and functions.
> + */

I don't think this comment is needed.

> +static void klp_free_object_dynamic(struct klp_object *obj)
> +{
> +	kfree(obj->name);
> +	kfree(obj);
> +}
> @@ -456,6 +620,8 @@ static void klp_free_funcs(struct klp_object *obj)
>  		if (func->kobj_alive) {
>  			func->kobj_alive = false;
>  			kobject_put(&func->kobj);
> +		} else if (func->nop) {
> +			klp_free_func_nop(func);

This removes 'func' from the list, so it needs to do a 'safe' list
iteration.

>  		}
>  	}
>  }
> @@ -467,8 +633,12 @@ static void klp_free_object_loaded(struct klp_object *obj)
>  
>  	obj->mod = NULL;
>  
> -	klp_for_each_func(obj, func)
> +	klp_for_each_func(obj, func) {
>  		func->old_func = NULL;
> +
> +		if (func->nop)
> +			func->new_func = NULL;
> +	}
>  }
>  
>  static void klp_free_objects(struct klp_patch *patch)
> @@ -482,6 +652,8 @@ static void klp_free_objects(struct klp_patch *patch)
>  		if (obj->kobj_alive) {
>  			obj->kobj_alive = false;
>  			kobject_put(&obj->kobj);
> +		} else if (obj->dynamic) {
> +			klp_free_object_dynamic(obj);

Ditto.

> +void klp_discard_replaced_patches(struct klp_patch *new_patch)
> +{
> +	struct klp_patch *old_patch, *tmp_patch;
> +
> +	list_for_each_entry_safe(old_patch, tmp_patch, &klp_patches, list) {
> +		if (old_patch == new_patch)
> +			return;
> +
> +		old_patch->enabled = false;
> +		klp_unpatch_objects(old_patch);
> +		klp_free_patch_start(old_patch);
> +		schedule_work(&old_patch->free_work);
> +	}

This doesn't need the "safe" list iteration because it doesn't remove
the patch from the list.

Side note, it would probably be useful to have a klp_for_each_patch()
helper.

-- 
Josh
