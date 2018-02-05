Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeBESs4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:48:56 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:15466 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753853AbeBESsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:48:01 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="706879288"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 09/12] KVM/VMX: Use the new host mapping API for cmpxchg_emulated
Date: Mon,  5 Feb 2018 19:47:28 +0100
Message-Id: <1517856451-2932-10-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/x86.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac38143..db0fd24 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4843,9 +4843,9 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 				     unsigned int bytes,
 				     struct x86_exception *exception)
 {
+	struct kvm_host_mapping mapping;
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	gpa_t gpa;
-	struct page *page;
 	char *kaddr;
 	bool exchanged;
 
@@ -4862,12 +4862,10 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	if (((gpa + bytes - 1) & PAGE_MASK) != (gpa & PAGE_MASK))
 		goto emul_write;
 
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page))
+	if (!kvm_vcpu_gpa_to_host_mapping(vcpu, gpa, &mapping, true))
 		goto emul_write;
 
-	kaddr = kmap_atomic(page);
-	kaddr += offset_in_page(gpa);
+	kaddr = mapping.kaddr + offset_in_page(gpa);
 	switch (bytes) {
 	case 1:
 		exchanged = CMPXCHG_TYPE(u8, kaddr, old, new);
@@ -4884,8 +4882,8 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	default:
 		BUG();
 	}
-	kunmap_atomic(kaddr);
-	kvm_release_page_dirty(page);
+
+	kvm_release_host_mapping(&mapping, true);
 
 	if (!exchanged)
 		return X86EMUL_CMPXCHG_FAILED;
-- 
2.7.4
