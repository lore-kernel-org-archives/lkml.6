Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937305AbeBURsC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:48:02 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:3115 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936186AbeBURr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:56 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="596070826"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 10/10] KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg
Date: Wed, 21 Feb 2018 18:47:21 +0100
Message-Id: <1519235241-6500-11-git-send-email-karahmed@amazon.de>
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
 arch/x86/kvm/hyperv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 909b498..870fd24 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -559,7 +559,7 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 			     struct hv_message *src_msg)
 {
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
-	struct page *page;
+	struct kvm_host_map map;
 	gpa_t gpa;
 	struct hv_message *dst_msg;
 	int r;
@@ -569,11 +569,11 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 		return -ENOENT;
 
 	gpa = synic->msg_page & PAGE_MASK;
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page))
+
+	if (!kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), &map))
 		return -EFAULT;
 
-	msg_page = kmap_atomic(page);
+	msg_page = map.kaddr;
 	dst_msg = &msg_page->sint_message[sint];
 	if (sync_cmpxchg(&dst_msg->header.message_type, HVMSG_NONE,
 			 src_msg->header.message_type) != HVMSG_NONE) {
@@ -590,8 +590,8 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 		else if (r == 0)
 			r = -EFAULT;
 	}
-	kunmap_atomic(msg_page);
-	kvm_release_page_dirty(page);
+
+	kvm_vcpu_unmap(&map);
 	kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
 	return r;
 }
-- 
2.7.4
