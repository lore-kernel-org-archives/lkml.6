Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08756C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9231278D5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9231278D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935872AbeF1UAH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:00:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934032AbeF1UAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:00:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SJsHK7011694
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 16:00:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jw3sye8r5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 16:00:04 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Jun 2018 16:00:03 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 15:59:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5SJxwB08192716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 19:59:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85772B2064;
        Thu, 28 Jun 2018 15:59:49 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54BC4B2068;
        Thu, 28 Jun 2018 15:59:49 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 15:59:49 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B546E16CA2CB; Thu, 28 Jun 2018 13:02:05 -0700 (PDT)
Date:   Thu, 28 Jun 2018 13:02:05 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, joel@joelfernandes.org,
        max.byungchul.park@gmail.com,
        Byungchul Park <byungchul.park@lge.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Reply-To: paulmck@linux.vnet.ibm.com
References: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622205813.GV3593@linux.vnet.ibm.com>
 <20180622170042.4adfbe21@gandalf.local.home>
 <20180622211600.GX3593@linux.vnet.ibm.com>
 <CALCETrUqe_1dg=3KYOswGQv5i=_5WFYpcn27Z6oa2D7-nBa+Jw@mail.gmail.com>
 <20180623175356.GH3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623175356.GH3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062820-2213-0000-0000-000002C178D1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009272; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053685; UDB=6.00540279; IPR=6.00831608;
 MB=3.00021912; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-28 20:00:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062819-2214-0000-0000-00005AA4363B
Message-Id: <20180628200205.GA6374@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 10:53:56AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 22, 2018 at 03:03:35PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 22, 2018 at 2:14 PM Paul E. McKenney
> > <paulmck@linux.vnet.ibm.com> wrote:
> > >
> > > On Fri, Jun 22, 2018 at 05:00:42PM -0400, Steven Rostedt wrote:
> > > > On Fri, 22 Jun 2018 13:58:13 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > >
> > > > > Something like this:
> > > > >
> > > > >     IRQ entered
> > > > >
> > > > > And never exited.  Ever.  I actually saw this in 2011.
> > > >
> > > > I still believe this was actually a bug. And perhaps you made the RCU
> > > > code robust enough to handle this bug ;-)
> > >
> > > Welcome to my world!
> > >
> > > But I recall it being used in several places, so if it was a bug, it
> > > was an intentional bug.  Probably the worst kind.
> > >
> > > Sort of like nested NMIs and interrupts within NMI handlers.  ;-)
> > >
> > > > > Or something like this:
> > > > >
> > > > >     IRQ exited
> > > > >
> > > > > Without a corresponding IRQ enter.
> > > > >
> > > > > The current code handles both of these situations, at least assuming
> > > > > that the interrupt entry/exit happens during a non-idle period.
> > > > >
> > > > > > > So why this function-call structure?  Well, you see, NMI handlers can
> > > > > > > take what appear to RCU to be normal interrupts...
> > > > > > >
> > > > > > > (And I just added that fun fact to Requirements.html.)
> > > > > >
> > > > > > Yes, I'll definitely go through all the interrupt requirements in the doc and
> > > > > > thanks for referring me to it.
> > > > >
> > > > > My concern may well be obsolete.  It would be good if it was!  ;-)
> > > >
> > > > I'd love to mandate that irq_enter() must be paired with irq_exit(). I
> > > > don't really see any rationale for it to be otherwise. If there is a
> > > > case, perhaps it needs to be fixed.
> > >
> > > Given that the usermode helpers now look to be common code using
> > > workqueues, kthreads, and calls to do_execve(), it might well be that
> > > the days of half-interrupts are behind us.
> > >
> > > But how to actually validate this?  My offer of adding a WARN_ON_ONCE()
> > > and waiting a few years still stands, but perhaps you have a better
> > > approach.
> > 
> > I think you should add a WARN_ON_ONCE().  Let's get the bugs fixed.
> 
> Or the obscure features identified, as the case may be.  ;-)
> 
> Either way, will do!

And here is a prototype patch.

							Thanx, Paul

------------------------------------------------------------------------

commit ef544593a7bcad74628fa0537badc49dce1f2d95
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Thu Jun 28 12:45:23 2018 -0700

    rcu: Add warning to detect half-interrupts
    
    RCU's dyntick-idle code is written to tolerate half-interrupts, that it,
    either an interrupt that invokes rcu_irq_enter() but never invokes the
    corresponding rcu_irq_exit() on the one hand, or an interrupt that never
    invokes rcu_irq_enter() but does invoke the "corresponding" rcu_irq_exit()
    on the other.  These things really did happen at one time, as evidenced
    by this ca-2011 LKML post:
    
    http://lkml.kernel.org/r/20111014170019.GE2428@linux.vnet.ibm.com
    
    The reason why RCU tolerates half-interrupts is that usermode helpers
    used exceptions to invoke a system call from within the kernel such that
    the system call did a normal return (not a return from exception) to
    the calling context.  This caused rcu_irq_enter() to be invoked without
    a matching rcu_irq_exit().  However, usermode helpers have since been
    rewritten to make much more housebroken use of workqueues, kernel threads,
    and do_execve(), and therefore should no longer produce half-interrupts.
    No one knows of any other source of half-interrupts, but then again,
    no one seems insane enough to go audit the entire kernel to verify that
    half-interrupts really are a relic of the past.
    
    This commit therefore adds a pair of WARN_ON_ONCE() calls that will
    trigger in the presence of half interrupts, which the code will continue
    to handle correctly.  If neither of these WARN_ON_ONCE() trigger by
    mid-2021, then perhaps RCU can stop handling half-interrupts, which
    would be a considerable simplification.
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Reported-by: Joel Fernandes <joel@joelfernandes.org>
    Reported-by: Andy Lutomirski <luto@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6c5a7f0daadc..37ae0d77854d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -714,6 +714,7 @@ static void rcu_eqs_enter(bool user)
 	struct rcu_dynticks *rdtp;
 
 	rdtp = this_cpu_ptr(&rcu_dynticks);
+	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
 	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdtp->dynticks_nesting == 0);
@@ -895,6 +896,7 @@ static void rcu_eqs_exit(bool user)
 	trace_rcu_dyntick(TPS("End"), rdtp->dynticks_nesting, 1, rdtp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdtp->dynticks_nesting, 1);
+	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting);
 	WRITE_ONCE(rdtp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
 }
 

