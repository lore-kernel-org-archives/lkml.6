Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCNT1F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:27:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750779AbeCNT1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:27:04 -0400
Date: Wed, 14 Mar 2018 15:27:02 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Nicolai Stange <nstange@suse.de>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Initialize shadow variables by init
 function safely
Message-ID: <20180314192702.h6fvqoo7myt426ww@redhat.com>
References: <20180313155448.1998-1-pmladek@suse.com>
 <20180313155448.1998-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313155448.1998-2-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
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
> 
> This patch makes the API more safe. A custom init function and data
> are passed to klp_shadow_*alloc() functions instead of the sample data.

Yup, this looks kinda familiar, I remember tinkering with the same idea
last year [1] before settling on the simpler API.

[1] https://github.com/torvalds/linux/compare/master...joe-lawrence:shadow_variables_v2_c

> Note that the init_data are not longer a template for the shadow->data.
> It might point to any data that might be necessary when the init
> function is called.

I'm not opposed to changing the API, but I was wondering if you had
thought about expanding it as an alternative? 

When working on this last summer, I remember holding onto to some less
than intuitive naming conventions so that I could support a basic API
and an extended API with bells and whistles like this patchset
implements.  It didn't seem too difficult to layer the basic API ontop
of one like this (see [1] for example), so maybe that's an option to
keep basic shadow variable usage a little simpler.  /two cents

> In addition, the newly allocated shadow structure is initialized
> only when it is really used. For this, the init function must be
> called under klp_shadow_lock. On one hand, this adds a risk of
> ABBA deadlocks. On the other hand, it allows to do some operations
> safely. For example, we could add the new structure into an
> existing list.
> 
> Reported-by: Nicolai Stange <nstange@suse.de>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  Documentation/livepatch/shadow-vars.txt   | 32 +++++++++++++++------
>  include/linux/livepatch.h                 | 17 ++++++++---
>  kernel/livepatch/shadow.c                 | 48 +++++++++++++++++++++----------
>  samples/livepatch/livepatch-shadow-fix1.c | 19 +++++++++++-
>  samples/livepatch/livepatch-shadow-fix2.c |  6 ++--
>  5 files changed, 89 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/livepatch/shadow-vars.txt b/Documentation/livepatch/shadow-vars.txt
> [ ... snip ...]
> @@ -148,16 +154,24 @@ shadow variables to parents already in-flight.
>  For commit 1d147bfa6429, a good spot to allocate a shadow spinlock is
>  inside ieee80211_sta_ps_deliver_wakeup():
>  
> +int ps_lock_shadow_init(void *obj, void *shadow_data, void *data)
> +{
> +	spinlock_t *lock = shadow_data;
> +
> +	spin_lock_init(lock);
> +	return 0;
> +}
> +
>  #define PS_LOCK 1
>  void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta)
>  {
> -	DEFINE_SPINLOCK(ps_lock_fallback);
>  	spinlock_t *ps_lock;
>  
>  	/* sync with ieee80211_tx_h_unicast_ps_buf */
>  	ps_lock = klp_shadow_get_or_alloc(sta, PS_LOCK,
> -			&ps_lock_fallback, sizeof(ps_lock_fallback),
> -			GFP_ATOMIC);
> +			sizeof(ps_lock_fallback), GFP_ATOMIC,

I think this should be "sizeof(*ps_lock)" here since we've removed the
ps_lock_fallback.

> +			ps_lock_shadow_init, NULL);
> +
>  	if (ps_lock)
>  		spin_lock(ps_lock);

The rest of this patchset looks pretty good.  I gave the samples a
test-run and they still operate as advertised.  Perhaps shadow variables
are another candidate for some kind of kselftest?

Regards,

-- Joe
