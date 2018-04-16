Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeDPV7X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:59:23 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35954 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDPV7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:59:18 -0400
X-Google-Smtp-Source: AIpwx4/lijyy3eFAWvheFFiTS7GWE7uqQBwsIMI5i0QG2apmFwgAfUG50wC34eUkWxDUpcTCFfnIUQ==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH v2 2/4] acpi: apei: Split GHES handlers outside of ghes_do_proc
Date: Mon, 16 Apr 2018 16:59:01 -0500
Message-Id: <20180416215903.7318-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180416215903.7318-1-mr.nuke.me@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a mapping from CPER UUID to get the correct handler for a given
GHES error. This is in preparation of splitting some handlers into
irq safe and regular parts.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 78 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f9b53a6f55f3..2119c51b4a9e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -414,6 +414,25 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 #endif
 }
 
+static int ghes_handle_arm(struct acpi_hest_generic_data *gdata, int sev)
+{
+	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+
+	log_arm_hw_error(err);
+	return ghes_severity(gdata->error_severity);
+}
+
+static int ghes_handle_mem(struct acpi_hest_generic_data *gdata, int sev)
+{
+	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+
+	ghes_edac_report_mem_error(sev, mem_err);
+	arch_apei_report_mem_error(sev, mem_err);
+	ghes_handle_memory_failure(gdata, sev);
+
+	return ghes_severity(gdata->error_severity);
+}
+
 /*
  * PCIe AER errors need to be sent to the AER driver for reporting and
  * recovery. The GHES severities map to the following AER severities and
@@ -428,7 +447,7 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
  * GHES_SEV_PANIC does not make it to this handling since the kernel must
  *     panic.
  */
-static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
+static int ghes_handle_aer(struct acpi_hest_generic_data *gdata, int sev)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
@@ -456,14 +475,54 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 				  (struct aer_capability_regs *)
 				  pcie_err->aer_info);
 	}
+
+	return GHES_SEV_CORRECTED;
 #endif
+	return ghes_severity(gdata->error_severity);
 }
 
+/**
+ * ghes_handler - handler for ACPI APEI errors
+ * @error_uuid: UUID describing the error entry (See ACPI/EFI CPER for details)
+ * @handle: Handler for the GHES entry of type 'error_uuid'. The handler
+ *	returns the severity of the error after handling. A handler is allowed
+ *	to demote errors to correctable or corrected, as appropriate.
+ */
+static const struct ghes_handler {
+	const guid_t *error_uuid;
+	int (*handle_irqsafe)(struct acpi_hest_generic_data *gdata, int sev);
+	int (*handle)(struct acpi_hest_generic_data *gdata, int sev);
+} ghes_handlers[] = {
+	{
+		.error_uuid = &CPER_SEC_PLATFORM_MEM,
+		.handle = ghes_handle_mem,
+	}, {
+		.error_uuid = &CPER_SEC_PCIE,
+		.handle = ghes_handle_aer,
+	}, {
+		.error_uuid = &CPER_SEC_PROC_ARM,
+		.handle = ghes_handle_arm,
+	}
+};
+
+static const struct ghes_handler *get_handler(const guid_t *type)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(ghes_handlers); i++) {
+		if (guid_equal(type, ghes_handlers[i].error_uuid))
+			return &ghes_handlers[i];
+	}
+	return NULL;
+}
+
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
 	int sev, sec_sev;
 	struct acpi_hest_generic_data *gdata;
+	const struct ghes_handler *handler;
 	guid_t *sec_type;
 	guid_t *fru_id = &NULL_UUID_LE;
 	char *fru_text = "";
@@ -478,21 +537,10 @@ static void ghes_do_proc(struct ghes *ghes,
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
 			fru_text = gdata->fru_text;
 
-		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-			ghes_edac_report_mem_error(sev, mem_err);
-
-			arch_apei_report_mem_error(sev, mem_err);
-			ghes_handle_memory_failure(gdata, sev);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			ghes_handle_aer(gdata);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 
-			log_arm_hw_error(err);
+		handler = get_handler(sec_type);
+		if (handler) {
+			sec_sev = handler->handle(gdata, sev);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.14.3
