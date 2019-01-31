Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F62C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2126B2195D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="obbPy7WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfAaU2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:28:10 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:18374 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfAaU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966424; x=1580502424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+gELcZ9qkF6w0Yk2Nn7ijwiyhntRKw4sDY5Yne2u5Ak=;
  b=obbPy7WOiUHhzVciwu16Th1E2u1K3N9bRsaLnCNpViXfGnBD3E7xO0ax
   T0volwbj1Ok6EMfaCKY6TYDd8gBUOldo35F6CwR5YxBAS0f2LwjFG1EfG
   NTTMZCuBPMtzZtv+1/+u1staSsYFqkB1N3TXmH33ad9ucN9wqawlswfgd
   U=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="379117862"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 20:27:02 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0VKQujF084950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 20:26:59 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKQoH2028902;
        Thu, 31 Jan 2019 21:26:56 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKQo4n028901;
        Thu, 31 Jan 2019 21:26:50 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 04/14] KVM: Introduce a new guest mapping API
Date:   Thu, 31 Jan 2019 21:24:34 +0100
Message-Id: <1548966284-28642-5-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In KVM, specially for nested guests, there is a dominant pattern of:

	=> map guest memory -> do_something -> unmap guest memory

In addition to all this unnecessarily noise in the code due to boiler plate
code, most of the time the mapping function does not properly handle memory
that is not backed by "struct page". This new guest mapping API encapsulate
most of this boiler plate code and also handles guest memory that is not
backed by "struct page".

The current implementation of this API is using memremap for memory that is
not backed by a "struct page" which would lead to a huge slow-down if it
was used for high-frequency mapping operations. The API does not have any
effect on current setups where guest memory is backed by a "struct page".
Further patches are going to also introduce a pfn-cache which would
significantly improve the performance of the memremap case.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

---
v5 -> v6:
- Added a helper function to check if the mapping is mapped or not.
- Added more comments on the struct.
- Setting ->page to NULL on unmap and to a poison ptr if unused during map.
- Checking for map ptr before using it.
- Change kvm_vcpu_unmap to also mark page dirty for LM. That requires
  passing the vCPU pointer again to this function.
v3 -> v4:
- Update the commit message.
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
 include/linux/kvm_host.h | 28 +++++++++++++++++++++
 virt/kvm/kvm_main.c      | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5e..15879ed 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -205,6 +205,32 @@ enum {
 	READING_SHADOW_PAGE_TABLES,
 };
 
+#define KVM_UNMAPPED_PAGE	((void *) 0x500 + POISON_POINTER_DELTA)
+
+struct kvm_host_map {
+	/*
+	 * Only valid if the 'pfn' is managed by the host kernel (i.e. There is
+	 * a 'struct page' for it. When using mem= kernel parameter some memory
+	 * can be used as guest memory but they are not managed by host
+	 * kernel).
+	 * If 'pfn' is not managed by the host kernel, this field is
+	 * initialized to KVM_UNMAPPED_PAGE.
+	 */
+	struct page *page;
+	void *hva;
+	kvm_pfn_t pfn;
+	kvm_pfn_t gfn;
+};
+
+/*
+ * Used to check if the mapping is valid or not. Never use 'kvm_host_map'
+ * directly to check for that.
+ */
+static inline bool kvm_vcpu_mapped(struct kvm_host_map *map)
+{
+	return !!map->hva;
+}
+
 /*
  * Sometimes a large or cross-page mmio needs to be broken up into separate
  * exits for userspace servicing.
@@ -710,7 +736,9 @@ struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
 struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map);
 struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn);
+void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map, bool dirty);
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
 int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data, int offset,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5ecea81..da3a8fc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1738,6 +1738,70 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(gfn_to_page);
 
+static int __kvm_map_gfn(struct kvm_memory_slot *slot, gfn_t gfn,
+			 struct kvm_host_map *map)
+{
+	kvm_pfn_t pfn;
+	void *hva = NULL;
+	struct page *page = KVM_UNMAPPED_PAGE;
+
+	if (!map)
+		return -EINVAL;
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
+void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map,
+		    bool dirty)
+{
+	if (!map)
+		return;
+
+	if (!map->hva)
+		return;
+
+	if (map->page)
+		kunmap(map->page);
+	else
+		memunmap(map->hva);
+
+	if (dirty) {
+		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
+		kvm_release_pfn_dirty(map->pfn);
+	} else {
+		kvm_release_pfn_clean(map->pfn);
+	}
+
+	map->hva = NULL;
+	map->page = NULL;
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_unmap);
+
 struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	kvm_pfn_t pfn;
-- 
2.7.4

