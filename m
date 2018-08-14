Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0445C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9047921728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9047921728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbeHNUPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:15:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbeHNUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:15:41 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1CE03C5C;
        Tue, 14 Aug 2018 17:27:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.18 71/79] x86/speculation: Use ARCH_CAPABILITIES to skip L1D flush on vmentry
Date:   Tue, 14 Aug 2018 19:17:30 +0200
Message-Id: <20180814171340.852690243@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

Bit 3 of ARCH_CAPABILITIES tells a hypervisor that L1D flush on vmentry is
not needed.  Add a new value to enum vmx_l1d_flush_state, which is used
either if there is no L1TF bug at all, or if bit 3 is set in ARCH_CAPABILITIES.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    1 +
 arch/x86/include/asm/vmx.h       |    1 +
 arch/x86/kernel/cpu/bugs.c       |    1 +
 arch/x86/kvm/vmx.c               |   10 ++++++++++
 4 files changed, 13 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -70,6 +70,7 @@
 #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
 #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
 #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
+#define ARCH_CAP_SKIP_VMENTRY_L1DFLUSH	(1 << 3)   /* Skip L1D flush on vmentry */
 #define ARCH_CAP_SSB_NO			(1 << 4)   /*
 						    * Not susceptible to Speculative Store Bypass
 						    * attack, so no Speculative Store Bypass
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -582,6 +582,7 @@ enum vmx_l1d_flush_state {
 	VMENTER_L1D_FLUSH_COND,
 	VMENTER_L1D_FLUSH_ALWAYS,
 	VMENTER_L1D_FLUSH_EPT_DISABLED,
+	VMENTER_L1D_FLUSH_NOT_REQUIRED,
 };
 
 extern enum vmx_l1d_flush_state l1tf_vmx_mitigation;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -731,6 +731,7 @@ static const char *l1tf_vmx_states[] = {
 	[VMENTER_L1D_FLUSH_COND]		= "conditional cache flushes",
 	[VMENTER_L1D_FLUSH_ALWAYS]		= "cache flushes",
 	[VMENTER_L1D_FLUSH_EPT_DISABLED]	= "EPT disabled",
+	[VMENTER_L1D_FLUSH_NOT_REQUIRED]	= "flush not necessary"
 };
 
 static ssize_t l1tf_show_state(char *buf)
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -218,6 +218,16 @@ static int vmx_setup_l1d_flush(enum vmx_
 		return 0;
 	}
 
+       if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES)) {
+	       u64 msr;
+
+	       rdmsrl(MSR_IA32_ARCH_CAPABILITIES, msr);
+	       if (msr & ARCH_CAP_SKIP_VMENTRY_L1DFLUSH) {
+		       l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NOT_REQUIRED;
+		       return 0;
+	       }
+       }
+
 	/* If set to auto use the default l1tf mitigation method */
 	if (l1tf == VMENTER_L1D_FLUSH_AUTO) {
 		switch (l1tf_mitigation) {


