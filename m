Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755263AbeD3Ve2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 17:34:28 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38894 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755147AbeD3VeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 17:34:23 -0400
X-Google-Smtp-Source: AB8JxZro5sWjy7JvjlBi+2a8+T23BR3C67wWqMHXIX3k6H+tvCIXSuav8i+2OngS6YTDx2S6ebJ2Ig==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bp@alien8.de
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org
Subject: [RFC PATCH v4 3/3] acpi: apei: Do not panic() on PCIe errors reported through GHES
Date: Mon, 30 Apr 2018 16:33:52 -0500
Message-Id: <20180430213358.8319-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180430213358.8319-1-mr.nuke.me@gmail.com>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The policy was to panic() when GHES said that an error is "Fatal".
This logic is wrong for several reasons, as it doesn't take into
account what caused the error.

PCIe fatal errors indicate that the link to a device is either
unstable or unusable. They don't indicate that the machine is on fire,
and they are not severe enough that we need to panic(). Instead of
relying on crackmonkey firmware, evaluate the error severity based on
what caused the error (GHES subsections).

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index c9f1971333c1..49318fba409c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -425,8 +425,7 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
  * GHES_SEV_RECOVERABLE -> AER_NONFATAL
  * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
  *     These both need to be reported and recovered from by the AER driver.
- * GHES_SEV_PANIC does not make it to this handling since the kernel must
- *     panic.
+ * GHES_SEV_PANIC -> AER_FATAL
  */
 static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 {
@@ -459,6 +458,46 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+/* PCIe errors should not cause a panic. */
+static int ghes_sec_pcie_severity(struct acpi_hest_generic_data *gdata)
+{
+	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+
+	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO &&
+	    IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER))
+		return CPER_SEV_RECOVERABLE;
+
+	return ghes_cper_severity(gdata->error_severity);
+}
+/*
+ * The severity field in the status block is oftentimes more severe than it
+ * needs to be. This makes it an unreliable metric for the severity. A more
+ * reliable way is to look at each subsection and correlate it with how well
+ * the error can be handled.
+ *   - SEC_PCIE: All PCIe errors can be handled by AER.
+ */
+static int ghes_severity(struct ghes *ghes)
+{
+	int worst_sev, sec_sev;
+	struct acpi_hest_generic_data *gdata;
+	const guid_t *section_type;
+	const struct acpi_hest_generic_status *estatus = ghes->estatus;
+
+	worst_sev = GHES_SEV_NO;
+	apei_estatus_for_each_section(estatus, gdata) {
+		section_type = (guid_t *)gdata->section_type;
+		sec_sev = ghes_cper_severity(gdata->error_severity);
+
+		if (guid_equal(section_type, &CPER_SEC_PCIE))
+			sec_sev = ghes_sec_pcie_severity(gdata);
+
+		worst_sev = max(worst_sev, sec_sev);
+	}
+
+	return worst_sev;
+}
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -944,7 +983,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 			ret = NMI_HANDLED;
 		}
 
-		sev = ghes_cper_severity(ghes->estatus->error_severity);
+		sev = ghes_severity(ghes);
 		if (sev >= GHES_SEV_PANIC) {
 			oops_begin();
 			ghes_print_queued_estatus();
-- 
2.14.3
