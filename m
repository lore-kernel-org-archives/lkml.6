Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DAFC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9462458D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9462458D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934364AbeFVQKL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:10:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934008AbeFVQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:10:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MG8tTM094472
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:10:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2js1ne7f6k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:10:08 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 12:10:07 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 12:10:04 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MGA3pf9503052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 16:10:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89A82B2068;
        Fri, 22 Jun 2018 12:10:02 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51965B2065;
        Fri, 22 Jun 2018 12:10:02 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 12:10:02 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8522C16C429C; Fri, 22 Jun 2018 09:12:05 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:12:05 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     joel@joelfernandes.org, max.byungchul.park@gmail.com,
        Byungchul Park <byungchul.park@lge.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <CALCETrXgubD2BBx9Xe2PALbStgPYc=_GTNkoH03469rpN5JwZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXgubD2BBx9Xe2PALbStgPYc=_GTNkoH03469rpN5JwZw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062216-0040-0000-0000-00000443ED4A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009239; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050739; UDB=6.00538508; IPR=6.00829709;
 MB=3.00021808; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 16:10:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062216-0041-0000-0000-0000084A0026
Message-Id: <20180622161205.GQ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 07:19:13AM -0700, Andy Lutomirski wrote:
> On Fri, Jun 22, 2018 at 6:26 AM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > On Thu, Jun 21, 2018 at 10:56:59PM -0700, Joel Fernandes wrote:
> > > Hi Paul,
> > >
> > > On Wed, Jun 20, 2018 at 09:49:02AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Jun 21, 2018 at 01:05:22AM +0900, Byungchul Park wrote:
> > > > > On Wed, Jun 20, 2018 at 11:58 PM, Paul E. McKenney
> > > > > <paulmck@linux.vnet.ibm.com> wrote:
> > > > > > On Wed, Jun 20, 2018 at 05:47:20PM +0900, Byungchul Park wrote:
> > > > > >> Hello folks,
> > > > > >>
> > > > > >> I'm careful in saying that ->dynticks_nmi_nesting can be removed but I
> > > > > >> think it's possible since the only thing we are interested in with
> > > > > >> regard to ->dynticks_nesting or ->dynticks_nmi_nesting is whether rcu is
> > > > > >> idle or not.
> > > > > >
> > > > > > Please keep in mind that NMIs cannot be masked, which means that the
> > > > > > rcu_nmi_enter() and rcu_nmi_exit() pair can be invoked at any point in
> > > > > > the process, between any consecutive pair of instructions.  The saving
> > > >
> > > > And yes, I should have looked at this patch more closely before replying.
> > > > But please see below.
> > > >
> > > > > I believe I understand what NMI is and why you introduced
> > > > > ->dynticks_nmi_nesting. Or am I missing something?
> > > >
> > > > Perhaps the fact that there are architectures that can enter interrupt
> > > > handlers and never leave them when the CPU is non-idle.  One example of
> > > > this is the usermode upcalls in the comment that you removed.
> > >
> > > I spent some time tonight and last night trying to understand this concept of
> > > never leaving an interrupt, I hope you don't mind me asking this dumb
> > > question... perhaps I will learn something : Could you let me know how is it
> > > possible that an interrupt never exits?
> > >
> > > Typically an interrupt never exiting sounds like a hard-lockup. This is how
> > > hardlock detector works: Since regular interrupts in linux can't nest, the
> > > hardlockup detector checks if hrtimer interrupts are being handled and if
> > > not, then it throws a splat, panics the kernel etc. So I am a bit troubled by
> > > this interrupt never exiting concept..
> > >
> > > Further since an interrupt is an atomic context, it cannot sleep or schedule
> > > into usermode so how are these upcalls handled from the interrupt?
> >
> > It has been some years since I traced the code flow, but what happened
> > back then is that it switches itself from an interrupt handler to not
> > without actually returning from the interrupt.  This can only happen when
> > interrupting a non-idle process, thankfully, and RCU's dyntick-idle code
> > relies on this restriction.  If I remember correctly, the code ends up
> > executing in the context of the interrupted process, but it has been some
> > years, so please apply appropriate skepticism.
> 
> ...
> 
> >
> > I have never seen NMIs be unpaired or improperly nested.  However,
> > given that rcu_irq_enter() invokes rcu_nmi_enter() and rcu_irq_exit()
> > invokes rcu_nmi_exit(), it is definitely the case that rcu_nmi_enter()
> > and rcu_nmi_exit() need to deal with unpaired and improperly nested
> > invocations.
> 
> This is very strange.  There are certainly cases in x86 where an
> interrupt-ish code path can become less interrupt-ish without
> returning (killing a task that overflows a kernel stack is an
> example), but the RCU calls should still nest correctly.  Do you know
> the history of this requirement?

I believe that they are called "usermode helpers", and are (were?)
used on a number of architectures to implement system calls from
within the kernel.

							Thanx, Paul

