Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeCONSh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:18:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeCONSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:18:35 -0400
Date: Thu, 15 Mar 2018 06:18:32 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] Improve mutex documentation
Message-ID: <20180315131832.GC9949@bombadil.infradead.org>
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180315115812.GA9949@bombadil.infradead.org>
 <2397831d-71b5-3cc8-9dc4-ce06e2eddfde@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2397831d-71b5-3cc8-9dc4-ce06e2eddfde@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 03:12:30PM +0300, Kirill Tkhai wrote:
> > +/**
> > + * mutex_lock_killable() - Acquire the mutex, interruptible by fatal signals.
> 
> Shouldn't we clarify that fatal signals are SIGKILL only?

It's more complicated than it might seem (... welcome to signal handling!)
If you send SIGINT to a task that's waiting on a mutex_killable(), it will
still die.  I *think* that's due to the code in complete_signal():

        if (sig_fatal(p, sig) &&
            !(signal->flags & SIGNAL_GROUP_EXIT) &&
            !sigismember(&t->real_blocked, sig) &&
            (sig == SIGKILL || !p->ptrace)) {
...
                                sigaddset(&t->pending.signal, SIGKILL);

You're correct that this code only checks for SIGKILL, but any fatal
signal will result in the signal group receiving SIGKILL.

Unless I've misunderstood, and it wouldn't be the first time I've
misunderstood signal handling.
