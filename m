Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755692AbeEAOMw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:12:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752182AbeEAOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:12:50 -0400
Date: Tue, 1 May 2018 07:14:04 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: NeilBrown <neilb@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-nfs@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4 v2] rculist: add list_for_each_entry_from_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <152506256513.7246.13171564155614823841.stgit@noble>
 <152506269061.7246.13075216914692813995.stgit@noble>
 <20180430052032.GA16963@localhost>
 <20180430134308.GT26088@linux.vnet.ibm.com>
 <20180430111454.722c2aa8@gandalf.local.home>
 <20180430153505.GW26088@linux.vnet.ibm.com>
 <87y3h4gjdq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3h4gjdq.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050114-0056-0000-0000-00000447E140
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008956; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01025959; UDB=6.00523952; IPR=6.00805191;
 MB=3.00020880; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-01 14:12:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050114-0057-0000-0000-0000088BE70B
Message-Id: <20180501141404.GD26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 01:11:29PM +1000, NeilBrown wrote:
> 
> list_for_each_entry_from_rcu() is an RCU version of
> list_for_each_entry_from().  It walks a linked list under rcu
> protection, from a given start point.
> 
> It is similar to list_for_each_entry_continue_rcu() but starts *at*
> the given position rather than *after* it.
> 
> Naturally, the start point must be known to be in the list.
> 
> Also update the documentation for list_for_each_entry_continue_rcu()
> to match the documentation for the new list_for_each_entry_from_rcu(),
> and add list_for_each_entry_from_rcu() and the already existing
> hlist_for_each_entry_from_rcu() to section 7 of whatisRCU.txt.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

I am guessing that it would be more convenient for you to carry this
with the patches using it, so:

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

If not, please let me know.

							Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.txt |  2 ++
>  include/linux/rculist.h         | 32 +++++++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
> index a27fbfb0efb8..b7d38bd212d2 100644
> --- a/Documentation/RCU/whatisRCU.txt
> +++ b/Documentation/RCU/whatisRCU.txt
> @@ -814,11 +814,13 @@ RCU list traversal:
>  	list_next_rcu
>  	list_for_each_entry_rcu
>  	list_for_each_entry_continue_rcu
> +	list_for_each_entry_from_rcu
>  	hlist_first_rcu
>  	hlist_next_rcu
>  	hlist_pprev_rcu
>  	hlist_for_each_entry_rcu
>  	hlist_for_each_entry_rcu_bh
> +	hlist_for_each_entry_from_rcu
>  	hlist_for_each_entry_continue_rcu
>  	hlist_for_each_entry_continue_rcu_bh
>  	hlist_nulls_first_rcu
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 127f534fec94..4786c2235b98 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -396,13 +396,43 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
>   * @member:	the name of the list_head within the struct.
>   *
>   * Continue to iterate over list of given type, continuing after
> - * the current position.
> + * the current position which must have been in the list when the RCU read
> + * lock was taken.
> + * This would typically require either that you obtained the node from a
> + * previous walk of the list in the same RCU read-side critical section, or
> + * that you held some sort of non-RCU reference (such as a reference count)
> + * to keep the node alive *and* in the list.
> + *
> + * This iterator is similar to list_for_each_entry_from_rcu() except
> + * this starts after the given position and that one starts at the given
> + * position.
>   */
>  #define list_for_each_entry_continue_rcu(pos, head, member) 		\
>  	for (pos = list_entry_rcu(pos->member.next, typeof(*pos), member); \
>  	     &pos->member != (head);	\
>  	     pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
>  
> +/**
> + * list_for_each_entry_from_rcu - iterate over a list from current point
> + * @pos:	the type * to use as a loop cursor.
> + * @head:	the head for your list.
> + * @member:	the name of the list_node within the struct.
> + *
> + * Iterate over the tail of a list starting from a given position,
> + * which must have been in the list when the RCU read lock was taken.
> + * This would typically require either that you obtained the node from a
> + * previous walk of the list in the same RCU read-side critical section, or
> + * that you held some sort of non-RCU reference (such as a reference count)
> + * to keep the node alive *and* in the list.
> + *
> + * This iterator is similar to list_for_each_entry_continue_rcu() except
> + * this starts from the given position and that one starts from the position
> + * after the given position.
> + */
> +#define list_for_each_entry_from_rcu(pos, head, member)			\
> +	for (; &(pos)->member != (head);					\
> +		pos = list_entry_rcu(pos->member.next, typeof(*(pos)), member))
> +
>  /**
>   * hlist_del_rcu - deletes entry from hash list without re-initialization
>   * @n: the element to delete from the hash list.
> -- 
> 2.14.0.rc0.dirty
> 
