Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BD7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB1E20660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp7qh8U6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB1E20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeK1Wok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:44:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeK1Wo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:44:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so2026039wmh.1;
        Wed, 28 Nov 2018 03:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=y36Vr6tHWUTE6fkkPoOSAxsWpbq5HwHQ/ij4F5cdR/U=;
        b=Lp7qh8U6GPKBVbxBhm92DLIATEoyoDOLHeRrXkaX/H5bW5UpfD9hPDaTK900qGqSnG
         gYiMU0sLJm7sgLrNWx3neWS3zdE8ppFKBHkfkBbme5ZluI1azty9Ilz7PXTnY660DSUN
         Yq8zmJaCin6gFZGodLSCVWCiYmWyKgDVJs/cCPkAH2jb1ERqRL2iprgDxl0R/u68GBDZ
         kjnYZxsdQzJXDbD2Lx5k9fWt9KhO0afsRwNw2gwijU+kFvX3nrm32pFKIf1s6fUaRia2
         Q5V0JZwRrGrdKYLGbRKiyZJBm9K6zGGP26Gg+dh0t5aX2U3PhzuYZuXSi55IGUXPHi3G
         r2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=y36Vr6tHWUTE6fkkPoOSAxsWpbq5HwHQ/ij4F5cdR/U=;
        b=nXG0Q9DB+OYtw0lCyJCxT9xubL4lrSuGjndqsJekUTtM2hV/TywZ9yqicx2Aubzm4O
         KxLnN7mBEu1OZvYZIM8Esimbj44tO6+wLkyVIGiIf7jnpgiWrUVdb8l1JFRhOHN+yz66
         Sh6136iGkEW07ybMai7kcV8hWhTFoEYE+6aLU03bjCl0CqYIw7DoG0T51PlUPqO1DkFU
         2dQSBcQ55M7nR2vJp3zNcbsEnlDGfxNedYSmplBsjhO8Lv6TdWAEIboF2Ma7m5IAicwR
         3/OgwgXoDWsj9NusewigZftTwJLCjhQo0GtYVUwz4FZXdRtaS+ylHcrvuKEzdXne78Br
         r+kg==
X-Gm-Message-State: AA+aEWa2QlJB5Kx6UcBYRYbhHd+NjiteXH7YSN2CrZJJvTYx5m+eBAkG
        wwfXLXThrPpyLWlz07G9JQfxo1+/
X-Google-Smtp-Source: AFSGD/UF+0AH0mZvbPKGxS1rMcME+x5eSn/aBZBUAbmUTKsVPAN/LoYWKkOCRM7PrvLqxeWeaEQtiQ==
X-Received: by 2002:a1c:238c:: with SMTP id j134mr182309wmj.16.1543405383726;
        Wed, 28 Nov 2018 03:43:03 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id k19sm7061740wre.5.2018.11.28.03.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 03:43:02 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH 2/3] kvm: rename last argument to kvm_get_dirty_log_protect
Date:   Wed, 28 Nov 2018 12:42:58 +0100
Message-Id: <1543405379-21910-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1543405379-21910-1-git-send-email-pbonzini@redhat.com>
References: <1543405379-21910-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When manual dirty log reprotect will be enabled, kvm_get_dirty_log_protect's
pointer argument will always be false on exit, because no TLB flush is needed
until the manual re-protection operation.  Rename it from "is_dirty" to "flush",
which more accurately tells the caller what they have to do with it.

Reviewed-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/mips/kvm/mips.c     | 6 +++---
 arch/x86/kvm/x86.c       | 6 +++---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/arm/arm.c       | 6 +++---
 virt/kvm/kvm_main.c      | 6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 1fcc4d149054..3898e657952e 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1004,14 +1004,14 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	bool is_dirty = false;
+	bool flush = false;
 	int r;
 
 	mutex_lock(&kvm->slots_lock);
 
-	r = kvm_get_dirty_log_protect(kvm, log, &is_dirty);
+	r = kvm_get_dirty_log_protect(kvm, log, &flush);
 
-	if (is_dirty) {
+	if (flush) {
 		slots = kvm_memslots(kvm);
 		memslot = id_to_memslot(slots, log->slot);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 714c5eb0c3bd..448f011aa317 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4393,7 +4393,7 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
  */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
-	bool is_dirty = false;
+	bool flush = false;
 	int r;
 
 	mutex_lock(&kvm->slots_lock);
@@ -4404,14 +4404,14 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	if (kvm_x86_ops->flush_log_dirty)
 		kvm_x86_ops->flush_log_dirty(kvm);
 
-	r = kvm_get_dirty_log_protect(kvm, log, &is_dirty);
+	r = kvm_get_dirty_log_protect(kvm, log, &flush);
 
 	/*
 	 * All the TLBs can be flushed out of mmu lock, see the comments in
 	 * kvm_mmu_slot_remove_write_access().
 	 */
 	lockdep_assert_held(&kvm->slots_lock);
-	if (is_dirty)
+	if (flush)
 		kvm_flush_remote_tlbs(kvm);
 
 	mutex_unlock(&kvm->slots_lock);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 54cc06dd7e6c..8c56b2873b13 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -753,7 +753,7 @@ int kvm_get_dirty_log(struct kvm *kvm,
 			struct kvm_dirty_log *log, int *is_dirty);
 
 int kvm_get_dirty_log_protect(struct kvm *kvm,
-			struct kvm_dirty_log *log, bool *is_dirty);
+			      struct kvm_dirty_log *log, bool *flush);
 
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					struct kvm_memory_slot *slot,
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 23774970c9df..120a2663dab9 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1205,14 +1205,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
  */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
-	bool is_dirty = false;
+	bool flush = false;
 	int r;
 
 	mutex_lock(&kvm->slots_lock);
 
-	r = kvm_get_dirty_log_protect(kvm, log, &is_dirty);
+	r = kvm_get_dirty_log_protect(kvm, log, &flush);
 
-	if (is_dirty)
+	if (flush)
 		kvm_flush_remote_tlbs(kvm);
 
 	mutex_unlock(&kvm->slots_lock);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1d6b77162d7c..54f0fcfd431e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1154,7 +1154,7 @@ int kvm_get_dirty_log(struct kvm *kvm,
  *
  */
 int kvm_get_dirty_log_protect(struct kvm *kvm,
-			struct kvm_dirty_log *log, bool *is_dirty)
+			struct kvm_dirty_log *log, bool *flush)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
@@ -1181,7 +1181,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 	memset(dirty_bitmap_buffer, 0, n);
 
 	spin_lock(&kvm->mmu_lock);
-	*is_dirty = false;
+	*flush = false;
 	for (i = 0; i < n / sizeof(long); i++) {
 		unsigned long mask;
 		gfn_t offset;
@@ -1189,7 +1189,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 		if (!dirty_bitmap[i])
 			continue;
 
-		*is_dirty = true;
+		*flush = true;
 
 		mask = xchg(&dirty_bitmap[i], 0);
 		dirty_bitmap_buffer[i] = mask;
-- 
1.8.3.1


