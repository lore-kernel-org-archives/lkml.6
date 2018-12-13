Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC72C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0601720870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0601720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeLMEka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:40:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728410AbeLMEk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:40:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBD4chcs015995
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 23:40:27 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pbasqxq0u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 23:40:26 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 13 Dec 2018 04:40:25 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Dec 2018 04:40:22 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBD4eLop21364990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 04:40:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 368F3B2064;
        Thu, 13 Dec 2018 04:40:21 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3553B205F;
        Thu, 13 Dec 2018 04:40:20 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.223.5])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Dec 2018 04:40:20 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8713F16C5F3F; Wed, 12 Dec 2018 20:40:20 -0800 (PST)
Date:   Wed, 12 Dec 2018 20:40:20 -0800
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
        "Sun, Yi J" <yi.j.sun@intel.com>
Subject: Re: rcu_preempt caused oom
Reply-To: paulmck@linux.ibm.com
References: <CD6925E8781EFD4D8E11882D20FC406D52A18E53@SHSMSX104.ccr.corp.intel.com>
 <20181212022446.GV4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A192C3@SHSMSX104.ccr.corp.intel.com>
 <20181212154224.GX4170@linux.ibm.com>
 <20181212210316.GA14777@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A193C3@SHSMSX104.ccr.corp.intel.com>
 <20181213001214.GE4170@linux.ibm.com>
 <88DC34334CA3444C85D647DBFA962C2735AD5F77@SHSMSX104.ccr.corp.intel.com>
 <20181213024234.GF4170@linux.ibm.com>
 <88DC34334CA3444C85D647DBFA962C2735AD5F9E@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88DC34334CA3444C85D647DBFA962C2735AD5F9E@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121304-0040-0000-0000-000004A1C984
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010217; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01131001; UDB=6.00577119; IPR=6.00911132;
 MB=3.00024675; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-13 04:40:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121304-0041-0000-0000-000008AAEBCA
Message-Id: <20181213044020.GA19765@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 03:28:46AM +0000, Zhang, Jun wrote:
> Ok, we will test it, thanks!

But please also try the sysrq-y with the earlier patch after a hang!

							Thanx, Paul

