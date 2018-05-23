Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbeEWMgX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:36:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41558 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932070AbeEWMgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:36:22 -0400
Date: Wed, 23 May 2018 14:36:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH 3/8] md: raid5: use refcount_t for reference counting
 instead atomic_t
Message-ID: <20180523123615.GY12217@hirez.programming.kicks-ass.net>
References: <20180509193645.830-1-bigeasy@linutronix.de>
 <20180509193645.830-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509193645.830-4-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Most changes are 1:1 replacements except for
> 	BUG_ON(atomic_inc_return(&sh->count) != 1);

That doesn't look right, 'inc_return == 1' implies inc-from-zero, which
is not allowed by refcount.

> which has been turned into
>         refcount_inc(&sh->count);
>         BUG_ON(refcount_read(&sh->count) != 1);

And that is racy, you can have additional increments in between.
