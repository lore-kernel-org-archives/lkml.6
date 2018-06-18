Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82D9C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6417720864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6417720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965852AbeFRIZj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:25:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56576 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965354AbeFRIZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:25:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 85CE7C9E;
        Mon, 18 Jun 2018 08:25:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marian Rotariu <mrotariu@bitdefender.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 221/279] x86: Delay skip of emulated hypercall instruction
Date:   Mon, 18 Jun 2018 10:13:26 +0200
Message-Id: <20180618080617.988782810@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
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

From: Marian Rotariu <mrotariu@bitdefender.com>

[ Upstream commit 6356ee0c9602004e0a3b4b2dad68ee2ee9385b17 ]

The IP increment should be done after the hypercall emulation, after
calling the various handlers. In this way, these handlers can accurately
identify the the IP of the VMCALL if they need it.

This patch keeps the same functionality for the Hyper-V handler which does
not use the return code of the standard kvm_skip_emulated_instruction()
call.

Signed-off-by: Marian Rotariu <mrotariu@bitdefender.com>
[Hyper-V hypercalls also need kvm_skip_emulated_instruction() - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/hyperv.c |    2 +-
 arch/x86/kvm/x86.c    |   19 +++++++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1223,7 +1223,7 @@ static int kvm_hv_hypercall_complete_use
 	struct kvm_run *run = vcpu->run;
 
 	kvm_hv_hypercall_set_result(vcpu, run->hyperv.u.hcall.result);
-	return 1;
+	return kvm_skip_emulated_instruction(vcpu);
 }
 
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6553,12 +6553,13 @@ void kvm_vcpu_deactivate_apicv(struct kv
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
 	unsigned long nr, a0, a1, a2, a3, ret;
-	int op_64_bit, r;
+	int op_64_bit;
 
-	r = kvm_skip_emulated_instruction(vcpu);
-
-	if (kvm_hv_hypercall_enabled(vcpu->kvm))
-		return kvm_hv_hypercall(vcpu);
+	if (kvm_hv_hypercall_enabled(vcpu->kvm)) {
+		if (!kvm_hv_hypercall(vcpu))
+			return 0;
+		goto out;
+	}
 
 	nr = kvm_register_read(vcpu, VCPU_REGS_RAX);
 	a0 = kvm_register_read(vcpu, VCPU_REGS_RBX);
@@ -6579,7 +6580,7 @@ int kvm_emulate_hypercall(struct kvm_vcp
 
 	if (kvm_x86_ops->get_cpl(vcpu) != 0) {
 		ret = -KVM_EPERM;
-		goto out;
+		goto out_error;
 	}
 
 	switch (nr) {
@@ -6599,12 +6600,14 @@ int kvm_emulate_hypercall(struct kvm_vcp
 		ret = -KVM_ENOSYS;
 		break;
 	}
-out:
+out_error:
 	if (!op_64_bit)
 		ret = (u32)ret;
 	kvm_register_write(vcpu, VCPU_REGS_RAX, ret);
+
+out:
 	++vcpu->stat.hypercalls;
-	return r;
+	return kvm_skip_emulated_instruction(vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_hypercall);
 


