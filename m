Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC543C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF1520841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF1520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeGaQLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:11:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732266AbeGaQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:11:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6VE9UfN097889
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:31:00 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kjrdbuq9h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:31:00 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 31 Jul 2018 10:30:58 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Jul 2018 10:30:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6VEUpes17891798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Jul 2018 14:30:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7FD3B2066;
        Tue, 31 Jul 2018 10:30:25 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF217B2064;
        Tue, 31 Jul 2018 10:30:25 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jul 2018 10:30:25 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1514516C0EB0; Tue, 31 Jul 2018 07:30:52 -0700 (PDT)
Date:   Tue, 31 Jul 2018 07:30:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        ying.huang@intel.com, peterz@infradead.org, mingo@kernel.org,
        jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, joel@joelfernandes.org,
        len.brown@intel.com, glider@google.com, peter@hurleysoftware.com,
        aik@ozlabs.ru
Subject: Re: [QUESTION] llist: Comment releasing 'must delete' restriction
 before traversing
Reply-To: paulmck@linux.vnet.ibm.com
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
 <20180731043042.GJ24813@linux.vnet.ibm.com>
 <20180731092950.GB12241@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731092950.GB12241@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18073114-0072-0000-0000-0000038821E0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009463; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068479; UDB=6.00549296; IPR=6.00846676;
 MB=3.00022427; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-31 14:30:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073114-0073-0000-0000-000048E8353E
Message-Id: <20180731143052.GL24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:29:50PM +0900, Byungchul Park wrote:
> On Mon, Jul 30, 2018 at 09:30:42PM -0700, Paul E. McKenney wrote:
> > On Tue, Jul 31, 2018 at 09:58:36AM +0900, Byungchul Park wrote:
> > > Hello folks,
> > > 
> > > I'm careful in saying.. and curious about..
> > > 
> > > In restrictive cases like only addtions happen but never deletion, can't
> > > we safely traverse a llist? I believe llist can be more useful if we can
> > > release the restriction. Can't we?
> > 
> > Yes, but please give a thought to the people looking at your code some
> > time down the line.  If you are doing this, lots of comments, please.
> 
> Yes, I will. Thank you for the comment.
> 
> > Here are the approaches that I am aware of:
> > 
> > 1.	Normal RCU.  Use list_add_rcu(), list_del_rcu(), and friends.
> > 
> > 2.	Things are added but never deleted.  Use list_add_rcu() and
> > 	friends, but since you don't ever delete anything, you never
> > 	use list_del_rcu(), synchronize_rcu(), call_rcu(), and friends.
> 
> I think rcu list also works well. But I decided to use llist because
> llist is simpler and has one less pointer.

No.

To see this, look at llist_for_each() below, which is absolutely -not-
able to reliably traverse lists while nodes are being inserted.

#define llist_for_each(pos, node)			\
	for ((pos) = (node); pos; (pos) = (pos)->next)

Now, you could introduce an llist_for_each_rcu() that used rcu_dereference
or similar (thus handling insertion, but that is not what your patches
currently do.

> Just to be sure, let me explain my use case more:
> 
>    1. Introduced a global list where single linked list is sufficient.
>    2. All operations I need is to add items and traverse the list.
>    3. Ensure the operations always happen within irq-disabled section.
>    4. I'm considering CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG properly.
>    5. The list can be accessed by every CPU concurrently.
> 
> Of course, I can use normal double list with a lock or rcu list. But I
> think it doesn't have to be protected by even rcu in that case. I wanted
> to use the simplest one all requiremnets are satisfied with and I
> thought it's llist. Thoughts?

If you want lockless reader traversal, you need rcu_dereference().

> > 5.	Just mark the deleted elements, but leave them in the list.
> > 	Actually remove them using one of the above techniques.
> 
> Honestly, I have a plan to do this thing as a future work. But now, I
> can assume deletion never happen with the list :)
> 
> > I suggest that such special cases stay in the subsystem in question.
> > If a given technique gains wider use, then it might be time to
> > update header comments.
> 
> Ok.
> 
> > > If yes, we may add another function traversing starting from a head. Or
> > > just use existing funtion with head->first.
> > 
> > If you start with head->first, then you need to make sure that a concurrent
> > add of an element at the head of the list works.  You need at least a
> > READ_ONCE() and preferably an rcu_dereference() or similar.
> 
> Yes, sir. I'll be careful in doing it.

