Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeENRUu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:20:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752292AbeENRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:20:40 -0400
Date: Mon, 14 May 2018 10:22:05 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 2/8] rcu: Clarify usage of cond_resched for tasks-RCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-3-joel@joelfernandes.org>
 <20180514105454.45946ad3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514105454.45946ad3@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051417-0048-0000-0000-0000026CD55E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009025; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032259; UDB=6.00527710; IPR=6.00811391;
 MB=3.00021110; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 17:20:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051417-0049-0000-0000-0000451E79C8
Message-Id: <20180514172205.GZ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:54:54AM -0400, Steven Rostedt wrote:
> On Sun, 13 May 2018 20:15:35 -0700
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > Recently we had a discussion about cond_resched unconditionally
> > recording a voluntary context switch [1].
> > 
> > Lets add a comment clarifying that how this API is to be used.
> > 
> > [1] https://lkml.kernel.org/r/1526027434-21237-1-git-send-email-byungchul.park@lge.com
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  include/linux/rcupdate.h | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 743226176350..a9881007ece6 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -159,8 +159,12 @@ static inline void rcu_init_nohz(void) { }
> >  	} while (0)
> >  
> >  /*
> > - * Note a voluntary context switch for RCU-tasks benefit.  This is a
> > - * macro rather than an inline function to avoid #include hell.
> > + * Note an attempt to perform a voluntary context switch for RCU-tasks benefit.
> > + *
> > + * This is called even in situations where a context switch didn't really
> > + * happen even though it was requested. The caller uses it to indicate
> > + * traversal of an RCU-tasks quiescent state. This is a macro rather than an
> > + * inline function to avoid #include hell.
> 
> I don't know. I just don't like the wording. It sounds too much like
> it was written by someone that was confused for it being called when a
> context switch didn't occur ;-)
> 
> What about something more like:
> 
> /*
>  * This is called to denote a RCU-task quiescent state. It is placed at
>  * voluntary preemption points, as RCU-task critical sections may not
>  * perform voluntary preemption or scheduling calls. It does not matter
>  * if the task is scheduled out or not, just that a voluntary preemption
>  * may be done.
>  */

s/RCU-task/RCU-tasks/ and I am good with this.

							Thanx, Paul

> >   */
> >  #ifdef CONFIG_TASKS_RCU
> >  #define rcu_note_voluntary_context_switch_lite(t) \
> > @@ -187,7 +191,8 @@ static inline void exit_tasks_rcu_finish(void) { }
> >  #endif /* #else #ifdef CONFIG_TASKS_RCU */
> >  
> >  /**
> > - * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
> > + * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU.
> > + * The quiescent state report is made even if cond_resched() did nothing.
> 
> Same thing here.
> 
>  * The quiescent state report does not depend on cond_resched() scheduling.
> 
> -- Steve
> 
> 
> >   *
> >   * This macro resembles cond_resched(), except that it is defined to
> >   * report potential quiescent states to RCU-tasks even if the cond_resched()
> 
