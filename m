Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758790AbeD0QnJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:43:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758562AbeD0QnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:43:06 -0400
Date: Fri, 27 Apr 2018 09:44:16 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks executing
 with preempt on
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180427042656.190746-1-joelaf@google.com>
 <20180427155701.GL26088@linux.vnet.ibm.com>
 <20180427121330.40b7ef15@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427121330.40b7ef15@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042716-0040-0000-0000-000004233FF9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008932; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01024091; UDB=6.00522853; IPR=6.00803321;
 MB=3.00020809; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-27 16:43:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042716-0041-0000-0000-000008294210
Message-Id: <20180427164416.GN26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 12:13:30PM -0400, Steven Rostedt wrote:
> On Fri, 27 Apr 2018 08:57:01 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > +		if (preempt_on) {					\
> > > +			WARN_ON_ONCE(in_nmi()); /* no srcu from nmi */	\  
> > 
> > Very good on this check, thank you!
> 
> I think you need to return and not call the read lock.

Works for me either way, at least assuming that the splat actually gets
printed.  ;-)

> 			if (WARN_ON_ONCE(in_nmi()))
> 				return;
> 
> > 
> > > +			idx = srcu_read_lock(&tracepoint_srcu);         \  
> > 
> > Hmmm...  Do I need to create a _notrace variant of srcu_read_lock()
> > and srcu_read_unlock()?
> 
> I think so.

OK, please see the (untested) patch below.  Of course,
srcu_read_lock_notrace() invokes __srcu_read_lock(), which looks as
follows:

	int __srcu_read_lock(struct srcu_struct *sp)
	{
		int idx;

		idx = READ_ONCE(sp->srcu_idx) & 0x1;
		this_cpu_inc(sp->sda->srcu_lock_count[idx]);
		smp_mb(); /* B */  /* Avoid leaking the critical section. */
		return idx;
	}

Do I also need to make a notrace version of __srcu_read_lock()?
Same question for __srcu_read_unlock(), which is similar.  If so,
assuming that there is no need for a notrace variant of this_cpu_inc()
and smp_mb(), I suppose I could simply macro-ize the internals in both
cases, but perhaps you have a better approach.

								Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 91494d7e8e41..e2e2cf05a6eb 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -195,6 +195,16 @@ static inline int srcu_read_lock(struct srcu_struct *sp) __acquires(sp)
 	return retval;
 }
 
+/* Used by tracing, cannot be traced and cannot invoke lockdep. */
+static inline notrace int
+srcu_read_lock_notrace(struct srcu_struct *sp) __acquires(sp)
+{
+	int retval;
+
+	retval = __srcu_read_lock(sp);
+	return retval;
+}
+
 /**
  * srcu_read_unlock - unregister a old reader from an SRCU-protected structure.
  * @sp: srcu_struct in which to unregister the old reader.
@@ -205,6 +215,13 @@ static inline int srcu_read_lock(struct srcu_struct *sp) __acquires(sp)
 static inline void srcu_read_unlock(struct srcu_struct *sp, int idx)
 	__releases(sp)
 {
+	__srcu_read_unlock(sp, idx);
+}
+
+/* Used by tracing, cannot be traced and cannot call lockdep. */
+static inline notrace void
+srcu_read_unlock_notrace(struct srcu_struct *sp, int idx) __releases(sp)
+{
 	rcu_lock_release(&(sp)->dep_map);
 	__srcu_read_unlock(sp, idx);
 }
