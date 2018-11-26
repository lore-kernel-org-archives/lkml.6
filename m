Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AA1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3179E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3179E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeK0GzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:55:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbeK0GzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:55:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAQJrdSA126494
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:59:59 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p0nqjmqhx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:59:58 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 26 Nov 2018 19:59:57 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Nov 2018 19:59:53 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAQJxqvj17629414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 19:59:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C993B205F;
        Mon, 26 Nov 2018 19:59:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3997CB2067;
        Mon, 26 Nov 2018 19:59:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 26 Nov 2018 19:59:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D61C816C3623; Mon, 26 Nov 2018 11:59:54 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:59:54 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 23/41] sched: Replace synchronize_sched()
 with synchronize_rcu()
Reply-To: paulmck@linux.ibm.com
References: <20181112001233.GC3056@worktop>
 <20181112004528.GA4170@linux.ibm.com>
 <20181112005329.GG3056@worktop>
 <20181112014736.GB4170@linux.ibm.com>
 <20181112020710.GJ3056@worktop>
 <20181112022455.GD4170@linux.ibm.com>
 <20181112090047.GN3056@worktop>
 <20181112132852.GH4170@linux.ibm.com>
 <20181112181741.GA3097@worktop.psav.com>
 <20181112222112.GW4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112222112.GW4170@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112619-2213-0000-0000-0000031FACD9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010125; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123156; UDB=6.00583035; IPR=6.00903286;
 MB=3.00024340; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 19:59:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112619-2214-0000-0000-00005C649C13
Message-Id: <20181126195954.GA9143@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 02:21:12PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 12, 2018 at 07:17:41PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 12, 2018 at 05:28:52AM -0800, Paul E. McKenney wrote:
> > > On Mon, Nov 12, 2018 at 10:00:47AM +0100, Peter Zijlstra wrote:
> > 
> > > > Still, better safe than sorry. It was a rather big change in behaviour,
> > > > so it wouldn't have been strange to call that out.
> > > 
> > > This guy:
> > > 
> > > 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
> > > 
> > > Has a commit log that says:
> > > 
> > > 	Now that RCU-preempt knows about preemption disabling, its
> > > 	implementation of synchronize_rcu() works for synchronize_sched(),
> > > 	and likewise for the other RCU-sched update-side API members.
> > > 	This commit therefore confines the RCU-sched update-side code
> > > 	to CONFIG_PREEMPT=n builds, and defines RCU-sched's update-side
> > > 	API members in terms of those of RCU-preempt.
> > > 
> > > That last phrase seems pretty explicit.  What am I missing here?
> > 
> > That does not explicitly state that because RCU-preempt
> > synchornize_rcu() can take _much_ longer, the new synchronize_sched()
> > can now take _much_ longer too.
> > 
> > So when someone bisects a problem to this commit; and he reads the
> > Changelog, he might get the impression that was unexpected.
> 
> Of course, a preempt_disable() section of code can still be preempted
> by the underlying hypervisor, so in a surprisingly large fraction of
> the installed base, there really isn't that much difference.
> 
> > > Not that it matters, given that I know of no way to change a mainlined
> > > commit log.  I suppose I could ask Jon if he would be willing to take
> > > a 2018 RCU API LWN article, if that would help.
> > 
> > Yes, it is water under the bridge; but Changelogs should be explicit
> > about behavioural changes.
> > 
> > And while the merged RCU has the semantic behaviour required, the timing
> > behaviour did change significantly.
> 
> When running on bare metal, potentially.  From what I see, preemption
> of RCU read-side critical sections is the exception rather than the rule.
> And again, when running on hypervisors, even irq-disable regions of code
> can be preempted.  (And yes, there is work in flight to allow RCU to deal
> with this.)
> 
> > > > > > Again, the patch didn't say that.
> > > > > > 
> > > > > > If the Changelog would've read something like:
> > > > > > 
> > > > > > "Since synchronize_sched() is now equivalent to synchronize_rcu(),
> > > > > > replace the synchronize_sched() usage such that we can eventually remove
> > > > > > the interface."
> > > > > > 
> > > > > > It would've been clear that the patch is a nop and what the purpose
> > > > > > was.
> > > > > 
> > > > > I can easily make that change.
> > > > 
> > > > Please, sufficient doesn't imply necessary etc.. A changelog should
> > > > always clarify why we do the patch.
> > > 
> > > ???  Did you mean to say "necessary doesn't imply sufficient"?  If so,
> > > what else do you feel is missing?
> > 
> > No, I meant to say that your original Changelog only states that
> > sync_rcu now covers rcu-sched behaviour.  Which means that the change is
> > sufficient.
> > 
> > It completely and utterly fails to explain _why_ you're doing the
> > change. Ie. you do not address why it is necessary.
> > 
> > A Changelog should always explain why the change is needed.
> > 
> > In this case because you want to get rid of the sync_sched() api.
> 
> Right, which is stated in your suggested wording above.  So I am still
> not seeing what you want added to this:
> 
> 	"Since synchronize_sched() is now equivalent to synchronize_rcu(),
> 	replace the synchronize_sched() usage such that we can eventually
> 	remove the interface."

Finally getting back to this.  I removed this commit from the group that
I intend to send in next week's -tip pull request, and updated its commit
log as shown below.  Does this work for you?

							Thanx, Paul

------------------------------------------------------------------------

commit 52ffe7fbe615e8989f054432c76a7e43b8c35607
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Tue Nov 6 19:13:54 2018 -0800

    sched: Replace synchronize_sched() with synchronize_rcu()
    
    Now that synchronize_rcu() waits for preempt-disable regions of
    code as well as RCU read-side critical sections, synchronize_sched()
    can be replaced by synchronize_rcu(), in fact, synchronize_sched()
    is now completely equivalent to synchronize_rcu().  This commit
    therefore replaces synchronize_sched() with synchronize_rcu() so that
    synchronize_sched() can eventually be removed entirely.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Peter Zijlstra <peterz@infradead.org>

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 5e54cbcae673..90fee8e01280 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -51,8 +51,8 @@ EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
  *
  * Clear the update_util_data pointer for the given CPU.
  *
- * Callers must use RCU-sched callbacks to free any memory that might be
- * accessed via the old update_util_data pointer or invoke synchronize_sched()
+ * Callers must use RCU callbacks to free any memory that might be
+ * accessed via the old update_util_data pointer or invoke synchronize_rcu()
  * right after this function to avoid use-after-free.
  */
 void cpufreq_remove_update_util_hook(int cpu)
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3fffad3bc8a8..6a1bb76afbd1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -839,7 +839,7 @@ static void sugov_stop(struct cpufreq_policy *policy)
 	for_each_cpu(cpu, policy->cpus)
 		cpufreq_remove_update_util_hook(cpu);
 
-	synchronize_sched();
+	synchronize_rcu();
 
 	if (!policy->fast_switch_enabled) {
 		irq_work_sync(&sg_policy->irq_work);

