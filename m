Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F5BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1FB2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1FB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbeGKRvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:51:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732987AbeGKRvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:51:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BHkNRt063500
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:46:28 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k5kcprfn0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:46:27 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 13:46:27 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 13:46:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BHkOQb9437522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 17:46:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3F22B2064;
        Wed, 11 Jul 2018 13:46:23 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8425BB2067;
        Wed, 11 Jul 2018 13:46:23 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 13:46:23 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6C66C16C3B6E; Wed, 11 Jul 2018 10:48:43 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:48:43 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180709203441.GE3593@linux.vnet.ibm.com>
 <1531168538.26547.5.camel@infradead.org>
 <20180709204248.GF3593@linux.vnet.ibm.com>
 <1531169145.26547.8.camel@infradead.org>
 <20180709210532.GH3593@linux.vnet.ibm.com>
 <20180709220823.GA18045@linux.vnet.ibm.com>
 <1531319025.8759.57.camel@infradead.org>
 <20180711144303.GQ3593@linux.vnet.ibm.com>
 <20180711164952.GA29994@linux.vnet.ibm.com>
 <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071117-0068-0000-0000-000003168ABB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059881; UDB=6.00543996; IPR=6.00837801;
 MB=3.00022105; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 17:46:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071117-0069-0000-0000-000044FEB497
Message-Id: <20180711174843.GX3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 06:03:42PM +0100, David Woodhouse wrote:
> On Wed, 2018-07-11 at 09:49 -0700, Paul E. McKenney wrote:
> > And here is an updated v4.15 patch with Marius's Reported-by and David's
> > fix to my lost exclamation point.
> 
> Thanks. Are you sending the original version of that to Linus? It'd be
> useful to have the commit ID so that we can watch for it landing, and
> chase this one up to Greg.

That would be great!  The commit ID is currently 6d1b6b684e1f ("rcu: Make
need_resched() respond to urgent RCU-QS needs"), but is subject to change
given the likely need to rebase in order to fix bugs in commits preceding
that one.  Given your Reported-by, you will be CCed when it reaches -tip,
won't you?  At that point, the commit ID would be set in stone.

Either way, I would very much welcome any help with -stable.  I would
be happy to send you an email when its commit ID become set in stone,
for example, if that would help.

> As discussed on IRC, this patch reduces synchronize_sched() latency for
> us from ~4600s to ~160ms, which is nice.

Woo-hoo!!!  ;-)

> However, it isn't going to be sufficient in the NO_HZ_FULL case. For
> that you want a patch like the one below, which happily reduces the
> latency in our (!NO_HZ_FULL) case still further to ~40ms.

Even better, good stuff, thank you!

> Adding kvm list for better review...

And a comment below.

							Thanx, Paul

> From: David Woodhouse <dwmw@amazon.co.uk>
> Subject: [PATCH] kvm/x86: Inform RCU of quiescent state when entering guest mode
> 
> RCU can spend long periods of time waiting for a CPU which is actually in
> KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
> modes, and don't wait for it.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/x86.c      |  2 ++
>  include/linux/rcutree.h |  2 ++
>  kernel/rcu/tree.c       | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0046aa70205a..b0c82f70afa7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7458,7 +7458,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
>  	} > 
> +	rcu_kvm_enter();
>  	kvm_x86_ops->run(vcpu);
> +	rcu_kvm_exit();
> 
>  	/*
>  	 * Do this here before restoring debug registers on the host.  And
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 914655848ef6..6d07af5a50fc 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -82,6 +82,8 @@ void cond_synchronize_sched(unsigned long oldstate);
> 
>  void rcu_idle_enter(void);
>  void rcu_idle_exit(void);
> +void rcu_kvm_enter(void);
> +void rcu_kvm_exit(void);
>  void rcu_irq_enter(void);
>  void rcu_irq_exit(void);
>  void rcu_irq_enter_irqson(void);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index aa7cade1b9f3..df7893273939 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1019,6 +1019,22 @@ void rcu_irq_enter_irqson(void)
>  	local_irq_restore(flags);
>  }
> 
> +/*
> + * These are currently identical to the _idle_ versions but let's
> + * explicitly have separate copies to keep Paul honest in future.
> + */
> +void rcu_kvm_enter(void)
> +{
> +	rcu_idle_enter();
> +}
> +EXPORT_SYMBOL_GPL(rcu_kvm_enter);
> +
> +void rcu_kvm_exit(void)
> +{
> +	rcu_idle_exit();
> +}
> +EXPORT_SYMBOL_GPL(rcu_kvm_exit);

These look good, but we also need these in include/linux/rcutiny.h:

	static inline void rcu_kvm_enter(void) { }
	static inline void rcu_kvm_exit(void) { }

Unless KVM is excluded on !SMP systems or some such.

Alternatively, you could just have a single pair of static inlines in
include/linux/rcupdate.h (after the #include of rcutree.h and rcutiny.h)
that mapped the _kvm_ functions to the _idle_ functions.  Your choice,
I am fine either way.

> +
>  /**
>   * rcu_is_watching - see if RCU thinks that the current CPU is idle
>   *
> -- 
> 2.17.1
> 
> 
> -- 
> dwmw2
> 

