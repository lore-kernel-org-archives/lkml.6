Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeC1I7x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:59:53 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:44651 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbeC1I7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:59:20 -0400
X-Google-Smtp-Source: AIpwx4830yQcGhSRDELSG+Xvq6jag4HFMzBsaAv9Q6XldiASUGa7SbGxYE2VdiljLe/rrKC6ezCf9Q==
From: Paolo Bonzini <paolo.bonzini@gmail.com>
X-Google-Original-From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hofsass@google.com
Subject: [PATCH 1/2] kvm: selftests: add API testing infrastructure
Date: Wed, 28 Mar 2018 10:59:05 +0200
Message-Id: <20180328085906.26936-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328085906.26936-1-pbonzini@redhat.com>
References: <20180328085906.26936-1-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testsuite contributed by Google and cleaned up by myself for
inclusion in Linux.

Signed-off-by: Ken Hofsass <hofsass@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/kvm/Makefile               |   38 +
 tools/testing/selftests/kvm/include/kvm_util.h     |  139 ++
 tools/testing/selftests/kvm/include/sparsebit.h    |   75 +
 tools/testing/selftests/kvm/include/test_util.h    |   45 +
 tools/testing/selftests/kvm/include/x86.h          | 1043 ++++++++++
 tools/testing/selftests/kvm/lib/assert.c           |   87 +
 tools/testing/selftests/kvm/lib/kvm_util.c         | 1480 ++++++++++++++
 .../testing/selftests/kvm/lib/kvm_util_internal.h  |   67 +
 tools/testing/selftests/kvm/lib/sparsebit.c        | 2087 ++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86.c              |  697 +++++++
 tools/testing/selftests/kvm/set_sregs_test.c       |   57 +
 12 files changed, 5816 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/Makefile
 create mode 100644 tools/testing/selftests/kvm/include/kvm_util.h
 create mode 100644 tools/testing/selftests/kvm/include/sparsebit.h
 create mode 100644 tools/testing/selftests/kvm/include/test_util.h
 create mode 100644 tools/testing/selftests/kvm/include/x86.h
 create mode 100644 tools/testing/selftests/kvm/lib/assert.c
 create mode 100644 tools/testing/selftests/kvm/lib/kvm_util.c
 create mode 100644 tools/testing/selftests/kvm/lib/kvm_util_internal.h
 create mode 100644 tools/testing/selftests/kvm/lib/sparsebit.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86.c
 create mode 100644 tools/testing/selftests/kvm/set_sregs_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 7442dfb73b7f..c98f1b874582 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -14,6 +14,7 @@ TARGETS += gpio
 TARGETS += intel_pstate
 TARGETS += ipc
 TARGETS += kcmp
