Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934753AbeEWTdm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:33:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934690AbeEWTdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:33:32 -0400
Date: Wed, 23 May 2018 12:23:49 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
        kernel-team@android.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] rcu: Use better variable names in funnel locking loop
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523063815.198302-1-joel@joelfernandes.org>
 <20180523063815.198302-4-joel@joelfernandes.org>
 <20180523160617.GM3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523160617.GM3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052319-8235-0000-0000-00000D8F3D74
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009073; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036623; UDB=6.00530321; IPR=6.00815751;
 MB=3.00021262; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 19:33:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052319-8236-0000-0000-0000411CA5EC
Message-Id: <20180523192349.GA5845@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 09:06:17AM -0700, Paul E. McKenney wrote:
> On Tue, May 22, 2018 at 11:38:14PM -0700, Joel Fernandes wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > The funnel locking loop in rcu_start_this_gp uses rcu_root as a
> > temporary variable while walking the combining tree. This causes a
> > tiresome exercise of a code reader reminding themselves that rcu_root
> > may not be root. Lets just call it rnp, and rename other variables as
> > well to be more appropriate.
> > 
> > Original patch: https://patchwork.kernel.org/patch/10396577/
> > 
> > Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I used to have double Signed-off-by back when I was seconded to Linaro.
> But I am guessing that you want the second and don't need the first
> one.  Unless you tell me otherwise, I will remove the first one on
> my next rebase.
> 
> Anyway, the new variable names are much more clear, good stuff,
> queued for further review and testing, thank you!

And it looks to me like I should fold in the patchlet below to change to
rnp_start in a comment.  Please let me know if this would mess things up.

							Thanx, Paul

------------------------------------------------------------------------

commit 94ce05d9d110b8c34eca6641ca5221c1b150e99f
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed May 23 12:22:01 2018 -0700

    fixup! rcu: Use better variable names in funnel locking loop
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 65e49282429c..fdba8ab95e2c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1550,11 +1550,11 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	/*
 	 * Use funnel locking to either acquire the root rcu_node
 	 * structure's lock or bail out if the need for this grace period
-	 * has already been recorded -- or has already started.  If there
-	 * is already a grace period in progress in a non-leaf node, no
-	 * recording is needed because the end of the grace period will
-	 * scan the leaf rcu_node structures.  Note that rnp->lock must
-	 * not be released.
+	 * has already been recorded -- or if that grace period has in
+	 * fact already started.  If there is already a grace period in
+	 * progress in a non-leaf node, no recording is needed because the
+	 * end of the grace period will scan the leaf rcu_node structures.
+	 * Note that rnp_start->lock must not be released.
 	 */
 	raw_lockdep_assert_held_rcu_node(rnp_start);
 	trace_rcu_this_gp(rnp_start, rdp, gp_seq_req, TPS("Startleaf"));
