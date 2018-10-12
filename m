Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF2CC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F84620868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F84620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeJLXqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:46:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56567 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728882AbeJLXqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:46:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CA2D6E6D7B956;
        Sat, 13 Oct 2018 00:13:19 +0800 (CST)
Received: from SHA150392835-N.china.huawei.com (10.45.49.222) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Sat, 13 Oct 2018 00:13:13 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <suzuki.poulose@arm.com>, <james.morse@arm.com>,
        <peter.maydell@linaro.org>, <drjones@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>
CC:     <gengdongjiu@huawei.com>
Subject: [PATCH v4 2/2] arm/arm64: KVM: enable 32 bits kvm vcpu events support
Date:   Sat, 13 Oct 2018 00:12:49 +0800
Message-ID: <20181012161249.9236-3-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.11.0.windows.1
In-Reply-To: <20181012161249.9236-1-gengdongjiu@huawei.com>
References: <20181012161249.9236-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.45.49.222]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 539aee0edb9f ("KVM: arm64: Share the parts of
get/set events useful to 32bit") shares the get/set events
helper for arm64 and arm32, but forgot to share the cap
extension code.

User space will check whether KVM supports vcpu events by
checking the KVM_CAP_VCPU_EVENTS extension

Cc: James Morse <james.morse@arm.com>
Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Acked-by: James Morse <james.morse@arm.com>
---
For the 32 bits kvm migration, it needs to enable the vcpu events,
this patch will enable it. The user space QEMU patch is here:
https://patchwork.ozlabs.org/patch/975615/
---
 arch/arm64/kvm/reset.c | 1 -
 virt/kvm/arm/arm.c     | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index fd37c53..e50245e 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -82,7 +82,6 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_VCPU_ATTRIBUTES:
-	case KVM_CAP_VCPU_EVENTS:
 		r = 1;
 		break;
 	default:
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 40e79ea..64e5d97 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -212,6 +212,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_READONLY_MEM:
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_IMMEDIATE_EXIT:
+	case KVM_CAP_VCPU_EVENTS:
 		r = 1;
 		break;
 	case KVM_CAP_ARM_SET_DEVICE_ADDR:
-- 
1.9.1


