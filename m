Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA74BC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C4921479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m24lJqCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C4921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeJPMBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeJPMBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A2C21479;
        Tue, 16 Oct 2018 04:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663194;
        bh=CmvijBzPuy3Kdszmf/Ic5Tj4uG+63Y2U5oBLevoBp5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m24lJqCVXQtPUzuJxeJBVIoZLmtgc+KKxcJ/2/Ca9hUWkgvzG6sbd+oaYkXNFu7Fm
         PWEnpq3e5Azyky+NhGc37W5ZC5g6XLuvbQHO1SBs3NY8lmJ6jK0YplcU4jyHOazVDT
         lrtXd/Z5d85ssyojdy51DUas+FxAQa5lCMbNXz8U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 058/100] KVM: x86: Do not use kvm_x86_ops->mpx_supported() directly
Date:   Tue, 16 Oct 2018 00:11:39 -0400
Message-Id: <20181016041221.135528-58-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liran Alon <liran.alon@oracle.com>

[ Upstream commit 503234b3fdcaa578395c07e393ea3e5d13958824 ]

Commit a87036add092 ("KVM: x86: disable MPX if host did not enable
MPX XSAVE features") introduced kvm_mpx_supported() to return true
iff MPX is enabled in the host.

However, that commit seems to have missed replacing some calls to
kvm_x86_ops->mpx_supported() to kvm_mpx_supported().

Complete original commit by replacing remaining calls to
kvm_mpx_supported().

Fixes: a87036add092 ("KVM: x86: disable MPX if host did not enable
MPX XSAVE features")

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 2 +-
 arch/x86/kvm/x86.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ea691ddfc3aa..2e23fce5eb1f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11567,7 +11567,7 @@ static void prepare_vmcs02_full(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 
 	set_cr4_guest_host_mask(vmx);
 
-	if (vmx_mpx_supported())
+	if (kvm_mpx_supported())
 		vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
 
 	if (enable_vpid) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 97fcac34e007..3cd58a5eb449 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4625,7 +4625,7 @@ static void kvm_init_msr_list(void)
 		 */
 		switch (msrs_to_save[i]) {
 		case MSR_IA32_BNDCFGS:
-			if (!kvm_x86_ops->mpx_supported())
+			if (!kvm_mpx_supported())
 				continue;
 			break;
 		case MSR_TSC_AUX:
-- 
2.17.1

