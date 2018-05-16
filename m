Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEPPrE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:47:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750746AbeEPPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:47:03 -0400
Date: Wed, 16 May 2018 08:48:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 6/8] rcu: Add back the Startedleaf tracepoint
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-7-joel@joelfernandes.org>
 <20180514183823.GF26088@linux.vnet.ibm.com>
 <20180515005709.GE209519@joelaf.mtv.corp.google.com>
 <20180515034603.GY26088@linux.vnet.ibm.com>
 <20180515230430.GB7510@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515230430.GB7510@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051615-0040-0000-0000-0000042C4802
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009035; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033188; UDB=6.00528266; IPR=6.00812319;
 MB=3.00021147; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-16 15:47:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051615-0041-0000-0000-000008325D70
Message-Id: <20180516154829.GE3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 04:04:30PM -0700, Joel Fernandes wrote:
> On Mon, May 14, 2018 at 08:46:03PM -0700, Paul E. McKenney wrote:
> > On Mon, May 14, 2018 at 05:57:09PM -0700, Joel Fernandes wrote:
> > > On Mon, May 14, 2018 at 11:38:23AM -0700, Paul E. McKenney wrote:
> > > > On Sun, May 13, 2018 at 08:15:39PM -0700, Joel Fernandes (Google) wrote:
> > > > > In recent discussion [1], the check for whether a leaf believes RCU is
> > > > > not idle, is being added back to funnel locking code, to avoid more
> > > > > locking. In this we are marking the leaf node for a future grace-period
> > > > > and bailing out since a GP is currently in progress. However the
> > > > > tracepoint is missing. Lets add it back.
> > > > > 
> > > > > Also add a small comment about why we do this check (basically the point
> > > > > is to avoid locking intermediate nodes unnecessarily) and clarify the
> > > > > comments in the trace event header now that we are doing traversal of
> > > > > one or more intermediate nodes.
> > > > > 
> > > > > [1] http://lkml.kernel.org/r/20180513190906.GL26088@linux.vnet.ibm.com
> > > > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > Looks like a good idea, but it does not apply -- which is not a surprise,
> > > > given the change rate in this code.  I hand-applied as a modification
> > > > to c1b3f9fce26f ("rcu: Don't funnel-lock above leaf node if GP in progress")
> > > > with attribution, but with the changes below.  Please let me know if I
> > > > am missing something.
> > > > 
> > > > Ah, I see -- this commit depends on your earlier name-change commit.
> > > > I therefore made this patch use the old names.
> > > 
> > > Ok, I'll check your new tree and rebase.
> > 
> > Sounds good!
> > 
> > > > > ---
> > > > >  include/trace/events/rcu.h |  4 ++--
> > > > >  kernel/rcu/tree.c          | 11 ++++++++++-
> > > > >  2 files changed, 12 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > > > > index 539900a9f8c7..dc0bd11739c7 100644
> > > > > --- a/include/trace/events/rcu.h
> > > > > +++ b/include/trace/events/rcu.h
> > > > > @@ -91,8 +91,8 @@ TRACE_EVENT(rcu_grace_period,
> > > > >   *
> > > > >   * "Startleaf": Request a grace period based on leaf-node data.
> > > > >   * "Prestarted": Someone beat us to the request
> > > > > - * "Startedleaf": Leaf-node start proved sufficient.
> > > > > - * "Startedleafroot": Leaf-node start proved sufficient after checking root.
> > > > > + * "Startedleaf": Leaf and one or more non-root nodes marked for future start.
> > > > 
> > > > Actually, we only get to that trace if all we did was mark the leaf
> > > > node, right?
> > > 
> > > I didn't think so. In the code we are doing the check for rnp every time we
> > > walk up the tree. So even when we are on an intermediate node, we do the
> > > check of the node we started with. I thought that's what you wanted to do. It
> > > makes sense to me to do so too.
> > 
> > If we are not on the initial (usually leaf) node, then the similar check
> > in the previous "if" statement would have sent us to unlock_out, right?
> > 
> > (And yes, I should have said "mark the initial node" above.)
> 
> I may have missed this, sorry. 
> 
> Yes, that would be true unless the check could be true not at the firsti
> iteration, but after the first iteration? (i.e. another path started the
> initially idle GP). That's why I changed it to "one or more non-root nodes
> marked".

After the first iteration, the check after setting ->gp_seq_needed is
dead code.  If that check would have succeeded, the same check in the
big "if" statement would have taken the early exit.

							Thanx, Paul

> What do you think?
> 
> thanks,
> 
> - Joel
> 
