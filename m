Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E5ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BD7208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BD7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJRE2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:28:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbeJRE2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E622A6E13;
        Wed, 17 Oct 2018 20:31:13 +0000 (UTC)
Received: from treble (ovpn-122-46.rdu2.redhat.com [10.10.122.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FE8560C61;
        Wed, 17 Oct 2018 20:31:09 +0000 (UTC)
Date:   Wed, 17 Oct 2018 15:31:07 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v13 07/12] livepatch: Use lists to manage patches,
 objects and functions
Message-ID: <20181017203107.lirzlz2sulntauqq@treble>
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015123713.25868-8-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 17 Oct 2018 20:31:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:37:08PM +0200, Petr Mladek wrote:
> +static int klp_init_lists(struct klp_patch *patch)
> +{
> +	struct klp_object *obj;
> +	struct klp_func *func;
> +
> +	INIT_LIST_HEAD(&patch->obj_list);
> +	if (!patch->objs)
> +		return -EINVAL;
> +
> +	klp_for_each_object_static(patch, obj) {
> +		list_add(&obj->node, &patch->obj_list);
> +
> +		INIT_LIST_HEAD(&obj->func_list);
> +		if (!obj->funcs)
> +			return -EINVAL;
> +
> +		klp_for_each_func_static(obj, func)
> +			list_add(&func->node, &obj->func_list);
> +	}
> +
> +	return 0;
> +}

It may be ever-so-slightly better to use list_add_tail() instead of
list_add(), so the list order matches the array order.  I doubt the
ordering really matters, but you never know.  It could for example make
debugging a little easier in some scenarios.

-- 
Josh
