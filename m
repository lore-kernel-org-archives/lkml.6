Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeBXDWc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 22:22:32 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42373 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeBXDWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 22:22:30 -0500
X-Google-Smtp-Source: AH8x227SxfTmvaajiXVCR93c5dbS9A+HfiRbU/A6OEkI2cxX8H+g4CRD154hcyGeziuhfnvG967hwQ==
Subject: Re: [PATCH] tools/memory-model: update: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
To: Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <Pine.LNX.4.44L0.1802211214070.2032-100000@iolanthe.rowland.org>
 <74dbcbd4-6034-0be9-7674-ccb058de6177@gmail.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ea223820-6a1a-b1a6-58c5-c4c720ef58ea@gmail.com>
Date: Sat, 24 Feb 2018 12:22:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <74dbcbd4-6034-0be9-7674-ccb058de6177@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/02/22 07:29:02 +0900, Akira Yokosawa wrote:
> On 2018/02/22 2:15, Alan Stern wrote:
>> Commit bf28ae562744 ("tools/memory-model: Remove rb-dep,
>> smp_read_barrier_depends, and lockless_dereference") was accidentally
>> merged too early, while it was still in RFC form.  This patch adds in
>> the missing pieces.
>>
>> Akira pointed out some typos in the original patch, and he noted that
>> cheatsheet.txt should be updated to indicate how unsuccessful RMW
>> operations relate to address dependencies.
> 
> My point was to separate unannotated loads from READ_ONCE(), if the
> cheatsheet should concern such accesses as well.
> Unsuccessful RMW operations were brought up by Andrea.
>

Paul, can you amend above paragraph in the change log to something like:

    Akira pointed out some typos in the original patch, and he noted that
    cheatsheet.txt should be updated to indicate READ_ONCE() implies
    address dependency, which invited Andrea's observation that it should
    also be updated to indicate how unsuccessful RMW operations relate to
    address dependencies.

, if Alan and Andrea are OK with the amendment.

Also, please append my Acked-by.

Acked-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira
 
>>
>> Andrea pointed out that the macro for rcu_dereference() in linux.def
>> should now use the "once" annotation instead of "deref".  He also
>> suggested that the comments should mention commit 5a8897cc7631
>> ("locking/atomics/alpha: Add smp_read_barrier_depends() to
>> _release()/_relaxed() atomics") as an important precursor, and he
>> contributed commit cb13b424e986 ("locking/xchg/alpha: Add
>> unconditional memory barrier to cmpxchg()"), another prerequisite.
>>
>> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>> Suggested-by: Akira Yokosawa <akiyks@gmail.com>
>> Suggested-by: Andrea Parri <parri.andrea@gmail.com>
>> Fixes: bf28ae562744 ("tools/memory-model: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference")
>>
> 
> The change itself looks good to me.
> 
> Acked-by: Akira Yokosawa <akiyks@gmail.com>
> 
>        Thanks, Akira
> 
>> ---
>>
>>  tools/memory-model/Documentation/cheatsheet.txt  |    6 +++---
>>  tools/memory-model/Documentation/explanation.txt |    4 ++--
>>  tools/memory-model/linux-kernel.def              |    2 +-
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> Index: usb-4.x/tools/memory-model/Documentation/cheatsheet.txt
>> ===================================================================
>> --- usb-4.x.orig/tools/memory-model/Documentation/cheatsheet.txt
>> +++ usb-4.x/tools/memory-model/Documentation/cheatsheet.txt
>> @@ -1,11 +1,11 @@
>>                                    Prior Operation     Subsequent Operation
>>                                    ---------------  ---------------------------
>>                                 C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
>> -                              __  ----  -  -  ---  ----  -  -  --  --  ---  --
>> +                              --  ----  -  -  ---  ----  -  -  --  --  ---  --
>>  
>>  Store, e.g., WRITE_ONCE()            Y                                       Y
>> -Load, e.g., READ_ONCE()              Y                              Y        Y
>> -Unsuccessful RMW operation           Y                              Y        Y
>> +Load, e.g., READ_ONCE()              Y                          Y   Y        Y
>> +Unsuccessful RMW operation           Y                          Y   Y        Y
>>  rcu_dereference()                    Y                          Y   Y        Y
>>  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
>>  Successful *_release()         C        Y  Y    Y     W                      Y
>> Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
>> ===================================================================
>> --- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
>> +++ usb-4.x/tools/memory-model/Documentation/explanation.txt
>> @@ -826,7 +826,7 @@ A-cumulative; they only affect the propa
>>  executed on C before the fence (i.e., those which precede the fence in
>>  program order).
>>  
>> -read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
>> +read_read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
>>  other properties which we discuss later.
>>  
>>  
>> @@ -1138,7 +1138,7 @@ final effect is that even though the two
>>  program order, it appears that they aren't.
>>  
>>  This could not have happened if the local cache had processed the
>> -incoming stores in FIFO order.  In constrast, other architectures
>> +incoming stores in FIFO order.  By contrast, other architectures
>>  maintain at least the appearance of FIFO order.
>>  
>>  In practice, this difficulty is solved by inserting a special fence
>> Index: usb-4.x/tools/memory-model/linux-kernel.def
>> ===================================================================
>> --- usb-4.x.orig/tools/memory-model/linux-kernel.def
>> +++ usb-4.x/tools/memory-model/linux-kernel.def
>> @@ -13,7 +13,7 @@ WRITE_ONCE(X,V) { __store{once}(X,V); }
>>  smp_store_release(X,V) { __store{release}(*X,V); }
>>  smp_load_acquire(X) __load{acquire}(*X)
>>  rcu_assign_pointer(X,V) { __store{release}(X,V); }
>> -rcu_dereference(X) __load{deref}(X)
>> +rcu_dereference(X) __load{once}(X)
>>  
>>  // Fences
>>  smp_mb() { __fence{mb} ; }
>>
> 
