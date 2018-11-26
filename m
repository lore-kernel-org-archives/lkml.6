Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B36C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F84A20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5bpdVCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F84A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeK0DtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:49:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54881 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeK0DtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:49:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id z18so4298176wmc.4;
        Mon, 26 Nov 2018 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rGjk6e6/pUrl6zaOgH8WvQXEYRG547vFCcK6y+TeBHQ=;
        b=L5bpdVClYXnbSFAriAkpMhV+Qq7DOcjyUfh3N0iO5dPb+KLFYp8N0agNpFOmuc/3uN
         /tIINaTm9iAmye+ltNADgk0Kax49DeJFr5Ak9OISYHJVGaHze1xVBNmCqBrMxuQc3T60
         ldhzPY+r+yVZM4vkBBLIV+k7tZnfUoGa8h+wKt9tb2vwugurbC92rMLZDiegC14gPmFe
         dFs7F3OmanpPmSUw2Iq5zdcKCg3PZrlp6aDflyEzQFXivDQbUDZ1C7kGncWki814M2Tf
         zICLSYIAMlyMPWNiaUvfRxwb4x2qohzwtTGK1vPzATy1Im4yLoQoEm6zkX7AzT3ntcrJ
         wUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rGjk6e6/pUrl6zaOgH8WvQXEYRG547vFCcK6y+TeBHQ=;
        b=BuklWIh+7eIMm1BXK4/Y7sHFFqUQAVEY4KXWLuxjWmTC/EZw79d+1DZhSFY+v+anB7
         zQ42aZR6e7DNA7XZND9QCs1bqIJUHoLXLerCO8nLZlUHZJ6Ihy1NDIWDGWEH/lMAmplB
         sb6FbLPWLQRXtSF5TAs9H1Me/hGd10gG1jO7A8wiEdp0iENMIcsa3wNoTfEWkAl7IBqW
         dcwAAjT3ySccBeRoSeVRhBi4N+nlRuuTOz+opPyGDfiE1vjedgZuttRj3KAdJOJRbDyV
         aVC7oVlaQNR4LUpUyb2dZwE0AxNhT0LYPWyTss3yTYgj92TOf4K6ipfvHRbJ0fhnyJKt
         ESzg==
X-Gm-Message-State: AA+aEWbqUc3cVxCSLMH+Gqc6944oVAMI57FyEINR9k/d9vOzLq2JxVam
        ZTTtVszHlY4VAmI84zsWZlFbJ5CZ
X-Google-Smtp-Source: AFSGD/XGu75gzLSw3MhDQvaSWNQTz5IXUjUBQZYgTz9G6ZLE+V6sNgVOTROWr149skrqibKu8giYTg==
X-Received: by 2002:a1c:8f06:: with SMTP id r6mr15973611wmd.65.1543251259275;
        Mon, 26 Nov 2018 08:54:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id w8sm979240wrv.7.2018.11.26.08.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:54:17 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Junaid Shahid <junaids@google.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH 2/3] kvm: rename last argument to kvm_get_dirty_log_protect
Date:   Mon, 26 Nov 2018 17:54:12 +0100
Message-Id: <1543251253-24762-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
References: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When manual dirty log reprotect will be enabled, kvm_get_dirty_log_protect's
pointer argument will always be false on exit, because no TLB flush is needed
until the manual re-protection operation.  Rename it from "is_dirty" to "flush",
which more accurately tells the caller what they have to do with it.

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
index dc902e5139c2..ff6a8411a15c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4410,7 +4410,7 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
  */
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
-	bool is_dirty = false;
+	bool flush = false;
 	int r;
 
 	mutex_lock(&kvm->slots_lock);
@@ -4421,14 +4421,14 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
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
index 2d842fd20cd3..b1eae5394411 100644
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


