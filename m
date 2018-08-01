Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34177C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF52020840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNyx0kS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF52020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbeHAKz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:55:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38564 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388904AbeHAKz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:55:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so10516192pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e+WzGxbpUef5VVCoOYR6c5vYSjQnumwynJYFww+jQ/Q=;
        b=QNyx0kS4wI7KeDf5N3bKWZMtcjHev2t4xxeYqyyrkcbc+8VmoS7YwUPj6/hyN5LhbQ
         +8fDwhOjh106CwV2yWqHjqz/1toaSYBarZI2n58FiEmREVE5CSZNrk4H1tnz7yo0UrOj
         fw5TSkeBsxBK83J18urXN7d3fxQWhXP4dvgvJjTi9QcWx+Zf9bncFnAN8gwbrGV0tGU2
         PKMLIcO4Zfsyli73ephCuz1Fmn7qg0MFICMRqudgEPYy3Je2/IxP0EAHuk4E2Wds7Zuw
         WG9fxWESrgBsmrlu76CVWWPu4HYLN3IIbQ5vYfcYjsudgSKhRNnCiWTZHS3dtlUM2G8P
         sEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e+WzGxbpUef5VVCoOYR6c5vYSjQnumwynJYFww+jQ/Q=;
        b=UOrhgimUe1O5mf7QdfRBKhgYKeAvZh5l/VKG/gDnEP2/w5XClSRXrGmoaOhWMfcs9l
         wHxNiRbzEhdGG8r3umi22DEXku1yDH6bdmkYC4TLrdD62EjPyeEN4SCdhEENLrh5uACb
         cF7rqSCKG7ArsC/kogmjHaW46OR27R+7FR72yQZyCyVW+luHZv5CVuvfDBrIaQE90bmV
         6BUui/C1bnVcVIQaweFUlFg+rAbDfXv79RsHxnlsQZFhNs5JntXouRxdDlLVw9VERAfN
         xgXZwbeI4cq7aerka0uikjQQNNmudKcM+0mG/Woavvk3hG5TcoZy22rJXFYRsnClmgws
         ymlA==
X-Gm-Message-State: AOUpUlFp3T9HOmro7ocvKgZeoO5zF8MkcguTD26HRvQyvtGEQNG5kwyj
        fTGWDIL4L1hqdQOcR+pSAgMnFYst8WVjjCzIxHzovA==
X-Google-Smtp-Source: AAOMgpezFBebRzboYC6e/ChP+jBiq7Ra9VkwF7BhQkwma9g+nMLD5YRh4gQm/xYE/tVdb2UyMNehcTmqLwg1+L4k5q4=
X-Received: by 2002:a63:c046:: with SMTP id z6-v6mr15226111pgi.114.1533114642515;
 Wed, 01 Aug 2018 02:10:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 02:10:22
 -0700 (PDT)
