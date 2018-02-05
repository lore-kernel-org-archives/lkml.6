Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeBEStc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:49:32 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14405 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753898AbeBEStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:49:05 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="718190670"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 10/12] KVM/VMX: Use the new host mapping API for synic_clear_sint_msg_pending
Date: Mon,  5 Feb 2018 19:47:29 +0100
Message-Id: <1517856451-2932-11-git-send-email-karahmed@amazon.de>
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
index dc97f25..408428a 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -137,25 +137,25 @@ static void synic_clear_sint_msg_pending(struct kvm_vcpu_hv_synic *synic,
 					u32 sint)
 {
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
-	struct page *page;
+	struct kvm_host_mapping mapping;
 	gpa_t gpa;
 	struct hv_message *msg;
 	struct hv_message_page *msg_page;
 
 	gpa = synic->msg_page & PAGE_MASK;
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page)) {
+
+
+	if (!kvm_vcpu_gpa_to_host_mapping(vcpu, gpa, &mapping, true)) {
 		vcpu_err(vcpu, "Hyper-V SynIC can't get msg page, gpa 0x%llx\n",
 			 gpa);
 		return;
 	}
-	msg_page = kmap_atomic(page);
+	msg_page = mapping.kaddr;
 
 	msg = &msg_page->sint_message[sint];
 	msg->header.message_flags.msg_pending = 0;
 
-	kunmap_atomic(msg_page);
-	kvm_release_page_dirty(page);
+	kvm_release_host_mapping(&mapping, true);
 	kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
 }
 
-- 
2.7.4
