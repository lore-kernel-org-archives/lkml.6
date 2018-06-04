Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeFDPFd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:05:33 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45796 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbeFDPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:05:15 -0400
X-Google-Smtp-Source: ADUXVKIxew/4dIoYUhwE4unbVql7Xl3CveeL+0gya0FXtdC9L80M1Kv8eM9P7rgICYfCgdCkhslgFw==
From: mrnuke <mr.nuke.me@gmail.com>
X-Google-Original-From: mrnuke <mrnuke@austins740xd.dell>
To: linux-acpi@vger.kernel.org, tony.luck@intel.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org
Subject: [PATCH v8 3/3] acpi: apei: Do not panic() on PCIe errors reported through GHES
Date: Mon,  4 Jun 2018 10:04:40 -0500
Message-Id: <20180604150443.1265-4-mrnuke@austins740xd.dell>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180604150443.1265-1-mrnuke@austins740xd.dell>
References: <20180604150443.1265-1-mrnuke@austins740xd.dell>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Gagniuc <mr.nuke.me@gmail.com>

As previously noted, the policy to panic on any "Fatal" GHES error is
not suitable for several classes of errors. The most notable is
error containment. The correct policy is to achieve identical behavior
to native error handling -- i.e. when not reported through GHES. This,
in special cases, may not be possible, as we have to exit NMIs, which
requires these special considerations

PCIe AER errors are contained and reported at the root port. On DPC
capable hardware, containment can be done by all downstream ports. DPC
also has the added advantage of preventing future errors. Since these
errors stop at the root port, we can do all the work we need to exit
NMI and reach the error handler.

This patch does away with the mindless crashing of the system, and
correctly invokes the AER handler. When AER is not enabled, or the
firmware doesn't provide sufficient information to identify the source
of the error, the original panic() behavior is maintained.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1b22e18168f5..f7126f6d8d52 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -425,7 +425,7 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
  * GHES_SEV_RECOVERABLE -> AER_NONFATAL
  * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
  *     These both need to be reported and recovered from by the AER driver.
- * GHES_SEV_FATAL does not make it to this handler
+ * GHES_SEV_FATAL -> AER_FATAL
  */
 static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 {
@@ -837,6 +837,45 @@ static inline void ghes_sea_remove(struct ghes *ghes) { }
 static struct llist_head ghes_estatus_llist;
 static struct irq_work ghes_proc_irq_work;
 
+/* PCIe AER errors are safe if AER section contains enough info. */
+static int ghes_pcie_has_safe_handler(struct acpi_hest_generic_data *gdata)
+{
+	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+
+	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+		pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO &&
+		IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER))
+		return true;
+
+	return false;
+}
+
+/*
+ * Do we have an error handler that we can safely reach? We're concerned with
+ * being able to notify an error handler by crossing the NMI/IRQ boundary,
+ * being able to schedule_work, and so forth.
+ */
+static int ghes_has_fatal_handler(struct ghes *ghes)
+{
+	int worst_sev, sec_sev;
+	bool safe = true;
+	struct acpi_hest_generic_data *gdata;
+	const guid_t *section_type;
+	const struct acpi_hest_generic_status *estatus = ghes->estatus;
+
+	apei_estatus_for_each_section(estatus, gdata) {
+		section_type = (guid_t *)gdata->section_type;
+
+		if (guid_equal(section_type, &CPER_SEC_PCIE))
+			safe = ghes_pcie_has_safe_handler(gdata);
+
+		if (!safe)
+			break;
+	}
+
+	return safe;
+}
+
 /*
  * NMI may be triggered on any CPU, so ghes_in_nmi is used for
  * having only one concurrent reader.
@@ -944,7 +983,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 		}
 
 		sev = ghes_cper_severity(ghes->estatus->error_severity);
-		if (sev >= GHES_SEV_FATAL) {
+		if ((sev >= GHES_SEV_FATAL) && !ghes_has_fatal_handler(ghes)) {
 			oops_begin();
 			ghes_print_queued_estatus();
 			__ghes_panic(ghes);
-- 
2.14.3
