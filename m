Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DACBECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480EC20673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480EC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbeGRRNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:13:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731323AbeGRRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:13:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IGSbAl091867
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:34:52 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ka7jbmq3g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:34:51 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 18 Jul 2018 12:34:51 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 12:34:48 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6IGYlLq15597976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 16:34:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D59FB2065;
        Wed, 18 Jul 2018 12:34:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D07AB205F;
        Wed, 18 Jul 2018 12:34:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jul 2018 12:34:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C2DB016C3E27; Wed, 18 Jul 2018 09:37:12 -0700 (PDT)
Date:   Wed, 18 Jul 2018 09:37:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531340384.8759.86.camel@infradead.org>
 <20180711210828.GD3593@linux.vnet.ibm.com>
 <1531396842.8759.125.camel@infradead.org>
 <20180712125351.GP3593@linux.vnet.ibm.com>
 <20180712161704.GA20726@linux.vnet.ibm.com>
 <20180716154015.GA21419@linux.vnet.ibm.com>
 <1531815548.19223.23.camel@infradead.org>
 <20180717125653.GH12945@linux.vnet.ibm.com>
 <20180718153628.GA24359@linux.vnet.ibm.com>
 <1531929711.3414.29.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531929711.3414.29.camel@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071816-0064-0000-0000-0000032C4C36
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009387; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062646; UDB=6.00545617; IPR=6.00840499;
 MB=3.00022187; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-18 16:34:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071816-0065-0000-0000-000039FC4BC9
Message-Id: <20180718163712.GB12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:01:51PM +0200, David Woodhouse wrote:
> On Wed, 2018-07-18 at 08:36 -0700, Paul E. McKenney wrote:
> > And I finally did get some near misses from an earlier commit, so we
> > should consider your patch to be officially off the hook.
> 
> Yay, I like it when it's not my fault. I'll redo it with the ifdef
> CONFIG_NO_HZ_FULL.

Hey, I didn't say it wasn't your fault, only that it -officially- wasn't
your fault.  ;-)

> What should it do for the !CONFIG_NO_HZ_FULL case? The existing call in
> guest_enter_irqoff() clearly wasn't actually doing the right thing
> anyway, hence the need for the need_resched() patch in $SUBJECT... so
> should I just leave it doing nothing in guest_enter_irqoff()? 

One starting point would be the combination of your patch and my
patch, with -rcu commit IDs and diff below.  But yes, it needs to be
!CONFIG_NO_HZ_FULL.  And no, I am not at all confident that I actually
found all the places needing change in the core code, so this needs some
serious review both by the KVM guys and the NO_HZ_FULL guys.

And some serious testing.  But you knew that already.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

57e3b96d012a kvm/x86: Inform RCU of quiescent state when entering guest mode
f437e330a720 kvm: Inform RCU of quiescent state when entering guest mode

------------------------------------------------------------------------

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d05609ad329d..8d2a9d3073ad 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -118,12 +118,12 @@ static inline void guest_enter_irqoff(void)
 	 * one time slice). Lets treat guest mode as quiescent state, just like
 	 * we do with user-mode execution.
 	 */
-	if (!context_tracking_cpu_is_enabled())
-		rcu_virt_note_context_switch(smp_processor_id());
+	rcu_kvm_enter();
 }
 
 static inline void guest_exit_irqoff(void)
 {
+	rcu_kvm_exit();
 	if (context_tracking_is_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
 
@@ -143,12 +143,13 @@ static inline void guest_enter_irqoff(void)
 	 */
 	vtime_account_system(current);
 	current->flags |= PF_VCPU;
-	rcu_virt_note_context_switch(smp_processor_id());
+	rcu_kvm_enter();
 }
 
 static inline void guest_exit_irqoff(void)
 {
 	/* Flush the guest cputime we spent on the guest */
+	rcu_kvm_exit();
 	vtime_account_system(current);
 	current->flags &= ~PF_VCPU;
 }
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 7fa4fb9e899e..a7aa5b3cfb81 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -81,10 +81,11 @@ static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
  * Take advantage of the fact that there is only one CPU, which
  * allows us to ignore virtualization-based context switches.
  */
-static inline void rcu_virt_note_context_switch(int cpu) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline void rcu_idle_enter(void) { }
 static inline void rcu_idle_exit(void) { }
+static inline void rcu_kvm_enter(void) { }
+static inline void rcu_kvm_exit(void) { }
 static inline void rcu_irq_enter(void) { }
 static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 7f83179177d1..62b61e579bb4 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -34,17 +34,6 @@ void rcu_softirq_qs(void);
 void rcu_note_context_switch(bool preempt);
 int rcu_needs_cpu(u64 basem, u64 *nextevt);
 void rcu_cpu_stall_reset(void);
-
-/*
- * Note a virtualization-based context switch.  This is simply a
- * wrapper around rcu_note_context_switch(), which allows TINY_RCU
- * to save a few bytes. The caller must have disabled interrupts.
- */
-static inline void rcu_virt_note_context_switch(int cpu)
-{
-	rcu_note_context_switch(false);
-}
-
 void synchronize_rcu_expedited(void);
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
@@ -55,6 +44,8 @@ void cond_synchronize_rcu(unsigned long oldstate);
 
 void rcu_idle_enter(void);
 void rcu_idle_exit(void);
+void rcu_kvm_enter(void);
+void rcu_kvm_exit(void);
 void rcu_irq_enter(void);
 void rcu_irq_exit(void);
 void rcu_irq_enter_irqson(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8674ef151d50..cb182b7b0d9a 100644
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

