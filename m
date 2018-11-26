Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C73C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BC120865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7X7SPfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BC120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeK0DtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:49:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37717 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeK0DtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:49:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so19706428wru.4;
        Mon, 26 Nov 2018 08:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=57c4Q/Th0jocyYgM3t9/CmeGzHNJrZKIuZfPR4cLdi4=;
        b=O7X7SPfD1+OigBE/YfGLjNYrZxdosOStDobFyXQmo/bnuehKwrjbPApTGE5MqqJRim
         EI1SqJnnH6h+a5ZR5uM0AFpXzEB6886bI68Xt46u0Gb86RGESSCFK12y/kpHQhbBKqTY
         25+przF3o2bDlyR2QFO0HABdQi/97KHXwlXI1661iRe/7zDcYu877GMhQHMd+XfOQCXQ
         K3WMC264CH/szBjWfK4n86hsJPRLD2RJwEq4/l6o8RgNfo3iXWQIBZcK+oAX796N2Noj
         1JJh3VdzDM+cyca9r3ngr78fDmiua69SKnUe7VnVsePhyqxXe15vZEtRYlZJf2rHYbob
         CaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=57c4Q/Th0jocyYgM3t9/CmeGzHNJrZKIuZfPR4cLdi4=;
        b=LowsPbiELnDwXi1JrFdQ9t43SnnvrmKeLmgEe3JWYs8xt5IKeJ1goBbMm0YGkirWx9
         p/Piu7sNOP3shrrDI3/ZR82JMdIQvY4wkK+gJJ1ZZEjTmhVxmoofPMCoq0xrj7Z/Qh3Y
         tk3g4JBPJUIzMVRk+Xis9vUD1+olLnLoEmNABSt+YB0/CZ9JGzzZeUuAQGFNJYIk1wUG
         KYxBDkwxPuZdeWm3NSM+rgHTIn+k4meSlJ3zeO6TjTfHoEV2aXdilKeWArMPYtaFuwIe
         b5RJQr6EtWAovy7sP8HN1uOaKf56QsKPS2Kn0/idxgDZxJbdhdzubO/KvAu8bilpba9/
         29RQ==
X-Gm-Message-State: AA+aEWa7+2c0wtXy8hBi6U0Mzcg0GH7+T11WuDRa+I2Z+PLZouM5fJeZ
        yO/aCIcbgpILlk9tC1OGGlB1XleQ
X-Google-Smtp-Source: AFSGD/VeSxQ7mhhYxtUG1ehXLnCaVCGpWh7dI/Ojc5N5Tr/KRFOlTPPWdmKhvWykWSbzahCk8Hg8Xg==
X-Received: by 2002:adf:9c02:: with SMTP id f2-v6mr23550014wrc.211.1543251261145;
        Mon, 26 Nov 2018 08:54:21 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id w8sm979240wrv.7.2018.11.26.08.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:54:19 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Junaid Shahid <junaids@google.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH 3/3] kvm: introduce manual dirty log reprotect
Date:   Mon, 26 Nov 2018 17:54:13 +0100
Message-Id: <1543251253-24762-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
References: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two problems with KVM_GET_DIRTY_LOG.  First, and less important,
it can take kvm->mmu_lock for an extended period of time.  Second, its user
can actually see many false positives in some cases.  The latter is due
to a benign race like this:

  1. KVM_GET_DIRTY_LOG returns a set of dirty pages and write protects
     them.
  2. The guest modifies the pages, causing them to be marked ditry.
  3. Userspace actually copies the pages.
  4. KVM_GET_DIRTY_LOG returns those pages as dirty again, even though
     they were not written to since (3).

