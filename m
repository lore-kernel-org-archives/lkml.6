Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELtb/KvHm1RT2qcfMYjtHWPuMvDZklt2sNumZIpa3SxcPyZpNqelXHFNIDgHqmohQCx9J55R
ARC-Seal: i=1; a=rsa-sha256; t=1519842559; cv=none;
        d=google.com; s=arc-20160816;
        b=fHMoXz+wxwDGi49Sj4zEekPEyKXemzLwm/kUllhtZ6jBHmUeKMLRX2j/274U2NQQfW
         daLznrjPsqLpcoqljij7Z7Yc3mjwemv09Y1nezFU+ZR4jxoyGchoALZe6IvUouTKR3xX
         JsdIq04qP5qGmuxflRy9JhImXn7G3v5WbEkFyeeozBdwwrhYbTZbHF1ccjViyeLh3JeC
         W0tCVxzFvLI8C5Wg+G2Aj4Ab6QDa+tlR2MCT8wIhw789AdsbSP3TglXHun3chPQ5zvDz
         UhykeP0zuhFi/KtinR1d/CqYltMk5Nv/hUf9xBYo6tvXtWumLwN8e2ELdyZ/oWMpmDYS
         oVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=WhVN4vJc/3o/DM9329n8zeF36pD+r4h+Z6q1+VtOocw=;
        b=gkXiCFf6yIALZcL5SAQk0WlBwE2l289NxBeEwA/xkJJeZfXHvJvX6SBG0Evm2wqtDi
         u2kG3sU4o4yhQA47vjFaWIZDKI2pqkPBH9kscFtsi3HYMsyQHMRueuFZIiuRX7OVGM5x
         PQfXdmcqFBNFqyQl0rr58veOG1ItpGRYiwiCmqFXDXq+iXhDivXRIYAR38/PidrInbro
         S2OA60gHqfv13CfUcDqR+2vnwm7WQ6UTCFC8tjBCQPK/3x+nX0gWK1+tKPtuyL6XELqn
         LzHI1eUfwoEepWv6Kug7xfj9rEjZCoGRIWYUzo+puFSTV5dvGbnfY8E9s4dSJ/7nVyjt
         M+zg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=s0iSGDeH;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=s0iSGDeH;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Maran Wilson <maran.wilson@oracle.com>
To: pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
        jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, luto@kernel.org, maran.wilson@oracle.com,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
Subject: [RFC PATCH v4 5/7] xen/pvh: Move Xen code for getting mem map via hcall out of common file
Date: Wed, 28 Feb 2018 10:28:01 -0800
Message-Id: <1519842483-8887-6-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280224
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670431984970161?=
X-GMAIL-MSGID: =?utf-8?q?1593670431984970161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We need to refactor PVH entry code so that support for other hypervisors
like Qemu/KVM can be added more easily.

The original design for PVH entry in Xen guests relies on being able to
obtain the memory map from the hypervisor using a hypercall. When we
extend the PVH entry ABI to support other hypervisors like Qemu/KVM,
a new mechanism will be added that allows the guest to get the memory
map without needing to use hypercalls.

For Xen guests, the hypercall approach will still be supported. In
preparation for adding support for other hypervisors, we can move the
code that uses hypercalls into the Xen specific file. This will allow us
to compile kernels in the future without CONFIG_XEN that are still capable
of being booted as a Qemu/KVM guest via the PVH entry point.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 arch/x86/pvh.c               | 28 ++++++++++++++--------------
 arch/x86/xen/enlighten_pvh.c | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/x86/pvh.c b/arch/x86/pvh.c
index 2d7a7f4958cb..6e9f6a6e97b3 100644
--- a/arch/x86/pvh.c
+++ b/arch/x86/pvh.c
@@ -7,9 +7,6 @@
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
 
-#include <asm/xen/interface.h>
-#include <asm/xen/hypercall.h>
-
 #include <xen/interface/memory.h>
 #include <xen/interface/hvm/start_info.h>
 
@@ -24,21 +21,24 @@ struct boot_params pvh_bootparams __attribute__((section(".data")));
 struct hvm_start_info pvh_start_info;
 unsigned int pvh_start_info_sz = sizeof(pvh_start_info);
 
+/*
+ * Xen guests are able to obtain the memory map from the hypervisor via the
+ * HYPERVISOR_memory_op hypercall.
+ * If we are trying to boot a Xen PVH guest, it is expected that the kernel
+ * will have been configured to provide an override for this routine to do
+ * just that.
+ */
+void __init __weak mem_map_via_hcall(struct boot_params *ptr __maybe_unused)
+{
+	xen_raw_printk("Error: Could not find memory map\n");
+	BUG();
+}
+
 static void __init init_pvh_bootparams(void)
 {
-	struct xen_memory_map memmap;
-	int rc;
-
 	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
 
-	memmap.nr_entries = ARRAY_SIZE(pvh_bootparams.e820_table);
-	set_xen_guest_handle(memmap.buffer, pvh_bootparams.e820_table);
-	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
-	if (rc) {
-		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
-		BUG();
-	}
-	pvh_bootparams.e820_entries = memmap.nr_entries;
+	mem_map_via_hcall(&pvh_bootparams);
 
 	if (pvh_bootparams.e820_entries < E820_MAX_ENTRIES_ZEROPAGE - 1) {
 		pvh_bootparams.e820_table[pvh_bootparams.e820_entries].addr =
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 833c441a20df..3a830caef8ee 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,10 +1,15 @@
 #include <linux/acpi.h>
 
+#include <xen/hvc-console.h>
+
 #include <asm/io_apic.h>
+#include <asm/e820/api.h>
 
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
 
+#include <xen/interface/memory.h>
+
 /*
  * PVH variables.
  *
@@ -25,3 +30,18 @@ void __init xen_pvh_init(void)
 	pfn = __pa(hypercall_page);
 	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
 }
+
+void __init mem_map_via_hcall(struct boot_params *boot_params_p)
+{
+	struct xen_memory_map memmap;
+	int rc;
+
+	memmap.nr_entries = ARRAY_SIZE(boot_params_p->e820_table);
+	set_xen_guest_handle(memmap.buffer, boot_params_p->e820_table);
+	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
+	if (rc) {
+		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
+		BUG();
+	}
+	boot_params_p->e820_entries = memmap.nr_entries;
+}
-- 
2.16.1
