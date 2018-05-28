Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbeE1JJR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:09:17 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60209 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754082AbeE1JJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:09:13 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40438398"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [RESEND RFC PATCH] acpi/processor: Remove the check of duplicate processors
Date: Mon, 28 May 2018 17:08:41 +0800
Message-ID: <20180528090841.18185-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 855BE48AE929.A3ED1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found there are some processors which have the same processor ID
but in different PXM in the ACPI namespace. such as this:

proc_id   |    pxm
--------------------
0       <->     0
1       <->     0
2       <->     1
3       <->     1
......
89      <->     0
89      <->     1
89      <->     2
89      <->     3
......

So we create a mechanism to validate them. make the processor(ID=89)
as invalid. And once a processor be hotplugged physically, we check its
processor id.

    Commit 8e089eaa1999 ("acpi: Provide mechanism to validate processors in the ACPI tables")
    Commit a77d6cd96849 ("acpi/processor: Check for duplicate processor ids at hotplug time")

Recently, I found the check mechanism has a bug, it didn't use the
acpi_processor_ids_walk() right and always gave us a wrong result.
First, I fixed it by modifying the value with AE_OK which is the
standard acpi_status value.

    https://lkml.org/lkml/2018/3/20/273

But, now, I even think this check is useless. my reasons are following:

    1). Based on the practical tests, It works well, and no bug be reported
    2). Based on the code, the duplicate cases can be dealed with by

       if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id))

That seems more reasonable, let's see the following case:

                          Before the patch,             After the patch

the first processor(ID=89)
hot-add                        failed                        success

the others processor(ID=89)
hot-add                        failed                        failed

So, Remove the check code.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 drivers/acpi/acpi_processor.c | 126 ------------------------------------------
 include/linux/acpi.h          |   3 -
 2 files changed, 129 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 449d86d39965..8358708e0bbb 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -281,13 +281,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		pr->acpi_id = value;
 	}
 
-	if (acpi_duplicate_processor_id(pr->acpi_id)) {
-		dev_err(&device->dev,
-			"Failed to get unique processor _UID (0x%x)\n",
-			pr->acpi_id);
-		return -ENODEV;
-	}
-
 	pr->phys_id = acpi_get_phys_id(pr->handle, device_declaration,
 					pr->acpi_id);
 	if (invalid_phys_cpuid(pr->phys_id))
@@ -579,127 +572,8 @@ static struct acpi_scan_handler processor_container_handler = {
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
-static void __init processor_validated_ids_update(int proc_id)
-{
-	int i;
-
-	if (nr_unique_ids == NR_CPUS||nr_duplicate_ids == NR_CPUS)
-		return;
-
-	/*
-	 * Firstly, compare the proc_id with duplicate IDs, if the proc_id is
-	 * already in the IDs, do nothing.
-	 */
-	for (i = 0; i < nr_duplicate_ids; i++) {
-		if (duplicate_processor_ids[i] == proc_id)
-			return;
-	}
-
-	/*
-	 * Secondly, compare the proc_id with unique IDs, if the proc_id is in
-	 * the IDs, put it in the duplicate IDs.
-	 */
-	for (i = 0; i < nr_unique_ids; i++) {
-		if (unique_processor_ids[i] == proc_id) {
-			duplicate_processor_ids[nr_duplicate_ids] = proc_id;
-			nr_duplicate_ids++;
-			return;
-		}
-	}
-
-	/*
-	 * Lastly, the proc_id is a unique ID, put it in the unique IDs.
-	 */
-	unique_processor_ids[nr_unique_ids] = proc_id;
-	nr_unique_ids++;
-}
-
-static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
-						  u32 lvl,
-						  void *context,
-						  void **rv)
-{
-	acpi_status status;
-	acpi_object_type acpi_type;
-	unsigned long long uid;
-	union acpi_object object = { 0 };
-	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
-
-	status = acpi_get_type(handle, &acpi_type);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	switch (acpi_type) {
-	case ACPI_TYPE_PROCESSOR:
-		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
-		if (ACPI_FAILURE(status))
-			goto err;
-		uid = object.processor.proc_id;
-		break;
-
-	case ACPI_TYPE_DEVICE:
-		status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
-		if (ACPI_FAILURE(status))
-			goto err;
-		break;
-	default:
-		goto err;
-	}
-
-	processor_validated_ids_update(uid);
-	return true;
-
-err:
-	acpi_handle_info(handle, "Invalid processor object\n");
-	return false;
-
-}
-
-static void __init acpi_processor_check_duplicates(void)
-{
-	/* check the correctness for all processors in ACPI namespace */
-	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
-						ACPI_UINT32_MAX,
-						acpi_processor_ids_walk,
-						NULL, NULL, NULL);
-	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, acpi_processor_ids_walk,
-						NULL, NULL);
-}
-
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
-	acpi_processor_check_duplicates();
 	acpi_scan_add_handler_with_hotplug(&processor_handler, "processor");
 	acpi_scan_add_handler(&processor_container_handler);
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 15bfb15c2fa5..068dcfe6768b 100644
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
