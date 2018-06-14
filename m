Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 26CBAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13BF208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ska18klf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13BF208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965414AbeFNOmY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965333AbeFNOIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:08:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA48F208DD;
        Thu, 14 Jun 2018 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985332;
        bh=5NsNiGGmyUHwgnTp2sX0XcSQ3WOe2/4C5ZrDMmiGeaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ska18klfq8V9Wpet9Z/uQMwT9fOCJbZECubXcWlcR5qsFjIAhnbqpunO6aQ+Rq33T
         W8hyI6EptKvtNOMs9x+ILSDvUrrdnpgZsZm/lP9SsivjLOqBjzVfeavTZ2FRoNkwwU
         h03Gnxj+HeiIOzpJ2xXuMQqPiNRZTigLYgpquokQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Wilhelm <fwilhelm@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.16 07/43] kvm: nVMX: Enforce cpl=0 for VMX instructions
Date:   Thu, 14 Jun 2018 16:04:11 +0200
Message-Id: <20180614132135.424847630@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132135.111973468@linuxfoundation.org>
References: <20180614132135.111973468@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Wilhelm <fwilhelm@google.com>

commit 727ba748e110b4de50d142edca9d6a9b7e6111d8 upstream.

VMX instructions executed inside a L1 VM will always trigger a VM exit
even when executed with cpl 3. This means we must perform the
privilege check in software.

Fixes: 70f3aac964ae("kvm: nVMX: Remove superfluous VMX instruction fault checks")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Wilhelm <fwilhelm@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7426,6 +7426,12 @@ static int handle_vmon(struct kvm_vcpu *
 		return 1;
 	}
 
+	/* CPL=0 must be checked manually. */
+	if (vmx_get_cpl(vcpu)) {
+		kvm_queue_exception(vcpu, UD_VECTOR);
+		return 1;
+	}
+
 	if (vmx->nested.vmxon) {
 		nested_vmx_failValid(vcpu, VMXERR_VMXON_IN_VMX_ROOT_OPERATION);
 		return kvm_skip_emulated_instruction(vcpu);
@@ -7485,6 +7491,11 @@ static int handle_vmon(struct kvm_vcpu *
  */
 static int nested_vmx_check_permission(struct kvm_vcpu *vcpu)
 {
+	if (vmx_get_cpl(vcpu)) {
+		kvm_queue_exception(vcpu, UD_VECTOR);
+		return 0;
+	}
+
 	if (!to_vmx(vcpu)->nested.vmxon) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 0;
@@ -7785,7 +7796,7 @@ static int handle_vmread(struct kvm_vcpu
 		if (get_vmx_mem_address(vcpu, exit_qualification,
 				vmx_instruction_info, true, &gva))
 			return 1;
-		/* _system ok, as hardware has verified cpl=0 */
+		/* _system ok, nested_vmx_check_permission has verified cpl=0 */
 		kvm_write_guest_virt_system(&vcpu->arch.emulate_ctxt, gva,
 			     &field_value, (is_long_mode(vcpu) ? 8 : 4), NULL);
 	}
@@ -7945,7 +7956,7 @@ static int handle_vmptrst(struct kvm_vcp
 	if (get_vmx_mem_address(vcpu, exit_qualification,
 			vmx_instruction_info, true, &vmcs_gva))
 		return 1;
-	/* ok to use *_system, as hardware has verified cpl=0 */
+	/* *_system ok, nested_vmx_check_permission has verified cpl=0 */
 	if (kvm_write_guest_virt_system(&vcpu->arch.emulate_ctxt, vmcs_gva,
 				 (void *)&to_vmx(vcpu)->nested.current_vmptr,
 				 sizeof(u64), &e)) {