> -----Original Message-----
> From: Paul E. McKenney [mailto:paulmck@linux.ibm.com] 
> Sent: Thursday, December 13, 2018 10:43
> To: Zhang, Jun <jun.zhang@intel.com>
> Cc: He, Bo <bo.he@intel.com>; Steven Rostedt <rostedt@goodmis.org>; linux-kernel@vger.kernel.org; josh@joshtriplett.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>; Sun, Yi J <yi.j.sun@intel.com>
> Subject: Re: rcu_preempt caused oom
> 
> On Thu, Dec 13, 2018 at 02:11:35AM +0000, Zhang, Jun wrote:
> > Hello, Paul
> > 
> > I think the next patch is better.
> > Because ULONG_CMP_GE could cause double write, which has risk that write back old value.
> > Please help review.
> > I don't test it. If you agree, we will test it.
> 
> Just to make sure that I understand, you are worried about something like the following, correct?
> 
> o	__note_gp_changes() compares rnp->gp_seq_needed and rdp->gp_seq_needed
> 	and finds them equal.
> 
> o	At just this time something like rcu_start_this_gp() assigns a new
> 	(larger) value to rdp->gp_seq_needed.
> 
> o	Then __note_gp_changes() overwrites rdp->gp_seq_needed with the
> 	old value.
> 
> This cannot happen because __note_gp_changes() runs with interrupts disabled on the CPU corresponding to the rcu_data structure referenced by the rdp pointer.  So there is no way for rcu_start_this_gp() to be invoked on the same CPU during this "if" statement.
> 
> Of course, there could be bugs.  For example:
> 
> o	__note_gp_changes() might be called on a different CPU than that
> 	corresponding to rdp.  You can check this with something like:
> 
> 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
> 
> o	The same things could happen with rcu_start_this_gp(), and the
> 	above WARN_ON_ONCE() would work there as well.
> 
> o	rcutree_prepare_cpu() is a special case, but is irrelevant unless
> 	you are doing CPU-hotplug operations.  (It can run on a CPU other
> 	than rdp->cpu, but only at times when rdp->cpu is offline.)
> 
> o	Interrupts might not really be disabled.
> 
> That said, your patch could reduce overhead slightly, given that the two values will be equal much of the time.  So it might be worth testing just for that reason.
> 
> So why not just test it anyway?  If it makes the bug go away, I will be surprised, but it would not be the first surprise for me.  ;-)
> 
> 							Thanx, Paul
> 
> > Thanks!
> > 
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 
> > 0b760c1..c00f34e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1849,7 +1849,7 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
> >                 zero_cpu_stall_ticks(rdp);
> >         }
> >         rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
> > -       if (ULONG_CMP_GE(rnp->gp_seq_needed, rdp->gp_seq_needed) || rdp->gpwrap)
> > +       if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || 
> > + rdp->gpwrap)
> >                 rdp->gp_seq_needed = rnp->gp_seq_needed;
> >         WRITE_ONCE(rdp->gpwrap, false);
> >         rcu_gpnum_ovf(rnp, rdp);
> > 
> > 
> > -----Original Message-----
> > From: Paul E. McKenney [mailto:paulmck@linux.ibm.com]
> > Sent: Thursday, December 13, 2018 08:12
> > To: He, Bo <bo.he@intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>; 
> > linux-kernel@vger.kernel.org; josh@joshtriplett.org; 
> > mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Zhang, Jun 
> > <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin 
> > <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>; Sun, Yi J 
> > <yi.j.sun@intel.com>
> > Subject: Re: rcu_preempt caused oom
> > 
> > On Wed, Dec 12, 2018 at 11:13:22PM +0000, He, Bo wrote:
> > > I don't see the rcutree.sysrq_rcu parameter in v4.19 kernel, I also checked the latest kernel and the latest tag v4.20-rc6, not see the sysrq_rcu.
> > > Please correct me if I have something wrong.
> > 
> > That would be because I sent you the wrong patch, apologies!  :-/
> > 
> > Please instead see the one below, which does add sysrq_rcu.
> > 
> > 							Thanx, Paul
> > 
> > > -----Original Message-----
> > > From: Paul E. McKenney <paulmck@linux.ibm.com>
> > > Sent: Thursday, December 13, 2018 5:03 AM
> > > To: He, Bo <bo.he@intel.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>; 
> > > linux-kernel@vger.kernel.org; josh@joshtriplett.org; 
> > > mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Zhang, Jun 
> > > <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin 
> > > <yanmin.zhang@intel.com>; Bai, Jie A <jie.a.bai@intel.com>
> > > Subject: Re: rcu_preempt caused oom
> > > 
> > > On Wed, Dec 12, 2018 at 07:42:24AM -0800, Paul E. McKenney wrote:
> > > > On Wed, Dec 12, 2018 at 01:21:33PM +0000, He, Bo wrote:
> > > > > we reproduce on two boards, but I still not see the show_rcu_gp_kthreads() dump logs, it seems the patch can't catch the scenario.
> > > > > I double confirmed the CONFIG_PROVE_RCU=y is enabled in the config as it's extracted from the /proc/config.gz.
> > > > 
> > > > Strange.
> > > > 
> > > > Are the systems responsive to sysrq keys once failure occurs?  If 
> > > > so, I will provide you a sysrq-R or some such to dump out the RCU state.
> > > 
> > > Or, as it turns out, sysrq-y if booting with rcutree.sysrq_rcu=1 using the patch below.  Only lightly tested.
> > 
> > ----------------------------------------------------------------------
> > --
> > 
> > commit 04b6245c8458e8725f4169e62912c1fadfdf8141
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Wed Dec 12 16:10:09 2018 -0800
> > 
> >     rcu: Add sysrq rcu_node-dump capability
> >     
> >     Backported from v4.21/v5.0
> >     
> >     Life is hard if RCU manages to get stuck without triggering RCU CPU
> >     stall warnings or triggering the rcu_check_gp_start_stall() checks
> >     for failing to start a grace period.  This commit therefore adds a
> >     boot-time-selectable sysrq key (commandeering "y") that allows manually
> >     dumping Tree RCU state.  The new rcutree.sysrq_rcu kernel boot parameter
> >     must be set for this sysrq to be available.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 
> > 0b760c1369f7..e9392a9d6291 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -61,6 +61,7 @@
> >  #include <linux/trace_events.h>
> >  #include <linux/suspend.h>
> >  #include <linux/ftrace.h>
> > +#include <linux/sysrq.h>
> >  
> >  #include "tree.h"
> >  #include "rcu.h"
> > @@ -128,6 +129,9 @@ int num_rcu_lvl[] = NUM_RCU_LVL_INIT;  int 
> > rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in 
> > use. */
> >  /* panic() on RCU Stall sysctl. */
> >  int sysctl_panic_on_rcu_stall __read_mostly;
> > +/* Commandeer a sysrq key to dump RCU's tree. */ static bool 
> > +sysrq_rcu; module_param(sysrq_rcu, bool, 0444);
> >  
> >  /*
> >   * The rcu_scheduler_active variable is initialized to the value @@ 
> > -662,6 +666,27 @@ void show_rcu_gp_kthreads(void)  }  
> > EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
> >  
> > +/* Dump grace-period-request information due to commandeered sysrq. 
> > +*/ static void sysrq_show_rcu(int key) {
> > +	show_rcu_gp_kthreads();
> > +}
> > +
> > +static struct sysrq_key_op sysrq_rcudump_op = {
> > +	.handler = sysrq_show_rcu,
> > +	.help_msg = "show-rcu(y)",
> > +	.action_msg = "Show RCU tree",
> > +	.enable_mask = SYSRQ_ENABLE_DUMP,
> > +};
> > +
> > +static int __init rcu_sysrq_init(void) {
> > +	if (sysrq_rcu)
> > +		return register_sysrq_key('y', &sysrq_rcudump_op);
> > +	return 0;
> > +}
> > +early_initcall(rcu_sysrq_init);
> > +
> >  /*
> >   * Send along grace-period-related data for rcutorture diagnostics.
> >   */
> > 
> 

