Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ECCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260BE208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260BE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeGaGJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:09:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbeGaGJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:09:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6V4SmVh110228
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:30:51 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kjg43h9xu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:30:50 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 31 Jul 2018 00:30:48 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Jul 2018 00:30:44 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6V4UhVk3735922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Jul 2018 04:30:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFDA9B2065;
        Tue, 31 Jul 2018 00:30:17 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92AE1B2070;
        Tue, 31 Jul 2018 00:30:17 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.140.233])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jul 2018 00:30:17 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C118F16CA602; Mon, 30 Jul 2018 21:30:42 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:30:42 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18073104-0052-0000-0000-00000315B015
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009461; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068322; UDB=6.00549188; IPR=6.00846475;
 MB=3.00022418; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-31 04:30:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073104-0053-0000-0000-00005D8C970D
Message-Id: <20180731043042.GJ24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:58:36AM +0900, Byungchul Park wrote:
> Hello folks,
> 
> I'm careful in saying.. and curious about..
> 
> In restrictive cases like only addtions happen but never deletion, can't
> we safely traverse a llist? I believe llist can be more useful if we can
> release the restriction. Can't we?

Yes, but please give a thought to the people looking at your code some
time down the line.  If you are doing this, lots of comments, please.

Here are the approaches that I am aware of:

1.	Normal RCU.  Use list_add_rcu(), list_del_rcu(), and friends.

2.	Things are added but never deleted.  Use list_add_rcu() and
	friends, but since you don't ever delete anything, you never
	use list_del_rcu(), synchronize_rcu(), call_rcu(), and friends.

3.	Things are added, but deletion deletes the entire list.
	You need to use something like list_del_rcu() to handle
	this, and you need synchronize_rcu(), call_rcu(), and friends.
	So really not all that much different than #1.

4.	Things are added, but deletions happen during some sort of
	maintenance phase during which there are no readers.  This is
	really easy to get wrong -- all you have to do is let one little
	reader slip in and all is broken.  Also the maintenance phases
	often take longer than planned.  (We used a trick somewhat
	like this back when I worked on the dormitory system back at
	university the first time around, but we had the advantage of
	everyone using the system being in the same timezone and
	the system being taken down every night anyway.)

5.	Just mark the deleted elements, but leave them in the list.
	Actually remove them using one of the above techniques.

There are probably others, but those come to mind immediately.

I suggest that such special cases stay in the subsystem in question.
If a given technique gains wider use, then it might be time to
update header comments.

> If yes, we may add another function traversing starting from a head. Or
> just use existing funtion with head->first.

If you start with head->first, then you need to make sure that a concurrent
add of an element at the head of the list works.  You need at least a
READ_ONCE() and preferably an rcu_dereference() or similar.

> Thank a lot for your answers in advance :)

You did ask!

							Thanx, Paul

> ----->8-----
> >From 1e73882799b269cd86e7a7c955021e3a18d1e6cf Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul.park@lge.com>
> Date: Tue, 31 Jul 2018 09:31:57 +0900
> Subject: [QUESTION] llist: Comment releasing 'must delete' restriction before
>  traversing
> 
> llist traversing can run without deletion in restrictive cases all
> items are added but never deleted like a rculist traversing such as
> list_for_each_entry_lockless. So add the comment.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  include/linux/llist.h | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 85abc29..d012d3e 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -32,8 +32,12 @@
>   * operation, with "-" being no lock needed, while "L" being lock is needed.
>   *
>   * The list entries deleted via llist_del_all can be traversed with
> - * traversing function such as llist_for_each etc.  But the list
> - * entries can not be traversed safely before deleted from the list.
> + * traversing function such as llist_for_each etc.  Normally the list
> + * entries cannot be traversed safely before deleted from the list
> + * except the cases items are added to the list but never deleted.  In
> + * that restrictive cases the list may be safely traversed concurrently
> + * with llist_add.
> + *
>   * The order of deleted entries is from the newest to the oldest added
>   * one.  If you want to traverse from the oldest to the newest, you
>   * must reverse the order by yourself before traversing.
> @@ -116,7 +120,9 @@ static inline void init_llist_head(struct llist_head *list)
>   *
>   * In general, some entries of the lock-less list can be traversed
>   * safely only after being deleted from list, so start with an entry
> - * instead of list head.
> + * instead of list head.  But in restrictive cases items are added to
> + * the list but never deleted, the list may be safely traversed
> + * concurrently with llist_add.
>   *
>   * If being used on entries deleted from lock-less list directly, the
>   * traverse order is from the newest to the oldest added entry.  If
> @@ -135,7 +141,9 @@ static inline void init_llist_head(struct llist_head *list)
>   *
>   * In general, some entries of the lock-less list can be traversed
>   * safely only after being deleted from list, so start with an entry
> - * instead of list head.
> + * instead of list head.  But in restrictive cases items are added to
> + * the list but never deleted, the list may be safely traversed
> + * concurrently with llist_add.
>   *
>   * If being used on entries deleted from lock-less list directly, the
>   * traverse order is from the newest to the oldest added entry.  If
> @@ -153,7 +161,9 @@ static inline void init_llist_head(struct llist_head *list)
>   *
>   * In general, some entries of the lock-less list can be traversed
>   * safely only after being removed from list, so start with an entry
> - * instead of list head.
> + * instead of list head.  But in restrictive cases items are added to
> + * the list but never deleted, the list may be safely traversed
> + * concurrently with llist_add.
>   *
>   * If being used on entries deleted from lock-less list directly, the
>   * traverse order is from the newest to the oldest added entry.  If
> @@ -175,7 +185,9 @@ static inline void init_llist_head(struct llist_head *list)
>   *
>   * In general, some entries of the lock-less list can be traversed
>   * safely only after being removed from list, so start with an entry
> - * instead of list head.
> + * instead of list head.  But in restrictive cases items are added to
> + * the list but never deleted, the list may be safely traversed
> + * concurrently with llist_add.
>   *
>   * If being used on entries deleted from lock-less list directly, the
>   * traverse order is from the newest to the oldest added entry.  If
> -- 
> 1.9.1
> 

