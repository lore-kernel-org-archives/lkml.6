Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeDCRJw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:09:52 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39377 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDCRIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:08:51 -0400
X-Google-Smtp-Source: AIpwx48PJG8s6Hi/p8nWTOwvPv5NzSNAlsL94W/QBT4xL3eY4HkJwfYjkV24honLQ73oGe+xFKH20w==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH 1/4] acpi: apei: Return severity of GHES messages after handling
Date: Tue,  3 Apr 2018 12:08:27 -0500
Message-Id: <20180403170830.29282-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180403170830.29282-1-mr.nuke.me@gmail.com>
References: <20180403170830.29282-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The policy currently is to simply panic() on GHES fatal errors.
Oftentimes we may correct fatal errors
i.e. "Fatal" PCIe errors can be corrected via AER
When these errors are corrected, it doesn't make sense to panic().

Update ghes_do_proc() to return the severity of the worst error, while
marking handled errors as corrected.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1efefe919555..25cf77a18e0a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -383,7 +383,7 @@ static void ghes_clear_estatus(struct ghes *ghes)
 	ghes->flags &= ~GHES_TO_CLEAR;
 }
 
-static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
+static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
 {
 #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
 	unsigned long pfn;
@@ -411,7 +411,10 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 
 	if (flags != -1)
 		memory_failure_queue(pfn, flags);
+
+	return true;
 #endif
+	return false;
 }
 
 /*
@@ -428,7 +431,7 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
  * GHES_SEV_PANIC does not make it to this handling since the kernel must
  *     panic.
  */
-static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
+static bool ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
@@ -456,20 +459,33 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 				  (struct aer_capability_regs *)
 				  pcie_err->aer_info);
 	}
+
+	return true;
 #endif
+	return false;
 }
 
-static void ghes_do_proc(struct ghes *ghes,
+/*
+ * Handle GHES messages, and return the highest encountered severity.
+ * Errors which are handled are considered to be CORRECTED. The severity is
+ * taken from each GHES error data entry, not the error status block.
+ * An error is considered corrected if it can be dispatched to an appropriate
+ * handler. However, simply logging an error is not enough to "correct" it.
+ */
+static int ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
-	int sev, sec_sev;
+	int sev, sec_sev, corrected_sev;
 	struct acpi_hest_generic_data *gdata;
 	guid_t *sec_type;
 	guid_t *fru_id = &NULL_UUID_LE;
 	char *fru_text = "";
+	bool handled;
 
+	corrected_sev = GHES_SEV_NO;
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
+		handled = false;
 		sec_type = (guid_t *)gdata->section_type;
 		sec_sev = ghes_severity(gdata->error_severity);
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
@@ -484,10 +500,10 @@ static void ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(ghes, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			ghes_handle_memory_failure(gdata, sev);
+			handled = ghes_handle_memory_failure(gdata, sev);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			ghes_handle_aer(gdata);
+			handled = ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
@@ -500,7 +516,14 @@ static void ghes_do_proc(struct ghes *ghes,
 					       sec_sev, err,
 					       gdata->error_data_length);
 		}
+
+		if (sec_sev >= GHES_SEV_RECOVERABLE && handled)
+			sec_sev = GHES_SEV_CORRECTED;
+
+		corrected_sev = max(corrected_sev, sec_sev);
 	}
+
+	return corrected_sev;
 }
 
 static void __ghes_print_estatus(const char *pfx,
-- 
2.14.3
