Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D500C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5411020872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5411020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeFTO4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:56:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754002AbeFTO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:56:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KEkj0i155428
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:56:43 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqpkbqvmc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:56:43 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 10:56:42 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 10:56:40 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KEudro9044710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 14:56:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24614B2065;
        Wed, 20 Jun 2018 10:56:28 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04D09B205F;
        Wed, 20 Jun 2018 10:56:28 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 10:56:27 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ED4FD16C2DE8; Wed, 20 Jun 2018 07:58:40 -0700 (PDT)
Date:   Wed, 20 Jun 2018 07:58:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [RFC 1/2] rcu: Do prepare and cleanup idle depending on in_nmi()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <20180620093309.7d07715a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620093309.7d07715a@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062014-0072-0000-0000-000003722D67
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009227; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049754; UDB=6.00537917; IPR=6.00828727;
 MB=3.00021760; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 14:56:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062014-0073-0000-0000-0000486D794A
Message-Id: <20180620145840.GR3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=984 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 09:33:09AM -0400, Steven Rostedt wrote:
> On Wed, 20 Jun 2018 17:47:19 +0900
> Byungchul Park <byungchul.park@lge.com> wrote:
> 
> > Get rid of dependency on ->dynticks_nmi_nesting.
> 
> This is not a trivial change. Can you please explain the rational and
> background in the change log. Add enough context here to know why this
> change is needed.

What Steve said!!!

							Thanx, Paul

> Thanks!
> 
> -- Steve
> 
> > 
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > ---
> >  kernel/rcu/tree.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index deb2508..59ae94e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -797,6 +797,11 @@ void rcu_nmi_exit(void)
> >  		return;
> >  	}
> >  
> > +	if (!in_nmi()) {
> > +		rcu_prepare_for_idle();
> > +		rcu_dynticks_task_enter();
> > +	}
> > +
> >  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> >  	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
> >  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> > @@ -824,14 +829,8 @@ void rcu_nmi_exit(void)
> >   */
> >  void rcu_irq_exit(void)
> >  {
> > -	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> > -
> >  	lockdep_assert_irqs_disabled();
> > -	if (rdtp->dynticks_nmi_nesting == 1)
> > -		rcu_prepare_for_idle();
> >  	rcu_nmi_exit();
> > -	if (rdtp->dynticks_nmi_nesting == 0)
> > -		rcu_dynticks_task_enter();
> >  }
> >  
> >  /*
> > @@ -944,6 +943,11 @@ void rcu_nmi_enter(void)
> >  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> >  		rcu_dynticks_eqs_exit();
> >  		incby = 1;
> > +
> > +		if (!in_nmi()) {
> > +			rcu_dynticks_task_exit();
> > +			rcu_cleanup_after_idle();
> > +		}
> >  	}
> >  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> >  			  rdtp->dynticks_nmi_nesting,
> > @@ -977,14 +981,8 @@ void rcu_nmi_enter(void)
> >   */
> >  void rcu_irq_enter(void)
> >  {
> > -	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> > -
> >  	lockdep_assert_irqs_disabled();
> > -	if (rdtp->dynticks_nmi_nesting == 0)
> > -		rcu_dynticks_task_exit();
> >  	rcu_nmi_enter();
> > -	if (rdtp->dynticks_nmi_nesting == 1)
> > -		rcu_cleanup_after_idle();
> >  }
> >  
> >  /*
> 

