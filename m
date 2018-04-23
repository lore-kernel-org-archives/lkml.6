Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755763AbeDWPLX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:11:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932106AbeDWPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:11:19 -0400
Date: Mon, 23 Apr 2018 08:12:22 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rostedt <rostedt@goodmis.org>, Joel Fernandes <joelaf@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@lge.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180417040748.212236-1-joelaf@google.com>
 <20180418180250.7b6038dddba46b37c94b796c@kernel.org>
 <20180419054302.GD13370@sejong>
 <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
 <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
 <20180423031926.GF26088@linux.vnet.ibm.com>
 <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
 <20180423105325.7d5d245b@gandalf.local.home>
 <1045420715.14686.1524495583859.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045420715.14686.1524495583859.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042315-0040-0000-0000-00000420A594
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008906; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022141; UDB=6.00521685; IPR=6.00801376;
 MB=3.00020727; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 15:11:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042315-0041-0000-0000-00000826AF8C
Message-Id: <20180423151222.GO26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:59:43AM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 23, 2018, at 10:53 AM, rostedt rostedt@goodmis.org wrote:
> 
> > On Mon, 23 Apr 2018 10:31:28 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> >> I've been wanting to introduce an alternative tracepoint instrumentation
> >> "flavor" for e.g. system call entry/exit which rely on SRCU rather than
> >> sched-rcu (preempt-off). This would allow taking faults within the
> >> instrumentation
> >> probe, which makes lots of things easier when fetching data from user-space
> >> upon system call entry/exit. This could also be used to cleanly instrument
> >> the idle loop.
> > 
> > I'd be OK with such an approach. And I don't think it would be that
> > hard to implement. It could be similar to the rcu_idle() tracepoints,
> > where each flavor simply passes in what protection it uses for
> > DO_TRACE(). We could do linker tricks to tell the tracepoint.c code how
> > the tracepoint is protected (add section code, that could be read to
> > update flags in the tracepoint). Of course modules that have
> > tracepoints could only use the standard preempt ones.
> > 
> > That is, if trace_##event##_srcu(trace_##event##_sp, PARAMS), is used,
> > then the trace_##event##_sp would need to be created somewhere. The use
> > of trace_##event##_srcu() would create a section entry, and on boot up
> > we can see that the use of this tracepoint requires srcu protection
> > with a pointer to the trace_##event##_sp srcu_struct. This could be
> > used to make sure that trace_#event() call isn't done multiple times
> > that uses two different protection flavors.
> > 
> > I'm just brain storming the idea, and I'm sure I screwed up something
> > above, but I do believe it is feasible.
> 
> The main open question here is whether we want one SRCU grace period
> domain per SRCU tracepoint definition, or just one SRCU domain for all
> SRCU tracepoints would be fine.
> 
> I'm not sure what we would gain by having the extra granularity provided
> by one SRCU grace period domain per tracepoint, and having a single SRCU
> domain for all SRCU tracepoints makes it easy to batch grace period after
> bulk tracepoint modifications.

I don't see how having multiple SRCU domains would help anything, but
perhaps I am missing something basic.

							thanx, Paul
