Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBIM71 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:59:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:46558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbeBIM7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:59:25 -0500
Date: Fri, 9 Feb 2018 13:59:22 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] livepatch: Support separate list for replaced
 patches.
In-Reply-To: <20180206103424.10829-6-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802091331310.30746@pobox.suse.cz>
References: <20180206103424.10829-1-pmladek@suse.com> <20180206103424.10829-6-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Petr Mladek wrote:

> From: Jason Baron <jbaron@akamai.com>
> 
> We are going to add a feature called atomic replace. It will allow to
> create a patch that would replace all already registered patches.
> 
> The replaced patches will stay registered because they are typically
> unregistered by some package uninstall scripts. But we will remove
> these patches from @klp_patches list to keep the enabled patch
> on the bottom of the stack. Otherwise, we would need to implement
> rather complex logic for moving the patches on the stack. Also
> it would complicate implementation of the atomic replace feature.
> It is not worth it.
> 
> As a result, we will have patches that are registered but that
> are not longer usable. Let's get prepared for this and use
> a better descriptive name for klp_is_patch_registered() function.
> 
> Also create separate list for the replaced patches and allow to
> unregister them. Alternative solution would be to add a flag
> into struct klp_patch. Note that patch->kobj.state_initialized
> is not safe because it can be cleared outside klp_mutex.
> 
> This patch does not change the existing behavior.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Split and renamed klp_is_patch_usable()]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>
> ---
>  kernel/livepatch/core.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index fccb603942f1..11632fe8716a 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -47,6 +47,13 @@ DEFINE_MUTEX(klp_mutex);
>  
>  static LIST_HEAD(klp_patches);
>  
> +/*
> + * List of 'replaced' patches that have been replaced by a patch that has the
> + * 'replace' bit set. When they are added to this list, they are disabled and
> + * can not be re-enabled, but they can be unregistered().
> + */
> +LIST_HEAD(klp_replaced_patches);

It should be static, I think. It is used only in kernel/livepatch/core.c. 
And sparse complains about it.

With that fixed

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
