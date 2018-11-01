Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE97C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDEA2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDEA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeKATjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:39:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:52050 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeKATjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:39:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 03:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,451,1534834800"; 
   d="scan'208";a="100602029"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2018 03:36:35 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 8/8] KVM/x86/vPMU: return the counters to host if guest is torn down
Date:   Thu,  1 Nov 2018 18:04:08 +0800
Message-Id: <1541066648-40690-9-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the assigned counters to host in the case the guest is torn down
unexpectedly.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kvm/pmu_intel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
index 9eb5230..30fa8eb 100644
--- a/arch/x86/kvm/pmu_intel.c
+++ b/arch/x86/kvm/pmu_intel.c
@@ -410,7 +410,7 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
-	int i;
+	u32 i, bit;
 
 	for (i = 0; i < INTEL_PMC_MAX_GENERIC; i++) {
 		pmc = &pmu->gp_counters[i];
@@ -422,6 +422,10 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
 		pmc->counter = 0;
 	}
 
+	for_each_set_bit(bit, (unsigned long *)&pmu->assigned_pmc_bitmap,
+			 X86_PMC_IDX_MAX)
+		intel_pmu_put_pmc(pmu, bit);
+
 	pmu->fixed_ctr_ctrl = 0;
 	pmu->global_ctrl = 0;
 	pmu->global_status = 0;
-- 
2.7.4

