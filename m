Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA871C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E722080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E722080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeLNKRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:17:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16567 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728829AbeLNKRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:17:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B09C8A91BF2DF;
        Fri, 14 Dec 2018 18:17:12 +0800 (CST)
Received: from ros.huawei.com (10.143.28.118) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 18:17:10 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <peter.maydell@linaro.org>, <rkrcmar@redhat.com>, <corbet@lwn.net>,
        <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC RESEND PATCH] kvm: arm64: export memory error recovery capability to user space
Date:   Fri, 14 Dec 2018 02:15:37 -0800
Message-ID: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.118]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user space do memory recovery, it will check whether KVM and
guest support the error recovery, only when both of them support,
user space will do the error recovery. This patch exports this
capability of KVM to user space.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
User space needs to check this capability of KVM is suggested by Peter[1],
this patch as RFC tag because user space patches are still under review,
so this kernel patch is firstly sent out for review.

[1]: https://patchwork.codeaurora.org/patch/652261/
---
 Documentation/virtual/kvm/api.txt | 9 +++++++++
 arch/arm64/kvm/reset.c            | 1 +
 include/uapi/linux/kvm.h          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index cd209f7..241e2e2 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4895,3 +4895,12 @@ Architectures: x86
 This capability indicates that KVM supports paravirtualized Hyper-V IPI send
 hypercalls:
 HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
+
+8.21 KVM_CAP_ARM_MEMORY_ERROR_RECOVERY
+
+Architectures: arm, arm64
+
+This capability indicates that guest memory error can be detected by the KVM which
+supports the error recovery. When user space do recovery, such as QEMU, it will
+check whether KVM and guest support memory error recovery, only when both of them
+support, user space will do the error recovery.
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b72a3dd..90d1d9a 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -82,6 +82,7 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvm_arm_support_pmu_v3();
 		break;
 	case KVM_CAP_ARM_INJECT_SERROR_ESR:
+	case KVM_CAP_ARM_MEMORY_ERROR_RECOVERY:
 		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2b7a652..3b19580 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -975,6 +975,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
+#define KVM_CAP_ARM_MEMORY_ERROR_RECOVERY 166
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4

