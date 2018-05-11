Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeEKR0M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:26:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750711AbeEKR0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:26:11 -0400
Date: Fri, 11 May 2018 10:27:35 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        peterz@infradead.org
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
Reply-To: paulmck@linux.vnet.ibm.com
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
 <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
 <20180511161746.GX26088@linux.vnet.ibm.com>
 <20180511122321.722a12cc@gandalf.local.home>
 <20180511122528.2a398d24@gandalf.local.home>
 <20180511122712.2d67992b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511122712.2d67992b@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051117-0056-0000-0000-0000044D0351
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009007; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01030821; UDB=6.00526848; IPR=6.00809952;
 MB=3.00021051; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-11 17:26:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051117-0057-0000-0000-00000891140E
Message-Id: <20180511172735.GB26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 12:27:12PM -0400, Steven Rostedt wrote:
> On Fri, 11 May 2018 12:25:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I would also say that one should never call schedule() directly without
> > changing its state to something other than TASK_RUNNING. Hence, calling
> > schedule directly is saying you are ready to sleep. But that is not the
> > case with cond_resched() which should always be called with the state
> > as TASK_RUNNING.
> 
> To continue this, with tracing, when a task is scheduled out in the
> RUNNING state, it is considered preempted, otherwise it is not.

I suppose another option would be for cond_resched_tasks_rcu_qs() to set
(and later clear) a per-CPU variable that causes rcu_note_context_switch()
to ignore its "preempt" parameter.  Byungchul's approach seems more
straightforward, though.

							Thanx, Paul
