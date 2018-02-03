Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeBCUMp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 15:12:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752995AbeBCUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 15:12:37 -0500
Date: Sat, 3 Feb 2018 01:18:35 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ildar Ismagilov <devix84@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] srcu: reduce scans of srcu_data in counter wrap check
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180131194221.28544-1-devix84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131194221.28544-1-devix84@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020320-0048-0000-0000-00000231D789
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008466; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00984559; UDB=6.00499431; IPR=6.00763837;
 BA=6.00005810; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019353; XFM=3.00000015;
 UTC=2018-02-03 20:12:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020320-0049-0000-0000-00004401DA71
Message-Id: <20180203091835.GG3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802030269
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 10:42:21PM +0300, Ildar Ismagilov wrote:
> This patch reduce scans of srcu_data in case of a srcu_struct
> tree have more than one levels

Good catch!!!  Applied for testing and review.

I had to hand-apply this patch as well, and also fill out the commit log.
In addition, in the future, please capitalize the word in the Subject
line following the colon (":").  Please see below for the updated commit
and again please let me know if I messed something up.

							Thanx, Paul

------------------------------------------------------------------------

commit bcec03ee2e43f2a24c61a99709d4dd1aa90438c2
Author: Ildar Ismagilov <devix84@gmail.com>
Date:   Wed Jan 31 22:42:21 2018 +0300

    srcu: Reduce scans of srcu_data in counter wrap check
    
    Currently, given a multi-level srcu_node tree, SRCU can scan the full
    set of srcu_data structures at each level when cleaning up after a grace
    period.  This, though harmless otherwise, represents pointless overhead.
    This commit therefore eliminates this overhead by scanning the srcu_data
    structures only when traversing the leaf srcu_node structures.
    
    Signed-off-by: Ildar Ismagilov <devix84@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ad3e1aa5e6ea..72dc6e39be14 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -527,6 +527,7 @@ static void srcu_gp_end(struct srcu_struct *sp)
 {
 	unsigned long cbdelay;
 	bool cbs;
+	bool last_lvl;
 	int cpu;
 	unsigned long flags;
 	unsigned long gpseq;
@@ -559,7 +560,8 @@ static void srcu_gp_end(struct srcu_struct *sp)
 	rcu_for_each_node_breadth_first(sp, snp) {
 		spin_lock_irq_rcu_node(snp);
 		cbs = false;
-		if (snp >= sp->level[rcu_num_lvls - 1])
+		last_lvl = snp >= sp->level[rcu_num_lvls - 1];
+		if (last_lvl)
 			cbs = snp->srcu_have_cbs[idx] == gpseq;
 		snp->srcu_have_cbs[idx] = gpseq;
 		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
@@ -572,7 +574,7 @@ static void srcu_gp_end(struct srcu_struct *sp)
 			srcu_schedule_cbs_snp(sp, snp, mask, cbdelay);
 
 		/* Occasionally prevent srcu_data counter wrap. */
-		if (!(gpseq & counter_wrap_check))
+		if (!(gpseq & counter_wrap_check) && last_lvl)
 			for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
 				sdp = per_cpu_ptr(sp->sda, cpu);
 				spin_lock_irqsave_rcu_node(sdp, flags);
