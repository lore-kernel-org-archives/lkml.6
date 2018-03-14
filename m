Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeCNT3E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:29:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751700AbeCNT3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:29:01 -0400
Date: Wed, 14 Mar 2018 14:28:57 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Initialize shadow variables by init
 function safely
Message-ID: <20180314192857.yfdk2uwn4okuzlfh@treble>
References: <20180313155448.1998-1-pmladek@suse.com>
 <20180313155448.1998-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313155448.1998-2-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 04:54:47PM +0100, Petr Mladek wrote:
> The existing API allows to pass a sample data to initialize the shadow
> data. It works well when the data are position independent. But it fails
> miserably when we need to set a pointer to the shadow structure itself.
> 
> Unfortunately, we might need to initialize the pointer surprisingly
> often because of struct list_head. It is even worse because the list
> might be hidden in other common structures, for example, struct mutex,
> struct wait_queue_head.

Can you provide a specific example in the changelog of where this was
needed?

> This patch makes the API more safe. A custom init function and data
> are passed to klp_shadow_*alloc() functions instead of the sample data.
> 
> Note that the init_data are not longer a template for the shadow->data.
> It might point to any data that might be necessary when the init
> function is called.
> 
> In addition, the newly allocated shadow structure is initialized
> only when it is really used.

I don't understand this sentence.  It makes it sound like the init
function is called when you do klp_shadow_get().  However, looking at
the code, the init function is always called after allocation.

> For this, the init function must be
> called under klp_shadow_lock. On one hand, this adds a risk of
> ABBA deadlocks. On the other hand, it allows to do some operations
> safely. For example, we could add the new structure into an
> existing list.

> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 4754f01c1abb..fc7c64ce0992 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -186,11 +186,20 @@ static inline bool klp_have_reliable_stack(void)
>  	       IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
>  }
>  
> +struct klp_shadow;

Why is this forward struct declaration needed?

> @@ -150,6 +145,23 @@ static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
>  		goto exists;
>  	}
>  
> +	new_shadow->obj = obj;
> +	new_shadow->id = id;
> +
> +	if (init_func) {
> +		int err;
> +
> +		err = init_func(obj, new_shadow->data, init_data);

Am I hallucinating, or will new_shadow->data always be NULL?  How did it
even work before?

-- 
Josh
