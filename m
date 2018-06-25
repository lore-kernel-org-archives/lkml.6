Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448D2C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A8D25EF5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A8D25EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeFYRRX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:17:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934129AbeFYRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:17:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PHEFL3130270
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 13:17:21 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju267f51y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 13:17:21 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 13:17:20 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 13:17:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PHHGA414418296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 17:17:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 528F6B205F;
        Mon, 25 Jun 2018 13:17:11 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2179BB2064;
        Mon, 25 Jun 2018 13:17:11 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 13:17:11 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C280E16C6A76; Mon, 25 Jun 2018 10:19:20 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:19:20 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
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
 <20180622143247.781028b1@gandalf.local.home>
 <20180622200548.GA114655@joelaf.mtv.corp.google.com>
 <20180625082824.GB21377@X58A-UD3R>
 <20180625163951.GA52646@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625163951.GA52646@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062517-0060-0000-0000-000002824449
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009254; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052191; UDB=6.00539382; IPR=6.00830116;
 MB=3.00021851; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 17:17:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062517-0061-0000-0000-0000459267C7
Message-Id: <20180625171920.GR3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:39:51AM -0700, Joel Fernandes wrote:
> On Mon, Jun 25, 2018 at 05:28:24PM +0900, Byungchul Park wrote:
> > On Fri, Jun 22, 2018 at 01:05:48PM -0700, Joel Fernandes wrote:
> > > On Fri, Jun 22, 2018 at 02:32:47PM -0400, Steven Rostedt wrote:
> > > > On Fri, 22 Jun 2018 11:19:16 -0700
> > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > 
> > > > > Sure. So in a later thread you mentioned "usermode helpers". I took a closer
> > > > > look at that subsystem, and it seems you can execute usermode helpers from
> > > > > atomic sections with help of UMH_NO_WAIT flag.
> > > > > 
> > > > > Then I checked where this flag is used and it turns out its from the
> > > > > mce_work_trigger function in x86/kernel/cpu/mcheck/dev-mcelog.c which can be
> > > > > called infact from an interrupt context (mce_notify_irq).
> > > > > 
> > > > > Is this the usecase you remember causing this weird transitions to userspace?
> > > > 
> > > > But this case still looks like it uses work queues, it just doesn't
> > > > wait for the result.
> > > > 
> > > > I'll have to look at the code from what it looked like back in 2011, to
> > > > see if there was an actual issue here back then.
> > > 
> > > Good point Steve. So I guess in the current kernel sources, there's no code
> > > that uses UMH in IRQ context AFAICT. I'll go through the google group thread
> > > Paul pointed as well to study the history of the problem a bit more.
> > 
> > Me too. Good discussion we had thanks to you, Joel.
> 
> No problem, thanks for the patch in the first place which triggered this
> discussion.
> 
> For whatever its worth, I made some notes of what I understood from reading
> the code and old posts because I was sure I would otherwise forget
> everything:
> http://www.joelfernandes.org/linuxinternals/2018/06/15/rcu-dynticks.html
> 
> Feel free to comment on that post directly (or here) if you feel something is
> grossly wrong.
> 
> Again thank you and everyone for the discussion! ;-)

Not a bad writeup!  A few comments, as usual...

							Thanx, Paul

------------------------------------------------------------------------

	When I traced rdtp->dynticks_nesting, I could only find its
	value to be either a 0 or a 1. However looking back at old kernel
	sources, it appears that these can be nested becaues of so called
	“half-interrupts”. I believe these are basically interrupts
	that cause a transition to usermode due to usermode upcalls
	(usermode helper subsystem). So a nesting situation could be
	something like: 1. Transition from idle to process context which
	makes dynticks_nesting == 1. Next, an interrupt comes in which
	makes a usermode upcall. This usermode call now makes a system
	call causing entry back into process context, which increments
	the dynticks_nesting counter to 2. Such a crazy situation is
	perhaps possible.

The half-interrupts can instead cause ->dynticks_nmi_nesting to either
fail to return to zero or to go negative, depending on which half of
the interrupt was present.  I don't immediately recall the reason for
allowing nested process-level entry/exit.  Might be another place to
put a WARN_ON_ONCE(), as eliminating this capability would save another
conditional branch.

	Any time the rdtp->dynticks counter’s second-lowest most bit
	is not set, we are in an EQS, and if its set, then we are not
	(second lowest because lowest is reserved for something else as
	of v4.18-rc1). This function is not useful to check if we’re
	in an EQS from a timer tick though, because its possible the
	timer tick interrupt entry caused an EQS exit which updated
	the counter. IOW, the ‘dynticks’ counter is not capable of
	checking if we had already exited the EQS before. To check if
	we were in an EQS or not from the timer tick, we instead must
	use dynticks_nesting counter. More on that later. The above
	function is probably just useful to make sure that interrupt
	entry/exit is properly updating the dynticks counter, and also
	to make sure from non-interrupt context that RCU is in an EQS
	(see rcu_gp_fqs function).

You lost me on this one.  There is rcu_is_cpu_rrupt_from_idle(), but
I am not sure what you are trying to achieve here, so I am not sure
whether this function does what you want.

	When dynticks_nesting is decremented to 0 (the outermost
	process-context nesting level exit causes an eqs-entry), the
	dynticks_nmi_nesting is reset to

I think you want "0." at the end of this sentence.  Or maybe my browser
is messing things up.

							Thanx, Paul

