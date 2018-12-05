Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8822EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F80D2146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F80D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeLEThf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:37:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbeLEThe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:37:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F3EC30832C7;
        Wed,  5 Dec 2018 19:37:34 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D2E8648A6;
        Wed,  5 Dec 2018 19:37:33 +0000 (UTC)
Date:   Wed, 5 Dec 2018 14:37:32 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 07/11] livepatch: Add atomic replace
Message-ID: <20181205193732.qu25oh5xrqg7am36@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-8-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 05 Dec 2018 19:37:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:27AM +0100, Petr Mladek wrote:
> From: Jason Baron <jbaron@akamai.com>
> 
> Sometimes we would like to revert a particular fix. Currently, this
> is not easy because we want to keep all other fixes active and we
> could revert only the last applied patch.
> 
> One solution would be to apply new patch that implemented all
> the reverted functions like in the original code. It would work
> as expected but there will be unnecessary redirections. In addition,
> it would also require knowing which functions need to be reverted at
> build time.
> 
> Another problem is when there are many patches that touch the same
> functions. There might be dependencies between patches that are
> not enforced on the kernel side. Also it might be pretty hard to
> actually prepare the patch and ensure compatibility with the other
> patches.
> 
> Atomic replace && cumulative patches:
> 
> A better solution would be to create cumulative patch and say that
> it replaces all older ones.
> 
> This patch adds a new "replace" flag to struct klp_patch. When it is
> enabled, a set of 'nop' klp_func will be dynamically created for all
> functions that are already being patched but that will no longer be
> modified by the new patch. They are used as a new target during
> the patch transition.
> 
> The idea is to handle Nops' structures like the static ones. When
> the dynamic structures are allocated, we initialize all values that
> are normally statically defined.
> 
> The only exception is "new_func" in struct klp_func. It has to point
> to the original function and the address is known only when the object
> (module) is loaded. Note that we really need to set it. The address is
> used, for example, in klp_check_stack_func().
> 
> Nevertheless we still need to distinguish the dynamically allocated
> structures in some operations. For this, we add "nop" flag into
> struct klp_func and "dynamic" flag into struct klp_object. They
> need special handling in the following situations:
> 
>   + The structures are added into the lists of objects and functions
>     immediately. In fact, the lists were created for this purpose.
> 
>   + The address of the original function is known only when the patched
>     object (module) is loaded. Therefore it is copied later in
>     klp_init_object_loaded().
> 
>   + The ftrace handler must not set PC to func->new_func. It would cause
>     infinite loop because the address points back to the beginning of
>     the original function.
> 
>   + The various free() functions must free the structure itself.
> 
> Note that other ways to detect the dynamic structures are not considered
> safe. For example, even the statically defined struct klp_object might
> include empty funcs array. It might be there just to run some callbacks.
> 
> Special callbacks handling:
> 
> The callbacks from the replaced patches are _not_ called by intention.
> It would be pretty hard to define a reasonable semantic and implement it.
> 
> It might even be counter-productive. The new patch is cumulative. It is
> supposed to include most of the changes from older patches. In most cases,
> it will not want to call pre_unpatch() post_unpatch() callbacks from
> the replaced patches. It would disable/break things for no good reasons.
> Also it should be easier to handle various scenarios in a single script
> in the new patch than think about interactions caused by running many
> scripts from older patches. Not to say that the old scripts even would
> not expect to be called in this situation.
> 
> Removing replaced patches:
> 
> One nice effect of the cumulative patches is that the code from the
> older patches is no longer used. Therefore the replaced patches can
> be removed. It has several advantages:
> 
>   + Nops' structs will not longer be necessary and might be removed.
                         ^^^^^^^^^^
s/not longer/no longer

>     This would save memory, restore performance (no ftrace handler),
>     allow clear view on what is really patched.
> 
>   + Disabling the patch will cause using the original code everywhere.
>     Therefore the livepatch callbacks could handle only one scenario.
>     Note that the complication is already complex enough when the patch
>     gets enabled. It is currently solved by calling callbacks only from
>     the new cumulative patch.
> 
>   + The state is clean in both the sysfs interface and lsmod. The modules
>     with the replaced livepatches might even get removed from the system.
> 
> Some people actually expected this behavior from the beginning. After all
> a cumulative patch is supposed to "completely" replace an existing one.
> It is like when a new version of an application replaces an older one.
> 
> This patch does the first step. It removes the replaced patches from
> the list of patches. It is safe. The consistency model ensures that
> they are not longer used. By other words, each process works only with
           ^^^^^^^^^^
s/not longer/no longer


> the structures from klp_transition_patch.
> 
> The removal is done by a special function. It combines actions done by
> __disable_patch() and klp_complete_transition(). But it is a fast
> track without all the transaction-related stuff.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Split, reuse existing code, simplified]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>
> ---

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

> diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> index d849af312576..ba6e83a08209 100644
> --- a/Documentation/livepatch/livepatch.txt
> +++ b/Documentation/livepatch/livepatch.txt
> @@ -15,8 +15,9 @@ Table of Contents:
>  5. Livepatch life-cycle
>     5.1. Loading
>     5.2. Enabling
> -   5.3. Disabling
> -   5.4. Removing
> +   5.3. Replacing
> +   5.4. Disabling
> +   5.5. Removing
>  6. Sysfs
>  7. Limitations
>  
> @@ -300,8 +301,12 @@ into three levels:
>  5. Livepatch life-cycle
>  =======================
>  
> -Livepatching can be described by four basic operations:
> -loading, enabling, disabling, removing.
> +Livepatching can be described by five basic operations:
> +loading, enabling, replacing, disabling, removing.
> +
> +Where the replacing and the disabling operations are mutually
> +exclusive. They have the same result for the given patch but
> +not for the system.
>  
>  
>  5.1. Loading
> @@ -347,7 +352,23 @@ to '0'.
>      the "Consistency model" section.
>  
>  
> -5.3. Disabling
> +5.3. Replacing
> +--------------
> +
> +All enabled patches might get replaced by a cumulative patch that
> +has the .replace flag set.
> +
> +Once the new patch is enabled and the 'transition" finishes then
                                         ^          ^
single quotes paired with double quotes

-- Joe
