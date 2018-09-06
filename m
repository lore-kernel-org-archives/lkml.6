Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E43C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1B02075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1B02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeIFQgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:36:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:62809 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIFQgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:36:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 05:00:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="71046737"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2018 05:00:51 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com
Cc:     kan.liang@intel.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com, wei.w.wang@intel.com
Subject: [PATCH v2 2/8] KVM/x86: KVM_CAP_X86_GUEST_LBR
Date:   Thu,  6 Sep 2018 19:30:50 +0800
Message-Id: <1536233456-12173-3-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce KVM_CAP_X86_GUEST_LBR to allow per-VM enabling of the guest
lbr feature.

Signed-off-by: Like Xu <like.xu@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/x86.c              | 5 +++++
 include/uapi/linux/kvm.h        | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 00ddb0c..5db5ba3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -822,6 +822,7 @@ struct kvm_arch {
 
 	gpa_t wall_clock;
 
+	bool guest_lbr;
 	bool mwait_in_guest;
 	bool hlt_in_guest;
 	bool pause_in_guest;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 506bd2b..3eaf1b8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2927,6 +2927,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
  	case KVM_CAP_SPLIT_IRQCHIP:
 	case KVM_CAP_IMMEDIATE_EXIT:
 	case KVM_CAP_GET_MSR_FEATURES:
+	case KVM_CAP_X86_GUEST_LBR:
 		r = 1;
 		break;
 	case KVM_CAP_SYNC_REGS:
@@ -4350,6 +4351,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			kvm->arch.pause_in_guest = true;
 		r = 0;
 		break;
+	case KVM_CAP_X86_GUEST_LBR:
+		kvm->arch.guest_lbr = true;
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 07548de..7cf9bc0 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -952,6 +952,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_HPAGE_1M 156
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
+#define KVM_CAP_X86_GUEST_LBR 159
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4

