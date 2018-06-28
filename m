Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268ECC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0B524D28
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0B524D28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754955AbeF1Vjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:39:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753805AbeF1Vjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:39:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SLdjJn096580
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:39:45 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jw4sgf44n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:39:45 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Jun 2018 17:39:17 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 17:39:14 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5SLdDBG14876970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 21:39:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21B61B2067;
        Thu, 28 Jun 2018 17:39:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE719B206E;
        Thu, 28 Jun 2018 17:39:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 17:39:03 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8754A16C5F24; Thu, 28 Jun 2018 14:41:20 -0700 (PDT)
Date:   Thu, 28 Jun 2018 14:41:20 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        max.byungchul.park@gmail.com,
        Byungchul Park <byungchul.park@lge.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622205813.GV3593@linux.vnet.ibm.com>
 <20180622170042.4adfbe21@gandalf.local.home>
 <20180622211600.GX3593@linux.vnet.ibm.com>
 <CALCETrUqe_1dg=3KYOswGQv5i=_5WFYpcn27Z6oa2D7-nBa+Jw@mail.gmail.com>
 <20180623175356.GH3593@linux.vnet.ibm.com>
 <20180628200205.GA6374@linux.vnet.ibm.com>
 <20180628211315.GA230720@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628211315.GA230720@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062821-0072-0000-0000-00000376BC0A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009273; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053718; UDB=6.00540299; IPR=6.00831641;
 MB=3.00021914; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-28 21:39:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062821-0073-0000-0000-00004885DA8C
Message-Id: <20180628214120.GQ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 02:13:15PM -0700, Joel Fernandes wrote:
> On Thu, Jun 28, 2018 at 01:02:05PM -0700, Paul E. McKenney wrote:
> > > > <paulmck@linux.vnet.ibm.com> wrote:
> [..]
> > > > > > > > > So why this function-call structure?  Well, you see, NMI handlers can
> > > > > > > > > take what appear to RCU to be normal interrupts...
> > > > > > > > >
> > > > > > > > > (And I just added that fun fact to Requirements.html.)
> > > > > > > >
> > > > > > > > Yes, I'll definitely go through all the interrupt requirements in the doc and
> > > > > > > > thanks for referring me to it.
> > > > > > >
> > > > > > > My concern may well be obsolete.  It would be good if it was!  ;-)
> > > > > >
> > > > > > I'd love to mandate that irq_enter() must be paired with irq_exit(). I
> > > > > > don't really see any rationale for it to be otherwise. If there is a
> > > > > > case, perhaps it needs to be fixed.
> > > > >
> > > > > Given that the usermode helpers now look to be common code using
> > > > > workqueues, kthreads, and calls to do_execve(), it might well be that
> > > > > the days of half-interrupts are behind us.
> > > > >
> > > > > But how to actually validate this?  My offer of adding a WARN_ON_ONCE()
> > > > > and waiting a few years still stands, but perhaps you have a better
> > > > > approach.
> > > > 
> > > > I think you should add a WARN_ON_ONCE().  Let's get the bugs fixed.
> > > 
> > > Or the obscure features identified, as the case may be.  ;-)
> > > 
> > > Either way, will do!
> > 
> > And here is a prototype patch.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit ef544593a7bcad74628fa0537badc49dce1f2d95
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Thu Jun 28 12:45:23 2018 -0700
> > 
> >     rcu: Add warning to detect half-interrupts
> >     
> >     RCU's dyntick-idle code is written to tolerate half-interrupts, that it,
> >     either an interrupt that invokes rcu_irq_enter() but never invokes the
> >     corresponding rcu_irq_exit() on the one hand, or an interrupt that never
> >     invokes rcu_irq_enter() but does invoke the "corresponding" rcu_irq_exit()
> >     on the other.  These things really did happen at one time, as evidenced
> >     by this ca-2011 LKML post:
> >     
> >     http://lkml.kernel.org/r/20111014170019.GE2428@linux.vnet.ibm.com
> >     
> >     The reason why RCU tolerates half-interrupts is that usermode helpers
> >     used exceptions to invoke a system call from within the kernel such that
> >     the system call did a normal return (not a return from exception) to
> >     the calling context.  This caused rcu_irq_enter() to be invoked without
> >     a matching rcu_irq_exit().  However, usermode helpers have since been
> >     rewritten to make much more housebroken use of workqueues, kernel threads,
> >     and do_execve(), and therefore should no longer produce half-interrupts.
> >     No one knows of any other source of half-interrupts, but then again,
> >     no one seems insane enough to go audit the entire kernel to verify that
> >     half-interrupts really are a relic of the past.
> >     
> >     This commit therefore adds a pair of WARN_ON_ONCE() calls that will
> >     trigger in the presence of half interrupts, which the code will continue
> >     to handle correctly.  If neither of these WARN_ON_ONCE() trigger by
> >     mid-2021, then perhaps RCU can stop handling half-interrupts, which
> >     would be a considerable simplification.
> >     
> >     Reported-by: Steven Rostedt <rostedt@goodmis.org>
> >     Reported-by: Joel Fernandes <joel@joelfernandes.org>
> >     Reported-by: Andy Lutomirski <luto@kernel.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> Looks good to me!
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you!!!

							Thanx, Paul

