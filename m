Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB74C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FE6214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="TYrbGiC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FE6214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLCJby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:31:54 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7528 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLCJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543829499; x=1575365499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Py5JiW69qOO5baCsZHoyyhTfGuArenzy79zuSKYdWng=;
  b=TYrbGiC4rrAcXrm4KGkpodOKZYZ5AcGUUD/b4sQKkRxE8HDitSLu7yk5
   jRKOtRewNzlhuXTFVDCpAtvsDbO4pRGBqfQvPkONQI3EEH2/HmrOJhpnT
   akZPfa1ciGVgVv+di1XqxBSOHvptEU1jzgnHTNg5c27GbwxozwQ/04PQf
   o=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="370599941"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Dec 2018 09:31:33 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wB39VTQ0098624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 3 Dec 2018 09:31:30 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wB39VSjB018131;
        Mon, 3 Dec 2018 10:31:28 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id wB39VSer018127;
        Mon, 3 Dec 2018 10:31:28 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v4 05/14] KVM: Introduce a new guest mapping API
Date:   Mon,  3 Dec 2018 10:30:58 +0100
Message-Id: <1543829467-18025-6-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
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
---
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
 include/linux/kvm_host.h |  9 +++++++++
 virt/kvm/kvm_main.c      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c926698..59e56b8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -205,6 +205,13 @@ enum {
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
@@ -708,6 +715,8 @@ struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
 struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map);
+void kvm_vcpu_unmap(struct kvm_host_map *map);
 struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2679e47..ea7c82f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1658,6 +1658,56 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
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

