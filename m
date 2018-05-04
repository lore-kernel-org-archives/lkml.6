Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeEDUKQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:10:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752115AbeEDUKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:10:12 -0400
Date: Fri, 4 May 2018 13:11:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: rcu-bh design
Reply-To: paulmck@linux.vnet.ibm.com
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
 <20180504123050.2841f80d@gandalf.local.home>
 <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
 <20180504174330.GS26088@linux.vnet.ibm.com>
 <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
 <20180504184951.GU26088@linux.vnet.ibm.com>
 <CAEi0qN=8c6tzNq26x=BBj5u3JoZHXF0DvfwWg=1vjmTU0UC4-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEi0qN=8c6tzNq26x=BBj5u3JoZHXF0DvfwWg=1vjmTU0UC4-w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050420-0008-0000-0000-00000302EEF8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008970; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027518; UDB=6.00524875; IPR=6.00806651;
 MB=3.00020932; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-04 20:10:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050420-0009-0000-0000-000039228C78
Message-Id: <20180504201129.GX26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 12:57:19PM -0700, Joel Fernandes wrote:
> On Fri, May 4, 2018 at 11:49 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Fri, May 04, 2018 at 06:34:32PM +0000, Joel Fernandes wrote:
> >> On Fri, May 4, 2018 at 10:42 AM Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com>
> >> wrote:
> >> [...]
> >> > > > > But preemptible RCU *does not* use context-switch as a quiescent
> >> state.
> >> > > > It doesn't?
> >> > >
> >> > > I thought that's what preemptible rcu is about. You can get preempted
> >> but
> >> > > you shouldn't block in a read-section. Is that not true?
> >>
> >> > Almost.  All context switches in an RCU-preempt read-side critical section
> >> > must be subject to priority boosting.  Preemption is one example, because
> >> > boosting the priority of the preempted task will make it runnable.
> >> > The priority-inheritance -rt "spinlock" is another example, because
> >> > boosting the priority of the task holding the lock will eventually make
> >> > runnable the task acquiring the lock within the RCU-preempt read-side
> >> > critical section.
> >>
> >> Yes I understand priority boosting is needed with preemptible RCU so that
> >> read-sections are making forward progress. I meant (and correct me if I'm
> >> wrong) that, as long as a task doesn't sleep in a preemptible RCU
> >> read-section (rcu-preempt flavor), then bad things wont happen and RCU will
> >> work correctly.
> >
> > The exception is -rt "spinlock" acquisition.  If the "spinlock" is held,
> > the task acquiring it will block, which is legal within an RCU-preempt
> > read-side critical section.
> >
> > This exception is why I define bad things in terms of lack of
> > susceptibility to priority boosting instead of sleeping.
> 
> Oh, that's a tricky situation. Thanks for letting me know. I guess my
> view was too idealistic. Makes sense now.

Well, let me put it this way...

Here is your nice elegant little algorithm:
https://upload.wikimedia.org/wikipedia/commons/6/6e/Golde33443.jpg

Here is your nice elegant little algorithm equipped to survive within
the Linux kernel:
https://totatema.files.wordpress.com/2012/06/feeling_grizzly-1600x1200.jpg

Any questions?  ;-)

							Thanx, Paul
