Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeCLJNF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:13:05 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43740 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeCLJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:13:04 -0400
X-Google-Smtp-Source: AG47ELurHuF+UYySYAC8PFnaH6c0Fc+sdYjQsUZbg6uW1uJVfWgU1wmg9FpjNt3h1BkmDxIEM4Bwo9pB3Mq5n5OmAZ8=
MIME-Version: 1.0
In-Reply-To: <20180312085646.GE4064@hirez.programming.kicks-ass.net>
References: <CAJDTihwMgUqjK6YL2M_WZY4VBaifVYgNvdZOF_fNrnk_p27Kvw@mail.gmail.com>
 <20180312054412.yqyde34ly3kjoajj@tardis> <CAJDTihxxhy7zmhTJ-ky4wvMby_o9y8UOcs9R1dABN7NccekAiQ@mail.gmail.com>
 <20180312085600.aczjkpn73axzs2sb@tardis> <20180312085646.GE4064@hirez.programming.kicks-ass.net>
From: =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date: Mon, 12 Mar 2018 17:13:03 +0800
Message-ID: <CAJDTihyP96H6XTh5M17uMbMHxz8YjFZ89u0YsBGsRpR+BaEU_Q@mail.gmail.com>
Subject: Re: smp_mb__after_spinlock requirement too strong?
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>, will.deacon@arm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com, mingo@kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com, benh@kernel.crashing.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 4:56 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 12, 2018 at 04:56:00PM +0800, Boqun Feng wrote:
>> So I think the purpose of smp_mb__after_spinlock() is to provide RCsc
>> locks, it's just the comments before that may be misleading. We want
>> RCsc locks in schedule code because we want writes in different critical
>> section are ordered even outside the critical sections, for case like:
>>
>>       CPU 0           CPU 1           CPU 2
>>
>>       {A =0 , B = 0}
>>       lock(rq0);
>>       write A=1;
>>       unlock(rq0);
>>
>>                       lock(rq0);
>>                       read A=1;
>>                       write B=2;
>>                       unlock(rq0);
>>
>>                                       read B=2;
>>                                       smp_rmb();
>>                                       read A=1;
>>
>> I think we need to fix the comments rather than loose the requirement.
>> Peter?
>
> Yes, ISTR people relying on schedule() being RCsc, and I just picked a
> bad exmaple.

Hi, Peter,
If the fixed comment could point out where this RCsc is used, it will be great.
