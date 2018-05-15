Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeEOEJr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 00:09:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752153AbeEOEJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 00:09:46 -0400
Date: Mon, 14 May 2018 21:11:11 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Report a quiescent state of TASKS_RCU on a tick
 from user
Reply-To: paulmck@linux.vnet.ibm.com
References: <1526344426-31836-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526344426-31836-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051504-0024-0000-0000-000003590BB1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009027; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032476; UDB=6.00527839; IPR=6.00811607;
 MB=3.00021118; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 04:09:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051504-0025-0000-0000-000048042BD4
Message-Id: <20180515041111.GC26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150041
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:33:46AM +0900, Byungchul Park wrote:
> Hello Paul,
> 
> You removed the reporing while simplifying the commit 508880df6 :)
> Fold this patch onto the commit or add, whatever you want.

First, thank you for checking!

But second, the removal was intentional.  Tiny RCU only exists in
PREEMPT=n kernels, and in such kernels there can be no RCU-tasks.
This is the reason for this line in the new commit log:

[ paulmck: Simplify rcutiny portion given no RCU-tasks for !PREEMPT. ]

							Thanx, Paul

> Thanks,
> Byungchul
> 
> ----->8-----
> >From 18a2d8da3baf79d0edd5ccf94abe6f989da5b1c1 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul.park@lge.com>
> Date: Tue, 15 May 2018 09:21:43 +0900
> Subject: [PATCH] rcu: Report a quiescent state of TASKS_RCU on a tick from
>  user
> 
> The reporting was removed while simplifying the commit 508880df6 (rcu:
> Improve rcu_note_voluntary_context_switch() reporting). Add it back.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/rcu/tiny.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index befc932..3345596 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -120,8 +120,10 @@ void rcu_bh_qs(void)
>   */
>  void rcu_check_callbacks(int user)
>  {
> -	if (user)
> +	if (user) {
>  		rcu_sched_qs();
> +		rcu_tasks_qs();
> +	}
>  	if (user || !in_softirq())
>  		rcu_bh_qs();
>  }
> -- 
> 1.9.1
> 