This is especially a problem for large guests, where the time between
(1) and (3) can be substantial.  This patch introduces a new
capability which, when enabled, makes KVM_GET_DIRTY_LOG not
write-protect the pages it returns.  Instead, userspace has to
explicitly clear the dirty log bits just before using the content
of the page.  The new KVM_CLEAR_DIRTY_LOG ioctl can operate on a
64-page granularity rather than requiring to sync a full memslot.
This way the mmu_lock is taken for small amounts of time, and
only a small amount of time will pass between write protection
of pages and the sending of their content.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virtual/kvm/api.txt                  |  65 +++++++++++
 arch/mips/kvm/mips.c                               |  23 ++++
 arch/x86/kvm/x86.c                                 |  27 +++++
 include/linux/kvm_host.h                           |   5 +
 include/uapi/linux/kvm.h                           |  15 +++
 tools/testing/selftests/kvm/Makefile               |   2 +
 tools/testing/selftests/kvm/clear_dirty_log_test.c |   2 +
 tools/testing/selftests/kvm/dirty_log_test.c       |  19 ++++
 tools/testing/selftests/kvm/include/kvm_util.h     |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c         |  13 +++
 virt/kvm/arm/arm.c                                 |  16 +++
 virt/kvm/kvm_main.c                                | 120 ++++++++++++++++++---
 12 files changed, 293 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 1071c10cf1c7..859927fb0b9c 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -305,6 +305,9 @@ the address space for which you want to return the dirty bitmap.
 They must be less than the value that KVM_CHECK_EXTENSION returns for
 the KVM_CAP_MULTI_ADDRESS_SPACE capability.
 
+The bits in the dirty bitmap are cleared before the ioctl returns, unless
+KVM_CAP_MANUAL_DIRTY_LOG_PROTECT is enabled.  For more information,
+see the description of the capability.
 
 4.9 KVM_SET_MEMORY_ALIAS
 
@@ -3758,6 +3761,44 @@ Coalesced pio is based on coalesced mmio. There is little difference
 between coalesced mmio and pio except that coalesced pio records accesses
 to I/O ports.
 
+4.117 KVM_CLEAR_DIRTY_LOG (vm ioctl)
+
+Capability: KVM_CAP_MANUAL_DIRTY_LOG_PROTECT
+Architectures: x86
+Type: vm ioctl
+Parameters: struct kvm_dirty_log (in/out)
+Returns: 0 on success, -1 on error
+
+/* for KVM_CLEAR_DIRTY_LOG */
+struct kvm_clear_dirty_log {
+	__u32 slot;
+	__u32 num_pages;
+	__u64 first_page;
+	union {
+		void __user *dirty_bitmap; /* one bit per page */
+		__u64 padding;
+	};
+};
+
+The ioctl write-protects pages in a memory slot according to the
+bitmap that is passed in struct kvm_clear_dirty_log's dirty_bitmap
+field.  Bit 0 of the bitmap corresponds to page "first_page" in the
+memory slot, and num_pages is the size in bits of the input bitmap.
+Both first_page and num_pages must be a multiple of 64.  For each
+bit that is set in the input bitmap, the corresponding page is write
+protected and marked "clean" in KVM's dirty bitmap.
+
+If KVM_CAP_MULTI_ADDRESS_SPACE is available, bits 16-31 specifies
+the address space for which you want to return the dirty bitmap.
+They must be less than the value that KVM_CHECK_EXTENSION returns for
+the KVM_CAP_MULTI_ADDRESS_SPACE capability.
+
+This ioctl is mostly useful when KVM_CAP_MANUAL_DIRTY_LOG_PROTECT
+is enabled; for more information, see the description of the capability.
+However, it can always be used as long as KVM_CHECK_EXTENSION confirms
+that KVM_CAP_MANUAL_DIRTY_LOG_PROTECT is present.
+
+
 5. The kvm_run structure
 ------------------------
 
@@ -4652,6 +4693,30 @@ and injected exceptions.
 * For the new DR6 bits, note that bit 16 is set iff the #DB exception
   will clear DR6.RTM.
 
+7.18 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT
+
+Architectures: all
+Parameters: args[0] whether feature should be enabled or not
+
+With this capability enabled, KVM_GET_DIRTY_LOG will not automatically
+clear and write-protect all pages that are returned as dirty.
+Rather, userspace will have to do this operation separately using
+KVM_CLEAR_DIRTY_LOG.
+
+At the cost of a slightly more complicated operation, this provides better
+scalability and responsiveness for two reasons.  First,
+KVM_CLEAR_DIRTY_LOG ioctl can operate on a 64-page granularity rather
+than requiring to sync a full memslot; this ensures that KVM does not
+take spinlocks for an extended period of time.  Second, in some cases a
+large amount of time can pass between a call to KVM_GET_DIRTY_LOG and
+userspace actually using the data in the page.  Pages can be modified
+during this time, which is inefficint for both the guest and userspace:
+the guest will incur a higher penalty due to write protection faults,
+while userspace can see false reports of dirty pages.  Manual reprotection
+helps reducing this time, improving guest performance and reducing the
+number of dirty log false positives.
+
+
 8. Other capabilities.
 ----------------------
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 3898e657952e..3734cd58895e 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1023,6 +1023,29 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	return r;
 }
 
