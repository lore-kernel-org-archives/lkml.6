Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeDJBQX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:16:23 -0400
Received: from mx140-tc.baidu.com ([61.135.168.140]:50444 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752234AbeDJBQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:16:21 -0400
From: Li RongQing <lirongqing@baidu.com>
To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, jgross@suse.com, douly.fnst@cn.fujitsu.com,
        x86@kernel.org, peterz@infradead.org
Subject: [PATCH][V2] x86/acpi: Prevent all the X2APIC Id from being parsed in non-x2apic mode
Date: Tue, 10 Apr 2018 09:16:06 +0800
Message-Id: <1523322966-10296-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.10.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the values of x2APIC ID is greater than 0xff in ACPI MADT, if acpi
is apic_flat, default_apic_id_valid() is called to check id which
is converted from u32 to int, will return true if id is larger than
0x7fffffff, this is wrong

and if local_apic_id is invalid, we should prevent it from being
accounted

This fixes a bug that some Purley platform displays many possible cpu

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h          |  4 ++--
 arch/x86/kernel/acpi/boot.c          | 13 ++++++++-----
 arch/x86/kernel/apic/apic_common.c   |  2 +-
 arch/x86/kernel/apic/apic_numachip.c |  2 +-
 arch/x86/kernel/apic/x2apic.h        |  2 +-
 arch/x86/kernel/apic/x2apic_phys.c   |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
 arch/x86/xen/apic.c                  |  2 +-
 8 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 40a3d3642f3a..08acd954f00e 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -313,7 +313,7 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	int	(*apic_id_valid)(int apicid);
+	int	(*apic_id_valid)(u32 apicid);
 	int	(*apic_id_registered)(void);
 
 	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
@@ -486,7 +486,7 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
 
-extern int default_apic_id_valid(int apicid);
+extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7a37d9357bc4..4ba949de1ca9 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -200,7 +200,7 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 {
 	struct acpi_madt_local_x2apic *processor = NULL;
 #ifdef CONFIG_X86_X2APIC
-	int apic_id;
+	u32 apic_id;
 	u8 enabled;
 #endif
 
@@ -222,10 +222,13 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	if (!apic->apic_id_valid(apic_id) && enabled)
-		printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
-	else
-		acpi_register_lapic(apic_id, processor->uid, enabled);
+	if (!apic->apic_id_valid(apic_id)) {
+		if (enabled)
+			printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
+		return 0;
+	}
+
+	acpi_register_lapic(apic_id, processor->uid, enabled);
 #else
 	printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
 #endif
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index a360801779ae..02b4839478b1 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -40,7 +40,7 @@ int default_check_phys_apicid_present(int phys_apicid)
 	return physid_isset(phys_apicid, phys_cpu_present_map);
 }
 
-int default_apic_id_valid(int apicid)
+int default_apic_id_valid(u32 apicid)
 {
 	return (apicid < 255);
 }
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 134e04506ab4..78778b54f904 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,7 +56,7 @@ static u32 numachip2_set_apic_id(unsigned int id)
 	return id << 24;
 }
 
-static int numachip_apic_id_valid(int apicid)
+static int numachip_apic_id_valid(u32 apicid)
 {
 	/* Trust what bootloader passes in MADT */
 	return 1;
diff --git a/arch/x86/kernel/apic/x2apic.h b/arch/x86/kernel/apic/x2apic.h
index b107de381cb5..a49b3604027f 100644
--- a/arch/x86/kernel/apic/x2apic.h
+++ b/arch/x86/kernel/apic/x2apic.h
@@ -1,6 +1,6 @@
 /* Common bits for X2APIC cluster/physical modes. */
 
-int x2apic_apic_id_valid(int apicid);
+int x2apic_apic_id_valid(u32 apicid);
 int x2apic_apic_id_registered(void);
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 unsigned int x2apic_get_apic_id(unsigned long id);
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index e2829bf40e4a..b5cf9e7b3830 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -101,7 +101,7 @@ static int x2apic_phys_probe(void)
 }
 
 /* Common x2apic functions, also used by x2apic_cluster */
-int x2apic_apic_id_valid(int apicid)
+int x2apic_apic_id_valid(u32 apicid)
 {
 	return 1;
 }
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f11910b44638..efaf2d4f9c3c 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -557,7 +557,7 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static int uv_apic_id_valid(int apicid)
+static int uv_apic_id_valid(u32 apicid)
 {
 	return 1;
 }
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 2163888497d3..5e53bfbe5823 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -112,7 +112,7 @@ static int xen_madt_oem_check(char *oem_id, char *oem_table_id)
 	return xen_pv_domain();
 }
 
-static int xen_id_always_valid(int apicid)
+static int xen_id_always_valid(u32 apicid)
 {
 	return 1;
 }
-- 
2.11.0
