Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeEOLGj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:06:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752379AbeEOLGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:06:38 -0400
Date: Tue, 15 May 2018 13:06:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as
 non-spinnable in percpu_rwsem_release()
Message-ID: <20180515110632.GA14527@redhat.com>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
 <1526326267-22501-3-git-send-email-longman@redhat.com>
 <20180515085111.GW12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515085111.GW12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15, Peter Zijlstra wrote:
>
> So what's wrong with adding:
>
> 	if (!read)
> 		sem->rw_sem.owner = current;

Agreed, I have already suggested this change twice. Except we obviously
need to check CONFIG_RWSEM_SPIN_ON_OWNER (->owner doesn't exists otherwise)
or even CONFIG_DEBUG_RWSEMS to make the purpose more clear.

> Afaict the whole .owner=NULL thing in release already stops the spinners

Not really, the new writer will spin in this case, afaics.

But this is another problem and probably we do not care. The new writer is
almost impossible in this particular case, another freeze_super() should
notice frozen != SB_UNFROZEN and return EBUSY.

> and the above 'fixes' the debug splat.

Yes.

Waiman, can't we trivially fix the problem first? Then we can add the helpers
and think about other improvements.

Oleg.