+int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *log)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	bool flush = false;
+	int r;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = kvm_clear_dirty_log_protect(kvm, log, &flush);
+
+	if (flush) {
+		slots = kvm_memslots(kvm);
+		memslot = id_to_memslot(slots, log->slot);
+
+		/* Let implementation handle TLB/GVA invalidation */
+		kvm_mips_callbacks->flush_shadow_memslot(kvm, memslot);
+	}
+
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+}
+
 long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
 	long r;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ff6a8411a15c..0a5b335b45bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4435,6 +4435,33 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	return r;
 }
 
+int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *log)
+{
+	bool flush = false;
+	int r;
+
+	mutex_lock(&kvm->slots_lock);
+
+	/*
+	 * Flush potentially hardware-cached dirty pages to dirty_bitmap.
+	 */
+	if (kvm_x86_ops->flush_log_dirty)
+		kvm_x86_ops->flush_log_dirty(kvm);
+
+	r = kvm_clear_dirty_log_protect(kvm, log, &flush);
+
+	/*
+	 * All the TLBs can be flushed out of mmu lock, see the comments in
+	 * kvm_mmu_slot_remove_write_access().
+	 */
+	lockdep_assert_held(&kvm->slots_lock);
+	if (flush)
+		kvm_flush_remote_tlbs(kvm);
+
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+}
+
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 			bool line_status)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8c56b2873b13..e065aeaae29e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -449,6 +449,7 @@ struct kvm {
 #endif
 	long tlbs_dirty;
 	struct list_head devices;
+	bool manual_dirty_log_protect;
 	struct dentry *debugfs_dentry;
 	struct kvm_stat_data **debugfs_stat_data;
 	struct srcu_struct srcu;
@@ -754,6 +755,8 @@ int kvm_get_dirty_log(struct kvm *kvm,
 
 int kvm_get_dirty_log_protect(struct kvm *kvm,
 			      struct kvm_dirty_log *log, bool *flush);
+int kvm_clear_dirty_log_protect(struct kvm *kvm,
+				struct kvm_clear_dirty_log *log, bool *flush);
 
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					struct kvm_memory_slot *slot,
@@ -762,6 +765,8 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 				struct kvm_dirty_log *log);
+int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
+				  struct kvm_clear_dirty_log *log);
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 			bool line_status);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b8da14cee8e5..681e6bbdc157 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -492,6 +492,17 @@ struct kvm_dirty_log {
 	};
 };
 
+/* for KVM_CLEAR_DIRTY_LOG */
+struct kvm_clear_dirty_log {
+	__u32 slot;
+	__u32 num_pages;
+	__u64 first_page;
+	union {
+		void __user *dirty_bitmap; /* one bit per page */
+		__u64 padding2;
+	};
+};
+
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
@@ -976,6 +987,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
 #define KVM_CAP_HYPERV_STIMER_DIRECT 166
+#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 167
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1422,6 +1434,9 @@ struct kvm_enc_region {
 #define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
 #define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
+/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT */
+#define KVM_CLEAR_DIRTY_LOG          _IOWR(KVMIO, 0xc0, struct kvm_clear_dirty_log)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 01a219229238..e35955bf59b3 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -15,8 +15,10 @@ TEST_GEN_PROGS_x86_64 += x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
+TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 
 TEST_GEN_PROGS_aarch64 += dirty_log_test
+TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/clear_dirty_log_test.c b/tools/testing/selftests/kvm/clear_dirty_log_test.c
new file mode 100644
index 000000000000..749336937d37
--- /dev/null
+++ b/tools/testing/selftests/kvm/clear_dirty_log_test.c
@@ -0,0 +1,2 @@
+#define USE_CLEAR_DIRTY_LOG
+#include "dirty_log_test.c"
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index aeff95a91b15..4629c7ccfa28 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -275,6 +275,14 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 
 	vm = create_vm(mode, VCPU_ID, guest_num_pages, guest_code);
 
+#ifdef USE_CLEAR_DIRTY_LOG
+	struct kvm_enable_cap cap = {};
+
+	cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT;
+	cap.args[0] = 1;
+	vm_enable_cap(vm, &cap);
+#endif
+
 	/* Add an extra memory slot for testing dirty logging */
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
 				    guest_test_mem,
@@ -316,6 +324,10 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 		/* Give the vcpu thread some time to dirty some pages */
 		usleep(interval * 1000);
 		kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
+#ifdef USE_CLEAR_DIRTY_LOG
+		kvm_vm_clear_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap, 0,
+				       DIV_ROUND_UP(host_num_pages, 64) * 64);
+#endif
 		vm_dirty_log_verify(bmap);
 		iteration++;
 		sync_global_to_guest(vm, iteration);
