Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C842C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3C42084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="xt1IaSpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfAUJOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:14:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37881 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAUJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:14:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so22379548wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ba3tDASNTotjNQKnGm55/6Aw1NBRDm2GVVzFiCk5Tjc=;
        b=xt1IaSpMNL7ziYvM+rZnBGX/PKTiPlj5tS9UtgSyiPJn92VBAFynaLivIruQFoWrCb
         LWwmR1ZBO4JmpORKmpVZMKLjGdeji5S4uPPgk/3NMH/2MRqC/jA7/CI6b0fUhpdTkHfJ
         V5my0sqbH76wXLJ5UwMA8Uxu1T/CddVtzUkb/HNFRtxIwdOgLeYRDOcPntoayD4/9vgn
         VLkI1KDpyRjLH7DfuaWSnV/UHNEm9SG4NRSDK+ctqa/B0J5XaZtSW7FPOPc7vqvGrbzt
         IadnMIC/hexahdFXpeqoIqD3dhm2k/Ax8jV8mj26WBPQ+KgBU/Szwfkjkp+fYwqJRBOP
         3EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ba3tDASNTotjNQKnGm55/6Aw1NBRDm2GVVzFiCk5Tjc=;
        b=qDGjd3tHcHC9YkA19OVfwH7PnM2AFKUUCz6GuZyNYR3P7gndEaK4QkTLOMgsx2hQGw
         7/vQI91WUYy4187sCEtajzLf9U5JzvV2L2ZmAuKw56fygyWy0cWO59M6m3UqOivSWby6
         rQ1g5EdIrAgFJyqhuGhj2PlVHWGDCxD5fRDggitlyGvRLaicMZ9OUSsksfu0aZpTDib4
         8kkgU7tHNyP1I5i1n2xtdPdZ1aEigulMXgzoKXfW6TYuEEM/XVfUoKJGGS+RAzWkgOYC
         YObpAEuXKho2QZ3dbgOX3mxE+fTlMO/xi2l3hxxPrTJBIGb24JDDet2hKhysGQbu1yUZ
         QRrQ==
X-Gm-Message-State: AJcUukcwCakVKgTb5xdVCD5dOA+qDH9PRO0+YRTerGN7jPfTQ8aKJlWZ
        3BI5g907HavfD/tzHP26wIO+nBTCKbk=
X-Google-Smtp-Source: ALg8bN7ul2pdzsg6zMf4tyvqYVChZ72Zkyxhd1WnH7clqi7jYMFuxYuMyxLoCiPtpUytkSGt+Q8+Aw==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr26249203wrr.162.1548027680378;
        Sun, 20 Jan 2019 15:41:20 -0800 (PST)
Received: from localhost.localdomain ([156.212.82.83])
        by smtp.gmail.com with ESMTPSA id e9sm76576753wro.16.2019.01.20.15.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 15:41:19 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [RESEND PATCH V8 05/11] KVM: Create architecture independent ROE skeleton
Date:   Mon, 21 Jan 2019 01:39:34 +0200
Message-Id: <20190120233940.15282-6-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190120233940.15282-1-ahmedsoliman@mena.vt.edu>
References: <20190120233940.15282-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a hypercall that can assist against subset of kernel
rootkits, it works by place readonly protection in shadow PTE. The end
result protection is also kept in a bitmap for each kvm_memory_slot and is
used as reference when updating SPTEs. The whole goal is to protect the
guest kernel static data from modification if attacker is running from
guest ring 0, for this reason there is no hypercall to revert effect of
Memory ROE hypercall. This patch doesn't implement integrity check on guest
TLB so obvious attack on the current implementation will involve guest
virtual address -> guest physical address remapping, but there are plans to
fix that. For this patch to work on a given arch/ one would need to
implement 2 function that are architecture specific:
kvm_roe_arch_commit_protection() and kvm_roe_arch_is_userspace(). Also it
would need to have kvm_roe invoked using the appropriate hypercall
mechanism.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 include/kvm/roe.h             |  16 ++++
 include/linux/kvm_host.h      |   1 +
 include/uapi/linux/kvm_para.h |   4 +
 virt/kvm/kvm_main.c           |  19 +++--
 virt/kvm/roe.c                | 136 ++++++++++++++++++++++++++++++++++
 virt/kvm/roe_generic.h        |  19 +++++
 6 files changed, 190 insertions(+), 5 deletions(-)
 create mode 100644 include/kvm/roe.h
 create mode 100644 virt/kvm/roe.c
 create mode 100644 virt/kvm/roe_generic.h

