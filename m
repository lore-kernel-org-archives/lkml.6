Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7D2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208AD2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208AD2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeKOI6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:58:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:50988 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbeKOI6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:58:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 14:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,234,1539673200"; 
   d="scan'208";a="106314894"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2018 14:53:04 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 6/7] acpi: Create subtable parsing infrastructure
Date:   Wed, 14 Nov 2018 15:49:19 -0700
Message-Id: <20181114224921.12123-7-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181114224921.12123-2-keith.busch@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parsing entries in an ACPI table had assumed a generic header structure
that is most common. There is no standard ACPI header, though, so less
common types would need custom parsers if they want go walk their
subtable entry list.

Create the infrastructure for adding different table types so parsing
the entries array may be more reused for all ACPI system tables.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/tables.c | 75 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 61203eebf3a1..15ee77780f68 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -49,6 +49,19 @@ static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
 static int acpi_apic_instance __initdata;
 
+enum acpi_subtable_type {
+	ACPI_SUBTABLE_COMMON,
+};
+
+union acpi_subtable_headers {
+	struct acpi_subtable_header common;
+};
+
+struct acpi_subtable_entry {
+	union acpi_subtable_headers *hdr;
+	enum acpi_subtable_type type;
+};
+
 /*
  * Disable table checksum verification for the early stage due to the size
  * limitation of the current x86 early mapping implementation.
@@ -217,6 +230,45 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
+static unsigned long __init
+acpi_get_entry_type(struct acpi_subtable_entry *entry)
+{
+	switch (entry->type) {
+	case ACPI_SUBTABLE_COMMON:
+		return entry->hdr->common.type;
+	}
+	WARN_ONCE(1, "invalid acpi type\n");
+	return 0;
+}
+
+static unsigned long __init
+acpi_get_entry_length(struct acpi_subtable_entry *entry)
+{
+	switch (entry->type) {
+	case ACPI_SUBTABLE_COMMON:
+		return entry->hdr->common.length;
+	}
+	WARN_ONCE(1, "invalid acpi type\n");
+	return 0;
+}
+
+static unsigned long __init
+acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
+{
+	switch (entry->type) {
+	case ACPI_SUBTABLE_COMMON:
+		return sizeof(entry->hdr->common);
+	}
+	WARN_ONCE(1, "invalid acpi type\n");
+	return 0;
+}
+
+static enum acpi_subtable_type __init
+acpi_get_subtable_type(char *id)
+{
+	return ACPI_SUBTABLE_COMMON;
+}
+
 /**
  * acpi_parse_entries_array - for each proc_num find a suitable subtable
  *
@@ -246,8 +298,8 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 		struct acpi_subtable_proc *proc, int proc_num,
 		unsigned int max_entries)
 {
-	struct acpi_subtable_header *entry;
-	unsigned long table_end;
+	struct acpi_subtable_entry entry;
+	unsigned long table_end, subtable_len, entry_len;
 	int count = 0;
 	int errs = 0;
 	int i;
@@ -270,19 +322,21 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 
 	/* Parse all entries looking for a match. */
 
-	entry = (struct acpi_subtable_header *)
+	entry.type = acpi_get_subtable_type(id);
+	entry.hdr = (union acpi_subtable_headers *)
 	    ((unsigned long)table_header + table_size);
+	subtable_len = acpi_get_subtable_header_length(&entry);
 
-	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
-	       table_end) {
+	while (((unsigned long)entry.hdr) + subtable_len  < table_end) {
 		if (max_entries && count >= max_entries)
 			break;
 
 		for (i = 0; i < proc_num; i++) {
-			if (entry->type != proc[i].id)
+			if (acpi_get_entry_type(&entry) != proc[i].id)
 				continue;
 			if (!proc[i].handler ||
-			     (!errs && proc[i].handler(entry, table_end))) {
+			     (!errs && proc[i].handler(&entry.hdr->common,
+						       table_end))) {
 				errs++;
 				continue;
 			}
@@ -297,13 +351,14 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 		 * If entry->length is 0, break from this loop to avoid
 		 * infinite loop.
 		 */
-		if (entry->length == 0) {
+		entry_len = acpi_get_entry_length(&entry);
+		if (entry_len == 0) {
 			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
 			return -EINVAL;
 		}
 
-		entry = (struct acpi_subtable_header *)
-		    ((unsigned long)entry + entry->length);
+		entry.hdr = (union acpi_subtable_headers *)
+		    ((unsigned long)entry.hdr + entry_len);
 	}
 
 	if (max_entries && count > max_entries) {
-- 
2.14.4