Which means adding something to the current llist.h.

							Thanx, Paul

> Thanks a lot.
> 
> > > Thank a lot for your answers in advance :)
> > 
> > You did ask!
> > 
> > 							Thanx, Paul
> > 
> > > ----->8-----
> > > >From 1e73882799b269cd86e7a7c955021e3a18d1e6cf Mon Sep 17 00:00:00 2001
> > > From: Byungchul Park <byungchul.park@lge.com>
> > > Date: Tue, 31 Jul 2018 09:31:57 +0900
> > > Subject: [QUESTION] llist: Comment releasing 'must delete' restriction before
> > >  traversing
> > > 
> > > llist traversing can run without deletion in restrictive cases all
> > > items are added but never deleted like a rculist traversing such as
> > > list_for_each_entry_lockless. So add the comment.
> > > 
> > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > ---
> > >  include/linux/llist.h | 24 ++++++++++++++++++------
> > >  1 file changed, 18 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/include/linux/llist.h b/include/linux/llist.h
> > > index 85abc29..d012d3e 100644
> > > --- a/include/linux/llist.h
> > > +++ b/include/linux/llist.h
> > > @@ -32,8 +32,12 @@
> > >   * operation, with "-" being no lock needed, while "L" being lock is needed.
> > >   *
> > >   * The list entries deleted via llist_del_all can be traversed with
> > > - * traversing function such as llist_for_each etc.  But the list
> > > - * entries can not be traversed safely before deleted from the list.
> > > + * traversing function such as llist_for_each etc.  Normally the list
> > > + * entries cannot be traversed safely before deleted from the list
> > > + * except the cases items are added to the list but never deleted.  In
> > > + * that restrictive cases the list may be safely traversed concurrently
> > > + * with llist_add.
> > > + *
> > >   * The order of deleted entries is from the newest to the oldest added
> > >   * one.  If you want to traverse from the oldest to the newest, you
> > >   * must reverse the order by yourself before traversing.
> > > @@ -116,7 +120,9 @@ static inline void init_llist_head(struct llist_head *list)
> > >   *
> > >   * In general, some entries of the lock-less list can be traversed
> > >   * safely only after being deleted from list, so start with an entry
> > > - * instead of list head.
> > > + * instead of list head.  But in restrictive cases items are added to
> > > + * the list but never deleted, the list may be safely traversed
> > > + * concurrently with llist_add.
> > >   *
> > >   * If being used on entries deleted from lock-less list directly, the
> > >   * traverse order is from the newest to the oldest added entry.  If
> > > @@ -135,7 +141,9 @@ static inline void init_llist_head(struct llist_head *list)
> > >   *
> > >   * In general, some entries of the lock-less list can be traversed
> > >   * safely only after being deleted from list, so start with an entry
> > > - * instead of list head.
> > > + * instead of list head.  But in restrictive cases items are added to
> > > + * the list but never deleted, the list may be safely traversed
> > > + * concurrently with llist_add.
> > >   *
> > >   * If being used on entries deleted from lock-less list directly, the
> > >   * traverse order is from the newest to the oldest added entry.  If
> > > @@ -153,7 +161,9 @@ static inline void init_llist_head(struct llist_head *list)
> > >   *
> > >   * In general, some entries of the lock-less list can be traversed
> > >   * safely only after being removed from list, so start with an entry
> > > - * instead of list head.
> > > + * instead of list head.  But in restrictive cases items are added to
> > > + * the list but never deleted, the list may be safely traversed
> > > + * concurrently with llist_add.
> > >   *
> > >   * If being used on entries deleted from lock-less list directly, the
> > >   * traverse order is from the newest to the oldest added entry.  If
> > > @@ -175,7 +185,9 @@ static inline void init_llist_head(struct llist_head *list)
> > >   *
> > >   * In general, some entries of the lock-less list can be traversed
> > >   * safely only after being removed from list, so start with an entry
> > > - * instead of list head.
> > > + * instead of list head.  But in restrictive cases items are added to
> > > + * the list but never deleted, the list may be safely traversed
> > > + * concurrently with llist_add.
> > >   *
> > >   * If being used on entries deleted from lock-less list directly, the
> > >   * traverse order is from the newest to the oldest added entry.  If
> > > -- 
> > > 1.9.1
> > > 
> 

