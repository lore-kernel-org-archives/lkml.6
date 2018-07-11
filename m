Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F15C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736E620C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736E620C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390028AbeGKUVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:21:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733103AbeGKUVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:21:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BK8cRd011265
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 16:15:45 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5mmraa51-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 16:15:45 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 16:15:43 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 16:15:41 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BKFeh810289482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 20:15:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9CDCB205F;
        Wed, 11 Jul 2018 16:15:39 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9902B2068;
        Wed, 11 Jul 2018 16:15:39 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 16:15:39 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D136116C3B6A; Wed, 11 Jul 2018 13:17:59 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:17:59 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531168538.26547.5.camel@infradead.org>
 <20180709204248.GF3593@linux.vnet.ibm.com>
 <1531169145.26547.8.camel@infradead.org>
 <20180709210532.GH3593@linux.vnet.ibm.com>
 <20180709220823.GA18045@linux.vnet.ibm.com>
 <1531319025.8759.57.camel@infradead.org>
 <20180711144303.GQ3593@linux.vnet.ibm.com>
 <20180711164952.GA29994@linux.vnet.ibm.com>
 <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
 <9ee4d6fd-02e2-2c73-36a7-36ef4f6413b0@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee4d6fd-02e2-2c73-36a7-36ef4f6413b0@de.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071120-0072-0000-0000-0000037E7BD4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059931; UDB=6.00544026; IPR=6.00837851;
 MB=3.00022106; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 20:15:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071120-0073-0000-0000-000048ADD351
Message-Id: <20180711201759.GB3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:31:55PM +0200, Christian Borntraeger wrote:
> So why is the rcu_virt_note_context_switch(smp_processor_id());
> in guest_enter_irqoff not good enough? 
> 
> This was actually supposed to tell rcu that being in the guest
> is an extended quiescing period (like userspace).
> 
> What has changed?

As I understand it, they would like to have their guest run uninterrupted
for extended times.  Because rcu_virt_note_context_switch() is a
point-in-time quiescent state, it cannot tell RCU about the extended
quiescent state.

Should we replace the current calls to rcu_virt_note_context_switch()
with rcu_kvm_enter() and rcu_kvm_exit()?  Would that be better
than the below architecture-by-architecture approach?

							Thanx, Paul

> On 07/11/2018 07:03 PM, David Woodhouse wrote:
> > On Wed, 2018-07-11 at 09:49 -0700, Paul E. McKenney wrote:
> >> And here is an updated v4.15 patch with Marius's Reported-by and David's
> >> fix to my lost exclamation point.
> > 
> > Thanks. Are you sending the original version of that to Linus? It'd be
> > useful to have the commit ID so that we can watch for it landing, and
> > chase this one up to Greg.
> > 
> > As discussed on IRC, this patch reduces synchronize_sched() latency for
> > us from ~4600s to ~160ms, which is nice.
> > 
> > However, it isn't going to be sufficient in the NO_HZ_FULL case. For
> > that you want a patch like the one below, which happily reduces the
> > latency in our (!NO_HZ_FULL) case still further to ~40ms.
> > 
> > Adding kvm list for better review...
> > 
> > From: David Woodhouse <dwmw@amazon.co.uk>
> > Subject: [PATCH] kvm/x86: Inform RCU of quiescent state when entering guest mode
> > 
> > RCU can spend long periods of time waiting for a CPU which is actually in
> > KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
> > modes, and don't wait for it.
> > 
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > ---
> >  arch/x86/kvm/x86.c      |  2 ++
> >  include/linux/rcutree.h |  2 ++
> >  kernel/rcu/tree.c       | 16 ++++++++++++++++
> >  3 files changed, 20 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 0046aa70205a..b0c82f70afa7 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -7458,7 +7458,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >  		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
> >  	}
> > 
> > +	rcu_kvm_enter();
> >  	kvm_x86_ops->run(vcpu);
> > +	rcu_kvm_exit();
> > 
> >  	/*
> >  	 * Do this here before restoring debug registers on the host.  And
> > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > index 914655848ef6..6d07af5a50fc 100644
> > --- a/include/linux/rcutree.h
> > +++ b/include/linux/rcutree.h
> > @@ -82,6 +82,8 @@ void cond_synchronize_sched(unsigned long oldstate);
> > 
> >  void rcu_idle_enter(void);
> >  void rcu_idle_exit(void);
> > +void rcu_kvm_enter(void);
> > +void rcu_kvm_exit(void);
> >  void rcu_irq_enter(void);
> >  void rcu_irq_exit(void);
> >  void rcu_irq_enter_irqson(void);
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index aa7cade1b9f3..df7893273939 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1019,6 +1019,22 @@ void rcu_irq_enter_irqson(void)
> >  	local_irq_restore(flags);
> >  }
> > 
> > +/*
> > + * These are currently identical to the _idle_ versions but let's
> > + * explicitly have separate copies to keep Paul honest in future.
> > + */
> > +void rcu_kvm_enter(void)
> > +{
> > +	rcu_idle_enter();
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_kvm_enter);
> > +
> > +void rcu_kvm_exit(void)
> > +{
> > +	rcu_idle_exit();
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_kvm_exit);
> > +
> >  /**
> >   * rcu_is_watching - see if RCU thinks that the current CPU is idle
> >   *
> > 

