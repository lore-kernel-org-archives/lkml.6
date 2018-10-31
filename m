Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80494C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16692080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16692080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeKAHp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:45:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbeKAHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:45:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9VMcduH098000
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 18:45:20 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nfkmw3xwa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 18:45:20 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 31 Oct 2018 22:45:19 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 22:45:16 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9VMjFYu37617894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 22:45:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21A41B2065;
        Wed, 31 Oct 2018 22:45:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01F68B205F;
        Wed, 31 Oct 2018 22:45:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 31 Oct 2018 22:45:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DF45E16C35A7; Wed, 31 Oct 2018 15:45:15 -0700 (PDT)
Date:   Wed, 31 Oct 2018 15:45:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     mhillenb@amazon.de, dwmw2@infradead.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Fix for 10-second delay bug for -stable
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18103122-0040-0000-0000-0000048A55DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009962; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110813; UDB=6.00575604; IPR=6.00890906;
 MB=3.00023985; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-31 22:45:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103122-0041-0000-0000-0000089355FF
Message-Id: <20181031224515.GA9255@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have lightly tested the following backport of 92aa39e9dc77 ("rcu:
Make need_resched() respond to urgent RCU-QS needs") on v4.12-v4.19.
Does it look reasonable from your viewpoint?

If I don't hear otherwise, I will send it along to -stable at the end
of this coming weekend, Pacific Time.

This patch does not apply to v4.11 and earlier.  I will therefore
ignore those releases unless someone reproduces the problem on them.

							Thanx, Paul

------------------------------------------------------------------------

commit 0a555b6d58f80dcd93a116c5b197208aeaf9f7ef
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Jul 9 13:47:30 2018 -0700

    rcu: Make need_resched() respond to urgent RCU-QS needs
    
    commit 92aa39e9dc77 upstream.
    
    The per-CPU rcu_dynticks.rcu_urgent_qs variable communicates an urgent
    need for an RCU quiescent state from the force-quiescent-state processing
    within the grace-period kthread to context switches and to cond_resched().
    Unfortunately, such urgent needs are not communicated to need_resched(),
    which is sometimes used to decide when to invoke cond_resched(), for
    but one example, within the KVM vcpu_run() function.  As of v4.15, this
    can result in synchronize_sched() being delayed by up to ten seconds,
    which can be problematic, to say nothing of annoying.
    
    This commit therefore checks rcu_dynticks.rcu_urgent_qs from within
    rcu_check_callbacks(), which is invoked from the scheduling-clock
    interrupt handler.  If the current task is not an idle task and is
    not executing in usermode, a context switch is forced, and either way,
    the rcu_dynticks.rcu_urgent_qs variable is set to false.  If the current
    task is an idle task, then RCU's dyntick-idle code will detect the
    quiescent state, so no further action is required.  Similarly, if the
    task is executing in usermode, other code in rcu_check_callbacks() and
    its called functions will report the corresponding quiescent state.
    
    Reported-by: Marius Hillenbrand <mhillenb@amazon.de>
    Reported-by: David Woodhouse <dwmw2@infradead.org>
    Suggested-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    [ paulmck: Backported to make patch apply cleanly on older versions. ]
    Tested-by: Marius Hillenbrand <mhillenb@amazon.de>
    Cc: <stable@vger.kernel.org> # 4.12.x - 4.19.x

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0b760c1369f7..15301ed19da6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2662,6 +2662,15 @@ void rcu_check_callbacks(int user)
 		rcu_bh_qs();
 	}
 	rcu_preempt_check_callbacks();
+	/* The load-acquire pairs with the store-release setting to true. */
+	if (smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs))) {
+		/* Idle and userspace execution already are quiescent states. */
+		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
+			set_tsk_need_resched(current);
+			set_preempt_need_resched();
+		}
+		__this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
+	}
 	if (rcu_pending())
 		invoke_rcu_core();
 

