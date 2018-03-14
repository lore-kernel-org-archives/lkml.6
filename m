Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbeCNAha (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:37:30 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36350 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932840AbeCNAhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:37:03 -0400
X-Google-Smtp-Source: AG47ELvxqVMWt7ID7U8DDz5OKD6rOUUgOLIdyvAhzmQHxRL68yrbHK4FgqnT39kPvX1xgk1VK6PmDg==
From: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Daniel Kurtz <djkurtz@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] ACPI: SPCR: Add support for AMD CT/SZ
Date: Tue, 13 Mar 2018 18:36:54 -0600
Message-Id: <20180314003655.12141-3-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180314003655.12141-1-djkurtz@chromium.org>
References: <20180314003655.12141-1-djkurtz@chromium.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
earlycon setup handler to configure its input clock in order to compute
baud rate divisor registers.
Detect them by examining the OEMID field in the SPCR header, and pass
then pass uart type amdcz to earlycon.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/acpi/spcr.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 9d52743080a4..52d840d0e05b 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -73,6 +73,24 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
 	return xgene_8250;
 }
 
+/*
+ * AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
+ * earlycon setup handler to configure its input clock in order to compute
+ * baud rate divisor registers.
+ * Detect them by examining the OEM fields in the SPCR header.
+ */
+static bool amdcz_present(struct acpi_table_spcr *tb)
+{
+	if (memcmp(tb->header.oem_id, "AMDCZ ", ACPI_OEM_ID_SIZE))
+		return false;
+
+	if (memcmp(tb->header.oem_table_id, "AMDCZ   ",
+		    ACPI_OEM_TABLE_ID_SIZE))
+		return false;
+
+	return true;
+}
+
 /**
  * acpi_parse_spcr() - parse ACPI SPCR table and add preferred console
  *
@@ -189,6 +207,11 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 			uart = "qdf2400_e44";
 	}
 
+	if (amdcz_present(table)) {
+		if (enable_earlycon)
+			uart = "amdcz";
+	}
+
 	if (xgene_8250_erratum_present(table)) {
 		iotype = "mmio32";
 
-- 
2.16.2.804.g6dcf76e118-goog
