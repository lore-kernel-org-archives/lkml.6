Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9F120661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9F120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbeGTSKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:10:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387950AbeGTSKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:10:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DD1281663EE;
        Fri, 20 Jul 2018 17:20:53 +0000 (UTC)
Received: from treble (ovpn-120-158.rdu2.redhat.com [10.10.120.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E1132026D69;
        Fri, 20 Jul 2018 17:20:53 +0000 (UTC)
Date:   Fri, 20 Jul 2018 12:20:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Jiri Kosina <jikos@kernel.org>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Validate module/old func name length
Message-ID: <20180720172051.jkgm3txclbon2bsy@treble>
References: <1532080002-10724-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532080002-10724-1-git-send-email-kamalesh@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 17:20:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 17:20:53 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 03:16:42PM +0530, Kamalesh Babulal wrote:
> livepatch module author can pass module name/old function name with more
> than the defined character limit. With obj->name length greater than
> MODULE_NAME_LEN, the livepatch module gets loaded but waits forever on
> the module specified by obj->name to be loaded. It also populates a /sys
> directory with an untruncated object name.
> 
> In the case of funcs->old_name length greater then KSYM_NAME_LEN, it
> would not match against any of the symbol table entries. Instead loop
> through the symbol table comparing them against a nonexisting function,
> which can be avoided.
> 
> The same issues apply, to misspelled/incorrect names. At least gatekeep
> the modules with over the limit string length, by checking for their
> length during livepatch module registration.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

> ---
>  kernel/livepatch/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 3a4656fb7047..5b77a7314e01 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -678,6 +678,9 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
>  	if (!func->old_name || !func->new_func)
>  		return -EINVAL;
>  
> +	if (strlen(func->old_name) >= KSYM_NAME_LEN)
> +		return -EINVAL;
> +
>  	INIT_LIST_HEAD(&func->stack_node);
>  	func->patched = false;
>  	func->transition = false;
> @@ -751,6 +754,9 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
>  	if (!obj->funcs)
>  		return -EINVAL;
>  
> +	if (klp_is_module(obj) && strlen(obj->name) >= MODULE_NAME_LEN)
> +		return -EINVAL;
> +
>  	obj->patched = false;
>  	obj->mod = NULL;
>  
> -- 
> 2.7.4
> 

-- 
Josh
