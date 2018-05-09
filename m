Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934099AbeEIJmI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:42:08 -0400
Received: from foss.arm.com ([217.140.101.70]:41074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933685AbeEIJmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:42:06 -0400
Date: Wed, 9 May 2018 10:41:55 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dvyukov@google.com, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 2/3] kcov: prefault the kcov_area
Message-ID: <20180509094145.4yxx6dkcgu5w7zaz@lakrids.cambridge.arm.com>
References: <20180504135535.53744-1-mark.rutland@arm.com>
 <20180504135535.53744-3-mark.rutland@arm.com>
 <20180508155158.7e6a789d950bcaf957c8c3bf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508155158.7e6a789d950bcaf957c8c3bf@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 03:51:58PM -0700, Andrew Morton wrote:
> On Fri,  4 May 2018 14:55:34 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On many architectures the vmalloc area is lazily faulted in upon first
> > access. This is problematic for KCOV, as __sanitizer_cov_trace_pc
> > accesses the (vmalloc'd) kcov_area, and fault handling code may be
> > instrumented. If an access to kcov_area faults, this will result in
> > mutual recursion through the fault handling code and
> > __sanitizer_cov_trace_pc(), eventually leading to stack corruption
> > and/or overflow.
> > 
> > We can avoid this by faulting in the kcov_area before
> > __sanitizer_cov_trace_pc() is permitted to access it. Once it has been
> > faulted in, it will remain present in the process page tables, and will
> > not fault again.
> > 
> > ...
> >
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -324,6 +324,17 @@ static int kcov_close(struct inode *inode, struct file *filep)
> >  	return 0;
> >  }
> >  
> > +static void kcov_fault_in_area(struct kcov *kcov)
> 
> It would be nice to have a comment here explaining why the function
> exists.
> 
> umm, this?
> 
> --- a/kernel/kcov.c~kcov-prefault-the-kcov_area-fix-fix
> +++ a/kernel/kcov.c
> @@ -324,6 +324,10 @@ static int kcov_close(struct inode *inod
>  	return 0;
>  }
>  
> +/*
> + * fault in a lazily-faulted vmalloc area, to avoid recursion issues if the
> + * vmalloc fault handler itself is instrumented.
> + */

Sounds good to me. Perhaps we want a little more detail, e.g.

/*
 * Fault in a lazily-faulted vmalloc area before it can be used by
 * __santizer_cov_trace_pc(), to avoid recursion issues if any code on
 * the vmalloc fault handling path is instrumented.
 */

>  static void kcov_fault_in_area(struct kcov *kcov)

I also think it might make sense to rename this to kcov_prefault_area(),
so that this doesn't sound like a fault handler, but that's not a big
deal.

Thanks for handling this!

Mark.
