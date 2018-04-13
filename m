Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754373AbeDML0r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:26:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38080 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754222AbeDMLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:23:40 -0400
X-Google-Smtp-Source: AIpwx48Gzvzd0EahnFUhccQpAth9lvmyVeumix8W2KlqIX8g1/HkoLEC/eaZtdMU9PL3YvvpKI3qzA==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: karahmed@amazon.de, jmattson@google.com, rkrcmar@redhat.com
Subject: [PATCH 3/2] kvm: selftests: add vmx_tsc_adjust_test
Date: Fri, 13 Apr 2018 13:23:28 +0200
Message-Id: <1523618608-30574-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523618608-30574-1-git-send-email-pbonzini@redhat.com>
References: <1523618608-30574-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test checks the behavior of setting MSR_IA32_TSC while in a
nested guest.  It also introduces the testing infrastructure for
Intel nested virtualization.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile              |   3 +-
 tools/testing/selftests/kvm/include/kvm_util.h    |  15 +-
 tools/testing/selftests/kvm/include/vmx.h         | 680 ++++++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c        |  18 +-
 tools/testing/selftests/kvm/lib/vmx.c             |  54 ++
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c | 222 +++++++
 6 files changed, 979 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/vmx.h
 create mode 100644 tools/testing/selftests/kvm/lib/vmx.c
 create mode 100644 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 1da541e1ab75..2ddcc96ae456 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -4,10 +4,11 @@ top_srcdir = ../../../../
 UNAME_M := $(shell uname -m)
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c
-LIBKVM_x86_64 = lib/x86.c
+LIBKVM_x86_64 = lib/x86.c lib/vmx.c
 
 TEST_GEN_PROGS_x86_64 = set_sregs_test
 TEST_GEN_PROGS_x86_64 += sync_regs_test
+TEST_GEN_PROGS_x86_64 += vmx_tsc_adjust_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 57974ad46373..637b7017b6ee 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -112,24 +112,27 @@ void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm,
 	vm_paddr_t paddr_min, uint32_t memslot);
 
-void kvm_get_supported_cpuid(struct kvm_cpuid2 *cpuid);
+struct kvm_cpuid2 *kvm_get_supported_cpuid(void);
 void vcpu_set_cpuid(
 	struct kvm_vm *vm, uint32_t vcpuid, struct kvm_cpuid2 *cpuid);
 
-struct kvm_cpuid2 *allocate_kvm_cpuid2(void);
 struct kvm_cpuid_entry2 *
-find_cpuid_index_entry(struct kvm_cpuid2 *cpuid, uint32_t function,
-		       uint32_t index);
+kvm_get_supported_cpuid_index(uint32_t function, uint32_t index);
 
 static inline struct kvm_cpuid_entry2 *
-find_cpuid_entry(struct kvm_cpuid2 *cpuid, uint32_t function)
+kvm_get_supported_cpuid_entry(uint32_t function)
 {
-	return find_cpuid_index_entry(cpuid, function, 0);
+	return kvm_get_supported_cpuid_index(function, 0);
 }
 
 struct kvm_vm *vm_create_default(uint32_t vcpuid, void *guest_code);
 void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code);
 
+typedef void (*vmx_guest_code_t)(vm_vaddr_t vmxon_vaddr,
+				 vm_paddr_t vmxon_paddr,
+				 vm_vaddr_t vmcs_vaddr,
+				 vm_paddr_t vmcs_paddr);
+
 struct kvm_userspace_memory_region *
 kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 				 uint64_t end);
