Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5569C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DAB204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DAB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeH2Xc3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:32:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbeH2Xc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75833401DEA8;
        Wed, 29 Aug 2018 19:34:06 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37D202166B41;
        Wed, 29 Aug 2018 19:34:05 +0000 (UTC)
Subject: Re: [PATCH 2/2] fs/dcache: Make negative dentries easier to be
 reclaimed
To:     Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-3-git-send-email-longman@redhat.com>
 <20180829010228.GE1572@dastard>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6e2999b3-e93f-2138-6ceb-4f24712f419f@redhat.com>
Date:   Wed, 29 Aug 2018 15:34:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180829010228.GE1572@dastard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 29 Aug 2018 19:34:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 29 Aug 2018 19:34:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 09:02 PM, Dave Chinner wrote:
> On Tue, Aug 28, 2018 at 01:19:40PM -0400, Waiman Long wrote:
>> For negative dentries that are accessed once and never used again, they
>> should be removed first before other dentries when shrinker is running.
>> This is done by putting negative dentries at the head of the LRU list
>> instead at the tail.
>>
>> A new DCACHE_NEW_NEGATIVE flag is now added to a negative dentry when it
>> is initially created. When such a dentry is added to the LRU, it will be
>> added to the head so that it will be the first to go when a shrinker is
>> running if it is never accessed again (DCACHE_REFERENCED bit not set).
>> The flag is cleared after the LRU list addition.
> This exposes internal LRU list functionality to callers. I carefully
> hid what end of the list was the most or least recent from
> subsystems interacting with LRUs precisely because "head" and "tail"
> are completely confusing when interacting with a LRU.
>
> LRUs are about tracking relative object age, not heads and tails.
>
> IOWs, "track this object as most recently used", not "add this
> object to the list tail". The opposite is "track this object is
> least recently used", not "add object at head of list".
>
> IOWs, the interface should be list_lru_add_oldest() or maybe
> list_lru_add_least_recent() to indicate that these objects are
> considered to be the oldest and therefore prime immediate reclaim
> candidates.

Good point. I will use age as function name instead.

> Which points out a problem. That the most recent negative dentry
> will be the first to be reclaimed. That's not LRU behaviour, and
> prevents a working set of negative dentries from being retained
> when the shrinker rotates through the dentries in LRU order. i.e.
> this patch turns the LRU into a MRU list for negative dentries.
>
> And then there's shrinker behaviour. What happens if the shrinker
> isolate callback returns LRU_ROTATE on a negative dentry? It gets
> moved to the most recent end of the list, so it won't have an
> attempt to reclaim it again until it's tried to reclaim all the real
> dentries. IOWs, it goes back to behaving like LRUs are supposed to
> behaving.
>
> IOWs, reclaim behaviour of negative dentries will be
> highly unpredictable, it will not easily retain a working set, nor
> will the working set it does retain be predictable or easy to eject
> from memory when the workload changes.
>
> Is this the behavour what we want for negative dentries?

I am aware that the behavior is not strictly LRU for negative dentries.
This is a compromise for using one LRU list for 2 different classes of
dentries. The basic idea is that negative dentries that are used only
once will go first irrespective of their age.

> Perhaps a second internal LRU list in the list_lru for "immediate
> reclaim" objects would be a better solution. i.e. similar to the
> active/inactive lists used for prioritising the working set iover
> single use pages in page reclaim. negative dentries go onto the
> immediate list, real dentries go on the existing list. Both are LRU,
> and the shrinker operates on the immediate list first. When we
> rotate referenced negative dentries on the immediate list, promote
> them to the active list with all the real dentries so they age out
> with the rest of the working set. That way single use negative
> dentries get removed in LRU order in preference to the working set
> of real dentries.
>
> Being able to make changes to the list implementation easily was one
> of the reasons I hid the implementation of the list_lru from the
> interface callers use....
>
> [...]

I have thought about using 2 lists for dentries. That will require much
more extensive changes to the code and hence much more testing will be
needed to verify their correctness. That is the main reason why I try to
avoid doing that.

As you have suggested, we could implement this 2-level LRU list in the
list_lru API. But it is used by other subsystems as well. Extensive
change like that will have similar issue in term of testing and
verification effort.

>> @@ -430,8 +424,20 @@ static void d_lru_add(struct dentry *dentry)
>>  	D_FLAG_VERIFY(dentry, 0);
>>  	dentry->d_flags |= DCACHE_LRU_LIST;
>>  	this_cpu_inc(nr_dentry_unused);
>> +	if (d_is_negative(dentry)) {
>> +		__neg_dentry_inc(dentry);
> /me notes this patch now open codes this, like suggested in the
> previous patch.
>
>> +		if (dentry->d_flags & DCACHE_NEW_NEGATIVE) {
>> +			/*
>> +			 * Add the negative dentry to the head once, it
>> +			 * will be added to the tail next time.
>> +			 */
>> +			WARN_ON_ONCE(!list_lru_add_head(
>> +				&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
>> +			dentry->d_flags &= ~DCACHE_NEW_NEGATIVE;
>> +			return;
>> +		}
>> +	}
>>  	WARN_ON_ONCE(!list_lru_add(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
>> -	neg_dentry_inc(dentry);
>>  }
>>  
>>  static void d_lru_del(struct dentry *dentry)
>> @@ -2620,6 +2626,9 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
>>  		__d_set_inode_and_type(dentry, inode, add_flags);
>>  		raw_write_seqcount_end(&dentry->d_seq);
>>  		fsnotify_update_flags(dentry);
>> +	} else {
>> +		/* It is a negative dentry, add it to LRU head initially. */
>> +		dentry->d_flags |= DCACHE_NEW_NEGATIVE;
> Comments about LRU behaviour should not be put anywhere but in the
> lru code. Otherwise it ends up stale and wrong, assuming it is
> correct to start with....
>

I will document all that in the LRU code.

>>  	}
>>  	__d_rehash(dentry);
>>  	if (dir)
>> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
>> index df942e5..03a1918 100644
>> --- a/include/linux/dcache.h
>> +++ b/include/linux/dcache.h
>> @@ -214,6 +214,7 @@ struct dentry_operations {
>>  #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
>>  #define DCACHE_ENCRYPTED_WITH_KEY	0x02000000 /* dir is encrypted with a valid key */
>>  #define DCACHE_OP_REAL			0x04000000
>> +#define DCACHE_NEW_NEGATIVE		0x08000000 /* New negative dentry */
>>  
>>  #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
>>  #define DCACHE_DENTRY_CURSOR		0x20000000
>> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
>> index aa5efd9..bfac057 100644
>> --- a/include/linux/list_lru.h
>> +++ b/include/linux/list_lru.h
>> @@ -90,6 +90,23 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
>>  bool list_lru_add(struct list_lru *lru, struct list_head *item);
>>  
>>  /**
>> + * list_lru_add_head: add an element to the lru list's head
>> + * @list_lru: the lru pointer
>> + * @item: the item to be added.
>> + *
>> + * This is similar to list_lru_add(). The only difference is the location
>> + * where the new item will be added. The list_lru_add() function will add
>> + * the new item to the tail as it is the most recently used one. The
>> + * list_lru_add_head() will add the new item into the head so that it
>> + * will the first to go if a shrinker is running. So this function should
>> + * only be used for less important item that can be the first to go if
>> + * the system is under memory pressure.
> As mentioned above, this API needs reference object ages, not
> internal list ordering and shrinker implementation details.

Sure. Thanks for the suggestion.

Cheers,
Longman