+TARGETS += kvm
 TARGETS += lib
 TARGETS += membarrier
 TARGETS += memfd
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
new file mode 100644
index 000000000000..6aade26e9ca2
--- /dev/null
+++ b/tools/testing/selftests/kvm/Makefile
@@ -0,0 +1,38 @@
+all:
+
+top_srcdir = ../../../../
+UNAME_M := $(shell uname -m)
+
+LIBKVM = lib/assert.c lib/kvm_util.c lib/sparsebit.c
+LIBKVM_x86_64 = lib/x86.c
+
+TEST_GEN_PROGS_x86_64 = set_sregs_test
+
+TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
+LIBKVM += $(LIBKVM_$(UNAME_M))
+
+INSTALL_HDR_PATH = $(top_srcdir)/usr
+LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
+CFLAGS += -O2 -g -I$(LINUX_HDR_PATH) -Iinclude -I$(<D)
+
+# After inclusion, $(OUTPUT) is defined and
+# $(TEST_GEN_PROGS) starts with $(OUTPUT)/
+include ../lib.mk
+
+STATIC_LIBS := $(OUTPUT)/libkvm.a
+LIBKVM_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM))
+EXTRA_CLEAN += $(LIBKVM_OBJ) $(STATIC_LIBS)
+
+x := $(shell mkdir -p $(sort $(dir $(LIBKVM_OBJ))))
+$(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+$(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
+	$(AR) crs $@ $^
+
+$(LINUX_HDR_PATH):
+	make -C $(top_srcdir) headers_install
+
+all: $(STATIC_LIBS) $(LINUX_HDR_PATH)
+$(TEST_GEN_PROGS): $(STATIC_LIBS)
+$(TEST_GEN_PROGS) $(LIBKVM_OBJ): | $(LINUX_HDR_PATH)
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
new file mode 100644
index 000000000000..44aa1e204dbc
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -0,0 +1,139 @@
+/*
+ * tools/testing/selftests/kvm/include/kvm_util.h
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ */
+#ifndef SELFTEST_KVM_UTIL_H
+#define SELFTEST_KVM_UTIL_H 1
+
+#include "test_util.h"
+
+#include "asm/kvm.h"
+#include "linux/kvm.h"
+#include <sys/ioctl.h>
+
+#include "sparsebit.h"
+
+/*
+ * Memslots can't cover the gfn starting at this gpa otherwise vCPUs can't be
+ * created. Only applies to VMs using EPT.
+ */
+#define KVM_DEFAULT_IDENTITY_MAP_ADDRESS 0xfffbc000ul
+
+
+/* Callers of kvm_util only have an incomplete/opaque description of the
+ * structure kvm_util is using to maintain the state of a VM.
+ */
+struct kvm_vm;
+
+typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
+typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
+
+/* Minimum allocated guest virtual and physical addresses */
+#define KVM_UTIL_MIN_VADDR 0x2000
+
+#define DEFAULT_GUEST_PHY_PAGES		512
+#define DEFAULT_GUEST_STACK_VADDR_MIN	0xab6000
+#define DEFAULT_STACK_PGS               5
+
+enum vm_guest_mode {
+	VM_MODE_FLAT48PG,
+};
+
+enum vm_mem_backing_src_type {
+	VM_MEM_SRC_ANONYMOUS,
+	VM_MEM_SRC_ANONYMOUS_THP,
+	VM_MEM_SRC_ANONYMOUS_HUGETLB,
+};
+
+int kvm_check_cap(long cap);
+
+struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
+void kvm_vm_free(struct kvm_vm *vmp);
+
+int kvm_memcmp_hva_gva(void *hva,
+	struct kvm_vm *vm, const vm_vaddr_t gva, size_t len);
+
+void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
+void vcpu_dump(FILE *stream, struct kvm_vm *vm,
+	uint32_t vcpuid, uint8_t indent);
+
+void vm_create_irqchip(struct kvm_vm *vm);
+
+void vm_userspace_mem_region_add(struct kvm_vm *vm,
+	enum vm_mem_backing_src_type src_type,
+	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
+	uint32_t flags);
+
+void vcpu_ioctl(struct kvm_vm *vm,
+	uint32_t vcpuid, unsigned long ioctl, void *arg);
+void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
+void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
+void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
+vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+	uint32_t data_memslot, uint32_t pgd_memslot);
+void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
+void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
+vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
+vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva);
+
+struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
+int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
+	struct kvm_mp_state *mp_state);
+void vcpu_regs_get(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_regs *regs);
+void vcpu_regs_set(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_regs *regs);
+void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...);
+void vcpu_sregs_get(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_sregs *sregs);
+void vcpu_sregs_set(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_sregs *sregs);
+int _vcpu_sregs_set(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_sregs *sregs);
+void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
+			  struct kvm_vcpu_events *events);
+void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
+			  struct kvm_vcpu_events *events);
+
+const char *exit_reason_str(unsigned int exit_reason);
+
+void virt_pgd_alloc(struct kvm_vm *vm, uint32_t pgd_memslot);
+void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+	uint32_t pgd_memslot);
+vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm,
+	vm_paddr_t paddr_min, uint32_t memslot);
+
+void kvm_get_supported_cpuid(struct kvm_cpuid2 *cpuid);
+void vcpu_set_cpuid(
+	struct kvm_vm *vm, uint32_t vcpuid, struct kvm_cpuid2 *cpuid);
+
+struct kvm_cpuid2 *allocate_kvm_cpuid2(void);
+struct kvm_cpuid_entry2 *
+find_cpuid_index_entry(struct kvm_cpuid2 *cpuid, uint32_t function,
+		       uint32_t index);
+
+static inline struct kvm_cpuid_entry2 *
+find_cpuid_entry(struct kvm_cpuid2 *cpuid, uint32_t function)
+{
+	return find_cpuid_index_entry(cpuid, function, 0);
+}
+
+struct kvm_vm *vm_create_default(uint32_t vcpuid, void *guest_code);
+void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code);
+
+struct kvm_userspace_memory_region *
+kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
+				 uint64_t end);
+
+struct kvm_dirty_log *
+allocate_kvm_dirty_log(struct kvm_userspace_memory_region *region);
+
+int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
+
+#endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/include/sparsebit.h b/tools/testing/selftests/kvm/include/sparsebit.h
new file mode 100644
index 000000000000..b0705de82b0b
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/sparsebit.h
@@ -0,0 +1,75 @@
+/*
+ * tools/testing/selftests/kvm/include/sparsebit.h
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ *
+ * Header file that describes API to the sparsebit library.
+ * This library provides a memory efficient means of storing
+ * the settings of bits indexed via a uint64_t.  Memory usage
+ * is reasonable, significantly less than (2^64 / 8) bytes, as
+ * long as bits that are mostly set or mostly cleared are close
+ * to each other.  This library is efficient in memory usage
+ * even in the case where most bits are set.
+ */
+
+#ifndef _TEST_SPARSEBIT_H_
+#define _TEST_SPARSEBIT_H_
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct sparsebit;
+typedef uint64_t sparsebit_idx_t;
+typedef uint64_t sparsebit_num_t;
+
+struct sparsebit *sparsebit_alloc(void);
+void sparsebit_free(struct sparsebit **sbitp);
+void sparsebit_copy(struct sparsebit *dstp, struct sparsebit *src);
+
+bool sparsebit_is_set(struct sparsebit *sbit, sparsebit_idx_t idx);
+bool sparsebit_is_set_num(struct sparsebit *sbit,
+			  sparsebit_idx_t idx, sparsebit_num_t num);
+bool sparsebit_is_clear(struct sparsebit *sbit, sparsebit_idx_t idx);
+bool sparsebit_is_clear_num(struct sparsebit *sbit,
+			    sparsebit_idx_t idx, sparsebit_num_t num);
+sparsebit_num_t sparsebit_num_set(struct sparsebit *sbit);
+bool sparsebit_any_set(struct sparsebit *sbit);
+bool sparsebit_any_clear(struct sparsebit *sbit);
+bool sparsebit_all_set(struct sparsebit *sbit);
+bool sparsebit_all_clear(struct sparsebit *sbit);
+sparsebit_idx_t sparsebit_first_set(struct sparsebit *sbit);
+sparsebit_idx_t sparsebit_first_clear(struct sparsebit *sbit);
+sparsebit_idx_t sparsebit_next_set(struct sparsebit *sbit, sparsebit_idx_t prev);
+sparsebit_idx_t sparsebit_next_clear(struct sparsebit *sbit, sparsebit_idx_t prev);
+sparsebit_idx_t sparsebit_next_set_num(struct sparsebit *sbit,
+				       sparsebit_idx_t start, sparsebit_num_t num);
+sparsebit_idx_t sparsebit_next_clear_num(struct sparsebit *sbit,
+					 sparsebit_idx_t start, sparsebit_num_t num);
+
+void sparsebit_set(struct sparsebit *sbitp, sparsebit_idx_t idx);
+void sparsebit_set_num(struct sparsebit *sbitp, sparsebit_idx_t start,
+		       sparsebit_num_t num);
+void sparsebit_set_all(struct sparsebit *sbitp);
+
+void sparsebit_clear(struct sparsebit *sbitp, sparsebit_idx_t idx);
+void sparsebit_clear_num(struct sparsebit *sbitp,
+			 sparsebit_idx_t start, sparsebit_num_t num);
+void sparsebit_clear_all(struct sparsebit *sbitp);
+
+void sparsebit_dump(FILE *stream, struct sparsebit *sbit,
+		    unsigned int indent);
+void sparsebit_validate_internal(struct sparsebit *sbit);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _TEST_SPARSEBIT_H_ */
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
new file mode 100644
index 000000000000..af92ce8f7baa
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -0,0 +1,45 @@
+/*
+ * tools/testing/selftests/kvm/include/test_util.h
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ */
+
+#ifndef TEST_UTIL_H
+#define TEST_UTIL_H 1
+
+#include <stdlib.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+ssize_t test_write(int fd, const void *buf, size_t count);
+ssize_t test_read(int fd, void *buf, size_t count);
+int test_seq_read(const char *path, char **bufp, size_t *sizep);
+
+void test_assert(bool exp, const char *exp_str,
+		 const char *file, unsigned int line, const char *fmt, ...);
+
+#define ARRAY_SIZE(array) (sizeof(array) / sizeof((array)[0]))
+
+#define TEST_ASSERT(e, fmt, ...) \
+	test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+#define ASSERT_EQ(a, b) do { \
+	typeof(a) __a = (a); \
+	typeof(b) __b = (b); \
+	TEST_ASSERT(__a == __b, \
+		    "ASSERT_EQ(%s, %s) failed.\n" \
+		    "\t%s is %#lx\n" \
+		    "\t%s is %#lx", \
+		    #a, #b, #a, (unsigned long) __a, #b, (unsigned long) __b); \
+} while (0)
+
+#endif /* TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/include/x86.h b/tools/testing/selftests/kvm/include/x86.h
new file mode 100644
index 000000000000..b34c5e0fc21d
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86.h
@@ -0,0 +1,1043 @@
+/*
+ * tools/testing/selftests/kvm/include/x86.h
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ */
+
+#ifndef SELFTEST_KVM_X86_H
+#define SELFTEST_KVM_X86_H
+
+#include <assert.h>
+#include <stdint.h>
+
+#define X86_EFLAGS_FIXED	 (1u << 1)
+
+#define X86_CR4_VME		(1ul << 0)
+#define X86_CR4_PVI		(1ul << 1)
+#define X86_CR4_TSD		(1ul << 2)
+#define X86_CR4_DE		(1ul << 3)
+#define X86_CR4_PSE		(1ul << 4)
+#define X86_CR4_PAE		(1ul << 5)
+#define X86_CR4_MCE		(1ul << 6)
+#define X86_CR4_PGE		(1ul << 7)
+#define X86_CR4_PCE		(1ul << 8)
+#define X86_CR4_OSFXSR		(1ul << 9)
+#define X86_CR4_OSXMMEXCPT	(1ul << 10)
+#define X86_CR4_UMIP		(1ul << 11)
+#define X86_CR4_VMXE		(1ul << 13)
+#define X86_CR4_SMXE		(1ul << 14)
+#define X86_CR4_FSGSBASE	(1ul << 16)
+#define X86_CR4_PCIDE		(1ul << 17)
+#define X86_CR4_OSXSAVE		(1ul << 18)
+#define X86_CR4_SMEP		(1ul << 20)
+#define X86_CR4_SMAP		(1ul << 21)
+#define X86_CR4_PKE		(1ul << 22)
+
+/* The enum values match the intruction encoding of each register */
+enum x86_register {
+	RAX = 0,
+	RCX,
+	RDX,
+	RBX,
+	RSP,
+	RBP,
+	RSI,
+	RDI,
+	R8,
+	R9,
+	R10,
+	R11,
+	R12,
+	R13,
+	R14,
+	R15,
+};
+
+struct desc64 {
+	uint16_t limit0;
+	uint16_t base0;
+	unsigned base1:8, type:5, dpl:2, p:1;
+	unsigned limit1:4, zero0:3, g:1, base2:8;
+	uint32_t base3;
+	uint32_t zero1;
+} __attribute__((packed));
+
+struct desc_ptr {
+	uint16_t size;
+	uint64_t address;
+} __attribute__((packed));
+
+static inline uint64_t get_desc64_base(const struct desc64 *desc)
+{
+	return ((uint64_t)desc->base3 << 32) |
+		(desc->base0 | ((desc->base1) << 16) | ((desc->base2) << 24));
+}
+
+static inline uint64_t rdtsc(void)
+{
+	uint32_t eax, edx;
+
+	/*
+	 * The lfence is to wait (on Intel CPUs) until all previous
+	 * instructions have been executed.
+	 */
+	__asm__ __volatile__("lfence; rdtsc" : "=a"(eax), "=d"(edx));
+	return ((uint64_t)edx) << 32 | eax;
+}
+
+static inline uint64_t rdtscp(uint32_t *aux)
+{
+	uint32_t eax, edx;
+
+	__asm__ __volatile__("rdtscp" : "=a"(eax), "=d"(edx), "=c"(*aux));
+	return ((uint64_t)edx) << 32 | eax;
+}
+
+static inline uint64_t rdmsr(uint32_t msr)
+{
+	uint32_t a, d;
+
+	__asm__ __volatile__("rdmsr" : "=a"(a), "=d"(d) : "c"(msr) : "memory");
+
+	return a | ((uint64_t) d << 32);
+}
+
+static inline void wrmsr(uint32_t msr, uint64_t value)
+{
+	uint32_t a = value;
+	uint32_t d = value >> 32;
+
+	__asm__ __volatile__("wrmsr" :: "a"(a), "d"(d), "c"(msr) : "memory");
+}
+
+
+static inline uint16_t inw(uint16_t port)
+{
+	uint16_t tmp;
+
+	__asm__ __volatile__("in %%dx, %%ax"
+		: /* output */ "=a" (tmp)
+		: /* input */ "d" (port));
+
+	return tmp;
+}
+
+static inline uint16_t get_es(void)
+{
+	uint16_t es;
+
+	__asm__ __volatile__("mov %%es, %[es]"
+			     : /* output */ [es]"=rm"(es));
+	return es;
+}
+
+static inline uint16_t get_cs(void)
+{
+	uint16_t cs;
+
+	__asm__ __volatile__("mov %%cs, %[cs]"
+			     : /* output */ [cs]"=rm"(cs));
+	return cs;
+}
+
+static inline uint16_t get_ss(void)
+{
+	uint16_t ss;
+
+	__asm__ __volatile__("mov %%ss, %[ss]"
+			     : /* output */ [ss]"=rm"(ss));
+	return ss;
+}
+
+static inline uint16_t get_ds(void)
+{
+	uint16_t ds;
+
+	__asm__ __volatile__("mov %%ds, %[ds]"
+			     : /* output */ [ds]"=rm"(ds));
+	return ds;
+}
+
+static inline uint16_t get_fs(void)
+{
+	uint16_t fs;
+
+	__asm__ __volatile__("mov %%fs, %[fs]"
+			     : /* output */ [fs]"=rm"(fs));
+	return fs;
+}
+
+static inline uint16_t get_gs(void)
+{
+	uint16_t gs;
+
+	__asm__ __volatile__("mov %%gs, %[gs]"
+			     : /* output */ [gs]"=rm"(gs));
+	return gs;
+}
+
+static inline uint16_t get_tr(void)
+{
+	uint16_t tr;
+
+	__asm__ __volatile__("str %[tr]"
+			     : /* output */ [tr]"=rm"(tr));
+	return tr;
+}
+
+static inline uint64_t get_cr0(void)
+{
+	uint64_t cr0;
+
+	__asm__ __volatile__("mov %%cr0, %[cr0]"
+			     : /* output */ [cr0]"=r"(cr0));
+	return cr0;
+}
+
+static inline uint64_t get_cr3(void)
+{
+	uint64_t cr3;
+
+	__asm__ __volatile__("mov %%cr3, %[cr3]"
+			     : /* output */ [cr3]"=r"(cr3));
+	return cr3;
+}
+
+static inline uint64_t get_cr4(void)
+{
+	uint64_t cr4;
+
+	__asm__ __volatile__("mov %%cr4, %[cr4]"
+			     : /* output */ [cr4]"=r"(cr4));
+	return cr4;
+}
+
+static inline void set_cr4(uint64_t val)
+{
+	__asm__ __volatile__("mov %0, %%cr4" : : "r" (val) : "memory");
+}
+
+static inline uint64_t get_gdt_base(void)
+{
+	struct desc_ptr gdt;
+	__asm__ __volatile__("sgdt %[gdt]"
+			     : /* output */ [gdt]"=m"(gdt));
+	return gdt.address;
+}
+
+static inline uint64_t get_idt_base(void)
+{
+	struct desc_ptr idt;
+	__asm__ __volatile__("sidt %[idt]"
+			     : /* output */ [idt]"=m"(idt));
+	return idt.address;
+}
+
+#define SET_XMM(__var, __xmm) \
+	asm volatile("movq %0, %%"#__xmm : : "r"(__var) : #__xmm)
+
+static inline void set_xmm(int n, unsigned long val)
+{
+	switch (n) {
+	case 0:
+		SET_XMM(val, xmm0);
+		break;
+	case 1:
+		SET_XMM(val, xmm1);
+		break;
+	case 2:
+		SET_XMM(val, xmm2);
+		break;
+	case 3:
+		SET_XMM(val, xmm3);
+		break;
+	case 4:
+		SET_XMM(val, xmm4);
+		break;
+	case 5:
+		SET_XMM(val, xmm5);
+		break;
+	case 6:
+		SET_XMM(val, xmm6);
+		break;
+	case 7:
+		SET_XMM(val, xmm7);
+		break;
+	}
+}
+
+typedef unsigned long v1di __attribute__ ((vector_size (8)));
+static inline unsigned long get_xmm(int n)
+{
+	assert(n >= 0 && n <= 7);
+
+	register v1di xmm0 __asm__("%xmm0");
+	register v1di xmm1 __asm__("%xmm1");
+	register v1di xmm2 __asm__("%xmm2");
+	register v1di xmm3 __asm__("%xmm3");
+	register v1di xmm4 __asm__("%xmm4");
+	register v1di xmm5 __asm__("%xmm5");
+	register v1di xmm6 __asm__("%xmm6");
+	register v1di xmm7 __asm__("%xmm7");
+	switch (n) {
+	case 0:
+		return (unsigned long)xmm0;
+	case 1:
+		return (unsigned long)xmm1;
+	case 2:
+		return (unsigned long)xmm2;
+	case 3:
+		return (unsigned long)xmm3;
+	case 4:
+		return (unsigned long)xmm4;
+	case 5:
+		return (unsigned long)xmm5;
+	case 6:
+		return (unsigned long)xmm6;
+	case 7:
+		return (unsigned long)xmm7;
+	}
+	return 0;
+}
+
+/*
+ * Basic CPU control in CR0
+ */
+#define X86_CR0_PE          (1UL<<0) /* Protection Enable */
+#define X86_CR0_MP          (1UL<<1) /* Monitor Coprocessor */
+#define X86_CR0_EM          (1UL<<2) /* Emulation */
+#define X86_CR0_TS          (1UL<<3) /* Task Switched */
+#define X86_CR0_ET          (1UL<<4) /* Extension Type */
+#define X86_CR0_NE          (1UL<<5) /* Numeric Error */
+#define X86_CR0_WP          (1UL<<16) /* Write Protect */
+#define X86_CR0_AM          (1UL<<18) /* Alignment Mask */
+#define X86_CR0_NW          (1UL<<29) /* Not Write-through */
+#define X86_CR0_CD          (1UL<<30) /* Cache Disable */
+#define X86_CR0_PG          (1UL<<31) /* Paging */
+
+/*
+ * CPU model specific register (MSR) numbers.
+ */
+
+/* x86-64 specific MSRs */
+#define MSR_EFER		0xc0000080 /* extended feature register */
+#define MSR_STAR		0xc0000081 /* legacy mode SYSCALL target */
+#define MSR_LSTAR		0xc0000082 /* long mode SYSCALL target */
+#define MSR_CSTAR		0xc0000083 /* compat mode SYSCALL target */
+#define MSR_SYSCALL_MASK	0xc0000084 /* EFLAGS mask for syscall */
+#define MSR_FS_BASE		0xc0000100 /* 64bit FS base */
+#define MSR_GS_BASE		0xc0000101 /* 64bit GS base */
+#define MSR_KERNEL_GS_BASE	0xc0000102 /* SwapGS GS shadow */
+#define MSR_TSC_AUX		0xc0000103 /* Auxiliary TSC */
+
+/* EFER bits: */
+#define EFER_SCE		(1<<0)  /* SYSCALL/SYSRET */
+#define EFER_LME		(1<<8)  /* Long mode enable */
+#define EFER_LMA		(1<<10) /* Long mode active (read-only) */
+#define EFER_NX			(1<<11) /* No execute enable */
+#define EFER_SVME		(1<<12) /* Enable virtualization */
+#define EFER_LMSLE		(1<<13) /* Long Mode Segment Limit Enable */
+#define EFER_FFXSR		(1<<14) /* Enable Fast FXSAVE/FXRSTOR */
+
+/* Intel MSRs. Some also available on other CPUs */
+
+#define MSR_PPIN_CTL			0x0000004e
+#define MSR_PPIN			0x0000004f
+
+#define MSR_IA32_PERFCTR0		0x000000c1
+#define MSR_IA32_PERFCTR1		0x000000c2
+#define MSR_FSB_FREQ			0x000000cd
+#define MSR_PLATFORM_INFO		0x000000ce
+#define MSR_PLATFORM_INFO_CPUID_FAULT_BIT	31
+#define MSR_PLATFORM_INFO_CPUID_FAULT		BIT_ULL(MSR_PLATFORM_INFO_CPUID_FAULT_BIT)
+
+#define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
+#define NHM_C3_AUTO_DEMOTE		(1UL << 25)
+#define NHM_C1_AUTO_DEMOTE		(1UL << 26)
+#define ATM_LNC_C6_AUTO_DEMOTE		(1UL << 25)
+#define SNB_C1_AUTO_UNDEMOTE		(1UL << 27)
+#define SNB_C3_AUTO_UNDEMOTE		(1UL << 28)
+
+#define MSR_MTRRcap			0x000000fe
+#define MSR_IA32_BBL_CR_CTL		0x00000119
+#define MSR_IA32_BBL_CR_CTL3		0x0000011e
+
+#define MSR_IA32_SYSENTER_CS		0x00000174
+#define MSR_IA32_SYSENTER_ESP		0x00000175
+#define MSR_IA32_SYSENTER_EIP		0x00000176
+
+#define MSR_IA32_MCG_CAP		0x00000179
+#define MSR_IA32_MCG_STATUS		0x0000017a
+#define MSR_IA32_MCG_CTL		0x0000017b
+#define MSR_IA32_MCG_EXT_CTL		0x000004d0
+
+#define MSR_OFFCORE_RSP_0		0x000001a6
+#define MSR_OFFCORE_RSP_1		0x000001a7
+#define MSR_TURBO_RATIO_LIMIT		0x000001ad
+#define MSR_TURBO_RATIO_LIMIT1		0x000001ae
+#define MSR_TURBO_RATIO_LIMIT2		0x000001af
+
+#define MSR_LBR_SELECT			0x000001c8
+#define MSR_LBR_TOS			0x000001c9
+#define MSR_LBR_NHM_FROM		0x00000680
+#define MSR_LBR_NHM_TO			0x000006c0
+#define MSR_LBR_CORE_FROM		0x00000040
+#define MSR_LBR_CORE_TO			0x00000060
+
+#define MSR_LBR_INFO_0			0x00000dc0 /* ... 0xddf for _31 */
+#define LBR_INFO_MISPRED		BIT_ULL(63)
+#define LBR_INFO_IN_TX			BIT_ULL(62)
+#define LBR_INFO_ABORT			BIT_ULL(61)
+#define LBR_INFO_CYCLES			0xffff
+
+#define MSR_IA32_PEBS_ENABLE		0x000003f1
+#define MSR_IA32_DS_AREA		0x00000600
+#define MSR_IA32_PERF_CAPABILITIES	0x00000345
+#define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
+
+#define MSR_IA32_RTIT_CTL		0x00000570
+#define MSR_IA32_RTIT_STATUS		0x00000571
+#define MSR_IA32_RTIT_ADDR0_A		0x00000580
+#define MSR_IA32_RTIT_ADDR0_B		0x00000581
+#define MSR_IA32_RTIT_ADDR1_A		0x00000582
+#define MSR_IA32_RTIT_ADDR1_B		0x00000583
+#define MSR_IA32_RTIT_ADDR2_A		0x00000584
+#define MSR_IA32_RTIT_ADDR2_B		0x00000585
+#define MSR_IA32_RTIT_ADDR3_A		0x00000586
+#define MSR_IA32_RTIT_ADDR3_B		0x00000587
+#define MSR_IA32_RTIT_CR3_MATCH		0x00000572
+#define MSR_IA32_RTIT_OUTPUT_BASE	0x00000560
+#define MSR_IA32_RTIT_OUTPUT_MASK	0x00000561
+
+#define MSR_MTRRfix64K_00000		0x00000250
+#define MSR_MTRRfix16K_80000		0x00000258
+#define MSR_MTRRfix16K_A0000		0x00000259
+#define MSR_MTRRfix4K_C0000		0x00000268
+#define MSR_MTRRfix4K_C8000		0x00000269
+#define MSR_MTRRfix4K_D0000		0x0000026a
+#define MSR_MTRRfix4K_D8000		0x0000026b
+#define MSR_MTRRfix4K_E0000		0x0000026c
+#define MSR_MTRRfix4K_E8000		0x0000026d
+#define MSR_MTRRfix4K_F0000		0x0000026e
+#define MSR_MTRRfix4K_F8000		0x0000026f
+#define MSR_MTRRdefType			0x000002ff
+
+#define MSR_IA32_CR_PAT			0x00000277
+
+#define MSR_IA32_DEBUGCTLMSR		0x000001d9
+#define MSR_IA32_LASTBRANCHFROMIP	0x000001db
+#define MSR_IA32_LASTBRANCHTOIP		0x000001dc
+#define MSR_IA32_LASTINTFROMIP		0x000001dd
+#define MSR_IA32_LASTINTTOIP		0x000001de
+
+/* DEBUGCTLMSR bits (others vary by model): */
+#define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_BTF_SHIFT		1
+#define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
+#define DEBUGCTLMSR_TR			(1UL <<  6)
+#define DEBUGCTLMSR_BTS			(1UL <<  7)
+#define DEBUGCTLMSR_BTINT		(1UL <<  8)
+#define DEBUGCTLMSR_BTS_OFF_OS		(1UL <<  9)
+#define DEBUGCTLMSR_BTS_OFF_USR		(1UL << 10)
+#define DEBUGCTLMSR_FREEZE_LBRS_ON_PMI	(1UL << 11)
+#define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
+#define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+
+#define MSR_PEBS_FRONTEND		0x000003f7
+
+#define MSR_IA32_POWER_CTL		0x000001fc
+
+#define MSR_IA32_MC0_CTL		0x00000400
+#define MSR_IA32_MC0_STATUS		0x00000401
+#define MSR_IA32_MC0_ADDR		0x00000402
+#define MSR_IA32_MC0_MISC		0x00000403
+
+/* C-state Residency Counters */
+#define MSR_PKG_C3_RESIDENCY		0x000003f8
+#define MSR_PKG_C6_RESIDENCY		0x000003f9
+#define MSR_ATOM_PKG_C6_RESIDENCY	0x000003fa
+#define MSR_PKG_C7_RESIDENCY		0x000003fa
+#define MSR_CORE_C3_RESIDENCY		0x000003fc
+#define MSR_CORE_C6_RESIDENCY		0x000003fd
+#define MSR_CORE_C7_RESIDENCY		0x000003fe
+#define MSR_KNL_CORE_C6_RESIDENCY	0x000003ff
+#define MSR_PKG_C2_RESIDENCY		0x0000060d
+#define MSR_PKG_C8_RESIDENCY		0x00000630
+#define MSR_PKG_C9_RESIDENCY		0x00000631
+#define MSR_PKG_C10_RESIDENCY		0x00000632
+
+/* Interrupt Response Limit */
+#define MSR_PKGC3_IRTL			0x0000060a
+#define MSR_PKGC6_IRTL			0x0000060b
+#define MSR_PKGC7_IRTL			0x0000060c
+#define MSR_PKGC8_IRTL			0x00000633
+#define MSR_PKGC9_IRTL			0x00000634
+#define MSR_PKGC10_IRTL			0x00000635
+
+/* Run Time Average Power Limiting (RAPL) Interface */
+
+#define MSR_RAPL_POWER_UNIT		0x00000606
+
+#define MSR_PKG_POWER_LIMIT		0x00000610
+#define MSR_PKG_ENERGY_STATUS		0x00000611
+#define MSR_PKG_PERF_STATUS		0x00000613
+#define MSR_PKG_POWER_INFO		0x00000614
+
+#define MSR_DRAM_POWER_LIMIT		0x00000618
+#define MSR_DRAM_ENERGY_STATUS		0x00000619
+#define MSR_DRAM_PERF_STATUS		0x0000061b
+#define MSR_DRAM_POWER_INFO		0x0000061c
+
+#define MSR_PP0_POWER_LIMIT		0x00000638
+#define MSR_PP0_ENERGY_STATUS		0x00000639
+#define MSR_PP0_POLICY			0x0000063a
+#define MSR_PP0_PERF_STATUS		0x0000063b
+
+#define MSR_PP1_POWER_LIMIT		0x00000640
+#define MSR_PP1_ENERGY_STATUS		0x00000641
+#define MSR_PP1_POLICY			0x00000642
+
+/* Config TDP MSRs */
+#define MSR_CONFIG_TDP_NOMINAL		0x00000648
+#define MSR_CONFIG_TDP_LEVEL_1		0x00000649
+#define MSR_CONFIG_TDP_LEVEL_2		0x0000064A
+#define MSR_CONFIG_TDP_CONTROL		0x0000064B
+#define MSR_TURBO_ACTIVATION_RATIO	0x0000064C
+
+#define MSR_PLATFORM_ENERGY_STATUS	0x0000064D
+
+#define MSR_PKG_WEIGHTED_CORE_C0_RES	0x00000658
+#define MSR_PKG_ANY_CORE_C0_RES		0x00000659
+#define MSR_PKG_ANY_GFXE_C0_RES		0x0000065A
+#define MSR_PKG_BOTH_CORE_GFXE_C0_RES	0x0000065B
+
+#define MSR_CORE_C1_RES			0x00000660
+#define MSR_MODULE_C6_RES_MS		0x00000664
+
+#define MSR_CC6_DEMOTION_POLICY_CONFIG	0x00000668
+#define MSR_MC6_DEMOTION_POLICY_CONFIG	0x00000669
+
+#define MSR_ATOM_CORE_RATIOS		0x0000066a
+#define MSR_ATOM_CORE_VIDS		0x0000066b
+#define MSR_ATOM_CORE_TURBO_RATIOS	0x0000066c
+#define MSR_ATOM_CORE_TURBO_VIDS	0x0000066d
+
+
+#define MSR_CORE_PERF_LIMIT_REASONS	0x00000690
+#define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
+#define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
+
+/* Hardware P state interface */
+#define MSR_PPERF			0x0000064e
+#define MSR_PERF_LIMIT_REASONS		0x0000064f
+#define MSR_PM_ENABLE			0x00000770
+#define MSR_HWP_CAPABILITIES		0x00000771
+#define MSR_HWP_REQUEST_PKG		0x00000772
+#define MSR_HWP_INTERRUPT		0x00000773
+#define MSR_HWP_REQUEST			0x00000774
+#define MSR_HWP_STATUS			0x00000777
+
+/* CPUID.6.EAX */
+#define HWP_BASE_BIT			(1<<7)
+#define HWP_NOTIFICATIONS_BIT		(1<<8)
+#define HWP_ACTIVITY_WINDOW_BIT		(1<<9)
+#define HWP_ENERGY_PERF_PREFERENCE_BIT	(1<<10)
+#define HWP_PACKAGE_LEVEL_REQUEST_BIT	(1<<11)
+
+/* IA32_HWP_CAPABILITIES */
+#define HWP_HIGHEST_PERF(x)		(((x) >> 0) & 0xff)
+#define HWP_GUARANTEED_PERF(x)		(((x) >> 8) & 0xff)
+#define HWP_MOSTEFFICIENT_PERF(x)	(((x) >> 16) & 0xff)
+#define HWP_LOWEST_PERF(x)		(((x) >> 24) & 0xff)
+
+/* IA32_HWP_REQUEST */
+#define HWP_MIN_PERF(x)			(x & 0xff)
+#define HWP_MAX_PERF(x)			((x & 0xff) << 8)
+#define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
+#define HWP_ENERGY_PERF_PREFERENCE(x)	(((unsigned long long) x & 0xff) << 24)
+#define HWP_EPP_PERFORMANCE		0x00
+#define HWP_EPP_BALANCE_PERFORMANCE	0x80
+#define HWP_EPP_BALANCE_POWERSAVE	0xC0
+#define HWP_EPP_POWERSAVE		0xFF
+#define HWP_ACTIVITY_WINDOW(x)		((unsigned long long)(x & 0xff3) << 32)
+#define HWP_PACKAGE_CONTROL(x)		((unsigned long long)(x & 0x1) << 42)
+
+/* IA32_HWP_STATUS */
+#define HWP_GUARANTEED_CHANGE(x)	(x & 0x1)
+#define HWP_EXCURSION_TO_MINIMUM(x)	(x & 0x4)
+
+/* IA32_HWP_INTERRUPT */
+#define HWP_CHANGE_TO_GUARANTEED_INT(x)	(x & 0x1)
+#define HWP_EXCURSION_TO_MINIMUM_INT(x)	(x & 0x2)
+
+#define MSR_AMD64_MC0_MASK		0xc0010044
+
+#define MSR_IA32_MCx_CTL(x)		(MSR_IA32_MC0_CTL + 4*(x))
+#define MSR_IA32_MCx_STATUS(x)		(MSR_IA32_MC0_STATUS + 4*(x))
+#define MSR_IA32_MCx_ADDR(x)		(MSR_IA32_MC0_ADDR + 4*(x))
+#define MSR_IA32_MCx_MISC(x)		(MSR_IA32_MC0_MISC + 4*(x))
+
+#define MSR_AMD64_MCx_MASK(x)		(MSR_AMD64_MC0_MASK + (x))
+
+/* These are consecutive and not in the normal 4er MCE bank block */
+#define MSR_IA32_MC0_CTL2		0x00000280
+#define MSR_IA32_MCx_CTL2(x)		(MSR_IA32_MC0_CTL2 + (x))
+
+#define MSR_P6_PERFCTR0			0x000000c1
+#define MSR_P6_PERFCTR1			0x000000c2
+#define MSR_P6_EVNTSEL0			0x00000186
+#define MSR_P6_EVNTSEL1			0x00000187
+
+#define MSR_KNC_PERFCTR0               0x00000020
+#define MSR_KNC_PERFCTR1               0x00000021
+#define MSR_KNC_EVNTSEL0               0x00000028
+#define MSR_KNC_EVNTSEL1               0x00000029
+
+/* Alternative perfctr range with full access. */
+#define MSR_IA32_PMC0			0x000004c1
+
+/* AMD64 MSRs. Not complete. See the architecture manual for a more
+   complete list. */
+
+#define MSR_AMD64_PATCH_LEVEL		0x0000008b
+#define MSR_AMD64_TSC_RATIO		0xc0000104
+#define MSR_AMD64_NB_CFG		0xc001001f
+#define MSR_AMD64_PATCH_LOADER		0xc0010020
+#define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
+#define MSR_AMD64_OSVW_STATUS		0xc0010141
+#define MSR_AMD64_LS_CFG		0xc0011020
+#define MSR_AMD64_DC_CFG		0xc0011022
+#define MSR_AMD64_BU_CFG2		0xc001102a
+#define MSR_AMD64_IBSFETCHCTL		0xc0011030
+#define MSR_AMD64_IBSFETCHLINAD		0xc0011031
+#define MSR_AMD64_IBSFETCHPHYSAD	0xc0011032
+#define MSR_AMD64_IBSFETCH_REG_COUNT	3
+#define MSR_AMD64_IBSFETCH_REG_MASK	((1UL<<MSR_AMD64_IBSFETCH_REG_COUNT)-1)
+#define MSR_AMD64_IBSOPCTL		0xc0011033
+#define MSR_AMD64_IBSOPRIP		0xc0011034
+#define MSR_AMD64_IBSOPDATA		0xc0011035
+#define MSR_AMD64_IBSOPDATA2		0xc0011036
+#define MSR_AMD64_IBSOPDATA3		0xc0011037
+#define MSR_AMD64_IBSDCLINAD		0xc0011038
+#define MSR_AMD64_IBSDCPHYSAD		0xc0011039
+#define MSR_AMD64_IBSOP_REG_COUNT	7
+#define MSR_AMD64_IBSOP_REG_MASK	((1UL<<MSR_AMD64_IBSOP_REG_COUNT)-1)
+#define MSR_AMD64_IBSCTL		0xc001103a
+#define MSR_AMD64_IBSBRTARGET		0xc001103b
+#define MSR_AMD64_IBSOPDATA4		0xc001103d
+#define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
+#define MSR_AMD64_SEV			0xc0010131
+#define MSR_AMD64_SEV_ENABLED_BIT	0
+#define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
+
+/* Fam 17h MSRs */
+#define MSR_F17H_IRPERF			0xc00000e9
+
+/* Fam 16h MSRs */
+#define MSR_F16H_L2I_PERF_CTL		0xc0010230
+#define MSR_F16H_L2I_PERF_CTR		0xc0010231
+#define MSR_F16H_DR1_ADDR_MASK		0xc0011019
+#define MSR_F16H_DR2_ADDR_MASK		0xc001101a
+#define MSR_F16H_DR3_ADDR_MASK		0xc001101b
+#define MSR_F16H_DR0_ADDR_MASK		0xc0011027
+
+/* Fam 15h MSRs */
+#define MSR_F15H_PERF_CTL		0xc0010200
+#define MSR_F15H_PERF_CTR		0xc0010201
+#define MSR_F15H_NB_PERF_CTL		0xc0010240
+#define MSR_F15H_NB_PERF_CTR		0xc0010241
+#define MSR_F15H_PTSC			0xc0010280
+#define MSR_F15H_IC_CFG			0xc0011021
+
+/* Fam 10h MSRs */
+#define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
+#define FAM10H_MMIO_CONF_ENABLE		(1<<0)
+#define FAM10H_MMIO_CONF_BUSRANGE_MASK	0xf
+#define FAM10H_MMIO_CONF_BUSRANGE_SHIFT 2
+#define FAM10H_MMIO_CONF_BASE_MASK	0xfffffffULL
+#define FAM10H_MMIO_CONF_BASE_SHIFT	20
+#define MSR_FAM10H_NODE_ID		0xc001100c
+#define MSR_F10H_DECFG			0xc0011029
+#define MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT	1
+#define MSR_F10H_DECFG_LFENCE_SERIALIZE		BIT_ULL(MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT)
+
+/* K8 MSRs */
+#define MSR_K8_TOP_MEM1			0xc001001a
+#define MSR_K8_TOP_MEM2			0xc001001d
+#define MSR_K8_SYSCFG			0xc0010010
+#define MSR_K8_SYSCFG_MEM_ENCRYPT_BIT	23
+#define MSR_K8_SYSCFG_MEM_ENCRYPT	BIT_ULL(MSR_K8_SYSCFG_MEM_ENCRYPT_BIT)
+#define MSR_K8_INT_PENDING_MSG		0xc0010055
+/* C1E active bits in int pending message */
+#define K8_INTP_C1E_ACTIVE_MASK		0x18000000
+#define MSR_K8_TSEG_ADDR		0xc0010112
+#define MSR_K8_TSEG_MASK		0xc0010113
+#define K8_MTRRFIXRANGE_DRAM_ENABLE	0x00040000 /* MtrrFixDramEn bit    */
+#define K8_MTRRFIXRANGE_DRAM_MODIFY	0x00080000 /* MtrrFixDramModEn bit */
+#define K8_MTRR_RDMEM_WRMEM_MASK	0x18181818 /* Mask: RdMem|WrMem    */
+
+/* K7 MSRs */
+#define MSR_K7_EVNTSEL0			0xc0010000
+#define MSR_K7_PERFCTR0			0xc0010004
+#define MSR_K7_EVNTSEL1			0xc0010001
+#define MSR_K7_PERFCTR1			0xc0010005
+#define MSR_K7_EVNTSEL2			0xc0010002
+#define MSR_K7_PERFCTR2			0xc0010006
+#define MSR_K7_EVNTSEL3			0xc0010003
+#define MSR_K7_PERFCTR3			0xc0010007
+#define MSR_K7_CLK_CTL			0xc001001b
+#define MSR_K7_HWCR			0xc0010015
+#define MSR_K7_HWCR_SMMLOCK_BIT		0
+#define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
+#define MSR_K7_FID_VID_CTL		0xc0010041
+#define MSR_K7_FID_VID_STATUS		0xc0010042
+
+/* K6 MSRs */
+#define MSR_K6_WHCR			0xc0000082
+#define MSR_K6_UWCCR			0xc0000085
+#define MSR_K6_EPMR			0xc0000086
+#define MSR_K6_PSOR			0xc0000087
+#define MSR_K6_PFIR			0xc0000088
+
+/* Centaur-Hauls/IDT defined MSRs. */
+#define MSR_IDT_FCR1			0x00000107
+#define MSR_IDT_FCR2			0x00000108
+#define MSR_IDT_FCR3			0x00000109
+#define MSR_IDT_FCR4			0x0000010a
+
+#define MSR_IDT_MCR0			0x00000110
+#define MSR_IDT_MCR1			0x00000111
+#define MSR_IDT_MCR2			0x00000112
+#define MSR_IDT_MCR3			0x00000113
+#define MSR_IDT_MCR4			0x00000114
+#define MSR_IDT_MCR5			0x00000115
+#define MSR_IDT_MCR6			0x00000116
+#define MSR_IDT_MCR7			0x00000117
+#define MSR_IDT_MCR_CTRL		0x00000120
+
+/* VIA Cyrix defined MSRs*/
+#define MSR_VIA_FCR			0x00001107
+#define MSR_VIA_LONGHAUL		0x0000110a
+#define MSR_VIA_RNG			0x0000110b
+#define MSR_VIA_BCR2			0x00001147
+
+/* Transmeta defined MSRs */
+#define MSR_TMTA_LONGRUN_CTRL		0x80868010
+#define MSR_TMTA_LONGRUN_FLAGS		0x80868011
+#define MSR_TMTA_LRTI_READOUT		0x80868018
+#define MSR_TMTA_LRTI_VOLT_MHZ		0x8086801a
+
+/* Intel defined MSRs. */
+#define MSR_IA32_P5_MC_ADDR		0x00000000
+#define MSR_IA32_P5_MC_TYPE		0x00000001
+#define MSR_IA32_TSC			0x00000010
+#define MSR_IA32_PLATFORM_ID		0x00000017
+#define MSR_IA32_EBL_CR_POWERON		0x0000002a
+#define MSR_EBC_FREQUENCY_ID		0x0000002c
+#define MSR_SMI_COUNT			0x00000034
+#define MSR_IA32_FEATURE_CONTROL        0x0000003a
+#define MSR_IA32_TSC_ADJUST             0x0000003b
+#define MSR_IA32_BNDCFGS		0x00000d90
+
+#define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
+
+#define MSR_IA32_XSS			0x00000da0
+
+#define FEATURE_CONTROL_LOCKED				(1<<0)
+#define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
+#define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
+#define FEATURE_CONTROL_LMCE				(1<<20)
+
+#define MSR_IA32_APICBASE		0x0000001b
+#define MSR_IA32_APICBASE_BSP		(1<<8)
+#define MSR_IA32_APICBASE_ENABLE	(1<<11)
+#define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
+
+#define MSR_IA32_TSCDEADLINE		0x000006e0
+
+#define MSR_IA32_UCODE_WRITE		0x00000079
+#define MSR_IA32_UCODE_REV		0x0000008b
+
+#define MSR_IA32_SMM_MONITOR_CTL	0x0000009b
+#define MSR_IA32_SMBASE			0x0000009e
+
+#define MSR_IA32_PERF_STATUS		0x00000198
+#define MSR_IA32_PERF_CTL		0x00000199
+#define INTEL_PERF_CTL_MASK		0xffff
+#define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
+#define MSR_AMD_PERF_STATUS		0xc0010063
+#define MSR_AMD_PERF_CTL		0xc0010062
+
+#define MSR_IA32_MPERF			0x000000e7
+#define MSR_IA32_APERF			0x000000e8
+
+#define MSR_IA32_THERM_CONTROL		0x0000019a
+#define MSR_IA32_THERM_INTERRUPT	0x0000019b
+
+#define THERM_INT_HIGH_ENABLE		(1 << 0)
+#define THERM_INT_LOW_ENABLE		(1 << 1)
+#define THERM_INT_PLN_ENABLE		(1 << 24)
+
+#define MSR_IA32_THERM_STATUS		0x0000019c
+
+#define THERM_STATUS_PROCHOT		(1 << 0)
+#define THERM_STATUS_POWER_LIMIT	(1 << 10)
+
+#define MSR_THERM2_CTL			0x0000019d
+
+#define MSR_THERM2_CTL_TM_SELECT	(1ULL << 16)
+
+#define MSR_IA32_MISC_ENABLE		0x000001a0
+
+#define MSR_IA32_TEMPERATURE_TARGET	0x000001a2
+
+#define MSR_MISC_FEATURE_CONTROL	0x000001a4
+#define MSR_MISC_PWR_MGMT		0x000001aa
+
+#define MSR_IA32_ENERGY_PERF_BIAS	0x000001b0
+#define ENERGY_PERF_BIAS_PERFORMANCE		0
+#define ENERGY_PERF_BIAS_BALANCE_PERFORMANCE	4
+#define ENERGY_PERF_BIAS_NORMAL			6
+#define ENERGY_PERF_BIAS_BALANCE_POWERSAVE	8
+#define ENERGY_PERF_BIAS_POWERSAVE		15
+
+#define MSR_IA32_PACKAGE_THERM_STATUS		0x000001b1
+
+#define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
+#define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
+
+#define MSR_IA32_PACKAGE_THERM_INTERRUPT	0x000001b2
+
+#define PACKAGE_THERM_INT_HIGH_ENABLE		(1 << 0)
+#define PACKAGE_THERM_INT_LOW_ENABLE		(1 << 1)
+#define PACKAGE_THERM_INT_PLN_ENABLE		(1 << 24)
+
+/* Thermal Thresholds Support */
+#define THERM_INT_THRESHOLD0_ENABLE    (1 << 15)
+#define THERM_SHIFT_THRESHOLD0        8
+#define THERM_MASK_THRESHOLD0          (0x7f << THERM_SHIFT_THRESHOLD0)
+#define THERM_INT_THRESHOLD1_ENABLE    (1 << 23)
+#define THERM_SHIFT_THRESHOLD1        16
+#define THERM_MASK_THRESHOLD1          (0x7f << THERM_SHIFT_THRESHOLD1)
+#define THERM_STATUS_THRESHOLD0        (1 << 6)
+#define THERM_LOG_THRESHOLD0           (1 << 7)
+#define THERM_STATUS_THRESHOLD1        (1 << 8)
+#define THERM_LOG_THRESHOLD1           (1 << 9)
+
+/* MISC_ENABLE bits: architectural */
+#define MSR_IA32_MISC_ENABLE_FAST_STRING_BIT		0
+#define MSR_IA32_MISC_ENABLE_FAST_STRING		(1ULL << MSR_IA32_MISC_ENABLE_FAST_STRING_BIT)
+#define MSR_IA32_MISC_ENABLE_TCC_BIT			1
+#define MSR_IA32_MISC_ENABLE_TCC			(1ULL << MSR_IA32_MISC_ENABLE_TCC_BIT)
+#define MSR_IA32_MISC_ENABLE_EMON_BIT			7
+#define MSR_IA32_MISC_ENABLE_EMON			(1ULL << MSR_IA32_MISC_ENABLE_EMON_BIT)
+#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL_BIT		11
+#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL		(1ULL << MSR_IA32_MISC_ENABLE_BTS_UNAVAIL_BIT)
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL_BIT		12
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL		(1ULL << MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL_BIT)
+#define MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP_BIT	16
+#define MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP		(1ULL << MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP_BIT)
+#define MSR_IA32_MISC_ENABLE_MWAIT_BIT			18
+#define MSR_IA32_MISC_ENABLE_MWAIT			(1ULL << MSR_IA32_MISC_ENABLE_MWAIT_BIT)
+#define MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT		22
+#define MSR_IA32_MISC_ENABLE_LIMIT_CPUID		(1ULL << MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT)
+#define MSR_IA32_MISC_ENABLE_XTPR_DISABLE_BIT		23
+#define MSR_IA32_MISC_ENABLE_XTPR_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_XTPR_DISABLE_BIT)
+#define MSR_IA32_MISC_ENABLE_XD_DISABLE_BIT		34
+#define MSR_IA32_MISC_ENABLE_XD_DISABLE			(1ULL << MSR_IA32_MISC_ENABLE_XD_DISABLE_BIT)
+
+/* MISC_ENABLE bits: model-specific, meaning may vary from core to core */
+#define MSR_IA32_MISC_ENABLE_X87_COMPAT_BIT		2
+#define MSR_IA32_MISC_ENABLE_X87_COMPAT			(1ULL << MSR_IA32_MISC_ENABLE_X87_COMPAT_BIT)
+#define MSR_IA32_MISC_ENABLE_TM1_BIT			3
+#define MSR_IA32_MISC_ENABLE_TM1			(1ULL << MSR_IA32_MISC_ENABLE_TM1_BIT)
+#define MSR_IA32_MISC_ENABLE_SPLIT_LOCK_DISABLE_BIT	4
+#define MSR_IA32_MISC_ENABLE_SPLIT_LOCK_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_SPLIT_LOCK_DISABLE_BIT)
+#define MSR_IA32_MISC_ENABLE_L3CACHE_DISABLE_BIT	6
+#define MSR_IA32_MISC_ENABLE_L3CACHE_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_L3CACHE_DISABLE_BIT)
+#define MSR_IA32_MISC_ENABLE_SUPPRESS_LOCK_BIT		8
+#define MSR_IA32_MISC_ENABLE_SUPPRESS_LOCK		(1ULL << MSR_IA32_MISC_ENABLE_SUPPRESS_LOCK_BIT)
+#define MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE_BIT	9
+#define MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE_BIT)
+#define MSR_IA32_MISC_ENABLE_FERR_BIT			10
+#define MSR_IA32_MISC_ENABLE_FERR			(1ULL << MSR_IA32_MISC_ENABLE_FERR_BIT)
+#define MSR_IA32_MISC_ENABLE_FERR_MULTIPLEX_BIT		10
+#define MSR_IA32_MISC_ENABLE_FERR_MULTIPLEX		(1ULL << MSR_IA32_MISC_ENABLE_FERR_MULTIPLEX_BIT)
+#define MSR_IA32_MISC_ENABLE_TM2_BIT			13
+#define MSR_IA32_MISC_ENABLE_TM2			(1ULL << MSR_IA32_MISC_ENABLE_TM2_BIT)
+#define MSR_IA32_MISC_ENABLE_ADJ_PREF_DISABLE_BIT	19
+#define MSR_IA32_MISC_ENABLE_ADJ_PREF_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_ADJ_PREF_DISABLE_BIT)
+#define MSR_IA32_MISC_ENABLE_SPEEDSTEP_LOCK_BIT		20
+#define MSR_IA32_MISC_ENABLE_SPEEDSTEP_LOCK		(1ULL << MSR_IA32_MISC_ENABLE_SPEEDSTEP_LOCK_BIT)
+#define MSR_IA32_MISC_ENABLE_L1D_CONTEXT_BIT		24
+#define MSR_IA32_MISC_ENABLE_L1D_CONTEXT		(1ULL << MSR_IA32_MISC_ENABLE_L1D_CONTEXT_BIT)
+#define MSR_IA32_MISC_ENABLE_DCU_PREF_DISABLE_BIT	37
+#define MSR_IA32_MISC_ENABLE_DCU_PREF_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_DCU_PREF_DISABLE_BIT)
+#define MSR_IA32_MISC_ENABLE_TURBO_DISABLE_BIT		38
+#define MSR_IA32_MISC_ENABLE_TURBO_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_TURBO_DISABLE_BIT)
+#define MSR_IA32_MISC_ENABLE_IP_PREF_DISABLE_BIT	39
+#define MSR_IA32_MISC_ENABLE_IP_PREF_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_IP_PREF_DISABLE_BIT)
+
+/* MISC_FEATURES_ENABLES non-architectural features */
+#define MSR_MISC_FEATURES_ENABLES	0x00000140
+
+#define MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT	0
+#define MSR_MISC_FEATURES_ENABLES_CPUID_FAULT		BIT_ULL(MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT)
+#define MSR_MISC_FEATURES_ENABLES_RING3MWAIT_BIT	1
+
+#define MSR_IA32_TSC_DEADLINE		0x000006E0
+
+/* P4/Xeon+ specific */
+#define MSR_IA32_MCG_EAX		0x00000180
+#define MSR_IA32_MCG_EBX		0x00000181
+#define MSR_IA32_MCG_ECX		0x00000182
+#define MSR_IA32_MCG_EDX		0x00000183
+#define MSR_IA32_MCG_ESI		0x00000184
+#define MSR_IA32_MCG_EDI		0x00000185
+#define MSR_IA32_MCG_EBP		0x00000186
+#define MSR_IA32_MCG_ESP		0x00000187
+#define MSR_IA32_MCG_EFLAGS		0x00000188
+#define MSR_IA32_MCG_EIP		0x00000189
+#define MSR_IA32_MCG_RESERVED		0x0000018a
+
+/* Pentium IV performance counter MSRs */
+#define MSR_P4_BPU_PERFCTR0		0x00000300
+#define MSR_P4_BPU_PERFCTR1		0x00000301
+#define MSR_P4_BPU_PERFCTR2		0x00000302
+#define MSR_P4_BPU_PERFCTR3		0x00000303
+#define MSR_P4_MS_PERFCTR0		0x00000304
+#define MSR_P4_MS_PERFCTR1		0x00000305
+#define MSR_P4_MS_PERFCTR2		0x00000306
+#define MSR_P4_MS_PERFCTR3		0x00000307
+#define MSR_P4_FLAME_PERFCTR0		0x00000308
+#define MSR_P4_FLAME_PERFCTR1		0x00000309
+#define MSR_P4_FLAME_PERFCTR2		0x0000030a
+#define MSR_P4_FLAME_PERFCTR3		0x0000030b
+#define MSR_P4_IQ_PERFCTR0		0x0000030c
+#define MSR_P4_IQ_PERFCTR1		0x0000030d
+#define MSR_P4_IQ_PERFCTR2		0x0000030e
+#define MSR_P4_IQ_PERFCTR3		0x0000030f
+#define MSR_P4_IQ_PERFCTR4		0x00000310
+#define MSR_P4_IQ_PERFCTR5		0x00000311
+#define MSR_P4_BPU_CCCR0		0x00000360
+#define MSR_P4_BPU_CCCR1		0x00000361
+#define MSR_P4_BPU_CCCR2		0x00000362
+#define MSR_P4_BPU_CCCR3		0x00000363
+#define MSR_P4_MS_CCCR0			0x00000364
+#define MSR_P4_MS_CCCR1			0x00000365
+#define MSR_P4_MS_CCCR2			0x00000366
+#define MSR_P4_MS_CCCR3			0x00000367
+#define MSR_P4_FLAME_CCCR0		0x00000368
+#define MSR_P4_FLAME_CCCR1		0x00000369
+#define MSR_P4_FLAME_CCCR2		0x0000036a
+#define MSR_P4_FLAME_CCCR3		0x0000036b
+#define MSR_P4_IQ_CCCR0			0x0000036c
+#define MSR_P4_IQ_CCCR1			0x0000036d
+#define MSR_P4_IQ_CCCR2			0x0000036e
+#define MSR_P4_IQ_CCCR3			0x0000036f
+#define MSR_P4_IQ_CCCR4			0x00000370
+#define MSR_P4_IQ_CCCR5			0x00000371
+#define MSR_P4_ALF_ESCR0		0x000003ca
+#define MSR_P4_ALF_ESCR1		0x000003cb
+#define MSR_P4_BPU_ESCR0		0x000003b2
+#define MSR_P4_BPU_ESCR1		0x000003b3
+#define MSR_P4_BSU_ESCR0		0x000003a0
+#define MSR_P4_BSU_ESCR1		0x000003a1
+#define MSR_P4_CRU_ESCR0		0x000003b8
+#define MSR_P4_CRU_ESCR1		0x000003b9
+#define MSR_P4_CRU_ESCR2		0x000003cc
+#define MSR_P4_CRU_ESCR3		0x000003cd
+#define MSR_P4_CRU_ESCR4		0x000003e0
+#define MSR_P4_CRU_ESCR5		0x000003e1
+#define MSR_P4_DAC_ESCR0		0x000003a8
+#define MSR_P4_DAC_ESCR1		0x000003a9
+#define MSR_P4_FIRM_ESCR0		0x000003a4
+#define MSR_P4_FIRM_ESCR1		0x000003a5
+#define MSR_P4_FLAME_ESCR0		0x000003a6
+#define MSR_P4_FLAME_ESCR1		0x000003a7
+#define MSR_P4_FSB_ESCR0		0x000003a2
+#define MSR_P4_FSB_ESCR1		0x000003a3
+#define MSR_P4_IQ_ESCR0			0x000003ba
+#define MSR_P4_IQ_ESCR1			0x000003bb
+#define MSR_P4_IS_ESCR0			0x000003b4
+#define MSR_P4_IS_ESCR1			0x000003b5
+#define MSR_P4_ITLB_ESCR0		0x000003b6
+#define MSR_P4_ITLB_ESCR1		0x000003b7
+#define MSR_P4_IX_ESCR0			0x000003c8
+#define MSR_P4_IX_ESCR1			0x000003c9
+#define MSR_P4_MOB_ESCR0		0x000003aa
+#define MSR_P4_MOB_ESCR1		0x000003ab
+#define MSR_P4_MS_ESCR0			0x000003c0
+#define MSR_P4_MS_ESCR1			0x000003c1
+#define MSR_P4_PMH_ESCR0		0x000003ac
+#define MSR_P4_PMH_ESCR1		0x000003ad
+#define MSR_P4_RAT_ESCR0		0x000003bc
+#define MSR_P4_RAT_ESCR1		0x000003bd
+#define MSR_P4_SAAT_ESCR0		0x000003ae
+#define MSR_P4_SAAT_ESCR1		0x000003af
+#define MSR_P4_SSU_ESCR0		0x000003be
+#define MSR_P4_SSU_ESCR1		0x000003bf /* guess: not in manual */
+
+#define MSR_P4_TBPU_ESCR0		0x000003c2
+#define MSR_P4_TBPU_ESCR1		0x000003c3
+#define MSR_P4_TC_ESCR0			0x000003c4
+#define MSR_P4_TC_ESCR1			0x000003c5
+#define MSR_P4_U2L_ESCR0		0x000003b0
+#define MSR_P4_U2L_ESCR1		0x000003b1
+
+#define MSR_P4_PEBS_MATRIX_VERT		0x000003f2
+
+/* Intel Core-based CPU performance counters */
+#define MSR_CORE_PERF_FIXED_CTR0	0x00000309
+#define MSR_CORE_PERF_FIXED_CTR1	0x0000030a
+#define MSR_CORE_PERF_FIXED_CTR2	0x0000030b
+#define MSR_CORE_PERF_FIXED_CTR_CTRL	0x0000038d
+#define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
+#define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
+
+/* Geode defined MSRs */
+#define MSR_GEODE_BUSCONT_CONF0		0x00001900
+
+/* Intel VT MSRs */
+#define MSR_IA32_VMX_BASIC              0x00000480
+#define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
+#define MSR_IA32_VMX_PROCBASED_CTLS     0x00000482
+#define MSR_IA32_VMX_EXIT_CTLS          0x00000483
+#define MSR_IA32_VMX_ENTRY_CTLS         0x00000484
+#define MSR_IA32_VMX_MISC               0x00000485
+#define MSR_IA32_VMX_CR0_FIXED0         0x00000486
+#define MSR_IA32_VMX_CR0_FIXED1         0x00000487
+#define MSR_IA32_VMX_CR4_FIXED0         0x00000488
+#define MSR_IA32_VMX_CR4_FIXED1         0x00000489
+#define MSR_IA32_VMX_VMCS_ENUM          0x0000048a
+#define MSR_IA32_VMX_PROCBASED_CTLS2    0x0000048b
+#define MSR_IA32_VMX_EPT_VPID_CAP       0x0000048c
+#define MSR_IA32_VMX_TRUE_PINBASED_CTLS  0x0000048d
+#define MSR_IA32_VMX_TRUE_PROCBASED_CTLS 0x0000048e
+#define MSR_IA32_VMX_TRUE_EXIT_CTLS      0x0000048f
+#define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
+#define MSR_IA32_VMX_VMFUNC             0x00000491
+
+/* VMX_BASIC bits and bitmasks */
+#define VMX_BASIC_VMCS_SIZE_SHIFT	32
+#define VMX_BASIC_TRUE_CTLS		(1ULL << 55)
+#define VMX_BASIC_64		0x0001000000000000LLU
+#define VMX_BASIC_MEM_TYPE_SHIFT	50
+#define VMX_BASIC_MEM_TYPE_MASK	0x003c000000000000LLU
+#define VMX_BASIC_MEM_TYPE_WB	6LLU
+#define VMX_BASIC_INOUT		0x0040000000000000LLU
+
+/* MSR_IA32_VMX_MISC bits */
+#define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
+#define MSR_IA32_VMX_MISC_PREEMPTION_TIMER_SCALE   0x1F
+/* AMD-V MSRs */
+
+#define MSR_VM_CR                       0xc0010114
+#define MSR_VM_IGNNE                    0xc0010115
+#define MSR_VM_HSAVE_PA                 0xc0010117
+
+#endif /* !SELFTEST_KVM_X86_H */
diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
new file mode 100644
index 000000000000..0b19a9ac5785
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -0,0 +1,87 @@
+/*
+ * tools/testing/selftests/kvm/lib/assert.c
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ */
+
+#define _GNU_SOURCE /* for getline(3) and strchrnul(3)*/
+
+#include "test_util.h"
+
+#include <execinfo.h>
+#include <sys/syscall.h>
+
+/* Dumps the current stack trace to stderr. */
+static void __attribute__((noinline)) test_dump_stack(void);
+static void test_dump_stack(void)
+{
+	/*
+	 * Build and run this command:
+	 *
+	 *	addr2line -s -e /proc/$PPID/exe -fpai {backtrace addresses} | \
+	 *		grep -v test_dump_stack | cat -n 1>&2
+	 *
+	 * Note that the spacing is different and there's no newline.
+	 */
+	size_t i;
+	size_t n = 20;
+	void *stack[n];
+	const char *addr2line = "addr2line -s -e /proc/$PPID/exe -fpai";
+	const char *pipeline = "|cat -n 1>&2";
+	char cmd[strlen(addr2line) + strlen(pipeline) +
+		 /* N bytes per addr * 2 digits per byte + 1 space per addr: */
+		 n * (((sizeof(void *)) * 2) + 1) +
+		 /* Null terminator: */
+		 1];
+	char *c;
+
+	n = backtrace(stack, n);
+	c = &cmd[0];
+	c += sprintf(c, "%s", addr2line);
+	/*
+	 * Skip the first 3 frames: backtrace, test_dump_stack, and
+	 * test_assert. We hope that backtrace isn't inlined and the other two
+	 * we've declared noinline.
+	 */
+	for (i = 2; i < n; i++)
+		c += sprintf(c, " %lx", ((unsigned long) stack[i]) - 1);
+	c += sprintf(c, "%s", pipeline);
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-result"
+	system(cmd);
+#pragma GCC diagnostic pop
+}
+
+static pid_t gettid(void)
+{
+	return syscall(SYS_gettid);
+}
+
+void __attribute__((noinline))
+test_assert(bool exp, const char *exp_str,
+	const char *file, unsigned int line, const char *fmt, ...)
+{
+	va_list ap;
+
+	if (!(exp)) {
+		va_start(ap, fmt);
+
+		fprintf(stderr, "==== Test Assertion Failure ====\n"
+			"  %s:%u: %s\n"
+			"  pid=%d tid=%d\n",
+			file, line, exp_str, getpid(), gettid());
+		test_dump_stack();
+		if (fmt) {
+			fputs("  ", stderr);
+			vfprintf(stderr, fmt, ap);
+			fputs("\n", stderr);
+		}
+		va_end(ap);
+
+		exit(254);
+	}
+
+	return;
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
new file mode 100644
index 000000000000..5558969c0b33
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -0,0 +1,1480 @@
+/*
+ * tools/testing/selftests/kvm/lib/kvm_util.c
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "kvm_util_internal.h"
+
+#include <assert.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#define KVM_DEV_PATH "/dev/kvm"
+
+#define KVM_UTIL_PGS_PER_HUGEPG 512
+#define KVM_UTIL_MIN_PADDR      0x2000
+
+/* Aligns x up to the next multiple of size. Size must be a power of 2. */
+static void *align(void *x, size_t size)
+{
+	size_t mask = size - 1;
+	TEST_ASSERT(size != 0 && !(size & (size - 1)),
+		    "size not a power of 2: %lu", size);
+	return (void *) (((size_t) x + mask) & ~mask);
+}
+
+/* Capability
+ *
+ * Input Args:
+ *   cap - Capability
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   On success, the Value corresponding to the capability (KVM_CAP_*)
+ *   specified by the value of cap.  On failure a TEST_ASSERT failure
+ *   is produced.
+ *
+ * Looks up and returns the value corresponding to the capability
+ * (KVM_CAP_*) given by cap.
+ */
+int kvm_check_cap(long cap)
+{
+	int ret;
+	int kvm_fd;
+
+	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
+	TEST_ASSERT(kvm_fd >= 0, "open %s failed, rc: %i errno: %i",
+		KVM_DEV_PATH, kvm_fd, errno);
+
+	ret = ioctl(kvm_fd, KVM_CHECK_EXTENSION, cap);
+	TEST_ASSERT(ret != -1, "KVM_CHECK_EXTENSION IOCTL failed,\n"
+		"  rc: %i errno: %i", ret, errno);
+
+	close(kvm_fd);
+
+	return ret;
+}
+
+/* VM Create
+ *
+ * Input Args:
+ *   mode - VM Mode (e.g. VM_MODE_FLAT48PG)
+ *   phy_pages - Physical memory pages
+ *   perm - permission
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to opaque structure that describes the created VM.
+ *
+ * Creates a VM with the mode specified by mode (e.g. VM_MODE_FLAT48PG).
+ * When phy_pages is non-zero, a memory region of phy_pages physical pages
+ * is created and mapped starting at guest physical address 0.  The file
+ * descriptor to control the created VM is created with the permissions
+ * given by perm (e.g. O_RDWR).
+ */
+struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
+{
+	struct kvm_vm *vm;
+	int kvm_fd;
+
+	/* Allocate memory. */
+	vm = calloc(1, sizeof(*vm));
+	TEST_ASSERT(vm != NULL, "Insufficent Memory");
+
+	vm->mode = mode;
+	kvm_fd = open(KVM_DEV_PATH, perm);
+	TEST_ASSERT(kvm_fd >= 0, "open %s failed, rc: %i errno: %i",
+		KVM_DEV_PATH, kvm_fd, errno);
+
+	/* Create VM. */
+	vm->fd = ioctl(kvm_fd, KVM_CREATE_VM, NULL);
+	TEST_ASSERT(vm->fd >= 0, "KVM_CREATE_VM ioctl failed, "
+		"rc: %i errno: %i", vm->fd, errno);
+
+	close(kvm_fd);
+
+	/* Setup mode specific traits. */
+	switch (vm->mode) {
+	case VM_MODE_FLAT48PG:
+		vm->page_size = 0x1000;
+		vm->page_shift = 12;
+
+		/* Limit to 48-bit canonical virtual addresses. */
+		vm->vpages_valid = sparsebit_alloc();
+		sparsebit_set_num(vm->vpages_valid,
+			0, (1ULL << (48 - 1)) >> vm->page_shift);
+		sparsebit_set_num(vm->vpages_valid,
+			(~((1ULL << (48 - 1)) - 1)) >> vm->page_shift,
+			(1ULL << (48 - 1)) >> vm->page_shift);
+
+		/* Limit physical addresses to 52-bits. */
+		vm->max_gfn = ((1ULL << 52) >> vm->page_shift) - 1;
+		break;
+
+	default:
+		TEST_ASSERT(false, "Unknown guest mode, mode: 0x%x", mode);
+	}
+
+	/* Allocate and setup memory for guest. */
+	vm->vpages_mapped = sparsebit_alloc();
+	if (phy_pages != 0)
+		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+					    0, 0, phy_pages, 0);
+
+	return vm;
+}
+
+/* Userspace Memory Region Find
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   start - Starting VM physical address
+ *   end - Ending VM physical address, inclusive.
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to overlapping region, NULL if no such region.
+ *
+ * Searches for a region with any physical memory that overlaps with
+ * any portion of the guest physical addresses from start to end
+ * inclusive.  If multiple overlapping regions exist, a pointer to any
+ * of the regions is returned.  Null is returned only when no overlapping
+ * region exists.
+ */
+static struct userspace_mem_region *userspace_mem_region_find(
+	struct kvm_vm *vm, uint64_t start, uint64_t end)
+{
+	struct userspace_mem_region *region;
+
+	for (region = vm->userspace_mem_region_head; region;
+		region = region->next) {
+		uint64_t existing_start = region->region.guest_phys_addr;
+		uint64_t existing_end = region->region.guest_phys_addr
+			+ region->region.memory_size - 1;
+		if (start <= existing_end && end >= existing_start)
+			return region;
+	}
+
+	return NULL;
+}
+
+/* KVM Userspace Memory Region Find
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   start - Starting VM physical address
+ *   end - Ending VM physical address, inclusive.
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to overlapping region, NULL if no such region.
+ *
+ * Public interface to userspace_mem_region_find. Allows tests to look up
+ * the memslot datastructure for a given range of guest physical memory.
+ */
+struct kvm_userspace_memory_region *
+kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
+				 uint64_t end)
+{
+	struct userspace_mem_region *region;
+
+	region = userspace_mem_region_find(vm, start, end);
+	if (!region)
+		return NULL;
+
+	return &region->region;
+}
+
+/* VCPU Find
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to VCPU structure
+ *
+ * Locates a vcpu structure that describes the VCPU specified by vcpuid and
+ * returns a pointer to it.  Returns NULL if the VM doesn't contain a VCPU
+ * for the specified vcpuid.
+ */
+struct vcpu *vcpu_find(struct kvm_vm *vm,
+	uint32_t vcpuid)
+{
+	struct vcpu *vcpup;
+
+	for (vcpup = vm->vcpu_head; vcpup; vcpup = vcpup->next) {
+		if (vcpup->id == vcpuid)
+			return vcpup;
+	}
+
+	return NULL;
+}
+
+/* VM VCPU Remove
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *
+ * Output Args: None
+ *
+ * Return: None, TEST_ASSERT failures for all error conditions
+ *
+ * Within the VM specified by vm, removes the VCPU given by vcpuid.
+ */
+static void vm_vcpu_rm(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+
+	int ret = close(vcpu->fd);
+	TEST_ASSERT(ret == 0, "Close of VCPU fd failed, rc: %i "
+		"errno: %i", ret, errno);
+
+	if (vcpu->next)
+		vcpu->next->prev = vcpu->prev;
+	if (vcpu->prev)
+		vcpu->prev->next = vcpu->next;
+	else
+		vm->vcpu_head = vcpu->next;
+	free(vcpu);
+}
+
+
+/* Destroys and frees the VM pointed to by vmp.
+ */
+void kvm_vm_free(struct kvm_vm *vmp)
+{
+	int ret;
+
+	if (vmp == NULL)
+		return;
+
+	/* Free userspace_mem_regions. */
+	while (vmp->userspace_mem_region_head) {
+		struct userspace_mem_region *region
+			= vmp->userspace_mem_region_head;
+
+		region->region.memory_size = 0;
+		ret = ioctl(vmp->fd, KVM_SET_USER_MEMORY_REGION,
+			&region->region);
+		TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed, "
+			"rc: %i errno: %i", ret, errno);
+
+		vmp->userspace_mem_region_head = region->next;
+		sparsebit_free(&region->unused_phy_pages);
+		ret = munmap(region->mmap_start, region->mmap_size);
+		TEST_ASSERT(ret == 0, "munmap failed, rc: %i errno: %i",
+			    ret, errno);
+
+		free(region);
+	}
+
+	/* Free VCPUs. */
+	while (vmp->vcpu_head)
+		vm_vcpu_rm(vmp, vmp->vcpu_head->id);
+
+	/* Free sparsebit arrays. */
+	sparsebit_free(&vmp->vpages_valid);
+	sparsebit_free(&vmp->vpages_mapped);
+
+	/* Close file descriptor for the VM. */
+	ret = close(vmp->fd);
+	TEST_ASSERT(ret == 0, "Close of vm fd failed,\n"
+		"  vmp->fd: %i rc: %i errno: %i", vmp->fd, ret, errno);
+
+	/* Free the structure describing the VM. */
+	free(vmp);
+}
+
+/* Memory Compare, host virtual to guest virtual
+ *
+ * Input Args:
+ *   hva - Starting host virtual address
+ *   vm - Virtual Machine
+ *   gva - Starting guest virtual address
+ *   len - number of bytes to compare
+ *
+ * Output Args: None
+ *
+ * Input/Output Args: None
+ *
+ * Return:
+ *   Returns 0 if the bytes starting at hva for a length of len
+ *   are equal the guest virtual bytes starting at gva.  Returns
+ *   a value < 0, if bytes at hva are less than those at gva.
+ *   Otherwise a value > 0 is returned.
+ *
+ * Compares the bytes starting at the host virtual address hva, for
+ * a length of len, to the guest bytes starting at the guest virtual
+ * address given by gva.
+ */
+int kvm_memcmp_hva_gva(void *hva,
+	struct kvm_vm *vm, vm_vaddr_t gva, size_t len)
+{
+	size_t amt;
+
+	/* Compare a batch of bytes until either a match is found
+	 * or all the bytes have been compared.
+	 */
+	for (uintptr_t offset = 0; offset < len; offset += amt) {
+		uintptr_t ptr1 = (uintptr_t)hva + offset;
+
+		/* Determine host address for guest virtual address
+		 * at offset.
+		 */
+		uintptr_t ptr2 = (uintptr_t)addr_gva2hva(vm, gva + offset);
+
+		/* Determine amount to compare on this pass.
+		 * Don't allow the comparsion to cross a page boundary.
+		 */
+		amt = len - offset;
+		if ((ptr1 >> vm->page_shift) != ((ptr1 + amt) >> vm->page_shift))
+			amt = vm->page_size - (ptr1 % vm->page_size);
+		if ((ptr2 >> vm->page_shift) != ((ptr2 + amt) >> vm->page_shift))
+			amt = vm->page_size - (ptr2 % vm->page_size);
+
+		assert((ptr1 >> vm->page_shift) == ((ptr1 + amt - 1) >> vm->page_shift));
+		assert((ptr2 >> vm->page_shift) == ((ptr2 + amt - 1) >> vm->page_shift));
+
+		/* Perform the comparison.  If there is a difference
+		 * return that result to the caller, otherwise need
+		 * to continue on looking for a mismatch.
+		 */
+		int ret = memcmp((void *)ptr1, (void *)ptr2, amt);
+		if (ret != 0)
+			return ret;
+	}
+
+	/* No mismatch found.  Let the caller know the two memory
+	 * areas are equal.
+	 */
+	return 0;
+}
+
+/* Allocate an instance of struct kvm_cpuid2
+ *
+ * Input Args: None
+ *
+ * Output Args: None
+ *
+ * Return: A pointer to the allocated struct. The caller is responsible
+ * for freeing this struct.
+ *
+ * Since kvm_cpuid2 uses a 0-length array to allow a the size of the
+ * array to be decided at allocation time, allocation is slightly
+ * complicated. This function uses a reasonable default length for
+ * the array and performs the appropriate allocation.
+ */
+struct kvm_cpuid2 *allocate_kvm_cpuid2(void)
+{
+	struct kvm_cpuid2 *cpuid;
+	int nent = 100;
+	size_t size;
+
+	size = sizeof(*cpuid);
+	size += nent * sizeof(struct kvm_cpuid_entry2);
+	cpuid = malloc(size);
+	if (!cpuid) {
+		perror("malloc");
+		abort();
+	}
+
+	cpuid->nent = nent;
+
+	return cpuid;
+}
+
+/* KVM Supported CPUID Get
+ *
+ * Input Args: None
+ *
+ * Output Args:
+ *   cpuid - The supported KVM CPUID
+ *
+ * Return: void
+ *
+ * Get the guest CPUID supported by KVM.
+ */
+void kvm_get_supported_cpuid(struct kvm_cpuid2 *cpuid)
+{
+	int ret;
+	int kvm_fd;
+
+	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
+	TEST_ASSERT(kvm_fd >= 0, "open %s failed, rc: %i errno: %i",
+		KVM_DEV_PATH, kvm_fd, errno);
+
+	ret = ioctl(kvm_fd, KVM_GET_SUPPORTED_CPUID, cpuid);
+	TEST_ASSERT(ret == 0, "KVM_GET_SUPPORTED_CPUID failed %d %d\n",
+		    ret, errno);
+
+	close(kvm_fd);
+}
+
+/* Locate a cpuid entry.
+ *
+ * Input Args:
+ *   cpuid: The cpuid.
+ *   function: The function of the cpuid entry to find.
+ *
+ * Output Args: None
+ *
+ * Return: A pointer to the cpuid entry. Never returns NULL.
+ */
+struct kvm_cpuid_entry2 *
+find_cpuid_index_entry(struct kvm_cpuid2 *cpuid, uint32_t function,
+		       uint32_t index)
+{
+	struct kvm_cpuid_entry2 *entry = NULL;
+	int i;
+
+	for (i = 0; i < cpuid->nent; i++) {
+		if (cpuid->entries[i].function == function &&
+		    cpuid->entries[i].index == index) {
+			entry = &cpuid->entries[i];
+			break;
+		}
+	}
+
+	TEST_ASSERT(entry, "Guest CPUID entry not found: (EAX=%x, ECX=%x).",
+		    function, index);
+	return entry;
+}
+
+/* VM Userspace Memory Region Add
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   backing_src - Storage source for this region.
+ *                 NULL to use anonymous memory.
+ *   guest_paddr - Starting guest physical address
+ *   slot - KVM region slot
+ *   npages - Number of physical pages
+ *   flags - KVM memory region flags (e.g. KVM_MEM_LOG_DIRTY_PAGES)
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Allocates a memory area of the number of pages specified by npages
+ * and maps it to the VM specified by vm, at a starting physical address
+ * given by guest_paddr.  The region is created with a KVM region slot
+ * given by slot, which must be unique and < KVM_MEM_SLOTS_NUM.  The
+ * region is created with the flags given by flags.
+ */
+void vm_userspace_mem_region_add(struct kvm_vm *vm,
+	enum vm_mem_backing_src_type src_type,
+	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
+	uint32_t flags)
+{
+	int ret;
+	unsigned long pmem_size = 0;
+	struct userspace_mem_region *region;
+	size_t huge_page_size = KVM_UTIL_PGS_PER_HUGEPG * vm->page_size;
+
+	TEST_ASSERT((guest_paddr % vm->page_size) == 0, "Guest physical "
+		"address not on a page boundary.\n"
+		"  guest_paddr: 0x%lx vm->page_size: 0x%x",
+		guest_paddr, vm->page_size);
+	TEST_ASSERT((((guest_paddr >> vm->page_shift) + npages) - 1)
+		<= vm->max_gfn, "Physical range beyond maximum "
+		"supported physical address,\n"
+		"  guest_paddr: 0x%lx npages: 0x%lx\n"
+		"  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
+		guest_paddr, npages, vm->max_gfn, vm->page_size);
+
+	/* Confirm a mem region with an overlapping address doesn't
+	 * already exist.
+	 */
+	region = (struct userspace_mem_region *) userspace_mem_region_find(
+		vm, guest_paddr, guest_paddr + npages * vm->page_size);
+	if (region != NULL)
+		TEST_ASSERT(false, "overlapping userspace_mem_region already "
+			"exists\n"
+			"  requested guest_paddr: 0x%lx npages: 0x%lx "
+			"page_size: 0x%x\n"
+			"  existing guest_paddr: 0x%lx size: 0x%lx",
+			guest_paddr, npages, vm->page_size,
+			(uint64_t) region->region.guest_phys_addr,
+			(uint64_t) region->region.memory_size);
+
+	/* Confirm no region with the requested slot already exists. */
+	for (region = vm->userspace_mem_region_head; region;
+		region = region->next) {
+		if (region->region.slot == slot)
+			break;
+		if ((guest_paddr <= (region->region.guest_phys_addr
+				+ region->region.memory_size))
+			&& ((guest_paddr + npages * vm->page_size)
+				>= region->region.guest_phys_addr))
+			break;
+	}
+	if (region != NULL)
+		TEST_ASSERT(false, "A mem region with the requested slot "
+			"or overlapping physical memory range already exists.\n"
+			"  requested slot: %u paddr: 0x%lx npages: 0x%lx\n"
+			"  existing slot: %u paddr: 0x%lx size: 0x%lx",
+			slot, guest_paddr, npages,
+			region->region.slot,
+			(uint64_t) region->region.guest_phys_addr,
+			(uint64_t) region->region.memory_size);
+
+	/* Allocate and initialize new mem region structure. */
+	region = calloc(1, sizeof(*region));
+	TEST_ASSERT(region != NULL, "Insufficient Memory");
+	region->mmap_size = npages * vm->page_size;
+
+	/* Enough memory to align up to a huge page. */
+	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
+		region->mmap_size += huge_page_size;
+	region->mmap_start = mmap(NULL, region->mmap_size,
+				  PROT_READ | PROT_WRITE,
+				  MAP_PRIVATE | MAP_ANONYMOUS
+				  | (src_type == VM_MEM_SRC_ANONYMOUS_HUGETLB ? MAP_HUGETLB : 0),
+				  -1, 0);
+	TEST_ASSERT(region->mmap_start != MAP_FAILED,
+		    "test_malloc failed, mmap_start: %p errno: %i",
+		    region->mmap_start, errno);
+
+	/* Align THP allocation up to start of a huge page. */
+	region->host_mem = align(region->mmap_start,
+				 src_type == VM_MEM_SRC_ANONYMOUS_THP ?  huge_page_size : 1);
+
+	/* As needed perform madvise */
+	if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
+		ret = madvise(region->host_mem, npages * vm->page_size,
+			     src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
+		TEST_ASSERT(ret == 0, "madvise failed,\n"
+			    "  addr: %p\n"
+			    "  length: 0x%lx\n"
+			    "  src_type: %x",
+			    region->host_mem, npages * vm->page_size, src_type);
+	}
+
+	region->unused_phy_pages = sparsebit_alloc();
+	sparsebit_set_num(region->unused_phy_pages,
+		guest_paddr >> vm->page_shift, npages);
+	region->region.slot = slot;
+	region->region.flags = flags;
+	region->region.guest_phys_addr = guest_paddr;
+	region->region.memory_size = npages * vm->page_size;
+	region->region.userspace_addr = (uintptr_t) region->host_mem;
+	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
+	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
+		"  rc: %i errno: %i\n"
+		"  slot: %u flags: 0x%x\n"
+		"  guest_phys_addr: 0x%lx size: 0x%lx",
+		ret, errno, slot, flags,
+		guest_paddr, (uint64_t) region->region.memory_size);
+
+	/* Add to linked-list of memory regions. */
+	if (vm->userspace_mem_region_head)
+		vm->userspace_mem_region_head->prev = region;
+	region->next = vm->userspace_mem_region_head;
+	vm->userspace_mem_region_head = region;
+}
+
+/* Memslot to region
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   memslot - KVM memory slot ID
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to memory region structure that describe memory region
+ *   using kvm memory slot ID given by memslot.  TEST_ASSERT failure
+ *   on error (e.g. currently no memory region using memslot as a KVM
+ *   memory slot ID).
+ */
+static struct userspace_mem_region *memslot2region(struct kvm_vm *vm,
+	uint32_t memslot)
+{
+	struct userspace_mem_region *region;
+
+	for (region = vm->userspace_mem_region_head; region;
+		region = region->next) {
+		if (region->region.slot == memslot)
+			break;
+	}
+	if (region == NULL) {
+		fprintf(stderr, "No mem region with the requested slot found,\n"
+			"  requested slot: %u\n", memslot);
+		fputs("---- vm dump ----\n", stderr);
+		vm_dump(stderr, vm, 2);
+		TEST_ASSERT(false, "Mem region not found");
+	}
+
+	return region;
+}
+
+/* VM Memory Region Flags Set
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   flags - Starting guest physical address
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Sets the flags of the memory region specified by the value of slot,
+ * to the values given by flags.
+ */
+void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags)
+{
+	int ret;
+	struct userspace_mem_region *region;
+
+	/* Locate memory region. */
+	region = memslot2region(vm, slot);
+
+	region->region.flags = flags;
+
+	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
+
+	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
+		"  rc: %i errno: %i slot: %u flags: 0x%x",
+		ret, errno, slot, flags);
+}
+
+/* VCPU mmap Size
+ *
+ * Input Args: None
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Size of VCPU state
+ *
+ * Returns the size of the structure pointed to by the return value
+ * of vcpu_state().
+ */
+static int vcpu_mmap_sz(void)
+{
+	int dev_fd, ret;
+
+	dev_fd = open(KVM_DEV_PATH, O_RDONLY);
+	TEST_ASSERT(dev_fd >= 0, "%s open %s failed, rc: %i errno: %i",
+		__func__, KVM_DEV_PATH, dev_fd, errno);
+
+	ret = ioctl(dev_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
+	TEST_ASSERT(ret >= sizeof(struct kvm_run),
+		"%s KVM_GET_VCPU_MMAP_SIZE ioctl failed, rc: %i errno: %i",
+		__func__, ret, errno);
+
+	close(dev_fd);
+
+	return ret;
+}
+
+/* VM VCPU Add
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Creates and adds to the VM specified by vm and virtual CPU with
+ * the ID given by vcpuid.
+ */
+void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu;
+
+	/* Confirm a vcpu with the specified id doesn't already exist. */
+	vcpu = vcpu_find(vm, vcpuid);
+	if (vcpu != NULL)
+		TEST_ASSERT(false, "vcpu with the specified id "
+			"already exists,\n"
+			"  requested vcpuid: %u\n"
+			"  existing vcpuid: %u state: %p",
+			vcpuid, vcpu->id, vcpu->state);
+
+	/* Allocate and initialize new vcpu structure. */
+	vcpu = calloc(1, sizeof(*vcpu));
+	TEST_ASSERT(vcpu != NULL, "Insufficient Memory");
+	vcpu->id = vcpuid;
+	vcpu->fd = ioctl(vm->fd, KVM_CREATE_VCPU, vcpuid);
+	TEST_ASSERT(vcpu->fd >= 0, "KVM_CREATE_VCPU failed, rc: %i errno: %i",
+		vcpu->fd, errno);
+
+	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->state), "vcpu mmap size "
+		"smaller than expected, vcpu_mmap_sz: %i expected_min: %zi",
+		vcpu_mmap_sz(), sizeof(*vcpu->state));
+	vcpu->state = (struct kvm_run *) mmap(NULL, sizeof(*vcpu->state),
+		PROT_READ | PROT_WRITE, MAP_SHARED, vcpu->fd, 0);
+	TEST_ASSERT(vcpu->state != MAP_FAILED, "mmap vcpu_state failed, "
+		"vcpu id: %u errno: %i", vcpuid, errno);
+
+	/* Add to linked-list of VCPUs. */
+	if (vm->vcpu_head)
+		vm->vcpu_head->prev = vcpu;
+	vcpu->next = vm->vcpu_head;
+	vm->vcpu_head = vcpu;
+
+	vcpu_setup(vm, vcpuid);
+}
+
+/* VM Virtual Address Unused Gap
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   sz - Size (bytes)
+ *   vaddr_min - Minimum Virtual Address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Lowest virtual address at or below vaddr_min, with at least
+ *   sz unused bytes.  TEST_ASSERT failure if no area of at least
+ *   size sz is available.
+ *
+ * Within the VM specified by vm, locates the lowest starting virtual
+ * address >= vaddr_min, that has at least sz unallocated bytes.  A
+ * TEST_ASSERT failure occurs for invalid input or no area of at least
+ * sz unallocated bytes >= vaddr_min is available.
+ */
+static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
+	vm_vaddr_t vaddr_min)
+{
+	uint64_t pages = (sz + vm->page_size - 1) >> vm->page_shift;
+
+	/* Determine lowest permitted virtual page index. */
+	uint64_t pgidx_start = (vaddr_min + vm->page_size - 1) >> vm->page_shift;
+	if ((pgidx_start * vm->page_size) < vaddr_min)
+			goto no_va_found;
+
+	/* Loop over section with enough valid virtual page indexes. */
+	if (!sparsebit_is_set_num(vm->vpages_valid,
+		pgidx_start, pages))
+		pgidx_start = sparsebit_next_set_num(vm->vpages_valid,
+			pgidx_start, pages);
+	do {
+		/*
+		 * Are there enough unused virtual pages available at
+		 * the currently proposed starting virtual page index.
+		 * If not, adjust proposed starting index to next
+		 * possible.
+		 */
+		if (sparsebit_is_clear_num(vm->vpages_mapped,
+			pgidx_start, pages))
+			goto va_found;
+		pgidx_start = sparsebit_next_clear_num(vm->vpages_mapped,
+			pgidx_start, pages);
+		if (pgidx_start == 0)
+			goto no_va_found;
+
+		/*
+		 * If needed, adjust proposed starting virtual address,
+		 * to next range of valid virtual addresses.
+		 */
+		if (!sparsebit_is_set_num(vm->vpages_valid,
+			pgidx_start, pages)) {
+			pgidx_start = sparsebit_next_set_num(
+				vm->vpages_valid, pgidx_start, pages);
+			if (pgidx_start == 0)
+				goto no_va_found;
+		}
+	} while (pgidx_start != 0);
+
+no_va_found:
+	TEST_ASSERT(false, "No vaddr of specified pages available, "
+		"pages: 0x%lx", pages);
+
+	/* NOT REACHED */
+	return -1;
+
+va_found:
+	TEST_ASSERT(sparsebit_is_set_num(vm->vpages_valid,
+		pgidx_start, pages),
+		"Unexpected, invalid virtual page index range,\n"
+		"  pgidx_start: 0x%lx\n"
+		"  pages: 0x%lx",
+		pgidx_start, pages);
+	TEST_ASSERT(sparsebit_is_clear_num(vm->vpages_mapped,
+		pgidx_start, pages),
+		"Unexpected, pages already mapped,\n"
+		"  pgidx_start: 0x%lx\n"
+		"  pages: 0x%lx",
+		pgidx_start, pages);
+
+	return pgidx_start * vm->page_size;
+}
+
+/* VM Virtual Address Allocate
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   sz - Size in bytes
+ *   vaddr_min - Minimum starting virtual address
+ *   data_memslot - Memory region slot for data pages
+ *   pgd_memslot - Memory region slot for new virtual translation tables
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Starting guest virtual address
+ *
+ * Allocates at least sz bytes within the virtual address space of the vm
+ * given by vm.  The allocated bytes are mapped to a virtual address >=
+ * the address given by vaddr_min.  Note that each allocation uses a
+ * a unique set of pages, with the minimum real allocation being at least
+ * a page.
+ */
+vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+	uint32_t data_memslot, uint32_t pgd_memslot)
+{
+	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
+
+	virt_pgd_alloc(vm, pgd_memslot);
+
+	/* Find an unused range of virtual page addresses of at least
+	 * pages in length.
+	 */
+	vm_vaddr_t vaddr_start = vm_vaddr_unused_gap(vm, sz, vaddr_min);
+
+	/* Map the virtual pages. */
+	for (vm_vaddr_t vaddr = vaddr_start; pages > 0;
+		pages--, vaddr += vm->page_size) {
+		vm_paddr_t paddr;
+
+		paddr = vm_phy_page_alloc(vm, KVM_UTIL_MIN_PADDR, data_memslot);
+
+		virt_pg_map(vm, vaddr, paddr, pgd_memslot);
+
+		sparsebit_set(vm->vpages_mapped,
+			vaddr >> vm->page_shift);
+	}
+
+	return vaddr_start;
+}
+
+/* Address VM Physical to Host Virtual
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gpa - VM physical address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Equivalent host virtual address
+ *
+ * Locates the memory region containing the VM physical address given
+ * by gpa, within the VM given by vm.  When found, the host virtual
+ * address providing the memory to the vm physical address is returned.
+ * A TEST_ASSERT failure occurs if no region containing gpa exists.
+ */
+void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa)
+{
+	struct userspace_mem_region *region;
+	for (region = vm->userspace_mem_region_head; region;
+	     region = region->next) {
+		if ((gpa >= region->region.guest_phys_addr)
+			&& (gpa <= (region->region.guest_phys_addr
+				+ region->region.memory_size - 1)))
+			return (void *) ((uintptr_t) region->host_mem
+				+ (gpa - region->region.guest_phys_addr));
+	}
+
+	TEST_ASSERT(false, "No vm physical memory at 0x%lx", gpa);
+	return NULL;
+}
+
+/* Address Host Virtual to VM Physical
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   hva - Host virtual address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Equivalent VM physical address
+ *
+ * Locates the memory region containing the host virtual address given
+ * by hva, within the VM given by vm.  When found, the equivalent
+ * VM physical address is returned. A TEST_ASSERT failure occurs if no
+ * region containing hva exists.
+ */
+vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva)
+{
+	struct userspace_mem_region *region;
+	for (region = vm->userspace_mem_region_head; region;
+	     region = region->next) {
+		if ((hva >= region->host_mem)
+			&& (hva <= (region->host_mem
+				+ region->region.memory_size - 1)))
+			return (vm_paddr_t) ((uintptr_t)
+				region->region.guest_phys_addr
+				+ (hva - (uintptr_t) region->host_mem));
+	}
+
+	TEST_ASSERT(false, "No mapping to a guest physical address, "
+		"hva: %p", hva);
+	return -1;
+}
+
+/* VM Create IRQ Chip
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Creates an interrupt controller chip for the VM specified by vm.
+ */
+void vm_create_irqchip(struct kvm_vm *vm)
+{
+	int ret;
+
+	ret = ioctl(vm->fd, KVM_CREATE_IRQCHIP, 0);
+	TEST_ASSERT(ret == 0, "KVM_CREATE_IRQCHIP IOCTL failed, "
+		"rc: %i errno: %i", ret, errno);
+}
+
+/* VM VCPU State
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to structure that describes the state of the VCPU.
+ *
+ * Locates and returns a pointer to a structure that describes the
+ * state of the VCPU with the given vcpuid.
+ */
+struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	return vcpu->state;
+}
+
+/* VM VCPU Run
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Switch to executing the code for the VCPU given by vcpuid, within the VM
+ * given by vm.
+ */
+void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	int ret = _vcpu_run(vm, vcpuid);
+	TEST_ASSERT(ret == 0, "KVM_RUN IOCTL failed, "
+		"rc: %i errno: %i", ret, errno);
+}
+
+int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int rc;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+        do {
+		rc = ioctl(vcpu->fd, KVM_RUN, NULL);
+	} while (rc == -1 && errno == EINTR);
+	return rc;
+}
+
+/* VM VCPU Set MP State
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   mp_state - mp_state to be set
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Sets the MP state of the VCPU given by vcpuid, to the state given
+ * by mp_state.
+ */
+void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
+	struct kvm_mp_state *mp_state)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	ret = ioctl(vcpu->fd, KVM_SET_MP_STATE, mp_state);
+	TEST_ASSERT(ret == 0, "KVM_SET_MP_STATE IOCTL failed, "
+		"rc: %i errno: %i", ret, errno);
+}
+
+/* VM VCPU Regs Get
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *
+ * Output Args:
+ *   regs - current state of VCPU regs
+ *
+ * Return: None
+ *
+ * Obtains the current register state for the VCPU specified by vcpuid
+ * and stores it at the location given by regs.
+ */
+void vcpu_regs_get(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_regs *regs)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	/* Get the regs. */
+	ret = ioctl(vcpu->fd, KVM_GET_REGS, regs);
+	TEST_ASSERT(ret == 0, "KVM_GET_REGS failed, rc: %i errno: %i",
+		ret, errno);
+}
+
+/* VM VCPU Regs Set
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   regs - Values to set VCPU regs to
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Sets the regs of the VCPU specified by vcpuid to the values
+ * given by regs.
+ */
+void vcpu_regs_set(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_regs *regs)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	/* Set the regs. */
+	ret = ioctl(vcpu->fd, KVM_SET_REGS, regs);
+	TEST_ASSERT(ret == 0, "KVM_SET_REGS failed, rc: %i errno: %i",
+		ret, errno);
+}
+
+void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
+			  struct kvm_vcpu_events *events)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	/* Get the regs. */
+	ret = ioctl(vcpu->fd, KVM_GET_VCPU_EVENTS, events);
+	TEST_ASSERT(ret == 0, "KVM_GET_VCPU_EVENTS, failed, rc: %i errno: %i",
+		ret, errno);
+}
+
+void vcpu_events_set(struct kvm_vm *vm, uint32_t vcpuid,
+			  struct kvm_vcpu_events *events)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	/* Set the regs. */
+	ret = ioctl(vcpu->fd, KVM_SET_VCPU_EVENTS, events);
+	TEST_ASSERT(ret == 0, "KVM_SET_VCPU_EVENTS, failed, rc: %i errno: %i",
+		ret, errno);
+}
+
+/* VM VCPU Args Set
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   num - number of arguments
+ *   ... - arguments, each of type uint64_t
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Sets the first num function input arguments to the values
+ * given as variable args.  Each of the variable args is expected to
+ * be of type uint64_t.
+ */
+void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
+{
+	va_list ap;
+	struct kvm_regs regs;
+
+	TEST_ASSERT(num >= 1 && num <= 6, "Unsupported number of args,\n"
+		    "  num: %u\n",
+		    num);
+
+	va_start(ap, num);
+	vcpu_regs_get(vm, vcpuid, &regs);
+
+	if (num >= 1)
+		regs.rdi = va_arg(ap, uint64_t);
+
+	if (num >= 2)
+		regs.rsi = va_arg(ap, uint64_t);
+
+	if (num >= 3)
+		regs.rdx = va_arg(ap, uint64_t);
+
+	if (num >= 4)
+		regs.rcx = va_arg(ap, uint64_t);
+
+	if (num >= 5)
+		regs.r8 = va_arg(ap, uint64_t);
+
+	if (num >= 6)
+		regs.r9 = va_arg(ap, uint64_t);
+
+	vcpu_regs_set(vm, vcpuid, &regs);
+	va_end(ap);
+}
+
+/* VM VCPU System Regs Get
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *
+ * Output Args:
+ *   sregs - current state of VCPU system regs
+ *
+ * Return: None
+ *
+ * Obtains the current system register state for the VCPU specified by
+ * vcpuid and stores it at the location given by sregs.
+ */
+void vcpu_sregs_get(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_sregs *sregs)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	/* Get the regs. */
+	/* Get the regs. */
+	ret = ioctl(vcpu->fd, KVM_GET_SREGS, sregs);
+	TEST_ASSERT(ret == 0, "KVM_GET_SREGS failed, rc: %i errno: %i",
+		ret, errno);
+}
+
+/* VM VCPU System Regs Set
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   sregs - Values to set VCPU system regs to
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Sets the system regs of the VCPU specified by vcpuid to the values
+ * given by sregs.
+ */
+void vcpu_sregs_set(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_sregs *sregs)
+{
+	int ret = _vcpu_sregs_set(vm, vcpuid, sregs);
+	TEST_ASSERT(ret == 0, "KVM_RUN IOCTL failed, "
+		"rc: %i errno: %i", ret, errno);
+}
+
+int _vcpu_sregs_set(struct kvm_vm *vm,
+	uint32_t vcpuid, struct kvm_sregs *sregs)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	/* Get the regs. */
+	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
+}
+
+/* VCPU Ioctl
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   cmd - Ioctl number
+ *   arg - Argument to pass to the ioctl
+ *
+ * Return: None
+ *
+ * Issues an arbitrary ioctl on a VCPU fd.
+ */
+void vcpu_ioctl(struct kvm_vm *vm,
+	uint32_t vcpuid, unsigned long cmd, void *arg)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int ret;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	ret = ioctl(vcpu->fd, cmd, arg);
+	TEST_ASSERT(ret == 0, "vcpu ioctl %lu failed, rc: %i errno: %i (%s)",
+		cmd, ret, errno, strerror(errno));
+}
+
+/* VM Ioctl
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   cmd - Ioctl number
+ *   arg - Argument to pass to the ioctl
+ *
+ * Return: None
+ *
+ * Issues an arbitrary ioctl on a VM fd.
+ */
+void vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
+{
+	int ret;
+
+	ret = ioctl(vm->fd, cmd, arg);
+	TEST_ASSERT(ret == 0, "vm ioctl %lu failed, rc: %i errno: %i (%s)",
+		cmd, ret, errno, strerror(errno));
+}
+
+/* VM Dump
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   indent - Left margin indent amount
+ *
+ * Output Args:
+ *   stream - Output FILE stream
+ *
+ * Return: None
+ *
+ * Dumps the current state of the VM given by vm, to the FILE stream
+ * given by stream.
+ */
+void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+{
+	struct userspace_mem_region *region;
+	struct vcpu *vcpu;
+
+	fprintf(stream, "%*smode: 0x%x\n", indent, "", vm->mode);
+	fprintf(stream, "%*sfd: %i\n", indent, "", vm->fd);
+	fprintf(stream, "%*spage_size: 0x%x\n", indent, "", vm->page_size);
+	fprintf(stream, "%*sMem Regions:\n", indent, "");
+	for (region = vm->userspace_mem_region_head; region;
+		region = region->next) {
+		fprintf(stream, "%*sguest_phys: 0x%lx size: 0x%lx "
+			"host_virt: %p\n", indent + 2, "",
+			(uint64_t) region->region.guest_phys_addr,
+			(uint64_t) region->region.memory_size,
+			region->host_mem);
+		fprintf(stream, "%*sunused_phy_pages: ", indent + 2, "");
+		sparsebit_dump(stream, region->unused_phy_pages, 0);
+	}
+	fprintf(stream, "%*sMapped Virtual Pages:\n", indent, "");
+	sparsebit_dump(stream, vm->vpages_mapped, indent + 2);
+	fprintf(stream, "%*spgd_created: %u\n", indent, "",
+		vm->pgd_created);
+	if (vm->pgd_created) {
+		fprintf(stream, "%*sVirtual Translation Tables:\n",
+			indent + 2, "");
+		virt_dump(stream, vm, indent + 4);
+	}
+	fprintf(stream, "%*sVCPUs:\n", indent, "");
+	for (vcpu = vm->vcpu_head; vcpu; vcpu = vcpu->next)
+		vcpu_dump(stream, vm, vcpu->id, indent + 2);
+}
+
+/* VM VCPU Dump
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU ID
+ *   indent - Left margin indent amount
+ *
+ * Output Args:
+ *   stream - Output FILE stream
+ *
+ * Return: None
+ *
+ * Dumps the current state of the VCPU specified by vcpuid, within the VM
+ * given by vm, to the FILE stream given by stream.
+ */
+void vcpu_dump(FILE *stream, struct kvm_vm *vm,
+	uint32_t vcpuid, uint8_t indent)
+{
+		struct kvm_regs regs;
+		struct kvm_sregs sregs;
+
+		fprintf(stream, "%*scpuid: %u\n", indent, "", vcpuid);
+
+		fprintf(stream, "%*sregs:\n", indent + 2, "");
+		vcpu_regs_get(vm, vcpuid, &regs);
+		regs_dump(stream, &regs, indent + 4);
+
+		fprintf(stream, "%*ssregs:\n", indent + 2, "");
+		vcpu_sregs_get(vm, vcpuid, &sregs);
+		sregs_dump(stream, &sregs, indent + 4);
+}
+
+/* Known KVM exit reasons */
+static struct exit_reason {
+	unsigned int reason;
+	const char *name;
+} exit_reasons_known[] = {
+	{KVM_EXIT_UNKNOWN, "UNKNOWN"},
+	{KVM_EXIT_EXCEPTION, "EXCEPTION"},
+	{KVM_EXIT_IO, "IO"},
+	{KVM_EXIT_HYPERCALL, "HYPERCALL"},
+	{KVM_EXIT_DEBUG, "DEBUG"},
+	{KVM_EXIT_HLT, "HLT"},
+	{KVM_EXIT_MMIO, "MMIO"},
+	{KVM_EXIT_IRQ_WINDOW_OPEN, "IRQ_WINDOW_OPEN"},
+	{KVM_EXIT_SHUTDOWN, "SHUTDOWN"},
+	{KVM_EXIT_FAIL_ENTRY, "FAIL_ENTRY"},
+	{KVM_EXIT_INTR, "INTR"},
+	{KVM_EXIT_SET_TPR, "SET_TPR"},
+	{KVM_EXIT_TPR_ACCESS, "TPR_ACCESS"},
+	{KVM_EXIT_S390_SIEIC, "S390_SIEIC"},
+	{KVM_EXIT_S390_RESET, "S390_RESET"},
+	{KVM_EXIT_DCR, "DCR"},
+	{KVM_EXIT_NMI, "NMI"},
+	{KVM_EXIT_INTERNAL_ERROR, "INTERNAL_ERROR"},
+	{KVM_EXIT_OSI, "OSI"},
+	{KVM_EXIT_PAPR_HCALL, "PAPR_HCALL"},
+#ifdef KVM_EXIT_MEMORY_NOT_PRESENT
+	{KVM_EXIT_MEMORY_NOT_PRESENT, "MEMORY_NOT_PRESENT"},
+#endif
+};
+
+/* Exit Reason String
+ *
+ * Input Args:
+ *   exit_reason - Exit reason
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Constant string pointer describing the exit reason.
+ *
+ * Locates and returns a constant string that describes the KVM exit
+ * reason given by exit_reason.  If no such string is found, a constant
+ * string of "Unknown" is returned.
+ */
+const char *exit_reason_str(unsigned int exit_reason)
+{
+	unsigned int n1;
+
+	for (n1 = 0; n1 < ARRAY_SIZE(exit_reasons_known); n1++) {
+		if (exit_reason == exit_reasons_known[n1].reason)
+			return exit_reasons_known[n1].name;
+	}
+
+	return "Unknown";
+}
+
+/* Physical Page Allocate
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   paddr_min - Physical address minimum
+ *   memslot - Memory region to allocate page from
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Starting physical address
+ *
+ * Within the VM specified by vm, locates an available physical page
+ * at or above paddr_min.  If found, the page is marked as in use
+ * and its address is returned.  A TEST_ASSERT failure occurs if no
+ * page is available at or above paddr_min.
+ */
+vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm,
+	vm_paddr_t paddr_min, uint32_t memslot)
+{
+	struct userspace_mem_region *region;
+	sparsebit_idx_t pg;
+
+	TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
+		"not divisable by page size.\n"
+		"  paddr_min: 0x%lx page_size: 0x%x",
+		paddr_min, vm->page_size);
+
+	/* Locate memory region. */
+	region = memslot2region(vm, memslot);
+
+	/* Locate next available physical page at or above paddr_min. */
+	pg = paddr_min >> vm->page_shift;
+
+	if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+		pg = sparsebit_next_set(region->unused_phy_pages, pg);
+		if (pg == 0) {
+			fprintf(stderr, "No guest physical page available, "
+				"paddr_min: 0x%lx page_size: 0x%x memslot: %u",
+				paddr_min, vm->page_size, memslot);
+			fputs("---- vm dump ----\n", stderr);
+			vm_dump(stderr, vm, 2);
+			abort();
+		}
+	}
+
+	/* Specify page as in use and return its address. */
+	sparsebit_clear(region->unused_phy_pages, pg);
+
+	return pg * vm->page_size;
+}
+
+/* Address Guest Virtual to Host Virtual
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gva - VM virtual address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Equivalent host virtual address
+ */
+void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva)
+{
+	return addr_gpa2hva(vm, addr_gva2gpa(vm, gva));
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
new file mode 100644
index 000000000000..d2e6c2f39091
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -0,0 +1,67 @@
+/*
+ * tools/testing/selftests/kvm/lib/kvm_util.c
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ */
+
+#ifndef KVM_UTIL_INTERNAL_H
+#define KVM_UTIL_INTERNAL_H 1
+
+#include "sparsebit.h"
+
+#ifndef BITS_PER_BYTE
+#define BITS_PER_BYTE           8
+#endif
+
+#ifndef BITS_PER_LONG
+#define BITS_PER_LONG (BITS_PER_BYTE * sizeof(long))
+#endif
+
+#define DIV_ROUND_UP(n, d)	(((n) + (d) - 1) / (d))
+#define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_LONG)
+
+/* Concrete definition of struct kvm_vm. */
+struct userspace_mem_region {
+	struct userspace_mem_region *next, *prev;
+	struct kvm_userspace_memory_region region;
+	struct sparsebit *unused_phy_pages;
+	int fd;
+	off_t offset;
+	void *host_mem;
+	void *mmap_start;
+	size_t mmap_size;
+};
+
+struct vcpu {
+	struct vcpu *next, *prev;
+	uint32_t id;
+	int fd;
+	struct kvm_run *state;
+};
+
+struct kvm_vm {
+	int mode;
+	int fd;
+	unsigned int page_size;
+	unsigned int page_shift;
+	uint64_t max_gfn;
+	struct vcpu *vcpu_head;
+	struct userspace_mem_region *userspace_mem_region_head;
+	struct sparsebit *vpages_valid;
+	struct sparsebit *vpages_mapped;
+	bool pgd_created;
+	vm_paddr_t pgd;
+};
+
+struct vcpu *vcpu_find(struct kvm_vm *vm,
+	uint32_t vcpuid);
+void vcpu_setup(struct kvm_vm *vm, int vcpuid);
+void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
+void regs_dump(FILE *stream, struct kvm_regs *regs,
+	uint8_t indent);
+void sregs_dump(FILE *stream, struct kvm_sregs *sregs,
+	uint8_t indent);
+
+#endif
diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
new file mode 100644
index 000000000000..7293564a4329
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/sparsebit.c
@@ -0,0 +1,2087 @@
+/*
+ * Sparse bit array
+ *
+ * Copyright (C) 2018, Google LLC.
+ * Copyright (C) 2018, Red Hat, Inc. (code style cleanup and fuzzing driver)
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * This library provides functions to support a memory efficient bit array,
+ * with an index size of 2^64.  A sparsebit array is allocated through
+ * the use sparsebit_alloc() and free'd via sparsebit_free(),
+ * such as in the following:
+ *
+ *   struct sparsebit *s;
+ *   s = sparsebit_alloc();
+ *   sparsebit_free(&s);
+ *
+ * The struct sparsebit type resolves down to a struct sparsebit.
+ * Note that, sparsebit_free() takes a pointer to the sparsebit
+ * structure.  This is so that sparsebit_free() is able to poison
+ * the pointer (e.g. set it to NULL) to the struct sparsebit before
+ * returning to the caller.
+ *
+ * Between the return of sparsebit_alloc() and the call of
+ * sparsebit_free(), there are multiple query and modifying operations
+ * that can be performed on the allocated sparsebit array.  All of
+ * these operations take as a parameter the value returned from
+ * sparsebit_alloc() and most also take a bit index.  Frequently
+ * used routines include:
+ *
+ *  ---- Query Operations
+ *  sparsebit_is_set(s, idx)
+ *  sparsebit_is_clear(s, idx)
+ *  sparsebit_any_set(s)
+ *  sparsebit_first_set(s)
+ *  sparsebit_next_set(s, prev_idx)
+ *
+ *  ---- Modifying Operations
+ *  sparsebit_set(s, idx)
+ *  sparsebit_clear(s, idx)
+ *  sparsebit_set_num(s, idx, num);
+ *  sparsebit_clear_num(s, idx, num);
+ *
+ * A common operation, is to itterate over all the bits set in a test
+ * sparsebit array.  This can be done via code with the following structure:
+ *
+ *   sparsebit_idx_t idx;
+ *   if (sparsebit_any_set(s)) {
+ *     idx = sparsebit_first_set(s);
+ *     do {
+ *       ...
+ *       idx = sparsebit_next_set(s, idx);
+ *     } while (idx != 0);
+ *   }
+ *
+ * The index of the first bit set needs to be obtained via
+ * sparsebit_first_set(), because sparsebit_next_set(), needs
+ * the index of the previously set.  The sparsebit_idx_t type is
+ * unsigned, so there is no previous index before 0 that is available.
+ * Also, the call to sparsebit_first_set() is not made unless there
+ * is at least 1 bit in the array set.  This is because sparsebit_first_set()
+ * aborts if sparsebit_first_set() is called with no bits set.
+ * It is the callers responsibility to assure that the
+ * sparsebit array has at least a single bit set before calling
+ * sparsebit_first_set().
+ *
+ * ==== Implementation Overview ====
+ * For the most part the internal implementation of sparsebit is
+ * opaque to the caller.  One important implementation detail that the
+ * caller may need to be aware of is the spatial complexity of the
+ * implementation.  This implementation of a sparsebit array is not
+ * only sparse, in that it uses memory proportional to the number of bits
+ * set.  It is also efficient in memory usage when most of the bits are
+ * set.
+ *
+ * At a high-level the state of the bit settings are maintained through
+ * the use of a binary-search tree, where each node contains at least
+ * the following members:
+ *
+ *   typedef uint64_t sparsebit_idx_t;
+ *   typedef uint64_t sparsebit_num_t;
+ *
+ *   sparsebit_idx_t idx;
+ *   uint32_t mask;
+ *   sparsebit_num_t num_after;
+ *
+ * The idx member contains the bit index of the first bit described by this
+ * node, while the mask member stores the setting of the first 32-bits.
+ * The setting of the bit at idx + n, where 0 <= n < 32, is located in the
+ * mask member at 1 << n.
+ *
+ * Nodes are sorted by idx and the bits described by two nodes will never
+ * overlap. The idx member is always aligned to the mask size, i.e. a
+ * multiple of 32.
+ *
+ * Beyond a typical implementation, the nodes in this implementation also
+ * contains a member named num_after.  The num_after member holds the
+ * number of bits immediately after the mask bits that are contiguously set.
+ * The use of the num_after member allows this implementation to efficiently
+ * represent cases where most bits are set.  For example, the case of all
+ * but the last two bits set, is represented by the following two nodes:
+ *
+ *   node 0 - idx: 0x0 mask: 0xffffffff num_after: 0xffffffffffffffc0
+ *   node 1 - idx: 0xffffffffffffffe0 mask: 0x3fffffff num_after: 0
+ *
+ * ==== Invariants ====
+ * This implementation usses the following invariants:
+ *
+ *   + Node are only used to represent bits that are set.
+ *     Nodes with a mask of 0 and num_after of 0 are not allowed.
+ *
+ *   + Sum of bits set in all the nodes is equal to the value of
+ *     the struct sparsebit_pvt num_set member.
+ *
+ *   + The setting of at least one bit is always described in a nodes
+ *     mask (mask >= 1).
+ *
+ *   + A node with all mask bits set only occurs when the last bit
+ *     described by the previous node is not equal to this nodes
+ *     starting index - 1.  All such occurences of this condition are
+ *     avoided by moving the setting of the nodes mask bits into
+ *     the previous nodes num_after setting.
+ *
+ *   + Node starting index is evenly divisable by the number of bits
+ *     within a nodes mask member.
+ *
+ *   + Nodes never represent a range of bits that wrap around the
+ *     highest supported index.
+ *
+ *      (idx + MASK_BITS + num_after - 1) <= ((sparsebit_idx_t) 0) - 1)
+ *
+ *     As a consequence of the above, the num_after member of a node
+ *     will always be <=:
+ *
+ *       maximum_index - nodes_starting_index - number_of_mask_bits
+ *
+ *   + Nodes within the binary search tree are sorted based on each
+ *     nodes starting index.
+ *
+ *   + The range of bits described by any two nodes do not overlap.  The
+ *     range of bits described by a single node is:
+ *
+ *       start: node->idx
+ *       end (inclusive): node->idx + MASK_BITS + node->num_after - 1;
+ *
+ * Note, at times these invariants are temporarily violated for a
+ * specific portion of the code.  For example, when setting a mask
+ * bit, there is a small delay between when the mask bit is set and the
+ * value in the struct sparsebit_pvt num_set member is updated.  Other
+ * temporary violations occur when node_split() is called with a specified
+ * index and assures that a node where its mask represents the bit
+ * at the specified index exists.  At times to do this node_split()
+ * must split an existing node into two nodes or create a node that
+ * has no bits set.  Such temporary violations must be corrected before
+ * returning to the caller.  These corrections are typically performed
+ * by the local function node_reduce().
+ */
+
+#include "test_util.h"
+#include "sparsebit.h"
+#include <limits.h>
+#include <assert.h>
+
+#define DUMP_LINE_MAX 100 /* Does not include indent amount */
+
+typedef uint32_t mask_t;
+#define MASK_BITS (sizeof(mask_t) * CHAR_BIT)
+
+struct node {
+	struct node *parent;
+	struct node *left;
+	struct node *right;
+	sparsebit_idx_t idx; /* index of least-significant bit in mask */
+	sparsebit_num_t num_after; /* num contiguously set after mask */
+	mask_t mask;
+};
+
+struct sparsebit {
+	/*
+	 * Points to root node of the binary search
+	 * tree.  Equal to NULL when no bits are set in
+	 * the entire sparsebit array.
+	 */
+	struct node *root;
+
+	/*
+	 * A redundant count of the total number of bits set.  Used for
+	 * diagnostic purposes and to change the time complexity of
+	 * sparsebit_num_set() from O(n) to O(1).
+	 * Note: Due to overflow, a value of 0 means none or all set.
+	 */
+	sparsebit_num_t num_set;
+};
+
+/* Returns the number of set bits described by the settings
+ * of the node pointed to by nodep.
+ */
+static sparsebit_num_t node_num_set(struct node *nodep)
+{
+	return nodep->num_after + __builtin_popcount(nodep->mask);
+}
+
+/* Returns a pointer to the node that describes the
+ * lowest bit index.
+ */
+static struct node *node_first(struct sparsebit *s)
+{
+	struct node *nodep;
+
+	for (nodep = s->root; nodep && nodep->left; nodep = nodep->left)
+		;
+
+	return nodep;
+}
+
+/* Returns a pointer to the node that describes the
+ * lowest bit index > the index of the node pointed to by np.
+ * Returns NULL if no node with a higher index exists.
+ */
+static struct node *node_next(struct sparsebit *s, struct node *np)
+{
+	struct node *nodep = np;
+
+	/*
+	 * If current node has a right child, next node is the left-most
+	 * of the right child.
+	 */
+	if (nodep->right) {
+		for (nodep = nodep->right; nodep->left; nodep = nodep->left)
+			;
+		return nodep;
+	}
+
+	/*
+	 * No right child.  Go up until node is left child of a parent.
+	 * That parent is then the next node.
+	 */
+	while (nodep->parent && nodep == nodep->parent->right)
+		nodep = nodep->parent;
+
+	return nodep->parent;
+}
+
+/* Searches for and returns a pointer to the node that describes the
+ * highest index < the index of the node pointed to by np.
+ * Returns NULL if no node with a lower index exists.
+ */
+static struct node *node_prev(struct sparsebit *s, struct node *np)
+{
+	struct node *nodep = np;
+
+	/*
+	 * If current node has a left child, next node is the right-most
+	 * of the left child.
+	 */
+	if (nodep->left) {
+		for (nodep = nodep->left; nodep->right; nodep = nodep->right)
+			;
+		return (struct node *) nodep;
+	}
+
+	/*
+	 * No left child.  Go up until node is right child of a parent.
+	 * That parent is then the next node.
+	 */
+	while (nodep->parent && nodep == nodep->parent->left)
+		nodep = nodep->parent;
+
+	return (struct node *) nodep->parent;
+}
+
+
+/* Allocates space to hold a copy of the node sub-tree pointed to by
+ * subtree and duplicates the bit settings to the newly allocated nodes.
+ * Returns the newly allocated copy of subtree.
+ */
+static struct node *node_copy_subtree(struct node *subtree)
+{
+	struct node *root;
+
+	/* Duplicate the node at the root of the subtree */
+	root = calloc(1, sizeof(*root));
+	if (!root) {
+		perror("calloc");
+		abort();
+	}
+
+	root->idx = subtree->idx;
+	root->mask = subtree->mask;
+	root->num_after = subtree->num_after;
+
+	/* As needed, recursively duplicate the left and right subtrees */
+	if (subtree->left) {
+		root->left = node_copy_subtree(subtree->left);
+		root->left->parent = root;
+	}
+
+	if (subtree->right) {
+		root->right = node_copy_subtree(subtree->right);
+		root->right->parent = root;
+	}
+
+	return root;
+}
+
+/* Searches for and returns a pointer to the node that describes the setting
+ * of the bit given by idx.  A node describes the setting of a bit if its
+ * index is within the bits described by the mask bits or the number of
+ * contiguous bits set after the mask.  Returns NULL if there is no such node.
+ */
+static struct node *node_find(struct sparsebit *s, sparsebit_idx_t idx)
+{
+	struct node *nodep;
+
+	/* Find the node that describes the setting of the bit at idx */
+	for (nodep = s->root; nodep;
+	     nodep = nodep->idx > idx ? nodep->left : nodep->right) {
+		if (idx >= nodep->idx &&
+		    idx <= nodep->idx + MASK_BITS + nodep->num_after - 1)
+			break;
+	}
+
+	return nodep;
+}
+
+/* Entry Requirements:
+ *   + A node that describes the setting of idx is not already present.
+ *
+ * Adds a new node to describe the setting of the bit at the index given
+ * by idx.  Returns a pointer to the newly added node.
+ *
+ * TODO(lhuemill): Degenerate cases causes the tree to get unbalanced.
+ */
+static struct node *node_add(struct sparsebit *s, sparsebit_idx_t idx)
+{
+	struct node *nodep, *parentp, *prev;
+
+	/* Allocate and initialize the new node. */
+	nodep = calloc(1, sizeof(*nodep));
+	if (!nodep) {
+		perror("calloc");
+		abort();
+	}
+
+	nodep->idx = idx & -MASK_BITS;
+
+	/* If no nodes, set it up as the root node. */
+	if (!s->root) {
+		s->root = nodep;
+		return nodep;
+	}
+
+	/*
+	 * Find the parent where the new node should be attached
+	 * and add the node there.
+	 */
+	parentp = s->root;
+	while (true) {
+		if (idx < parentp->idx) {
+			if (!parentp->left) {
+				parentp->left = nodep;
+				nodep->parent = parentp;
+				break;
+			}
+			parentp = parentp->left;
+		} else {
+			assert(idx > parentp->idx + MASK_BITS + parentp->num_after - 1);
+			if (!parentp->right) {
+				parentp->right = nodep;
+				nodep->parent = parentp;
+				break;
+			}
+			parentp = parentp->right;
+		}
+	}
+
+	/*
+	 * Does num_after bits of previous node overlap with the mask
+	 * of the new node?  If so set the bits in the new nodes mask
+	 * and reduce the previous nodes num_after.
+	 */
+	prev = node_prev(s, nodep);
+	while (prev && prev->idx + MASK_BITS + prev->num_after - 1 >= nodep->idx) {
+		unsigned int n1 = (prev->idx + MASK_BITS + prev->num_after - 1)
+			- nodep->idx;
+		assert(prev->num_after > 0);
+		assert(n1 < MASK_BITS);
+		assert(!(nodep->mask & (1 << n1)));
+		nodep->mask |= (1 << n1);
+		prev->num_after--;
+	}
+
+	return nodep;
+}
+
+/* Returns whether all the bits in the sparsebit array are set.  */
+bool sparsebit_all_set(struct sparsebit *s)
+{
+	/*
+	 * If any nodes there must be at least one bit set.  Only case
+	 * where a bit is set and total num set is 0, is when all bits
+	 * are set.
+	 */
+	return s->root && s->num_set == 0;
+}
+
+/* Clears all bits described by the node pointed to by nodep, then
+ * removes the node.
+ */
+static void node_rm(struct sparsebit *s, struct node *nodep)
+{
+	struct node *tmp;
+	sparsebit_num_t num_set;
+
+	num_set = node_num_set(nodep);
+	assert(s->num_set >= num_set || sparsebit_all_set(s));
+	s->num_set -= node_num_set(nodep);
+
+	/* Have both left and right child */
+	if (nodep->left && nodep->right) {
+		/*
+		 * Move left children to the leftmost leaf node
+		 * of the right child.
+		 */
+		for (tmp = nodep->right; tmp->left; tmp = tmp->left)
+			;
+		tmp->left = nodep->left;
+		nodep->left = NULL;
+		tmp->left->parent = tmp;
+	}
+
+	/* Left only child */
+	if (nodep->left) {
+		if (!nodep->parent) {
+			s->root = nodep->left;
+			nodep->left->parent = NULL;
+		} else {
+			nodep->left->parent = nodep->parent;
+			if (nodep == nodep->parent->left)
+				nodep->parent->left = nodep->left;
+			else {
+				assert(nodep == nodep->parent->right);
+				nodep->parent->right = nodep->left;
+			}
+		}
+
+		nodep->parent = nodep->left = nodep->right = NULL;
+		free(nodep);
+
+		return;
+	}
+
+
+	/* Right only child */
+	if (nodep->right) {
+		if (!nodep->parent) {
+			s->root = nodep->right;
+			nodep->right->parent = NULL;
+		} else {
+			nodep->right->parent = nodep->parent;
+			if (nodep == nodep->parent->left)
+				nodep->parent->left = nodep->right;
+			else {
+				assert(nodep == nodep->parent->right);
+				nodep->parent->right = nodep->right;
+			}
+		}
+
+		nodep->parent = nodep->left = nodep->right = NULL;
+		free(nodep);
+
+		return;
+	}
+
+	/* Leaf Node */
+	if (!nodep->parent) {
+		s->root = NULL;
+	} else {
+		if (nodep->parent->left == nodep)
+			nodep->parent->left = NULL;
+		else {
+			assert(nodep == nodep->parent->right);
+			nodep->parent->right = NULL;
+		}
+	}
+
+	nodep->parent = nodep->left = nodep->right = NULL;
+	free(nodep);
+
+	return;
+}
+
+/* Splits the node containing the bit at idx so that there is a node
+ * that starts at the specified index.  If no such node exists, a new
+ * node at the specified index is created.  Returns the new node.
+ *
+ * idx must start of a mask boundary.
+ */
+static struct node *node_split(struct sparsebit *s, sparsebit_idx_t idx)
+{
+	struct node *nodep1, *nodep2;
+	sparsebit_idx_t offset;
+	sparsebit_num_t orig_num_after;
+
+	assert(!(idx % MASK_BITS));
+
+	/*
+	 * Is there a node that describes the setting of idx?
+	 * If not, add it.
+	 */
+	nodep1 = node_find(s, idx);
+	if (!nodep1)
+		return node_add(s, idx);
+
+	/*
+	 * All done if the starting index of the node is where the
+	 * split should occur.
+	 */
+	if (nodep1->idx == idx)
+		return nodep1;
+
+	/*
+	 * Split point not at start of mask, so it must be part of
+	 * bits described by num_after.
+	 */
+
+	/*
+	 * Calculate offset within num_after for where the split is
+	 * to occur.
+	 */
+	offset = idx - (nodep1->idx + MASK_BITS);
+	orig_num_after = nodep1->num_after;
+
+	/*
+	 * Add a new node to describe the bits starting at
+	 * the split point.
+	 */
+	nodep1->num_after = offset;
+	nodep2 = node_add(s, idx);
+
+	/* Move bits after the split point into the new node */
+	nodep2->num_after = orig_num_after - offset;
+	if (nodep2->num_after >= MASK_BITS) {
+		nodep2->mask = ~(mask_t) 0;
+		nodep2->num_after -= MASK_BITS;
+	} else {
+		nodep2->mask = (1 << nodep2->num_after) - 1;
+		nodep2->num_after = 0;
+	}
+
+	return nodep2;
+}
+
+/* Iteratively reduces the node pointed to by nodep and its adjacent
+ * nodes into a more compact form.  For example, a node with a mask with
+ * all bits set adjacent to a previous node, will get combined into a
+ * single node with an increased num_after setting.
+ *
+ * After each reduction, a further check is made to see if additional
+ * reductions are possible with the new previous and next nodes.  Note,
+ * a search for a reduction is only done across the nodes nearest nodep
+ * and those that became part of a reduction.  Reductions beyond nodep
+ * and the adjacent nodes that are reduced are not discovered.  It is the
+ * responsibility of the caller to pass a nodep that is within one node
+ * of each possible reduction.
+ *
+ * This function does not fix the temporary violation of all invariants.
+ * For example it does not fix the case where the bit settings described
+ * by two or more nodes overlap.  Such a violation introduces the potential
+ * complication of a bit setting for a specific index having different settings
+ * in different nodes.  This would then introduce the further complication
+ * of which node has the correct setting of the bit and thus such conditions
+ * are not allowed.
+ *
+ * This function is designed to fix invariant violations that are introduced
+ * by node_split() and by changes to the nodes mask or num_after members.
+ * For example, when setting a bit within a nodes mask, the function that
+ * sets the bit doesn't have to worry about whether the setting of that
+ * bit caused the mask to have leading only or trailing only bits set.
+ * Instead, the function can call node_reduce(), with nodep equal to the
+ * node address that it set a mask bit in, and node_reduce() will notice
+ * the cases of leading or trailing only bits and that there is an
+ * adjacent node that the bit settings could be merged into.
+ *
+ * This implementation specifically detects and corrects violation of the
+ * following invariants:
+ *
+ *   + Node are only used to represent bits that are set.
+ *     Nodes with a mask of 0 and num_after of 0 are not allowed.
+ *
+ *   + The setting of at least one bit is always described in a nodes
+ *     mask (mask >= 1).
+ *
+ *   + A node with all mask bits set only occurs when the last bit
+ *     described by the previous node is not equal to this nodes
+ *     starting index - 1.  All such occurences of this condition are
+ *     avoided by moving the setting of the nodes mask bits into
+ *     the previous nodes num_after setting.
+ */
+static void node_reduce(struct sparsebit *s, struct node *nodep)
+{
+	bool reduction_performed;
+
+	do {
+		reduction_performed = false;
+		struct node *prev, *next, *tmp;
+
+		/* 1) Potential reductions within the current node. */
+
+		/* Nodes with all bits cleared may be removed. */
+		if (nodep->mask == 0 && nodep->num_after == 0) {
+			/*
+			 * About to remove the node pointed to by
+			 * nodep, which normally would cause a problem
+			 * for the next pass through the reduction loop,
+			 * because the node at the starting point no longer
+			 * exists.  This potential problem is handled
+			 * by first remembering the location of the next
+			 * or previous nodes.  Doesn't matter which, because
+			 * once the node at nodep is removed, there will be
+			 * no other nodes between prev and next.
+			 *
+			 * Note, the checks performed on nodep against both
+			 * both prev and next both check for an adjacent
+			 * node that can be reduced into a single node.  As
+			 * such, after removing the node at nodep, doesn't
+			 * matter whether the nodep for the next pass
+			 * through the loop is equal to the previous pass
+			 * prev or next node.  Either way, on the next pass
+			 * the one not selected will become either the
+			 * prev or next node.
+			 */
+			tmp = node_next(s, nodep);
+			if (!tmp)
+				tmp = node_prev(s, nodep);
+
+			node_rm(s, nodep);
+			nodep = NULL;
+
+			nodep = tmp;
+			reduction_performed = true;
+			continue;
+		}
+
+		/*
+		 * When the mask is 0, can reduce the amount of num_after
+		 * bits by moving the initial num_after bits into the mask.
+		 */
+		if (nodep->mask == 0) {
+			assert(nodep->num_after != 0);
+			assert(nodep->idx + MASK_BITS > nodep->idx);
+
+			nodep->idx += MASK_BITS;
+
+			if (nodep->num_after >= MASK_BITS) {
+				nodep->mask = ~0;
+				nodep->num_after -= MASK_BITS;
+			} else {
+				nodep->mask = (1u << nodep->num_after) - 1;
+				nodep->num_after = 0;
+			}
+
+			reduction_performed = true;
+			continue;
+		}
+
+		/*
+		 * 2) Potential reductions between the current and
+		 * previous nodes.
+		 */
+		prev = node_prev(s, nodep);
+		if (prev) {
+			sparsebit_idx_t prev_highest_bit;
+
+			/* Nodes with no bits set can be removed. */
+			if (prev->mask == 0 && prev->num_after == 0) {
+				node_rm(s, prev);
+
+				reduction_performed = true;
+				continue;
+			}
+
+			/*
+			 * All mask bits set and previous node has
+			 * adjacent index.
+			 */
+			if (nodep->mask + 1 == 0 &&
+			    prev->idx + MASK_BITS == nodep->idx) {
+				prev->num_after += MASK_BITS + nodep->num_after;
+				nodep->mask = 0;
+				nodep->num_after = 0;
+
+				reduction_performed = true;
+				continue;
+			}
+
+			/*
+			 * Is node adjacent to previous node and the node
+			 * contains a single contiguous range of bits
+			 * starting from the beginning of the mask?
+			 */
+			prev_highest_bit = prev->idx + MASK_BITS - 1 + prev->num_after;
+			if (prev_highest_bit + 1 == nodep->idx &&
+			    (nodep->mask | (nodep->mask >> 1)) == nodep->mask) {
+				/*
+				 * How many contiguous bits are there?
+				 * Is equal to the total number of set
+				 * bits, due to an earlier check that
+				 * there is a single contiguous range of
+				 * set bits.
+				 */
+				unsigned int num_contiguous
+					= __builtin_popcount(nodep->mask);
+				assert((num_contiguous > 0) &&
+				       ((1ULL << num_contiguous) - 1) == nodep->mask);
+
+				prev->num_after += num_contiguous;
+				nodep->mask = 0;
+
+				/*
+				 * For predictable performance, handle special
+				 * case where all mask bits are set and there
+				 * is a non-zero num_after setting.  This code
+				 * is functionally correct without the following
+				 * conditionalized statements, but without them
+				 * the value of num_after is only reduced by
+				 * the number of mask bits per pass.  There are
+				 * cases where num_after can be close to 2^64.
+				 * Without this code it could take nearly
+				 * (2^64) / 32 passes to perform the full
+				 * reduction.
+				 */
+				if (num_contiguous == MASK_BITS) {
+					prev->num_after += nodep->num_after;
+					nodep->num_after = 0;
+				}
+
+				reduction_performed = true;
+				continue;
+			}
+		}
+
+		/*
+		 * 3) Potential reductions between the current and
+		 * next nodes.
+		 */
+		next = node_next(s, nodep);
+		if (next) {
+			/* Nodes with no bits set can be removed. */
+			if (next->mask == 0 && next->num_after == 0) {
+				node_rm(s, next);
+				reduction_performed = true;
+				continue;
+			}
+
+			/*
+			 * Is next node index adjacent to current node
+			 * and has a mask with all bits set?
+			 */
+			if (next->idx == nodep->idx + MASK_BITS + nodep->num_after &&
+			    next->mask == ~(mask_t) 0) {
+				nodep->num_after += MASK_BITS;
+				next->mask = 0;
+				nodep->num_after += next->num_after;
+				next->num_after = 0;
+
+				node_rm(s, next);
+				next = NULL;
+
+				reduction_performed = true;
+				continue;
+			}
+		}
+	} while (nodep && reduction_performed);
+}
+
+/* Returns whether the bit at the index given by idx, within the
+ * sparsebit array is set or not.
+ */
+bool sparsebit_is_set(struct sparsebit *s, sparsebit_idx_t idx)
+{
+	struct node *nodep;
+
+	/* Find the node that describes the setting of the bit at idx */
+	for (nodep = s->root; nodep;
+	     nodep = nodep->idx > idx ? nodep->left : nodep->right)
+		if (idx >= nodep->idx &&
+		    idx <= nodep->idx + MASK_BITS + nodep->num_after - 1)
+			goto have_node;
+
+	return false;
+
+have_node:
+	/* Bit is set if it is any of the bits described by num_after */
+	if (nodep->num_after && idx >= nodep->idx + MASK_BITS)
+		return true;
+
+	/* Is the corresponding mask bit set */
+	assert(idx >= nodep->idx && idx - nodep->idx < MASK_BITS);
+	return !!(nodep->mask & (1 << (idx - nodep->idx)));
+}
+
+/* Within the sparsebit array pointed to by s, sets the bit
+ * at the index given by idx.
+ */
+static void bit_set(struct sparsebit *s, sparsebit_idx_t idx)
+{
+	struct node *nodep;
+
+	/* Skip bits that are already set */
+	if (sparsebit_is_set(s, idx))
+		return;
+
+	/*
+	 * Get a node where the bit at idx is described by the mask.
+	 * The node_split will also create a node, if there isn't
+	 * already a node that describes the setting of bit.
+	 */
+	nodep = node_split(s, idx & -MASK_BITS);
+
+	/* Set the bit within the nodes mask */
+	assert(idx >= nodep->idx && idx <= nodep->idx + MASK_BITS - 1);
+	assert(!(nodep->mask & (1 << (idx - nodep->idx))));
+	nodep->mask |= 1 << (idx - nodep->idx);
+	s->num_set++;
+
+	node_reduce(s, nodep);
+}
+
+/* Within the sparsebit array pointed to by s, clears the bit
+ * at the index given by idx.
+ */
+static void bit_clear(struct sparsebit *s, sparsebit_idx_t idx)
+{
+	struct node *nodep;
+
+	/* Skip bits that are already cleared */
+	if (!sparsebit_is_set(s, idx))
+		return;
+
+	/* Is there a node that describes the setting of this bit? */
+	nodep = node_find(s, idx);
+	if (!nodep)
+		return;
+
+	/*
+	 * If a num_after bit, split the node, so that the bit is
+	 * part of a node mask.
+	 */
+	if (idx >= nodep->idx + MASK_BITS)
+		nodep = node_split(s, idx & -MASK_BITS);
+
+	/*
+	 * After node_split above, bit at idx should be within the mask.
+	 * Clear that bit.
+	 */
+	assert(idx >= nodep->idx && idx <= nodep->idx + MASK_BITS - 1);
+	assert(nodep->mask & (1 << (idx - nodep->idx)));
+	nodep->mask &= ~(1 << (idx - nodep->idx));
+	assert(s->num_set > 0 || sparsebit_all_set(s));
+	s->num_set--;
+
+	node_reduce(s, nodep);
+}
+
+/* Recursively dumps to the FILE stream given by stream the contents
+ * of the sub-tree of nodes pointed to by nodep.  Each line of output
+ * is prefixed by the number of spaces given by indent.  On each
+ * recursion, the indent amount is increased by 2.  This causes nodes
+ * at each level deeper into the binary search tree to be displayed
+ * with a greater indent.
+ */
+static void dump_nodes(FILE *stream, struct node *nodep,
+	unsigned int indent)
+{
+	char *node_type;
+
+	/* Dump contents of node */
+	if (!nodep->parent)
+		node_type = "root";
+	else if (nodep == nodep->parent->left)
+		node_type = "left";
+	else {
+		assert(nodep == nodep->parent->right);
+		node_type = "right";
+	}
+	fprintf(stream, "%*s---- %s nodep: %p\n", indent, "", node_type, nodep);
+	fprintf(stream, "%*s  parent: %p left: %p right: %p\n", indent, "",
+		nodep->parent, nodep->left, nodep->right);
+	fprintf(stream, "%*s  idx: 0x%lx mask: 0x%x num_after: 0x%lx\n",
+		indent, "", nodep->idx, nodep->mask, nodep->num_after);
+
+	/* If present, dump contents of left child nodes */
+	if (nodep->left)
+		dump_nodes(stream, nodep->left, indent + 2);
+
+	/* If present, dump contents of right child nodes */
+	if (nodep->right)
+		dump_nodes(stream, nodep->right, indent + 2);
+}
+
+static inline sparsebit_idx_t node_first_set(struct node *nodep, int start)
+{
+	mask_t leading = (mask_t)1 << start;
+	int n1 = __builtin_ctz(nodep->mask & -leading);
+
+	return nodep->idx + n1;
+}
+
+static inline sparsebit_idx_t node_first_clear(struct node *nodep, int start)
+{
+	mask_t leading = (mask_t)1 << start;
+	int n1 = __builtin_ctz(~nodep->mask & -leading);
+
+	return nodep->idx + n1;
+}
+
+/* Dumps to the FILE stream specified by stream, the implementation dependent
+ * internal state of s.  Each line of output is prefixed with the number
+ * of spaces given by indent.  The output is completely implementation
+ * dependent and subject to change.  Output from this function should only
+ * be used for diagnostic purposes.  For example, this function can be
+ * used by test cases after they detect an unexpected condition, as a means
+ * to capture diagnostic information.
+ */
+static void sparsebit_dump_internal(FILE *stream, struct sparsebit *s,
+	unsigned int indent)
+{
+	/* Dump the contents of s */
+	fprintf(stream, "%*sroot: %p\n", indent, "", s->root);
+	fprintf(stream, "%*snum_set: 0x%lx\n", indent, "", s->num_set);
+
+	if (s->root)
+		dump_nodes(stream, s->root, indent);
+}
+
+/* Allocates and returns a new sparsebit array. The initial state
+ * of the newly allocated sparsebit array has all bits cleared.
+ */
+struct sparsebit *sparsebit_alloc(void)
+{
+	struct sparsebit *s;
+
+	/* Allocate top level structure. */
+	s = calloc(1, sizeof(*s));
+	if (!s) {
+		perror("calloc");
+		abort();
+	}
+
+	return s;
+}
+
+/* Frees the implementation dependent data for the sparsebit array
+ * pointed to by s and poisons the pointer to that data.
+ */
+void sparsebit_free(struct sparsebit **sbitp)
+{
+	struct sparsebit *s = *sbitp;
+
+	if (!s)
+		return;
+
+	sparsebit_clear_all(s);
+	free(s);
+	*sbitp = NULL;
+}
+
+/* Makes a copy of the sparsebit array given by s, to the sparsebit
+ * array given by d.  Note, d must have already been allocated via
+ * sparsebit_alloc().  It can though already have bits set, which
+ * if different from src will be cleared.
+ */
+void sparsebit_copy(struct sparsebit *d, struct sparsebit *s)
+{
+	/* First clear any bits already set in the destination */
+	sparsebit_clear_all(d);
+
+	if (s->root) {
+		d->root = node_copy_subtree(s->root);
+		d->num_set = s->num_set;
+	}
+}
+
+/* Returns whether num consecutive bits starting at idx are all set.  */
+bool sparsebit_is_set_num(struct sparsebit *s,
+	sparsebit_idx_t idx, sparsebit_num_t num)
+{
+	sparsebit_idx_t next_cleared;
+
+	assert(num > 0);
+	assert(idx + num - 1 >= idx);
+
+	/* With num > 0, the first bit must be set. */
+	if (!sparsebit_is_set(s, idx))
+		return false;
+
+	/* Find the next cleared bit */
+	next_cleared = sparsebit_next_clear(s, idx);
+
+	/*
+	 * If no cleared bits beyond idx, then there are at least num
+	 * set bits. idx + num doesn't wrap.  Otherwise check if
+	 * there are enough set bits between idx and the next cleared bit.
+	 */
+	return next_cleared == 0 || next_cleared - idx >= num;
+}
+
+/* Returns whether the bit at the index given by idx.  */
+bool sparsebit_is_clear(struct sparsebit *s,
+	sparsebit_idx_t idx)
+{
+	return !sparsebit_is_set(s, idx);
+}
+
+/* Returns whether num consecutive bits starting at idx are all cleared.  */
+bool sparsebit_is_clear_num(struct sparsebit *s,
+	sparsebit_idx_t idx, sparsebit_num_t num)
+{
+	sparsebit_idx_t next_set;
+
+	assert(num > 0);
+	assert(idx + num - 1 >= idx);
+
+	/* With num > 0, the first bit must be cleared. */
+	if (!sparsebit_is_clear(s, idx))
+		return false;
+
+	/* Find the next set bit */
+	next_set = sparsebit_next_set(s, idx);
+
+	/*
+	 * If no set bits beyond idx, then there are at least num
+	 * cleared bits. idx + num doesn't wrap.  Otherwise check if
+	 * there are enough cleared bits between idx and the next set bit.
+	 */
+	return next_set == 0 || next_set - idx >= num;
+}
+
+/* Returns the total number of bits set.  Note: 0 is also returned for
+ * the case of all bits set.  This is because with all bits set, there
+ * is 1 additional bit set beyond what can be represented in the return
+ * value.  Use sparsebit_any_set(), instead of sparsebit_num_set() > 0,
+ * to determine if the sparsebit array has any bits set.
+ */
+sparsebit_num_t sparsebit_num_set(struct sparsebit *s)
+{
+	return s->num_set;
+}
+
+/* Returns whether any bit is set in the sparsebit array.  */
+bool sparsebit_any_set(struct sparsebit *s)
+{
+	/*
+	 * Nodes only describe set bits.  If any nodes then there
+	 * is at least 1 bit set.
+	 */
+	if (!s->root)
+		return false;
+
+	/*
+	 * Every node should have a non-zero mask.  For now will
+	 * just assure that the root node has a non-zero mask,
+	 * which is a quick check that at least 1 bit is set.
+	 */
+	assert(s->root->mask != 0);
+	assert(s->num_set > 0 ||
+	       (s->root->num_after == ((sparsebit_num_t) 0) - MASK_BITS &&
+		s->root->mask == ~(mask_t) 0));
+
+	return true;
+}
+
+/* Returns whether all the bits in the sparsebit array are cleared.  */
+bool sparsebit_all_clear(struct sparsebit *s)
+{
+	return !sparsebit_any_set(s);
+}
+
+/* Returns whether all the bits in the sparsebit array are set.  */
+bool sparsebit_any_clear(struct sparsebit *s)
+{
+	return !sparsebit_all_set(s);
+}
+
+/* Returns the index of the first set bit.  Abort if no bits are set.
+ */
+sparsebit_idx_t sparsebit_first_set(struct sparsebit *s)
+{
+	struct node *nodep;
+
+	/* Validate at least 1 bit is set */
+	assert(sparsebit_any_set(s));
+
+	nodep = node_first(s);
+	return node_first_set(nodep, 0);
+}
+
+/* Returns the index of the first cleared bit.  Abort if
+ * no bits are cleared.
+ */
+sparsebit_idx_t sparsebit_first_clear(struct sparsebit *s)
+{
+	struct node *nodep1, *nodep2;
+
+	/* Validate at least 1 bit is cleared. */
+	assert(sparsebit_any_clear(s));
+
+	/* If no nodes or first node index > 0 then lowest cleared is 0 */
+	nodep1 = node_first(s);
+	if (!nodep1 || nodep1->idx > 0)
+		return 0;
+
+	/* Does the mask in the first node contain any cleared bits. */
+	if (nodep1->mask != ~(mask_t) 0)
+		return node_first_clear(nodep1, 0);
+
+	/*
+	 * All mask bits set in first node.  If there isn't a second node
+	 * then the first cleared bit is the first bit after the bits
+	 * described by the first node.
+	 */
+	nodep2 = node_next(s, nodep1);
+	if (!nodep2) {
+		/*
+		 * No second node.  First cleared bit is first bit beyond
+		 * bits described by first node.
+		 */
+		assert(nodep1->mask == ~(mask_t) 0);
+		assert(nodep1->idx + MASK_BITS + nodep1->num_after != (sparsebit_idx_t) 0);
+		return nodep1->idx + MASK_BITS + nodep1->num_after;
+	}
+
+	/*
+	 * There is a second node.
+	 * If it is not adjacent to the first node, then there is a gap
+	 * of cleared bits between the nodes, and the first cleared bit
+	 * is the first bit within the gap.
+	 */
+	if (nodep1->idx + MASK_BITS + nodep1->num_after != nodep2->idx)
+		return nodep1->idx + MASK_BITS + nodep1->num_after;
+
+	/*
+	 * Second node is adjacent to the first node.
+	 * Because it is adjacent, its mask should be non-zero.  If all
+	 * its mask bits are set, then with it being adjacent, it should
+	 * have had the mask bits moved into the num_after setting of the
+	 * previous node.
+	 */
+	return node_first_clear(nodep2, 0);
+}
+
+/* Returns index of next bit set within s after the index given by prev.
+ * Returns 0 if there are no bits after prev that are set.
+ */
+sparsebit_idx_t sparsebit_next_set(struct sparsebit *s,
+	sparsebit_idx_t prev)
+{
+	sparsebit_idx_t lowest_possible = prev + 1;
+	sparsebit_idx_t start;
+	struct node *nodep;
+
+	/* A bit after the highest index can't be set. */
+	if (lowest_possible == 0)
+		return 0;
+
+	/*
+	 * Find the leftmost 'candidate' overlapping or to the right
+	 * of lowest_possible.
+	 */
+	struct node *candidate = NULL;
+
+	/* True iff lowest_possible is within candidate */
+	bool contains = false;
+
+	/*
+	 * Find node that describes setting of bit at lowest_possible.
+	 * If such a node doesn't exist, find the node with the lowest
+	 * starting index that is > lowest_possible.
+	 */
+	for (nodep = s->root; nodep;) {
+		if ((nodep->idx + MASK_BITS + nodep->num_after - 1)
+			>= lowest_possible) {
+			candidate = nodep;
+			if (candidate->idx <= lowest_possible) {
+				contains = true;
+				break;
+			}
+			nodep = nodep->left;
+		} else {
+			nodep = nodep->right;
+		}
+	}
+	if (!candidate)
+		return 0;
+
+	assert(candidate->mask != 0);
+
+	/* Does the candidate node describe the setting of lowest_possible? */
+	if (!contains) {
+		/*
+		 * Candidate doesn't describe setting of bit at lowest_possible.
+		 * Candidate points to the first node with a starting index
+		 * > lowest_possible.
+		 */
+		assert(candidate->idx > lowest_possible);
+
+		return node_first_set(candidate, 0);
+	}
+
+	/*
+	 * Candidate describes setting of bit at lowest_possible.
+	 * Note: although the node describes the setting of the bit
+	 * at lowest_possible, its possible that its setting and the
+	 * setting of all latter bits described by this node are 0.
+	 * For now, just handle the cases where this node describes
+	 * a bit at or after an index of lowest_possible that is set.
+	 */
+	start = lowest_possible - candidate->idx;
+
+	if (start < MASK_BITS && candidate->mask >= (1 << start))
+		return node_first_set(candidate, start);
+
+	if (candidate->num_after) {
+		sparsebit_idx_t first_num_after_idx = candidate->idx + MASK_BITS;
+
+		return lowest_possible < first_num_after_idx
+			? first_num_after_idx : lowest_possible;
+	}
+
+	/*
+	 * Although candidate node describes setting of bit at
+	 * the index of lowest_possible, all bits at that index and
+	 * latter that are described by candidate are cleared.  With
+	 * this, the next bit is the first bit in the next node, if
+	 * such a node exists.  If a next node doesn't exist, then
+	 * there is no next set bit.
+	 */
+	candidate = node_next(s, candidate);
+	if (!candidate)
+		return 0;
+
+	return node_first_set(candidate, 0);
+}
+
+/* Returns index of next bit cleared within s after the index given by prev.
+ * Returns 0 if there are no bits after prev that are cleared.
+ */
+sparsebit_idx_t sparsebit_next_clear(struct sparsebit *s,
+	sparsebit_idx_t prev)
+{
+	sparsebit_idx_t lowest_possible = prev + 1;
+	sparsebit_idx_t idx;
+	struct node *nodep1, *nodep2;
+
+	/* A bit after the highest index can't be set. */
+	if (lowest_possible == 0)
+		return 0;
+
+	/*
+	 * Does a node describing the setting of lowest_possible exist?
+	 * If not, the bit at lowest_possible is cleared.
+	 */
+	nodep1 = node_find(s, lowest_possible);
+	if (!nodep1)
+		return lowest_possible;
+
+	/* Does a mask bit in node 1 describe the next cleared bit. */
+	for (idx = lowest_possible - nodep1->idx; idx < MASK_BITS; idx++)
+		if (!(nodep1->mask & (1 << idx)))
+			return nodep1->idx + idx;
+
+	/*
+	 * Next cleared bit is not described by node 1.  If there
+	 * isn't a next node, then next cleared bit is described
+	 * by bit after the bits described by the first node.
+	 */
+	nodep2 = node_next(s, nodep1);
+	if (!nodep2)
+		return nodep1->idx + MASK_BITS + nodep1->num_after;
+
+	/*
+	 * There is a second node.
+	 * If it is not adjacent to the first node, then there is a gap
+	 * of cleared bits between the nodes, and the next cleared bit
+	 * is the first bit within the gap.
+	 */
+	if (nodep1->idx + MASK_BITS + nodep1->num_after != nodep2->idx)
+		return nodep1->idx + MASK_BITS + nodep1->num_after;
+
+	/*
+	 * Second node is adjacent to the first node.
+	 * Because it is adjacent, its mask should be non-zero.  If all
+	 * its mask bits are set, then with it being adjacent, it should
+	 * have had the mask bits moved into the num_after setting of the
+	 * previous node.
+	 */
+	return node_first_clear(nodep2, 0);
+}
+
+/* Starting with the index 1 greater than the index given by start, finds
+ * and returns the index of the first sequence of num consecutively set
+ * bits.  Returns a value of 0 of no such sequence exists.
+ */
+sparsebit_idx_t sparsebit_next_set_num(struct sparsebit *s,
+	sparsebit_idx_t start, sparsebit_num_t num)
+{
+	sparsebit_idx_t idx;
+
+	assert(num >= 1);
+
+	for (idx = sparsebit_next_set(s, start);
+		idx != 0 && idx + num - 1 >= idx;
+		idx = sparsebit_next_set(s, idx)) {
+		assert(sparsebit_is_set(s, idx));
+
+		/*
+		 * Does the sequence of bits starting at idx consist of
+		 * num set bits?
+		 */
+		if (sparsebit_is_set_num(s, idx, num))
+			return idx;
+
+		/*
+		 * Sequence of set bits at idx isn't large enough.
+		 * Skip this entire sequence of set bits.
+		 */
+		idx = sparsebit_next_clear(s, idx);
+		if (idx == 0)
+			return 0;
+	}
+
+	return 0;
+}
+
+/* Starting with the index 1 greater than the index given by start, finds
+ * and returns the index of the first sequence of num consecutively cleared
+ * bits.  Returns a value of 0 of no such sequence exists.
+ */
+sparsebit_idx_t sparsebit_next_clear_num(struct sparsebit *s,
+	sparsebit_idx_t start, sparsebit_num_t num)
+{
+	sparsebit_idx_t idx;
+
+	assert(num >= 1);
+
+	for (idx = sparsebit_next_clear(s, start);
+		idx != 0 && idx + num - 1 >= idx;
+		idx = sparsebit_next_clear(s, idx)) {
+		assert(sparsebit_is_clear(s, idx));
+
+		/*
+		 * Does the sequence of bits starting at idx consist of
+		 * num cleared bits?
+		 */
+		if (sparsebit_is_clear_num(s, idx, num))
+			return idx;
+
+		/*
+		 * Sequence of cleared bits at idx isn't large enough.
+		 * Skip this entire sequence of cleared bits.
+		 */
+		idx = sparsebit_next_set(s, idx);
+		if (idx == 0)
+			return 0;
+	}
+
+	return 0;
+}
+
+/* Sets the bits * in the inclusive range idx through idx + num - 1.  */
+void sparsebit_set_num(struct sparsebit *s,
+	sparsebit_idx_t start, sparsebit_num_t num)
+{
+	struct node *nodep, *next;
+	unsigned int n1;
+	sparsebit_idx_t idx;
+	sparsebit_num_t n;
+	sparsebit_idx_t middle_start, middle_end;
+
+	assert(num > 0);
+	assert(start + num - 1 >= start);
+
+	/*
+	 * Leading - bits before first mask boundary.
+	 *
+	 * TODO(lhuemill): With some effort it may be possible to
+	 *   replace the following loop with a sequential sequence
+	 *   of statements.  High level sequence would be:
+	 *
+	 *     1. Use node_split() to force node that describes setting
+	 *        of idx to be within the mask portion of a node.
+	 *     2. Form mask of bits to be set.
+	 *     3. Determine number of mask bits already set in the node
+	 *        and store in a local variable named num_already_set.
+	 *     4. Set the appropriate mask bits within the node.
+	 *     5. Increment struct sparsebit_pvt num_set member
+	 *        by the number of bits that were actually set.
+	 *        Exclude from the counts bits that were already set.
+	 *     6. Before returning to the caller, use node_reduce() to
+	 *        handle the multiple corner cases that this method
+	 *        introduces.
+	 */
+	for (idx = start, n = num; n > 0 && idx % MASK_BITS != 0; idx++, n--)
+		bit_set(s, idx);
+
+	/* Middle - bits spanning one or more entire mask */
+	middle_start = idx;
+	middle_end = middle_start + (n & -MASK_BITS) - 1;
+	if (n >= MASK_BITS) {
+		nodep = node_split(s, middle_start);
+
+		/*
+		 * As needed, split just after end of middle bits.
+		 * No split needed if end of middle bits is at highest
+		 * supported bit index.
+		 */
+		if (middle_end + 1 > middle_end)
+			(void) node_split(s, middle_end + 1);
+
+		/* Delete nodes that only describe bits within the middle. */
+		for (next = node_next(s, nodep);
+			next && (next->idx < middle_end);
+			next = node_next(s, nodep)) {
+			assert(next->idx + MASK_BITS + next->num_after - 1 <= middle_end);
+			node_rm(s, next);
+			next = NULL;
+		}
+
+		/* As needed set each of the mask bits */
+		for (n1 = 0; n1 < MASK_BITS; n1++) {
+			if (!(nodep->mask & (1 << n1))) {
+				nodep->mask |= 1 << n1;
+				s->num_set++;
+			}
+		}
+
+		s->num_set -= nodep->num_after;
+		nodep->num_after = middle_end - middle_start + 1 - MASK_BITS;
+		s->num_set += nodep->num_after;
+
+		node_reduce(s, nodep);
+	}
+	idx = middle_end + 1;
+	n -= middle_end - middle_start + 1;
+
+	/* Trailing - bits at and beyond last mask boundary */
+	assert(n < MASK_BITS);
+	for (; n > 0; idx++, n--)
+		bit_set(s, idx);
+}
+
+/* Clears the bits * in the inclusive range idx through idx + num - 1.  */
+void sparsebit_clear_num(struct sparsebit *s,
+	sparsebit_idx_t start, sparsebit_num_t num)
+{
+	struct node *nodep, *next;
+	unsigned int n1;
+	sparsebit_idx_t idx;
+	sparsebit_num_t n;
+	sparsebit_idx_t middle_start, middle_end;
+
+	assert(num > 0);
+	assert(start + num - 1 >= start);
+
+	/* Leading - bits before first mask boundary */
+	for (idx = start, n = num; n > 0 && idx % MASK_BITS != 0; idx++, n--)
+		bit_clear(s, idx);
+
+	/* Middle - bits spanning one or more entire mask */
+	middle_start = idx;
+	middle_end = middle_start + (n & -MASK_BITS) - 1;
+	if (n >= MASK_BITS) {
+		nodep = node_split(s, middle_start);
+
+		/*
+		 * As needed, split just after end of middle bits.
+		 * No split needed if end of middle bits is at highest
+		 * supported bit index.
+		 */
+		if (middle_end + 1 > middle_end)
+			(void) node_split(s, middle_end + 1);
+
+		/* Delete nodes that only describe bits within the middle. */
+		for (next = node_next(s, nodep);
+			next && (next->idx < middle_end);
+			next = node_next(s, nodep)) {
+			assert(next->idx + MASK_BITS + next->num_after - 1 <= middle_end);
+			node_rm(s, next);
+			next = NULL;
+		}
+
+		/* As needed clear each of the mask bits */
+		for (n1 = 0; n1 < MASK_BITS; n1++) {
+			if (nodep->mask & (1 << n1)) {
+				nodep->mask &= ~(1 << n1);
+				s->num_set--;
+			}
+		}
+
+		/* Clear any bits described by num_after */
+		s->num_set -= nodep->num_after;
+		nodep->num_after = 0;
+
+		/*
+		 * Delete the node that describes the beginning of
+		 * the middle bits and perform any allowed reductions
+		 * with the nodes prev or next of nodep.
+		 */
+		node_reduce(s, nodep);
+		nodep = NULL;
+	}
+	idx = middle_end + 1;
+	n -= middle_end - middle_start + 1;
+
+	/* Trailing - bits at and beyond last mask boundary */
+	assert(n < MASK_BITS);
+	for (; n > 0; idx++, n--)
+		bit_clear(s, idx);
+}
+
+/* Sets the bit at the index given by idx.  */
+void sparsebit_set(struct sparsebit *s, sparsebit_idx_t idx)
+{
+	sparsebit_set_num(s, idx, 1);
+}
+
+/* Clears the bit at the index given by idx.  */
+void sparsebit_clear(struct sparsebit *s, sparsebit_idx_t idx)
+{
+	sparsebit_clear_num(s, idx, 1);
+}
+
+/* Sets the bits in the entire addressable range of the sparsebit array.  */
+void sparsebit_set_all(struct sparsebit *s)
+{
+	sparsebit_set(s, 0);
+	sparsebit_set_num(s, 1, ~(sparsebit_idx_t) 0);
+	assert(sparsebit_all_set(s));
+}
+
+/* Clears the bits in the entire addressable range of the sparsebit array.  */
+void sparsebit_clear_all(struct sparsebit *s)
+{
+	sparsebit_clear(s, 0);
+	sparsebit_clear_num(s, 1, ~(sparsebit_idx_t) 0);
+	assert(!sparsebit_any_set(s));
+}
+
+static size_t display_range(FILE *stream, sparsebit_idx_t low,
+	sparsebit_idx_t high, bool prepend_comma_space)
+{
+	char *fmt_str;
+	size_t sz;
+
+	/* Determine the printf format string */
+	if (low == high)
+		fmt_str = prepend_comma_space ? ", 0x%lx" : "0x%lx";
+	else
+		fmt_str = prepend_comma_space ? ", 0x%lx:0x%lx" : "0x%lx:0x%lx";
+
+	/*
+	 * When stream is NULL, just determine the size of what would
+	 * have been printed, else print the range.
+	 */
+	if (!stream)
+		sz = snprintf(NULL, 0, fmt_str, low, high);
+	else
+		sz = fprintf(stream, fmt_str, low, high);
+
+	return sz;
+}
+
+
+/* Dumps to the FILE stream given by stream, the bit settings
+ * of s.  Each line of output is prefixed with the number of
+ * spaces given by indent.  The length of each line is implementation
+ * dependent and does not depend on the indent amount.  The following
+ * is an example output of a sparsebit array that has bits:
+ *
+ *   0x5, 0x8, 0xa:0xe, 0x12
+ *
+ * This corresponds to a sparsebit whose bits 5, 8, 10, 11, 12, 13, 14, 18
+ * are set.  Note that a ':', instead of a '-' is used to specify a range of
+ * contiguous bits.  This is done because '-' is used to specify command-line
+ * options, and sometimes ranges are specified as command-line arguments.
+ */
+void sparsebit_dump(FILE *stream, struct sparsebit *s,
+	unsigned int indent)
+{
+	size_t current_line_len = 0;
+	size_t sz;
+	struct node *nodep;
+
+	if (!sparsebit_any_set(s))
+		return;
+
+	/* Display initial indent */
+	fprintf(stream, "%*s", indent, "");
+
+	/* For each node */
+	for (nodep = node_first(s); nodep; nodep = node_next(s, nodep)) {
+		unsigned int n1;
+		sparsebit_idx_t low, high;
+
+		/* For each group of bits in the mask */
+		for (n1 = 0; n1 < MASK_BITS; n1++) {
+			if (nodep->mask & (1 << n1)) {
+				low = high = nodep->idx + n1;
+
+				for (; n1 < MASK_BITS; n1++) {
+					if (nodep->mask & (1 << n1))
+						high = nodep->idx + n1;
+					else
+						break;
+				}
+
+				if ((n1 == MASK_BITS) && nodep->num_after)
+					high += nodep->num_after;
+
+				/*
+				 * How much room will it take to display
+				 * this range.
+				 */
+				sz = display_range(NULL, low, high,
+					current_line_len != 0);
+
+				/*
+				 * If there is not enough room, display
+				 * a newline plus the indent of the next
+				 * line.
+				 */
+				if (current_line_len + sz > DUMP_LINE_MAX) {
+					fputs("\n", stream);
+					fprintf(stream, "%*s", indent, "");
+					current_line_len = 0;
+				}
+
+				/* Display the range */
+				sz = display_range(stream, low, high,
+					current_line_len != 0);
+				current_line_len += sz;
+			}
+		}
+
+		/*
+		 * If num_after and most significant-bit of mask is not
+		 * set, then still need to display a range for the bits
+		 * described by num_after.
+		 */
+		if (!(nodep->mask & (1 << (MASK_BITS - 1))) && nodep->num_after) {
+			low = nodep->idx + MASK_BITS;
+			high = nodep->idx + MASK_BITS + nodep->num_after - 1;
+
+			/*
+			 * How much room will it take to display
+			 * this range.
+			 */
+			sz = display_range(NULL, low, high,
+				current_line_len != 0);
+
+			/*
+			 * If there is not enough room, display
+			 * a newline plus the indent of the next
+			 * line.
+			 */
+			if (current_line_len + sz > DUMP_LINE_MAX) {
+				fputs("\n", stream);
+				fprintf(stream, "%*s", indent, "");
+				current_line_len = 0;
+			}
+
+			/* Display the range */
+			sz = display_range(stream, low, high,
+				current_line_len != 0);
+			current_line_len += sz;
+		}
+	}
+	fputs("\n", stream);
+}
+
+/* Validates the internal state of the sparsebit array given by
+ * s.  On error, diagnostic information is printed to stderr and
+ * abort is called.
+ */
+void sparsebit_validate_internal(struct sparsebit *s)
+{
+	bool error_detected = false;
+	struct node *nodep, *prev = NULL;
+	sparsebit_num_t total_bits_set = 0;
+	unsigned int n1;
+
+	/* For each node */
+	for (nodep = node_first(s); nodep;
+		prev = nodep, nodep = node_next(s, nodep)) {
+
+		/*
+		 * Increase total bits set by the number of bits set
+		 * in this node.
+		 */
+		for (n1 = 0; n1 < MASK_BITS; n1++)
+			if (nodep->mask & (1 << n1))
+				total_bits_set++;
+
+		total_bits_set += nodep->num_after;
+
+		/*
+		 * Arbitrary choice as to whether a mask of 0 is allowed
+		 * or not.  For diagnostic purposes it is beneficial to
+		 * have only one valid means to represent a set of bits.
+		 * To support this an arbitrary choice has been made
+		 * to not allow a mask of zero.
+		 */
+		if (nodep->mask == 0) {
+			fprintf(stderr, "Node mask of zero, "
+				"nodep: %p nodep->mask: 0x%x",
+				nodep, nodep->mask);
+			error_detected = true;
+			break;
+		}
+
+		/*
+		 * Validate num_after is not greater than the max index
+		 * - the number of mask bits.  The num_after member
+		 * uses 0-based indexing and thus has no value that
+		 * represents all bits set.  This limitation is handled
+		 * by requiring a non-zero mask.  With a non-zero mask,
+		 * MASK_BITS worth of bits are described by the mask,
+		 * which makes the largest needed num_after equal to:
+		 *
+		 *    (~(sparsebit_num_t) 0) - MASK_BITS + 1
+		 */
+		if (nodep->num_after
+			> (~(sparsebit_num_t) 0) - MASK_BITS + 1) {
+			fprintf(stderr, "num_after too large, "
+				"nodep: %p nodep->num_after: 0x%lx",
+				nodep, nodep->num_after);
+			error_detected = true;
+			break;
+		}
+
+		/* Validate node index is divisible by the mask size */
+		if (nodep->idx % MASK_BITS) {
+			fprintf(stderr, "Node index not divisable by "
+				"mask size,\n"
+				"  nodep: %p nodep->idx: 0x%lx "
+				"MASK_BITS: %lu\n",
+				nodep, nodep->idx, MASK_BITS);
+			error_detected = true;
+			break;
+		}
+
+		/*
+		 * Validate bits described by node don't wrap beyond the
+		 * highest supported index.
+		 */
+		if ((nodep->idx + MASK_BITS + nodep->num_after - 1) < nodep->idx) {
+			fprintf(stderr, "Bits described by node wrap "
+				"beyond highest supported index,\n"
+				"  nodep: %p nodep->idx: 0x%lx\n"
+				"  MASK_BITS: %lu nodep->num_after: 0x%lx",
+				nodep, nodep->idx, MASK_BITS, nodep->num_after);
+			error_detected = true;
+			break;
+		}
+
+		/* Check parent pointers. */
+		if (nodep->left) {
+			if (nodep->left->parent != nodep) {
+				fprintf(stderr, "Left child parent pointer "
+					"doesn't point to this node,\n"
+					"  nodep: %p nodep->left: %p "
+					"nodep->left->parent: %p",
+					nodep, nodep->left,
+					nodep->left->parent);
+				error_detected = true;
+				break;
+			}
+		}
+
+		if (nodep->right) {
+			if (nodep->right->parent != nodep) {
+				fprintf(stderr, "Right child parent pointer "
+					"doesn't point to this node,\n"
+					"  nodep: %p nodep->right: %p "
+					"nodep->right->parent: %p",
+					nodep, nodep->right,
+					nodep->right->parent);
+				error_detected = true;
+				break;
+			}
+		}
+
+		if (!nodep->parent) {
+			if (s->root != nodep) {
+				fprintf(stderr, "Unexpected root node, "
+					"s->root: %p nodep: %p",
+					s->root, nodep);
+				error_detected = true;
+				break;
+			}
+		}
+
+		if (prev) {
+			/*
+			 * Is index of previous node before index of
+			 * current node?
+			 */
+			if (prev->idx >= nodep->idx) {
+				fprintf(stderr, "Previous node index "
+					">= current node index,\n"
+					"  prev: %p prev->idx: 0x%lx\n"
+					"  nodep: %p nodep->idx: 0x%lx",
+					prev, prev->idx, nodep, nodep->idx);
+				error_detected = true;
+				break;
+			}
+
+			/*
+			 * Nodes occur in asscending order, based on each
+			 * nodes starting index.
+			 */
+			if ((prev->idx + MASK_BITS + prev->num_after - 1)
+				>= nodep->idx) {
+				fprintf(stderr, "Previous node bit range "
+					"overlap with current node bit range,\n"
+					"  prev: %p prev->idx: 0x%lx "
+					"prev->num_after: 0x%lx\n"
+					"  nodep: %p nodep->idx: 0x%lx "
+					"nodep->num_after: 0x%lx\n"
+					"  MASK_BITS: %lu",
+					prev, prev->idx, prev->num_after,
+					nodep, nodep->idx, nodep->num_after,
+					MASK_BITS);
+				error_detected = true;
+				break;
+			}
+
+			/*
+			 * When the node has all mask bits set, it shouldn't
+			 * be adjacent to the last bit described by the
+			 * previous node.
+			 */
+			if (nodep->mask == ~(mask_t) 0 &&
+			    prev->idx + MASK_BITS + prev->num_after == nodep->idx) {
+				fprintf(stderr, "Current node has mask with "
+					"all bits set and is adjacent to the "
+					"previous node,\n"
+					"  prev: %p prev->idx: 0x%lx "
+					"prev->num_after: 0x%lx\n"
+					"  nodep: %p nodep->idx: 0x%lx "
+					"nodep->num_after: 0x%lx\n"
+					"  MASK_BITS: %lu",
+					prev, prev->idx, prev->num_after,
+					nodep, nodep->idx, nodep->num_after,
+					MASK_BITS);
+
+				error_detected = true;
+				break;
+			}
+		}
+	}
+
+	if (!error_detected) {
+		/*
+		 * Is sum of bits set in each node equal to the count
+		 * of total bits set.
+		 */
+		if (s->num_set != total_bits_set) {
+			fprintf(stderr, "Number of bits set missmatch,\n"
+				"  s->num_set: 0x%lx total_bits_set: 0x%lx",
+				s->num_set, total_bits_set);
+
+			error_detected = true;
+		}
+	}
+
+	if (error_detected) {
+		fputs("  dump_internal:\n", stderr);
+		sparsebit_dump_internal(stderr, s, 4);
+		abort();
+	}
+}
+
+
+#ifdef FUZZ
+/* A simple but effective fuzzing driver.  Look for bugs with the help
+ * of some invariants and of a trivial representation of sparsebit.
+ * Just use 512 bytes of /dev/zero and /dev/urandom as inputs, and let
+ * afl-fuzz do the magic. :)
+ */
+
+#include <stdlib.h>
+#include <assert.h>
+
+struct range {
+	sparsebit_idx_t first, last;
+	bool set;
+};
+
+struct sparsebit *s;
+struct range ranges[1000];
+int num_ranges;
+
+static bool get_value(sparsebit_idx_t idx)
+{
+	int i;
+
+	for (i = num_ranges; --i >= 0; )
+		if (ranges[i].first <= idx && idx <= ranges[i].last)
+			return ranges[i].set;
+
+	return false;
+}
+
+static void operate(int code, sparsebit_idx_t first, sparsebit_idx_t last)
+{
+	sparsebit_num_t num;
+	sparsebit_idx_t next;
+
+	if (first < last) {
+		num = last - first + 1;
+	} else {
+		num = first - last + 1;
+		first = last;
+		last = first + num - 1;
+	}
+
+	switch (code) {
+	case 0:
+		sparsebit_set(s, first);
+		assert(sparsebit_is_set(s, first));
+		assert(!sparsebit_is_clear(s, first));
+		assert(sparsebit_any_set(s));
+		assert(!sparsebit_all_clear(s));
+		if (get_value(first))
+			return;
+		if (num_ranges == 1000)
+			exit(0);
+		ranges[num_ranges++] = (struct range)
+			{ .first = first, .last = first, .set = true };
+		break;
+	case 1:
+		sparsebit_clear(s, first);
+		assert(!sparsebit_is_set(s, first));
+		assert(sparsebit_is_clear(s, first));
+		assert(sparsebit_any_clear(s));
+		assert(!sparsebit_all_set(s));
+		if (!get_value(first))
+			return;
+		if (num_ranges == 1000)
+			exit(0);
+		ranges[num_ranges++] = (struct range)
+			{ .first = first, .last = first, .set = false };
+		break;
+	case 2:
+		assert(sparsebit_is_set(s, first) == get_value(first));
+		assert(sparsebit_is_clear(s, first) == !get_value(first));
+		break;
+	case 3:
+		if (sparsebit_any_set(s))
+			assert(get_value(sparsebit_first_set(s)));
+		if (sparsebit_any_clear(s))
+			assert(!get_value(sparsebit_first_clear(s)));
+		sparsebit_set_all(s);
+		assert(!sparsebit_any_clear(s));
+		assert(sparsebit_all_set(s));
+		num_ranges = 0;
+		ranges[num_ranges++] = (struct range)
+			{ .first = 0, .last = ~(sparsebit_idx_t)0, .set = true };
+		break;
+	case 4:
+		if (sparsebit_any_set(s))
+			assert(get_value(sparsebit_first_set(s)));
+		if (sparsebit_any_clear(s))
+			assert(!get_value(sparsebit_first_clear(s)));
+		sparsebit_clear_all(s);
+		assert(!sparsebit_any_set(s));
+		assert(sparsebit_all_clear(s));
+		num_ranges = 0;
+		break;
+	case 5:
+		next = sparsebit_next_set(s, first);
+		assert(next == 0 || next > first);
+		assert(next == 0 || get_value(next));
+		break;
+	case 6:
+		next = sparsebit_next_clear(s, first);
+		assert(next == 0 || next > first);
+		assert(next == 0 || !get_value(next));
+		break;
+	case 7:
+		next = sparsebit_next_clear(s, first);
+		if (sparsebit_is_set_num(s, first, num)) {
+			assert(next == 0 || next > last);
+			if (first)
+				next = sparsebit_next_set(s, first - 1);
+			else if (sparsebit_any_set(s))
+				next = sparsebit_first_set(s);
+			else
+				return;
+			assert(next == first);
+		} else {
+			assert(sparsebit_is_clear(s, first) || next <= last);
+		}
+		break;
+	case 8:
+		next = sparsebit_next_set(s, first);
+		if (sparsebit_is_clear_num(s, first, num)) {
+			assert(next == 0 || next > last);
+			if (first)
+				next = sparsebit_next_clear(s, first - 1);
+			else if (sparsebit_any_clear(s))
+				next = sparsebit_first_clear(s);
+			else
+				return;
+			assert(next == first);
+		} else {
+			assert(sparsebit_is_set(s, first) || next <= last);
+		}
+		break;
+	case 9:
+		sparsebit_set_num(s, first, num);
+		assert(sparsebit_is_set_num(s, first, num));
+		assert(!sparsebit_is_clear_num(s, first, num));
+		assert(sparsebit_any_set(s));
+		assert(!sparsebit_all_clear(s));
+		if (num_ranges == 1000)
+			exit(0);
+		ranges[num_ranges++] = (struct range)
+			{ .first = first, .last = last, .set = true };
+		break;
+	case 10:
+		sparsebit_clear_num(s, first, num);
+		assert(!sparsebit_is_set_num(s, first, num));
+		assert(sparsebit_is_clear_num(s, first, num));
+		assert(sparsebit_any_clear(s));
+		assert(!sparsebit_all_set(s));
+		if (num_ranges == 1000)
+			exit(0);
+		ranges[num_ranges++] = (struct range)
+			{ .first = first, .last = last, .set = false };
+		break;
+	case 11:
+		sparsebit_validate_internal(s);
+		break;
+	default:
+		break;
+	}
+}
+
+unsigned char get8(void)
+{
+	int ch;
+
+	ch = getchar();
+	if (ch == EOF)
+		exit(0);
+	return ch;
+}
+
+uint64_t get64(void)
+{
+	uint64_t x;
+
+	x = get8();
+	x = (x << 8) | get8();
+	x = (x << 8) | get8();
+	x = (x << 8) | get8();
+	x = (x << 8) | get8();
+	x = (x << 8) | get8();
+	x = (x << 8) | get8();
+	return (x << 8) | get8();
+}
+
+int main(void)
+{
+	s = sparsebit_alloc();
+	for (;;) {
+		uint8_t op = get8() & 0xf;
+		uint64_t first = get64();
+		uint64_t last = get64();
+
+		operate(op, first, last);
+	}
+}
+#endif
diff --git a/tools/testing/selftests/kvm/lib/x86.c b/tools/testing/selftests/kvm/lib/x86.c
new file mode 100644
index 000000000000..2b7f79df72ab
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86.c
@@ -0,0 +1,697 @@
+/*
+ * tools/testing/selftests/kvm/lib/x86.c
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_name */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "kvm_util_internal.h"
+#include "x86.h"
+
+/* Minimum physical address used for virtual translation tables. */
+#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
+
+/* Virtual translation table structure declarations */
+struct pageMapL4Entry {
+	uint64_t present:1;
+	uint64_t writable:1;
+	uint64_t user:1;
+	uint64_t write_through:1;
+	uint64_t cache_disable:1;
+	uint64_t accessed:1;
+	uint64_t ignored_06:1;
+	uint64_t page_size:1;
+	uint64_t ignored_11_08:4;
+	uint64_t address:40;
+	uint64_t ignored_62_52:11;
+	uint64_t execute_disable:1;
+};
+
+struct pageDirectoryPointerEntry {
+	uint64_t present:1;
+	uint64_t writable:1;
+	uint64_t user:1;
+	uint64_t write_through:1;
+	uint64_t cache_disable:1;
+	uint64_t accessed:1;
+	uint64_t ignored_06:1;
+	uint64_t page_size:1;
+	uint64_t ignored_11_08:4;
+	uint64_t address:40;
+	uint64_t ignored_62_52:11;
+	uint64_t execute_disable:1;
+};
+
+struct pageDirectoryEntry {
+	uint64_t present:1;
+	uint64_t writable:1;
+	uint64_t user:1;
+	uint64_t write_through:1;
+	uint64_t cache_disable:1;
+	uint64_t accessed:1;
+	uint64_t ignored_06:1;
+	uint64_t page_size:1;
+	uint64_t ignored_11_08:4;
+	uint64_t address:40;
+	uint64_t ignored_62_52:11;
+	uint64_t execute_disable:1;
+};
+
+struct pageTableEntry {
+	uint64_t present:1;
+	uint64_t writable:1;
+	uint64_t user:1;
+	uint64_t write_through:1;
+	uint64_t cache_disable:1;
+	uint64_t accessed:1;
+	uint64_t dirty:1;
+	uint64_t reserved_07:1;
+	uint64_t global:1;
+	uint64_t ignored_11_09:3;
+	uint64_t address:40;
+	uint64_t ignored_62_52:11;
+	uint64_t execute_disable:1;
+};
+
+/* Register Dump
+ *
+ * Input Args:
+ *   indent - Left margin indent amount
+ *   regs - register
+ *
+ * Output Args:
+ *   stream - Output FILE stream
+ *
+ * Return: None
+ *
+ * Dumps the state of the registers given by regs, to the FILE stream
+ * given by steam.
+ */
+void regs_dump(FILE *stream, struct kvm_regs *regs,
+	       uint8_t indent)
+{
+	fprintf(stream, "%*srax: 0x%.16llx rbx: 0x%.16llx "
+		"rcx: 0x%.16llx rdx: 0x%.16llx\n",
+		indent, "",
+		regs->rax, regs->rbx, regs->rcx, regs->rdx);
+	fprintf(stream, "%*srsi: 0x%.16llx rdi: 0x%.16llx "
+		"rsp: 0x%.16llx rbp: 0x%.16llx\n",
+		indent, "",
+		regs->rsi, regs->rdi, regs->rsp, regs->rbp);
+	fprintf(stream, "%*sr8:  0x%.16llx r9:  0x%.16llx "
+		"r10: 0x%.16llx r11: 0x%.16llx\n",
+		indent, "",
+		regs->r8, regs->r9, regs->r10, regs->r11);
+	fprintf(stream, "%*sr12: 0x%.16llx r13: 0x%.16llx "
+		"r14: 0x%.16llx r15: 0x%.16llx\n",
+		indent, "",
+		regs->r12, regs->r13, regs->r14, regs->r15);
+	fprintf(stream, "%*srip: 0x%.16llx rfl: 0x%.16llx\n",
+		indent, "",
+		regs->rip, regs->rflags);
+}
+
+/* Segment Dump
+ *
+ * Input Args:
+ *   indent - Left margin indent amount
+ *   segment - KVM segment
+ *
+ * Output Args:
+ *   stream - Output FILE stream
+ *
+ * Return: None
+ *
+ * Dumps the state of the KVM segment given by segment, to the FILE stream
+ * given by steam.
+ */
+static void segment_dump(FILE *stream, struct kvm_segment *segment,
+			 uint8_t indent)
+{
+	fprintf(stream, "%*sbase: 0x%.16llx limit: 0x%.8x "
+		"selector: 0x%.4x type: 0x%.2x\n",
+		indent, "", segment->base, segment->limit,
+		segment->selector, segment->type);
+	fprintf(stream, "%*spresent: 0x%.2x dpl: 0x%.2x "
+		"db: 0x%.2x s: 0x%.2x l: 0x%.2x\n",
+		indent, "", segment->present, segment->dpl,
+		segment->db, segment->s, segment->l);
+	fprintf(stream, "%*sg: 0x%.2x avl: 0x%.2x "
+		"unusable: 0x%.2x padding: 0x%.2x\n",
+		indent, "", segment->g, segment->avl,
+		segment->unusable, segment->padding);
+}
+
+/* dtable Dump
+ *
+ * Input Args:
+ *   indent - Left margin indent amount
+ *   dtable - KVM dtable
+ *
+ * Output Args:
+ *   stream - Output FILE stream
+ *
+ * Return: None
+ *
+ * Dumps the state of the KVM dtable given by dtable, to the FILE stream
+ * given by steam.
+ */
+static void dtable_dump(FILE *stream, struct kvm_dtable *dtable,
+			uint8_t indent)
+{
+	fprintf(stream, "%*sbase: 0x%.16llx limit: 0x%.4x "
+		"padding: 0x%.4x 0x%.4x 0x%.4x\n",
+		indent, "", dtable->base, dtable->limit,
+		dtable->padding[0], dtable->padding[1], dtable->padding[2]);
+}
+
+/* System Register Dump
+ *
+ * Input Args:
+ *   indent - Left margin indent amount
+ *   sregs - System registers
+ *
+ * Output Args:
+ *   stream - Output FILE stream
+ *
+ * Return: None
+ *
+ * Dumps the state of the system registers given by sregs, to the FILE stream
+ * given by steam.
+ */
+void sregs_dump(FILE *stream, struct kvm_sregs *sregs,
+		uint8_t indent)
+{
+	unsigned int i;
+
+	fprintf(stream, "%*scs:\n", indent, "");
+	segment_dump(stream, &sregs->cs, indent + 2);
+	fprintf(stream, "%*sds:\n", indent, "");
+	segment_dump(stream, &sregs->ds, indent + 2);
+	fprintf(stream, "%*ses:\n", indent, "");
+	segment_dump(stream, &sregs->es, indent + 2);
+	fprintf(stream, "%*sfs:\n", indent, "");
+	segment_dump(stream, &sregs->fs, indent + 2);
+	fprintf(stream, "%*sgs:\n", indent, "");
+	segment_dump(stream, &sregs->gs, indent + 2);
+	fprintf(stream, "%*sss:\n", indent, "");
+	segment_dump(stream, &sregs->ss, indent + 2);
+	fprintf(stream, "%*str:\n", indent, "");
+	segment_dump(stream, &sregs->tr, indent + 2);
+	fprintf(stream, "%*sldt:\n", indent, "");
+	segment_dump(stream, &sregs->ldt, indent + 2);
+
+	fprintf(stream, "%*sgdt:\n", indent, "");
+	dtable_dump(stream, &sregs->gdt, indent + 2);
+	fprintf(stream, "%*sidt:\n", indent, "");
+	dtable_dump(stream, &sregs->idt, indent + 2);
+
+	fprintf(stream, "%*scr0: 0x%.16llx cr2: 0x%.16llx "
+		"cr3: 0x%.16llx cr4: 0x%.16llx\n",
+		indent, "",
+		sregs->cr0, sregs->cr2, sregs->cr3, sregs->cr4);
+	fprintf(stream, "%*scr8: 0x%.16llx efer: 0x%.16llx "
+		"apic_base: 0x%.16llx\n",
+		indent, "",
+		sregs->cr8, sregs->efer, sregs->apic_base);
+
+	fprintf(stream, "%*sinterrupt_bitmap:\n", indent, "");
+	for (i = 0; i < (KVM_NR_INTERRUPTS + 63) / 64; i++) {
+		fprintf(stream, "%*s%.16llx\n", indent + 2, "",
+			sregs->interrupt_bitmap[i]);
+	}
+}
+
+void virt_pgd_alloc(struct kvm_vm *vm, uint32_t pgd_memslot)
+{
+	int rc;
+
+	TEST_ASSERT(vm->mode == VM_MODE_FLAT48PG, "Attempt to use "
+		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+
+	/* If needed, create page map l4 table. */
+	if (!vm->pgd_created) {
+		vm_paddr_t paddr = vm_phy_page_alloc(vm,
+			KVM_GUEST_PAGE_TABLE_MIN_PADDR, pgd_memslot);
+		vm->pgd = paddr;
+
+		/* Set pointer to pgd tables in all the VCPUs that
+		 * have already been created.  Future VCPUs will have
+		 * the value set as each one is created.
+		 */
+		for (struct vcpu *vcpu = vm->vcpu_head; vcpu;
+			vcpu = vcpu->next) {
+			struct kvm_sregs sregs;
+
+			/* Obtain the current system register settings */
+			vcpu_sregs_get(vm, vcpu->id, &sregs);
+
+			/* Set and store the pointer to the start of the
+			 * pgd tables.
+			 */
+			sregs.cr3 = vm->pgd;
+			vcpu_sregs_set(vm, vcpu->id, &sregs);
+		}
+
+		vm->pgd_created = true;
+	}
+}
+
+/* VM Virtual Page Map
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vaddr - VM Virtual Address
+ *   paddr - VM Physical Address
+ *   pgd_memslot - Memory region slot for new virtual translation tables
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Within the VM given by vm, creates a virtual translation for the page
+ * starting at vaddr to the page starting at paddr.
+ */
+void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+	uint32_t pgd_memslot)
+{
+	uint16_t index[4];
+	struct pageMapL4Entry *pml4e;
+
+	TEST_ASSERT(vm->mode == VM_MODE_FLAT48PG, "Attempt to use "
+		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+
+	TEST_ASSERT((vaddr % vm->page_size) == 0,
+		"Virtual address not on page boundary,\n"
+		"  vaddr: 0x%lx vm->page_size: 0x%x",
+		vaddr, vm->page_size);
+	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
+		(vaddr >> vm->page_shift)),
+		"Invalid virtual address, vaddr: 0x%lx",
+		vaddr);
+	TEST_ASSERT((paddr % vm->page_size) == 0,
+		"Physical address not on page boundary,\n"
+		"  paddr: 0x%lx vm->page_size: 0x%x",
+		paddr, vm->page_size);
+	TEST_ASSERT((paddr >> vm->page_shift) <= vm->max_gfn,
+		"Physical address beyond beyond maximum supported,\n"
+		"  paddr: 0x%lx vm->max_gfn: 0x%lx vm->page_size: 0x%x",
+		paddr, vm->max_gfn, vm->page_size);
+
+	index[0] = (vaddr >> 12) & 0x1ffu;
+	index[1] = (vaddr >> 21) & 0x1ffu;
+	index[2] = (vaddr >> 30) & 0x1ffu;
+	index[3] = (vaddr >> 39) & 0x1ffu;
+
+	/* Allocate page directory pointer table if not present. */
+	pml4e = addr_gpa2hva(vm, vm->pgd);
+	if (!pml4e[index[3]].present) {
+		pml4e[index[3]].address = vm_phy_page_alloc(vm,
+			KVM_GUEST_PAGE_TABLE_MIN_PADDR, pgd_memslot)
+			>> vm->page_shift;
+		pml4e[index[3]].writable = true;
+		pml4e[index[3]].present = true;
+	}
+
+	/* Allocate page directory table if not present. */
+	struct pageDirectoryPointerEntry *pdpe;
+	pdpe = addr_gpa2hva(vm, pml4e[index[3]].address * vm->page_size);
+	if (!pdpe[index[2]].present) {
+		pdpe[index[2]].address = vm_phy_page_alloc(vm,
+			KVM_GUEST_PAGE_TABLE_MIN_PADDR, pgd_memslot)
+			>> vm->page_shift;
+		pdpe[index[2]].writable = true;
+		pdpe[index[2]].present = true;
+	}
+
+	/* Allocate page table if not present. */
+	struct pageDirectoryEntry *pde;
+	pde = addr_gpa2hva(vm, pdpe[index[2]].address * vm->page_size);
+	if (!pde[index[1]].present) {
+		pde[index[1]].address = vm_phy_page_alloc(vm,
+			KVM_GUEST_PAGE_TABLE_MIN_PADDR, pgd_memslot)
+			>> vm->page_shift;
+		pde[index[1]].writable = true;
+		pde[index[1]].present = true;
+	}
+
+	/* Fill in page table entry. */
+	struct pageTableEntry *pte;
+	pte = addr_gpa2hva(vm, pde[index[1]].address * vm->page_size);
+	pte[index[0]].address = paddr >> vm->page_shift;
+	pte[index[0]].writable = true;
+	pte[index[0]].present = 1;
+}
+
+/* Virtual Translation Tables Dump
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   indent - Left margin indent amount
+ *
+ * Output Args:
+ *   stream - Output FILE stream
+ *
+ * Return: None
+ *
+ * Dumps to the FILE stream given by stream, the contents of all the
+ * virtual translation tables for the VM given by vm.
+ */
+void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+{
+	struct pageMapL4Entry *pml4e, *pml4e_start;
+	struct pageDirectoryPointerEntry *pdpe, *pdpe_start;
+	struct pageDirectoryEntry *pde, *pde_start;
+	struct pageTableEntry *pte, *pte_start;
+
+	if (!vm->pgd_created)
+		return;
+
+	fprintf(stream, "%*s                                          "
+		"                no\n", indent, "");
+	fprintf(stream, "%*s      index hvaddr         gpaddr         "
+		"addr         w exec dirty\n",
+		indent, "");
+	pml4e_start = (struct pageMapL4Entry *) addr_gpa2hva(vm,
+		vm->pgd);
+	for (uint16_t n1 = 0; n1 <= 0x1ffu; n1++) {
+		pml4e = &pml4e_start[n1];
+		if (!pml4e->present)
+			continue;
+		fprintf(stream, "%*spml4e 0x%-3zx %p 0x%-12lx 0x%-10lx %u "
+			" %u\n",
+			indent, "",
+			pml4e - pml4e_start, pml4e,
+			addr_hva2gpa(vm, pml4e), (uint64_t) pml4e->address,
+			pml4e->writable, pml4e->execute_disable);
+
+		pdpe_start = addr_gpa2hva(vm, pml4e->address
+			* vm->page_size);
+		for (uint16_t n2 = 0; n2 <= 0x1ffu; n2++) {
+			pdpe = &pdpe_start[n2];
+			if (!pdpe->present)
+				continue;
+			fprintf(stream, "%*spdpe  0x%-3zx %p 0x%-12lx 0x%-10lx "
+				"%u  %u\n",
+				indent, "",
+				pdpe - pdpe_start, pdpe,
+				addr_hva2gpa(vm, pdpe),
+				(uint64_t) pdpe->address, pdpe->writable,
+				pdpe->execute_disable);
+
+			pde_start = addr_gpa2hva(vm,
+				pdpe->address * vm->page_size);
+			for (uint16_t n3 = 0; n3 <= 0x1ffu; n3++) {
+				pde = &pde_start[n3];
+				if (!pde->present)
+					continue;
+				fprintf(stream, "%*spde   0x%-3zx %p "
+					"0x%-12lx 0x%-10lx %u  %u\n",
+					indent, "", pde - pde_start, pde,
+					addr_hva2gpa(vm, pde),
+					(uint64_t) pde->address, pde->writable,
+					pde->execute_disable);
+
+				pte_start = addr_gpa2hva(vm,
+					pde->address * vm->page_size);
+				for (uint16_t n4 = 0; n4 <= 0x1ffu; n4++) {
+					pte = &pte_start[n4];
+					if (!pte->present)
+						continue;
+					fprintf(stream, "%*spte   0x%-3zx %p "
+						"0x%-12lx 0x%-10lx %u  %u "
+						"    %u    0x%-10lx\n",
+						indent, "",
+						pte - pte_start, pte,
+						addr_hva2gpa(vm, pte),
+						(uint64_t) pte->address,
+						pte->writable,
+						pte->execute_disable,
+						pte->dirty,
+						((uint64_t) n1 << 27)
+							| ((uint64_t) n2 << 18)
+							| ((uint64_t) n3 << 9)
+							| ((uint64_t) n4));
+				}
+			}
+		}
+	}
+}
+
+/* Set Unusable Segment
+ *
+ * Input Args: None
+ *
+ * Output Args:
+ *   segp - Pointer to segment register
+ *
+ * Return: None
+ *
+ * Sets the segment register pointed to by segp to an unusable state.
+ */
+static void kvm_seg_set_unusable(struct kvm_segment *segp)
+{
+	memset(segp, 0, sizeof(*segp));
+	segp->unusable = true;
+}
+
+/* Set Long Mode Flat Kernel Code Segment
+ *
+ * Input Args:
+ *   selector - selector value
+ *
+ * Output Args:
+ *   segp - Pointer to KVM segment
+ *
+ * Return: None
+ *
+ * Sets up the KVM segment pointed to by segp, to be a code segment
+ * with the selector value given by selector.
+ */
+static void kvm_seg_set_kernel_code_64bit(uint16_t selector,
+	struct kvm_segment *segp)
+{
+	memset(segp, 0, sizeof(*segp));
+	segp->selector = selector;
+	segp->limit = 0xFFFFFFFFu;
+	segp->s = 0x1; /* kTypeCodeData */
+	segp->type = 0x08 | 0x01 | 0x02; /* kFlagCode | kFlagCodeAccessed
+					  * | kFlagCodeReadable
+					  */
+	segp->g = true;
+	segp->l = true;
+	segp->present = 1;
+}
+
+/* Set Long Mode Flat Kernel Data Segment
+ *
+ * Input Args:
+ *   selector - selector value
+ *
+ * Output Args:
+ *   segp - Pointer to KVM segment
+ *
+ * Return: None
+ *
+ * Sets up the KVM segment pointed to by segp, to be a data segment
+ * with the selector value given by selector.
+ */
+static void kvm_seg_set_kernel_data_64bit(uint16_t selector,
+	struct kvm_segment *segp)
+{
+	memset(segp, 0, sizeof(*segp));
+	segp->selector = selector;
+	segp->limit = 0xFFFFFFFFu;
+	segp->s = 0x1; /* kTypeCodeData */
+	segp->type = 0x00 | 0x01 | 0x02; /* kFlagData | kFlagDataAccessed
+					  * | kFlagDataWritable
+					  */
+	segp->g = true;
+	segp->present = true;
+}
+
+/* Address Guest Virtual to Guest Physical
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   gpa - VM virtual address
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Equivalent VM physical address
+ *
+ * Translates the VM virtual address given by gva to a VM physical
+ * address and then locates the memory region containing the VM
+ * physical address, within the VM given by vm.  When found, the host
+ * virtual address providing the memory to the vm physical address is returned.
+ * A TEST_ASSERT failure occurs if no region containing translated
+ * VM virtual address exists.
+ */
+vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
+{
+	uint16_t index[4];
+	struct pageMapL4Entry *pml4e;
+	struct pageDirectoryPointerEntry *pdpe;
+	struct pageDirectoryEntry *pde;
+	struct pageTableEntry *pte;
+	void *hva;
+
+	TEST_ASSERT(vm->mode == VM_MODE_FLAT48PG, "Attempt to use "
+		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+
+	index[0] = (gva >> 12) & 0x1ffu;
+	index[1] = (gva >> 21) & 0x1ffu;
+	index[2] = (gva >> 30) & 0x1ffu;
+	index[3] = (gva >> 39) & 0x1ffu;
+
+	if (!vm->pgd_created)
+		goto unmapped_gva;
+	pml4e = addr_gpa2hva(vm, vm->pgd);
+	if (!pml4e[index[3]].present)
+		goto unmapped_gva;
+
+	pdpe = addr_gpa2hva(vm, pml4e[index[3]].address * vm->page_size);
+	if (!pdpe[index[2]].present)
+		goto unmapped_gva;
+
+	pde = addr_gpa2hva(vm, pdpe[index[2]].address * vm->page_size);
+	if (!pde[index[1]].present)
+		goto unmapped_gva;
+
+	pte = addr_gpa2hva(vm, pde[index[1]].address * vm->page_size);
+	if (!pte[index[0]].present)
+		goto unmapped_gva;
+
+	return (pte[index[0]].address * vm->page_size) + (gva & 0xfffu);
+
+unmapped_gva:
+	TEST_ASSERT(false, "No mapping for vm virtual address, "
+		    "gva: 0x%lx", gva);
+}
+
+void vcpu_setup(struct kvm_vm *vm, int vcpuid)
+{
+	struct kvm_sregs sregs;
+
+	/* Set mode specific system register values. */
+	vcpu_sregs_get(vm, vcpuid, &sregs);
+
+	switch (vm->mode) {
+	case VM_MODE_FLAT48PG:
+		sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+		sregs.cr4 |= X86_CR4_PAE;
+		sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
+
+		kvm_seg_set_unusable(&sregs.ldt);
+		kvm_seg_set_kernel_code_64bit(0x8, &sregs.cs);
+		kvm_seg_set_kernel_data_64bit(0x10, &sregs.ds);
+		kvm_seg_set_kernel_data_64bit(0x10, &sregs.es);
+		break;
+
+	default:
+		TEST_ASSERT(false, "Unknown guest mode, mode: 0x%x", vm->mode);
+	}
+	vcpu_sregs_set(vm, vcpuid, &sregs);
+
+	/* If virtual translation table have been setup, set system register
+	 * to point to the tables.  It's okay if they haven't been setup yet,
+	 * in that the code that sets up the virtual translation tables, will
+	 * go back through any VCPUs that have already been created and set
+	 * their values.
+	 */
+	if (vm->pgd_created) {
+		struct kvm_sregs sregs;
+
+		vcpu_sregs_get(vm, vcpuid, &sregs);
+
+		sregs.cr3 = vm->pgd;
+		vcpu_sregs_set(vm, vcpuid, &sregs);
+	}
+}
+/* Adds a vCPU with reasonable defaults (i.e., a stack)
+ *
+ * Input Args:
+ *   vcpuid - The id of the VCPU to add to the VM.
+ *   guest_code - The vCPU's entry point
+ */
+void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
+{
+	struct kvm_mp_state mp_state;
+	struct kvm_regs regs;
+	vm_vaddr_t stack_vaddr;
+	stack_vaddr = vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
+				     DEFAULT_GUEST_STACK_VADDR_MIN, 0, 0);
+
+	/* Create VCPU */
+	vm_vcpu_add(vm, vcpuid);
+
+	/* Setup guest general purpose registers */
+	vcpu_regs_get(vm, vcpuid, &regs);
+	regs.rflags = regs.rflags | 0x2;
+	regs.rsp = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize());
+	regs.rip = (unsigned long) guest_code;
+	vcpu_regs_set(vm, vcpuid, &regs);
+
+	/* Setup the MP state */
+	mp_state.mp_state = 0;
+	vcpu_set_mp_state(vm, vcpuid, &mp_state);
+}
+
+/* VM VCPU CPUID Set
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - VCPU id
+ *   cpuid - The CPUID values to set.
+ *
+ * Output Args: None
+ *
+ * Return: void
+ *
+ * Set the VCPU's CPUID.
+ */
+void vcpu_set_cpuid(struct kvm_vm *vm,
+		uint32_t vcpuid, struct kvm_cpuid2 *cpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int rc;
+
+	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+
+	rc = ioctl(vcpu->fd, KVM_SET_CPUID2, cpuid);
+	TEST_ASSERT(rc == 0, "KVM_SET_CPUID2 failed, rc: %i errno: %i",
+		    rc, errno);
+
+}
+/* Create a VM with reasonable defaults
+ *
+ * Input Args:
+ *   vcpuid - The id of the single VCPU to add to the VM.
+ *   guest_code - The vCPU's entry point
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to opaque structure that describes the created VM.
+ */
+struct kvm_vm *vm_create_default(uint32_t vcpuid, void *guest_code)
+{
+	struct kvm_vm *vm;
+
+	/* Create VM */
+	vm = vm_create(VM_MODE_FLAT48PG, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+
+	/* Setup IRQ Chip */
+	vm_create_irqchip(vm);
+
+	/* Add the first vCPU. */
+	vm_vcpu_add_default(vm, vcpuid, guest_code);
+
+	return vm;
+}
diff --git a/tools/testing/selftests/kvm/set_sregs_test.c b/tools/testing/selftests/kvm/set_sregs_test.c
new file mode 100644
index 000000000000..1d411c830ea9
--- /dev/null
+++ b/tools/testing/selftests/kvm/set_sregs_test.c
@@ -0,0 +1,54 @@
+/*
+ * KVM_SET_SREGS tests
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * This is a regression test for the bug fixed by the following commit:
+ * d3802286fa0f ("kvm: x86: Disallow illegal IA32_APIC_BASE MSR values")
+ *
+ * That bug allowed a user-mode program that called the KVM_SET_SREGS
+ * ioctl to put a VCPU's local APIC into an invalid state.
+ *
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "x86.h"
+
+#define VCPU_ID                  5
+
+int main(int argc, char *argv[])
+{
+	struct kvm_sregs sregs;
+	struct kvm_vm *vm;
+	int rc;
+
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, NULL);
+
+	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	sregs.apic_base = 1 << 10;
+	rc = _vcpu_sregs_set(vm, VCPU_ID, &sregs);
+	TEST_ASSERT(rc, "Set IA32_APIC_BASE to %llx (invalid)",
+		    sregs.apic_base);
+	sregs.apic_base = 1 << 11;
+	rc = _vcpu_sregs_set(vm, VCPU_ID, &sregs);
+	TEST_ASSERT(!rc, "Couldn't set IA32_APIC_BASE to %llx (valid)",
+		    sregs.apic_base);
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.16.2
