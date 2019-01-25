Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B394C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526DF20881
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfAYOak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:30:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:21748 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfAYOak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:30:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 06:30:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="269876213"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2019 06:30:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D25DC33A; Fri, 25 Jan 2019 16:30:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@suse.de>, Thomas Tai <thomas.tai@oracle.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH v2] ras: Use consistent types for UUIDs
Date:   Fri, 25 Jan 2019 16:30:35 +0200
Message-Id: <20190125143035.81589-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit

  297b64c74385 ("ras: acpi / apei: generate trace event for unrecognized CPER section")

brought inconsistency in UUID types which are used across the RAS subsystem.

Fix this by moving to use guid_t everywhere.

Cc: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2:
- resend on top of tip:ras/core

 drivers/ras/ras.c       | 2 +-
 include/ras/ras_event.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 3f38907320dc..95540ea8dd9d 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -14,7 +14,7 @@
 #define TRACE_INCLUDE_PATH ../../include/ras
 #include <ras/ras_event.h>
 
-void log_non_standard_event(const uuid_le *sec_type, const uuid_le *fru_id,
+void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 			    const char *fru_text, const u8 sev, const u8 *err,
 			    const u32 len)
 {
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index a0794632fd01..36c5c5e38c1d 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -27,7 +27,7 @@
 TRACE_EVENT(extlog_mem_event,
 	TP_PROTO(struct cper_sec_mem_err *mem,
 		 u32 err_seq,
-		 const uuid_le *fru_id,
+		 const guid_t *fru_id,
 		 const char *fru_text,
 		 u8 sev),
 
@@ -39,7 +39,7 @@ TRACE_EVENT(extlog_mem_event,
 		__field(u8, sev)
 		__field(u64, pa)
 		__field(u8, pa_mask_lsb)
-		__field_struct(uuid_le, fru_id)
+		__field_struct(guid_t, fru_id)
 		__string(fru_text, fru_text)
 		__field_struct(struct cper_mem_err_compact, data)
 	),
@@ -218,8 +218,8 @@ TRACE_EVENT(arm_event,
  */
 TRACE_EVENT(non_standard_event,
 
-	TP_PROTO(const uuid_le *sec_type,
-		 const uuid_le *fru_id,
+	TP_PROTO(const guid_t *sec_type,
+		 const guid_t *fru_id,
 		 const char *fru_text,
 		 const u8 sev,
 		 const u8 *err,
-- 
2.20.1

