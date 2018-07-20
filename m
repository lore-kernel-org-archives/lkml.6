Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC17ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8CC204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8CC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeGUAWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:22:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727812AbeGUAWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:22:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KNUPPk106834
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 19:32:15 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kbnkgpcsv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 19:32:14 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 20 Jul 2018 19:32:13 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Jul 2018 19:32:11 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6KNWARM1900970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jul 2018 23:32:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33F9FB206E;
        Fri, 20 Jul 2018 19:31:58 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04B08B206A;
        Fri, 20 Jul 2018 19:31:57 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jul 2018 19:31:57 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0EAAF16CA2D3; Fri, 20 Jul 2018 16:32:12 -0700 (PDT)
Date:   Fri, 20 Jul 2018 16:32:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Chen <david.chen@nutanix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RCU nocb list not reclaiming causing OOM
Reply-To: paulmck@linux.vnet.ibm.com
References: <BYAPR02MB4501B990E353A2616594821294510@BYAPR02MB4501.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB4501B990E353A2616594821294510@BYAPR02MB4501.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072023-0040-0000-0000-00000451E965
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009400; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01063743; UDB=6.00546277; IPR=6.00841594;
 MB=3.00022236; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-20 23:32:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072023-0041-0000-0000-000008581808
Message-Id: <20180720233212.GC12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:05:52PM +0000, David Chen wrote:
> Hi Paul,
> 
> We hit an RCU issue on 4.9.37 kernel. One of the nocb_follower list grows too
> large, and not getting reclaimed, causing the system to OOM.
> 
> Printing the culprit rcu_sched_data:
> 
>   nocb_q_count = {
>     counter = 32369635
>   },
>   nocb_follower_head = 0xffff88ae901c0a00,
>   nocb_follower_tail = 0xffff88af1538b8d8,
>   nocb_kthread = 0xffff88b06d290000,
> 
> As you can see here, the nocb_follower_head is not empty, so in theory, the
> nocb_kthread shouldn't go to sleep. However, if dump the stack of the kthread:
> 
> crash> bt 0xffff88b06d290000
> PID: 21     TASK: ffff88b06d290000  CPU: 3   COMMAND: "rcuos/1"
>  #0 [ffffafc9020b7dc0] __schedule at ffffffff8d8789dc
>  #1 [ffffafc9020b7e38] schedule at ffffffff8d878e76
>  #2 [ffffafc9020b7e50] rcu_nocb_kthread at ffffffff8d112337
>  #3 [ffffafc9020b7ec8] kthread at ffffffff8d0c6ce7
>  #4 [ffffafc9020b7f50] ret_from_fork at ffffffff8d87d755
> 
> And if we dis the address at ffffffff8d112337:
> 
> /usr/src/debug/kernel-4.9.37/linux-4.9.37-29.nutanix.07142017.el7.centos.x86_64/kernel/rcu/tree_plugin.h: 2106
> 0xffffffff8d11232d <rcu_nocb_kthread+381>:      test   %rax,%rax
> 0xffffffff8d112330 <rcu_nocb_kthread+384>:      jne    0xffffffff8d112355 <rcu_nocb_kthread+421>
> 0xffffffff8d112332 <rcu_nocb_kthread+386>:      callq  0xffffffff8d878e40 <schedule>
> 0xffffffff8d112337 <rcu_nocb_kthread+391>:      lea    -0x40(%rbp),%rsi
> 
> So the kthread is blocked at swait_event_interruptible in the nocb_follower_wait.
> This contradict with the fact that nocb_follower_head was not empty. So I
> wonder if this is caused by the lack of memory barrier in the place shown below.
> If the head is set to NULL after doing xchg, it will overwrite the head set
> by leader. This caused the kthread to sleep the next iteration, and the leader
> won't wake him up as the tail doesn't point to head.
> 
> Please tell me what do you think.
> 
> Thanks,
> David
> 
> diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel/rcu/tree_plugin.h
> --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h	2017-07-12 06:42:41.000000000 -0700
> +++ linux-4.9.37/kernel/rcu/tree_plugin.h	2018-07-20 15:25:57.311206343 -0700
> @@ -2149,6 +2149,7 @@
>  		BUG_ON(!list);
>  		trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, "WokeNonEmpty");
>  		WRITE_ONCE(rdp->nocb_follower_head, NULL);
> +		smp_mb();
>  		tail = xchg(&rdp->nocb_follower_tail, &rdp->nocb_follower_head);

The xchg() operation implies full memory barriers both before and after,
so adding the smp_mb() before would have no effect.

But let me take a look at post-4.9 changes to this code...

I suggest trying out the following commit:

6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")

If that one doesn't help, the following might be worth trying, but probably
a lot harder to backport:

8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups")

Please let me know how it goes!

							Thanx, Paul

------------------------------------------------------------------------

commit 6b5fc3a1331810db407c9e0e673dc1837afdc9d0
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Fri Apr 28 20:11:09 2017 -0700

    rcu: Add memory barriers for NOCB leader wakeup
    
    Wait/wakeup operations do not guarantee ordering on their own.  Instead,
    either locking or memory barriers are required.  This commit therefore
    adds memory barriers to wake_nocb_leader() and nocb_leader_wait().
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Tested-by: Krister Johansen <kjlx@templeofstupid.com>
    Cc: <stable@vger.kernel.org> # 4.6.x

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0b1042545116..573fbe9640a0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1810,6 +1810,7 @@ static void wake_nocb_leader(struct rcu_data *rdp, bool force)
 	if (READ_ONCE(rdp_leader->nocb_leader_sleep) || force) {
 		/* Prior smp_mb__after_atomic() orders against prior enqueue. */
 		WRITE_ONCE(rdp_leader->nocb_leader_sleep, false);
+		smp_mb(); /* ->nocb_leader_sleep before swake_up(). */
 		swake_up(&rdp_leader->nocb_wq);
 	}
 }
@@ -2064,6 +2065,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 	 * nocb_gp_head, where they await a grace period.
 	 */
 	gotcbs = false;
+	smp_mb(); /* wakeup before ->nocb_head reads. */
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_follower) {
 		rdp->nocb_gp_head = READ_ONCE(rdp->nocb_head);
 		if (!rdp->nocb_gp_head)

