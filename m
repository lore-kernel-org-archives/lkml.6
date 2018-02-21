Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938246AbeBURxs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:53:48 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:2404 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935007AbeBURrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:48 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="667841891"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 08/10] KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
Date: Wed, 21 Feb 2018 18:47:19 +0100
Message-Id: <1519235241-6500-9-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... since using kvm_vcpu_gpa_to_page() and kmap() will only work for guest
memory that has a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/x86.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 37f5df9..197a395 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5013,9 +5013,9 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 				     unsigned int bytes,
 				     struct x86_exception *exception)
 {
+	struct kvm_host_map map;
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	gpa_t gpa;
-	struct page *page;
 	char *kaddr;
 	bool exchanged;
 
@@ -5032,12 +5032,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	if (((gpa + bytes - 1) & PAGE_MASK) != (gpa & PAGE_MASK))
 		goto emul_write;
 
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page))
+	if (!kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), &map))
 		goto emul_write;
 
-	kaddr = kmap_atomic(page);
-	kaddr += offset_in_page(gpa);
+	kaddr = map.kaddr + offset_in_page(gpa);
+
 	switch (bytes) {
 	case 1:
 		exchanged = CMPXCHG_TYPE(u8, kaddr, old, new);
@@ -5054,8 +5053,8 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	default:
 		BUG();
 	}
-	kunmap_atomic(kaddr);
-	kvm_release_page_dirty(page);
+
+	kvm_vcpu_unmap(&map);
 
 	if (!exchanged)
 		return X86EMUL_CMPXCHG_FAILED;
-- 
2.7.4
