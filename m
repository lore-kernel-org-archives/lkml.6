Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbeBGQJj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:09:39 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:35937 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754685AbeBGQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:09:37 -0500
X-Google-Smtp-Source: AH8x227qCoWNX1WA+STLs1juaGrvWci3HNCzCti8XMlMvgFTVi24NMJh07Pt9jZVLmgcB97ALiHIzqM2WAAFCDhT4EM=
MIME-Version: 1.0
In-Reply-To: <20180207080740.GH2269@hirez.programming.kicks-ass.net>
References: <20180206004903.224390-1-joelaf@google.com> <20180207080740.GH2269@hirez.programming.kicks-ass.net>
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 7 Feb 2018 08:09:36 -0800
Message-ID: <CAJWu+orvHb_-fSgtO0NqCai3PPc7fAe7LqNLVVhYbT+Wi-oATg@mail.gmail.com>
Subject: Re: [PATCH RFC] ashmem: Fix lockdep RECLAIM_FS false positive
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Feb 7, 2018 at 12:07 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 05, 2018 at 04:49:03PM -0800, Joel Fernandes wrote:
>
>> [ 2115.359650] -(1)[106:kswapd0]=================================
>> [ 2115.359665] -(1)[106:kswapd0][ INFO: inconsistent lock state ]
>> [ 2115.359684] -(1)[106:kswapd0]4.9.60+ #2 Tainted: G        W  O
>> [ 2115.359699] -(1)[106:kswapd0]---------------------------------
>> [ 2115.359715] -(1)[106:kswapd0]inconsistent {RECLAIM_FS-ON-W} ->
>> {IN-RECLAIM_FS-W} usage.
>
> Please don't wrap log output, this is unreadable :/

Sorry about that, here's the unwrapped output, I'll fix the commit
message in next rev: https://pastebin.com/e0BNGkaN

>
> Also, the output is from an ancient kernel and doesn't match the current
> code.

Right, however the driver hasn't changed and I don't see immediately
how lockdep handles this differently upstream, so I thought of fixing
it upstream.

>> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
>> index 372ce9913e6d..7e060f32aaa8 100644
>> --- a/drivers/staging/android/ashmem.c
>> +++ b/drivers/staging/android/ashmem.c
>> @@ -32,6 +32,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/mutex.h>
>>  #include <linux/shmem_fs.h>
>> +#include <linux/sched/mm.h>
>>  #include "ashmem.h"
>>
>>  #define ASHMEM_NAME_PREFIX "dev/ashmem/"
>> @@ -446,8 +447,17 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>>       if (!(sc->gfp_mask & __GFP_FS))
>>               return SHRINK_STOP;
>>
>> -     if (!mutex_trylock(&ashmem_mutex))
>> +     /*
>> +      * Release reclaim-fs marking since we've already checked GFP_FS, This
>> +      * will prevent lockdep's reclaim recursion deadlock false positives.
>> +      * We'll renable it before returning from this function.
>> +      */
>> +     fs_reclaim_release(sc->gfp_mask);
>> +
>> +     if (!mutex_trylock(&ashmem_mutex)) {
>> +             fs_reclaim_acquire(sc->gfp_mask);
>>               return -1;
>> +     }
>>
>>       list_for_each_entry_safe(range, next, &ashmem_lru_list, lru) {
>>               loff_t start = range->pgstart * PAGE_SIZE;
>> @@ -464,6 +474,8 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>>                       break;
>>       }
>>       mutex_unlock(&ashmem_mutex);
>> +
>> +     fs_reclaim_acquire(sc->gfp_mask);
>>       return freed;
>>  }
>
> Yuck that is horrible.. so if GFP_FS was set, we bail, but if GFP_FS
> wasn't set, why is fs_reclaim_*() doing anything at all?
>
> That is, __need_fd_reclaim() should return false when !GFP_FS.

So my patch is wrong, very sorry about that. That's why I marked it as
RFC and wanted to get your expert eyes on it.
The bail out happens when GFP_FS is *not* set. Lockdep reports this
issue when GFP_FS is infact set, and we enter this path and acquire
the lock. So lockdep seems to be doing the right thing however by
design it is reporting a false-positive.

The real issue is that the lock being acquired is of the same lock
class and a different lock instance is acquired under GFP_FS that
happens to be of the same class.

So the issue seems to me to be:
Process A          kswapd
---------          ------
acquire i_mutex    Enter RECLAIM_FS

Enter RECLAIM_FS   acquire different i_mutex

Neil tried to fix this sometime back:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg623909.html
but it was kind of NAK'ed.

Any thoughts on how we can fix this?

Thanks Peter,

- Joel