diff --git a/include/kvm/roe.h b/include/kvm/roe.h
new file mode 100644
index 0000000000..6a86866623
--- /dev/null
+++ b/include/kvm/roe.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __KVM_ROE_H__
+#define __KVM_ROE_H__
+/*
+ * KVM Read Only Enforcement
+ * Copyright (c) 2018 Ahmed Abd El Mawgood
+ *
+ * Author Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
+ *
+ */
+void kvm_roe_arch_commit_protection(struct kvm *kvm,
+		struct kvm_memory_slot *slot);
+int kvm_roe(struct kvm_vcpu *vcpu, u64 a0, u64 a1, u64 a2, u64 a3);
+bool kvm_roe_arch_is_userspace(struct kvm_vcpu *vcpu);
+#endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5eb7e..a627c6e81a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -297,6 +297,7 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 struct kvm_memory_slot {
 	gfn_t base_gfn;
 	unsigned long npages;
+	unsigned long *roe_bitmap;
 	unsigned long *dirty_bitmap;
 	struct kvm_arch_memory_slot arch;
 	unsigned long userspace_addr;
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index 6c0ce49931..e6004e0750 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -28,7 +28,11 @@
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 #define KVM_HC_CLOCK_PAIRING		9
 #define KVM_HC_SEND_IPI		10
+#define KVM_HC_ROE			11
 
+/* ROE Functionality parameters */
+#define ROE_VERSION			0
+#define ROE_MPROTECT			1
 /*
  * hypercalls use architecture specific
  */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2f37b4b6a2..88b5fbcbb0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -61,6 +61,7 @@
 #include "coalesced_mmio.h"
 #include "async_pf.h"
 #include "vfio.h"
+#include "roe_generic.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/kvm.h>
@@ -551,9 +552,10 @@ static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			      struct kvm_memory_slot *dont,
 			      enum kvm_mr_change change)
 {
-	if (change == KVM_MR_DELETE)
+	if (change == KVM_MR_DELETE) {
+		kvm_roe_free(free);
 		kvm_destroy_dirty_bitmap(free);
-
+	}
 	kvm_arch_free_memslot(kvm, free, dont);
 
 	free->npages = 0;
@@ -1018,6 +1020,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		if (kvm_create_dirty_bitmap(&new) < 0)
 			goto out_free;
 	}
+	if (kvm_roe_init(&new) < 0)
+		goto out_free;
 
 	slots = kvzalloc(sizeof(struct kvm_memslots), GFP_KERNEL);
 	if (!slots)
@@ -1348,13 +1352,18 @@ static bool memslot_is_readonly(struct kvm_memory_slot *slot)
 	return slot->flags & KVM_MEM_READONLY;
 }
 
+static bool gfn_is_readonly(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return gfn_is_full_roe(slot, gfn) || memslot_is_readonly(slot);
+}
+
 static unsigned long __gfn_to_hva_many(struct kvm_memory_slot *slot, gfn_t gfn,
 				       gfn_t *nr_pages, bool write)
 {
 	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
 		return KVM_HVA_ERR_BAD;
 
-	if (memslot_is_readonly(slot) && write)
+	if (gfn_is_readonly(slot, gfn) && write)
 		return KVM_HVA_ERR_RO_BAD;
 
 	if (nr_pages)
@@ -1402,7 +1411,7 @@ unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot,
 	unsigned long hva = __gfn_to_hva_many(slot, gfn, NULL, false);
 
 	if (!kvm_is_error_hva(hva) && writable)
-		*writable = !memslot_is_readonly(slot);
+		*writable = !gfn_is_readonly(slot, gfn);
 
 	return hva;
 }
@@ -1640,7 +1649,7 @@ kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
 	}
 
 	/* Do not map writable pfn in the readonly memslot. */
