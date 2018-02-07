Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeBGW1l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:27:41 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:39248 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeBGW1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:27:38 -0500
X-Google-Smtp-Source: AH8x225QSAMaKhZjdi1VWBBPUAklYu455Oh1woz5aNDdW94DeaLMeLPkiR0P2U9GMts7sHw4TWXxfrSVc1LcOCQwtN0=
MIME-Version: 1.0
In-Reply-To: <20180207165802.GC25219@hirez.programming.kicks-ass.net>
References: <20180206004903.224390-1-joelaf@google.com> <20180207080740.GH2269@hirez.programming.kicks-ass.net>
 <CAJWu+orvHb_-fSgtO0NqCai3PPc7fAe7LqNLVVhYbT+Wi-oATg@mail.gmail.com> <20180207165802.GC25219@hirez.programming.kicks-ass.net>
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 7 Feb 2018 14:27:37 -0800
Message-ID: <CAJWu+opo+mE-ZAsi3=u8ogUYurVM0_qaHi7keZJ6h0Sfa7oULQ@mail.gmail.com>
Subject: Re: [PATCH RFC] ashmem: Fix lockdep RECLAIM_FS false positive
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        Neil Brown <neilb@suse.com>, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Feb 7, 2018 at 8:58 AM, Peter Zijlstra <peterz@infradead.org> wrote:
[...]
>
>> Lockdep reports this issue when GFP_FS is infact set, and we enter
>> this path and acquire the lock. So lockdep seems to be doing the right
>> thing however by design it is reporting a false-positive.
>
> So I'm not seeing how its a false positive. fs/inode.c sets a different
> lock class per filesystem type. So recursing on an i_mutex within a
> filesystem does sound dodgy.

But directory inodes and file inodes in the same filesystem share the
same lock class right? All the issues I've seen (both our's and
Neil's) are similar in that a directory inode's lock is held followed
by a RECLAIM_FS allocation, and in parallel to that, memory reclaim
involving the same FS is going on in another thread. In the splat I
shared, during the VFS lookup- the d_alloc is called with an inode's
lock held (I am guessing this the lock of the directory inode which is
locked just before the d_alloc), and in parallel (kswapd or some other
thread) is doing memory reclaim.

>> The real issue is that the lock being acquired is of the same lock
>> class and a different lock instance is acquired under GFP_FS that
>> happens to be of the same class.
>>
>> So the issue seems to me to be:
>> Process A          kswapd
>> ---------          ------
>> acquire i_mutex    Enter RECLAIM_FS
>>
>> Enter RECLAIM_FS   acquire different i_mutex
>
> That's not a false positive, that's a 2 process way of writing i_mutex
> recursion.

Yes, but I mention false positive since the kswapd->ashmem_shrink_scan
path can never acquire the mutex of a directory inode AFAIK. So from
that perspective it seems a false-positive.

>
> What are the rules of acquiring two i_mutexes within a filesystem?
>

I am not fully sure. I am CC'ing Ted and linux-fs-devel as well for
any input on this question.

>> Neil tried to fix this sometime back:
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg623909.html
>> but it was kind of NAK'ed.
>
> So that got nacked because Neil tried to fix it in the vfs core. Also
> not entirely sure that's the same problem.

Yes, a similar fix was proposed internally here, I would say the
signature of the problem reported there is quite similar (its just
that there its nfsd mentioned as doing the reclaim instead of kswapd).

thanks,

- Joel

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg623986.html
