Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92C2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD45214DB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD45214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeLEUUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:20:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeLEUUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:20:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02BD1C0740F1;
        Wed,  5 Dec 2018 20:20:36 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 222441001F50;
        Wed,  5 Dec 2018 20:20:35 +0000 (UTC)
Date:   Wed, 5 Dec 2018 15:20:34 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 09/11] livepatch: Atomic replace and cumulative
 patches documentation
Message-ID: <20181205202034.a66aulfbkl4abr3q@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-10-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-10-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 05 Dec 2018 20:20:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:29AM +0100, Petr Mladek wrote:
> User documentation for the atomic replace feature. It makes it easier
> to maintain livepatches using so-called cumulative patches.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

>  Documentation/livepatch/cumulative-patches.txt | 105 +++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/livepatch/cumulative-patches.txt
> 
> diff --git a/Documentation/livepatch/cumulative-patches.txt b/Documentation/livepatch/cumulative-patches.txt
> new file mode 100644
> index 000000000000..a8089f7fe306
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
   ^^^^^^^^^
re-wording suggestion: "creation of"

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
> +Such a patch is added on top of the livepatch stack when enabled.
> +
> +All processes are then migrated to use the code only from the new patch.
> +Once the transition is finished, all older patches are automatically
> +disabled and removed from the stack of patches.
> +
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
> +  + Decrease user confusion about stacking order and what code
> +    is actually in use.
> +
> +
> +Limitations:
> +------------
> +
> +  + Once the operation finishes, there is no straightforward way
> +    to reverse it and restore the replaced patches atomically.
> +
> +    A good practice is to set .replace flag in any released livepatch.
> +    Then re-adding an older livepatch is equivalent to downgrading
> +    to that patch. This is safe as long as the livepatches do _not_ do
> +    extra modifications in (un)patching callbacks or in the module_init()
> +    or module_exit() functions, see below.
> +
> +    Also note that the replaced patch can be removed and loaded again
> +    only when the transition was not forced.
> +
> +
> +  + Only the (un)patching callbacks from the _new_ cumulative livepatch are
> +    executed. Any callbacks from the replaced patches are ignored.
> +
> +    In other words, the cumulative patch is responsible for doing any actions
> +    that are necessary to properly replace any older patch.
> +
> +    As a result, it might be dangerous to replace newer cumulative patches by
> +    older ones. The old livepatches might not provide the necessary callbacks.
> +
> +    This might be seen as a limitation in some scenarios. But it makes the life
                                                                          ^^^^^^^^
s/the life/life

> +    easier in many others. Only the new cumulative livepatch knows what
> +    fixes/features are added/removed and what special actions are necessary
> +    for a smooth transition.
> +
> +    In any case, it would be a nightmare to think about the order of
> +    the various callbacks and their interactions if the callbacks from all
> +    enabled patches were called.
> +
> +
> +  + There is no special handling of shadow variables. Livepatch authors
> +    must create their own rules how to pass them from one cumulative
> +    patch to the other. Especially they should not blindly remove them
                           ^^^^^^^^^^^^^^^
rewording suggestion: "Especially that they"

> +    in module_exit() functions.
> +
> +    A good practice might be to remove shadow variables in the post-unpatch
> +    callback. It is called only when the livepatch is properly disabled.
> -- 
> 2.13.7
> 

-- Joe
