Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeDPWAZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 18:00:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44096 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeDPV7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:59:16 -0400
X-Google-Smtp-Source: AIpwx4/WB/V4RqLk/oJm9zctLS5oAg8stUD4Je4eFdAuNyX03zPS5k16tHM6ve8/RlBUviOGq1+ifg==
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [RFC PATCH v2 1/4] EDAC, GHES: Remove unused argument to ghes_edac_report_mem_error
Date: Mon, 16 Apr 2018 16:59:00 -0500
Message-Id: <20180416215903.7318-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180416215903.7318-1-mr.nuke.me@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/apei/ghes.c | 2 +-
 drivers/edac/ghes_edac.c | 3 +--
 include/acpi/ghes.h      | 5 ++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 1efefe919555..f9b53a6f55f3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -481,7 +481,7 @@ static void ghes_do_proc(struct ghes *ghes,
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
-			ghes_edac_report_mem_error(ghes, sev, mem_err);
+			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
 			ghes_handle_memory_failure(gdata, sev);
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 68b6ee18bea6..32bb8c5f47dc 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -172,8 +172,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 	}
 }
 
-void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
-				struct cper_sec_mem_err *mem_err)
+void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	enum hw_event_mc_err_type type;
 	struct edac_raw_error_desc *e;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8feb0c866ee0..e096a4e7f611 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -55,15 +55,14 @@ enum {
 /* From drivers/edac/ghes_edac.c */
 
 #ifdef CONFIG_EDAC_GHES
-void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
-				struct cper_sec_mem_err *mem_err);
+void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
 
 int ghes_edac_register(struct ghes *ghes, struct device *dev);
 
 void ghes_edac_unregister(struct ghes *ghes);
 
 #else
-static inline void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
+static inline void ghes_edac_report_mem_error(int sev,
 				       struct cper_sec_mem_err *mem_err)
 {
 }
-- 
2.14.3
