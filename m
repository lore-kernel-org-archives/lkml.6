Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966457AbeEJPq2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:46:28 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:56187 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966191AbeEJPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:19 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:2:41:69:355:379:541:800:960:968:973:988:989:1260:1345:1359:1437:1535:1606:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2898:3138:3139:3140:3141:3142:3355:3865:3866:3867:3868:3871:3872:3874:4117:4250:4321:4419:4423:4605:5007:6117:6119:6261:6609:7875:8603:10004:10848:11026:11473:11657:11658:11914:12043:12296:12438:12555:12895:12986:13972:14394:21080:21451:21627:21740:30029:30054:30055:30070,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: class76_19d42434c0a0b
X-Filterd-Recvd-Size: 6035
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: [PATCH 05/18] x86/mtrr: Rename main.c to mtrr.c and remove duplicate prefixes
Date: Thu, 10 May 2018 08:45:31 -0700
Message-Id: <ae1fa81a0d1fad87571967b91ea90f70f486e853.1525964384.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild uses the first file as the name for KBUILD_MODNAME.
mtrr uses main.c as its first file, so rename that file to mtrr.c
and fixup the Makefile.

Remove the now duplicate "mtrr: " prefixes from the logging calls.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/x86/kernel/cpu/mtrr/Makefile           |  2 +-
 arch/x86/kernel/cpu/mtrr/{main.c => mtrr.c} | 33 ++++++++++++++---------------
 2 files changed, 17 insertions(+), 18 deletions(-)
 rename arch/x86/kernel/cpu/mtrr/{main.c => mtrr.c} (96%)

diff --git a/arch/x86/kernel/cpu/mtrr/Makefile b/arch/x86/kernel/cpu/mtrr/Makefile
index ad9e5ed81181..2ad9107ee980 100644
--- a/arch/x86/kernel/cpu/mtrr/Makefile
+++ b/arch/x86/kernel/cpu/mtrr/Makefile
@@ -1,3 +1,3 @@
-obj-y		:= main.o if.o generic.o cleanup.o
+obj-y		:= mtrr.o if.o generic.o cleanup.o
 obj-$(CONFIG_X86_32) += amd.o cyrix.o centaur.o
 
diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
similarity index 96%
rename from arch/x86/kernel/cpu/mtrr/main.c
rename to arch/x86/kernel/cpu/mtrr/mtrr.c
index 7468de429087..0c4f4fba9ec1 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -100,7 +100,7 @@ static int have_wrcomb(void)
 		if (dev->vendor == PCI_VENDOR_ID_SERVERWORKS &&
 		    dev->device == PCI_DEVICE_ID_SERVERWORKS_LE &&
 		    dev->revision <= 5) {
-			pr_info("mtrr: Serverworks LE rev < 6 detected. Write-combining disabled.\n");
+			pr_info("Serverworks LE rev < 6 detected. Write-combining disabled.\n");
 			pci_dev_put(dev);
 			return 0;
 		}
@@ -110,7 +110,7 @@ static int have_wrcomb(void)
 		 */
 		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
 		    dev->device == PCI_DEVICE_ID_INTEL_82451NX) {
-			pr_info("mtrr: Intel 450NX MMC detected. Write-combining disabled.\n");
+			pr_info("Intel 450NX MMC detected. Write-combining disabled.\n");
 			pci_dev_put(dev);
 			return 0;
 		}
@@ -312,24 +312,24 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 		return error;
 
 	if (type >= MTRR_NUM_TYPES) {
-		pr_warn("mtrr: type: %u invalid\n", type);
+		pr_warn("type: %u invalid\n", type);
 		return -EINVAL;
 	}
 
 	/* If the type is WC, check that this processor supports it */
 	if ((type == MTRR_TYPE_WRCOMB) && !have_wrcomb()) {
-		pr_warn("mtrr: your processor doesn't support write-combining\n");
+		pr_warn("your processor doesn't support write-combining\n");
 		return -ENOSYS;
 	}
 
 	if (!size) {
-		pr_warn("mtrr: zero sized request\n");
+		pr_warn("zero sized request\n");
 		return -EINVAL;
 	}
 
 	if ((base | (base + size - 1)) >>
 	    (boot_cpu_data.x86_phys_bits - PAGE_SHIFT)) {
-		pr_warn("mtrr: base or size exceeds the MTRR width\n");
+		pr_warn("base or size exceeds the MTRR width\n");
 		return -EINVAL;
 	}
 
@@ -360,8 +360,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 				} else if (types_compatible(type, ltype))
 					continue;
 			}
-			pr_warn("mtrr: 0x%lx000,0x%lx000 overlaps existing"
-				" 0x%lx000,0x%lx000\n", base, size, lbase,
+			pr_warn("0x%lx000,0x%lx000 overlaps existing 0x%lx000,0x%lx000\n", base, size, lbase,
 				lsize);
 			goto out;
 		}
@@ -369,7 +368,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 		if (ltype != type) {
 			if (types_compatible(type, ltype))
 				continue;
-			pr_warn("mtrr: type mismatch for %lx000,%lx000 old: %s new: %s\n",
+			pr_warn("type mismatch for %lx000,%lx000 old: %s new: %s\n",
 				base, size, mtrr_attrib_to_str(ltype),
 				mtrr_attrib_to_str(type));
 			goto out;
@@ -395,7 +394,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 			}
 		}
 	} else {
-		pr_info("mtrr: no more MTRRs available\n");
+		pr_info("no more MTRRs available\n");
 	}
 	error = i;
  out:
@@ -407,8 +406,8 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 static int mtrr_check(unsigned long base, unsigned long size)
 {
 	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
-		pr_warn("mtrr: size and base must be multiples of 4 kiB\n");
-		pr_debug("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+		pr_warn("size and base must be multiples of 4 kiB\n");
+		pr_debug("size: 0x%lx  base: 0x%lx\n", size, base);
 		dump_stack();
 		return -1;
 	}
@@ -499,22 +498,22 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 			}
 		}
 		if (reg < 0) {
-			pr_debug("mtrr: no MTRR for %lx000,%lx000 found\n",
+			pr_debug("no MTRR for %lx000,%lx000 found\n",
 				 base, size);
 			goto out;
 		}
 	}
 	if (reg >= max) {
-		pr_warn("mtrr: register: %d too big\n", reg);
+		pr_warn("register: %d too big\n", reg);
 		goto out;
 	}
 	mtrr_if->get(reg, &lbase, &lsize, &ltype);
 	if (lsize < 1) {
-		pr_warn("mtrr: MTRR %d not used\n", reg);
+		pr_warn("MTRR %d not used\n", reg);
 		goto out;
 	}
 	if (mtrr_usage_table[reg] < 1) {
-		pr_warn("mtrr: reg: %d has count=0\n", reg);
+		pr_warn("reg: %d has count=0\n", reg);
 		goto out;
 	}
 	if (--mtrr_usage_table[reg] < 1)
@@ -775,7 +774,7 @@ void __init mtrr_bp_init(void)
 	}
 
 	if (!mtrr_enabled()) {
-		pr_info("MTRR: Disabled\n");
+		pr_info("Disabled\n");
 
 		/*
 		 * PAT initialization relies on MTRR's rendezvous handler.
-- 
2.15.0
