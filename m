Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C885C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700E4207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfAXXJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:09:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:21167 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfAXXI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:08:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 15:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="313295741"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2019 15:08:23 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv5 02/10] acpi: Add HMAT to generic parsing tables
Date:   Thu, 24 Jan 2019 16:07:16 -0700
Message-Id: <20190124230724.10022-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190124230724.10022-1-keith.busch@intel.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Heterogeneous Memory Attribute Table (HMAT) header has different
field lengths than the existing parsing uses. Add the HMAT type to the
parsing rules so it may be generically parsed.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/tables.c | 9 +++++++++
 include/linux/acpi.h  | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 967e1168becf..d9911cd55edc 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -51,6 +51,7 @@ static int acpi_apic_instance __initdata;
 
 enum acpi_subtable_type {
 	ACPI_SUBTABLE_COMMON,
+	ACPI_SUBTABLE_HMAT,
 };
 
 struct acpi_subtable_entry {
@@ -232,6 +233,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 	switch (entry->type) {
 	case ACPI_SUBTABLE_COMMON:
 		return entry->hdr->common.type;
+	case ACPI_SUBTABLE_HMAT:
+		return entry->hdr->hmat.type;
 	}
 	return 0;
 }
@@ -242,6 +245,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 	switch (entry->type) {
 	case ACPI_SUBTABLE_COMMON:
 		return entry->hdr->common.length;
+	case ACPI_SUBTABLE_HMAT:
+		return entry->hdr->hmat.length;
 	}
 	return 0;
 }
@@ -252,6 +257,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 	switch (entry->type) {
 	case ACPI_SUBTABLE_COMMON:
 		return sizeof(entry->hdr->common);
+	case ACPI_SUBTABLE_HMAT:
+		return sizeof(entry->hdr->hmat);
 	}
 	return 0;
 }
@@ -259,6 +266,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 static enum acpi_subtable_type __init
 acpi_get_subtable_type(char *id)
 {
+	if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
+		return ACPI_SUBTABLE_HMAT;
 	return ACPI_SUBTABLE_COMMON;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7c3c4ebaded6..53f93dff171c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -143,6 +143,7 @@ enum acpi_address_range_id {
 /* Table Handlers */
 union acpi_subtable_headers {
 	struct acpi_subtable_header common;
+	struct acpi_hmat_structure hmat;
 };
 
 typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
-- 
2.14.4

