Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183ABC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF3E2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfATBHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 20:07:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728926AbfATBHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 20:07:41 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0K14ATE017680
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 20:07:40 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q4cy2bxb4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 20:07:39 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 20 Jan 2019 01:07:38 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 20 Jan 2019 01:07:35 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0K17YLc24641654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Jan 2019 01:07:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6037CB2064;
        Sun, 20 Jan 2019 01:07:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18996B205F;
        Sun, 20 Jan 2019 01:07:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.152.170])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 20 Jan 2019 01:07:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 95E5116C35B2; Sat, 19 Jan 2019 17:07:32 -0800 (PST)
Date:   Sat, 19 Jan 2019 17:07:32 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] rcu: Avoid unnecessary softirq when system is idle
Reply-To: paulmck@linux.ibm.com
References: <20190119161418.231042-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119161418.231042-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012001-0040-0000-0000-000004B48D57
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010439; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01148964; UDB=6.00593882; IPR=6.00929272;
 MB=3.00025206; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-20 01:07:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012001-0041-0000-0000-000008BF998B
Message-Id: <20190120010732.GH4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-19_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=864 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901200007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:14:18AM -0500, Joel Fernandes (Google) wrote:
> When there are no callbacks pending on an idle system, I noticed that
> RCU softirq is continuously firing. During this the cpu_no_qs is set to
> false, and core_needs_qs is set to true indefinitely. This causes
> rcu_process_callbacks to be repeatedly called, even though the node
> corresponding to the CPU has that CPU's mask bit cleared and the system
> is idle. I believe the race is when such mask clearing is done during
> idle CPU scan of the quiescent state forcing stage in the kthread
> instead of the softirq. Since the rnp mask is cleared, but the flags on
> the CPU's rdp are not cleared, the CPU thinks it still needs to report
> to core RCU.
> 
> Cure this by clearing the core_needs_qs flag when the CPU detects that
> its node is already updated which will avoid the unwanted softirq raises
> to the benefit of real-time systems.
> 
> Test: Ran rcutorture for various tree RCU configs.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9180158756d2..96ad80c76b15 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2273,6 +2273,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
>  	}
>  	mask = rdp->grpmask;
>  	if ((rnp->qsmask & mask) == 0) {
> +		rdp->core_needs_qs = false;
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	} else {
>  		rdp->core_needs_qs = false;
> -- 
> 2.20.1.321.g9e740568ce-goog
> 

