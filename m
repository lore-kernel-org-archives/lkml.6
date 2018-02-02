Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224ia62W3OMg+KzlTDclBsaTHDLs2tQxySizmDeBAPhI907NWumXcWYWBJV+FdM7mJtnbQQ3
ARC-Seal: i=1; a=rsa-sha256; t=1517591569; cv=none;
        d=google.com; s=arc-20160816;
        b=d5dREu4bsK4VWmGKW2+YjhN8q4JZfXnRcK4hU+Crt+NxtI3ps6tsas8dbf6cz/kVfV
         9/W/ilMzzYaeSBOLEQfjWl7XraZfV16j6ISt5P4DcT/knAuYARZ5m9Y3DyG1gxuQ46Tr
         nr3K3PmcoQPpZHiFYSTRvMCdQVn1KQM1EUFggpsxcEPNG9ssRBjvHkyd+Kyf/apqG1Tn
         DnO5q1r5vEf3fgg6E21JoBjtumVmej1AliAEQBvoF97zn+RJRv1HIPQXNDUNiXDewXC7
         50HGh7TOhwiN59rNuncrIwJD3gMpcQa22dHirvfMVBXQ4cLnle4FYqq3NzGELw5OR+78
         rFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wR1sVdRL1SawtfAT6IJCOXjceKOvmOkxWWphbAqI/Ho=;
        b=zqI+/0XnrQAoZoeelpKB/5tW5s78BYdBPVFMDJmT5E72rD9xZG6vp6PgxOUGucB0oB
         gf5lhNd7/PSWVNCnMLTrtgO0xtc2ExOsIfioEZNHGNLqcsGLeuQO+2ILApcfa2f8ME8T
         r0qHEtoxD5ca3XcD/niNVC41bmJVugYWS/J3S8CHiMSTCcDcJy3PC00OQUAYaff4IoFQ
         DJzVkmeFWcAQ6965C+RBsvW20CRfYBMW5DB8od+XtgZkhKDebdFO3GD1t9/DMs5VhK17
         a/Z1bkTQDYYiT3DFBRhh5/meSSt1hEdGdi2ENxDHjReG5+mQi3dV5bnwQpc3+D/zl47f
         Bp3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	xen-devel@lists.xenproject.org,
	boris.ostrovsky@oracle.com,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 124/156] x86/xen: Support early interrupts in xen pv guests
Date: Fri,  2 Feb 2018 17:58:25 +0100
Message-Id: <20180202140845.994367591@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310097679908944?=
X-GMAIL-MSGID: =?utf-8?q?1591310097679908944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>


[ Upstream commit 42b3a4cb5609de757f5445fcad18945ba9239a07 ]

Add early interrupt handlers activated by idt_setup_early_handler() to
the handlers supported by Xen pv guests. This will allow for early
WARN() calls not crashing the guest.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com
Link: https://lkml.kernel.org/r/20171124084221.30172-1-jgross@suse.com
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/segment.h |   12 ++++++++++++
 arch/x86/mm/extable.c          |    4 +++-
 arch/x86/xen/enlighten_pv.c    |   37 ++++++++++++++++++++++++-------------
 arch/x86/xen/xen-asm_64.S      |   14 ++++++++++++++
 4 files changed, 53 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -236,11 +236,23 @@
  */
 #define EARLY_IDT_HANDLER_SIZE 9
 
+/*
+ * xen_early_idt_handler_array is for Xen pv guests: for each entry in
+ * early_idt_handler_array it contains a prequel in the form of
+ * pop %rcx; pop %r11; jmp early_idt_handler_array[i]; summing up to
+ * max 8 bytes.
+ */
+#define XEN_EARLY_IDT_HANDLER_SIZE 8
+
 #ifndef __ASSEMBLY__
 
 extern const char early_idt_handler_array[NUM_EXCEPTION_VECTORS][EARLY_IDT_HANDLER_SIZE];
 extern void early_ignore_irq(void);
 
