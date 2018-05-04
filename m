Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeEDOgW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:36:22 -0400
Received: from foss.arm.com ([217.140.101.70]:54514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeEDOgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:36:21 -0400
Date: Fri, 4 May 2018 15:36:17 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dvyukov@google.com, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 3/3] sched/core / kcov: avoid kcov_area during task switch
Message-ID: <20180504143617.5smet67tomygchuu@lakrids.cambridge.arm.com>
References: <20180504135535.53744-1-mark.rutland@arm.com>
 <20180504135535.53744-4-mark.rutland@arm.com>
 <9dbd4703-5d79-0f3c-306c-5d50a757c11b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dbd4703-5d79-0f3c-306c-5d50a757c11b@virtuozzo.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 05:32:26PM +0300, Andrey Ryabinin wrote:
> On 05/04/2018 04:55 PM, Mark Rutland wrote:
> 
> > +#define kcov_prepare_switch(t)			\
> > +do {						\
> > +	(t)->kcov_mode |= KCOV_IN_CTXSW;	\
> > +} while (0)
> > +
> > +#define kcov_finish_switch(t)			\
> > +do {						\
> > +	(t)->kcov_mode &= ~KCOV_IN_CTXSW;	\
> > +} while (0)
> > +
> 
> Why macros?

I can't use static inline functions without a circular include
dependency between <linux/sched.h> and <linux/kcov.h>, since the
definition of task_struct uses things defined in <linux/kcov.h>.

Thanks,
Mark.
