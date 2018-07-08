Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE0C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEFA208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEFA208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeGHC6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 22:58:01 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:52196
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754509AbeGHC57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 22:57:59 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id bzsffYerc0KO8bzsff6aMB; Sat, 07 Jul 2018 19:56:58 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fbzsf-00070w-Jk; Sat, 07 Jul 2018 19:56:57 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic
Date:   Sun,  8 Jul 2018 02:56:51 +0000
Message-Id: <20180708025651.26922-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfFWe0GI65cBw/CFxq1e8jE1TaWIo6ml0pBNgGZSKJlyhK5qNjR+Pdc+AJsahexU3fKLTrHblD2IdCNk8ahKezqEEi480p215sF5ivJST2CgNCETJf49I
 5aViRc/+NbJWlrw4f2h8OXqXOSLIoTBnBI9Z/bWr3UuR9Yxax+Uy69Tyv0KahpSvQOHbbIW2E9lI4NYsQcUSBUJ+SGfO9KtqINtcTE//d4eOb+2rFNYwzyFe
 5VkduTZDHnF55rCBFtn4rysA9NCJ2cE+AzMfc9fnbhegwhECcDOfPt5xY6hA2XB+LzfUn7iNdw20QHe3m2WeTHqtkwCW1qopN4884ps+Gpvsoe9IPZYVBs5L
 eefK/9F/oVp8py63CExI/vEXiwcyVaBSRZOj7ZPkNTVO13ywENI+hxZf3JLNIlVkCIpVSCGsBHlhPrtUEMY+rnqvUMVcd4vvEuoqKeqiCF3+3t5yyCdhdJ+b
 AODV3Xe39amvvgW3422jZHVC0SzQCyUBjn1c3sT1BTA9zF66STDP49r7ITyYi6kyoJd03YajejyylVvx2PCa0mU0FdYmYYU5dDUKtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

In the VM mode on Hyper-V, currently, when the kernel panics, an error
code and few register values are populated in an MSR and the Hypervisor
notified. This information is collected on the host. The amount of
information currently collected is found to be limited and not very
actionable. To gather more actionable data, such as stack trace, the
proposal is to write one page worth of kmsg data on an allocated page
and the Hypervisor notified of the page address through the MSR.

- Sysctl option to control the behavior, with ON by default.

Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 Documentation/sysctl/kernel.txt    |  11 +++
 arch/x86/hyperv/hv_init.c          |  27 +++++++
 arch/x86/include/asm/hyperv-tlfs.h |   5 +-
 arch/x86/include/asm/mshyperv.h    |   1 +
 drivers/hv/vmbus_drv.c             | 110 +++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index eded671d55eb..59585030cbaf 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -39,6 +39,7 @@ show up in /proc/sys/kernel:
 - hung_task_check_count
 - hung_task_timeout_secs
 - hung_task_warnings
+- hyperv_record_panic_msg
 - kexec_load_disabled
 - kptr_restrict
 - l2cr                        [ PPC only ]
@@ -374,6 +375,16 @@ This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
 
 ==============================================================
 
+hyperv_record_panic_msg:
+
+Controls whether the panic kmsg data should be reported to Hyper-V.
+
+0: do not report panic kmsg data.
+
+1: report the panic kmsg data. This is the default behavior.
+
+==============================================================
+
 kexec_load_disabled:
 
 A toggle indicating if the kexec_load syscall has been disabled. This
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 595e44e8abaa..9c70018a9906 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -423,6 +423,33 @@ void hyperv_report_panic(struct pt_regs *regs, long err)
 }
 EXPORT_SYMBOL_GPL(hyperv_report_panic);
 
