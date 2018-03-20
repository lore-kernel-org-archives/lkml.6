Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeCTLG6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:06:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4898 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752850AbeCTLFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:22 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38002755"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <corbet@lwn.net>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <hpa@zytor.com>,
        <peterz@infradead.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 5/5] acpi/processor: Make the acpi_duplicate_processor_id() static
Date: Tue, 20 Mar 2018 19:04:32 +0800
Message-ID: <20180320110432.28127-6-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: A18A448AE76A.A1A72
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_duplicate_processor_id() is only called in acpi_processor_get_info(),
So move it in front of acpi_processor_get_info() and make it static.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 drivers/acpi/acpi_processor.c | 62 +++++++++++++++++++++----------------------
 include/linux/acpi.h          |  3 ---
 2 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index db5bdb59639c..03ec7690710c 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -229,6 +229,37 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 }
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
+/* The number of the unique processor IDs */
+static int nr_unique_ids __initdata;
+
+/* The number of the duplicate processor IDs */
+static int nr_duplicate_ids;
+
+/* Used to store the unique processor IDs */
+static int unique_processor_ids[] __initdata = {
+	[0 ... NR_CPUS - 1] = -1,
+};
+
+/* Used to store the duplicate processor IDs */
+static int duplicate_processor_ids[] = {
+	[0 ... NR_CPUS - 1] = -1,
+};
+
+static bool acpi_duplicate_processor_id(int proc_id)
+{
+	int i;
+
+	/*
+	 * Compare the proc_id with duplicate IDs, if the proc_id is already
+	 * in the duplicate IDs, return true, otherwise, return false.
+	 */
+	for (i = 0; i < nr_duplicate_ids; i++) {
+		if (duplicate_processor_ids[i] == proc_id)
+			return true;
+	}
+	return false;
+}
+
 static int acpi_processor_get_info(struct acpi_device *device)
 {
 	union acpi_object object = { 0 };
@@ -579,22 +610,6 @@ static struct acpi_scan_handler processor_container_handler = {
 	.attach = acpi_processor_container_attach,
 };
 
-/* The number of the unique processor IDs */
-static int nr_unique_ids __initdata;
-
-/* The number of the duplicate processor IDs */
-static int nr_duplicate_ids;
-
-/* Used to store the unique processor IDs */
-static int unique_processor_ids[] __initdata = {
-	[0 ... NR_CPUS - 1] = -1,
-};
-
-/* Used to store the duplicate processor IDs */
-static int duplicate_processor_ids[] = {
-	[0 ... NR_CPUS - 1] = -1,
-};
-
 static void __init processor_validated_ids_update(int proc_id)
 {
 	int i;
@@ -682,21 +697,6 @@ static void __init acpi_processor_check_duplicates(void)
 						NULL, NULL);
 }
 
-bool acpi_duplicate_processor_id(int proc_id)
-{
-	int i;
-
-	/*
-	 * compare the proc_id with duplicate IDs, if the proc_id is already
-	 * in the duplicate IDs, return true, otherwise, return false.
-	 */
-	for (i = 0; i < nr_duplicate_ids; i++) {
-		if (duplicate_processor_ids[i] == proc_id)
-			return true;
-	}
-	return false;
-}
-
 void __init acpi_processor_init(void)
 {
 	acpi_processor_check_duplicates();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 968173ec2726..dd4591dc1eb3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -285,9 +285,6 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
 	return phys_id == PHYS_CPUID_INVALID;
 }
 
-/* Validate the processor object's proc_id */
-bool acpi_duplicate_processor_id(int proc_id);
-
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
-- 
2.14.3
