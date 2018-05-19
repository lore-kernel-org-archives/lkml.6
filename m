Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeESAbI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 20:31:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeESAbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 20:31:05 -0400
Date: Fri, 18 May 2018 17:31:04 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Roman Kagan <rkagan@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-ID: <20180519003104.GB21615@bombadil.infradead.org>
References: <20180518175025.GD6361@bombadil.infradead.org>
 <20180518202307.GB753@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518202307.GB753@rkaganb.sw.ru>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:23:08PM +0300, Roman Kagan wrote:
> On Fri, May 18, 2018 at 10:50:25AM -0700, Matthew Wilcox wrote:
> > It'd be nice if you cc'd the person who wrote the code you're patching.
> > You'd get a response a lot quicker than waiting until I happened to
> > notice the email in a different forum.
> 
> I sent it to someone called "Matthew Wilcox <mawilcox@microsoft.com>".
> Also I cc'd that guy when I only started to point the finger at IDR as
> the suspected culprit in that syzcaller report.  I thought it was him
> who wrote the code...

I didn't get them ;-(  Sorry.

> > Thanks for finding the situation that leads to the bug.  Your fix is
> > incorrect; it's legitimate to store a NULL value at offset 0, and
> > your patch makes it impossible to delete.  Fortunately, the test-suite
> > covers that case ;-)
> 
> How do you build it?  I wish I had it when debugging but I got linking
> errors due to missing spin_lock_init, so I decided it wasn't up-to-date.

Yeah, I inadvertently broke it with commit
f6bb2a2c0b81 ("xarray: add the xa_lock to the radix_tree_root")

Andrew has a patch to fix it in his tree.  All you need is:

+++ b/tools/include/linux/spinlock.h
@@ -8,6 +8,7 @@
 #define spinlock_t             pthread_mutex_t
 #define DEFINE_SPINLOCK(x)     pthread_mutex_t x = PTHREAD_MUTEX_INITIALIZER;
 #define __SPIN_LOCK_UNLOCKED(x)        (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZ
ER
+#define spin_lock_init(x)      pthread_mutex_init(x, NULL);
 
 #define spin_lock_irqsave(x, f)                (void)f, pthread_mutex_lock(x)
 #define spin_unlock_irqrestore(x, f)   (void)f, pthread_mutex_unlock(x)

> Thanks,
> Roman.
> 
> P.S. I'll forward your message to all the recepients of my patch, to let
> them know it's wrong and you have a better one.

Thanks!
