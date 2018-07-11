Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11881C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93FC20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93FC20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbeGKUbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:31:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732855AbeGKUbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:31:39 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BKNXa1075416
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 16:25:37 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k5pwe4tvy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 16:25:37 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 16:25:36 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 16:25:34 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BKPXaW12321246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 20:25:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F695B2068;
        Wed, 11 Jul 2018 16:25:32 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F1EDB2066;
        Wed, 11 Jul 2018 16:25:32 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 16:25:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8C62C16C3B70; Wed, 11 Jul 2018 13:27:52 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:27:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, peterz@infradead.org,
        mhillenb@amazon.de, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2] kvm/x86: Inform RCU of quiescent state when entering
 guest mode
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180711174843.GX3593@linux.vnet.ibm.com>
 <20180711180101.3711464-1-dwmw2@infradead.org>
 <20180711182053.GA3593@linux.vnet.ibm.com>
 <20180711183645.GA23820@linux.vnet.ibm.com>
 <62e945ee-a58e-f9b3-279c-74cd0f5809da@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e945ee-a58e-f9b3-279c-74cd0f5809da@de.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071120-0072-0000-0000-0000037E7D52
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059934; UDB=6.00544028; IPR=6.00837854;
 MB=3.00022106; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 20:25:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071120-0073-0000-0000-000048ADD920
Message-Id: <20180711202752.GC3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:39:36PM +0200, Christian Borntraeger wrote:
> 
> 
> On 07/11/2018 08:36 PM, Paul E. McKenney wrote:
> > On Wed, Jul 11, 2018 at 11:20:53AM -0700, Paul E. McKenney wrote:
> >> On Wed, Jul 11, 2018 at 07:01:01PM +0100, David Woodhouse wrote:
> >>> From: David Woodhouse <dwmw@amazon.co.uk>
> >>>
> >>> RCU can spend long periods of time waiting for a CPU which is actually in
> >>> KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
> >>> modes, and don't wait for it.
> >>>
> >>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> >>
> >> And idiot here forgot about some of the debugging code in RCU's dyntick-idle
> >> code.  I will reply with a fixed patch.
> >>
> >> The code below works just fine as long as you don't enable CONFIG_RCU_EQS_DEBUG,
> >> so should be OK for testing, just not for mainline.
> > 
> > And here is the updated code that allegedly avoids splatting when run with
> > CONFIG_RCU_EQS_DEBUG.
> > 
> > Thoughts?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 12cd59e49cf734f907f44b696e2c6e4b46a291c3
> > Author: David Woodhouse <dwmw@amazon.co.uk>
> > Date:   Wed Jul 11 19:01:01 2018 +0100
> > 
> >     kvm/x86: Inform RCU of quiescent state when entering guest mode
> >     
> >     RCU can spend long periods of time waiting for a CPU which is actually in
> >     KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
> >     modes, and don't wait for it.
> >     
> >     Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >     [ paulmck: Adjust to avoid bad advice I gave to dwmw, avoid WARN_ON()s. ]
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
> 
> As indicated in my other mail. This is supposed to be handled in the guest_enter|exit_ calls around
> the run function. This would also handle other architectures. So if the guest_enter_irqoff code is
> not good enough, we should rather fix that instead of adding another rcu hint.

Something like this, on top of the earlier patch?  I am not at all
confident of this patch because there might be other entry/exit
paths I am missing.  Plus there might be RCU uses on the arch-specific
patch to and from the guest OS.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b0c82f70afa7..0046aa70205a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7458,9 +7458,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
 	}
 
-	rcu_kvm_enter();
 	kvm_x86_ops->run(vcpu);
-	rcu_kvm_exit();
 
 	/*
 	 * Do this here before restoring debug registers on the host.  And
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
index 4b2d691e453f..a7aa5b3cfb81 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -81,7 +81,6 @@ static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
  * Take advantage of the fact that there is only one CPU, which
  * allows us to ignore virtualization-based context switches.
  */
-static inline void rcu_virt_note_context_switch(int cpu) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline void rcu_idle_enter(void) { }
 static inline void rcu_idle_exit(void) { }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 48ce58b53ece..62b61e579bb4 100644
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
 

