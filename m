Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280BF2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAfe8ZZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280BF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeKZVvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZVvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9C920817;
        Mon, 26 Nov 2018 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229859;
        bh=HA2fMcbIpSMq+XJ4BiFBMvcnF93z2K7NkBnuxoB1vV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAfe8ZZ71TrishznU0Q3VdrMxwBd6ysPcmAqtNDei9MATTR2h+Kw+GHCkRr5cMmWw
         gscjFrn6EzUW54K705Pw10BiN34Py5Y2p42g1WTaEKhK0JtdLcZTd9uaG46Z1S1uwB
         irwFGtAst2sU98znoo/Q6QifPWWrlavDnSzYjgAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Milley <pbmilley@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 28/46] ACPI / watchdog: Prefer iTCO_wdt on Lenovo Z50-70
Date:   Mon, 26 Nov 2018 11:51:17 +0100
Message-Id: <20181126105048.806635366@linuxfoundation.org>
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

[ Upstream commit a0a37862a4e1844793d39aca9ccb8fecbdcb8659 ]

WDAT table on Lenovo Z50-70 is using RTC SRAM (ports 0x70 and 0x71) to
store state of the timer. This conflicts with Linux RTC driver
(rtc-cmos.c) who fails to reserve those ports for itself preventing RTC
from functioning. In addition the WDAT table seems not to be fully
functional because it does not reset the system when the watchdog times
out.

On this system iTCO_wdt works just fine so we simply prefer to use it
instead of WDAT. This makes RTC working again and also results working
watchdog via iTCO_wdt.

Reported-by: Peter Milley <pbmilley@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199033
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_watchdog.c | 59 ++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index ce8fc680785b..ca2724893541 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -12,23 +12,64 @@
 #define pr_fmt(fmt) "ACPI: watchdog: " fmt
 
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 
 #include "internal.h"
 
+static const struct dmi_system_id acpi_watchdog_skip[] = {
+	{
+		/*
+		 * On Lenovo Z50-70 there are two issues with the WDAT
+		 * table. First some of the instructions use RTC SRAM
+		 * to store persistent information. This does not work well
+		 * with Linux RTC driver. Second, more important thing is
+		 * that the instructions do not actually reset the system.
+		 *
+		 * On this particular system iTCO_wdt seems to work just
+		 * fine so we prefer that over WDAT for now.
+		 *
+		 * See also https://bugzilla.kernel.org/show_bug.cgi?id=199033.
+		 */
+		.ident = "Lenovo Z50-70",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20354"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Z50-70"),
+		},
+	},
+	{}
+};
+
+static const struct acpi_table_wdat *acpi_watchdog_get_wdat(void)
+{
+	const struct acpi_table_wdat *wdat = NULL;
+	acpi_status status;
+
+	if (acpi_disabled)
+		return NULL;
+
+	if (dmi_check_system(acpi_watchdog_skip))
+		return NULL;
+
+	status = acpi_get_table(ACPI_SIG_WDAT, 0,
+				(struct acpi_table_header **)&wdat);
+	if (ACPI_FAILURE(status)) {
+		/* It is fine if there is no WDAT */
+		return NULL;
+	}
+
+	return wdat;
+}
+
 /**
  * Returns true if this system should prefer ACPI based watchdog instead of
  * the native one (which are typically the same hardware).
  */
 bool acpi_has_watchdog(void)
 {
-	struct acpi_table_header hdr;
-
-	if (acpi_disabled)
-		return false;
-
-	return ACPI_SUCCESS(acpi_get_table_header(ACPI_SIG_WDAT, 0, &hdr));
+	return !!acpi_watchdog_get_wdat();
 }
 EXPORT_SYMBOL_GPL(acpi_has_watchdog);
 
@@ -41,12 +82,10 @@ void __init acpi_watchdog_init(void)
 	struct platform_device *pdev;
 	struct resource *resources;
 	size_t nresources = 0;
-	acpi_status status;
 	int i;
 
-	status = acpi_get_table(ACPI_SIG_WDAT, 0,
-				(struct acpi_table_header **)&wdat);
-	if (ACPI_FAILURE(status)) {
+	wdat = acpi_watchdog_get_wdat();
+	if (!wdat) {
 		/* It is fine if there is no WDAT */
 		return;
 	}
-- 
2.17.1



