Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeBVQ5p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:57:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933093AbeBVQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:57:44 -0500
Date: Thu, 22 Feb 2018 08:58:03 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: zhouzhouyi@gmail.com
Cc: josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: remove never used variable
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519282357-17983-1-git-send-email-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519282357-17983-1-git-send-email-zhouzhouyi@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022216-0024-0000-0000-0000032B19A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008577; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993515; UDB=6.00504840; IPR=6.00772856;
 MB=3.00019692; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-22 16:57:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022216-0025-0000-0000-0000471D7007
Message-Id: <20180222165803.GF2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220213
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 06:52:37AM +0000, zhouzhouyi@gmail.com wrote:
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> In function srcu_gp_end, the variable idxnext is never used after assign,
> remove it and its assign statement.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Good catch, but Byungchul Park beat you to it.  Please see commit
a72da917f186 ("srcu: Remove dead code in srcu_gp_end()") in -rcu.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index d5cea81..1241715 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -531,7 +531,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
>  	unsigned long flags;
>  	unsigned long gpseq;
>  	int idx;
> -	int idxnext;
>  	unsigned long mask;
>  	struct srcu_data *sdp;
>  	struct srcu_node *snp;
> @@ -555,7 +554,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
> 
>  	/* Initiate callback invocation as needed. */
>  	idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
> -	idxnext = (idx + 1) % ARRAY_SIZE(snp->srcu_have_cbs);
>  	rcu_for_each_node_breadth_first(sp, snp) {
>  		spin_lock_irq_rcu_node(snp);
>  		cbs = false;
> -- 
> 2.1.4
> 
