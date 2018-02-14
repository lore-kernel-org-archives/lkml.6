Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031575AbeBNVmg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:42:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031344AbeBNVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:42:33 -0500
Date: Wed, 14 Feb 2018 13:42:45 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] srcu: Fix incorrect condition in srcu_funnel_exp_start()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1518598794-26752-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518598794-26752-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021421-0040-0000-0000-000003F715B0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008535; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000253; SDB=6.00989773; UDB=6.00502609; IPR=6.00769127;
 MB=3.00019556; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-14 21:42:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021421-0041-0000-0000-000007F815DD
Message-Id: <20180214214245.GS3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802140254
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 05:59:54PM +0900, Byungchul Park wrote:
> We should've kept sp->srcu_gp_seq_needed_exp the furthest. But
> it probably fails because of the incorrect condition. Fix it.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>

Good catch, and thank you for reviewing the SRCU code, but Ildar Ismagilov
beat you to this one.  Please see 574428dee1f3 ("rcu: Fix misprint in
srcu_funnel_exp_start") in -rcu.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index d5cea81..44bc0fa 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -626,7 +626,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *sp, struct srcu_node *snp,
>  		spin_unlock_irqrestore_rcu_node(snp, flags);
>  	}
>  	spin_lock_irqsave_rcu_node(sp, flags);
> -	if (!ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
> +	if (ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
>  		sp->srcu_gp_seq_needed_exp = s;
>  	spin_unlock_irqrestore_rcu_node(sp, flags);
>  }
> -- 
> 1.9.1
> 
