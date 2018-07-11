Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDA4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740A4208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740A4208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbeGKSYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:24:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732496AbeGKSYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:24:09 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BIEKGG134430
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:18:38 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5md9ewcw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:18:38 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 14:18:37 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 14:18:34 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BIIYjT55509042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 18:18:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63DF7B205F;
        Wed, 11 Jul 2018 14:18:33 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45A03B2065;
        Wed, 11 Jul 2018 14:18:33 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 14:18:33 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3C5E316C3B6E; Wed, 11 Jul 2018 11:20:53 -0700 (PDT)
Date:   Wed, 11 Jul 2018 11:20:53 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     peterz@infradead.org, mhillenb@amazon.de,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2] kvm/x86: Inform RCU of quiescent state when entering
 guest mode
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180711174843.GX3593@linux.vnet.ibm.com>
 <20180711180101.3711464-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711180101.3711464-1-dwmw2@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071118-0060-0000-0000-0000028AB197
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059892; UDB=6.00544003; IPR=6.00837812;
 MB=3.00022105; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 18:18:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071118-0061-0000-0000-000045C323D1
Message-Id: <20180711182053.GA3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=961 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 07:01:01PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> RCU can spend long periods of time waiting for a CPU which is actually in
> KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
> modes, and don't wait for it.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

And idiot here forgot about some of the debugging code in RCU's dyntick-idle
code.  I will reply with a fixed patch.

The code below works just fine as long as you don't enable CONFIG_RCU_EQS_DEBUG,
so should be OK for testing, just not for mainline.

								Thanx, Paul

> ---
>  arch/x86/kvm/x86.c       | 2 ++
>  include/linux/rcupdate.h | 7 +++++++
>  kernel/rcu/tree.c        | 2 ++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0046aa70205a..b0c82f70afa7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7458,7 +7458,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
>  	}
> 
> +	rcu_kvm_enter();
>  	kvm_x86_ops->run(vcpu);
> +	rcu_kvm_exit();
> 
>  	/*
>  	 * Do this here before restoring debug registers on the host.  And
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 65163aa0bb04..1325f9d9ce00 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -212,6 +212,13 @@ do { \
>  #error "Unknown RCU implementation specified to kernel configuration"
>  #endif
> 
> +/*
> + * These are currently identical to the _idle_ versions but let's
> + * explicitly have separate copies to keep Paul honest in future.
> + */
> +static inline void rcu_kvm_enter(void) { rcu_idle_enter(); }
> +static inline void rcu_kvm_exit(void) { rcu_idle_exit(); }
> +
>  /*
>   * The init_rcu_head_on_stack() and destroy_rcu_head_on_stack() calls
>   * are needed for dynamic initialization and destruction of rcu_head
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index aa7cade1b9f3..d38c381bf4e3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -760,6 +760,7 @@ void rcu_idle_enter(void)
>  	lockdep_assert_irqs_disabled();
>  	rcu_eqs_enter(false);
>  }
> +EXPORT_SYMBOL_GPL(rcu_idle_enter);
> 
>  #ifdef CONFIG_NO_HZ_FULL
>  /**
> @@ -913,6 +914,7 @@ void rcu_idle_exit(void)
>  	rcu_eqs_exit(false);
>  	local_irq_restore(flags);
>  }
> +EXPORT_SYMBOL_GPL(rcu_idle_exit);
> 
>  #ifdef CONFIG_NO_HZ_FULL
>  /**
> -- 
> 2.17.1
> 

