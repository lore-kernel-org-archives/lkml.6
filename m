Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeDJOlZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:41:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754135AbeDJOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:41:22 -0400
Date: Tue, 10 Apr 2018 07:40:40 -0700
From: tip-bot for Li RongQing <tipbot@zytor.com>
Message-ID: <tip-57e95bee9f89560c5952409be8b41a4a2b7e384c@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, lirongqing@baidu.com,
        linux-kernel@vger.kernel.org, douly.fnst@cn.fujitsu.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, lirongqing@baidu.com,
        linux-kernel@vger.kernel.org, douly.fnst@cn.fujitsu.com
In-Reply-To: <1523322966-10296-1-git-send-email-lirongqing@baidu.com>
References: <1523322966-10296-1-git-send-email-lirongqing@baidu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic: Fix signedness bug in APIC ID validity
 checks
Git-Commit-ID: 57e95bee9f89560c5952409be8b41a4a2b7e384c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  57e95bee9f89560c5952409be8b41a4a2b7e384c
Gitweb:     https://git.kernel.org/tip/57e95bee9f89560c5952409be8b41a4a2b7e384c
Author:     Li RongQing <lirongqing@baidu.com>
AuthorDate: Tue, 10 Apr 2018 09:16:06 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 10 Apr 2018 16:33:21 +0200

x86/apic: Fix signedness bug in APIC ID validity checks

The APIC ID as parsed from ACPI MADT is validity checked with the
apic->apic_id_valid() callback, which depends on the selected APIC type.

For non X2APIC types APIC IDs >= 0xFF are invalid, but values > 0x7FFFFFFF
are detected as valid. This happens because the 'apicid' argument of the
apic_id_valid() callback is type 'int'. So the resulting comparison

   apicid < 0xFF

evaluates to true for all unsigned int values > 0x7FFFFFFF which are handed
to default_apic_id_valid(). As a consequence, invalid APIC IDs in !X2APIC
mode are considered valid and accounted as possible CPUs.

Change the apicid argument type of the apic_id_valid() callback to u32 so
the evaluation is unsigned and returns the correct result.

[ tglx: Massaged changelog ]

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: jgross@suse.com
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1523322966-10296-1-git-send-email-lirongqing@baidu.com

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
index 98722773391d..f01eef8b392e 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -319,7 +319,7 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	int	(*apic_id_valid)(int apicid);
+	int	(*apic_id_valid)(u32 apicid);
 	int	(*apic_id_registered)(void);
 
 	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
@@ -492,7 +492,7 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
 
-extern int default_apic_id_valid(int apicid);
+extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2aa92094b59d..cc7ddc932cf2 100644
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
index f8d9d69994e6..e972405eb2b5 100644
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
index de58533d3664..2fa79e2e73ea 100644
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
