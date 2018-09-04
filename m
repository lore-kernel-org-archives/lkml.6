Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B807C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF46A20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF46A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIDTl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:41:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbeIDTl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:41:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87987B061;
        Tue,  4 Sep 2018 15:15:52 +0000 (UTC)
Date:   Tue, 4 Sep 2018 17:15:50 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 10/12] livepatch: Atomic replace and cumulative
 patches documentation
In-Reply-To: <20180828143603.4442-11-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1809041709570.3194@pobox.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com> <20180828143603.4442-11-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Petr Mladek wrote:

> User documentation for the atomic replace feature. It makes it easier
> to maintain livepatches using so-called cumulative patches.

I think the documentation should be updated due to API changes.
 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  Documentation/livepatch/cumulative-patches.txt | 105 +++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/livepatch/cumulative-patches.txt
> 
> diff --git a/Documentation/livepatch/cumulative-patches.txt b/Documentation/livepatch/cumulative-patches.txt
> new file mode 100644
> index 000000000000..206b7f98d270
> --- /dev/null
> +++ b/Documentation/livepatch/cumulative-patches.txt
> @@ -0,0 +1,105 @@
> +===================================
> +Atomic Replace & Cumulative Patches
> +===================================
> +
> +There might be dependencies between livepatches. If multiple patches need
> +to do different changes to the same function(s) then we need to define
> +an order in which the patches will be installed. And function implementations
> +from any newer livepatch must be done on top of the older ones.
> +
> +This might become a maintenance nightmare. Especially if anyone would want
> +to remove a patch that is in the middle of the stack.
> +
> +An elegant solution comes with the feature called "Atomic Replace". It allows
> +to create so called "Cumulative Patches". They include all wanted changes
> +from all older livepatches and completely replace them in one transition.
> +
> +Usage
> +-----
> +
> +The atomic replace can be enabled by setting "replace" flag in struct klp_patch,
> +for example:
> +
> +	static struct klp_patch patch = {
> +		.mod = THIS_MODULE,
> +		.objs = objs,
> +		.replace = true,
> +	};
> +
> +Such a patch is added on top of the livepatch stack when registered. It can
> +be enabled even when some earlier patches have not been enabled yet.

Here.

> +All processes are then migrated to use the code only from the new patch.
> +Once the transition is finished, all older patches are removed from the stack
> +of patches. Even the older not-enabled patches mentioned above. They can
> +even be unregistered and the related modules unloaded.

Here.

> +Ftrace handlers are transparently removed from functions that are no
> +longer modified by the new cumulative patch.
> +
> +As a result, the livepatch authors might maintain sources only for one
> +cumulative patch. It helps to keep the patch consistent while adding or
> +removing various fixes or features.
> +
> +Users could keep only the last patch installed on the system after
> +the transition to has finished. It helps to clearly see what code is
> +actually in use. Also the livepatch might then be seen as a "normal"
> +module that modifies the kernel behavior. The only difference is that
> +it can be updated at runtime without breaking its functionality.
> +
> +
> +Features
> +--------
> +
> +The atomic replace allows:
> +
> +  + Atomically revert some functions in a previous patch while
> +    upgrading other functions.
> +
> +  + Remove eventual performance impact caused by core redirection
> +    for functions that are no longer patched.
> +
> +  + Decrease user confusion about stacking order and what patches are
> +    currently in effect.
> +
> +
> +Limitations:
> +------------
> +
> +  + Replaced patches can no longer be enabled. But if the transition
> +    to the cumulative patch was not forced, the kernel modules with
> +    the older livepatches can be removed and eventually added again.

I'd rewrite even this.

> +    A good practice is to set .replace flag in any released livepatch.
> +    Then re-adding an older livepatch is equivalent to downgrading
> +    to that patch. This is safe as long as the livepatches do _not_ do
> +    extra modifications in (un)patching callbacks or in the module_init()
> +    or module_exit() functions, see below.
> +
> +
> +  + Only the (un)patching callbacks from the _new_ cumulative livepatch are
> +    executed. Any callbacks from the replaced patches are ignored.
> +
> +    By other words, the cumulative patch is responsible for doing any actions
> +    that are necessary to properly replace any older patch.

s/By other words/In other words/

> +    As a result, it might be dangerous to replace newer cumulative patches by
> +    older ones. The old livepatches might not provide the necessary callbacks.
> +
> +    This might be seen as a limitation in some scenarios. But it makes the life
> +    easier in many others. Only the new cumulative livepatch knows what
> +    fixes/features are added/removed and what special actions are necessary
> +    for a smooth transition.
> +
> +    In each case, it would be a nightmare to think about the order of
> +    the various callbacks and their interactions if the callbacks from all
> +    enabled patches were called.

s/In each case/In any case/ ?

> +  + There is no special handling of shadow variables. Livepatch authors
> +    must create their own rules how to pass them from one cumulative
> +    patch to the other. Especially they should not blindly remove them
> +    in module_exit() functions.
> +
> +    A good practice might be to remove shadow variables in the post-unpatch
> +    callback. It is called only when the livepatch is properly disabled.

Miroslav
