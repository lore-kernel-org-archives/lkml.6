Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDIOCT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:02:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:47724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeDIOCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:02:17 -0400
Date: Mon, 9 Apr 2018 16:02:15 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] livepatch: Add an extra flag to distinguish registered
 patches
In-Reply-To: <20180323120028.31451-5-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1804091556110.20943@pobox.suse.cz>
References: <20180323120028.31451-1-pmladek@suse.com> <20180323120028.31451-5-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Petr Mladek wrote:

> The initial implementation of the atomic replace feature keeps the replaced
> patches on the stack. But people would like to remove the replaced patches
> from different reasons that will be described in the following patch.
> 
> This patch is just a small preparation step. We will need to keep
> the replaced patches registered even when they are not longer on the stack.

s/not longer/no longer/

> It is because they are typically unregistered by the module exit script.
> 
> Therefore we need to detect the registered patches another way. 

"in another way", "differently"?

> We could
> not use kobj.state_initialized because it is racy. The kobject is destroyed
> by an asynchronous call and could not be synchronized using klp_mutex.
> 
> This patch solves the problem by adding a flag into struct klp_patch.
> It is manipulated under klp_mutex and therefore it is safe. It is easy
> to understand and it is enough in most situations.
> 
> The function klp_is_patch_registered() is not longer needed. Though

s/not longer/no longer/

s/Though/So/ ?

> it was renamed to klp_is_patch_on_stack() and used in __klp_enable_patch()
> as a new sanity check.
> 
> This patch does not change the existing behavior.

In my opinion it could be easier for a review to squash the patch into the 
next one.

> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: Jason Baron <jbaron@akamai.com>
> ---
>  include/linux/livepatch.h |  2 ++
>  kernel/livepatch/core.c   | 24 ++++++++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index f28af280f9e0..d6e6d8176995 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -150,6 +150,7 @@ struct klp_object {
>   * @list:	list node for global list of registered patches
>   * @kobj:	kobject for sysfs resources
>   * @obj_list:	dynamic list of the object entries
> + * @registered: reliable way to check registration status
>   * @enabled:	the patch is enabled (but operation may be incomplete)
>   * @finish:	for waiting till it is safe to remove the patch module
>   */
> @@ -163,6 +164,7 @@ struct klp_patch {
>  	struct list_head list;
>  	struct kobject kobj;
>  	struct list_head obj_list;
> +	bool registered;
>  	bool enabled;
>  	struct completion finish;
>  };
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 18c400bd9a33..70c67a834e9a 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -45,6 +45,11 @@
>   */
>  DEFINE_MUTEX(klp_mutex);
>  
> +/*
> + * Stack of patches. It defines the order in which the patches can be enabled.
> + * Only patches on this stack might be enabled. New patches are added when
> + * registered. They are removed when they are unregistered.
> + */
>  static LIST_HEAD(klp_patches);
>  
>  static struct kobject *klp_root_kobj;
> @@ -97,7 +102,7 @@ static void klp_find_object_module(struct klp_object *obj)
>  	mutex_unlock(&module_mutex);
>  }
>  
> -static bool klp_is_patch_registered(struct klp_patch *patch)
> +static bool klp_is_patch_on_stack(struct klp_patch *patch)
>  {
>  	struct klp_patch *mypatch;
>  
> @@ -378,7 +383,7 @@ int klp_disable_patch(struct klp_patch *patch)
>  
>  	mutex_lock(&klp_mutex);
>  
> -	if (!klp_is_patch_registered(patch)) {
> +	if (!patch->registered) {

I don't see any actual problem, but I'd feel safer if we preserve 
klp_is_patch_on_stack() even somewhere in disable path.

Miroslav
