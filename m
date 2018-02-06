Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeBFRIO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:08:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeBFRHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:07:46 -0500
Date: Tue, 6 Feb 2018 12:07:42 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/7] livepatch: Atomic replace and cumulative patches
 documentation
Message-ID: <20180206170742.ldamdwztn2bs2t25@redhat.com>
References: <20180206103424.10829-1-pmladek@suse.com>
 <20180206103424.10829-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206103424.10829-8-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 11:34:24AM +0100, Petr Mladek wrote:
> User documentation for the atomic replace feature. It makes it easier
> to maintain livepatches using so-called cumulative patches.

Thanks for adding this doc.  A few minor wording suggestions and typos
below...

> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  Documentation/livepatch/cumulative-patches.txt | 76 ++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/livepatch/cumulative-patches.txt
> 
> diff --git a/Documentation/livepatch/cumulative-patches.txt b/Documentation/livepatch/cumulative-patches.txt
> new file mode 100644
> index 000000000000..5f1f3760b840
> --- /dev/null
> +++ b/Documentation/livepatch/cumulative-patches.txt
> @@ -0,0 +1,76 @@
> +===================================
> +Atomic Replace & Cumulative Patches
> +===================================
> +
> +There are dependencies between livepatches when more patches modify the same

s/more/multiple

> +function(s). Then any newer livepatch must include changes from the older ones.

If the new patch wants to maintain the original change that is.
(Perhaps that's implied here.)  

Also this might be a good place to formally introduce the "cumulative
patch" as a recurring term.

> +Also the patches must be registered in the right order.
> +
> +This might become a maintenance nightmare. Especially if anyone would want
> +to remove a patch that is in the middle of the stack.
> +
> +An elegant solution comes with the feature called "Atomic Replace". It allows
> +to create cumulative patches that completely replace all older livepatches.
> +
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
> +Such a patch is added on top of the livepatch stack when registered. It might
> +be enabled even when some earlier patches have not been enabled yet.

"It can be enabled" reads a little more naturally I think.

> +
> +All processes are then migrated to use the code only from the new patch.
> +Once the transition is finished, all older patches are removed from the stack
> +of patches.

Even the older not-enabled patches mentioned above.

> +
> +Ftrace handlers are transparently removed from functions that are not
> +longer modified by the new cumulative patch.
> +

s/not longer/no longer

> +As a result, the livepatch author might maintain sources only for one
> +cumulative patch. It helps to keep the patch consistent while adding or
> +removing various fixes or features.
> +
> +
> +Limitations:
> +------------
> +
> +  + Replaced patches can not longer be enabled. But if the transition

s/not longer/no longer

and "the transition" refers to the older patch transition, right?  (Not
the cumulative patching transition.)

> +    was not forced, the older patches might be unregistered, removed
> +    and eventually used again.
> +
> +
> +  + Only the (un)patching callbacks from the _new_ cumulative livepatch are
> +    proceed. Any callbacks from the replaced patches are ignored.

s/proceed/executed

> +
> +    By other words, the cumulative patch is responsible for doing any actions
> +    that are necessary to properly replace any older patch.
> +
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

I wonder if this deserves comment or an example in the callbacks
document, even if its a simple, contrived callback.  (I'll think on
this.)

> +
> +
> +  + There is no special handling of shadow variables. Livepatch authors
> +    must create their own rules how to pass them from one cumulative
> +    patch to the other. Especially they should not blindly remove them
> +    in module_exit() functions.
> +
> +    A good practice might be to remove shadow variables in the post-unpatch
> +    callback. It is called only when the livepatch is properly disabled.

Same here.

-- Joe
