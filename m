Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7956C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA1B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA1B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbeHAHSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:18:34 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:60386 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733054AbeHAHSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:18:34 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 1 Aug 2018 14:34:43 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 1 Aug 2018 14:34:43 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 1 Aug 2018 14:34:35 +0900
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
Message-ID: <20180801053435.GA25338@X58A-UD3R>
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
 <20180731043042.GJ24813@linux.vnet.ibm.com>
 <20180731092950.GB12241@X58A-UD3R>
 <20180731143052.GL24813@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731143052.GL24813@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 07:30:52AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 31, 2018 at 06:29:50PM +0900, Byungchul Park wrote:
> > On Mon, Jul 30, 2018 at 09:30:42PM -0700, Paul E. McKenney wrote:
> > > On Tue, Jul 31, 2018 at 09:58:36AM +0900, Byungchul Park wrote:
> > > > Hello folks,
> > > > 
> > > > I'm careful in saying.. and curious about..
> > > > 
> > > > In restrictive cases like only addtions happen but never deletion, can't
> > > > we safely traverse a llist? I believe llist can be more useful if we can
> > > > release the restriction. Can't we?
> > > 
> > > Yes, but please give a thought to the people looking at your code some
> > > time down the line.  If you are doing this, lots of comments, please.
> > 
> > Yes, I will. Thank you for the comment.
> > 
> > > Here are the approaches that I am aware of:
> > > 
> > > 1.	Normal RCU.  Use list_add_rcu(), list_del_rcu(), and friends.
> > > 
> > > 2.	Things are added but never deleted.  Use list_add_rcu() and
> > > 	friends, but since you don't ever delete anything, you never
> > > 	use list_del_rcu(), synchronize_rcu(), call_rcu(), and friends.
> > 
> > I think rcu list also works well. But I decided to use llist because
> > llist is simpler and has one less pointer.
> 
> No.
> 
> To see this, look at llist_for_each() below, which is absolutely -not-
> able to reliably traverse lists while nodes are being inserted.

Ah.. Not only 'node' but also 'pos->next' can cause a problem w/o
rcu_dereference or similar.. I need consider another way.

Or I might need memory barrier between READ_ONCE(head->first) and
llist_for_each() to make sure safely to read 'pos->next' when I see
a value of 'head->first'.

> #define llist_for_each(pos, node)			\
> 	for ((pos) = (node); pos; (pos) = (pos)->next)
> 
> Now, you could introduce an llist_for_each_rcu() that used rcu_dereference
> or similar (thus handling insertion, but that is not what your patches
> currently do.

Right.

> > Just to be sure, let me explain my use case more:
> > 
> >    1. Introduced a global list where single linked list is sufficient.
> >    2. All operations I need is to add items and traverse the list.
> >    3. Ensure the operations always happen within irq-disabled section.
> >    4. I'm considering CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG properly.
> >    5. The list can be accessed by every CPU concurrently.
> > 
> > Of course, I can use normal double list with a lock or rcu list. But I
> > think it doesn't have to be protected by even rcu in that case. I wanted
> > to use the simplest one all requiremnets are satisfied with and I
> > thought it's llist. Thoughts?
> 
> If you want lockless reader traversal, you need rcu_dereference().

Yes, I need that or similar anyway.

Thanks a lot, Paul!

