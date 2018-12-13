Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19EBC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C1620645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C1620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeLMMTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:19:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:54758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728766AbeLMMTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:19:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41F52AEBB;
        Thu, 13 Dec 2018 12:19:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Dec 2018 13:19:28 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Davidlohr Bueso <dbueso@suse.de>, Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
In-Reply-To: <20181213111957.GA8459@andrea>
References: <20181212110357.25656-1-rpenyaev@suse.de>
 <20181212110357.25656-4-rpenyaev@suse.de> <20181212171348.GA12786@andrea>
 <a30306ad68b4b7171fbb587f5f845ea5@suse.de> <20181213111957.GA8459@andrea>
Message-ID: <e047c6b259c1ee9ec7de0c66c1450c5c@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-13 12:19, Andrea Parri wrote:
> On Thu, Dec 13, 2018 at 11:13:58AM +0100, Roman Penyaev wrote:
>> On 2018-12-12 18:13, Andrea Parri wrote:
>> > On Wed, Dec 12, 2018 at 12:03:57PM +0100, Roman Penyaev wrote:
>> 
>> [...]
>> 
>> > > +static inline void list_add_tail_lockless(struct list_head *new,
>> > > +					  struct list_head *head)
>> > > +{
>> > > +	struct list_head *prev;
>> > > +
>> > > +	new->next = head;
>> > > +
>> > > +	/*
>> > > +	 * Initially ->next of a new element must be updated with the head
>> > > +	 * (we are inserting to the tail) and only then pointers are
>> > > atomically
>> > > +	 * exchanged.  XCHG guarantees memory ordering, thus ->next should
>> > > be
>> > > +	 * updated before pointers are actually swapped.
>> > > +	 */
>> > > +
>> > > +	prev = xchg(&head->prev, new);
>> > > +
>> > > +	/*
>> > > +	 * It is safe to modify prev->next and new->prev, because a new
>> > > element
>> > > +	 * is added only to the tail and new->next is updated before XCHG.
>> > > +	 */
>> >
>> > IIUC, you're also relying on "some" ordering between the atomic load
>> > of &head->prev above and the store to prev->next below: consider the
>> > following snippet for two concurrent list_add_tail_lockless()'s:
>> >
>> > {Initially: List := H -> A -> B}
>> >
>> > CPU0					CPU1
>> >
>> > list_add_tail_lockless(C, H):		list_add_tail_lockless(D, H):
>> >
>> > C->next = H				D->next = H
>> > prev = xchg(&H->prev, C) // =B		prev = xchg(&H->prev, D) // =C
>> > B->next = C				C->next = D
>> > C->prev = B				D->prev = C
>> >
>> > Here, as annotated, CPU0's xchg() "wins" over CPU1's xchg() (i.e., the
>> > latter reads the value of &H->prev that the former stored to that same
>> > location).
>> >
>> > As you noted above, the xchg() guarantees that CPU0's store to C->next
>> > is "ordered before" CPU0's store to &H->prev.
>> >
>> > But we also want CPU1's load from &H->prev to be ordered before CPU1's
>> > store to C->next, which is also guaranteed by the xchg() (or, FWIW, by
>> > the address dependency between these two memory accesses).
>> >
>> > I do not see what could guarantee "C->next == D" in the end, otherwise.
>> >
>> > What am I missing?
>> 
>> Hi Andrea,
>> 
>> xchg always acts as a full memory barrier, i.e. mfence in x86 terms.  
>> So the
>> following statement should be always true, otherwise nothing should 
>> work as
>> the same code pattern is used in many generic places:
>> 
>>    CPU0               CPU1
>> 
>>  C->next = H
>>  xchg(&ptr, C)
>>                      C = xchg(&ptr, D)
>>                      C->next = D
>> 
>> 
>> This is the only guarantee we need, i.e. make it simplier:
>> 
>>    C->next = H
>>    mfence            mfence
>>                      C->next = D
>> 
>> the gurantee that two stores won't reorder.  Pattern is always the 
>> same: we
>> prepare chunk of memory on CPU0 and do pointers xchg, CPU1 sees chunks 
>> of
>> memory with all stores committed by CPU0 (regardless of CPU1 does 
>> loads
>> or stores to this chunk).
>> 
>> I am repeating the same thing which you also noted, but I just want to 
>> be
>> sure that I do not say nonsense.  So basically repeating to myself.
>> 
>> Ok, let's commit that.  Returning to your question: "I do not see what
>> could guarantee "C->next == D" in the end"
>> 
>> At the end of what?  Lockless insert procedure (insert to tail) relies 
>> only
>> on "head->prev".  This is the single "place" where we atomically 
>> exchange
>> list elements and "somehow" chain them.  So insert needs only actual
>> "head->prev", and xchg provides this guarantees to us.
> 
> When all the operations reported in the snippet have completed (i.e.,
> executed and propagated to memory).
> 
> To rephrase my remark:
> 
> I am saying that we do need some ordering between the xchg() and the
> program-order _subsequent stores, and implicitly suggesting to write
> this down in the comment.  As I wrote, this ordering _is provided by
> the xchg() itself or by the dependency; so, maybe, something like:
> 
> 	/*
> 	 * [...]  XCHG guarantees memory ordering, thus new->next is
> 	 * updated before pointers are actually swapped and pointers
> 	 * are swapped before prev->next is updated.
> 	 */
> 
> Adding a snippet, say in the form you reported above, would not hurt
> of course. ;-)

Sure thing.  Will extend the comments.

--
Roman

