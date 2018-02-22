Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeBVOyl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:54:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeBVOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:54:37 -0500
Date: Thu, 22 Feb 2018 15:54:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 06/17] lockdep: Support deadlock
 detection for recursive read in check_noncircular()
Message-ID: <20180222145434.GS25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-7-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222070904.548-7-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:08:53PM +0800, Boqun Feng wrote:

> +static inline int hlock_conflict(struct lock_list *entry, void *data)
> +{
> +	struct held_lock *hlock = (struct held_lock *)data;
> +
> +	return hlock_class(hlock) == entry->class &&
> +	       (hlock->read != 2 || !entry->is_rr);
> +}

Bah, brain hurts.

So before we add prev -> this, relation, we check if there's a this ->
prev relation already in the graph -- if so that would be a problem.

The above function has @data == @prev (__bfs_forward starts at @this,
looking for @prev), and the above patch augments the 'class_equal' test
with @prev not having read==2 or @entry not having xr;

This is because.... (insert brain hurt)
