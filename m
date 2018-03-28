Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeC1I7a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:59:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39332 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeC1I7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:59:19 -0400
X-Google-Smtp-Source: AIpwx49vfIPGaIjy5b1dftu77TcsaAONhCC8nGh30zxz2fK9khzIOCoe5C+/foTVnI6Cba3B/A+wOA==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hofsass@google.com
Subject: [PATCH 2/2] kvm: selftests: add sync_regs_test
Date: Wed, 28 Mar 2018 10:59:06 +0200
Message-Id: <20180328085906.26936-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328085906.26936-1-pbonzini@redhat.com>
References: <20180328085906.26936-1-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This includes the infrastructure to map the test into the guest and
run code from the test program inside a VM.

Signed-off-by: Ken Hofsass <hofsass@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile           |   3 +-
 tools/testing/selftests/kvm/include/kvm_util.h |   3 +
 tools/testing/selftests/kvm/lib/elf.c          | 197 +++++++++++++++++++++
 tools/testing/selftests/kvm/lib/io.c           | 158 +++++++++++++++++
 tools/testing/selftests/kvm/lib/x86.c          |   3 +
 tools/testing/selftests/kvm/sync_regs_test.c   | 235 +++++++++++++++++++++++++
 6 files changed, 598 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/lib/elf.c
 create mode 100644 tools/testing/selftests/kvm/lib/io.c
 create mode 100644 tools/testing/selftests/kvm/sync_regs_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 6aade26e9ca2..dc44de904797 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -3,10 +3,11 @@ all:
 top_srcdir = ../../../../
 UNAME_M := $(shell uname -m)
 
-LIBKVM = lib/assert.c lib/kvm_util.c lib/sparsebit.c
+LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c
 LIBKVM_x86_64 = lib/x86.c
 
 TEST_GEN_PROGS_x86_64 = set_sregs_test
+TEST_GEN_PROGS_x86_64 += sync_regs_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 44aa1e204dbc..c823e0cb77e6 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -57,6 +57,9 @@ void kvm_vm_free(struct kvm_vm *vmp);
 int kvm_memcmp_hva_gva(void *hva,
 	struct kvm_vm *vm, const vm_vaddr_t gva, size_t len);
 
+void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename,
+	uint32_t data_memslot, uint32_t pgd_memslot);
+
 void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
 void vcpu_dump(FILE *stream, struct kvm_vm *vm,
 	uint32_t vcpuid, uint8_t indent);
diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
new file mode 100644
index 000000000000..171e2281b0f2
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/elf.c
@@ -0,0 +1,197 @@
+/*
+ * tools/testing/selftests/kvm/lib/elf.c
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ */
+
+#include "test_util.h"
+
+#include <bits/endian.h>
+#include <linux/elf.h>
+
+#include "kvm_util.h"
+#include "kvm_util_internal.h"
+
+static void elfhdr_get(const char *filename, Elf64_Ehdr *hdrp)
+{
+	off_t offset_rv;
+
+	/* Open the ELF file. */
+	int fd;
+	fd = open(filename, O_RDONLY);
+	TEST_ASSERT(fd >= 0, "Failed to open ELF file,\n"
+		"  filename: %s\n"
+		"  rv: %i errno: %i", filename, fd, errno);
+
+	/* Read in and validate ELF Identification Record.
+	 * The ELF Identification record is the first 16 (EI_NIDENT) bytes
+	 * of the ELF header, which is at the beginning of the ELF file.
+	 * For now it is only safe to read the first EI_NIDENT bytes.  Once
+	 * read and validated, the value of e_ehsize can be used to determine
+	 * the real size of the ELF header.
+	 */
+	unsigned char ident[EI_NIDENT];
+	test_read(fd, ident, sizeof(ident));
+	TEST_ASSERT((ident[EI_MAG0] == ELFMAG0) && (ident[EI_MAG1] == ELFMAG1)
+		&& (ident[EI_MAG2] == ELFMAG2) && (ident[EI_MAG3] == ELFMAG3),
+		"ELF MAGIC Mismatch,\n"
+		"  filename: %s\n"
+		"  ident[EI_MAG0 - EI_MAG3]: %02x %02x %02x %02x\n"
+		"  Expected: %02x %02x %02x %02x",
+		filename,
+		ident[EI_MAG0], ident[EI_MAG1], ident[EI_MAG2], ident[EI_MAG3],
+		ELFMAG0, ELFMAG1, ELFMAG2, ELFMAG3);
+	TEST_ASSERT(ident[EI_CLASS] == ELFCLASS64,
+		"Current implementation only able to handle ELFCLASS64,\n"
+		"  filename: %s\n"
+		"  ident[EI_CLASS]: %02x\n"
+		"  expected: %02x",
+		filename,
+		ident[EI_CLASS], ELFCLASS64);
+	TEST_ASSERT(((BYTE_ORDER == LITTLE_ENDIAN)
+			&& (ident[EI_DATA] == ELFDATA2LSB))
+		|| ((BYTE_ORDER == BIG_ENDIAN)
+			&& (ident[EI_DATA] == ELFDATA2MSB)), "Current "
+		"implementation only able to handle\n"
+		"cases where the host and ELF file endianness\n"
+		"is the same:\n"
+		"  host BYTE_ORDER: %u\n"
+		"  host LITTLE_ENDIAN: %u\n"
+		"  host BIG_ENDIAN: %u\n"
+		"  ident[EI_DATA]: %u\n"
+		"  ELFDATA2LSB: %u\n"
+		"  ELFDATA2MSB: %u",
+		BYTE_ORDER, LITTLE_ENDIAN, BIG_ENDIAN,
+		ident[EI_DATA], ELFDATA2LSB, ELFDATA2MSB);
+	TEST_ASSERT(ident[EI_VERSION] == EV_CURRENT,
+		"Current implementation only able to handle current "
+		"ELF version,\n"
+		"  filename: %s\n"
+		"  ident[EI_VERSION]: %02x\n"
+		"  expected: %02x",
+		filename, ident[EI_VERSION], EV_CURRENT);
+
+	/* Read in the ELF header.
+	 * With the ELF Identification portion of the ELF header
+	 * validated, especially that the value at EI_VERSION is
+	 * as expected, it is now safe to read the entire ELF header.
+	 */
+	offset_rv = lseek(fd, 0, SEEK_SET);
+	TEST_ASSERT(offset_rv == 0, "Seek to ELF header failed,\n"
+		"  rv: %zi expected: %i", offset_rv, 0);
+	test_read(fd, hdrp, sizeof(*hdrp));
+	TEST_ASSERT(hdrp->e_phentsize == sizeof(Elf64_Phdr),
+		"Unexpected physical header size,\n"
+		"  hdrp->e_phentsize: %x\n"
+		"  expected: %zx",
+		hdrp->e_phentsize, sizeof(Elf64_Phdr));
+	TEST_ASSERT(hdrp->e_shentsize == sizeof(Elf64_Shdr),
+		"Unexpected section header size,\n"
+		"  hdrp->e_shentsize: %x\n"
+		"  expected: %zx",
+		hdrp->e_shentsize, sizeof(Elf64_Shdr));
+}
+
+/* VM ELF Load
+ *
+ * Input Args:
+ *   filename - Path to ELF file
+ *
+ * Output Args: None
+ *
+ * Input/Output Args:
+ *   vm - Pointer to opaque type that describes the VM.
+ *
+ * Return: None, TEST_ASSERT failures for all error conditions
+ *
+ * Loads the program image of the ELF file specified by filename,
+ * into the virtual address space of the VM pointed to by vm.  On entry
+ * the VM needs to not be using any of the virtual address space used
+ * by the image and it needs to have sufficient available physical pages, to
+ * back the virtual pages used to load the image.
+ */
+void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename,
+	uint32_t data_memslot, uint32_t pgd_memslot)
+{
+	off_t offset, offset_rv;
+	Elf64_Ehdr hdr;
+
+	/* Open the ELF file. */
+	int fd;
+	fd = open(filename, O_RDONLY);
+	TEST_ASSERT(fd >= 0, "Failed to open ELF file,\n"
+		"  filename: %s\n"
+		"  rv: %i errno: %i", filename, fd, errno);
+
+	/* Read in the ELF header. */
+	elfhdr_get(filename, &hdr);
+
+	/* For each program header.
+	 * The following ELF header members specify the location
+	 * and size of the program headers:
+	 *
+	 *   e_phoff - File offset to start of program headers
+	 *   e_phentsize - Size of each program header
+	 *   e_phnum - Number of program header entries
+	 */
+	for (unsigned int n1 = 0; n1 < hdr.e_phnum; n1++) {
+		/* Seek to the beginning of the program header. */
+		offset = hdr.e_phoff + (n1 * hdr.e_phentsize);
+		offset_rv = lseek(fd, offset, SEEK_SET);
+		TEST_ASSERT(offset_rv == offset,
+			"Failed to seek to begining of program header %u,\n"
+			"  filename: %s\n"
+			"  rv: %jd errno: %i",
+			n1, filename, (intmax_t) offset_rv, errno);
+
+		/* Read in the program header. */
+		Elf64_Phdr phdr;
+		test_read(fd, &phdr, sizeof(phdr));
+
+		/* Skip if this header doesn't describe a loadable segment. */
+		if (phdr.p_type != PT_LOAD)
+			continue;
+
+		/* Allocate memory for this segment within the VM. */
+		TEST_ASSERT(phdr.p_memsz > 0, "Unexpected loadable segment "
+			"memsize of 0,\n"
+			"  phdr index: %u p_memsz: 0x%" PRIx64,
+			n1, (uint64_t) phdr.p_memsz);
+		vm_vaddr_t seg_vstart = phdr.p_vaddr;
+		seg_vstart &= ~(vm_vaddr_t)(vm->page_size - 1);
+		vm_vaddr_t seg_vend = phdr.p_vaddr + phdr.p_memsz - 1;
+		seg_vend |= vm->page_size - 1;
+		size_t seg_size = seg_vend - seg_vstart + 1;
+
+		vm_vaddr_t vaddr = vm_vaddr_alloc(vm, seg_size, seg_vstart,
+			data_memslot, pgd_memslot);
+		TEST_ASSERT(vaddr == seg_vstart, "Unable to allocate "
+			"virtual memory for segment at requested min addr,\n"
+			"  segment idx: %u\n"
+			"  seg_vstart: 0x%lx\n"
+			"  vaddr: 0x%lx",
+			n1, seg_vstart, vaddr);
+		memset(addr_gva2hva(vm, vaddr), 0, seg_size);
+		/* TODO(lhuemill): Set permissions of each memory segment
+		 * based on the least-significant 3 bits of phdr.p_flags.
+		 */
+
+		/* Load portion of initial state that is contained within
+		 * the ELF file.
+		 */
+		if (phdr.p_filesz) {
+			offset_rv = lseek(fd, phdr.p_offset, SEEK_SET);
+			TEST_ASSERT(offset_rv == phdr.p_offset,
+				"Seek to program segment offset failed,\n"
+				"  program header idx: %u errno: %i\n"
+				"  offset_rv: 0x%jx\n"
+				"  expected: 0x%jx\n",
+				n1, errno, (intmax_t) offset_rv,
+				(intmax_t) phdr.p_offset);
+			test_read(fd, addr_gva2hva(vm, phdr.p_vaddr),
+				phdr.p_filesz);
+		}
+	}
+}
diff --git a/tools/testing/selftests/kvm/lib/io.c b/tools/testing/selftests/kvm/lib/io.c
new file mode 100644
index 000000000000..0a710ba6d5d6
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/io.c
@@ -0,0 +1,158 @@
+/*
+ * tools/testing/selftests/kvm/lib/io.c
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ */
+
+#include "test_util.h"
+
+/* Test Write
+ *
+ * A wrapper for write(2), that automatically handles the following
+ * special conditions:
+ *
+ *   + Interrupted system call (EINTR)
+ *   + Write of less than requested amount
+ *   + Non-block return (EAGAIN)
+ *
+ * For each of the above, an additional write is performed to automatically
+ * continue writing the requested data.
+ * There are also many cases where write(2) can return an unexpected
+ * error (e.g. EIO).  Such errors cause a TEST_ASSERT failure.
+ *
+ * Note, for function signature compatibility with write(2), this function
+ * returns the number of bytes written, but that value will always be equal
+ * to the number of requested bytes.  All other conditions in this and
+ * future enhancements to this function either automatically issue another
+ * write(2) or cause a TEST_ASSERT failure.
+ *
+ * Args:
+ *  fd    - Opened file descriptor to file to be written.
+ *  count - Number of bytes to write.
+ *
+ * Output:
+ *  buf   - Starting address of data to be written.
+ *
+ * Return:
+ *  On success, number of bytes written.
+ *  On failure, a TEST_ASSERT failure is caused.
+ */
+ssize_t test_write(int fd, const void *buf, size_t count)
+{
+	ssize_t rc;
+	ssize_t num_written = 0;
+	size_t num_left = count;
+	const char *ptr = buf;
+
+	/* Note: Count of zero is allowed (see "RETURN VALUE" portion of
+	 * write(2) manpage for details.
+	 */
+	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);
+
+	do {
+		rc = write(fd, ptr, num_left);
+
+		switch (rc) {
+		case -1:
+			TEST_ASSERT(errno == EAGAIN || errno == EINTR,
+				    "Unexpected write failure,\n"
+				    "  rc: %zi errno: %i", rc, errno);
+			continue;
+
+		case 0:
+			TEST_ASSERT(false, "Unexpected EOF,\n"
+				    "  rc: %zi num_written: %zi num_left: %zu",
+				    rc, num_written, num_left);
+			break;
+
+		default:
+			TEST_ASSERT(rc >= 0, "Unexpected ret from write,\n"
+				"  rc: %zi errno: %i", rc, errno);
+			num_written += rc;
+			num_left -= rc;
+			ptr += rc;
+			break;
+		}
+	} while (num_written < count);
+
+	return num_written;
+}
+
+/* Test Read
+ *
+ * A wrapper for read(2), that automatically handles the following
+ * special conditions:
+ *
+ *   + Interrupted system call (EINTR)
+ *   + Read of less than requested amount
+ *   + Non-block return (EAGAIN)
+ *
+ * For each of the above, an additional read is performed to automatically
+ * continue reading the requested data.
+ * There are also many cases where read(2) can return an unexpected
+ * error (e.g. EIO).  Such errors cause a TEST_ASSERT failure.  Note,
+ * it is expected that the file opened by fd at the current file position
+ * contains at least the number of requested bytes to be read.  A TEST_ASSERT
+ * failure is produced if an End-Of-File condition occurs, before all the
+ * data is read.  It is the callers responsibility to assure that sufficient
+ * data exists.
+ *
+ * Note, for function signature compatibility with read(2), this function
+ * returns the number of bytes read, but that value will always be equal
+ * to the number of requested bytes.  All other conditions in this and
+ * future enhancements to this function either automatically issue another
+ * read(2) or cause a TEST_ASSERT failure.
+ *
+ * Args:
+ *  fd    - Opened file descriptor to file to be read.
+ *  count - Number of bytes to read.
+ *
+ * Output:
+ *  buf   - Starting address of where to write the bytes read.
+ *
+ * Return:
+ *  On success, number of bytes read.
+ *  On failure, a TEST_ASSERT failure is caused.
+ */
+ssize_t test_read(int fd, void *buf, size_t count)
+{
+	ssize_t rc;
+	ssize_t num_read = 0;
+	size_t num_left = count;
+	char *ptr = buf;
+
+	/* Note: Count of zero is allowed (see "If count is zero" portion of
+	 * read(2) manpage for details.
+	 */
+	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);
+
+	do {
+		rc = read(fd, ptr, num_left);
+
+		switch (rc) {
+		case -1:
+			TEST_ASSERT(errno == EAGAIN || errno == EINTR,
+				    "Unexpected read failure,\n"
+				    "  rc: %zi errno: %i", rc, errno);
+			break;
+
+		case 0:
+			TEST_ASSERT(false, "Unexpected EOF,\n"
+				    "  rc: %zi num_read: %zi num_left: %zu",
+				    rc, num_read, num_left);
+			break;
+
+		default:
+			TEST_ASSERT(rc > 0, "Unexpected ret from read,\n"
+				    "  rc: %zi errno: %i", rc, errno);
+			num_read += rc;
+			num_left -= rc;
+			ptr += rc;
+			break;
+		}
+	} while (num_read < count);
+
+	return num_read;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86.c b/tools/testing/selftests/kvm/lib/x86.c
index 2b7f79df72ab..e374c140b68d 100644
--- a/tools/testing/selftests/kvm/lib/x86.c
+++ b/tools/testing/selftests/kvm/lib/x86.c
@@ -687,6 +687,9 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, void *guest_code)
 	/* Create VM */
 	vm = vm_create(VM_MODE_FLAT48PG, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
 
+	/* Setup guest code */
+	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
+
 	/* Setup IRQ Chip */
 	vm_create_irqchip(vm);
 
diff --git a/tools/testing/selftests/kvm/sync_regs_test.c b/tools/testing/selftests/kvm/sync_regs_test.c
new file mode 100644
index 000000000000..068bf5ad1a40
--- /dev/null
+++ b/tools/testing/selftests/kvm/sync_regs_test.c
@@ -0,0 +1,232 @@
+/*
+ * Test for x86 KVM_CAP_SYNC_REGS
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * Verifies expected behavior of x86 KVM_CAP_SYNC_REGS functionality,
+ * including requesting an invalid register set, updates to/from values
+ * in kvm_run.s.regs when kvm_valid_regs and kvm_dirty_regs are toggled.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "x86.h"
+
+#define VCPU_ID 5
+#define PORT_HOST_SYNC 0x1000
+
+static void __exit_to_l0(uint16_t port, uint64_t arg0, uint64_t arg1)
+{
+	        __asm__ __volatile__("in %[port], %%al"
+				     :
+				     : [port]"d"(port), "D"(arg0), "S"(arg1)
+				     : "rax");
+}
+
+#define exit_to_l0(_port, _arg0, _arg1) \
+        __exit_to_l0(_port, (uint64_t) (_arg0), (uint64_t) (_arg1))
+
+#define GUEST_ASSERT(_condition) do { \
+	if (!(_condition)) \
+		exit_to_l0(PORT_ABORT, "Failed guest assert: " #_condition, 0);\
+} while (0)
+
+void guest_code(void)
+{
+	for (;;) {
+		exit_to_l0(PORT_HOST_SYNC, "hello", 0);
+		asm volatile ("inc %r11");
+	}
+}
+
+static void compare_regs(struct kvm_regs *left, struct kvm_regs *right)
+{
+#define REG_COMPARE(reg) \
+	TEST_ASSERT(left->reg == right->reg, \
+		    "Register " #reg \
+		    " values did not match: 0x%llx, 0x%llx\n", \
+		    left->reg, right->reg)
+	REG_COMPARE(rax);
+	REG_COMPARE(rbx);
+	REG_COMPARE(rcx);
+	REG_COMPARE(rdx);
+	REG_COMPARE(rsi);
+	REG_COMPARE(rdi);
+	REG_COMPARE(rsp);
+	REG_COMPARE(rbp);
+	REG_COMPARE(r8);
+	REG_COMPARE(r9);
+	REG_COMPARE(r10);
+	REG_COMPARE(r11);
+	REG_COMPARE(r12);
+	REG_COMPARE(r13);
+	REG_COMPARE(r14);
+	REG_COMPARE(r15);
+	REG_COMPARE(rip);
+	REG_COMPARE(rflags);
+#undef REG_COMPARE
+}
+
+static void compare_sregs(struct kvm_sregs *left, struct kvm_sregs *right)
+{
+}
+
+static void compare_vcpu_events(struct kvm_vcpu_events *left,
+				struct kvm_vcpu_events *right)
+{
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct kvm_run *run;
+	struct kvm_regs regs;
+	struct kvm_sregs sregs;
+	struct kvm_vcpu_events events;
+	int rv, cap;
+
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
+	TEST_ASSERT((unsigned long)cap == KVM_SYNC_X86_VALID_FIELDS,
+		    "KVM_CAP_SYNC_REGS (0x%x) != KVM_SYNC_X86_VALID_FIELDS (0x%lx)\n",
+		    cap, KVM_SYNC_X86_VALID_FIELDS);
+
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, guest_code);
+
+	run = vcpu_state(vm, VCPU_ID);
+
+	/* Request reading invalid register set from VCPU. */
+	run->kvm_valid_regs = KVM_SYNC_X86_VALID_FIELDS << 1;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv < 0 && errno == EINVAL,
+		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
+		    rv);
+	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
+
+	/* Request setting invalid register set into VCPU. */
+	run->kvm_dirty_regs = KVM_SYNC_X86_VALID_FIELDS << 1;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv < 0 && errno == EINVAL,
+		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
+		    rv);
+	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
+
+	/* Request and verify all valid register sets. */
+	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
+	run->kvm_valid_regs = KVM_SYNC_X86_VALID_FIELDS;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Unexpected exit reason: %u (%s),\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+
+	vcpu_regs_get(vm, VCPU_ID, &regs);
+	compare_regs(&regs, &run->s.regs.regs);
+
+	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	compare_sregs(&sregs, &run->s.regs.sregs);
+
+	vcpu_events_get(vm, VCPU_ID, &events);
+	compare_vcpu_events(&events, &run->s.regs.events);
+
+	/* Set and verify various register values. */
+	run->s.regs.regs.r11 = 0xBAD1DEA;
+	run->s.regs.sregs.apic_base = 1 << 11;
+	/* TODO run->s.regs.events.XYZ = ABC; */
+
+	run->kvm_valid_regs = KVM_SYNC_X86_VALID_FIELDS;
+	run->kvm_dirty_regs = KVM_SYNC_X86_REGS | KVM_SYNC_X86_SREGS;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Unexpected exit reason: %u (%s),\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+	TEST_ASSERT(run->s.regs.regs.r11 == 0xBAD1DEA + 1,
+		    "r11 sync regs value incorrect 0x%llx.",
+		    run->s.regs.regs.r11);
+	TEST_ASSERT(run->s.regs.sregs.apic_base == 1 << 11,
+		    "apic_base sync regs value incorrect 0x%llx.",
+		    run->s.regs.sregs.apic_base);
+
+	vcpu_regs_get(vm, VCPU_ID, &regs);
+	compare_regs(&regs, &run->s.regs.regs);
+
+	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	compare_sregs(&sregs, &run->s.regs.sregs);
+
+	vcpu_events_get(vm, VCPU_ID, &events);
+	compare_vcpu_events(&events, &run->s.regs.events);
+
+	/* Clear kvm_dirty_regs bits, verify new s.regs values are
+	 * overwritten with existing guest values.
+	 */
+	run->kvm_valid_regs = KVM_SYNC_X86_VALID_FIELDS;
+	run->kvm_dirty_regs = 0;
+	run->s.regs.regs.r11 = 0xDEADBEEF;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Unexpected exit reason: %u (%s),\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+	TEST_ASSERT(run->s.regs.regs.r11 != 0xDEADBEEF,
+		    "r11 sync regs value incorrect 0x%llx.",
+		    run->s.regs.regs.r11);
+
+	/* Clear kvm_valid_regs bits and kvm_dirty_bits.
+	 * Verify s.regs values are not overwritten with existing guest values
+	 * and that guest values are not overwritten with kvm_sync_regs values.
+	 */
+	run->kvm_valid_regs = 0;
+	run->kvm_dirty_regs = 0;
+	run->s.regs.regs.r11 = 0xAAAA;
+	regs.r11 = 0xBAC0;
+	vcpu_regs_set(vm, VCPU_ID, &regs);
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Unexpected exit reason: %u (%s),\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+	TEST_ASSERT(run->s.regs.regs.r11 == 0xAAAA,
+		    "r11 sync regs value incorrect 0x%llx.",
+		    run->s.regs.regs.r11);
+	vcpu_regs_get(vm, VCPU_ID, &regs);
+	TEST_ASSERT(regs.r11 == 0xBAC0 + 1,
+		    "r11 guest value incorrect 0x%llx.",
+		    regs.r11);
+
+	/* Clear kvm_valid_regs bits. Verify s.regs values are not overwritten
+	 * with existing guest values but that guest values are overwritten
+	 * with kvm_sync_regs values.
+	 */
+	run->kvm_valid_regs = 0;
+	run->kvm_dirty_regs = KVM_SYNC_X86_VALID_FIELDS;
+	run->s.regs.regs.r11 = 0xBBBB;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+		    "Unexpected exit reason: %u (%s),\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+	TEST_ASSERT(run->s.regs.regs.r11 == 0xBBBB,
+		    "r11 sync regs value incorrect 0x%llx.",
+		    run->s.regs.regs.r11);
+	vcpu_regs_get(vm, VCPU_ID, &regs);
+	TEST_ASSERT(regs.r11 == 0xBBBB + 1,
+		    "r11 guest value incorrect 0x%llx.",
+		    regs.r11);
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.16.2
