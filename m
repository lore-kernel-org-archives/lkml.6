Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C964C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524E321104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcC28WNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524E321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeKZVv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZVv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E374820817;
        Mon, 26 Nov 2018 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229862;
        bh=G3k+FTa+WkB+wh7BqmilwAEZZOLY1LmvG6VNeEaPPms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcC28WNAr6d84xXv48jTgzKPylV7JemDownVsZKNkvzcSL7Znq3ha0nR48ubfplBA
         25ZDGL/3O4tv5i2u8Nl76bYOcH5EWF7zZAq3KotcptfACwYXVr7pDrovzwp900Frbk
         zPYgF0EUP3vjeeFi3B2GISgeCm1yhdiRyR87kzs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnold Guy <aurnoldg@gmail.com>,
        Alois Nespor <nespor@fssp.cz>, Yury Pakin <zxwarior@gmail.com>,
        Ihor Chyhin <ihorchyhin@ukr.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 29/46] ACPI / watchdog: Prefer iTCO_wdt always when WDAT table uses RTC SRAM
Date:   Mon, 26 Nov 2018 11:51:18 +0100
Message-Id: <20181126105048.880481831@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5a802a7a285c8877ca872e44eeb0f06afcb5212f ]

After we added quirk for Lenovo Z50-70 it turns out there are at least
two more systems where WDAT table includes instructions accessing RTC
SRAM. Instead of quirking each system separately, look for such
instructions in the table and automatically prefer iTCO_wdt if found.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199033
Reported-by: Arnold Guy <aurnoldg@gmail.com>
Reported-by: Alois Nespor <nespor@fssp.cz>
Reported-by: Yury Pakin <zxwarior@gmail.com>
Reported-by: Ihor Chyhin <ihorchyhin@ukr.net>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_watchdog.c | 72 ++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index ca2724893541..396e358c2cee 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -12,35 +12,51 @@
 #define pr_fmt(fmt) "ACPI: watchdog: " fmt
 
 #include <linux/acpi.h>
-#include <linux/dmi.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 
 #include "internal.h"
 
-static const struct dmi_system_id acpi_watchdog_skip[] = {
-	{
-		/*
-		 * On Lenovo Z50-70 there are two issues with the WDAT
-		 * table. First some of the instructions use RTC SRAM
-		 * to store persistent information. This does not work well
-		 * with Linux RTC driver. Second, more important thing is
-		 * that the instructions do not actually reset the system.
-		 *
-		 * On this particular system iTCO_wdt seems to work just
-		 * fine so we prefer that over WDAT for now.
-		 *
-		 * See also https://bugzilla.kernel.org/show_bug.cgi?id=199033.
-		 */
-		.ident = "Lenovo Z50-70",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20354"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Z50-70"),
-		},
-	},
-	{}
-};
+#ifdef CONFIG_RTC_MC146818_LIB
+#include <linux/mc146818rtc.h>
+
+/*
+ * There are several systems where the WDAT table is accessing RTC SRAM to
+ * store persistent information. This does not work well with the Linux RTC
+ * driver so on those systems we skip WDAT driver and prefer iTCO_wdt
+ * instead.
+ *
+ * See also https://bugzilla.kernel.org/show_bug.cgi?id=199033.
+ */
+static bool acpi_watchdog_uses_rtc(const struct acpi_table_wdat *wdat)
+{
+	const struct acpi_wdat_entry *entries;
+	int i;
+
+	entries = (struct acpi_wdat_entry *)(wdat + 1);
+	for (i = 0; i < wdat->entries; i++) {
+		const struct acpi_generic_address *gas;
+
+		gas = &entries[i].register_region;
+		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+			switch (gas->address) {
+			case RTC_PORT(0):
+			case RTC_PORT(1):
+			case RTC_PORT(2):
+			case RTC_PORT(3):
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+#else
+static bool acpi_watchdog_uses_rtc(const struct acpi_table_wdat *wdat)
+{
+	return false;
+}
+#endif
 
 static const struct acpi_table_wdat *acpi_watchdog_get_wdat(void)
 {
@@ -50,9 +66,6 @@ static const struct acpi_table_wdat *acpi_watchdog_get_wdat(void)
 	if (acpi_disabled)
 		return NULL;
 
-	if (dmi_check_system(acpi_watchdog_skip))
-		return NULL;
-
 	status = acpi_get_table(ACPI_SIG_WDAT, 0,
 				(struct acpi_table_header **)&wdat);
 	if (ACPI_FAILURE(status)) {
@@ -60,6 +73,11 @@ static const struct acpi_table_wdat *acpi_watchdog_get_wdat(void)
 		return NULL;
 	}
 
+	if (acpi_watchdog_uses_rtc(wdat)) {
+		pr_info("Skipping WDAT on this system because it uses RTC SRAM\n");
+		return NULL;
+	}
+
 	return wdat;
 }
 
-- 
2.17.1



