Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeDXPzz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:55:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750868AbeDXPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:55:54 -0400
Date: Tue, 24 Apr 2018 08:56:55 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>, Namhyung Kim <namhyung@kernel.org>,
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
 <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
 <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
 <20180423031926.GF26088@linux.vnet.ibm.com>
 <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
 <20180423105325.7d5d245b@gandalf.local.home>
 <1045420715.14686.1524495583859.JavaMail.zimbra@efficios.com>
 <20180423121800.47b173af@gandalf.local.home>
 <1212130312.14753.1524503541789.JavaMail.zimbra@efficios.com>
 <20180423172244.694dbc9d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423172244.694dbc9d@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042415-0008-0000-0000-000002FD54B1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008913; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022635; UDB=6.00521982; IPR=6.00801869;
 MB=3.00020751; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-24 15:55:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042415-0009-0000-0000-00003903D101
Message-Id: <20180424155655.GA820@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:22:44PM -0400, Steven Rostedt wrote:
> On Mon, 23 Apr 2018 13:12:21 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> 
> > I'm inclined to explicitly declare the tracepoints with their given
> > synchronization method. Tracepoint probe callback functions for currently
> > existing tracepoints expect to have preemption disabled when invoked.
> > This assumption will not be true anymore for srcu-tracepoints.
> 
> Actually, why not have a flag attached to the tracepoint_func that
> states if it expects preemption to be enabled or not? If a
> trace_##event##_srcu() is called, then simply disable preemption before
> calling the callbacks for it. That way if a callback is fine for use
> with srcu, then it would require calling
> 
> 	register_trace_##event##_may_sleep();
> 
> Then if someone uses this on a tracepoint where preemption is disabled,
> we simply do not call it.

One more stupid question...  If we are having to trace so much stuff
in the idle loop, are we perhaps grossly overstating the extent of that
"idle" loop?  For being called "idle", this code seems quite busy!

							Thanx, Paul
