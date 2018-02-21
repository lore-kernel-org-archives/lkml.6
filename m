Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935677AbeBURrx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:47:53 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:11223 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934959AbeBURrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:49 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="723871744"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 04/10] KVM: Introduce a new guest mapping API
Date: Wed, 21 Feb 2018 18:47:15 +0100
Message-Id: <1519235241-6500-5-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In KVM, specially for nested guests, there is a dominant pattern of:

	=> map guest memory -> do_something -> unmap guest memory

In addition to all this unnecessarily noise in the code due to boiler plate
code, most of the time the mapping function does not properly handle memory
that is not backed by "struct page". This new guest mapping API encapsulate
most of this boiler plate code and also handles guest memory that is not
backed by "struct page".

Keep in mind that memremap is horribly slow, so this mapping API should not
be used for high-frequency mapping operations. But rather for low-frequency
mappings.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 include/linux/kvm_host.h | 15 +++++++++++++++
 virt/kvm/kvm_main.c      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ac0062b..6cc2c29 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -204,6 +204,13 @@ enum {
 	READING_SHADOW_PAGE_TABLES,
 };
 
+struct kvm_host_map {
+	struct page *page;
+	void *kaddr;
+	kvm_pfn_t pfn;
+	kvm_pfn_t gfn;
+};
+
 /*
  * Sometimes a large or cross-page mmio needs to be broken up into separate
  * exits for userspace servicing.
@@ -700,6 +707,9 @@ struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
 struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+bool kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa,
+		  struct kvm_host_map *map);
+void kvm_vcpu_unmap(struct kvm_host_map *map);
 struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
@@ -996,6 +1006,11 @@ static inline struct page *kvm_vcpu_gpa_to_page(struct kvm_vcpu *vcpu,
 	return kvm_vcpu_gfn_to_page(vcpu, gpa_to_gfn(gpa));
 }
 
+static inline bool kvm_vcpu_map_valid(struct kvm_host_map *map)
+{
+	return map->kaddr != NULL;
+}
+
 static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
 {
 	unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4501e65..54e7329 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1632,6 +1632,56 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(gfn_to_page);
 
+bool kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
+{
+	kvm_pfn_t pfn;
+	void *kaddr = NULL;
+	struct page *page = NULL;
+
+	if (map->kaddr && map->gfn == gfn)
+		/* If the mapping is valid and guest memory is already mapped */
+		return true;
+	else if (map->kaddr)
+		/* If the mapping is valid but trying to map a different guest pfn */
+		kvm_vcpu_unmap(map);
+
+	pfn = kvm_vcpu_gfn_to_pfn(vcpu, gfn);
+	if (is_error_pfn(pfn))
+		return false;
+
+	if (pfn_valid(pfn)) {
+		page = pfn_to_page(pfn);
+		kaddr = vmap(&page, 1, VM_MAP, PAGE_KERNEL);
+	} else {
+		kaddr = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
+	}
+
+	if (!kaddr)
+		return false;
+
+	map->page = page;
+	map->kaddr = kaddr;
+	map->pfn = pfn;
+	map->gfn = gfn;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_kaddr);
+
+void kvm_vcpu_unmap(struct kvm_host_map *map)
+{
+	if (!map->kaddr)
+		return;
+
+	if (map->page)
+		kunmap(map->page);
+	else
+		memunmap(map->kaddr);
+
+	kvm_release_pfn_dirty(map->pfn);
+	memset(map, 0, sizeof(*map));
+}
+
 struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	kvm_pfn_t pfn;
-- 
2.7.4
