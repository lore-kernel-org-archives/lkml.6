Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CD6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6353520C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WqGspgUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6353520C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390175AbeGKSGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:06:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388829AbeGKSGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Reply-To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xU8xnt5z0i0cOwf5Oj2C7sEJ0zxv39qS3yuH5uF96TI=; b=WqGspgUPM3PEnscGmH0xgxfNP
        CWyyNEL3TwGB17eNZlDKDoyGLD/oG7GBXohC7F/P5wH8jlKpnOnyLPtJ4znEbNV2iyfR+3uf7r1Kl
        sm4CW1NXb4Vm4cwHnBVL+hQWjpsE+41QhnIM8y4MYP60xeA2dY4TuX9l3UhSG3yuUbZwfoIRX5YrQ
        NMy/VxRf+a4eNivPYtpjLEBMK/tsVpPTt3m4mv8xwhtB0Noiqhxr2YYTi82YppcRdKfZ+hnOMT/Qt
        FLG3XK0tF+CMyY4bGFWLb77Fv/ra5kgd7xLqGwyvlfC5ONGEAsA2pDcFgDMKWpI0gJiMzaVIAcomP
        C+Md08Hzw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdJQF-0005Ga-5z; Wed, 11 Jul 2018 18:01:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.91 #2 (Red Hat Linux))
        id 1fdJQD-00FZXD-Mg; Wed, 11 Jul 2018 19:01:01 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     peterz@infradead.org, mhillenb@amazon.de,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        paulmck@linux.vnet.ibm.com
Subject: [PATCH v2] kvm/x86: Inform RCU of quiescent state when entering guest mode
Date:   Wed, 11 Jul 2018 19:01:01 +0100
Message-Id: <20180711180101.3711464-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711174843.GX3593@linux.vnet.ibm.com>
References: <20180711174843.GX3593@linux.vnet.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

RCU can spend long periods of time waiting for a CPU which is actually in
KVM guest mode, entirely pointlessly. Treat it like the idle and userspace
modes, and don't wait for it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c       | 2 ++
 include/linux/rcupdate.h | 7 +++++++
 kernel/rcu/tree.c        | 2 ++
 3 files changed, 11 insertions(+)

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
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 65163aa0bb04..1325f9d9ce00 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -212,6 +212,13 @@ do { \
 #error "Unknown RCU implementation specified to kernel configuration"
 #endif
 
+/*
+ * These are currently identical to the _idle_ versions but let's
+ * explicitly have separate copies to keep Paul honest in future.
+ */
+static inline void rcu_kvm_enter(void) { rcu_idle_enter(); }
+static inline void rcu_kvm_exit(void) { rcu_idle_exit(); }
+
 /*
  * The init_rcu_head_on_stack() and destroy_rcu_head_on_stack() calls
  * are needed for dynamic initialization and destruction of rcu_head
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aa7cade1b9f3..d38c381bf4e3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -760,6 +760,7 @@ void rcu_idle_enter(void)
 	lockdep_assert_irqs_disabled();
 	rcu_eqs_enter(false);
 }
+EXPORT_SYMBOL_GPL(rcu_idle_enter);
 
 #ifdef CONFIG_NO_HZ_FULL
 /**
@@ -913,6 +914,7 @@ void rcu_idle_exit(void)
 	rcu_eqs_exit(false);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(rcu_idle_exit);
 
 #ifdef CONFIG_NO_HZ_FULL
 /**
-- 
2.17.1

