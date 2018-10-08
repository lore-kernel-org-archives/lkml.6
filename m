Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238EEC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88C82085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88C82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJHLhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 07:37:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbeJHLhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 07:37:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 93DC263D172A0;
        Mon,  8 Oct 2018 12:27:15 +0800 (CST)
Received: from localhost.localdomain (10.143.28.90) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Mon, 8 Oct 2018 12:27:06 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <peter.maydell@linaro.org>, <drjones@redhat.com>,
        <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>
CC:     <gengdongjiu@huawei.com>
Subject: [PATCH v2 2/2] arm/arm64: KVM: enable 32 bits kvm vcpu events support
Date:   Mon, 8 Oct 2018 08:34:48 -0400
Message-ID: <1539002088-21215-3-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539002088-21215-1-git-send-email-gengdongjiu@huawei.com>
References: <1539002088-21215-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 539aee0edb9f ("KVM: arm64: Share the parts of
get/set events useful to 32bit") shares the get/set events
helper for arm64 and arm32, it is better also share the check
for vcpu events capability to enable 32 bit kvm vcpu events
support.

User space will check whether KVM supports vcpu events through
KVM_CAP_VCPU_EVENTS IOCTL.

Cc: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
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

