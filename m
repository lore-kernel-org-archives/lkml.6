Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9705FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E44E20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ENC6a6la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E44E20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390028AbeGKRJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:09:03 -0400
Received: from casper.infradead.org ([85.118.1.10]:38938 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbeGKRJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KVuU+JKR5yOnSuTRMuHFZw2lZ2I1AZ29tdBuFLwX6kc=; b=ENC6a6la6res5zmgZzzkgFZftr
        OcoC/mOo4FO0dxGpzTofhJUygr420kX8noipp9KFJOORdlKuGaJ1noCmyfkumVPrMg3/uMgnHirry
        6SUp7UX/cf2FuJg8ySHSHFVT/3953MsLP3JJvlvhalUYSRI4sKrx6sY6F9W6kB05ECWFq941sNkzK
        6l986/jq4SXPvhJnfS312UEGgs1ri9QkUlX8ObfHQOQuA56SdVjWYWy6fz06U6LEtU6Pg0qkVdXLP
        Iq12WW5Hl+Y/j5Ytwc+wZtssdNyEIN47bxC0A2f2YApJ4uAotw2R605qrWkMKJtEfb6wu9ZK7j24H
        XCyCdZBA==;
Received: from i7.infradead.org ([90.155.92.213])
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdIWm-0008FS-7z; Wed, 11 Jul 2018 17:03:44 +0000
Message-ID: <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
From:   David Woodhouse <dwmw2@infradead.org>
To:     paulmck@linux.vnet.ibm.com
Cc:     Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Date:   Wed, 11 Jul 2018 18:03:42 +0100
In-Reply-To: <20180711164952.GA29994@linux.vnet.ibm.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 09:49 -0700, Paul E. McKenney wrote:
> And here is an updated v4.15 patch with Marius's Reported-by and David's
> fix to my lost exclamation point.

Thanks. Are you sending the original version of that to Linus? It'd be
useful to have the commit ID so that we can watch for it landing, and
chase this one up to Greg.

As discussed on IRC, this patch reduces synchronize_sched() latency for
us from ~4600s to ~160ms, which is nice.

However, it isn't going to be sufficient in the NO_HZ_FULL case. For
that you want a patch like the one below, which happily reduces the
latency in our (!NO_HZ_FULL) case still further to ~40ms.

Adding kvm list for better review...

From: David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH] kvm/x86: Inform RCU of quiescent state when entering guest mode

RCU can spend long periods of time waiting for a CPU which is actually in
KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
modes, and don't wait for it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c      |  2 ++
 include/linux/rcutree.h |  2 ++
 kernel/rcu/tree.c       | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

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
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 914655848ef6..6d07af5a50fc 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -82,6 +82,8 @@ void cond_synchronize_sched(unsigned long oldstate);
 
 void rcu_idle_enter(void);
 void rcu_idle_exit(void);
+void rcu_kvm_enter(void);
+void rcu_kvm_exit(void);
 void rcu_irq_enter(void);
 void rcu_irq_exit(void);
 void rcu_irq_enter_irqson(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aa7cade1b9f3..df7893273939 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1019,6 +1019,22 @@ void rcu_irq_enter_irqson(void)
 	local_irq_restore(flags);
 }
 
+/*
+ * These are currently identical to the _idle_ versions but let's
+ * explicitly have separate copies to keep Paul honest in future.
+ */
+void rcu_kvm_enter(void)
+{
+	rcu_idle_enter();
+}
+EXPORT_SYMBOL_GPL(rcu_kvm_enter);
+
+void rcu_kvm_exit(void)
+{
+	rcu_idle_exit();
+}
+EXPORT_SYMBOL_GPL(rcu_kvm_exit);
+
 /**
  * rcu_is_watching - see if RCU thinks that the current CPU is idle
  *
-- 
2.17.1


-- 
dwmw2
