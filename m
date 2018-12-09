Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F737C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3976420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3976420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeLIWPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:15:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38082 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728052AbeLIWOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:33 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW734-0002ic-MG; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003W8-N4; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jean Delvare" <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.940666926@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 212/328] ACPI / bus: Only call dmi_check_system() on X86
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>

commit 5d128fbd8b20f8a48cb13c3eced789d1f9573ecd upstream.

Calling dmi_check_system() early only works on X86. Other
architectures initialize the DMI subsystem later so it's not
ready yet when ACPI itself gets initialized.

In the best case it results in a useless call to a function which
will do nothing. But depending on the dmi implementation, it could
also result in warnings. Best is to not call the function when it
can't work and isn't needed.

Additionally, if anyone ever needs to add non-x86 quirks, it would
surprisingly not work, so document the limitation to avoid confusion.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: cce4f632db20 (ACPI: fix early DSDT dmi check warnings on ia64)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/acpi/bus.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -36,10 +36,10 @@
 #include <linux/regulator/machine.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
+#include <linux/dmi.h>
 #endif
 #include <linux/pci.h>
 #include <acpi/apei.h>
-#include <linux/dmi.h>
 #include <linux/suspend.h>
 
 #include "internal.h"
@@ -82,10 +82,6 @@ static struct dmi_system_id dsdt_dmi_tab
 	},
 	{}
 };
-#else
-static struct dmi_system_id dsdt_dmi_table[] __initdata = {
-	{}
-};
 #endif
 
 /* --------------------------------------------------------------------------
@@ -508,11 +504,16 @@ void __init acpi_early_init(void)
 
 	acpi_gbl_permanent_mmap = 1;
 
+#ifdef CONFIG_X86
 	/*
 	 * If the machine falls into the DMI check table,
-	 * DSDT will be copied to memory
+	 * DSDT will be copied to memory.
+	 * Note that calling dmi_check_system() here on other architectures
+	 * would not be OK because only x86 initializes dmi early enough.
+	 * Thankfully only x86 systems need such quirks for now.
 	 */
 	dmi_check_system(dsdt_dmi_table);
+#endif
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {

