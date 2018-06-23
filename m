Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4375C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8977D24CBA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8977D24CBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeFWRyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 13:54:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751652AbeFWRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 13:54:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5NHrwlX054215
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 13:54:37 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jsfu91r40-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 13:54:37 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 23 Jun 2018 13:54:37 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 23 Jun 2018 13:54:32 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5NHsVuQ14352750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 23 Jun 2018 17:54:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93F35B2064;
        Sat, 23 Jun 2018 13:54:29 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58BB4B2066;
        Sat, 23 Jun 2018 13:54:29 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.148.28])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 23 Jun 2018 13:54:29 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A35AB16C41B5; Sat, 23 Jun 2018 10:56:34 -0700 (PDT)
Date:   Sat, 23 Jun 2018 10:56:34 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622205813.GV3593@linux.vnet.ibm.com>
 <20180622170042.4adfbe21@gandalf.local.home>
 <20180622211600.GX3593@linux.vnet.ibm.com>
 <20180623154839.GA12939@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623154839.GA12939@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062317-0052-0000-0000-0000030315D4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009247; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01051252; UDB=6.00538817; IPR=6.00829908;
 MB=3.00021827; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-23 17:54:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062317-0053-0000-0000-00005D1D939B
Message-Id: <20180623175634.GI3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806230213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 08:48:39AM -0700, Joel Fernandes wrote:
> On Fri, Jun 22, 2018 at 02:16:00PM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 22, 2018 at 05:00:42PM -0400, Steven Rostedt wrote:
> > > On Fri, 22 Jun 2018 13:58:13 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > Something like this:
> > > > 
> > > > 	IRQ entered
> > > > 
> > > > And never exited.  Ever.  I actually saw this in 2011.
> > > 
> > > I still believe this was actually a bug. And perhaps you made the RCU
> > > code robust enough to handle this bug ;-)
> > 
> > Welcome to my world!
> > 
> > But I recall it being used in several places, so if it was a bug, it
> > was an intentional bug.  Probably the worst kind.
> > 
> > Sort of like nested NMIs and interrupts within NMI handlers.  ;-)
> > 
> > > > Or something like this:
> > > > 
> > > > 	IRQ exited
> > > > 
> > > > Without a corresponding IRQ enter.
> > > > 
> > > > The current code handles both of these situations, at least assuming
> > > > that the interrupt entry/exit happens during a non-idle period.
> > > > 
> > > > > > So why this function-call structure?  Well, you see, NMI handlers can
> > > > > > take what appear to RCU to be normal interrupts...
> > > > > > 
> > > > > > (And I just added that fun fact to Requirements.html.)  
> > > > > 
> > > > > Yes, I'll definitely go through all the interrupt requirements in the doc and
> > > > > thanks for referring me to it.  
> > > > 
> > > > My concern may well be obsolete.  It would be good if it was!  ;-)
> > > 
> > > I'd love to mandate that irq_enter() must be paired with irq_exit(). I
> > > don't really see any rationale for it to be otherwise. If there is a
> > > case, perhaps it needs to be fixed.
> > 
> > Given that the usermode helpers now look to be common code using
> > workqueues, kthreads, and calls to do_execve(), it might well be that
> > the days of half-interrupts are behind us.
> > 
> > But how to actually validate this?  My offer of adding a WARN_ON_ONCE()
> > and waiting a few years still stands, but perhaps you have a better
> > approach.
> 
> Hi Paul, I am Ok with adding a warning for a couple of releases if you and
> others are Ok with it, how about something like this? Feel free to use the
> diff as a starting point or a different approach if you/others prefer
> something else. Thanks.

A few years rather than a few releases, but yes.  ;-)

The checks would need to go just before the "crowbar" stores.  I will put
something together after Byungchul's patches in this area have had time
to burn in for a few days.

							Thanx, Paul

> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8788ddbc0d13..176de74f5027 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -767,6 +767,21 @@ void rcu_idle_enter(void)
>   */
>  void rcu_user_enter(void)
>  {
> +	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> +
> +	/*
> +	 * Add warning to ensure: no known instances of entering userspace from
> +	 * IRQ/NMI handlers exist today. Currently special crowbarring of the
> +	 * dynticks_nmi_nesting and maintaining of this separate counter when
> +	 * dynticks_nesting exists, is done in order to handle entering of
> +	 * userspace from an IRQ context and never returning. Lets track it for
> +	 * a couple of kernel releases and then if the warning doesn't occur,
> +	 * we can try to simplify the code and combine/eliminate the counters.
> +	 * See: http://lkml.kernel.org/r/20180622181422.GT3593@linux.vnet.ibm.com
> +	 */
> +	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting &&
> +		     rdtp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
> +
>  	lockdep_assert_irqs_disabled();
>  	rcu_eqs_enter(true);
>  }
> 