In-Reply-To: <CACT4Y+aYZumcc-Od5T1AnP4mwn8-FaWfxvfb93MnNwQPqG8TDw@mail.gmail.com>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com> <CACT4Y+aYZumcc-Od5T1AnP4mwn8-FaWfxvfb93MnNwQPqG8TDw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 11:10:22 +0200
Message-ID: <CACT4Y+ZkgqDT77dshHg+hBtc9YPW-eZ8wVQA9LTDQ6q_y99oiQ@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 10:46 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Jul 31, 2018 at 8:51 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Tue, Jul 31, 2018 at 10:49 AM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> So the re-use might initialize the fields lazily, not necessarily using a ctor.
>>
>> In particular, the pattern that nf_conntrack uses looks like it is safe.
>>
>> If you have a well-defined refcount, and use "atomic_inc_not_zero()"
>> to guard the speculative RCU access section, and use
>> "atomic_dec_and_test()" in the freeing section, then you should be
>> safe wrt new allocations.
>>
>> If you have a completely new allocation that has "random stale
>> content", you know that it cannot be on the RCU list, so there is no
>> speculative access that can ever see that random content.
>>
>> So the only case you need to worry about is a re-use allocation, and
>> you know that the refcount will start out as zero even if you don't
>> have a constructor.
>>
>> So you can think of the refcount itself as always having a zero
>> constructor, *BUT* you need to be careful with ordering.
>>
>> In particular, whoever does the allocation needs to then set the
>> refcount to a non-zero value *after* it has initialized all the other
>> fields. And in particular, it needs to make sure that it uses the
>> proper memory ordering to do so.
>>
>> And in this case, we have
>>
>>   static struct nf_conn *
>>   __nf_conntrack_alloc(struct net *net,
>>   {
>>         ...
>>         atomic_set(&ct->ct_general.use, 0);
>>
>> which is a no-op for the re-use case (whether racing or not, since any
>> "inc_not_zero" users won't touch it), but initializes it to zero for
>> the "completely new object" case.
>>
>> And then, the thing that actually exposes it to the speculative walkers does:
>>
>>   int
>>   nf_conntrack_hash_check_insert(struct nf_conn *ct)
>>   {
>>         ...
>>         smp_wmb();
>>         /* The caller holds a reference to this object */
>>         atomic_set(&ct->ct_general.use, 2);
>>
>> which means that it stays as zero until everything is actually set up,
>> and then the optimistic walker can use the other fields (including
>> spinlocks etc) to verify that it's actually the right thing. The
>> smp_wmb() means that the previous initialization really will be
>> visible before the object is visible.
>>
>> Side note: on some architectures it might help to make that "smp_wmb
>> -> atomic_set()" sequence be am "smp_store_release()" instead. Doesn't
>> matter on x86, but might matter on arm64.
>>
>> NOTE! One thing to be very worried about is that re-initializing
>> whatever RCU lists means that now the RCU walker may be walking on the
>> wrong list so the walker may do the right thing for this particular
>> entry, but it may miss walking *other* entries. So then you can get
>> spurious lookup failures, because the RCU walker never walked all the
>> way to the end of the right list. That ends up being a much more
>> subtle bug.
>>
>> But the nf_conntrack case seems to get that right too, see the restart
>> in ____nf_conntrack_find().
>>
>> So I don't see anything wrong in nf_conntrack.
>>
>> But yes, using SLAB_TYPESAFE_BY_RCU is very very subtle. But most of
>> the subtleties have nothing to do with having a constructor, they are
>> about those "make sure memory ordering wrt refcount is right" and
>> "restart speculative RCU walk" issues that actually happen regardless
>> of having a constructor or not.
>
>
> Thank you, this is very enlightening.
>
> So the type-stable invariant is established by initialization of the
> object after the first kmem_cache_alloc, and then we rely on the fact
> that repeated initialization does not break the invariant, which works
> because the state is very simple (including debug builds, i.e. no
> ODEBUG nor magic values).


Still can't grasp all details.
There is state that we read without taking ct->ct_general.use ref
first, namely ct->state and what's used by nf_ct_key_equal.
So let's say the entry we want to find is in the list, but
____nf_conntrack_find finds a wrong entry earlier because all state it
looks at is random garbage, so it returns the wrong entry to
__nf_conntrack_find_get.
Now (nf_ct_is_dying(ct) || !atomic_inc_not_zero(&ct->ct_general.use))
check in __nf_conntrack_find_get passes, and it returns NULL to the
caller (which means entry is not present). While in reality the entry
is present, but we were just looking at the wrong one.

Also I am not sure about order of checks in (nf_ct_is_dying(ct) ||
!atomic_inc_not_zero(&ct->ct_general.use)), because checking state
before taking the ref is only a best-effort hint, so it can actually
be a dying entry when we take a ref.

So shouldn't it read something like the following?

        rcu_read_lock();
begin:
        h = ____nf_conntrack_find(net, zone, tuple, hash);
        if (h) {
                ct = nf_ct_tuplehash_to_ctrack(h);
                if (!atomic_inc_not_zero(&ct->ct_general.use))
                        goto begin;
                if (unlikely(nf_ct_is_dying(ct)) ||
                    unlikely(!nf_ct_key_equal(h, tuple, zone, net))) {
                        nf_ct_put(ct);
                        goto begin;
                }
        }
        rcu_read_unlock();
        return h;