-	if (writable && memslot_is_readonly(slot)) {
+	if (writable && gfn_is_readonly(slot, gfn)) {
 		*writable = false;
 		writable = NULL;
 	}
diff --git a/virt/kvm/roe.c b/virt/kvm/roe.c
new file mode 100644
index 0000000000..33d3a4f507
--- /dev/null
+++ b/virt/kvm/roe.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * KVM Read Only Enforcement
+ * Copyright (c) 2018 Ahmed Abd El Mawgood
+ *
+ * Author: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
+ *
+ */
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+#include <linux/kvm_para.h>
+#include <kvm/roe.h>
+
+int kvm_roe_init(struct kvm_memory_slot *slot)
+{
+	slot->roe_bitmap = kvzalloc(BITS_TO_LONGS(slot->npages) *
+			sizeof(unsigned long), GFP_KERNEL);
+	if (!slot->roe_bitmap)
+		return -ENOMEM;
+	return 0;
+
+}
+
+void kvm_roe_free(struct kvm_memory_slot *slot)
+{
+	kvfree(slot->roe_bitmap);
+}
+
+static void kvm_roe_protect_slot(struct kvm *kvm, struct kvm_memory_slot *slot,
+		gfn_t gfn, u64 npages)
+{
+	int i;
+
+	for (i = gfn - slot->base_gfn; i < gfn + npages - slot->base_gfn; i++)
+		set_bit(i, slot->roe_bitmap);
+	kvm_roe_arch_commit_protection(kvm, slot);
+}
+
+
+static int __kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages)
+{
+	struct kvm_memory_slot *slot;
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	int count = 0;
+
+	while (npages != 0) {
+		slot = gfn_to_memslot(kvm, gfn);
+		if (!slot) {
+			gfn += 1;
+			npages -= 1;
+			continue;
+		}
+		if (gfn + npages > slot->base_gfn + slot->npages) {
+			u64 _npages = slot->base_gfn + slot->npages - gfn;
+
+			kvm_roe_protect_slot(kvm, slot, gfn, _npages);
+			gfn += _npages;
+			count += _npages;
+			npages -= _npages;
+		} else {
+			kvm_roe_protect_slot(kvm, slot, gfn, npages);
+			count += npages;
+			npages = 0;
+		}
+	}
+	if (count == 0)
+		return -EINVAL;
+	return count;
+}
+
+static int kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages)
+{
+	int r;
+
+	mutex_lock(&kvm->slots_lock);
+	r = __kvm_roe_protect_range(kvm, gpa, npages);
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+}
+
+
+static int kvm_roe_full_protect_range(struct kvm_vcpu *vcpu, u64 gva,
+		u64 npages)
+{
+	struct kvm *kvm = vcpu->kvm;
+	gpa_t gpa;
+	u64 hva;
+	u64 count = 0;
+	int i;
+	int status;
+
+	if (gva & ~PAGE_MASK)
+		return -EINVAL;
+	// We need to make sure that there will be no overflow
+	if ((npages << PAGE_SHIFT) >> PAGE_SHIFT != npages || npages == 0)
+		return -EINVAL;
+	for (i = 0; i < npages; i++) {
+		gpa = kvm_mmu_gva_to_gpa_system(vcpu, gva + (i << PAGE_SHIFT),
+				NULL);
+		hva = gfn_to_hva(kvm, gpa >> PAGE_SHIFT);
+		if (kvm_is_error_hva(hva))
+			continue;
+		if (!access_ok(hva, 1 << PAGE_SHIFT))
+			continue;
+		status =  kvm_roe_protect_range(vcpu->kvm, gpa, 1);
+		if (status > 0)
+			count += status;
+	}
+	if (count == 0)
+		return -EINVAL;
+	return count;
+}
+
+int kvm_roe(struct kvm_vcpu *vcpu, u64 a0, u64 a1, u64 a2, u64 a3)
+{
+	int ret;
+	/*
+	 * First we need to make sure that we are running from something that
+	 * isn't usermode
+	 */
+	if (kvm_roe_arch_is_userspace(vcpu))
+		return -KVM_ENOSYS;
+	switch (a0) {
+	case ROE_VERSION:
+		ret = 1; //current version
+		break;
+	case ROE_MPROTECT:
+		ret = kvm_roe_full_protect_range(vcpu, a1, a2);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvm_roe);
diff --git a/virt/kvm/roe_generic.h b/virt/kvm/roe_generic.h
new file mode 100644
index 0000000000..36e5b52c5b
--- /dev/null
+++ b/virt/kvm/roe_generic.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __KVM_ROE_GENERIC_H__
+#define __KVM_ROE_GENERIC_H__
+/*
+ * KVM Read Only Enforcement
+ * Copyright (c) 2018 Ahmed Abd El Mawgood
+ *
+ * Author Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
+ *
+ */
+
+void kvm_roe_free(struct kvm_memory_slot *slot);
+int kvm_roe_init(struct kvm_memory_slot *slot);
+static inline bool gfn_is_full_roe(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return test_bit(gfn - slot->base_gfn, slot->roe_bitmap);
+}
+#endif
-- 
2.19.2

