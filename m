Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48E4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766D12077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766D12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbeGKOp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:45:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388680AbeGKOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:45:28 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BEd70Y054291
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:40:48 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k5gv98dfg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:40:47 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 10:40:47 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 10:40:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BEej1Q22151370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 14:40:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E8D3B205F;
        Wed, 11 Jul 2018 10:40:44 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ACD6B2071;
        Wed, 11 Jul 2018 10:40:44 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 10:40:44 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 00A6316C2F11; Wed, 11 Jul 2018 07:43:03 -0700 (PDT)
Date:   Wed, 11 Jul 2018 07:43:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180709152632.GX2476@hirez.programming.kicks-ass.net>
 <20180709163432.GV3593@linux.vnet.ibm.com>
 <1531162254.26547.3.camel@infradead.org>
 <20180709203441.GE3593@linux.vnet.ibm.com>
 <1531168538.26547.5.camel@infradead.org>
 <20180709204248.GF3593@linux.vnet.ibm.com>
 <1531169145.26547.8.camel@infradead.org>
 <20180709210532.GH3593@linux.vnet.ibm.com>
 <20180709220823.GA18045@linux.vnet.ibm.com>
 <1531319025.8759.57.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531319025.8759.57.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071114-0040-0000-0000-0000044D2A45
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009350; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059819; UDB=6.00543959; IPR=6.00837739;
 MB=3.00022102; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 14:40:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071114-0041-0000-0000-000008534F96
Message-Id: <20180711144303.GQ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:23:45PM +0100, David Woodhouse wrote:
> 
> 
> On Mon, 2018-07-09 at 15:08 -0700, Paul E. McKenney wrote:
> > index f9c0ca2ccf0c..3350ece366ab 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2839,6 +2839,15 @@ void rcu_check_callbacks(int user)
> >                 rcu_bh_qs();
> >         }
> >         rcu_preempt_check_callbacks();
> > +       /* The load-acquire pairs with the store-release setting to true. */
> > +       if (smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs))) {
> > +               /* Idle and userspace execution already are quiescent states. */
> > +               if (rcu_is_cpu_rrupt_from_idle() && !user) {
> 
> if (idle && !user) seems tautological and... illogical.
> 
> If I make it 'if (!rcu_is_cpu_rrput_from_idle() && !user)' it seems to
> work better. Ripping out my debugging printks now to check that's still
> true...

Right you are!  I will step away for a bit to put a paper bag over
my head...

> (Also, isn't userspace execution only a quiescent state if NO_HZ_FULL?)

Userspace execution is a quiescent state in all cases.  However, you
are quite right that NO_HZ_FULL makes a difference, namely, it allows
one CPU to reliably determine whether or not some other CPU is
currently executing either in userspace or in idle.

Without NO_HZ_FULL, CPUs can only detect their own userspace execution.
Which is what is happening here because rcu_check_callbacks() is being
invoked from the scheduling-clock interrupt, which is where the "user"
parameter comes from.

So the above code can reliably detect the usermode-execution quiescent
state because it is always running on the CPU in question.

							Thanx, Paul

> > +                       set_tsk_need_resched(current);
> > +                       set_preempt_need_resched();
> > +               }
> > +               __this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
> > +       }