+#if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
+extern const char xen_early_idt_handler_array[NUM_EXCEPTION_VECTORS][XEN_EARLY_IDT_HANDLER_SIZE];
+#endif
+
 /*
  * Load a segment. Fall back on loading the zero segment if something goes
  * wrong.  This variant assumes that loading zero fully clears the segment.
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -1,6 +1,7 @@
 #include <linux/extable.h>
 #include <linux/uaccess.h>
 #include <linux/sched/debug.h>
+#include <xen/xen.h>
 
 #include <asm/fpu/internal.h>
 #include <asm/traps.h>
@@ -212,8 +213,9 @@ void __init early_fixup_exception(struct
 	 * Old CPUs leave the high bits of CS on the stack
 	 * undefined.  I'm not sure which CPUs do this, but at least
 	 * the 486 DX works this way.
+	 * Xen pv domains are not using the default __KERNEL_CS.
 	 */
-	if (regs->cs != __KERNEL_CS)
+	if (!xen_pv_domain() && regs->cs != __KERNEL_CS)
 		goto fail;
 
 	/*
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -622,7 +622,7 @@ static struct trap_array_entry trap_arra
 	{ simd_coprocessor_error,      xen_simd_coprocessor_error,      false },
 };
 
-static bool get_trap_addr(void **addr, unsigned int ist)
+static bool __ref get_trap_addr(void **addr, unsigned int ist)
 {
 	unsigned int nr;
 	bool ist_okay = false;
@@ -644,6 +644,14 @@ static bool get_trap_addr(void **addr, u
 		}
 	}
 
+	if (nr == ARRAY_SIZE(trap_array) &&
+	    *addr >= (void *)early_idt_handler_array[0] &&
+	    *addr < (void *)early_idt_handler_array[NUM_EXCEPTION_VECTORS]) {
+		nr = (*addr - (void *)early_idt_handler_array[0]) /
+		     EARLY_IDT_HANDLER_SIZE;
+		*addr = (void *)xen_early_idt_handler_array[nr];
+	}
+
 	if (WARN_ON(ist != 0 && !ist_okay))
 		return false;
 
@@ -1261,6 +1269,21 @@ asmlinkage __visible void __init xen_sta
 	xen_setup_gdt(0);
 
 	xen_init_irq_ops();
+
+	/* Let's presume PV guests always boot on vCPU with id 0. */
+	per_cpu(xen_vcpu_id, 0) = 0;
+
+	/*
+	 * Setup xen_vcpu early because idt_setup_early_handler needs it for
+	 * local_irq_disable(), irqs_disabled().
+	 *
+	 * Don't do the full vcpu_info placement stuff until we have
+	 * the cpu_possible_mask and a non-dummy shared_info.
+	 */
+	xen_vcpu_info_reset(0);
+
+	idt_setup_early_handler();
+
 	xen_init_capabilities();
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -1294,18 +1317,6 @@ asmlinkage __visible void __init xen_sta
 	 */
 	acpi_numa = -1;
 #endif
-	/* Let's presume PV guests always boot on vCPU with id 0. */
-	per_cpu(xen_vcpu_id, 0) = 0;
-
-	/*
-	 * Setup xen_vcpu early because start_kernel needs it for
-	 * local_irq_disable(), irqs_disabled().
-	 *
-	 * Don't do the full vcpu_info placement stuff until we have
-	 * the cpu_possible_mask and a non-dummy shared_info.
-	 */
-	xen_vcpu_info_reset(0);
-
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_pv, xen_cpu_dead_pv));
 
 	local_irq_disable();
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -15,6 +15,7 @@
 
 #include <xen/interface/xen.h>
 
+#include <linux/init.h>
 #include <linux/linkage.h>
 
 .macro xen_pv_trap name
@@ -54,6 +55,19 @@ xen_pv_trap entry_INT80_compat
 #endif
 xen_pv_trap hypervisor_callback
 
+	__INIT
+ENTRY(xen_early_idt_handler_array)
+	i = 0
+	.rept NUM_EXCEPTION_VECTORS
+	pop %rcx
+	pop %r11
+	jmp early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE
+	i = i + 1
+	.fill xen_early_idt_handler_array + i*XEN_EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
+	.endr
+END(xen_early_idt_handler_array)
+	__FINIT
+
 hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
 /*
  * Xen64 iret frame:
