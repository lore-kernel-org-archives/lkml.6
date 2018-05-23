Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932977AbeEWNV1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:21:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932844AbeEWNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:21:22 -0400
Date: Wed, 23 May 2018 06:21:19 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-mm@kvack.org, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH 3/8] md: raid5: use refcount_t for reference counting
 instead atomic_t
Message-ID: <20180523132119.GC19987@bombadil.infradead.org>
References: <20180509193645.830-1-bigeasy@linutronix.de>
 <20180509193645.830-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509193645.830-4-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 09:36:40PM +0200, Sebastian Andrzej Siewior wrote:
> refcount_t type and corresponding API should be used instead of atomic_t when
> the variable is used as a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free situations.
> 
> Most changes are 1:1 replacements except for
> 	BUG_ON(atomic_inc_return(&sh->count) != 1);
> 
> which has been turned into
>         refcount_inc(&sh->count);
>         BUG_ON(refcount_read(&sh->count) != 1);

@@ -5387,7 +5387,8 @@ static struct stripe_head *__get_priority_stripe(struct
+r5conf *conf, int group)
                sh->group = NULL;
        }
        list_del_init(&sh->lru);
-       BUG_ON(atomic_inc_return(&sh->count) != 1);
+       refcount_inc(&sh->count);
+	BUG_ON(refcount_read(&sh->count) != 1);
        return sh;
 }


That's the only problematic usage.  And I think what it's really saying is:

	BUG_ON(refcount_read(&sh->count) != 0);
	refcount_set(&sh->count, 1);

With that, this looks like a reasonable use of refcount_t to me.
