Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031759AbeBNWUo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:20:44 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33454 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:20:42 -0500
X-Google-Smtp-Source: AH8x225YcN6ZzKYXc5XLkcjNM7mHc3DxHmLc8QfW7f2QLrh4J7j6xVvIjaAhFoQMWXHyUBtO/T8jAw==
Subject: Re: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-"
 -> "_")
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
 <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
 <a788e08d-eccb-0aec-6aa5-944e5321e5c6@gmail.com>
 <20180210010703.GE3617@linux.vnet.ibm.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <0ad5ff99-32e9-df65-70d3-ba4e9ec0f6c9@gmail.com>
Date: Thu, 15 Feb 2018 07:20:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180210010703.GE3617@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/02/09 17:07:03 -0800, Paul E. McKenney wrote:
> On Sat, Feb 10, 2018 at 08:46:25AM +0900, Akira Yokosawa wrote:
>> >From 7c1f497a9a51e8db1a94c8a7ef0b74b235aaab88 Mon Sep 17 00:00:00 2001
>> From: Akira Yokosawa <akiyks@gmail.com>
>> Date: Fri, 9 Feb 2018 04:51:05 -0800
>> Subject: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-" -> "_")
>>
>> As of herd7 7.47, these '-'s are not permitted and end up in
>> errors such as:
>>
>>     File "./linux-kernel.def", line 44, characters 29-30:
>>     unexpected '-' (in macros)
>>
>> Partial revert of commit 2d5fba7782d6 ("linux-kernel*: Make RCU
>> identifiers match ASPLOS paper") in the repository at
>> https://github.com/aparri/memory-model can restore the compatibility
>> with herd7 7.47.
>>
>> Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
>> Suggested-by: Andrea Parri <parri.andrea@gmail.com>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> ---
>> Paul,
>>
>> FWIW, this is a squashed version relative to patch 07/10 in the RFC series.
> 
> Thank you, Akira!
> 
> I am going to hold off on this for a bit to see if we can instead get
> a new release of herd7, but if we can't. this might well be a very good
> way to go.

So, herdtools7.7.48 is now available by "opam update; opam upgrade".
Maybe mentioning the required version of herdtools7 in README would help.

One glitch I'm aware of is one of the output of klitmus7 fails to
compile on kernels prior to 4.14, because of smp_mb__after_spinlock()
used in Z6.0+pooncelock+poonceLock+pombonce.litmus.

And there is a question I want to ask.

Z6.0+pooncelock+pooncelock+pombonce.litmus, which doesn't have
smp_mb__after_spinlock(), has a comment of:

(*
 * Result: Never
 *
 * This example demonstrates that a pair of accesses made by different
 * processes each while holding a given lock will not necessarily be
 * seen as ordered by a third process not holding that lock.
 *)

The result was changed from "Sometimes" to "Never" in response to
Alan's feedback the other day, but the following comment indicates
the result should be "Sometimes". And the current model gives the
result of "Sometimes".

As I have no idea of the pending patches, I'd like to know once
the pending patches are applied, would 
Z6.0+pooncelock+pooncelock+pombonce.litmus and
Z6.0+pooncelock+poonceLock+pombonce.litmus become identical?

    Thanks, Akira

> 
> 							Thanx, Paul
[...]
d_lock*)  ||
>> +		'rcu_unlock (*rcu_read_unlock*) ||
>> +		'sync_rcu (*synchronize_rcu*) ||
>>  		'before_atomic (*smp_mb__before_atomic*) ||
>>  		'after_atomic (*smp_mb__after_atomic*) ||
>>  		'after_spinlock (*smp_mb__after_spinlock*)
>> @@ -35,8 +35,8 @@ instructions F[Barriers]
>>
>>  (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
>>  let matched = let rec
>> -	    unmatched-locks = Rcu-lock \ domain(matched)
>> -	and unmatched-unlocks = Rcu-unlock \ range(matched)
>> +	    unmatched-locks = Rcu_lock \ domain(matched)
>> +	and unmatched-unlocks = Rcu_unlock \ range(matched)
>>  	and unmatched = unmatched-locks | unmatched-unlocks
>>  	and unmatched-po = [unmatched] ; po ; [unmatched]
>>  	and unmatched-locks-to-unlocks =
>> @@ -46,8 +46,8 @@ let matched = let rec
>>  	in matched
>>
>>  (* Validate nesting *)
>> -flag ~empty Rcu-lock \ domain(matched) as unbalanced-rcu-locking
>> -flag ~empty Rcu-unlock \ range(matched) as unbalanced-rcu-locking
>> +flag ~empty Rcu_lock \ domain(matched) as unbalanced-rcu-locking
>> +flag ~empty Rcu_unlock \ range(matched) as unbalanced-rcu-locking
>>
>>  (* Outermost level of nesting only *)
>>  let crit = matched \ (po^-1 ; matched ; po^-1)
>> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
>> index babe2b3..d0085d5 100644
>> --- a/tools/memory-model/linux-kernel.cat
>> +++ b/tools/memory-model/linux-kernel.cat
>> @@ -32,7 +32,7 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
>>  	([M] ; fencerel(Before_atomic) ; [RMW] ; po? ; [M]) |
>>  	([M] ; po? ; [RMW] ; fencerel(After_atomic) ; [M]) |
>>  	([M] ; po? ; [LKW] ; fencerel(After_spinlock) ; [M])
>> -let gp = po ; [Sync-rcu] ; po?
>> +let gp = po ; [Sync_rcu] ; po?
>>
>>  let strong-fence = mb | gp
>>
>> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
>> index a397387..fc08371 100644
>> --- a/tools/memory-model/linux-kernel.def
>> +++ b/tools/memory-model/linux-kernel.def
>> @@ -41,10 +41,10 @@ spin_unlock(X) { __unlock(X) ; }
>>  spin_trylock(X) __trylock(X)
>>
>>  // RCU
>> -rcu_read_lock() { __fence{rcu-lock}; }
>> -rcu_read_unlock() { __fence{rcu-unlock};}
>> -synchronize_rcu() { __fence{sync-rcu}; }
>> -synchronize_rcu_expedited() { __fence{sync-rcu}; }
>> +rcu_read_lock() { __fence{rcu_lock}; }
>> +rcu_read_unlock() { __fence{rcu_unlock};}
>> +synchronize_rcu() { __fence{sync_rcu}; }
>> +synchronize_rcu_expedited() { __fence{sync_rcu}; }
>>
>>  // Atomic
>>  atomic_read(X) READ_ONCE(*X)
>> -- 
>> 2.7.4
>>
>>
> 
