Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5840DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0931520C51
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0931520C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbeGKSkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:40:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732957AbeGKSkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:40:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BIUKOM027969
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:34:32 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5md9fdjp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:34:32 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 14:34:30 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 14:34:27 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BIYQBQ2425278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 18:34:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9081AB2064;
        Wed, 11 Jul 2018 14:34:25 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60CEAB206A;
        Wed, 11 Jul 2018 14:34:25 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 14:34:25 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5BAF716C3B70; Wed, 11 Jul 2018 11:36:45 -0700 (PDT)
Date:   Wed, 11 Jul 2018 11:36:45 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     peterz@infradead.org, mhillenb@amazon.de,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2] kvm/x86: Inform RCU of quiescent state when entering
 guest mode
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180711174843.GX3593@linux.vnet.ibm.com>
 <20180711180101.3711464-1-dwmw2@infradead.org>
 <20180711182053.GA3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711182053.GA3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071118-0068-0000-0000-000003168FEB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059897; UDB=6.00544006; IPR=6.00837817;
 MB=3.00022105; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 18:34:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071118-0069-0000-0000-000044FECFC7
Message-Id: <20180711183645.GA23820@linux.vnet.ibm.com>
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

On Wed, Jul 11, 2018 at 11:20:53AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 11, 2018 at 07:01:01PM +0100, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > RCU can spend long periods of time waiting for a CPU which is actually in
> > KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
> > modes, and don't wait for it.
> > 
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> And idiot here forgot about some of the debugging code in RCU's dyntick-idle
> code.  I will reply with a fixed patch.
> 
> The code below works just fine as long as you don't enable CONFIG_RCU_EQS_DEBUG,
> so should be OK for testing, just not for mainline.

And here is the updated code that allegedly avoids splatting when run with
CONFIG_RCU_EQS_DEBUG.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 12cd59e49cf734f907f44b696e2c6e4b46a291c3
Author: David Woodhouse <dwmw@amazon.co.uk>
Date:   Wed Jul 11 19:01:01 2018 +0100

    kvm/x86: Inform RCU of quiescent state when entering guest mode
    
    RCU can spend long periods of time waiting for a CPU which is actually in
    KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
    modes, and don't wait for it.
    
    Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    [ paulmck: Adjust to avoid bad advice I gave to dwmw, avoid WARN_ON()s. ]

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0046aa70205a..b0c82f70afa7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7458,7 +7458,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
 	}
 
+	rcu_kvm_enter();
 	kvm_x86_ops->run(vcpu);
+	rcu_kvm_exit();
 
 	/*
 	 * Do this here before restoring debug registers on the host.  And
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 7fa4fb9e899e..4b2d691e453f 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -85,6 +85,8 @@ static inline void rcu_virt_note_context_switch(int cpu) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline void rcu_idle_enter(void) { }
 static inline void rcu_idle_exit(void) { }
+static inline void rcu_kvm_enter(void) { }
+static inline void rcu_kvm_exit(void) { }
 static inline void rcu_irq_enter(void) { }
 static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 7f83179177d1..48ce58b53ece 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -55,6 +55,8 @@ void cond_synchronize_rcu(unsigned long oldstate);
 
 void rcu_idle_enter(void);
 void rcu_idle_exit(void);
+void rcu_kvm_enter(void);
+void rcu_kvm_exit(void);
 void rcu_irq_enter(void);
 void rcu_irq_exit(void);
 void rcu_irq_enter_irqson(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 765c81dd675e..0c0672faa6d1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -583,6 +583,24 @@ void rcu_idle_enter(void)
 	rcu_eqs_enter(false);
 }
 
+/**
+ * rcu_kvm_enter - inform RCU that current CPU is entering a guest OS
+ *
+ * Enter guest-OS mode, in other words, -leave- the mode in which RCU
+ * read-side critical sections can occur.  (Though RCU read-side critical
+ * sections can occur in irq handlers from guest OSes, a possibility
+ * handled by irq_enter() and irq_exit().)
+ *
+ * If you add or remove a call to rcu_kvm_enter(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ */
+void rcu_kvm_enter(void)
+{
+	lockdep_assert_irqs_disabled();
+	rcu_eqs_enter(true);
+}
+EXPORT_SYMBOL_GPL(rcu_kvm_enter);
+
 #ifdef CONFIG_NO_HZ_FULL
 /**
  * rcu_user_enter - inform RCU that we are resuming userspace.
@@ -747,6 +765,22 @@ void rcu_idle_exit(void)
 	local_irq_restore(flags);
 }
 
+/**
+ * rcu_kvm_exit - inform RCU that current CPU is leaving a guest OS
+ *
+ * Exit guest-OS mode, in other words, -enter- the mode in which RCU
+ * read-side critical sections can occur.
+ *
+ * If you add or remove a call to rcu_kvm_exit(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ */
+void rcu_kvm_exit(void)
+{
+	lockdep_assert_irqs_disabled();
+	rcu_eqs_exit(true);
+}
+EXPORT_SYMBOL_GPL(rcu_kvm_exit);
+
 #ifdef CONFIG_NO_HZ_FULL
 /**
  * rcu_user_exit - inform RCU that we are exiting userspace.

