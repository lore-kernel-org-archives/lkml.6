Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeC1SDl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:03:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeC1SDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:03:37 -0400
Date: Wed, 28 Mar 2018 20:03:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: Re: [PATCH] docs/memory-barriers.txt: Fix broken DMA vs MMIO
 ordering example
Message-ID: <20180328180316.GN4082@hirez.programming.kicks-ass.net>
References: <1522156287-15169-1-git-send-email-will.deacon@arm.com>
 <20180327150252.GN3675@linux.vnet.ibm.com>
 <c93ed5db-8cfd-1258-3396-62ca2076c44d@codeaurora.org>
 <CA+8MBb+61AhMkbo8xtd3Y0fY8xRUPD+kUsEvWgOz94KGEuovOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+8MBb+61AhMkbo8xtd3Y0fY8xRUPD+kUsEvWgOz94KGEuovOw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 10:57:11AM -0700, Tony Luck wrote:
> On Wed, Mar 28, 2018 at 6:02 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> > +linux-ia64
> > Does IA64 follow this requirement? If not, is implementation planned?
> >
> > "no wmb() before writel()"
> >
> > Linus asked us to get rid of wmb() in front of writel() for UC memory.
> > Just checking that we are not breaking anything for IA64.
> 
> We should be OK on ia64, writel() uses a cast to:
> 
>  *(volatile unsigned int __force *)
> 
> which the compiler takes as a request to use a "st4.rel" instruction
> (meaning "store with release semantics"). So the value stored will
> be visible to anything that follows.

Just to nitpick, regular release semantics don't guarantee anything like
that, but ia64 never actually got around to implementing proper release
and it's a full barrier and thus what you say is true.
