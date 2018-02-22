Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933567AbeBVRrE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:47:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933498AbeBVRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:47:01 -0500
Date: Thu, 22 Feb 2018 18:46:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 08/17] lockdep: Fix recursive read
 lock related safe->unsafe detection
Message-ID: <20180222174654.GW25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-9-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222070904.548-9-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:08:55PM +0800, Boqun Feng wrote:
> There are four cases for recursive read lock realted deadlocks:
> 
> (--(X..Y)--> means a strong dependency path starts with a --(X*)-->
> dependency and ends with a --(*Y)-- dependency.)
> 
> 1.	An irq-safe lock L1 has a dependency --(*..*)--> to an
> 	irq-unsafe lock L2.
> 
> 2.	An irq-read-safe lock L1 has a dependency --(N..*)--> to an
> 	irq-unsafe lock L2.
> 
> 3.	An irq-safe lock L1 has a dependency --(*..N)--> to an
> 	irq-read-unsafe lock L2.
> 
> 4.	An irq-read-safe lock L1 has a dependency --(N..N)--> to an
> 	irq-read-unsafe lock L2.
> 
> The current check_usage() only checks 1) and 2), so this patch adds
> checks for 3) and 4) and makes sure when find_usage_{back,for}wards find
> an irq-read-{,un}safe lock, the traverse path should ends at a
> dependency --(*N)-->. Note when we search backwards, --(*N)--> indicates
> a real dependency --(N*)-->.

This adds 4 __bfs() searches for every new link.

Can't we make the existing traversals smarter?
