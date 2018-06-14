Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EDBB0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A89A208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMqoSvJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A89A208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965592AbeFNOi0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965437AbeFNOJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:09:20 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66F8208E0;
        Thu, 14 Jun 2018 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985360;
        bh=BOu1raKUENULOkGzJkG9RF7m3/6m3iDeZ4R39s0Aojo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMqoSvJu7TesVC5b/SrLb8qlZjGzWBUIfcCOFpvcbzZioGXahhqyXYm0V0Kco5+80
         jzOhEtGprM1G/KjHlK8cUTW0RF/chMSrb4EBbj7NA/DwqYWMJUczTRn0uFqJNk0phk
         Q4B46AfufNRZbhDFOLlqv8185TjU0Fqt0UXcCyAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.16 31/43] kvm: x86: use correct privilege level for sgdt/sidt/fxsave/fxrstor access
Date:   Thu, 14 Jun 2018 16:04:35 +0200
Message-Id: <20180614132137.429647903@linuxfoundation.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

commit 3c9fa24ca7c9c47605672916491f79e8ccacb9e6 upstream.

The functions that were used in the emulation of fxrstor, fxsave, sgdt and
sidt were originally meant for task switching, and as such they did not
check privilege levels.  This is very bad when the same functions are used
in the emulation of unprivileged instructions.  This is CVE-2018-10853.

The obvious fix is to add a new argument to ops->read_std and ops->write_std,
which decides whether the access is a "system" access or should use the
processor's CPL.

Fixes: 129a72a0d3c8 ("KVM: x86: Introduce segmented_write_std", 2017-01-12)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_emulate.h |    6 ++++--
 arch/x86/kvm/emulate.c             |   12 ++++++------
 arch/x86/kvm/x86.c                 |   18 ++++++++++++++----
 3 files changed, 24 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -107,11 +107,12 @@ struct x86_emulate_ops {
 	 *  @addr:  [IN ] Linear address from which to read.
 	 *  @val:   [OUT] Value read from memory, zero-extended to 'u_long'.
 	 *  @bytes: [IN ] Number of bytes to read from memory.
+	 *  @system:[IN ] Whether the access is forced to be at CPL0.
 	 */
 	int (*read_std)(struct x86_emulate_ctxt *ctxt,
 			unsigned long addr, void *val,
 			unsigned int bytes,
-			struct x86_exception *fault);
+			struct x86_exception *fault, bool system);
 
 	/*
 	 * read_phys: Read bytes of standard (non-emulated/special) memory.
@@ -129,10 +130,11 @@ struct x86_emulate_ops {
 	 *  @addr:  [IN ] Linear address to which to write.
 	 *  @val:   [OUT] Value write to memory, zero-extended to 'u_long'.
 	 *  @bytes: [IN ] Number of bytes to write to memory.
+	 *  @system:[IN ] Whether the access is forced to be at CPL0.
 	 */
 	int (*write_std)(struct x86_emulate_ctxt *ctxt,
 			 unsigned long addr, void *val, unsigned int bytes,
-			 struct x86_exception *fault);
+			 struct x86_exception *fault, bool system);
 	/*
 	 * fetch: Read bytes of standard (non-emulated/special) memory.
 	 *        Used for instruction fetch.
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -814,14 +814,14 @@ static inline int jmp_rel(struct x86_emu
 static int linear_read_system(struct x86_emulate_ctxt *ctxt, ulong linear,
 			      void *data, unsigned size)
 {
-	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception);
+	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception, true);
 }
 
 static int linear_write_system(struct x86_emulate_ctxt *ctxt,
 			       ulong linear, void *data,
 			       unsigned int size)
 {
-	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception);
+	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception, true);
 }
 
 static int segmented_read_std(struct x86_emulate_ctxt *ctxt,
@@ -835,7 +835,7 @@ static int segmented_read_std(struct x86
 	rc = linearize(ctxt, addr, size, false, &linear);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
-	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception);
+	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception, false);
 }
 
 static int segmented_write_std(struct x86_emulate_ctxt *ctxt,
@@ -849,7 +849,7 @@ static int segmented_write_std(struct x8
 	rc = linearize(ctxt, addr, size, true, &linear);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
-	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception);
+	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception, false);
 }
 
 /*
@@ -2916,12 +2916,12 @@ static bool emulator_io_port_access_allo
 #ifdef CONFIG_X86_64
 	base |= ((u64)base3) << 32;
 #endif
-	r = ops->read_std(ctxt, base + 102, &io_bitmap_ptr, 2, NULL);
+	r = ops->read_std(ctxt, base + 102, &io_bitmap_ptr, 2, NULL, true);
 	if (r != X86EMUL_CONTINUE)
 		return false;
 	if (io_bitmap_ptr + port/8 > desc_limit_scaled(&tr_seg))
 		return false;
-	r = ops->read_std(ctxt, base + io_bitmap_ptr + port/8, &perm, 2, NULL);
+	r = ops->read_std(ctxt, base + io_bitmap_ptr + port/8, &perm, 2, NULL, true);
 	if (r != X86EMUL_CONTINUE)
 		return false;
 	if ((perm >> bit_idx) & mask)
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4716,10 +4716,15 @@ EXPORT_SYMBOL_GPL(kvm_read_guest_virt);
 
 static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
 			     gva_t addr, void *val, unsigned int bytes,
-			     struct x86_exception *exception)
+			     struct x86_exception *exception, bool system)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, 0, exception);
+	u32 access = 0;
+
+	if (!system && kvm_x86_ops->get_cpl(vcpu) == 3)
+		access |= PFERR_USER_MASK;
+
+	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access, exception);
 }
 
 static int kvm_read_guest_phys_system(struct x86_emulate_ctxt *ctxt,
@@ -4763,12 +4768,17 @@ out:
 }
 
 static int emulator_write_std(struct x86_emulate_ctxt *ctxt, gva_t addr, void *val,
-			      unsigned int bytes, struct x86_exception *exception)
+			      unsigned int bytes, struct x86_exception *exception,
+			      bool system)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	u32 access = PFERR_WRITE_MASK;
+
+	if (!system && kvm_x86_ops->get_cpl(vcpu) == 3)
+		access |= PFERR_USER_MASK;
 
 	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
-					   PFERR_WRITE_MASK, exception);
+					   access, exception);
 }
 
 int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu, gva_t addr, void *val,


