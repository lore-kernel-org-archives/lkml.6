Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeEUNuZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:50:25 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39363 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbeEUNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:50:21 -0400
X-Google-Smtp-Source: AB8JxZrNx9FOmxWzds3pXx7D2jQbJdjDczkNoCsvpuir2xJoFOZGy5ll1W7zIAYGOAOD/YLVO/l7dg==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bp@alien8.de
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to ghes_cper_severity()
Date: Mon, 21 May 2018 08:49:58 -0500
Message-Id: <20180521135003.32459-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180521135003.32459-1-mr.nuke.me@gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ghes_severity() is a misnomer in this case, as it implies the severity
of the entire GHES structure. Instead, it maps one CPER value to a
GHES_SEV* value. ghes_cper_severity() is clearer.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1efefe919555..7c1a16b106ba 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -271,7 +271,7 @@ static void ghes_fini(struct ghes *ghes)
 		unmap_gen_v2(ghes);
 }
 
-static inline int ghes_severity(int severity)
+static inline int ghes_cper_severity(int severity)
 {
 	switch (severity) {
 	case CPER_SEV_INFORMATIONAL:
@@ -388,7 +388,7 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
 	unsigned long pfn;
 	int flags = -1;
-	int sec_sev = ghes_severity(gdata->error_severity);
+	int sec_sev = ghes_cper_severity(gdata->error_severity);
 	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
@@ -468,10 +468,10 @@ static void ghes_do_proc(struct ghes *ghes,
 	guid_t *fru_id = &NULL_UUID_LE;
 	char *fru_text = "";
 
-	sev = ghes_severity(estatus->error_severity);
+	sev = ghes_cper_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
 		sec_type = (guid_t *)gdata->section_type;
-		sec_sev = ghes_severity(gdata->error_severity);
+		sec_sev = ghes_cper_severity(gdata->error_severity);
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
 			fru_id = (guid_t *)gdata->fru_id;
 
@@ -512,7 +512,7 @@ static void __ghes_print_estatus(const char *pfx,
 	char pfx_seq[64];
 
 	if (pfx == NULL) {
-		if (ghes_severity(estatus->error_severity) <=
+		if (ghes_cper_severity(estatus->error_severity) <=
 		    GHES_SEV_CORRECTED)
 			pfx = KERN_WARNING;
 		else
@@ -534,7 +534,7 @@ static int ghes_print_estatus(const char *pfx,
 	static DEFINE_RATELIMIT_STATE(ratelimit_uncorrected, 5*HZ, 2);
 	struct ratelimit_state *ratelimit;
 
-	if (ghes_severity(estatus->error_severity) <= GHES_SEV_CORRECTED)
+	if (ghes_cper_severity(estatus->error_severity) <= GHES_SEV_CORRECTED)
 		ratelimit = &ratelimit_corrected;
 	else
 		ratelimit = &ratelimit_uncorrected;
@@ -705,9 +705,8 @@ static int ghes_proc(struct ghes *ghes)
 	if (rc)
 		goto out;
 
-	if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC) {
+	if (ghes_cper_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC)
 		__ghes_panic(ghes);
-	}
 
 	if (!ghes_estatus_cached(ghes->estatus)) {
 		if (ghes_print_estatus(NULL, ghes->generic, ghes->estatus))
@@ -945,7 +944,7 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 			ret = NMI_HANDLED;
 		}
 
-		sev = ghes_severity(ghes->estatus->error_severity);
+		sev = ghes_cper_severity(ghes->estatus->error_severity);
 		if (sev >= GHES_SEV_PANIC) {
 			oops_begin();
 			ghes_print_queued_estatus();
-- 
2.14.3
