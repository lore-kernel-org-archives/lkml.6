Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947F3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669BB20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669BB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLFTMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:12:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:10038 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFTMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:12:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 11:12:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,323,1539673200"; 
   d="scan'208";a="98660756"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga006.jf.intel.com with ESMTP; 06 Dec 2018 11:12:14 -0800
From:   kan.liang@linux.intel.com
To:     rkrcmar@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, wei.w.wang@intel.com, like.xu@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH] KVM/x86/vPMU: Avoid counter reprogramming in kvm_pmu_handle_event
Date:   Thu,  6 Dec 2018 11:11:14 -0800
Message-Id: <1544123474-4909-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In the process of handling a guest overflow, KVM unconditionally
reprograms perf counters before entering guest. The reprogramming brings
very high overhead. For common case, (e.g. vCPU still runs on the same
CPU), it's unnecessary.

Here is current process of handling an overflow triggered by guest.
The patch intends to avoid the reprogramming in step 2.

PERF (HOST)                   KVM                          PERF (GUEST)

1. intel_pmu_handle_irq():
     Disable the counter
     ...
     overflow callback
                          overflow_intr():
                            request KVM_REQ_PMU
                            inject PMI to guest
                          overflow_intr() exit
     Enable the counter
   intel_pmu_handle_irq() exit
   ...

2.                        vcpu_enter_guest():
                            kvm_pmu_handle_event():
                              reprogram_counter():
                                pmc_stop_counter():
   Close the counter
                                pmc_reprogram_counter():
   Create a new counter
                            ...

3.                                             intel_pmu_handle_irq():
                                                  Disable all counters
                          pmc_stop_counter():
   Close the counter
                                                         ...
                                                  Enable all counters
                          pmc_reprogram_counter():
   Create a new counter
                                               intel_pmu_handle_irq exit

Only when the vcpu moves to another CPU before Step 2, the counter needs
to be reprogrammed for new CPU.
Otherwise, the reprogramming should be avoided. Because there is nothing
changed for perf event. The perf sub-system can take care of the
assigned counter.

The patch doesn't impact the counter value. Because the counter doesn't
count in host anyway.

The patch doesn't impact the behavior of step 3 (guest PMI handler). The
intel_pmu_handle_irq() is just an example. It could be any PMI handler.

The average duration of kvm_pmu_handle_event() is 85,282,765ns on
a 4 socket SKX with one guest which has perf sampling single event.
With the patch, the average duration is only 97ns.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/kvm/pmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 58ead7d..8436f32 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -221,8 +221,8 @@ EXPORT_SYMBOL_GPL(reprogram_counter);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	int bit, event_cpu;
 	u64 bitmask;
-	int bit;
 
 	bitmask = pmu->reprogram_pmi;
 
@@ -234,6 +234,16 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 			continue;
 		}
 
+		/*
+		 * It doesn't need to reprogram the counters unless
+		 * the CPU which vcpu runs on has changed.
+		 */
+		event_cpu = READ_ONCE(pmc->perf_event->oncpu);
+		if (event_cpu == vcpu->cpu) {
+			clear_bit(bit, (unsigned long *)&pmu->reprogram_pmi);
+			continue;
+		}
+
 		reprogram_counter(pmu, bit);
 	}
 }
-- 
2.7.4

