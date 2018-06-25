Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE798C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACE625D0F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACE625D0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbeFYPll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:41:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752187AbeFYPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:41:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PFdDuB140240
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:41:39 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju00qa7dh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:41:39 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 11:41:38 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 11:41:34 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PFfXGl1900862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 15:41:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D34EFB2066;
        Mon, 25 Jun 2018 11:41:28 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2A9DB2067;
        Mon, 25 Jun 2018 11:41:28 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 11:41:28 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 288E216C6A76; Mon, 25 Jun 2018 08:43:38 -0700 (PDT)
Date:   Mon, 25 Jun 2018 08:43:38 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
 <20180622062351.GC17010@X58A-UD3R>
 <20180623174954.GA3584@linux.vnet.ibm.com>
 <20180625100708.3cb50ced@gandalf.local.home>
 <20180625144849.GN3593@linux.vnet.ibm.com>
 <20180625110248.5e679a8d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625110248.5e679a8d@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062515-0052-0000-0000-00000303C724
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009253; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052159; UDB=6.00539363; IPR=6.00830085;
 MB=3.00021850; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 15:41:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062515-0053-0000-0000-00005D22B674
Message-Id: <20180625154338.GP3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:02:48AM -0400, Steven Rostedt wrote:
> On Mon, 25 Jun 2018 07:48:49 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > > @@ -923,7 +932,7 @@ void rcu_user_exit(void)
> > > >  #endif /* CONFIG_NO_HZ_FULL */
> > > >  
> > > >  /**
> > > > - * rcu_nmi_enter - inform RCU of entry to NMI context
> > > > + * rcu_nmi_enter_common - inform RCU of entry to NMI context
> > > >   *
> > > >   * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
> > > >   * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
> > > > @@ -931,10 +940,10 @@ void rcu_user_exit(void)
> > > >   * long as the nesting level does not overflow an int.  (You will probably
> > > >   * run out of stack space first.)
> > > >   *
> > > > - * If you add or remove a call to rcu_nmi_enter(), be sure to test
> > > > + * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> > > >   * with CONFIG_RCU_EQS_DEBUG=y.
> > > >   */
> > > > -void rcu_nmi_enter(void)
> > > > +static __always_inline void rcu_nmi_enter_common(bool irq)
> > > >  {
> > > >  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> > > >  	long incby = 2;
> > > > @@ -951,7 +960,15 @@ void rcu_nmi_enter(void)
> > > >  	 * period (observation due to Andy Lutomirski).
> > > >  	 */
> > > >  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> > > > +
> > > > +		if (irq)
> > > > +			rcu_dynticks_task_exit();
> > > > +
> > > >  		rcu_dynticks_eqs_exit();
> > > > +
> > > > +		if (irq)
> > > > +			rcu_cleanup_after_idle();
> > > > +
> > > >  		incby = 1;
> > > >  	}
> > > >  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),  
> > > 
> > > 
> > > There is a slight change here, although I don't think it is an issue,
> > > but I want to bring it up just in case.
> > > 
> > > The old way had:
> > > 
> > > 	rcu_dynticks_task_exit();
> > > 	rcu_dynticks_eqs_exit();
> > > 	trace_rcu_dyntick();
> > > 	rcu_cleanup_after_idle();
> > > 
> > > The new way has:
> > > 
> > > 	rcu_dynticks_task_exit();
> > > 	rcu_dynticks_eqs_exit();
> > > 	rcu_cleanup_after_idle();
> > > 	trace_rcu_dyntick();
> > > 
> > > As that tracepoint will use RCU, will this cause any side effects?
> > > 
> > > My thought is that the new way is actually more correct, as I'm not
> > > sure we wanted RCU usage before the rcu_cleanup_after_idle().  
> > 
> > I believe that this is OK because is is the position of the call to
> > rcu_dynticks_eqs_exit() that really matters.  Before this call, RCU
> > is not yet watching, and after this call it is watching.  Reversing
> > the calls to rcu_cleanup_after_idle() and trace_rcu_dyntick() has them
> > both being invoked while RCU is watching.
> > 
> > All that rcu_cleanup_after_idle() does is to account for the time that
> > passed while the CPU was idle, for example, advancing callbacks to allow
> > for how ever many RCU grace periods completed during that idle period.
> > 
> > Or am I missing something subtle.
> 
> As I stated above, I actually think the new way is more correct. That's
> because the trace event is the first user of RCU here and it probably
> wont be the last. It makes more sense to do it after the call to
> rcu_cleanup_after_idle(), just because it keeps all the RCU users after
> the RCU internal code for coming out of idle. Sure,
> rcu_cleanup_after_idle() doesn't do anything now that could affect
> this, but maybe it will in the future?

If rcu_cleanup_after_idle() job changes, then yes, changes might be
needed here and perhaps elsewhere as well.  ;-)

> > (At the very least, you would be quite right to ask that this be added
> > to the commit log!)
> 
> Yes, I agree. There should be a comment in the change log about this
> simply because this is technically a functional change.

Very good, will do!

							Thanx, Paul