@@ -392,6 +404,13 @@ int main(int argc, char *argv[])
 	unsigned int mode;
 	int opt, i;
 
+#ifdef USE_CLEAR_DIRTY_LOG
+	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT)) {
+		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping tests\n");
+		exit(KSFT_SKIP);
+	}
+#endif
+
 	while ((opt = getopt(argc, argv, "hi:I:o:tm:")) != -1) {
 		switch (opt) {
 		case 'i':
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a4e59e3b4826..c51bfaba017a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -58,6 +58,8 @@ enum vm_mem_backing_src_type {
 void kvm_vm_restart(struct kvm_vm *vmp, int perm);
 void kvm_vm_release(struct kvm_vm *vmp);
 void kvm_vm_get_dirty_log(struct kvm_vm *vm, int slot, void *log);
+void kvm_vm_clear_dirty_log(struct kvm_vm *vm, int slot, void *log,
+			    uint64_t first_page, uint32_t num_pages);
 
 int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, const vm_vaddr_t gva,
 		       size_t len);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1b41e71283d5..c9e94d6503af 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -231,6 +231,19 @@ void kvm_vm_get_dirty_log(struct kvm_vm *vm, int slot, void *log)
 		    strerror(-ret));
 }
 
+void kvm_vm_clear_dirty_log(struct kvm_vm *vm, int slot, void *log,
+			    uint64_t first_page, uint32_t num_pages)
+{
+	struct kvm_clear_dirty_log args = { .dirty_bitmap = log, .slot = slot,
+		                            .first_page = first_page,
+	                                    .num_pages = num_pages };
+	int ret;
+
+	ret = ioctl(vm->fd, KVM_CLEAR_DIRTY_LOG, &args);
+	TEST_ASSERT(ret == 0, "%s: KVM_CLEAR_DIRTY_LOG failed: %s",
+		    strerror(-ret));
+}
+
 /*
  * Userspace Memory Region Find
  *
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 120a2663dab9..e91adf77d99a 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1219,6 +1219,22 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	return r;
 }
 
+int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *log)
+{
+	bool flush = false;
+	int r;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = kvm_clear_dirty_log_protect(kvm, log, &flush);
+
+	if (flush)
+		kvm_flush_remote_tlbs(kvm);
+
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+}
+
 static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
 					struct kvm_arm_device_addr *dev_addr)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b1eae5394411..e6ed9e5553ff 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1176,37 +1176,104 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 		return -ENOENT;
 
 	n = kvm_dirty_bitmap_bytes(memslot);
+	*flush = false;
+	if (kvm->manual_dirty_log_protect) {
+		/* Unlike kvm_get_dirty_log, we always return false in *flush,
+		 * because no flush is needed until KVM_CLEAR_DIRTY_LOG.
+		 */
+		dirty_bitmap_buffer = dirty_bitmap;
+	} else {
+		dirty_bitmap_buffer = kvm_second_dirty_bitmap(memslot);
+		memset(dirty_bitmap_buffer, 0, n);
 
-	dirty_bitmap_buffer = kvm_second_dirty_bitmap(memslot);
-	memset(dirty_bitmap_buffer, 0, n);
+		spin_lock(&kvm->mmu_lock);
+		for (i = 0; i < n / sizeof(long); i++) {
+			unsigned long mask;
+			gfn_t offset;
 
-	spin_lock(&kvm->mmu_lock);
+			if (!dirty_bitmap[i])
+				continue;
+
+			*flush = true;
+			mask = xchg(&dirty_bitmap[i], 0);
+			dirty_bitmap_buffer[i] = mask;
+
+			if (mask) {
+				offset = i * BITS_PER_LONG;
+				kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
+									offset, mask);
+			}
+		}
+		spin_unlock(&kvm->mmu_lock);
+	}
+
+	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_get_dirty_log_protect);
+
+/**
+ * kvm_clear_dirty_log_protect - clear dirty bits in the bitmap
+ *	are dirty write protect the corresponding pages for next write.
+ * @kvm:	pointer to kvm instance
+ * @log:	slot id and address from which to fetch the bitmap of dirty pages
+ */
+int kvm_clear_dirty_log_protect(struct kvm *kvm,
+				struct kvm_clear_dirty_log *log, bool *flush)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	int as_id, id, n;
+	gfn_t offset;
+	unsigned long i;
+	unsigned long *dirty_bitmap;
+	unsigned long *dirty_bitmap_buffer;
+
+	as_id = log->slot >> 16;
+	id = (u16)log->slot;
+	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
+		return -EINVAL;
+
+	if ((log->first_page & 63) || (log->num_pages & 63))
+		return -EINVAL;
+
+	slots = __kvm_memslots(kvm, as_id);
+	memslot = id_to_memslot(slots, id);
+
+	dirty_bitmap = memslot->dirty_bitmap;
+	if (!dirty_bitmap)
+		return -ENOENT;
+
+	n = kvm_dirty_bitmap_bytes(memslot);
 	*flush = false;
