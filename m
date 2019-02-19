Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D4DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605C32147C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfBRL0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:26:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:13652 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfBRL0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:26:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 03:26:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,384,1544515200"; 
   d="scan'208";a="275885435"
Received: from vmm.bj.intel.com ([10.240.192.123])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2019 03:26:49 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com, ak@linux.intel.com,
        konrad.wilk@oracle.com, Janakarajan.Natarajan@amd.com,
        mattst88@gmail.com, tim.c.chen@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v2 1/2] KVM: x86: Inject PMI for KVM guest
Date:   Mon, 18 Feb 2019 19:26:07 -0500
Message-Id: <1550535968-7652-2-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550535968-7652-1-git-send-email-luwei.kang@intel.com>
References: <1550535968-7652-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inject a PMI for KVM guest when Intel PT working
in Host-Guest mode and Guest ToPA entry memory buffer
was completely filled.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/core.c     |  6 +++++-
 arch/x86/include/asm/msr-index.h |  4 ++++
 arch/x86/kvm/x86.c               | 10 ++++++++++
 include/linux/perf_event.h       |  1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 730978d..37cecff 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2273,7 +2273,11 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(55, (unsigned long *)&status)) {
 		handled++;
-		intel_pt_interrupt();
+		if (unlikely(perf_guest_cbs && perf_guest_cbs->is_in_guest() &&
+			perf_guest_cbs->handle_intel_pt_intr))
+			perf_guest_cbs->handle_intel_pt_intr();
+		else
+			intel_pt_interrupt();
 	}
 
 	/*
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 8e40c24..ae01fb0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -775,6 +775,10 @@
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
 
+/* PERF_GLOBAL_OVF_CTL bits */
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT	55
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI		(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT)
+
 /* Geode defined MSRs */
 #define MSR_GEODE_BUSCONT_CONF0		0x00001900
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 941f932..d1f4e0a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6795,10 +6795,20 @@ static unsigned long kvm_get_guest_ip(void)
 	return ip;
 }
 
+static void kvm_handle_intel_pt_intr(void)
+{
+	struct kvm_vcpu *vcpu = __this_cpu_read(current_vcpu);
+
+	kvm_make_request(KVM_REQ_PMI, vcpu);
+	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
+			(unsigned long *)&vcpu->arch.pmu.global_status);
+}
+
 static struct perf_guest_info_callbacks kvm_guest_cbs = {
 	.is_in_guest		= kvm_is_in_guest,
 	.is_user_mode		= kvm_is_user_mode,
 	.get_guest_ip		= kvm_get_guest_ip,
+	.handle_intel_pt_intr	= kvm_handle_intel_pt_intr,
 };
 
 static void kvm_set_mmio_spte_mask(void)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e1a0517..2b26a34 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -30,6 +30,7 @@ struct perf_guest_info_callbacks {
 	int				(*is_in_guest)(void);
 	int				(*is_user_mode)(void);
 	unsigned long			(*get_guest_ip)(void);
+	void				(*handle_intel_pt_intr)(void);
 };
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-- 
1.8.3.1

