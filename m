Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53E2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A6D214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfAJOTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:19:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728166AbfAJOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:19:45 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AEIhxP044701
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:19:43 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2px5x5wf2v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:19:43 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 14:19:42 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 14:19:39 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0AEJcYj20709434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 14:19:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42ACEB206A;
        Thu, 10 Jan 2019 14:19:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24C01B2064;
        Thu, 10 Jan 2019 14:19:38 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 14:19:38 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D20C016C63DA; Thu, 10 Jan 2019 06:19:38 -0800 (PST)
Date:   Thu, 10 Jan 2019 06:19:38 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>
Subject: Re: Possible use of RCU while in extended QS: idle vs RCU read-side
 in interrupt vs rcu_eqs_exit
Reply-To: paulmck@linux.ibm.com
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com>
 <20190110041328.GE1215@linux.ibm.com>
 <219114011.864.1547101805680.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219114011.864.1547101805680.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011014-0068-0000-0000-00000380A715
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010379; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144474; UDB=6.00595908; IPR=6.00924738;
 MB=3.00025068; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 14:19:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011014-0069-0000-0000-00004714A69D
Message-Id: <20190110141938.GI1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 01:30:05AM -0500, Mathieu Desnoyers wrote:
> ----- On Jan 9, 2019, at 8:13 PM, paulmck paulmck@linux.ibm.com wrote:
> 
> > On Wed, Jan 09, 2019 at 08:38:51PM -0500, Mathieu Desnoyers wrote:
> >> Hi Paul,
> >> 
> >> I've had a user report that trace_sched_waking() appears to be
> >> invoked while !rcu_is_watching() in some situation, so I started
> >> digging into the scheduler idle code.
> >> 
> >> It appears that interrupts are re-enabled before rcu_eqs_exit() is
> >> invoked when exiting idle code from the scheduler.
> >> 
> >> I wonder what happens if an interrupt handler (including scheduler code)
> >> happens to issue a RCU read-side critical section before rcu_eqs_exit()
> >> is called ? Is there some code on interrupt entry that ensures rcu eqs
> >> state is exited in such scenario ?
> > 
> > Interrupt handlers are supposed to invoke irq_enter(), which will in
> > turn invoke rcu_irq_enter(), which should take care of things.
> > 
> > However, there are cases where a given architecture knows that a given
> > interrupt handler does not contain RCU readers, and in this case, the
> > architecture might omit the rcu_irq_enter() or maybe even the whole
> > irq_enter().  And then it is all fun and games until someone adds an
> > RCU read-side critical section.  ;-)
> 
> Even if an irq handler does not contain any RCU read-side critical
> section, won't it end by possibly invoking the scheduler before
> returning ? Considering that the scheduler has tracepoints which
> use RCU, this might be related to the issue that has been brought
> to my attention.

Most interrupt handlers just return, but yes, scheduler state is often
checked during return from interrupt.  But in that case, the interrupt
handler needs to have invoked irq_enter().

> Do you have examples of such interrupt handlers which do not invoke
> rcu_irq_enter() ?

Mostly examples of lightweight interrupts handlers that used to not invoke
irq_enter() and thus not rcu_irq_enter(), but which later started using
RCU readers.  Which means that they are no longer examples that do not
invoke rcu_irq_enter().  ;-)

Some of them just invoked rcu_irq_enter(), others had to do the full
irq_enter() call (which in turn invokes rcu_irq_enter()).

These interrupt handlers were very light-weight.  Page-table walkers,
hardware events, and the like.  Take an interrupt, look at a hardware
register, update a data structure, maybe write to a hardware register,
return from interrupt.

If there is only one such tracepoint, one approach is to use _rcuidle,
that is, instead of trace_blarvitz(), trace_blarvitz_rcuidle().  This can
add overhead, so this might not be appropriate for any of the scheduler's
fastpaths.  Which brings me back to the interrupt handler invoking
either irq_enter() or rcu_irq_enter().  Or moving the tracepoints to
a nearby region of code that RCU is already watching.

So, is it reasonably to add the rcu_irq_enter()?  If you do change this,
please test with CONFIG_RCU_EQS_DEBUG=y.

							Thanx, Paul

