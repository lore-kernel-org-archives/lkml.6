Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932835AbeEWMuS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:50:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44030 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeEWMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:50:15 -0400
Date: Wed, 23 May 2018 14:50:07 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH 3/8] md: raid5: use refcount_t for reference counting
 instead atomic_t
Message-ID: <20180523125007.pbxcxef622cde3jz@linutronix.de>
References: <20180509193645.830-1-bigeasy@linutronix.de>
 <20180509193645.830-4-bigeasy@linutronix.de>
 <20180523123615.GY12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523123615.GY12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-23 14:36:15 [+0200], Peter Zijlstra wrote:
> > Most changes are 1:1 replacements except for
> > 	BUG_ON(atomic_inc_return(&sh->count) != 1);
> 
> That doesn't look right, 'inc_return == 1' implies inc-from-zero, which
> is not allowed by refcount.
> 
> > which has been turned into
> >         refcount_inc(&sh->count);
> >         BUG_ON(refcount_read(&sh->count) != 1);
> 
> And that is racy, you can have additional increments in between.

so do we stay with the atomic* API here or do we extend refcount* API?

Sebastian
