Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80D4208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80D4208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbeGMNZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:25:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:37714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeGMNZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:25:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 06:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,347,1526367600"; 
   d="scan'208";a="72079065"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2018 06:10:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F048C29B; Fri, 13 Jul 2018 16:10:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Tai <thomas.tai@oracle.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH v1] ras: Use consistent types for UUIDs
Date:   Fri, 13 Jul 2018 16:10:27 +0300
Message-Id: <20180713131027.77362-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
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
2.18.0

