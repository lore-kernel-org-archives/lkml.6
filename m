Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9447AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521C320672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521C320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503911AbeKWWoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:44:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:59408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390446AbeKWWoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:44:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C182AE98;
        Fri, 23 Nov 2018 12:00:36 +0000 (UTC)
Date:   Fri, 23 Nov 2018 13:00:35 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v13 08/12] livepatch: Add atomic replace
In-Reply-To: <20181015123713.25868-9-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1811222132050.19197@pobox.suse.cz>
References: <20181015123713.25868-1-pmladek@suse.com> <20181015123713.25868-9-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Petr Mladek wrote:

> +static int klp_add_object_nops(struct klp_patch *patch,
> +			       struct klp_object *old_obj)
> +{
> +	struct klp_object *obj;
> +	struct klp_func *func, *old_func;
> +
> +	obj = klp_find_object(patch, old_obj);
> +
> +	if (!obj) {
> +		obj = klp_alloc_object_dynamic(old_obj->name);
> +		if (!obj)
> +			return -ENOMEM;
> +
> +		list_add(&obj->node, &patch->obj_list);
> +	}
> +
> +	klp_for_each_func(old_obj, old_func) {
> +		func = klp_find_func(obj, old_func);
> +		if (func)
> +			continue;
> +
> +		func = klp_alloc_func_nop(old_func, obj);
> +		if (!func)
> +			return -ENOMEM;
> +
> +		list_add(&func->node, &obj->func_list);
> +	}
> +
> +	return 0;
> +}

Maybe you should consider list_add_tail() here too.

> +
> +/*
> + * Add 'nop' functions which simply return to the caller to run
> + * the original function. The 'nop' functions are added to a
> + * patch to facilitate a 'replace' mode.
> + */
> +static int klp_add_nops(struct klp_patch *patch)
> +{
> +	struct klp_patch *old_patch;
> +	struct klp_object *old_obj;
> +	int err = 0;

The initialization is unnecessary.

> +	list_for_each_entry(old_patch, &klp_patches, list) {
> +		klp_for_each_object(old_patch, old_obj) {
> +			err = klp_add_object_nops(patch, old_obj);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}

Miroslav
