Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521063895; cv=none;
        d=google.com; s=arc-20160816;
        b=lLBh1PBvM0LJ8j9ZFRvgEbpHsHVsZ1UMk/oMwkWdF/gv3Kh7CRh6BbRUlW+LR3YMMC
         6W5rQK/jP1apUgjq90YFwuP1A3iAv8JEjnGrvc/czI9s6bZ68vQvY2udWGKadfaTnUtx
         46XUzuK2D6d3rUKdHj+8hL6SC79OS6qi0uzpNmcN50p505GeoCMZmEWG4++uUCvn10IQ
         /rcf3UKIZJdk33vfhBki1Vjm6N5d3V9JcuUxgpbSk0NmWzGJ/3caibhOTmPn/J4CLDdS
         RFRhNP3i3AuFLTfOLLDZX3zKb+3z7Yg0LrOlSJUJg72qReNPGlZlqeSnzDIElH/EDakQ
         jYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Tdtjq/qkd4bjtfRl96x5sol1oqCrkwUTzGSG+0MBqWA=;
        b=N/YZy08EPLxAQqWsm+UNuPAsDP1wXnAXVW0u4R4LICouEkaTNpup1e5LD1+ZL8tIgO
         IthNaLno6eNE62+Vmnq1pozrHdFw+BS1SXE8D2m2yzQXNPUJLgHuu2eikpUUlomf7lrB
         QvBCCMwvGsNy6RUmQ52kO0bz66ouYQDe2Eh/ZGHl9ViSlRzTdDThMUhd7SfaWznCt7sc
         Qw/qexa6/frvbsykU2wqycMHYyQBxZ2XD1HlKEfRGoS5mEMC2c8DoSclNcMD2udAGS+T
         6keY9Ds2zbcoCTRs1PUeTuda9yRdzogIRnLPVIZxI4//YnEb/uxcNeceMtm5qS9FLPcp
         vsCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=i3jrIxI+;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=i3jrIxI+;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsSs6zjkQyiJJpJAAz+r8mY0heXgCCe/rox8KYKWNh2newCAML0RcdT/6cNWoevcv6MOwNDEA==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org,
	linux-kernel@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI)
Subject: [PATCH v2 2/3] ACPI: SPCR: Add support for AMD CT/SZ
Date: Wed, 14 Mar 2018 15:44:37 -0600
Message-Id: <20180314214439.27806-3-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180314214439.27806-1-djkurtz@chromium.org>
References: <20180314214439.27806-1-djkurtz@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594951095060046903?=
X-GMAIL-MSGID: =?utf-8?q?1594951095060046903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
earlycon setup handler to configure its input clock in order to compute
baud rate divisor registers.
Detect them by examining the OEMID field in the SPCR header, and pass
then pass uart type amdcz to earlycon.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
