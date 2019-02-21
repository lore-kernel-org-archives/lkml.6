Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8830C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E142084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfBUNwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:52:17 -0500
Received: from 8bytes.org ([81.169.241.247]:40380 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUNwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:52:17 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8A0863AA; Thu, 21 Feb 2019 14:52:15 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH stable-4.4.y] KVM: VMX: Fix x2apic check in vmx_msr_bitmap_mode()
Date:   Thu, 21 Feb 2019 14:52:13 +0100
Message-Id: <20190221135213.23926-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The stable backport of upstream commit

	904e14fb7cb96 KVM: VMX: make MSR bitmaps per-VCPU

has a bug in vmx_msr_bitmap_mode(). It enables the x2apic
MSR-bitmap when the kernel emulates x2apic for the guest in
software. The upstream version of the commit checkes whether
the hardware has virtualization enabled for x2apic
emulation.

Since KVM emulates x2apic for guests even when the host does
not support x2apic in hardware, this causes the intercept of
at least the X2APIC_TASKPRI MSR to be disabled on machines
not supporting that MSR. The result is undefined behavior,
on some machines (Intel Westmere based) it causes a crash of
the guest kernel when it tries to access that MSR.

Change the check in vmx_msr_bitmap_mode() to match the upstream
code. This fixes the guest crashes observed with stable
kernels starting with v4.4.168 through v4.4.175.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kvm/vmx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index aee2886a387c..14553f6c03a6 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4628,7 +4628,9 @@ static u8 vmx_msr_bitmap_mode(struct kvm_vcpu *vcpu)
 {
 	u8 mode = 0;
 
-	if (irqchip_in_kernel(vcpu->kvm) && apic_x2apic_mode(vcpu->arch.apic)) {
+	if (cpu_has_secondary_exec_ctrls() &&
+	    (vmcs_read32(SECONDARY_VM_EXEC_CONTROL) &
+	     SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE)) {
 		mode |= MSR_BITMAP_MODE_X2APIC;
 		if (enable_apicv)
 			mode |= MSR_BITMAP_MODE_X2APIC_APICV;
-- 
2.16.3

