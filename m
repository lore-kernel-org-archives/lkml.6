Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeDNW1T (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 18:27:19 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:34830 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeDNW1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 18:27:18 -0400
X-IronPort-AV: E=Sophos;i="5.48,451,1517875200";
   d="scan'208";a="715956314"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
Date: Sun, 15 Apr 2018 00:26:44 +0200
Message-Id: <1523744804-8220-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch 'requests' to be explicitly 64-bit and update BUILD_BUG_ON check to
use the size of "requests" instead of the hard-coded '32'.

That gives us a bit more room again for arch-specific requests as we
already ran out of space for x86 due to the hard-coded check.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 include/linux/kvm_host.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6930c63..fe4f46b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -129,7 +129,7 @@ static inline bool is_error_page(struct page *page)
 #define KVM_REQUEST_ARCH_BASE     8
 
 #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
-	BUILD_BUG_ON((unsigned)(nr) >= 32 - KVM_REQUEST_ARCH_BASE); \
+	BUILD_BUG_ON((unsigned)(nr) >= (sizeof(((struct kvm_vcpu *)0)->requests) * 8) - KVM_REQUEST_ARCH_BASE); \
 	(unsigned)(((nr) + KVM_REQUEST_ARCH_BASE) | (flags)); \
 })
 #define KVM_ARCH_REQ(nr)           KVM_ARCH_REQ_FLAGS(nr, 0)
@@ -223,7 +223,7 @@ struct kvm_vcpu {
 	int vcpu_id;
 	int srcu_idx;
 	int mode;
-	unsigned long requests;
+	u64 requests;
 	unsigned long guest_debug;
 
 	int pre_pcpu;
@@ -1122,7 +1122,7 @@ static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
 	 * caller.  Paired with the smp_mb__after_atomic in kvm_check_request.
 	 */
 	smp_wmb();
-	set_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
+	set_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
 }
 
 static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
@@ -1132,12 +1132,12 @@ static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
 
 static inline bool kvm_test_request(int req, struct kvm_vcpu *vcpu)
 {
-	return test_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
+	return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
 }
 
 static inline void kvm_clear_request(int req, struct kvm_vcpu *vcpu)
 {
-	clear_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
+	clear_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
 }
 
 static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
-- 
2.7.4
