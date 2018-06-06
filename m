Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZtDzcTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5818D607E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeFFOBH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeFFOBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:01:06 -0400
Date: Wed, 6 Jun 2018 16:00:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/7] atomics/tty: add missing atomic_long_t * cast
Message-ID: <20180606140042.GA8865@kroah.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-2-mark.rutland@arm.com>
 <20180605120021.GH12258@hirez.programming.kicks-ass.net>
 <20180605142051.GB12925@kroah.com>
 <20180605144304.GW12180@hirez.programming.kicks-ass.net>
 <20180605145334.GA12235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605145334.GA12235@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:53:34PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 05, 2018 at 04:43:04PM +0200, Peter Zijlstra wrote:
> 
> > I can make a proper patch, hold on.
> 
> ---
> Subject: atomic/tty: Fix up atomic abuse in ldsem
> 
> Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> working after making the atomic_long interface type safe.
> 
> Needing casts is bad form, which made me look at the code. There are no
> ld_semaphore::count users outside of these functions so there is no
> reason why it can not be an atomic_long_t in the first place, obviating
> the need for this cast.
> 
> That also ensures the loads use atomic_long_read(), which implies (at
> least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> 
> When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> very thin (the only difference is not changing *old on success, which
> most callers don't seem to care about).
> 
> So rework the whole thing to use atomic_long_t and its accessors
> directly.
> 
> While there, fixup all the horrible comment styles.
> 
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good, I'll queue this up after 4.18-rc1 is out, thanks.

greg k-h
