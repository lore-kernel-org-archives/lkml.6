Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932536AbeCLBqi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 21:46:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932419AbeCLBqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 21:46:37 -0400
Date: Sun, 11 Mar 2018 18:47:09 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use the proper lockdep annotation in
 dump_blkd_tasks()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180309013224.23890-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309013224.23890-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18031201-0036-0000-0000-000002CEAA07
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008656; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01001737; UDB=6.00509653; IPR=6.00781067;
 MB=3.00019979; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-12 01:46:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031201-0037-0000-0000-0000439CD451
Message-Id: <20180312014709.GL3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-11_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803120020
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:32:18AM +0800, Boqun Feng wrote:
> Sparse reported this:
> 
> | kernel/rcu/tree_plugin.h:814:9: warning: incorrect type in argument 1 (different modifiers)
> | kernel/rcu/tree_plugin.h:814:9:    expected struct lockdep_map const *lock
> | kernel/rcu/tree_plugin.h:814:9:    got struct lockdep_map [noderef] *<noident>
> 
> This is caused by using vanilla lockdep annotations on rcu_node::lock,
> and that requires accessing ->lock of rcu_node directly. However we need
> to keep rcu_node::lock __private to avoid breaking its extra ordering
> guarantee. And we have a dedicated lockdep annotation for
> rcu_node::lock, so use it.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Good eyes!  Queued both this and v3 for testing and further review.

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 9accacffd138..ea33f57abae5 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -811,7 +811,7 @@ static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>  	int i;
>  	struct list_head *lhp;
> 
> -	lockdep_assert_held(&rnp->lock);
> +	raw_lockdep_assert_held_rcu_node(rnp);
>  	pr_info("%s: grp: %d-%d level: %d ->qamask %#lx ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p &->blkd_tasks: %p offset: %u\n", __func__, rnp->grplo, rnp->grphi, rnp->level, rnp->qsmask, rnp->gp_tasks, rnp->boost_tasks, rnp->exp_tasks, &rnp->blkd_tasks, (unsigned int)offsetof(typeof(*rnp), blkd_tasks));
>  	pr_cont("\t->blkd_tasks");
>  	i = 0;
> -- 
> 2.16.2
> 
