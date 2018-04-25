Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeDYVee (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:34:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751231AbeDYVec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:34:32 -0400
Date: Wed, 25 Apr 2018 14:35:39 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>, Namhyung Kim <namhyung@kernel.org>,
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
References: <CAJWu+or_-emRLeBbfOtQYyn9W8v-KHH8XecV_k-p5FX_3BLHAQ@mail.gmail.com>
 <20180424172658.GT26088@linux.vnet.ibm.com>
 <20180424182302.GA404@linux.vnet.ibm.com>
 <20180424182623.GA1357@linux.vnet.ibm.com>
 <CAJWu+opC9pLxoiXq7QDRUDe6ouC4ij398bHCfnUwp+h7Y_ssDg@mail.gmail.com>
 <849066633.939.1524612064698.JavaMail.zimbra@efficios.com>
 <68e4c123-a223-5e26-e57a-da2515041bf3@google.com>
 <20180425001049.GX26088@linux.vnet.ibm.com>
 <20180425042056.GA21412@linux.vnet.ibm.com>
 <CAJWu+orWC=W0Jn2Jo7f+u5mbHMi+D1yuCmhD-xSgjWZ6Ynw32Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+orWC=W0Jn2Jo7f+u5mbHMi+D1yuCmhD-xSgjWZ6Ynw32Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042521-0056-0000-0000-00000445260F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008921; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01023228; UDB=6.00522336; IPR=6.00802462;
 MB=3.00020782; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-25 21:34:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042521-0057-0000-0000-000008892645
Message-Id: <20180425213539.GA26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804250196
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 02:27:08PM -0700, Joel Fernandes wrote:
> On Tue, Apr 24, 2018 at 9:20 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> [..]
> >> >
> >> > Sounds good, thanks.
> >> >
> >> > Also I found the reason for my boot issue. It was because the
> >> > init_srcu_struct in the prototype was being done in an initcall.
> >> > Instead if I do it in start_kernel before the tracepoint is used, it
> >> > fixes it (although I don't know if this is dangerous to do like this
> >> > but I can get it to boot atleast.. Let me know if this isn't the
> >> > right way to do it, or if something else could go wrong)
> >> >
> >> > diff --git a/init/main.c b/init/main.c
> >> > index 34823072ef9e..ecc88319c6da 100644
> >> > --- a/init/main.c
> >> > +++ b/init/main.c
> >> > @@ -631,6 +631,7 @@ asmlinkage __visible void __init start_kernel(void)
> >> >         WARN(!irqs_disabled(), "Interrupts were enabled early\n");
> >> >         early_boot_irqs_disabled = false;
> >> >
> >> > +       init_srcu_struct(&tracepoint_srcu);
> >> >         lockdep_init_early();
> >> >
> >> >         local_irq_enable();
> >> > --
> >> >
> >> > I benchmarked it and the performance also looks quite good compared
> >> > to the rcu tracepoint version.
> >> >
> >> > If you, Paul and other think doing the init_srcu_struct like this
> >> > should be Ok, then I can try to work more on your srcu prototype and
> >> > roll into my series and post them in the next RFC series (or let me
> >> > know if you wanted to work your srcu stuff in a separate series..).
> >>
> >> That is definitely not what I was expecting, but let's see if it works
> >> anyway...  ;-)
> >>
> >> But first, I was instead expecting something like this:
> >>
> >> DEFINE_SRCU(tracepoint_srcu);
> >>
> >> With this approach, some of the initialization happens at compile time
> >> and the rest happens at the first call_srcu().
> >>
> >> This will work -only- if the first call_srcu() doesn't happen until after
> >> workqueue_init_early() has been invoked.  Which I believe must have been
> >> the case in your testing, because otherwise it looks like __call_srcu()
> >> would have complained bitterly.
> >>
> >> On the other hand, if you need to invoke call_srcu() before the call
> >> to workqueue_init_early(), then you need the patch that I am beating
> >> into shape.  Plus you would need to use DEFINE_SRCU() and to avoid
> >> invoking init_srcu_struct().
> >
> > And here is the patch.  I do not intend to send it upstream unless it
> > actually proves necessary, and it appears that current SRCU does what
> > you need.
> >
> > You would only need this patch if you wanted to invoke call_srcu()
> > before workqueue_init_early() was called, which does not seem likely.
> 
> Cool. So I was chatting with Paul and just to update everyone as well,
> I tried the DEFINE_SRCU instead of the late init_srcu_struct call and
> can make it past boot too (thanks Paul!). Also I don't see a reason we
> need the RCU callback to execute early and its fine if it runs later.

Very good, thank you!

> Also, I was thinking of introducing a separate trace_*event*_srcu API
> as a replacement to the _rcuidle API. Then I can make use of it for my
> tracepoints, and then later can use it for the other tracepoints
> needing _rcuidle. After that we can finally get rid of the _rcuidle
> API if there are no other users of it. This is just a rough plan, but
> let me know if there's any issue with this plan that you can think
> off.

You mean make _rcuidle use SRCU instead of RCU?  Sounds reasonable to me.

> IMO, I believe its simpler if the caller worries about whether it can
> tolerate if tracepoint probes can block or not, than making it a
> property of the tracepoint. That would also simplify the patch to
> introduce srcu and keep the tracepoint creation API simple and less
> confusing, but let me know if I'm missing something about this.

If it helps, you can use synchronize_rcu_mult() to wait for several
different types of RCU grace periods concurrently.  Of course,
if it is fast enough to just do a synchronize_rcu() followed by a
synchronize_srcu(), why worry?

							Thanx, Paul
