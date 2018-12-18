Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DE2217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeLRFea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:34:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbeLRFea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:34:30 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBI5XSTB058716
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:34:28 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pepctser8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:34:28 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 18 Dec 2018 05:34:27 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 05:34:23 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBI5YMR614352534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 05:34:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBB18B2067;
        Tue, 18 Dec 2018 05:34:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 963BDB205F;
        Tue, 18 Dec 2018 05:34:22 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 18 Dec 2018 05:34:22 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1541916C11E1; Mon, 17 Dec 2018 21:34:26 -0800 (PST)
Date:   Mon, 17 Dec 2018 21:34:26 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Zhang, Jun" <jun.zhang@intel.com>
Cc:     "He, Bo" <bo.he@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>,
        "Sun, Yi J" <yi.j.sun@intel.com>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "Mei, Paul" <paul.mei@intel.com>
Subject: Re: rcu_preempt caused oom
Reply-To: paulmck@linux.ibm.com
References: <20181213181136.GL4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A198C7@SHSMSX104.ccr.corp.intel.com>
 <20181214021527.GR4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A19939@SHSMSX104.ccr.corp.intel.com>
 <20181214051011.GS4170@linux.ibm.com>
 <20181214053841.GA16100@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A1A280@SHSMSX104.ccr.corp.intel.com>
 <20181217042623.GF4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A1A634@SHSMSX104.ccr.corp.intel.com>
 <88DC34334CA3444C85D647DBFA962C2735AD64A0@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88DC34334CA3444C85D647DBFA962C2735AD64A0@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121805-0064-0000-0000-0000038808DE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010241; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01133371; UDB=6.00589186; IPR=6.00913539;
 MB=3.00024728; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-18 05:34:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121805-0065-0000-0000-00003BB834C1
Message-Id: <20181218053426.GP4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:46:43AM +0000, Zhang, Jun wrote:
> Hello, paul
> 
> In softirq context, and current is rcu_preempt-10,  rcu_gp_kthread_wake don't wakeup rcu_preempt.
> Maybe next patch could fix it. Please help review.
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0b760c1..98f5b40 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1697,7 +1697,7 @@ static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
>   */
>  static void rcu_gp_kthread_wake(struct rcu_state *rsp)
>  {
> -       if (current == rsp->gp_kthread ||
> +       if (((current == rsp->gp_kthread) && !in_softirq()) ||

Close, but not quite.  Please see below.

>             !READ_ONCE(rsp->gp_flags) ||
>             !rsp->gp_kthread)
>                 return;
> 
> [44932.311439, 0][     rcu_preempt]      rcu_preempt-10    [001] .n.. 44929.401037: rcu_grace_period: rcu_preempt 19063548 reqwait
> ......
> [44932.311517, 0][     rcu_preempt]      rcu_preempt-10    [001] d.s2 44929.402234: rcu_future_grace_period: rcu_preempt 19063548 19063552 0 0 3 Startleaf
> [44932.311536, 0][     rcu_preempt]      rcu_preempt-10    [001] d.s2 44929.402237: rcu_future_grace_period: rcu_preempt 19063548 19063552 0 0 3 Startedroot

Good catch!  If the rcu_preempt kthread had just entered the function
swait_event_idle_exclusive(), which had just called __swait_event_idle()
which had just called ___swait_event(), which had just gotten done
checking the "condition", then yes, the rcu_preempt kthread could
sleep forever.  This is a very narrow race window, but that matches
your experience with its not happening often -- and my experience with
it not happening at all.

However, for this to happen, the wakeup must happen within a softirq
handler that executes upon return from an interrupt that interrupted
___swait_event() just after the "if (condition)".  For this, we don't want
in_softirq() but rather in_serving_softirq(), as shown in the patch below.
The patch you have above could result in spurious wakeups, as it is
checking for bottom halves being disabled, not just executing within a
softirq handler.  Which might be better than not having enough wakeups,
but let's please try for just the right number.  ;-)

So could you please instead test the patch below?

And if it works, could I please have your Signed-off-by so that I can
queue it?  My patch is quite clearly derived from yours, after all!
And you should get credit for finding the problem and arriving at an
approximate fix, after all.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e9392a9d6291..b9205b40b621 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1722,7 +1722,7 @@ static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
  */
 static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 {
-	if (current == rsp->gp_kthread ||
+	if ((current == rsp->gp_kthread && !in_serving_softirq()) ||
 	    !READ_ONCE(rsp->gp_flags) ||
 	    !rsp->gp_kthread)
 		return;

