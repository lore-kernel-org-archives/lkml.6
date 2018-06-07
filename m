Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qNWeLRlDGVvVBAAAmS7hNA
	; Thu, 07 Jun 2018 14:37:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9C492607DC; Thu,  7 Jun 2018 14:37:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 24225601C3;
	Thu,  7 Jun 2018 14:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24225601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeFGOhM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:37:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40420 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933688AbeFGOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:36:42 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbz-0005Zw-UF; Thu, 07 Jun 2018 15:10:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002j6-D9; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Paolo Bonzini" <pbonzini@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.420496415@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 037/410] KVM: x86: rename update_db_bp_intercept to
 update_bp_intercept
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit a96036b8ef7df9f10cd575c0d78359bd33188e8e upstream.

Because #DB is now intercepted unconditionally, this callback
only operates on #BP for both VMX and SVM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[carnil: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/svm.c              | 2 +-
 arch/x86/kvm/vmx.c              | 2 +-
 arch/x86/kvm/x86.c              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -682,7 +682,7 @@ struct kvm_x86_ops {
 	void (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
 	void (*vcpu_put)(struct kvm_vcpu *vcpu);
 
-	void (*update_db_bp_intercept)(struct kvm_vcpu *vcpu);
+	void (*update_bp_intercept)(struct kvm_vcpu *vcpu);
 	int (*get_msr)(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata);
 	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr);
 	u64 (*get_segment_base)(struct kvm_vcpu *vcpu, int seg);
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4353,7 +4353,7 @@ static struct kvm_x86_ops svm_x86_ops =
 	.vcpu_load = svm_vcpu_load,
 	.vcpu_put = svm_vcpu_put,
 
-	.update_db_bp_intercept = update_bp_intercept,
+	.update_bp_intercept = update_bp_intercept,
 	.get_msr = svm_get_msr,
 	.set_msr = svm_set_msr,
 	.get_segment_base = svm_get_segment_base,
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8932,7 +8932,7 @@ static struct kvm_x86_ops vmx_x86_ops =
 	.vcpu_load = vmx_vcpu_load,
 	.vcpu_put = vmx_vcpu_put,
 
-	.update_db_bp_intercept = update_exception_bitmap,
+	.update_bp_intercept = update_exception_bitmap,
 	.get_msr = vmx_get_msr,
 	.set_msr = vmx_set_msr,
 	.get_segment_base = vmx_get_segment_base,
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6732,7 +6732,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(
 	 */
 	kvm_set_rflags(vcpu, rflags);
 
-	kvm_x86_ops->update_db_bp_intercept(vcpu);
+	kvm_x86_ops->update_bp_intercept(vcpu);
 
 	r = 0;
 
