Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeDOVzd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:55:33 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:21598 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeDOVzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:55:03 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="735371362"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 10/12] KVM/X86: hyperv: Use kvm_vcpu_map in synic_clear_sint_msg_pending
Date: Sun, 15 Apr 2018 23:53:16 +0200
Message-Id: <1523829198-13236-11-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map in synic_clear_sint_msg_pending since using
kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Update to match the new API return codes
---
 arch/x86/kvm/hyperv.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 98618e3..fc33d8f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -158,26 +158,22 @@ static void synic_clear_sint_msg_pending(struct kvm_vcpu_hv_synic *synic,
 					u32 sint)
 {
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
-	struct page *page;
-	gpa_t gpa;
+	struct kvm_host_map map;
 	struct hv_message *msg;
 	struct hv_message_page *msg_page;
 
-	gpa = synic->msg_page & PAGE_MASK;
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page)) {
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(synic->msg_page), &map)) {
 		vcpu_err(vcpu, "Hyper-V SynIC can't get msg page, gpa 0x%llx\n",
-			 gpa);
+			 synic->msg_page);
 		return;
 	}
-	msg_page = kmap_atomic(page);
 
+	msg_page = map.hva;
 	msg = &msg_page->sint_message[sint];
 	msg->header.message_flags.msg_pending = 0;
 
-	kunmap_atomic(msg_page);
-	kvm_release_page_dirty(page);
-	kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
+	kvm_vcpu_unmap(&map);
+	kvm_vcpu_mark_page_dirty(vcpu, gpa_to_gfn(synic->msg_page));
 }
 
 static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
-- 
2.7.4
