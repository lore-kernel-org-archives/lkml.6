Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967123AbeEYPyM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:54:12 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42773 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965666AbeEYPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:54:08 -0400
X-Google-Smtp-Source: ADUXVKLvHtlcGknoy40lJpP5XUdcG3dqDK5bk37C33ZenvmK/M+HxcrAyrkVb8E+opua2E0p1ZAp5w==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org
Subject: [PATCH v7 1/3] acpi: apei: Rename GHES_SEV_PANIC to GHES_SEV_FATAL
Date: Fri, 25 May 2018 10:53:46 -0500
Message-Id: <20180525155352.22350-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180525155352.22350-1-mr.nuke.me@gmail.com>
References: <20180525155352.22350-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'GHES_SEV_PANIC' implies that the kernel must panic. That was true
many years ago when fatal errors could not be handled and recovered.
However, this is no longer the case with PCIe AER and DPC errors. The
latter class of errors are contained at the hardware level.
'GHES_SEV_PANIC' is confusing because it implies a policy to crash the
system on fatal errors. Drop this questionable policy, and rename the
enum to 'GHES_SEV_FATAL' to better convey the meaning.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 arch/x86/kernel/cpu/mcheck/mce-apei.c |  2 +-
 drivers/acpi/apei/ghes.c              | 11 +++++------
 drivers/edac/ghes_edac.c              |  2 +-
 include/acpi/ghes.h                   |  2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
index 2eee85379689..cbec89f5cdf0 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
@@ -53,7 +53,7 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	if (severity >= GHES_SEV_RECOVERABLE)
 		m.status |= MCI_STATUS_UC;
 
-	if (severity >= GHES_SEV_PANIC) {
+	if (severity >= GHES_SEV_FATAL) {
 		m.status |= MCI_STATUS_PCC;
 		m.tsc = rdtsc();
 	}
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1efefe919555..26a41bbe222b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -281,10 +281,10 @@ static inline int ghes_severity(int severity)
 	case CPER_SEV_RECOVERABLE:
 		return GHES_SEV_RECOVERABLE;
 	case CPER_SEV_FATAL:
-		return GHES_SEV_PANIC;
+		return GHES_SEV_FATAL;
 	default:
 		/* Unknown, go panic */
-		return GHES_SEV_PANIC;
+		return GHES_SEV_FATAL;
 	}
 }
 
@@ -425,8 +425,7 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
  * GHES_SEV_RECOVERABLE -> AER_NONFATAL
  * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
  *     These both need to be reported and recovered from by the AER driver.
- * GHES_SEV_PANIC does not make it to this handling since the kernel must
- *     panic.
+ * GHES_SEV_FATAL does not make it to this handler
  */
 static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 {
@@ -705,7 +704,7 @@ static int ghes_proc(struct ghes *ghes)
 	if (rc)
 		goto out;
 
-	if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC) {
+	if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_FATAL) {
 		__ghes_panic(ghes);
 	}
 
@@ -946,7 +945,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 		}
 
 		sev = ghes_severity(ghes->estatus->error_severity);
-		if (sev >= GHES_SEV_PANIC) {
+		if (sev >= GHES_SEV_FATAL) {
 			oops_begin();
 			ghes_print_queued_estatus();
 			__ghes_panic(ghes);
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 68b6ee18bea6..8455758327d4 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -220,7 +220,7 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 	case GHES_SEV_RECOVERABLE:
 		type = HW_EVENT_ERR_UNCORRECTED;
 		break;
-	case GHES_SEV_PANIC:
+	case GHES_SEV_FATAL:
 		type = HW_EVENT_ERR_FATAL;
 		break;
 	default:
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8feb0c866ee0..322f7ede24bd 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -49,7 +49,7 @@ enum {
 	GHES_SEV_NO = 0x0,
 	GHES_SEV_CORRECTED = 0x1,
 	GHES_SEV_RECOVERABLE = 0x2,
-	GHES_SEV_PANIC = 0x3,
+	GHES_SEV_FATAL = 0x3,
 };
 
 /* From drivers/edac/ghes_edac.c */
-- 
2.14.3
