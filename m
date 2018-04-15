Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDOV4T (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:56:19 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:7225 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbeDOVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:55:01 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="726275413"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 05/12] KVM: Introduce a new guest mapping API
Date: Sun, 15 Apr 2018 23:53:11 +0200
Message-Id: <1523829198-13236-6-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
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
v1 -> v2:
- Drop the caching optimization (pbonzini)
- Use 'hva' instead of 'kaddr' (pbonzini)
- Return 0/-EINVAL/-EFAULT instead of true/false. -EFAULT will be used for
  AMD patch (pbonzini)
- Introduce __kvm_map_gfn which accepts a memory slot and use it (pbonzini)
- Only clear map->hva instead of memsetting the whole structure.
- Drop kvm_vcpu_map_valid since it is no longer used.
- Fix EXPORT_MODULE naming.
---
 include/linux/kvm_host.h |  9 +++++++++
 virt/kvm/kvm_main.c      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fe4f46b..15b9244 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -204,6 +204,13 @@ enum {
 	READING_SHADOW_PAGE_TABLES,
 };
 
+struct kvm_host_map {
+	struct page *page;
+	void *hva;
+	kvm_pfn_t pfn;
+	kvm_pfn_t gfn;
+};
+
 /*
  * Sometimes a large or cross-page mmio needs to be broken up into separate
  * exits for userspace servicing.
@@ -700,6 +707,8 @@ struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
 struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map);
+void kvm_vcpu_unmap(struct kvm_host_map *map);
 struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c7b2e92..70c3e56 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1631,6 +1631,56 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(gfn_to_page);
 
+static int __kvm_map_gfn(struct kvm_memory_slot *slot, gfn_t gfn,
+			 struct kvm_host_map *map)
+{
+	kvm_pfn_t pfn;
+	void *hva = NULL;
+	struct page *page = NULL;
+
+	pfn = gfn_to_pfn_memslot(slot, gfn);
+	if (is_error_noslot_pfn(pfn))
+		return -EINVAL;
+
+	if (pfn_valid(pfn)) {
+		page = pfn_to_page(pfn);
+		hva = kmap(page);
+	} else {
+		hva = memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
+	}
+
+	if (!hva)
+		return -EFAULT;
+
+	map->page = page;
+	map->hva = hva;
+	map->pfn = pfn;
+	map->gfn = gfn;
+
+	return 0;
+}
+
+int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
+{
+	return __kvm_map_gfn(kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn, map);
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_map);
+
+void kvm_vcpu_unmap(struct kvm_host_map *map)
+{
+	if (!map->hva)
+		return;
+
+	if (map->page)
+		kunmap(map->page);
+	else
+		memunmap(map->hva);
+
+	kvm_release_pfn_dirty(map->pfn);
+	map->hva = NULL;
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_unmap);
+
 struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	kvm_pfn_t pfn;
-- 
2.7.4