-	for (i = 0; i < n / sizeof(long); i++) {
-		unsigned long mask;
-		gfn_t offset;
+	dirty_bitmap_buffer = kvm_second_dirty_bitmap(memslot);
+	if (copy_from_user(dirty_bitmap_buffer, log->dirty_bitmap, n))
+		return -EFAULT;
 
-		if (!dirty_bitmap[i])
+	spin_lock(&kvm->mmu_lock);
+	for (offset = log->first_page,
+	     i = offset / BITS_PER_LONG, n = log->num_pages / BITS_PER_LONG; n--;
+	     i++, offset += BITS_PER_LONG) {
+		unsigned long mask = *dirty_bitmap_buffer++;
+		atomic_long_t *p = (atomic_long_t *) &dirty_bitmap[i];
+		if (!mask)
 			continue;
 
-		*flush = true;
-
-		mask = xchg(&dirty_bitmap[i], 0);
-		dirty_bitmap_buffer[i] = mask;
+		mask &= atomic_long_fetch_andnot(mask, p);
 
+		/* mask contains the bits that really have been cleared.  */
 		if (mask) {
-			offset = i * BITS_PER_LONG;
+			*flush = true;
 			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
 								offset, mask);
 		}
 	}
-
 	spin_unlock(&kvm->mmu_lock);
-	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
-		return -EFAULT;
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(kvm_get_dirty_log_protect);
+EXPORT_SYMBOL_GPL(kvm_clear_dirty_log_protect);
 #endif
 
 bool kvm_largepages_enabled(void)
@@ -2945,6 +3012,9 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_IOEVENTFD_ANY_LENGTH:
 	case KVM_CAP_CHECK_EXTENSION_VM:
 	case KVM_CAP_ENABLE_CAP_VM:
+#ifdef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
+	case KVM_CAP_MANUAL_DIRTY_LOG_PROTECT:
+#endif
 		return 1;
 #ifdef CONFIG_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
@@ -2978,6 +3048,13 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
 					   struct kvm_enable_cap *cap)
 {
 	switch (cap->cap) {
+#ifdef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
+	case KVM_CAP_MANUAL_DIRTY_LOG_PROTECT:
+		if (cap->flags || (cap->args[0] & ~1))
+			return -EINVAL;
+		kvm->manual_dirty_log_protect = cap->args[0];
+		return 0;
+#endif
 	default:
 		return kvm_vm_ioctl_enable_cap(kvm, cap);
 	}
@@ -3025,6 +3102,17 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_get_dirty_log(kvm, &log);
 		break;
 	}
+#ifdef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
+	case KVM_CLEAR_DIRTY_LOG: {
+		struct kvm_clear_dirty_log log;
+
+		r = -EFAULT;
+		if (copy_from_user(&log, argp, sizeof(log)))
+			goto out;
+		r = kvm_vm_ioctl_clear_dirty_log(kvm, &log);
+		break;
+	}
+#endif
 #ifdef CONFIG_KVM_MMIO
 	case KVM_REGISTER_COALESCED_MMIO: {
 		struct kvm_coalesced_mmio_zone zone;
-- 
1.8.3.1

