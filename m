Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC208C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8194421927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198133;
	bh=aaJVp55CTXuaXx9jliqdiG47J4cyVZSwbncctg49O/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iyGy6lJg2uzV/lCxdT0mnHVEc5ZH8OCHFPJgaFfimY+kUDe06FPCUVfaIJTjibb2J
	 JPHk/QdeP0nVEJJg6fCNOY+leTuVYoSS5P6wxjEfnJd11+4Qg0T998mqC/DeQ5rPY/
	 eAmcC8DnrFWCaLJoVpLJ31asnTPiYVheQND51nTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbfBOCfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:35:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732138AbfBOCLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A8021B68;
        Fri, 15 Feb 2019 02:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196664;
        bh=aaJVp55CTXuaXx9jliqdiG47J4cyVZSwbncctg49O/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVlOdPxHlOlli0+3+Xebty1xYNTEFYTe9rEhykYSmF8eG7hUVmAKPXhR0pi30LkLN
         kh+dCMt7K2hNN98WGULbtlIu9sJse0MpO+BPwKU1oTvNEAEsgsSMGVp9vO4NrBTNGb
         N2XjvsybZ14Rw/eKfyHwcJ3C1vPKvmWgLKF+TJ5c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 73/77] svm: Fix AVIC incomplete IPI emulation
Date:   Thu, 14 Feb 2019 21:08:51 -0500
Message-Id: <20190215020855.176727-73-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[ Upstream commit bb218fbcfaaa3b115d4cd7a43c0ca164f3a96e57 ]

In case of incomplete IPI with invalid interrupt type, the current
SVM driver does not properly emulate the IPI, and fails to boot
FreeBSD guests with multiple vcpus when enabling AVIC.

Fix this by update APIC ICR high/low registers, which also
emulate sending the IPI.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 101f53ccf571..cea8f8c03e8c 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4486,25 +4486,14 @@ static int avic_incomplete_ipi_interception(struct vcpu_svm *svm)
 		kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 		break;
 	case AVIC_IPI_FAILURE_TARGET_NOT_RUNNING: {
-		int i;
-		struct kvm_vcpu *vcpu;
-		struct kvm *kvm = svm->vcpu.kvm;
 		struct kvm_lapic *apic = svm->vcpu.arch.apic;
 
 		/*
-		 * At this point, we expect that the AVIC HW has already
-		 * set the appropriate IRR bits on the valid target
-		 * vcpus. So, we just need to kick the appropriate vcpu.
+		 * Update ICR high and low, then emulate sending IPI,
+		 * which is handled when writing APIC_ICR.
 		 */
-		kvm_for_each_vcpu(i, vcpu, kvm) {
-			bool m = kvm_apic_match_dest(vcpu, apic,
-						     icrl & KVM_APIC_SHORT_MASK,
-						     GET_APIC_DEST_FIELD(icrh),
-						     icrl & KVM_APIC_DEST_MASK);
-
-			if (m && !avic_vcpu_is_running(vcpu))
-				kvm_vcpu_wake_up(vcpu);
-		}
+		kvm_lapic_reg_write(apic, APIC_ICR2, icrh);
+		kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 		break;
 	}
 	case AVIC_IPI_FAILURE_INVALID_TARGET:
-- 
2.19.1

