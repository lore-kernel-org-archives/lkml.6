Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbeEWQ2E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:28:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933476AbeEWQ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:28:03 -0400
Date: Wed, 23 May 2018 18:27:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
Message-ID: <20180523162741.GU12198@hirez.programming.kicks-ass.net>
References: <50481b83-4c03-f354-bd11-cef7aecdd85f@embeddedor.com>
 <b5e5e160-6ac7-87c8-af1a-4eb88f1f020d@embeddedor.com>
 <CAPcyv4iO67AG5ytc7gRBTnu6V8bdTOMb9eBwjGJtkGpMLKkpwg@mail.gmail.com>
 <3d2e5771-c2c9-6e45-3e85-21c0bc86876e@embeddedor.com>
 <58df7ae3-8ef0-4f42-9ab2-b551d2ffff00@embeddedor.com>
 <161a0513-1029-a76c-f967-1e606081599d@embeddedor.com>
 <CAPcyv4i6zOJZakNVW=y8NyUFB1EzOxBtoOGVhWCwysuTi6grvg@mail.gmail.com>
 <112349fb-837c-7b91-e256-a1c443710150@embeddedor.com>
 <20180523090840.GU12217@hirez.programming.kicks-ass.net>
 <20180523150737.ycuulapggtu3hpc3@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523150737.ycuulapggtu3hpc3@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 04:07:37PM +0100, Mark Rutland wrote:
> I think that either way, we have a potential problem if the compiler
> generates a branch dependent on the result of validate_index_nospec().
> 
> In that case, we could end up with codegen approximating:
> 
> 	bool safe = false;
> 
> 	if (idx < bound) {
> 		idx = array_index_nospec(idx, bound);
> 		safe = true;
> 	}
> 
> 	// this branch can be mispredicted
> 	if (safe) {
> 		foo = array[idx];
> 	}
> 
> ... and thus we lose the nospec protection.

I was assuming the compiler would not do that, that's pretty stupid
code-gen. But you're right in calling that out, because I think it's
entirely in it's right to do that :/

> I also suspect that compiler transformations mean that this might
> already be the case for patterns like:
> 
> 	if (idx < bound)  {
> 		safe_idx = array_index_nospec(idx, bound)];
> 		...
> 		foo = array[safe_idx];
> 	}
> 
> ... if the compiler can transform that to something like:
> 
> 	if (idx < bound) {
> 		idx = array_index_nospec(idx, bound);
> 	}
> 
> 	// can be mispredicted
> 	if (idx < bound) {
> 		foo = array[idx];
> 	}
> 
> ... which I think a compiler might be capable of, depending on the rest
> of the function body (e.g. if there's a common portion shared with the
> else case).
> 
> I'll see if I can trigger that in a test case. :/

*groan*...
