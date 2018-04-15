Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeDOVzs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:55:48 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:6149 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbeDOVzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:55:02 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="339950789"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 11/12] KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg
Date: Sun, 15 Apr 2018 23:53:17 +0200
Message-Id: <1523829198-13236-12-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_vcpu_map in synic_deliver_msg since using kvm_vcpu_gpa_to_page()
and kmap() will only work for guest memory that has a "struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Update to match the new API return codes
---
 arch/x86/kvm/hyperv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fc33d8f..668dbd3 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -580,7 +580,7 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 			     struct hv_message *src_msg)
 {
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
-	struct page *page;
+	struct kvm_host_map map;
 	gpa_t gpa;
 	struct hv_message *dst_msg;
 	int r;
@@ -590,11 +590,11 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 		return -ENOENT;
 
 	gpa = synic->msg_page & PAGE_MASK;
-	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page))
+
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), &map))
 		return -EFAULT;
 
-	msg_page = kmap_atomic(page);
+	msg_page = map.hva;
 	dst_msg = &msg_page->sint_message[sint];
 	if (sync_cmpxchg(&dst_msg->header.message_type, HVMSG_NONE,
 			 src_msg->header.message_type) != HVMSG_NONE) {
@@ -611,8 +611,8 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
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
