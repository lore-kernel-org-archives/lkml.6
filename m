Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6897DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C77208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P1ae/JU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C77208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966385AbeFOQrQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:47:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58162 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964992AbeFOQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FPSy7COcdrgPAfZ+GqYL8a9DLfasAs7wcZsItPaiPc8=; b=P1ae/JU4VIJZOQy4gOIQNKLdq
        eR0rNLCBxjNiIfZte3e1aoMf4SFBEUaCAF6psy/u85gunsTjtiIaG0Ygms3pxJBXcZuxolJqlc0dC
        RdujZZLqMMdTC3tSzYj81wjmMXjSJYpAAfSqAKqChDT+0IfhxJImPxtPfg/nqqQjgHoNC6yZlqBW+
        lc5LZQ1e/LcnOSgbEjlFwaz7rxGBSaTWXxqbLx/WzMafQIQ13N2yecazVIwE2lWXO5/o3aY7TSPEl
        qbYlrdcCJd1jj95IRqFzppAECV0pU+cuegZl5VWwg7oAFXSDuA0VufizewPuZZwSpECjJ6dfdjoV+
        FtToVXrZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTrrT-0006W3-QD; Fri, 15 Jun 2018 16:46:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5A352029FA0D; Fri, 15 Jun 2018 18:46:04 +0200 (CEST)
Date:   Fri, 15 Jun 2018 18:46:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v3 2/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
Message-ID: <20180615164604.GD2458@hirez.programming.kicks-ass.net>
References: <20180615120827.3989-1-thellstrom@vmware.com>
 <20180615120827.3989-2-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615120827.3989-2-thellstrom@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 02:08:27PM +0200, Thomas Hellstrom wrote:

> @@ -772,6 +856,25 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
>  	}
>  
>  	list_add_tail(&waiter->list, pos);
> +	if (__mutex_waiter_is_first(lock, waiter))
> +		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
> +
> +	/*
> +	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
> +	 * wound that such that we might proceed.
> +	 */
> +	if (!is_wait_die) {
> +		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
> +
> +		/*
> +		 * See ww_mutex_set_context_fastpath(). Orders setting
> +		 * MUTEX_FLAG_WAITERS (atomic operation) vs the ww->ctx load,
> +		 * such that either we or the fastpath will wound @ww->ctx.
> +		 */
> +		smp_mb__after_atomic();
> +
> +		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
> +	}

I think we want the smp_mb__after_atomic() in the same branch as
__mutex_set_flag(). So something like:

	if (__mutex_waiter_is_first()) {
		__mutex_set_flag();
		if (!is_wait_die)
			smp_mb__after_atomic();
	}

Or possibly even without the !is_wait_die. The rules for
smp_mb__*_atomic() are such that we want it unconditional after an
atomic, otherwise the semantics get too fuzzy.

Alan (rightfully) complained about that a while ago when he was auditing
users.


