Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBSBEd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 20:04:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751884AbeBSBEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 20:04:32 -0500
Date: Sun, 18 Feb 2018 17:04:46 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] srcu: Fix incorrect condition in srcu_funnel_exp_start()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1518598794-26752-1-git-send-email-byungchul.park@lge.com>
 <20180214214245.GS3617@linux.vnet.ibm.com>
 <f9abfde2-ad0d-edab-0a2a-a62515ffe870@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9abfde2-ad0d-edab-0a2a-a62515ffe870@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021901-0048-0000-0000-0000023B6DAA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008556; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00991759; UDB=6.00503788; IPR=6.00771105;
 MB=3.00019625; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-19 01:04:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021901-0049-0000-0000-0000442DCA69
Message-Id: <20180219010446.GS3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190011
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 08:36:30AM +0900, Byungchul Park wrote:
> On 2/15/2018 6:42 AM, Paul E. McKenney wrote:
> >On Wed, Feb 14, 2018 at 05:59:54PM +0900, Byungchul Park wrote:
> >>We should've kept sp->srcu_gp_seq_needed_exp the furthest. But
> >>it probably fails because of the incorrect condition. Fix it.
> >>
> >>Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> >
> >Good catch, and thank you for reviewing the SRCU code, but Ildar Ismagilov
> >beat you to this one.  Please see 574428dee1f3 ("rcu: Fix misprint in
> >srcu_funnel_exp_start") in -rcu.
> 
> Hi Paul,
> 
> I'm sorry I'm late. It's been Lunar New Year holiday since last
> thursday.

Not a problem!

> Do you mean:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> 
> Is this rcu's main dev-tree?

It is indeed!

> Thanks for replying anyway, and happy new year~

And a very happy Lunar New Year to you and yours!!!

							Thanx, Paul

> >>---
> >>  kernel/rcu/srcutree.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >>index d5cea81..44bc0fa 100644
> >>--- a/kernel/rcu/srcutree.c
> >>+++ b/kernel/rcu/srcutree.c
> >>@@ -626,7 +626,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *sp, struct srcu_node *snp,
> >>  		spin_unlock_irqrestore_rcu_node(snp, flags);
> >>  	}
> >>  	spin_lock_irqsave_rcu_node(sp, flags);
> >>-	if (!ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
> >>+	if (ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
> >>  		sp->srcu_gp_seq_needed_exp = s;
> >>  	spin_unlock_irqrestore_rcu_node(sp, flags);
> >>  }
> >>-- 
> >>1.9.1
> >>
> >
> >
> 
> -- 
> Thanks,
> Byungchul
> 
