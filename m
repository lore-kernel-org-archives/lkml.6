Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F7EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBBA20C51
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBBA20C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeGKShi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:37:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732344AbeGKShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:37:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BITPH7011940
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:32:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k5mcwqaym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:32:03 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 11 Jul 2018 19:32:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 19:31:57 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BIVug729032536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 18:31:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F080A4053;
        Wed, 11 Jul 2018 21:32:18 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01D94A4057;
        Wed, 11 Jul 2018 21:32:18 +0100 (BST)
Received: from oc7330422307.ibm.com (unknown [9.145.165.185])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 21:32:17 +0100 (BST)
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
To:     David Woodhouse <dwmw2@infradead.org>, paulmck@linux.vnet.ibm.com
Cc:     Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
References: <20180709163432.GV3593@linux.vnet.ibm.com>
 <1531162254.26547.3.camel@infradead.org>
 <20180709203441.GE3593@linux.vnet.ibm.com>
 <1531168538.26547.5.camel@infradead.org>
 <20180709204248.GF3593@linux.vnet.ibm.com>
 <1531169145.26547.8.camel@infradead.org>
 <20180709210532.GH3593@linux.vnet.ibm.com>
 <20180709220823.GA18045@linux.vnet.ibm.com>
 <1531319025.8759.57.camel@infradead.org>
 <20180711144303.GQ3593@linux.vnet.ibm.com>
 <20180711164952.GA29994@linux.vnet.ibm.com>
 <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Wed, 11 Jul 2018 20:31:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071118-0012-0000-0000-00000289236C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071118-0013-0000-0000-000020BAC746
Message-Id: <9ee4d6fd-02e2-2c73-36a7-36ef4f6413b0@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So why is the rcu_virt_note_context_switch(smp_processor_id());
in guest_enter_irqoff not good enough? 

This was actually supposed to tell rcu that being in the guest
is an extended quiescing period (like userspace).

What has changed?



On 07/11/2018 07:03 PM, David Woodhouse wrote:
> On Wed, 2018-07-11 at 09:49 -0700, Paul E. McKenney wrote:
>> And here is an updated v4.15 patch with Marius's Reported-by and David's
>> fix to my lost exclamation point.
> 
> Thanks. Are you sending the original version of that to Linus? It'd be
> useful to have the commit ID so that we can watch for it landing, and
> chase this one up to Greg.
> 
> As discussed on IRC, this patch reduces synchronize_sched() latency for
> us from ~4600s to ~160ms, which is nice.
> 
> However, it isn't going to be sufficient in the NO_HZ_FULL case. For
> that you want a patch like the one below, which happily reduces the
> latency in our (!NO_HZ_FULL) case still further to ~40ms.
> 
> Adding kvm list for better review...
> 
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
>  	}
> 
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
> +
>  /**
>   * rcu_is_watching - see if RCU thinks that the current CPU is idle
>   *
> 

