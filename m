Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD897C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3D720869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3D720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJPPEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:04:04 -0400
Received: from mo-csw-fb1515.securemx.jp ([210.130.202.171]:40568 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeJPPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:04:04 -0400
X-Greylist: delayed 835 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2018 11:04:02 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id w9G7186p008628; Tue, 16 Oct 2018 16:01:08 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id w9G70pSg001416; Tue, 16 Oct 2018 16:00:51 +0900
X-Iguazu-Qid: 34tKsREiUECuMlXfoO
X-Iguazu-QSIG: v=1; s=0; t=1539673251; q=34tKsREiUECuMlXfoO; m=IvjZkqsTQUWYq6WR52o9jwzEA6UrFDkAF9FR4ZkrGGM=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id w9G70nRw027045;
        Tue, 16 Oct 2018 16:00:49 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w9G70nuj029415;
        Tue, 16 Oct 2018 16:00:49 +0900 (JST)
From:   Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4.4 1/4] KVM: x86: remove eager_fpu field of struct kvm_vcpu_arch
Date:   Tue, 16 Oct 2018 16:00:00 +0900
X-TSB-HOP: ON
Message-Id: <1539673203-21068-2-git-send-email-daniel.sangorrin@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539673203-21068-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1539673203-21068-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 5a5fbdc0e3f1159a734f1890da60fce70e98271d upstream.

It is now equal to use_eager_fpu(), which simply tests a cpufeature bit.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/cpuid.c            | 3 +--
 arch/x86/kvm/x86.c              | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 74fda1a..3a37cdb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,7 +439,6 @@ struct kvm_vcpu_arch {
 	struct kvm_mmu_memory_cache mmu_page_header_cache;
 
 	struct fpu guest_fpu;
-	bool eager_fpu;
 	u64 xcr0;
 	u64 guest_supported_xcr0;
 	u32 guest_xstate_size;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 83d6369..7b4ea5e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -104,8 +104,7 @@ int kvm_update_cpuid(struct kvm_vcpu *vcpu)
 	if (best && (best->eax & (F(XSAVES) | F(XSAVEC))))
 		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
 
-	vcpu->arch.eager_fpu = use_eager_fpu();
-	if (vcpu->arch.eager_fpu)
+	if (use_eager_fpu())
 		kvm_x86_ops->fpu_activate(vcpu);
 
 	/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 53d43d2..660d8a0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7325,7 +7325,7 @@ void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 	 * Every 255 times fpu_counter rolls over to 0; a guest that uses
 	 * the FPU in bursts will revert to loading it on demand.
 	 */
-	if (!vcpu->arch.eager_fpu) {
+	if (!use_eager_fpu()) {
 		if (++vcpu->fpu_counter < 5)
 			kvm_make_request(KVM_REQ_DEACTIVATE_FPU, vcpu);
 	}
-- 
2.7.4

