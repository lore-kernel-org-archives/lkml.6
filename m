Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDXTfl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbeDXTfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:35:16 -0400
From: Al Stone <ahs3@redhat.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Al Stone <ahs3@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 2/3] ACPI: ensure acpi_parse_entries_array() does not access non-existent table data
Date: Tue, 24 Apr 2018 13:35:04 -0600
Message-Id: <20180424193505.6934-3-ahs3@redhat.com>
In-Reply-To: <20180424193505.6934-1-ahs3@redhat.com>
References: <20180424193505.6934-1-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ACPI tables that have subtables, acpi_parse_entries_array() gets used
to step through each of the subtables in memory.  The primary loop for this
was checking that the beginning location of the subtable being examined
plus the length of struct acpi_subtable_header was not beyond the end of
the complete ACPI table; if it wasn't, the subtable could be examined, but
if it was the loop would terminate as it should.

In the middle of this subtable loop, a callback is used to examine the
subtable in detail.

Should the callback function try to examine elements of the subtable that
are located past the subtable header, and the ACPI table containing this
subtable has an incorrect length, it is possible to access either invalid
or protected memory and cause a fault.  And, the length of struct
acpi_subtable_header will always be smaller than the length of the actual
subtable.

To fix this, we make the main loop check that the beginning of the
subtable being examined plus the actual length of the subtable does
not go past the end of the enclosing ACPI table.  While this cannot
protect us from malicious callback functions, it can prevent us from
failing because of some poorly constructed ACPI tables.

Found by inspection.  There is no functional change to existing code
that is known to work when calling acpi_parse_entries_array().

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/tables.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 21535762b890..c7b028f231a6 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -271,8 +271,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	entry = (struct acpi_subtable_header *)
 	    ((unsigned long)table_header + table_size);
 
-	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
-	       table_end) {
+	while (((unsigned long)entry + entry->length) <= table_end) {
 		if (max_entries && count >= max_entries)
 			break;
 
-- 
2.14.3
