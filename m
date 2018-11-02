Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A3C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6FB20840
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAVM+kAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6FB20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeKCDsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbeKCDs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:48:29 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479AC20837;
        Fri,  2 Nov 2018 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184017;
        bh=VrjJn/SarbwQR/adGZEFUShxB09Jiu6YeTVWgfRWbmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAVM+kAg6Y7WFBUQNRvZOX6cYdQeU04YoIO4RXrVx/ZceionlijnHUXVkpOKzkCjv
         hbtbSCiMmb/mIZ5AUaLWd0gZbhR9LBcfopHq2BD6Zv/tCLUCSUiA6VSQSajgJsCMSq
         xMUxZgWwdGyag1f/wdk0ymwEPPsu31xOTLZDMCmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 051/150] KVM: x86: Do not use kvm_x86_ops->mpx_supported() directly
Date:   Fri,  2 Nov 2018 19:33:33 +0100
Message-Id: <20181102182907.053587529@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



