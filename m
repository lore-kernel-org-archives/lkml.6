Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELuMlCmqwnStDLeIostmamUYQ9adHilx2ROU0ab0ffHSyEBEF8qgs9ZYV1KF1PV0ag+hcg2I
ARC-Seal: i=1; a=rsa-sha256; t=1519842663; cv=none;
        d=google.com; s=arc-20160816;
        b=thMm8YTnbTgGEPjwZJRl8fpaYSCCdfJ3ASTpCI1zXGBSnKDVBkhRAta7hM4PRN40aW
         wwsd9nD4Yg6+i2LTYHKVLO8QChRO/g1epDAF1VqqOiikDcUTKgLdWyifutL4XhwPA4pX
         B2get8yKehCHcCoKNZUgNneUpwjM/CjjoqR0yMqY0uzIJzz0Zxac106895vp08IIcBev
         kEy9xPQ9YCVN94wwbIrVKsNAnHumVgaUNe0iOhVHyBXmxvz9B3VuK0sU4QHMpmsoQJGD
         ioZ6vojtV7gcL+3xxkoaZph90V+7y+G3RmN6wwZncJQ5gHf6bnK9vTSMpgq6x8JosJvy
         K6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=XkYVVhW39KnOCMbiuvmHaVlGfp3iwNvI4xwPtt4aJus=;
        b=jep6tqhagegX8tLzKhBCSzNK5JP5CneuTWh33kOXG8SmqxqCqbvsohVoExzH3qlMjN
         mi2fk2835i0v1olDHrrYqdBOnWglJq4aDUwLN6jvgp/fS/vVY4xkZ6Sob2tdHqt87vAk
         dta7v1nMDKe31STbJWzIbFMO4NlIMHeUQWObbTcsX28HLDnbhZny5G/H0RuaE3gwWU9j
         t2yRw7q8W0PiUSdv7epwYhuDWyPToYvenxIhtosxQCS0kcHoNwDxCcXdqrmcrWIiBMhk
         UELMG9vozQEHUjMbk3RMpWKKHNth3U/v18Znf+qteqH1m+RzjCxvu7/92KqlqNSdNGGa
         z4fA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Tw+f0BEc;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Tw+f0BEc;
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
Subject: [RFC PATCH v4 7/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Date: Wed, 28 Feb 2018 10:28:03 -0800
Message-Id: <1519842483-8887-8-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280224
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670431489579630?=
X-GMAIL-MSGID: =?utf-8?q?1593670540775034005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For certain applications it is desirable to rapidly boot a KVM virtual
machine. In cases where legacy hardware and software support within the
guest is not needed, Qemu should be able to boot directly into the
uncompressed Linux kernel binary without the need to run firmware.

There already exists an ABI to allow this for Xen PVH guests and the ABI
is supported by Linux and FreeBSD:

   https://xenbits.xen.org/docs/unstable/misc/pvh.html

This patch enables Qemu to use that same entry point for booting KVM
guests.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 arch/x86/Kbuild |  4 ++--
 arch/x86/pvh.c  | 43 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index a4e5e3d348dc..e9dc0f1c9d32 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -7,8 +7,8 @@ obj-$(CONFIG_KVM) += kvm/
 # Xen paravirtualization support
 obj-$(CONFIG_XEN) += xen/
 
-obj-$(CONFIG_XEN_PVH) += pvh.o
-obj-$(CONFIG_XEN_PVH) += pvh-head.o
+obj-$(CONFIG_PVH) += pvh.o
+obj-$(CONFIG_PVH) += pvh-head.o
 
 # Hyper-V paravirtualization support
 obj-$(subst m,y,$(CONFIG_HYPERV)) += hyperv/
diff --git a/arch/x86/pvh.c b/arch/x86/pvh.c
index 6e9f6a6e97b3..97042d11342f 100644
--- a/arch/x86/pvh.c
+++ b/arch/x86/pvh.c
@@ -7,6 +7,9 @@
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
 
+#include <asm/xen/interface.h>
+#include <asm/xen/hypercall.h>
+
 #include <xen/interface/memory.h>
 #include <xen/interface/hvm/start_info.h>
 
@@ -34,11 +37,28 @@ void __init __weak mem_map_via_hcall(struct boot_params *ptr __maybe_unused)
 	BUG();
 }
 
-static void __init init_pvh_bootparams(void)
+static void __init init_pvh_bootparams(bool xen_guest)
 {
 	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
 
-	mem_map_via_hcall(&pvh_bootparams);
+	if ((pvh_start_info.version > 0) && (pvh_start_info.memmap_entries)) {
+		struct hvm_memmap_table_entry *ep;
+		int i;
+
+		ep = __va(pvh_start_info.memmap_paddr);
+		pvh_bootparams.e820_entries = pvh_start_info.memmap_entries;
+
+		for (i = 0; i < pvh_bootparams.e820_entries ; i++, ep++) {
+			pvh_bootparams.e820_table[i].addr = ep->addr;
+			pvh_bootparams.e820_table[i].size = ep->size;
+			pvh_bootparams.e820_table[i].type = ep->type;
+		}
+	} else if (xen_guest) {
+		mem_map_via_hcall(&pvh_bootparams);
+	} else {
+		/* Non-xen guests are not supported by version 0 */
+		BUG();
+	}
 
 	if (pvh_bootparams.e820_entries < E820_MAX_ENTRIES_ZEROPAGE - 1) {
 		pvh_bootparams.e820_table[pvh_bootparams.e820_entries].addr =
@@ -69,7 +89,7 @@ static void __init init_pvh_bootparams(void)
 	 * environment (i.e. hardware_subarch 0).
 	 */
 	pvh_bootparams.hdr.version = 0x212;
-	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
+	pvh_bootparams.hdr.type_of_loader = ((xen_guest ? 0x9 : 0xb) << 4) | 0;
 }
 
 /*
@@ -82,13 +102,10 @@ void __init __weak xen_pvh_init(void)
 	BUG();
 }
 
-/*
- * When we add support for other hypervisors like Qemu/KVM, this routine can
- * selectively invoke the appropriate initialization based on guest type.
- */
-static void hypervisor_specific_init(void)
+static void hypervisor_specific_init(bool xen_guest)
 {
-	xen_pvh_init();
+	if (xen_guest)
+		xen_pvh_init();
 }
 
 /*
@@ -97,13 +114,17 @@ static void hypervisor_specific_init(void)
  */
 void __init xen_prepare_pvh(void)
 {
+
+	u32 msr = xen_cpuid_base();
+	bool xen_guest = !!msr;
+
 	if (pvh_start_info.magic != XEN_HVM_START_MAGIC_VALUE) {
 		xen_raw_printk("Error: Unexpected magic value (0x%08x)\n",
 				pvh_start_info.magic);
 		BUG();
 	}
 
-	hypervisor_specific_init();
+	hypervisor_specific_init(xen_guest);
 
-	init_pvh_bootparams();
+	init_pvh_bootparams(xen_guest);
 }
-- 
2.16.1
