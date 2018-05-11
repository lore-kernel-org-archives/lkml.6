Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeEKK7g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:59:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39822 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752362AbeEKK7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:59:35 -0400
Date: Fri, 11 May 2018 11:59:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] perf/ring_buffer: ensure atomicity and order of updates
Message-ID: <20180511105931.yyarmtz2gjkbuq2a@lakrids.cambridge.arm.com>
References: <20180510130632.34497-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510130632.34497-1-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 02:06:32PM +0100, Mark Rutland wrote:
> -	smp_wmb(); /* B, matches C */
> -	rb->user_page->data_head = head;
> +	smp_store_release(&rb->user_page->data_head, head); /* B, matches C */

> -	rb->user_page->aux_head = rb->aux_head;
> +	smp_store_release(&rb->user_page->aux_head, rb->aux_head);

> -	rb->user_page->aux_head = rb->aux_head;
> +	smp_store_release(&rb->user_page->aux_head, rb->aux_head);


The kbuild test robot has helpfully discovered another latent bug here.

We assume we can make single-copy-atomic accesses to
{aux,data}_{head,tail}, but this isn't necessarily true on 32-bit
architectures, and smp_store_release() rightly complains at build time.

READ_ONCE() and WRITE_ONCE() "helpfully" make a silent fallback to a
memcpy in this case, so we're broken today, regardless of this change.

I suspect that in practice we get single-copy-atomicity for the 32-bit
halves, and sessions likely produce less than 4GiB of ringbuffer data,
so failures would be rare.

I'm not sure how to fix the ABI here. The same issue applies on the
userspace side, so whatever we do we need to fix both sides.

Thanks,
Mark.
