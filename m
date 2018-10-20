Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E8DC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D514E21712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="dXpvTDXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D514E21712
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJUGgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:36:44 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57222 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeJUGew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540074174; x=1571610174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=eiLXFeLGfkVvPF3se8LKAX+oivBR0a7kYpa/IzmeHx4=;
  b=dXpvTDXOHZoOTlDZYmrwNhpzhhTs8pyu3yLno1P0twsu++Z7XFowGCib
   WWBUntT39kyMjHswoJloNC5zjNlCHmjDKPlaVQ0E5fQmFIjCVUDSAHHxf
   vwZmj8mA2spSpSxVJHnAJLGnrOTBTCkgRpNKrL9TMx1rAbiqYQ7x8Q4D7
   o=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="637420944"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:22:52 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMMndW126566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:22:50 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMMmXV031607;
        Sun, 21 Oct 2018 00:22:48 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMMlf3031606;
        Sun, 21 Oct 2018 00:22:47 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 05/13] KVM: Introduce a new guest mapping API
Date:   Sun, 21 Oct 2018 00:22:17 +0200
Message-Id: <1540074145-31285-6-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
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
index 94e931f..a79a3c4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1652,6 +1652,56 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
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

