Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EBBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E386F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfAJMci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:32:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbfAJMch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:32:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E7B1AEA6;
        Thu, 10 Jan 2019 12:32:36 +0000 (UTC)
Date:   Thu, 10 Jan 2019 13:32:35 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 05/11] livepatch: Simplify API by removing registration
 step
In-Reply-To: <20190109124329.21991-6-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1901101332150.15065@pobox.suse.cz>
References: <20190109124329.21991-1-pmladek@suse.com> <20190109124329.21991-6-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Petr Mladek wrote:

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
> Therefore, remove the two step public API. All the checks and init calls
> are moved from klp_register_patch() to klp_enabled_patch(). Also the patch
> is automatically freed, including the sysfs interface when the transition
> to the disabled state is completed.
> 
> As a result, there is never a disabled patch on the top of the stack.
> Therefore we do not need to check the stack in __klp_enable_patch().
> And we could simplify the check in __klp_disable_patch().
> 
> Also the API and logic is much easier. It is enough to call
> klp_enable_patch() in module_init() call. The patch can be disabled
> by writing '0' into /sys/kernel/livepatch/<patch>/enabled. Then the module
> can be removed once the transition finishes and sysfs interface is freed.
> 
> The only problem is how to free the structures and kobjects safely.
> The operation is triggered from the sysfs interface. We could not put
> the related kobject from there because it would cause lock inversion
> between klp_mutex and kernfs locks, see kn->count lockdep map.
> 
> Therefore, offload the free task to a workqueue. It is perfectly fine:
> 
>   + The patch can no longer be used in the livepatch operations.
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

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
