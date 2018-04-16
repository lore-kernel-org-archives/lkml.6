Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeDPWAF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 18:00:05 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45602 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeDPV7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:59:19 -0400
X-Google-Smtp-Source: AIpwx4/Vpm1ZQhPb0I6f9iz5xX2yZfp6dg8mu90L+ic9wYv5f+KMdboG4xUddxuC/fcxAA0uD/PHPw==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable errors are marked as fatal.
Date: Mon, 16 Apr 2018 16:59:02 -0500
Message-Id: <20180416215903.7318-4-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180416215903.7318-1-mr.nuke.me@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware is evil:
 - ACPI was created to "try and make the 'ACPI' extensions somehow
 Windows specific" in order to "work well with NT and not the others
 even if they are open"
 - EFI was created to hide "secret" registers from the OS.
 - UEFI was created to allow compromising an otherwise secure OS.

Never has firmware been created to solve a problem or simplify an
otherwise cumbersome process. It is of no surprise then, that
firmware nowadays intentionally crashes an OS.

One simple way to do that is to mark GHES errors as fatal. Firmware
knows and even expects that an OS will crash in this case. And most
OSes do.

PCIe errors are notorious for having different definitions of "fatal".
In ACPI, and other firmware sandards, 'fatal' means the machine is
about to explode and needs to be reset. In PCIe, on the other hand,
fatal means that the link to a device has died. In the hotplug world
of PCIe, this is akin to a USB disconnect. From that view, the "fatal"
loss of a link is a normal event. To allow a machine to crash in this
case is downright idiotic.

To solve this, implement an IRQ safe handler for AER. This makes sure
we have enough information to invoke the full AER handler later down
the road, and tells ghes_notify_nmi that "It's all cool".
ghes_notify_nmi() then gets calmed down a little, and doesn't panic().

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2119c51b4a9e..e0528da4e8f8 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -481,12 +481,26 @@ static int ghes_handle_aer(struct acpi_hest_generic_data *gdata, int sev)
 	return ghes_severity(gdata->error_severity);
 }
 
+static int ghes_handle_aer_irqsafe(struct acpi_hest_generic_data *gdata,
+				   int sev)
+{
+	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+
+	/* The system can always recover from AER errors. */
+	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+		pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO)
+		return CPER_SEV_RECOVERABLE;
+
+	return ghes_severity(gdata->error_severity);
+}
+
 /**
  * ghes_handler - handler for ACPI APEI errors
  * @error_uuid: UUID describing the error entry (See ACPI/EFI CPER for details)
  * @handle: Handler for the GHES entry of type 'error_uuid'. The handler
  *	returns the severity of the error after handling. A handler is allowed
  *	to demote errors to correctable or corrected, as appropriate.
+ * @handle_irqsafe: (optional) Non-blocking handler for GHES entry.
  */
 static const struct ghes_handler {
 	const guid_t *error_uuid;
@@ -498,6 +512,7 @@ static const struct ghes_handler {
 		.handle = ghes_handle_mem,
 	}, {
 		.error_uuid = &CPER_SEC_PCIE,
+		.handle_irqsafe = ghes_handle_aer_irqsafe,
 		.handle = ghes_handle_aer,
 	}, {
 		.error_uuid = &CPER_SEC_PROC_ARM,
@@ -551,6 +566,30 @@ static void ghes_do_proc(struct ghes *ghes,
 	}
 }
 
+/* How severe is the error if handling is deferred outside IRQ/NMI context? */
+static int ghes_deferrable_severity(struct ghes *ghes)
+{
+	int deferrable_sev, sev, sec_sev;
+	struct acpi_hest_generic_data *gdata;
+	const struct ghes_handler *handler;
+	const guid_t *section_type;
+	const struct acpi_hest_generic_status *estatus = ghes->estatus;
+
+	deferrable_sev = GHES_SEV_NO;
+	sev = ghes_severity(estatus->error_severity);
+	apei_estatus_for_each_section(estatus, gdata) {
+		section_type = (guid_t *)gdata->section_type;
+		handler = get_handler(section_type);
+		if (handler && handler->handle_irqsafe)
+			sec_sev = handler->handle_irqsafe(gdata, sev);
+		else
+			sec_sev = ghes_severity(gdata->error_severity);
+		deferrable_sev = max(deferrable_sev, sec_sev);
+	}
+
+	return deferrable_sev;
+}
+
 static void __ghes_print_estatus(const char *pfx,
 				 const struct acpi_hest_generic *generic,
 				 const struct acpi_hest_generic_status *estatus)
@@ -980,7 +1019,7 @@ static void __process_error(struct ghes *ghes)
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	struct ghes *ghes;
-	int sev, ret = NMI_DONE;
+	int sev, dsev, ret = NMI_DONE;
 
 	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
 		return ret;
@@ -993,8 +1032,9 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 			ret = NMI_HANDLED;
 		}
 
+		dsev = ghes_deferrable_severity(ghes);
 		sev = ghes_severity(ghes->estatus->error_severity);
-		if (sev >= GHES_SEV_PANIC) {
+		if ((sev >= GHES_SEV_PANIC) && (dsev >= GHES_SEV_PANIC)) {
 			oops_begin();
 			ghes_print_queued_estatus();
 			__ghes_panic(ghes);
-- 
2.14.3
