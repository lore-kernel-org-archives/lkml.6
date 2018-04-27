Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758897AbeD0REJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:04:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757569AbeD0REH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:04:07 -0400
Date: Fri, 27 Apr 2018 10:05:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks executing
 with preempt on
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180427042656.190746-1-joelaf@google.com>
 <20180427155701.GL26088@linux.vnet.ibm.com>
 <CAJWu+or9GJwkDK9+842YbobG3=xVW-PgqS=uE5P2xFbDhmqxEQ@mail.gmail.com>
 <20180427122201.75abc313@gandalf.local.home>
 <20180427164554.GO26088@linux.vnet.ibm.com>
 <20180427124641.7b991c57@gandalf.local.home>
 <20180427170048.GP26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427170048.GP26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042717-0036-0000-0000-000002EB4F10
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008933; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01024098; UDB=6.00522858; IPR=6.00803328;
 MB=3.00020809; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-27 17:04:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042717-0037-0000-0000-000044236A1B
Message-Id: <20180427170517.GA799@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 10:00:48AM -0700, Paul E. McKenney wrote:
> On Fri, Apr 27, 2018 at 12:46:41PM -0400, Steven Rostedt wrote:
> > On Fri, 27 Apr 2018 09:45:54 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > > > That shouldn't be needed. For the rcu_read_lock_sched case, there is a
> > > > > preempt_disable which needs to be a notrace, but for the srcu one,
> > > > > since we don't do that, I think it should be fine.  
> > > > 
> > > > Actually, I think I may agree here too. Because the _notrace is for
> > > > function tracing, and it shouldn't affect it. If people don't want it
> > > > traced, they could add those functions to the list in the notrace file.  
> > > 
> > > OK, feel free to ignore my notrace srcu_read_lock() patch, then.  ;-)
> > 
> > Of course I wasn't thinking about the lockdep tracepoints that Joel
> > mentioned, which happens to be the reason for all this discussion in
> > the first place :-)  Now I think we do need it. (OK, I can keep
> > changing my mind, can't I?).
> 
> You can, but at some point I start applying heavy-duty hysteresis.  ;-)
> 
> So the current thought (as of your having sent the above email) is that
> we need notrace versions of srcu_read_lock() and srcu_read_unlock(),
> but not for __srcu_read_lock() and __srcu_read_unlock(), correct?

And Joel noted offline that I messed up srcu_read_unlock_notrace(),
so here is an updated patch with that fixed.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 91494d7e8e41..3e72a291c401 100644
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
@@ -209,6 +219,13 @@ static inline void srcu_read_unlock(struct srcu_struct *sp, int idx)
 	__srcu_read_unlock(sp, idx);
 }
 
+/* Used by tracing, cannot be traced and cannot call lockdep. */
+static inline notrace void
+srcu_read_unlock_notrace(struct srcu_struct *sp, int idx) __releases(sp)
+{
+	__srcu_read_unlock(sp, idx);
+}
+
 /**
  * smp_mb__after_srcu_read_unlock - ensure full ordering after srcu_read_unlock
  *
