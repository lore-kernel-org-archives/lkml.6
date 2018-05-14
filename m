Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeENUbz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:31:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751865AbeENUby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:31:54 -0400
Date: Mon, 14 May 2018 13:33:20 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 8/8] rcu: Fix cpustart tracepoint gp_seq number
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-9-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514031541.67247-9-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051420-2213-0000-0000-000002A53301
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009025; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032323; UDB=6.00527748; IPR=6.00811454;
 MB=3.00021111; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 20:31:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051420-2214-0000-0000-00005A1E4D69
Message-Id: <20180514203320.GK26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 08:15:41PM -0700, Joel Fernandes (Google) wrote:
> cpustart shows a stale gp_seq. This is because rdp->gp_seq is updated
> only at the end of the __note_gp_changes function. For this reason, use
> rnp->gp_seq instead. I believe we can't update rdp->gp_seq too early so
> lets just use the gp_seq from rnp instead.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I took this one with the usual commit-log update.  Please take a look!

							Thanx, Paul

------------------------------------------------------------------------

commit 3e14c6a5225d201776edd9a96d9c9b4435855446
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Sun May 13 20:15:41 2018 -0700

    rcu: Fix cpustart tracepoint gp_seq number
    
    The "cpustart" trace event shows a stale gp_seq. This is because it uses
    rdp->gp_seq, which is updated only at the end of the __note_gp_changes()
    function. This commit therefore instead uses rnp->gp_seq.
    
    An alternative fix would be to update rdp->gp_seq earlier, but this would
    break RCU's detection of the beginning of a new-to-this-CPU grace period.
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index de6447dd73de..23b855f5c5cb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1796,7 +1796,7 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 		 * set up to detect a quiescent state, otherwise don't
 		 * go looking for one.
 		 */
-		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpustart"));
+		trace_rcu_grace_period(rsp->name, rnp->gp_seq, TPS("cpustart"));
 		need_gp = !!(rnp->qsmask & rdp->grpmask);
 		rdp->cpu_no_qs.b.norm = need_gp;
 		rdp->rcu_qs_ctr_snap = __this_cpu_read(rcu_dynticks.rcu_qs_ctr);
