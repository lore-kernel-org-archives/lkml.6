Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521079492; cv=none;
        d=google.com; s=arc-20160816;
        b=kQMF4TFHJh5b9pL43jCI7isB9Hj43IbNHbLfXEenreQf9lL0QtHU9cfgDjx5eJBUuq
         2kiS+o8jtQktfRNfe7zGmzgQx4+TkYMYm4AS8ZrcUc3GzMJkndqYKfkB+YZVz7yKq31g
         D4a/BmkFKK14Z26OHYmY+clUphcJ406/ZockAKXCnxC1YSuyJ+rfC9hkb8f1096b5Tyv
         RwseUpEAFpqHjd7cyrv6t23cDK0i2oyyRICGVjd3R8Enim+VjLhBcYbBJwqHCm7QTcur
         LCMyI45wKU94k2flUgVu8fbJBJc15g2+OAfzeIdWqp6Dl6xyH9HC2B3PivlncM1Tarwc
         xOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=uDdZm8yuXcFomq9kTBbYweUNrIni6McZopibnPCFFeA=;
        b=Xli/vEBSy9zaOd2uUKmr0rM2CRaZarO4nRQ/DjAFq50+x1YlEQa+0Uqe6jQrZ5gMn7
         ppfnuuzzA8dmid2HmqHQRt7kxmcCihGUWOTdTiCnu5+NB+rTOqMC1nbWMiMYroLB1wdb
         pNaVlv37QGMY7xlnLtArbU03HN5SJADi6Asa70rZM6uSlr0/Cf+lUhJz9tuoaDVpdYa8
         I5vu39e8KSiWv2NWAHsgJNpMcPUuYXY+ZqrRxhaD4y2EUvVMgI1OWUnq+VE84x2rzr32
         JOtO/TU7BSb2dW/j52QKYnvj4Mgm5WM5upgSQ5XSfZsOaHfHUPF/bz0ydTHB4s37VBeI
         U/OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=hmylWZFp;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=hmylWZFp;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtLSKe5WFttvoO2KrxBf8GnvuJy2vZh5IW+9LaW5AaIGHiBjdaIn6mt+paHRrz+uOCQocOgFw==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org,
	linux-kernel@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI)
Subject: [PATCH v3 2/3] ACPI: SPCR: Add support for AMD CT/SZ
Date: Wed, 14 Mar 2018 20:04:44 -0600
Message-Id: <20180315020445.150604-3-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180315020445.150604-1-djkurtz@chromium.org>
References: <20180315020445.150604-1-djkurtz@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594951095060046903?=
X-GMAIL-MSGID: =?utf-8?q?1594967449680499635?=
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
Changes since v1:
 * added Reviewed-by

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
