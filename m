Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbeBESvo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:51:44 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23891 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753636AbeBESr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:47:58 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="330725241"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 01/12] KVM: Introduce helper functions to map/unmap guest memory
Date: Mon,  5 Feb 2018 19:47:20 +0100
Message-Id: <1517856451-2932-2-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce helper functions to map and unmap guest memory into host kernel
memory. These helper functions support mapping guest memory both that are
managed by the host kernel (i.e. have a "struct page") and the ones that
are not managed by the kernel (i.e. does not have a "struct page").

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 include/linux/kvm_host.h | 18 ++++++++++++++
 virt/kvm/kvm_main.c      | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6bdd4b9..45d2854 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -204,6 +204,12 @@ enum {
 	READING_SHADOW_PAGE_TABLES,
 };
 
+struct kvm_host_mapping {
+	struct page *page;
+	void *kaddr;
+	kvm_pfn_t pfn;
+};
+
 /*
  * Sometimes a large or cross-page mmio needs to be broken up into separate
  * exits for userspace servicing.
@@ -700,6 +706,10 @@ struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
 struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+bool kvm_vcpu_gfn_to_host_mapping(struct kvm_vcpu *vcpu, gfn_t gfn,
+				  struct kvm_host_mapping *mapping,
+				  bool kernel_access);
+void kvm_release_host_mapping(struct kvm_host_mapping *mapping, bool dirty);
 struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
@@ -990,6 +1000,14 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
 	return (hpa_t)pfn << PAGE_SHIFT;
 }
 
+static inline bool kvm_vcpu_gpa_to_host_mapping(struct kvm_vcpu *vcpu, gpa_t gpa,
+						struct kvm_host_mapping *mapping,
+						bool kernel_access)
+{
+	return kvm_vcpu_gfn_to_host_mapping(vcpu, gpa_to_gfn(gpa), mapping,
+					    kernel_access);
+}
+
 static inline struct page *kvm_vcpu_gpa_to_page(struct kvm_vcpu *vcpu,
 						gpa_t gpa)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 210bf82..2b9f93d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1653,6 +1653,68 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(gfn_to_page);
 
+bool kvm_vcpu_gfn_to_host_mapping(struct kvm_vcpu *vcpu, gfn_t gfn,
+				  struct kvm_host_mapping *mapping,
+				  bool kernel_access)
+{
+	void *kaddr = NULL;
+	kvm_pfn_t pfn;
+	struct page *page = NULL;
+
+	pfn = kvm_vcpu_gfn_to_pfn(vcpu, gfn);
+
+	if (pfn_valid(pfn)) {
+		page = kvm_pfn_to_page(pfn);
+		if (is_error_page(page))
+			return false;
+
+		if (kernel_access) {
+			kaddr = kmap(page);
+			if (!kaddr)
+				return false;
+		}
+
+		mapping->kaddr = kaddr;
+		mapping->page = page;
+		mapping->pfn = pfn;
+		return true;
+	}
+
+	kaddr = memremap(pfn << PAGE_SHIFT, PAGE_SIZE, MEMREMAP_WB);
+	if (!kaddr)
+		return false;
+
+	mapping->page = NULL;
+	mapping->kaddr = kaddr;
+	mapping->pfn = pfn;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_kaddr);
+
+void kvm_release_host_mapping(struct kvm_host_mapping *mapping, bool dirty)
+{
+	if (mapping->page) {
+		if (mapping->kaddr)
+			kunmap(mapping->page);
+
+		if (dirty)
+			kvm_release_page_dirty(mapping->page);
+		else
+			kvm_release_page_clean(mapping->page);
+	} else {
+		if (mapping->kaddr)
+			memunmap(mapping->kaddr);
+
+		if (dirty)
+			kvm_release_pfn_dirty(mapping->pfn);
+		else
+			kvm_release_pfn_clean(mapping->pfn);
+	}
+
+	memset(mapping, 0, sizeof(*mapping));
+}
+
 struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	kvm_pfn_t pfn;
-- 
2.7.4