diff --git a/tools/testing/selftests/kvm/include/vmx.h b/tools/testing/selftests/kvm/include/vmx.h
new file mode 100644
index 000000000000..686d79d71465
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/vmx.h
@@ -0,0 +1,680 @@
+/*
+ * tools/testing/selftests/kvm/include/vmx.h
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ */
+
+#ifndef SELFTEST_KVM_VMX_H
+#define SELFTEST_KVM_VMX_H
+
+#include <stdint.h>
+#include "x86.h"
+
+#define CPUID_VMX_BIT				5
+
+#define CPUID_VMX				(1 << 5)
+
+/*
+ * Definitions of Primary Processor-Based VM-Execution Controls.
+ */
+#define CPU_BASED_VIRTUAL_INTR_PENDING		0x00000004
+#define CPU_BASED_USE_TSC_OFFSETING		0x00000008
+#define CPU_BASED_HLT_EXITING			0x00000080
+#define CPU_BASED_INVLPG_EXITING		0x00000200
+#define CPU_BASED_MWAIT_EXITING			0x00000400
+#define CPU_BASED_RDPMC_EXITING			0x00000800
+#define CPU_BASED_RDTSC_EXITING			0x00001000
+#define CPU_BASED_CR3_LOAD_EXITING		0x00008000
+#define CPU_BASED_CR3_STORE_EXITING		0x00010000
+#define CPU_BASED_CR8_LOAD_EXITING		0x00080000
+#define CPU_BASED_CR8_STORE_EXITING		0x00100000
+#define CPU_BASED_TPR_SHADOW			0x00200000
+#define CPU_BASED_VIRTUAL_NMI_PENDING		0x00400000
+#define CPU_BASED_MOV_DR_EXITING		0x00800000
+#define CPU_BASED_UNCOND_IO_EXITING		0x01000000
+#define CPU_BASED_USE_IO_BITMAPS		0x02000000
+#define CPU_BASED_MONITOR_TRAP			0x08000000
+#define CPU_BASED_USE_MSR_BITMAPS		0x10000000
+#define CPU_BASED_MONITOR_EXITING		0x20000000
+#define CPU_BASED_PAUSE_EXITING			0x40000000
+#define CPU_BASED_ACTIVATE_SECONDARY_CONTROLS	0x80000000
+
+#define CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR	0x0401e172
+
+/*
+ * Definitions of Secondary Processor-Based VM-Execution Controls.
+ */
+#define SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES 0x00000001
+#define SECONDARY_EXEC_ENABLE_EPT		0x00000002
+#define SECONDARY_EXEC_DESC			0x00000004
+#define SECONDARY_EXEC_RDTSCP			0x00000008
+#define SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE	0x00000010
+#define SECONDARY_EXEC_ENABLE_VPID		0x00000020
+#define SECONDARY_EXEC_WBINVD_EXITING		0x00000040
+#define SECONDARY_EXEC_UNRESTRICTED_GUEST	0x00000080
+#define SECONDARY_EXEC_APIC_REGISTER_VIRT	0x00000100
+#define SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY	0x00000200
+#define SECONDARY_EXEC_PAUSE_LOOP_EXITING	0x00000400
+#define SECONDARY_EXEC_RDRAND_EXITING		0x00000800
+#define SECONDARY_EXEC_ENABLE_INVPCID		0x00001000
+#define SECONDARY_EXEC_ENABLE_VMFUNC		0x00002000
+#define SECONDARY_EXEC_SHADOW_VMCS		0x00004000
+#define SECONDARY_EXEC_RDSEED_EXITING		0x00010000
+#define SECONDARY_EXEC_ENABLE_PML		0x00020000
+#define SECONDARY_EPT_VE			0x00040000
+#define SECONDARY_ENABLE_XSAV_RESTORE		0x00100000
+#define SECONDARY_EXEC_TSC_SCALING		0x02000000
+
+#define PIN_BASED_EXT_INTR_MASK			0x00000001
+#define PIN_BASED_NMI_EXITING			0x00000008
+#define PIN_BASED_VIRTUAL_NMIS			0x00000020
+#define PIN_BASED_VMX_PREEMPTION_TIMER		0x00000040
+#define PIN_BASED_POSTED_INTR			0x00000080
+
+#define PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR	0x00000016
+
+#define VM_EXIT_SAVE_DEBUG_CONTROLS		0x00000004
+#define VM_EXIT_HOST_ADDR_SPACE_SIZE		0x00000200
+#define VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL	0x00001000
+#define VM_EXIT_ACK_INTR_ON_EXIT		0x00008000
+#define VM_EXIT_SAVE_IA32_PAT			0x00040000
+#define VM_EXIT_LOAD_IA32_PAT			0x00080000
+#define VM_EXIT_SAVE_IA32_EFER			0x00100000
+#define VM_EXIT_LOAD_IA32_EFER			0x00200000
+#define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER	0x00400000
+
+#define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
+
+#define VM_ENTRY_LOAD_DEBUG_CONTROLS		0x00000004
+#define VM_ENTRY_IA32E_MODE			0x00000200
+#define VM_ENTRY_SMM				0x00000400
+#define VM_ENTRY_DEACT_DUAL_MONITOR		0x00000800
+#define VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL	0x00002000
+#define VM_ENTRY_LOAD_IA32_PAT			0x00004000
+#define VM_ENTRY_LOAD_IA32_EFER			0x00008000
+
+#define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
+
+#define VMX_MISC_PREEMPTION_TIMER_RATE_MASK	0x0000001f
+#define VMX_MISC_SAVE_EFER_LMA			0x00000020
+
+#define EXIT_REASON_EXCEPTION_NMI	0
+#define EXIT_REASON_EXTERNAL_INTERRUPT	1
+#define EXIT_REASON_TRIPLE_FAULT	2
+#define EXIT_REASON_PENDING_INTERRUPT	7
+#define EXIT_REASON_NMI_WINDOW		8
+#define EXIT_REASON_TASK_SWITCH		9
+#define EXIT_REASON_CPUID		10
+#define EXIT_REASON_HLT			12
+#define EXIT_REASON_INVD		13
+#define EXIT_REASON_INVLPG		14
+#define EXIT_REASON_RDPMC		15
+#define EXIT_REASON_RDTSC		16
+#define EXIT_REASON_VMCALL		18
+#define EXIT_REASON_VMCLEAR		19
+#define EXIT_REASON_VMLAUNCH		20
+#define EXIT_REASON_VMPTRLD		21
+#define EXIT_REASON_VMPTRST		22
+#define EXIT_REASON_VMREAD		23
+#define EXIT_REASON_VMRESUME		24
+#define EXIT_REASON_VMWRITE		25
+#define EXIT_REASON_VMOFF		26
+#define EXIT_REASON_VMON		27
+#define EXIT_REASON_CR_ACCESS		28
+#define EXIT_REASON_DR_ACCESS		29
+#define EXIT_REASON_IO_INSTRUCTION	30
+#define EXIT_REASON_MSR_READ		31
+#define EXIT_REASON_MSR_WRITE		32
+#define EXIT_REASON_INVALID_STATE	33
+#define EXIT_REASON_MWAIT_INSTRUCTION	36
+#define EXIT_REASON_MONITOR_INSTRUCTION 39
+#define EXIT_REASON_PAUSE_INSTRUCTION	40
+#define EXIT_REASON_MCE_DURING_VMENTRY	41
+#define EXIT_REASON_TPR_BELOW_THRESHOLD 43
+#define EXIT_REASON_APIC_ACCESS		44
+#define EXIT_REASON_EOI_INDUCED		45
+#define EXIT_REASON_EPT_VIOLATION	48
+#define EXIT_REASON_EPT_MISCONFIG	49
+#define EXIT_REASON_INVEPT		50
+#define EXIT_REASON_RDTSCP		51
+#define EXIT_REASON_PREEMPTION_TIMER	52
+#define EXIT_REASON_INVVPID		53
+#define EXIT_REASON_WBINVD		54
+#define EXIT_REASON_XSETBV		55
+#define EXIT_REASON_APIC_WRITE		56
+#define EXIT_REASON_INVPCID		58
+#define EXIT_REASON_PML_FULL		62
+#define EXIT_REASON_XSAVES		63
+#define EXIT_REASON_XRSTORS		64
+#define LAST_EXIT_REASON		64
+
+enum vmcs_field {
+	VIRTUAL_PROCESSOR_ID		= 0x00000000,
+	POSTED_INTR_NV			= 0x00000002,
+	GUEST_ES_SELECTOR		= 0x00000800,
+	GUEST_CS_SELECTOR		= 0x00000802,
+	GUEST_SS_SELECTOR		= 0x00000804,
+	GUEST_DS_SELECTOR		= 0x00000806,
+	GUEST_FS_SELECTOR		= 0x00000808,
+	GUEST_GS_SELECTOR		= 0x0000080a,
+	GUEST_LDTR_SELECTOR		= 0x0000080c,
+	GUEST_TR_SELECTOR		= 0x0000080e,
+	GUEST_INTR_STATUS		= 0x00000810,
+	GUEST_PML_INDEX			= 0x00000812,
+	HOST_ES_SELECTOR		= 0x00000c00,
+	HOST_CS_SELECTOR		= 0x00000c02,
+	HOST_SS_SELECTOR		= 0x00000c04,
+	HOST_DS_SELECTOR		= 0x00000c06,
+	HOST_FS_SELECTOR		= 0x00000c08,
+	HOST_GS_SELECTOR		= 0x00000c0a,
+	HOST_TR_SELECTOR		= 0x00000c0c,
+	IO_BITMAP_A			= 0x00002000,
+	IO_BITMAP_A_HIGH		= 0x00002001,
+	IO_BITMAP_B			= 0x00002002,
+	IO_BITMAP_B_HIGH		= 0x00002003,
+	MSR_BITMAP			= 0x00002004,
+	MSR_BITMAP_HIGH			= 0x00002005,
+	VM_EXIT_MSR_STORE_ADDR		= 0x00002006,
+	VM_EXIT_MSR_STORE_ADDR_HIGH	= 0x00002007,
+	VM_EXIT_MSR_LOAD_ADDR		= 0x00002008,
+	VM_EXIT_MSR_LOAD_ADDR_HIGH	= 0x00002009,
+	VM_ENTRY_MSR_LOAD_ADDR		= 0x0000200a,
+	VM_ENTRY_MSR_LOAD_ADDR_HIGH	= 0x0000200b,
+	PML_ADDRESS			= 0x0000200e,
+	PML_ADDRESS_HIGH		= 0x0000200f,
+	TSC_OFFSET			= 0x00002010,
+	TSC_OFFSET_HIGH			= 0x00002011,
+	VIRTUAL_APIC_PAGE_ADDR		= 0x00002012,
+	VIRTUAL_APIC_PAGE_ADDR_HIGH	= 0x00002013,
+	APIC_ACCESS_ADDR		= 0x00002014,
+	APIC_ACCESS_ADDR_HIGH		= 0x00002015,
+	POSTED_INTR_DESC_ADDR		= 0x00002016,
+	POSTED_INTR_DESC_ADDR_HIGH	= 0x00002017,
+	EPT_POINTER			= 0x0000201a,
+	EPT_POINTER_HIGH		= 0x0000201b,
+	EOI_EXIT_BITMAP0		= 0x0000201c,
+	EOI_EXIT_BITMAP0_HIGH		= 0x0000201d,
+	EOI_EXIT_BITMAP1		= 0x0000201e,
+	EOI_EXIT_BITMAP1_HIGH		= 0x0000201f,
+	EOI_EXIT_BITMAP2		= 0x00002020,
+	EOI_EXIT_BITMAP2_HIGH		= 0x00002021,
+	EOI_EXIT_BITMAP3		= 0x00002022,
+	EOI_EXIT_BITMAP3_HIGH		= 0x00002023,
+	VMREAD_BITMAP			= 0x00002026,
+	VMREAD_BITMAP_HIGH		= 0x00002027,
+	VMWRITE_BITMAP			= 0x00002028,
+	VMWRITE_BITMAP_HIGH		= 0x00002029,
+	XSS_EXIT_BITMAP			= 0x0000202C,
+	XSS_EXIT_BITMAP_HIGH		= 0x0000202D,
+	TSC_MULTIPLIER			= 0x00002032,
+	TSC_MULTIPLIER_HIGH		= 0x00002033,
+	GUEST_PHYSICAL_ADDRESS		= 0x00002400,
+	GUEST_PHYSICAL_ADDRESS_HIGH	= 0x00002401,
+	VMCS_LINK_POINTER		= 0x00002800,
+	VMCS_LINK_POINTER_HIGH		= 0x00002801,
+	GUEST_IA32_DEBUGCTL		= 0x00002802,
+	GUEST_IA32_DEBUGCTL_HIGH	= 0x00002803,
+	GUEST_IA32_PAT			= 0x00002804,
+	GUEST_IA32_PAT_HIGH		= 0x00002805,
+	GUEST_IA32_EFER			= 0x00002806,
+	GUEST_IA32_EFER_HIGH		= 0x00002807,
+	GUEST_IA32_PERF_GLOBAL_CTRL	= 0x00002808,
+	GUEST_IA32_PERF_GLOBAL_CTRL_HIGH= 0x00002809,
+	GUEST_PDPTR0			= 0x0000280a,
+	GUEST_PDPTR0_HIGH		= 0x0000280b,
+	GUEST_PDPTR1			= 0x0000280c,
+	GUEST_PDPTR1_HIGH		= 0x0000280d,
+	GUEST_PDPTR2			= 0x0000280e,
+	GUEST_PDPTR2_HIGH		= 0x0000280f,
+	GUEST_PDPTR3			= 0x00002810,
+	GUEST_PDPTR3_HIGH		= 0x00002811,
+	GUEST_BNDCFGS			= 0x00002812,
+	GUEST_BNDCFGS_HIGH		= 0x00002813,
+	HOST_IA32_PAT			= 0x00002c00,
+	HOST_IA32_PAT_HIGH		= 0x00002c01,
+	HOST_IA32_EFER			= 0x00002c02,
+	HOST_IA32_EFER_HIGH		= 0x00002c03,
+	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,
+	HOST_IA32_PERF_GLOBAL_CTRL_HIGH	= 0x00002c05,
+	PIN_BASED_VM_EXEC_CONTROL	= 0x00004000,
+	CPU_BASED_VM_EXEC_CONTROL	= 0x00004002,
+	EXCEPTION_BITMAP		= 0x00004004,
+	PAGE_FAULT_ERROR_CODE_MASK	= 0x00004006,
+	PAGE_FAULT_ERROR_CODE_MATCH	= 0x00004008,
+	CR3_TARGET_COUNT		= 0x0000400a,
+	VM_EXIT_CONTROLS		= 0x0000400c,
+	VM_EXIT_MSR_STORE_COUNT		= 0x0000400e,
+	VM_EXIT_MSR_LOAD_COUNT		= 0x00004010,
+	VM_ENTRY_CONTROLS		= 0x00004012,
+	VM_ENTRY_MSR_LOAD_COUNT		= 0x00004014,
+	VM_ENTRY_INTR_INFO_FIELD	= 0x00004016,
+	VM_ENTRY_EXCEPTION_ERROR_CODE	= 0x00004018,
+	VM_ENTRY_INSTRUCTION_LEN	= 0x0000401a,
+	TPR_THRESHOLD			= 0x0000401c,
+	SECONDARY_VM_EXEC_CONTROL	= 0x0000401e,
+	PLE_GAP				= 0x00004020,
+	PLE_WINDOW			= 0x00004022,
+	VM_INSTRUCTION_ERROR		= 0x00004400,
+	VM_EXIT_REASON			= 0x00004402,
+	VM_EXIT_INTR_INFO		= 0x00004404,
+	VM_EXIT_INTR_ERROR_CODE		= 0x00004406,
+	IDT_VECTORING_INFO_FIELD	= 0x00004408,
+	IDT_VECTORING_ERROR_CODE	= 0x0000440a,
+	VM_EXIT_INSTRUCTION_LEN		= 0x0000440c,
+	VMX_INSTRUCTION_INFO		= 0x0000440e,
+	GUEST_ES_LIMIT			= 0x00004800,
+	GUEST_CS_LIMIT			= 0x00004802,
+	GUEST_SS_LIMIT			= 0x00004804,
+	GUEST_DS_LIMIT			= 0x00004806,
+	GUEST_FS_LIMIT			= 0x00004808,
+	GUEST_GS_LIMIT			= 0x0000480a,
+	GUEST_LDTR_LIMIT		= 0x0000480c,
+	GUEST_TR_LIMIT			= 0x0000480e,
+	GUEST_GDTR_LIMIT		= 0x00004810,
+	GUEST_IDTR_LIMIT		= 0x00004812,
+	GUEST_ES_AR_BYTES		= 0x00004814,
+	GUEST_CS_AR_BYTES		= 0x00004816,
+	GUEST_SS_AR_BYTES		= 0x00004818,
+	GUEST_DS_AR_BYTES		= 0x0000481a,
+	GUEST_FS_AR_BYTES		= 0x0000481c,
+	GUEST_GS_AR_BYTES		= 0x0000481e,
+	GUEST_LDTR_AR_BYTES		= 0x00004820,
+	GUEST_TR_AR_BYTES		= 0x00004822,
+	GUEST_INTERRUPTIBILITY_INFO	= 0x00004824,
+	GUEST_ACTIVITY_STATE		= 0X00004826,
+	GUEST_SYSENTER_CS		= 0x0000482A,
+	VMX_PREEMPTION_TIMER_VALUE	= 0x0000482E,
+	HOST_IA32_SYSENTER_CS		= 0x00004c00,
+	CR0_GUEST_HOST_MASK		= 0x00006000,
+	CR4_GUEST_HOST_MASK		= 0x00006002,
+	CR0_READ_SHADOW			= 0x00006004,
+	CR4_READ_SHADOW			= 0x00006006,
+	CR3_TARGET_VALUE0		= 0x00006008,
+	CR3_TARGET_VALUE1		= 0x0000600a,
+	CR3_TARGET_VALUE2		= 0x0000600c,
+	CR3_TARGET_VALUE3		= 0x0000600e,
+	EXIT_QUALIFICATION		= 0x00006400,
+	GUEST_LINEAR_ADDRESS		= 0x0000640a,
+	GUEST_CR0			= 0x00006800,
+	GUEST_CR3			= 0x00006802,
+	GUEST_CR4			= 0x00006804,
+	GUEST_ES_BASE			= 0x00006806,
+	GUEST_CS_BASE			= 0x00006808,
+	GUEST_SS_BASE			= 0x0000680a,
+	GUEST_DS_BASE			= 0x0000680c,
+	GUEST_FS_BASE			= 0x0000680e,
+	GUEST_GS_BASE			= 0x00006810,
+	GUEST_LDTR_BASE			= 0x00006812,
+	GUEST_TR_BASE			= 0x00006814,
+	GUEST_GDTR_BASE			= 0x00006816,
+	GUEST_IDTR_BASE			= 0x00006818,
+	GUEST_DR7			= 0x0000681a,
+	GUEST_RSP			= 0x0000681c,
+	GUEST_RIP			= 0x0000681e,
+	GUEST_RFLAGS			= 0x00006820,
+	GUEST_PENDING_DBG_EXCEPTIONS	= 0x00006822,
+	GUEST_SYSENTER_ESP		= 0x00006824,
+	GUEST_SYSENTER_EIP		= 0x00006826,
+	HOST_CR0			= 0x00006c00,
+	HOST_CR3			= 0x00006c02,
+	HOST_CR4			= 0x00006c04,
+	HOST_FS_BASE			= 0x00006c06,
+	HOST_GS_BASE			= 0x00006c08,
+	HOST_TR_BASE			= 0x00006c0a,
+	HOST_GDTR_BASE			= 0x00006c0c,
+	HOST_IDTR_BASE			= 0x00006c0e,
+	HOST_IA32_SYSENTER_ESP		= 0x00006c10,
+	HOST_IA32_SYSENTER_EIP		= 0x00006c12,
+	HOST_RSP			= 0x00006c14,
+	HOST_RIP			= 0x00006c16,
+};
+
+struct vmx_msr_entry {
+	uint32_t index;
+	uint32_t reserved;
+	uint64_t value;
+} __attribute__ ((aligned(16)));
+
+static inline int vmxon(uint64_t phys)
+{
+	uint8_t ret;
+
+	__asm__ __volatile__ ("vmxon %[pa]; setna %[ret]"
+		: [ret]"=rm"(ret)
+		: [pa]"m"(phys)
+		: "cc", "memory");
+
+	return ret;
+}
+
+static inline void vmxoff(void)
+{
+	__asm__ __volatile__("vmxoff");
+}
+
+static inline int vmclear(uint64_t vmcs_pa)
+{
+	uint8_t ret;
+
+	__asm__ __volatile__ ("vmclear %[pa]; setna %[ret]"
+		: [ret]"=rm"(ret)
+		: [pa]"m"(vmcs_pa)
+		: "cc", "memory");
+
+	return ret;
+}
+
+static inline int vmptrld(uint64_t vmcs_pa)
+{
+	uint8_t ret;
+
+	__asm__ __volatile__ ("vmptrld %[pa]; setna %[ret]"
+		: [ret]"=rm"(ret)
+		: [pa]"m"(vmcs_pa)
+		: "cc", "memory");
+
+	return ret;
+}
+
+/*
+ * No guest state (e.g. GPRs) is established by this vmlaunch.
+ */
+static inline int vmlaunch(void)
+{
+	int ret;
+
+	__asm__ __volatile__("push %%rbp;"
+			     "push %%rcx;"
+			     "push %%rdx;"
+			     "push %%rsi;"
+			     "push %%rdi;"
+			     "push $0;"
+			     "vmwrite %%rsp, %[host_rsp];"
+			     "lea 1f(%%rip), %%rax;"
+			     "vmwrite %%rax, %[host_rip];"
+			     "vmlaunch;"
+			     "incq (%%rsp);"
+			     "1: pop %%rax;"
+			     "pop %%rdi;"
+			     "pop %%rsi;"
+			     "pop %%rdx;"
+			     "pop %%rcx;"
+			     "pop %%rbp;"
+			     : [ret]"=&a"(ret)
+			     : [host_rsp]"r"((uint64_t)HOST_RSP),
+			       [host_rip]"r"((uint64_t)HOST_RIP)
+			     : "memory", "cc", "rbx", "r8", "r9", "r10",
+			       "r11", "r12", "r13", "r14", "r15");
+	return ret;
+}
+
+/*
+ * No guest state (e.g. GPRs) is established by this vmresume.
+ */
+static inline int vmresume(void)
+{
+	int ret;
+
+	__asm__ __volatile__("push %%rbp;"
+			     "push %%rcx;"
+			     "push %%rdx;"
+			     "push %%rsi;"
+			     "push %%rdi;"
+			     "push $0;"
+			     "vmwrite %%rsp, %[host_rsp];"
+			     "lea 1f(%%rip), %%rax;"
+			     "vmwrite %%rax, %[host_rip];"
+			     "vmresume;"
+			     "incq (%%rsp);"
+			     "1: pop %%rax;"
+			     "pop %%rdi;"
+			     "pop %%rsi;"
+			     "pop %%rdx;"
+			     "pop %%rcx;"
+			     "pop %%rbp;"
+			     : [ret]"=&a"(ret)
+			     : [host_rsp]"r"((uint64_t)HOST_RSP),
+			       [host_rip]"r"((uint64_t)HOST_RIP)
+			     : "memory", "cc", "rbx", "r8", "r9", "r10",
+			       "r11", "r12", "r13", "r14", "r15");
+	return ret;
+}
+
+static inline int vmread(uint64_t encoding, uint64_t *value)
+{
+	uint64_t tmp;
+	uint8_t ret;
+
+	__asm__ __volatile__("vmread %[encoding], %[value]; setna %[ret]"
+		: [value]"=rm"(tmp), [ret]"=rm"(ret)
+		: [encoding]"r"(encoding)
+		: "cc", "memory");
+
+	*value = tmp;
+	return ret;
+}
+
+/*
+ * A wrapper around vmread that ignores errors and returns zero if the
+ * vmread instruction fails.
+ */
+static inline uint64_t vmreadz(uint64_t encoding)
+{
+	uint64_t value = 0;
+	vmread(encoding, &value);
+	return value;
+}
+
+static inline int vmwrite(uint64_t encoding, uint64_t value)
+{
+	uint8_t ret;
+
+	__asm__ __volatile__ ("vmwrite %[value], %[encoding]; setna %[ret]"
+		: [ret]"=rm"(ret)
+		: [value]"rm"(value), [encoding]"r"(encoding)
+		: "cc", "memory");
+
+	return ret;
+}
+
+static inline uint32_t vmcs_revision(void)
+{
+	return rdmsr(MSR_IA32_VMX_BASIC);
+}
+
+static inline void prepare_for_vmx_operation(void)
+{
+	uint64_t feature_control;
+	uint64_t required;
+	unsigned long cr0;
+	unsigned long cr4;
+
+	/*
+	 * Ensure bits in CR0 and CR4 are valid in VMX operation:
+	 * - Bit X is 1 in _FIXED0: bit X is fixed to 1 in CRx.
+	 * - Bit X is 0 in _FIXED1: bit X is fixed to 0 in CRx.
+	 */
+	__asm__ __volatile__("mov %%cr0, %0" : "=r"(cr0) : : "memory");
+	cr0 &= rdmsr(MSR_IA32_VMX_CR0_FIXED1);
+	cr0 |= rdmsr(MSR_IA32_VMX_CR0_FIXED0);
+	__asm__ __volatile__("mov %0, %%cr0" : : "r"(cr0) : "memory");
+
+	__asm__ __volatile__("mov %%cr4, %0" : "=r"(cr4) : : "memory");
+	cr4 &= rdmsr(MSR_IA32_VMX_CR4_FIXED1);
+	cr4 |= rdmsr(MSR_IA32_VMX_CR4_FIXED0);
+	/* Enable VMX operation */
+	cr4 |= X86_CR4_VMXE;
+	__asm__ __volatile__("mov %0, %%cr4" : : "r"(cr4) : "memory");
+
+	/*
+	 * Configure IA32_FEATURE_CONTROL MSR to allow VMXON:
+	 *  Bit 0: Lock bit. If clear, VMXON causes a #GP.
+	 *  Bit 2: Enables VMXON outside of SMX operation. If clear, VMXON
+	 *    outside of SMX causes a #GP.
+	 */
+	required = FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+	required |= FEATURE_CONTROL_LOCKED;
+	feature_control = rdmsr(MSR_IA32_FEATURE_CONTROL);
+	if ((feature_control & required) != required)
+		wrmsr(MSR_IA32_FEATURE_CONTROL, feature_control | required);
+}
+
+/*
+ * Initialize the control fields to the most basic settings possible.
+ */
+static inline void init_vmcs_control_fields(void)
+{
+	vmwrite(VIRTUAL_PROCESSOR_ID, 0);
+	vmwrite(POSTED_INTR_NV, 0);
+
+	vmwrite(PIN_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_PINBASED_CTLS));
+	vmwrite(CPU_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_PROCBASED_CTLS));
+	vmwrite(EXCEPTION_BITMAP, 0);
+	vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0);
+	vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1); /* Never match */
+	vmwrite(CR3_TARGET_COUNT, 0);
+	vmwrite(VM_EXIT_CONTROLS, rdmsr(MSR_IA32_VMX_EXIT_CTLS) |
+		VM_EXIT_HOST_ADDR_SPACE_SIZE);	  /* 64-bit host */
+	vmwrite(VM_EXIT_MSR_STORE_COUNT, 0);
+	vmwrite(VM_EXIT_MSR_LOAD_COUNT, 0);
+	vmwrite(VM_ENTRY_CONTROLS, rdmsr(MSR_IA32_VMX_ENTRY_CTLS) |
+		VM_ENTRY_IA32E_MODE);		  /* 64-bit guest */
+	vmwrite(VM_ENTRY_MSR_LOAD_COUNT, 0);
+	vmwrite(VM_ENTRY_INTR_INFO_FIELD, 0);
+	vmwrite(TPR_THRESHOLD, 0);
+	vmwrite(SECONDARY_VM_EXEC_CONTROL, 0);
+
+	vmwrite(CR0_GUEST_HOST_MASK, 0);
+	vmwrite(CR4_GUEST_HOST_MASK, 0);
+	vmwrite(CR0_READ_SHADOW, get_cr0());
+	vmwrite(CR4_READ_SHADOW, get_cr4());
+}
+
+/*
+ * Initialize the host state fields based on the current host state, with
+ * the exception of HOST_RSP and HOST_RIP, which should be set by vmlaunch
+ * or vmresume.
+ */
+static inline void init_vmcs_host_state(void)
+{
+	uint32_t exit_controls = vmreadz(VM_EXIT_CONTROLS);
+
+	vmwrite(HOST_ES_SELECTOR, get_es());
+	vmwrite(HOST_CS_SELECTOR, get_cs());
+	vmwrite(HOST_SS_SELECTOR, get_ss());
+	vmwrite(HOST_DS_SELECTOR, get_ds());
+	vmwrite(HOST_FS_SELECTOR, get_fs());
+	vmwrite(HOST_GS_SELECTOR, get_gs());
+	vmwrite(HOST_TR_SELECTOR, get_tr());
+
+	if (exit_controls & VM_EXIT_LOAD_IA32_PAT)
+		vmwrite(HOST_IA32_PAT, rdmsr(MSR_IA32_CR_PAT));
+	if (exit_controls & VM_EXIT_LOAD_IA32_EFER)
+		vmwrite(HOST_IA32_EFER, rdmsr(MSR_EFER));
+	if (exit_controls & VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
+		vmwrite(HOST_IA32_PERF_GLOBAL_CTRL,
+			rdmsr(MSR_CORE_PERF_GLOBAL_CTRL));
+
+	vmwrite(HOST_IA32_SYSENTER_CS, rdmsr(MSR_IA32_SYSENTER_CS));
+
+	vmwrite(HOST_CR0, get_cr0());
+	vmwrite(HOST_CR3, get_cr3());
+	vmwrite(HOST_CR4, get_cr4());
+	vmwrite(HOST_FS_BASE, rdmsr(MSR_FS_BASE));
+	vmwrite(HOST_GS_BASE, rdmsr(MSR_GS_BASE));
+	vmwrite(HOST_TR_BASE,
+		get_desc64_base((struct desc64 *)(get_gdt_base() + get_tr())));
+	vmwrite(HOST_GDTR_BASE, get_gdt_base());
+	vmwrite(HOST_IDTR_BASE, get_idt_base());
+	vmwrite(HOST_IA32_SYSENTER_ESP, rdmsr(MSR_IA32_SYSENTER_ESP));
+	vmwrite(HOST_IA32_SYSENTER_EIP, rdmsr(MSR_IA32_SYSENTER_EIP));
+}
+
+/*
+ * Initialize the guest state fields essentially as a clone of
+ * the host state fields. Some host state fields have fixed
+ * values, and we set the corresponding guest state fields accordingly.
+ */
+static inline void init_vmcs_guest_state(void *rip, void *rsp)
+{
+	vmwrite(GUEST_ES_SELECTOR, vmreadz(HOST_ES_SELECTOR));
+	vmwrite(GUEST_CS_SELECTOR, vmreadz(HOST_CS_SELECTOR));
+	vmwrite(GUEST_SS_SELECTOR, vmreadz(HOST_SS_SELECTOR));
+	vmwrite(GUEST_DS_SELECTOR, vmreadz(HOST_DS_SELECTOR));
+	vmwrite(GUEST_FS_SELECTOR, vmreadz(HOST_FS_SELECTOR));
+	vmwrite(GUEST_GS_SELECTOR, vmreadz(HOST_GS_SELECTOR));
+	vmwrite(GUEST_LDTR_SELECTOR, 0);
+	vmwrite(GUEST_TR_SELECTOR, vmreadz(HOST_TR_SELECTOR));
+	vmwrite(GUEST_INTR_STATUS, 0);
+	vmwrite(GUEST_PML_INDEX, 0);
+
+	vmwrite(VMCS_LINK_POINTER, -1ll);
+	vmwrite(GUEST_IA32_DEBUGCTL, 0);
+	vmwrite(GUEST_IA32_PAT, vmreadz(HOST_IA32_PAT));
+	vmwrite(GUEST_IA32_EFER, vmreadz(HOST_IA32_EFER));
+	vmwrite(GUEST_IA32_PERF_GLOBAL_CTRL,
+		vmreadz(HOST_IA32_PERF_GLOBAL_CTRL));
+
+	vmwrite(GUEST_ES_LIMIT, -1);
+	vmwrite(GUEST_CS_LIMIT, -1);
+	vmwrite(GUEST_SS_LIMIT, -1);
+	vmwrite(GUEST_DS_LIMIT, -1);
+	vmwrite(GUEST_FS_LIMIT, -1);
+	vmwrite(GUEST_GS_LIMIT, -1);
+	vmwrite(GUEST_LDTR_LIMIT, -1);
+	vmwrite(GUEST_TR_LIMIT, 0x67);
+	vmwrite(GUEST_GDTR_LIMIT, 0xffff);
+	vmwrite(GUEST_IDTR_LIMIT, 0xffff);
+	vmwrite(GUEST_ES_AR_BYTES,
+		vmreadz(GUEST_ES_SELECTOR) == 0 ? 0x10000 : 0xc093);
+	vmwrite(GUEST_CS_AR_BYTES, 0xa09b);
+	vmwrite(GUEST_SS_AR_BYTES, 0xc093);
+	vmwrite(GUEST_DS_AR_BYTES,
+		vmreadz(GUEST_DS_SELECTOR) == 0 ? 0x10000 : 0xc093);
+	vmwrite(GUEST_FS_AR_BYTES,
+		vmreadz(GUEST_FS_SELECTOR) == 0 ? 0x10000 : 0xc093);
+	vmwrite(GUEST_GS_AR_BYTES,
+		vmreadz(GUEST_GS_SELECTOR) == 0 ? 0x10000 : 0xc093);
+	vmwrite(GUEST_LDTR_AR_BYTES, 0x10000);
+	vmwrite(GUEST_TR_AR_BYTES, 0x8b);
+	vmwrite(GUEST_INTERRUPTIBILITY_INFO, 0);
+	vmwrite(GUEST_ACTIVITY_STATE, 0);
+	vmwrite(GUEST_SYSENTER_CS, vmreadz(HOST_IA32_SYSENTER_CS));
+	vmwrite(VMX_PREEMPTION_TIMER_VALUE, 0);
+
+	vmwrite(GUEST_CR0, vmreadz(HOST_CR0));
+	vmwrite(GUEST_CR3, vmreadz(HOST_CR3));
+	vmwrite(GUEST_CR4, vmreadz(HOST_CR4));
+	vmwrite(GUEST_ES_BASE, 0);
+	vmwrite(GUEST_CS_BASE, 0);
+	vmwrite(GUEST_SS_BASE, 0);
+	vmwrite(GUEST_DS_BASE, 0);
+	vmwrite(GUEST_FS_BASE, vmreadz(HOST_FS_BASE));
+	vmwrite(GUEST_GS_BASE, vmreadz(HOST_GS_BASE));
+	vmwrite(GUEST_LDTR_BASE, 0);
+	vmwrite(GUEST_TR_BASE, vmreadz(HOST_TR_BASE));
+	vmwrite(GUEST_GDTR_BASE, vmreadz(HOST_GDTR_BASE));
+	vmwrite(GUEST_IDTR_BASE, vmreadz(HOST_IDTR_BASE));
+	vmwrite(GUEST_DR7, 0x400);
+	vmwrite(GUEST_RSP, (uint64_t)rsp);
+	vmwrite(GUEST_RIP, (uint64_t)rip);
+	vmwrite(GUEST_RFLAGS, 2);
+	vmwrite(GUEST_PENDING_DBG_EXCEPTIONS, 0);
+	vmwrite(GUEST_SYSENTER_ESP, vmreadz(HOST_IA32_SYSENTER_ESP));
+	vmwrite(GUEST_SYSENTER_EIP, vmreadz(HOST_IA32_SYSENTER_EIP));
+}
+
+static inline void prepare_vmcs(void *guest_rip, void *guest_rsp)
+{
+	init_vmcs_control_fields();
+	init_vmcs_host_state();
+	init_vmcs_guest_state(guest_rip, guest_rsp);
+}
+
+struct kvm_vm *vm_create_default_vmx(uint32_t vcpuid,
+				     vmx_guest_code_t guest_code);
+
+#endif /* !SELFTEST_KVM_VMX_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e213d513dc61..2cedfda181d4 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -378,7 +378,7 @@ int kvm_memcmp_hva_gva(void *hva,
  * complicated. This function uses a reasonable default length for
  * the array and performs the appropriate allocation.
  */
-struct kvm_cpuid2 *allocate_kvm_cpuid2(void)
+static struct kvm_cpuid2 *allocate_kvm_cpuid2(void)
 {
 	struct kvm_cpuid2 *cpuid;
 	int nent = 100;
@@ -402,17 +402,21 @@ struct kvm_cpuid2 *allocate_kvm_cpuid2(void)
  * Input Args: None
  *
  * Output Args:
- *   cpuid - The supported KVM CPUID
  *
- * Return: void
+ * Return: The supported KVM CPUID
  *
  * Get the guest CPUID supported by KVM.
  */
-void kvm_get_supported_cpuid(struct kvm_cpuid2 *cpuid)
+struct kvm_cpuid2 *kvm_get_supported_cpuid(void)
 {
+	static struct kvm_cpuid2 *cpuid;
 	int ret;
 	int kvm_fd;
 
+	if (cpuid)
+		return cpuid;
+
+	cpuid = allocate_kvm_cpuid2();
 	kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
 	TEST_ASSERT(kvm_fd >= 0, "open %s failed, rc: %i errno: %i",
 		KVM_DEV_PATH, kvm_fd, errno);
@@ -422,6 +426,7 @@ void kvm_get_supported_cpuid(struct kvm_cpuid2 *cpuid)
 		    ret, errno);
 
 	close(kvm_fd);
+	return cpuid;
 }
 
 /* Locate a cpuid entry.
@@ -435,12 +440,13 @@ void kvm_get_supported_cpuid(struct kvm_cpuid2 *cpuid)
  * Return: A pointer to the cpuid entry. Never returns NULL.
  */
 struct kvm_cpuid_entry2 *
-find_cpuid_index_entry(struct kvm_cpuid2 *cpuid, uint32_t function,
-		       uint32_t index)
+kvm_get_supported_cpuid_index(uint32_t function, uint32_t index)
 {
+	struct kvm_cpuid2 *cpuid;
 	struct kvm_cpuid_entry2 *entry = NULL;
 	int i;
 
+	cpuid = kvm_get_supported_cpuid();
 	for (i = 0; i < cpuid->nent; i++) {
 		if (cpuid->entries[i].function == function &&
 		    cpuid->entries[i].index == index) {
diff --git a/tools/testing/selftests/kvm/lib/vmx.c b/tools/testing/selftests/kvm/lib/vmx.c
new file mode 100644
index 000000000000..7f7bf154bdb0
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/vmx.c
@@ -0,0 +1,54 @@
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
+/* Create a default VM for VMX tests.
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
+struct kvm_vm *
+vm_create_default_vmx(uint32_t vcpuid, vmx_guest_code_t guest_code)
+{
+	struct kvm_cpuid2 *cpuid;
+	struct kvm_vm *vm;
+	vm_vaddr_t vmxon_vaddr;
+	vm_paddr_t vmxon_paddr;
+	vm_vaddr_t vmcs_vaddr;
+	vm_paddr_t vmcs_paddr;
+
+	vm = vm_create_default(vcpuid, (void *) guest_code);
+
+	/* Enable nesting in CPUID */
+	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
+
+	/* Setup of a region of guest memory for the vmxon region. */
+	vmxon_vaddr = vm_vaddr_alloc(vm, getpagesize(), 0, 0, 0);
+	vmxon_paddr = addr_gva2gpa(vm, vmxon_vaddr);
+
+	/* Setup of a region of guest memory for a vmcs. */
+	vmcs_vaddr = vm_vaddr_alloc(vm, getpagesize(), 0, 0, 0);
+	vmcs_paddr = addr_gva2gpa(vm, vmcs_vaddr);
+
+	vcpu_args_set(vm, vcpuid, 4, vmxon_vaddr, vmxon_paddr, vmcs_vaddr,
+		      vmcs_paddr);
+
+	return vm;
+}
diff --git a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
new file mode 100644
index 000000000000..f614d0aea668
--- /dev/null
+++ b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
@@ -0,0 +1,222 @@
+/*
+ * gtests/tests/vmx_tsc_adjust_test.c
+ *
+ * Copyright (C) 2018, Google LLC.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ *
+ * IA32_TSC_ADJUST test
+ *
+ * According to the SDM, "if an execution of WRMSR to the
+ * IA32_TIME_STAMP_COUNTER MSR adds (or subtracts) value X from the TSC,
+ * the logical processor also adds (or subtracts) value X from the
+ * IA32_TSC_ADJUST MSR.
+ *
+ * Note that when L1 doesn't intercept writes to IA32_TSC, a
+ * WRMSR(IA32_TSC) from L2 sets L1's TSC value, not L2's perceived TSC
+ * value.
+ *
+ * This test verifies that this unusual case is handled correctly.
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "x86.h"
+#include "vmx.h"
+
+#include <string.h>
+#include <sys/ioctl.h>
+
+#ifndef MSR_IA32_TSC_ADJUST
+#define MSR_IA32_TSC_ADJUST 0x3b
+#endif
+
+#define PAGE_SIZE	4096
+#define VCPU_ID		5
+
+#define TSC_ADJUST_VALUE (1ll << 32)
+#define TSC_OFFSET_VALUE -(1ll << 48)
+
+enum {
+	PORT_ABORT = 0x1000,
+	PORT_REPORT,
+	PORT_DONE,
+};
+
+struct vmx_page {
+	vm_vaddr_t virt;
+	vm_paddr_t phys;
+};
+
+enum {
+	VMXON_PAGE = 0,
+	VMCS_PAGE,
+	MSR_BITMAP_PAGE,
+
+	NUM_VMX_PAGES,
+};
+
+struct kvm_single_msr {
+	struct kvm_msrs header;
+	struct kvm_msr_entry entry;
+} __attribute__((packed));
+
+/* The virtual machine object. */
+static struct kvm_vm *vm;
+
+/* Array of vmx_page descriptors that is shared with the guest. */
+struct vmx_page *vmx_pages;
+
+#define exit_to_l0(_port, _arg) do_exit_to_l0(_port, (unsigned long) (_arg))
+static void do_exit_to_l0(uint16_t port, unsigned long arg)
+{
+	__asm__ __volatile__("in %[port], %%al"
+		:
+		: [port]"d"(port), "D"(arg)
+		: "rax");
+}
+
+
+#define GUEST_ASSERT(_condition) do {					     \
+	if (!(_condition))						     \
+		exit_to_l0(PORT_ABORT, "Failed guest assert: " #_condition); \
+} while (0)
+
+static void check_ia32_tsc_adjust(int64_t max)
+{
+	int64_t adjust;
+
+	adjust = rdmsr(MSR_IA32_TSC_ADJUST);
+	exit_to_l1(PORT_REPORT, adjust);
+	GUEST_ASSERT(adjust <= max);
+}
+
+static void l2_guest_code(void)
+{
+	uint64_t l1_tsc = rdtsc() - TSC_OFFSET_VALUE;
+
+	wrmsr(MSR_IA32_TSC, l1_tsc - TSC_ADJUST_VALUE);
+	check_ia32_tsc_adjust(-2 * TSC_ADJUST_VALUE);
+
+	/* Exit to L1 */
+	__asm__ __volatile__("vmcall");
+}
+
+static void l1_guest_code(struct vmx_page *vmx_pages)
+{
+#define L2_GUEST_STACK_SIZE 64
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	uint32_t control;
+
+	GUEST_ASSERT(rdtsc() < TSC_ADJUST_VALUE);
+	wrmsr(MSR_IA32_TSC, rdtsc() - TSC_ADJUST_VALUE);
+	check_ia32_tsc_adjust(-1 * TSC_ADJUST_VALUE);
+
+	prepare_for_vmx_operation();
+
+	/* Enter VMX root operation. */
+	*(uint32_t *)vmx_pages[VMXON_PAGE].virt = vmcs_revision();
+	GUEST_ASSERT(!vmxon(vmx_pages[VMXON_PAGE].phys));
+
+	/* Load a VMCS. */
+	*(uint32_t *)vmx_pages[VMCS_PAGE].virt = vmcs_revision();
+	GUEST_ASSERT(!vmclear(vmx_pages[VMCS_PAGE].phys));
+	GUEST_ASSERT(!vmptrld(vmx_pages[VMCS_PAGE].phys));
+
+	/* Prepare the VMCS for L2 execution. */
+	prepare_vmcs(l2_guest_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETING;
+	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
+	vmwrite(MSR_BITMAP, vmx_pages[MSR_BITMAP_PAGE].phys);
+	vmwrite(TSC_OFFSET, TSC_OFFSET_VALUE);
+
+	/* Jump into L2. */
+	GUEST_ASSERT(!vmlaunch());
+	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+
+	check_ia32_tsc_adjust(-2 * TSC_ADJUST_VALUE);
+
+	exit_to_l0(PORT_DONE, 0);
+}
+
+static void allocate_vmx_page(struct vmx_page *page)
+{
+	vm_vaddr_t virt;
+
+	virt = vm_vaddr_alloc(vm, PAGE_SIZE, 0, 0, 0);
+	memset(addr_gva2hva(vm, virt), 0, PAGE_SIZE);
+
+	page->virt = virt;
+	page->phys = addr_gva2gpa(vm, virt);
+}
+
+static vm_vaddr_t allocate_vmx_pages(void)
+{
+	vm_vaddr_t vmx_pages_vaddr;
+	int i;
+
+	vmx_pages_vaddr = vm_vaddr_alloc(
+		vm, sizeof(struct vmx_page) * NUM_VMX_PAGES, 0, 0, 0);
+
+	vmx_pages = (void *) addr_gva2hva(vm, vmx_pages_vaddr);
+
+	for (i = 0; i < NUM_VMX_PAGES; i++)
+		allocate_vmx_page(&vmx_pages[i]);
+
+	return vmx_pages_vaddr;
+}
+
+void report(int64_t val)
+{
+	printf("IA32_TSC_ADJUST is %ld (%lld * TSC_ADJUST_VALUE + %lld).\n",
+	       val, val / TSC_ADJUST_VALUE, val % TSC_ADJUST_VALUE);
+}
+
+int main(int argc, char *argv[])
+{
+	vm_vaddr_t vmx_pages_vaddr;
+	struct kvm_cpuid_entry2 *entry = kvm_get_supported_cpuid_entry(1);
+
+	if (!(entry->ecx & CPUID_VMX)) {
+		printf("nested VMX not enabled, skipping test");
+		return 0;
+	}
+
+	vm = vm_create_default_vmx(VCPU_ID, (void *) l1_guest_code);
+
+	/* Allocate VMX pages and shared descriptors (vmx_pages). */
+	vmx_pages_vaddr = allocate_vmx_pages();
+	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_vaddr);
+
+	for (;;) {
+		volatile struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+		struct kvm_regs regs;
+
+		vcpu_run(vm, VCPU_ID);
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+			    "Got exit_reason other than KVM_EXIT_IO: %u (%s),\n",
+			    run->exit_reason,
+			    exit_reason_str(run->exit_reason));
+
+		vcpu_regs_get(vm, VCPU_ID, &regs);
+
+		switch (run->io.port) {
+		case PORT_ABORT:
+			TEST_ASSERT(false, "%s", (const char *) regs.rdi);
+			/* NOT REACHED */
+		case PORT_REPORT:
+			report(regs.rdi);
+			break;
+		case PORT_DONE:
+			goto done;
+		default:
+			TEST_ASSERT(false, "Unknown port 0x%x.", run->io.port);
+		}
+	}
+
+	kvm_vm_free(vm);
+done:
+	return 0;
+}
-- 
1.8.3.1
