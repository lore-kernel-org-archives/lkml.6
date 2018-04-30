Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbeD3VeN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 17:34:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46020 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeD3VeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 17:34:10 -0400
X-Google-Smtp-Source: AB8JxZqyozgbf6gTaAr14JnhwMibrcyIV4mKUijaXnZ+AWY+D8TCor2tC5jJYHcWq0bQnLuAYQh0cQ==
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
Subject: [RFC PATCH v4 1/3] EDAC, GHES: Remove unused argument to ghes_edac_report_mem_error
Date: Mon, 30 Apr 2018 16:33:50 -0500
Message-Id: <20180430213358.8319-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180430212836.7807-1-mr.nuke.me@gmail.com>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of the 'ghes' argument was removed in a previous commit, but
function signature was not updated to reflect this.

Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller")
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
