Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53FCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11DB208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11DB208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbeGaLJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:09:26 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:60270 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729731AbeGaLJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:09:26 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 31 Jul 2018 18:29:57 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 31 Jul 2018 18:29:57 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 31 Jul 2018 18:29:50 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        ying.huang@intel.com, peterz@infradead.org, mingo@kernel.org,
        jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, joel@joelfernandes.org,
        len.brown@intel.com, glider@google.com, peter@hurleysoftware.com,
        aik@ozlabs.ru
Subject: Re: [QUESTION] llist: Comment releasing 'must delete' restriction
 before traversing
Message-ID: <20180731092950.GB12241@X58A-UD3R>
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
 <20180731043042.GJ24813@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731043042.GJ24813@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:30:42PM -0700, Paul E. McKenney wrote:
> On Tue, Jul 31, 2018 at 09:58:36AM +0900, Byungchul Park wrote:
> > Hello folks,
> > 
> > I'm careful in saying.. and curious about..
> > 
> > In restrictive cases like only addtions happen but never deletion, can't
> > we safely traverse a llist? I believe llist can be more useful if we can
> > release the restriction. Can't we?
> 
> Yes, but please give a thought to the people looking at your code some
> time down the line.  If you are doing this, lots of comments, please.

Yes, I will. Thank you for the comment.

> Here are the approaches that I am aware of:
> 
> 1.	Normal RCU.  Use list_add_rcu(), list_del_rcu(), and friends.
> 
> 2.	Things are added but never deleted.  Use list_add_rcu() and
> 	friends, but since you don't ever delete anything, you never
> 	use list_del_rcu(), synchronize_rcu(), call_rcu(), and friends.

I think rcu list also works well. But I decided to use llist because
llist is simpler and has one less pointer.

Just to be sure, let me explain my use case more:

   1. Introduced a global list where single linked list is sufficient.
   2. All operations I need is to add items and traverse the list.
   3. Ensure the operations always happen within irq-disabled section.
   4. I'm considering CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG properly.
   5. The list can be accessed by every CPU concurrently.

Of course, I can use normal double list with a lock or rcu list. But I
think it doesn't have to be protected by even rcu in that case. I wanted
to use the simplest one all requiremnets are satisfied with and I
thought it's llist. Thoughts?

> 5.	Just mark the deleted elements, but leave them in the list.
> 	Actually remove them using one of the above techniques.

Honestly, I have a plan to do this thing as a future work. But now, I
can assume deletion never happen with the list :)

> I suggest that such special cases stay in the subsystem in question.
> If a given technique gains wider use, then it might be time to
> update header comments.

Ok.

> > If yes, we may add another function traversing starting from a head. Or
> > just use existing funtion with head->first.
> 
> If you start with head->first, then you need to make sure that a concurrent
> add of an element at the head of the list works.  You need at least a
> READ_ONCE() and preferably an rcu_dereference() or similar.

Yes, sir. I'll be careful in doing it.

Thanks a lot.

> > Thank a lot for your answers in advance :)
> 
> You did ask!
> 
> 							Thanx, Paul
> 
> > ----->8-----
> > >From 1e73882799b269cd86e7a7c955021e3a18d1e6cf Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul.park@lge.com>
> > Date: Tue, 31 Jul 2018 09:31:57 +0900
> > Subject: [QUESTION] llist: Comment releasing 'must delete' restriction before
> >  traversing
> > 
> > llist traversing can run without deletion in restrictive cases all
> > items are added but never deleted like a rculist traversing such as
> > list_for_each_entry_lockless. So add the comment.
> > 
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > ---
> >  include/linux/llist.h | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/llist.h b/include/linux/llist.h
> > index 85abc29..d012d3e 100644
> > --- a/include/linux/llist.h
> > +++ b/include/linux/llist.h
> > @@ -32,8 +32,12 @@
> >   * operation, with "-" being no lock needed, while "L" being lock is needed.
> >   *
> >   * The list entries deleted via llist_del_all can be traversed with
> > - * traversing function such as llist_for_each etc.  But the list
> > - * entries can not be traversed safely before deleted from the list.
> > + * traversing function such as llist_for_each etc.  Normally the list
> > + * entries cannot be traversed safely before deleted from the list
> > + * except the cases items are added to the list but never deleted.  In
> > + * that restrictive cases the list may be safely traversed concurrently
> > + * with llist_add.
> > + *
> >   * The order of deleted entries is from the newest to the oldest added
> >   * one.  If you want to traverse from the oldest to the newest, you
> >   * must reverse the order by yourself before traversing.
> > @@ -116,7 +120,9 @@ static inline void init_llist_head(struct llist_head *list)
> >   *
> >   * In general, some entries of the lock-less list can be traversed
> >   * safely only after being deleted from list, so start with an entry
> > - * instead of list head.
> > + * instead of list head.  But in restrictive cases items are added to
> > + * the list but never deleted, the list may be safely traversed
> > + * concurrently with llist_add.
> >   *
> >   * If being used on entries deleted from lock-less list directly, the
> >   * traverse order is from the newest to the oldest added entry.  If
> > @@ -135,7 +141,9 @@ static inline void init_llist_head(struct llist_head *list)
> >   *
> >   * In general, some entries of the lock-less list can be traversed
> >   * safely only after being deleted from list, so start with an entry
> > - * instead of list head.
> > + * instead of list head.  But in restrictive cases items are added to
> > + * the list but never deleted, the list may be safely traversed
> > + * concurrently with llist_add.
> >   *
> >   * If being used on entries deleted from lock-less list directly, the
> >   * traverse order is from the newest to the oldest added entry.  If
> > @@ -153,7 +161,9 @@ static inline void init_llist_head(struct llist_head *list)
> >   *
> >   * In general, some entries of the lock-less list can be traversed
> >   * safely only after being removed from list, so start with an entry
> > - * instead of list head.
> > + * instead of list head.  But in restrictive cases items are added to
> > + * the list but never deleted, the list may be safely traversed
> > + * concurrently with llist_add.
> >   *
> >   * If being used on entries deleted from lock-less list directly, the
> >   * traverse order is from the newest to the oldest added entry.  If
> > @@ -175,7 +185,9 @@ static inline void init_llist_head(struct llist_head *list)
> >   *
> >   * In general, some entries of the lock-less list can be traversed
> >   * safely only after being removed from list, so start with an entry
> > - * instead of list head.
> > + * instead of list head.  But in restrictive cases items are added to
> > + * the list but never deleted, the list may be safely traversed
> > + * concurrently with llist_add.
> >   *
> >   * If being used on entries deleted from lock-less list directly, the
> >   * traverse order is from the newest to the oldest added entry.  If
> > -- 
> > 1.9.1
> > 
