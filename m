Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeC2Qz5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeC2Qz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:55:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E0E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Thu, 29 Mar 2018 18:55:53 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 10/10] softirq: Remove __ARCH_SET_SOFTIRQ_PENDING
Message-ID: <20180329165552.GC12958@lerouge>
References: <1522290425-22844-1-git-send-email-frederic@kernel.org>
 <1522290425-22844-11-git-send-email-frederic@kernel.org>
 <20180329071619.GO4082@hirez.programming.kicks-ass.net>
 <20180329134745.GA12958@lerouge>
 <20180329140111.GC4043@hirez.programming.kicks-ass.net>
 <20180329140748.GB12958@lerouge>
 <20180329165343.39f4486f@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329165343.39f4486f@mschwideX1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 04:53:43PM +0200, Martin Schwidefsky wrote:
> On Thu, 29 Mar 2018 16:07:49 +0200
> Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > On Thu, Mar 29, 2018 at 04:01:11PM +0200, Peter Zijlstra wrote:
> > > On Thu, Mar 29, 2018 at 03:47:46PM +0200, Frederic Weisbecker wrote:  
> > > > On Thu, Mar 29, 2018 at 09:16:19AM +0200, Peter Zijlstra wrote:  
> > > > > On Thu, Mar 29, 2018 at 04:27:05AM +0200, Frederic Weisbecker wrote:  
> > > > > > The last user of __ARCH_SET_SOFTIRQ_PENDING has been converted to generic
> > > > > > per-cpu softirq mask. We can now remove this conditional.  
> > > > > 
> > > > > This seems like half a cleanup; who still has local_softirq_pending()
> > > > > after this?  
> > > > 
> > > > Only s390 because it uses lowcore to store such cpu data.  
> > > 
> > > Is it worth keeping it there? It seems an aweful shame to keep this
> > > stuff special cased for just the one arch. At the very least this
> > > should've mentioned s390 is special and why.  
> > 
> > Right, I thought well about moving that special case to s390. I can
> > do that in v2.
> 
> The lowcore optimization for softirq_pending field is not really needed,
> just nice to have. But if there is a strong reason to make a common
> definition for it we can certainly do that.

I think there is no need to. Lowcore is faster to access than per-cpu on s390
and we are dealing with a frequently accessed field. Plus lowcore is expected to
be often cache-hot.

But Peter is right that I should move the default implementation of
or_softirq_pending() and set_softirq_pending() to s390 as it's the last
user of these after this patchset.

Thanks.
