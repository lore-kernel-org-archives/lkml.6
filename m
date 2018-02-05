Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbeBESsc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:48:32 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:15450 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeBESsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:48:05 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="706879299"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 11/12] KVM/VMX: Use the new host mapping API for synic_deliver_msg
Date: Mon,  5 Feb 2018 19:47:30 +0100
Message-Id: <1517856451-2932-12-git-send-email-karahmed@amazon.de>
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
 arch/x86/kvm/hyperv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 408428a..be6ce0e 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -563,7 +563,7 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 			     struct hv_message *src_msg)
 {
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
-	struct page *page;
+	struct kvm_host_mapping mapping;
 	gpa_t gpa;
 	struct hv_message *dst_msg;
 	int r;
@@ -573,11 +573,11 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 		return -ENOENT;
 
 	gpa = synic->msg_page & PAGE_MASK;
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page))
+
+	if (!kvm_vcpu_gpa_to_host_mapping(vcpu, gpa, &mapping, true))
 		return -EFAULT;
 
-	msg_page = kmap_atomic(page);
+	msg_page = mapping.kaddr;
 	dst_msg = &msg_page->sint_message[sint];
 	if (sync_cmpxchg(&dst_msg->header.message_type, HVMSG_NONE,
 			 src_msg->header.message_type) != HVMSG_NONE) {
@@ -594,8 +594,8 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 		else if (r == 0)
 			r = -EFAULT;
 	}
-	kunmap_atomic(msg_page);
-	kvm_release_page_dirty(page);
+
+	kvm_release_host_mapping(&mapping, true);
 	kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
 	return r;
 }
-- 
2.7.4