+/**
+ * hyperv_report_panic_msg - report panic message to Hyper-V
+ * @pa: physical address of the panic page containing the message
+ * @size: size of the message in the page
+ */
+void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
+{
+	/*
+	 * P3 to contain the physical address of the panic page & P4 to
+	 * contain the size of the panic data in that page. Rest of the
+	 * registers are no-op when the NOTIFY_MSG flag is set.
+	 */
+	wrmsrl(HV_X64_MSR_CRASH_P0, 0);
+	wrmsrl(HV_X64_MSR_CRASH_P1, 0);
+	wrmsrl(HV_X64_MSR_CRASH_P2, 0);
+	wrmsrl(HV_X64_MSR_CRASH_P3, pa);
+	wrmsrl(HV_X64_MSR_CRASH_P4, size);
+
+	/*
+	 * Let Hyper-V know there is crash data available along with
+	 * the panic message.
+	 */
+	wrmsrl(HV_X64_MSR_CRASH_CTL,
+	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
+
 bool hv_is_hyperv_initialized(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 96272e99b64e..6ced78af48da 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -176,9 +176,10 @@
 #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED    (1 << 14)
 
 /*
- * Crash notification flag.
+ * Crash notification flags.
  */
-#define HV_CRASH_CTL_CRASH_NOTIFY (1ULL << 63)
+#define HV_CRASH_CTL_CRASH_NOTIFY_MSG	BIT_ULL(62)
+#define HV_CRASH_CTL_CRASH_NOTIFY	BIT_ULL(63)
 
 /* MSR used to identify the guest OS. */
 #define HV_X64_MSR_GUEST_OS_ID			0x40000000
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 81e768b8d9eb..156a2e5a97a9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -299,6 +299,7 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void hyperv_report_panic(struct pt_regs *regs, long err);
+void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 void hyperv_cleanup(void);
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b10fe26c4891..05e37283d7c3 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -56,6 +56,8 @@ static struct completion probe_event;
 
 static int hyperv_cpuhp_online;
 
+static void *hv_panic_page;
+
 static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 			      void *args)
 {
@@ -1018,6 +1020,75 @@ static void vmbus_isr(void)
 	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
 }
 
+/*
+ * Boolean to control whether to report panic messages over Hyper-V.
+ *
+ * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
+ */
+static int sysctl_record_panic_msg = 1;
+
+/*
+ * Callback from kmsg_dump. Grab as much as possible from the end of the kmsg
+ * buffer and call into Hyper-V to transfer the data.
+ */
+static void hv_kmsg_dump(struct kmsg_dumper *dumper,
+			 enum kmsg_dump_reason reason)
+{
+	size_t bytes_written;
+	phys_addr_t panic_pa;
+
+	/* We are only interested in panics. */
+	if ((reason != KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
+		return;
+
+	panic_pa = virt_to_phys(hv_panic_page);
+
+	/*
+	 * Write dump contents to the page. No need to synchronize; panic should
+	 * be single-threaded.
+	 */
+	if (!kmsg_dump_get_buffer(dumper, true, hv_panic_page,
+				  PAGE_SIZE, &bytes_written)) {
+		pr_err("Hyper-V: Unable to get kmsg data for panic\n");
+		return;
+	}
+
+	hyperv_report_panic_msg(panic_pa, bytes_written);
+}
+
+static struct kmsg_dumper hv_kmsg_dumper = {
+	.dump = hv_kmsg_dump,
+};
+
+static struct ctl_table_header *hv_ctl_table_hdr;
+static int zero;
+static int one = 1;
+
+/*
+ * sysctl option to allow the user to control whether kmsg data should be
+ * reported to Hyper-V on panic.
+ */
+static struct ctl_table hv_ctl_table[] = {
+	{
+		.procname       = "hyperv_record_panic_msg",
+		.data           = &sysctl_record_panic_msg,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one
+	},
+	{}
+};
+
+static struct ctl_table hv_root_table[] = {
+	{
+		.procname	= "kernel",
+		.mode		= 0555,
+		.child		= hv_ctl_table
+	},
+	{}
+};
 
 /*
  * vmbus_bus_init -Main vmbus driver initialization routine.
@@ -1065,6 +1136,32 @@ static int vmbus_bus_init(void)
 	 * Only register if the crash MSRs are available
 	 */
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+		u64 hyperv_crash_ctl;
+		/*
+		 * Sysctl registration is not fatal, since by default
+		 * reporting is enabled.
+		 */
+		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
+		if (!hv_ctl_table_hdr)
+			pr_err("Hyper-V: sysctl table register error");
+
+		/*
+		 * Register for panic kmsg callback only if the right
+		 * capability is supported by the hypervisor.
+		 */
+		rdmsrl(HV_X64_MSR_CRASH_CTL, hyperv_crash_ctl);
+		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG) {
+			hv_panic_page = (void *)get_zeroed_page(GFP_KERNEL);
+			if (hv_panic_page) {
+				ret = kmsg_dump_register(&hv_kmsg_dumper);
+				if (ret)
+					pr_err("Hyper-V: kmsg dump register "
+						"error 0x%x\n", ret);
+			} else
+				pr_err("Hyper-V: panic message page memory "
+					"allocation failed");
+		}
+
 		register_die_notifier(&hyperv_die_block);
 		atomic_notifier_chain_register(&panic_notifier_list,
 					       &hyperv_panic_block);
@@ -1081,6 +1178,11 @@ static int vmbus_bus_init(void)
 	hv_remove_vmbus_irq();
 
 	bus_unregister(&hv_bus);
+	free_page((unsigned long)hv_panic_page);
+	if (!hv_ctl_table_hdr) {
+		unregister_sysctl_table(hv_ctl_table_hdr);
+		hv_ctl_table_hdr = NULL;
+	}
 
 	return ret;
 }
@@ -1785,10 +1887,18 @@ static void __exit vmbus_exit(void)
 	vmbus_free_channels();
 
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+		kmsg_dump_unregister(&hv_kmsg_dumper);
 		unregister_die_notifier(&hyperv_die_block);
 		atomic_notifier_chain_unregister(&panic_notifier_list,
 						 &hyperv_panic_block);
 	}
+
+	free_page((unsigned long)hv_panic_page);
+	if (!hv_ctl_table_hdr) {
+		unregister_sysctl_table(hv_ctl_table_hdr);
+		hv_ctl_table_hdr = NULL;
+	}
+
 	bus_unregister(&hv_bus);
 
 	cpuhp_remove_state(hyperv_cpuhp_online);
-- 
2.17.1

