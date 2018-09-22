Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE6DC46470
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079C72156E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079C72156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392207AbeIVGRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:17:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44073 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391842AbeIVGKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008Bc-OS; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000r0-Jo; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paolo Bonzini" <pbonzini@redhat.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.802137681@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 17/63] kvm: x86: use correct privilege level for
 sgdt/sidt/fxsave/fxrstor  access
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: Drop change in handle_ud()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -104,11 +104,12 @@ struct x86_emulate_ops {
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
 	 * write_std: Write bytes of standard (non-emulated/special) memory.
@@ -116,10 +117,11 @@ struct x86_emulate_ops {
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
@@ -734,14 +734,14 @@ static int linearize(struct x86_emulate_
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
@@ -755,7 +755,7 @@ static int segmented_read_std(struct x86
 	rc = linearize(ctxt, addr, size, false, &linear);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
-	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception);
+	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception, false);
 }
 
 static int segmented_write_std(struct x86_emulate_ctxt *ctxt,
@@ -769,7 +769,7 @@ static int segmented_write_std(struct x8
 	rc = linearize(ctxt, addr, size, true, &linear);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
-	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception);
+	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception, false);
 }
 
 /*
@@ -2472,12 +2472,12 @@ static bool emulator_io_port_access_allo
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
@@ -4191,10 +4191,15 @@ EXPORT_SYMBOL_GPL(kvm_read_guest_virt);
 
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
 
 static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
@@ -4229,12 +4234,17 @@ out:
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

