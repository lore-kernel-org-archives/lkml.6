Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeBZFrG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 00:47:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750749AbeBZFrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 00:47:05 -0500
Date: Sun, 25 Feb 2018 21:47:27 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 06/10] trace: Eliminate
 cond_resched_rcu_qs() in favor of cond_resched()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20171201192122.GA19301@linux.vnet.ibm.com>
 <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180224151240.0d63a059@vmware.local.home>
 <20180225174927.GC2855@linux.vnet.ibm.com>
 <20180225181730.GA3963@linux.vnet.ibm.com>
 <20180225235748.4ce882e5@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180225235748.4ce882e5@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022605-0052-0000-0000-000002BE6048
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008599; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995210; UDB=6.00505843; IPR=6.00774543;
 MB=3.00019741; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 05:47:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022605-0053-0000-0000-00005BD09131
Message-Id: <20180226054727.GJ2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 11:57:48PM -0500, Steven Rostedt wrote:
> On Sun, 25 Feb 2018 10:17:30 -0800
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> 
> > And probably not.  You are probably running CONFIG_PREEMPT=y (otherwise
> > RCU-tasks is trivial), so cond_resched() is a complete no-op:
> > 
> > static inline int _cond_resched(void) { return 0; }
> > 
> > I could make this call rcu_all_qs(), but I would not expect Peter Zijlstra
> > to be at all happy with that sort of change.
> > 
> > And the people who asked for the cond_resched() work probably aren't
> > going to be happy with the resumed proliferation of cond_resched_rcu_qs().
> > 
> > Hmmm...  Grasping at straws...  Could we make cond_resched() be something
> > like a tracepoint and instrument them with cond_resched_rcu_qs() if the
> > current RCU-tasks grace period ran for more that (say) a minute of its
> > ten-minute stall-warning span?
> > 
> 
> Instead of monkeying with cond_resched(), since this is "special" code,
> why don't I just have that code call it directly?
> 
> 	cond_resched();
> 	rcu_note_voluntary_context_switch(current);

The advantage of the last patch that I sent is that the special call
is in one place.  (This is the one that adds the "special" definition
for _cond_resched().)

							Thanx, Paul
