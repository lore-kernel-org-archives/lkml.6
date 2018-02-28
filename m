Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELvEHaNo3ZDzOFKLgnTWHSnhE1SjBZXgWTRnaMAPi45fcNJ2KwpNe2KXo/7xDRvT/Aimz7+i
ARC-Seal: i=1; a=rsa-sha256; t=1519842617; cv=none;
        d=google.com; s=arc-20160816;
        b=GHWEOqFspRUWh8ht9fruT6ROshBTzjGchTWP0umYfMw81CXD8N8naGfJ+PminDVESI
         Rn3lfQ20vMVEPJ2QDyFyHpjLn1gmFpisadhP3PSpCxeliYfq8OjDopDCcIX5HxMUOBW7
         v59TfSW+phSLoqdNUAiFEglQPe1uVLHvZBNow3J+/j9YDjyPNCzUyIQ704Il0VdEju/8
         10P9VcVt6ZWjMIJwSi64Rymu/0Vvayoq4ePvLqqQjQxT5UAuRLbC4f5jb41Jlpmx0uq5
         Y7S0TQ1F2EGrRS4+dDNwC3iL59OwarjQ1HswB8zFlJLhigy2pNdXPY6PXjAF7DxFvxA4
         m1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=CynUHG06YZdxTsjMWHTTmOcY/puewD1H81xubBboeCo=;
        b=VIomR+4NU3/qWMh9lC37G4D2womuZ8JXTjK1cSAIz2VSOkGvv7Fkx4R3gZUGgFHYhB
         Sjs9WAYw+M0h7S25kgZSzqwLRU3V2+1Q0+stebY7qvrpbs4BqWYjFfSagHQtt0wnDLRn
         e4TispsJMeRq2+1jegLPIMZ5DlIBlzMenNhGyjOQI8tcR0fBqS1Rp77fEtStRZ4zKnOE
         MbnR8vGcDkedNFGq/yY2k3/ThTvCAd/cYh9qQSFqXiXrvf2zCAHd3ox1JRAwU/OreWVX
         xFrE84I2gRJJRNtSDCoAU0HrnChFfoBC/loXas63Cz+kdbgNz+qwB+np5U24GlL867aZ
         oy7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=h7jVt9ze;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=h7jVt9ze;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
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
Subject: [RFC PATCH v4 4/7] xen/pvh: Move Xen specific PVH VM initialization out of common code
Date: Wed, 28 Feb 2018 10:28:00 -0800
Message-Id: <1519842483-8887-5-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280224
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670492940069413?=
X-GMAIL-MSGID: =?utf-8?q?1593670492940069413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We need to refactor PVH entry code so that support for other hypervisors
like Qemu/KVM can be added more easily.

This patch moves the small block of code used for initializing Xen PVH
virtual machines into the Xen specific file. This initialization is not
going to be needed for Qemu/KVM guests. Moving it out of the common file
is going to allow us to compile kernels in the future without CONFIG_XEN
that are still capable of being booted as a Qemu/KVM guest via the PVH
entry point.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 arch/x86/pvh.c               | 28 ++++++++++++++++++++--------
 arch/x86/xen/enlighten_pvh.c | 18 +++++++++++++++++-
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/x86/pvh.c b/arch/x86/pvh.c
index b56cb5e7d6ac..2d7a7f4958cb 100644
--- a/arch/x86/pvh.c
+++ b/arch/x86/pvh.c
@@ -72,26 +72,38 @@ static void __init init_pvh_bootparams(void)
 	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
 }
 
+/*
+ * If we are trying to boot a Xen PVH guest, it is expected that the kernel
+ * will have been configured to provide the required override for this routine.
+ */
+void __init __weak xen_pvh_init(void)
+{
+	xen_raw_printk("Error: Missing xen PVH initialization\n");
+	BUG();
+}
+
+/*
+ * When we add support for other hypervisors like Qemu/KVM, this routine can
+ * selectively invoke the appropriate initialization based on guest type.
+ */
+static void hypervisor_specific_init(void)
+{
+	xen_pvh_init();
+}
+
 /*
  * This routine (and those that it might call) should not use
  * anything that lives in .bss since that segment will be cleared later.
  */
 void __init xen_prepare_pvh(void)
 {
-	u32 msr;
-	u64 pfn;
-
 	if (pvh_start_info.magic != XEN_HVM_START_MAGIC_VALUE) {
 		xen_raw_printk("Error: Unexpected magic value (0x%08x)\n",
 				pvh_start_info.magic);
 		BUG();
 	}
 
-	xen_pvh = 1;
-
-	msr = cpuid_ebx(xen_cpuid_base() + 2);
-	pfn = __pa(hypercall_page);
-	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+	hypervisor_specific_init();
 
 	init_pvh_bootparams();
 }
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 4b4e9cc78b8a..833c441a20df 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,4 +1,9 @@
-#include <linux/types.h>
+#include <linux/acpi.h>
+
+#include <asm/io_apic.h>
+
+#include <asm/xen/interface.h>
+#include <asm/xen/hypercall.h>
 
 /*
  * PVH variables.
@@ -9,3 +14,14 @@
  */
 bool xen_pvh __attribute__((section(".data"))) = 0;
 
+void __init xen_pvh_init(void)
+{
+	u32 msr;
+	u64 pfn;
+
+	xen_pvh = 1;
+
+	msr = cpuid_ebx(xen_cpuid_base() + 2);
+	pfn = __pa(hypercall_page);
+	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+}
-- 
2.16.1
