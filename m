Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85C3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C3D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C3D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeH2VEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:04:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728003AbeH2VEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:04:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6F7FAFDB;
        Wed, 29 Aug 2018 17:06:15 +0000 (UTC)
Date:   Wed, 29 Aug 2018 19:06:14 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, "Zheng, Lv" <lv.zheng@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI / bus: Only call dmi_check_system on X86
Message-ID: <20180829190614.5814817b@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Fixes: cce4f632db20 ("ACPI: fix early DSDT dmi check warnings on ia64")
Cc: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Cc: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
Cc: Len Brown <lenb@kernel.org> (supporter:ACPI)
---
 drivers/acpi/bus.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- linux-4.17.orig/drivers/acpi/bus.c	2018-06-03 23:15:21.000000000 +0200
+++ linux-4.17/drivers/acpi/bus.c	2018-08-29 17:54:09.498532435 +0200
@@ -35,11 +35,11 @@
 #include <linux/delay.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
+#include <linux/dmi.h>
 #endif
 #include <linux/acpi_iort.h>
 #include <linux/pci.h>
 #include <acpi/apei.h>
-#include <linux/dmi.h>
 #include <linux/suspend.h>
 
 #include "internal.h"
@@ -109,10 +109,6 @@ static const struct dmi_system_id acpi_q
 	},
 	{}
 };
-#else
-static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
-	{}
-};
 #endif
 
 /* --------------------------------------------------------------------------
@@ -1060,8 +1056,15 @@ void __init acpi_early_init(void)
 
 	acpi_permanent_mmap = true;
 
-	/* Check machine-specific quirks */
+#ifdef CONFIG_X86
+	/*
+	 * Check machine-specific quirks
+	 * Note that calling dmi_check_system here on other architectures
+	 * would not be OK because only x86 intializes dmi early enough.
+	 * Thankfully only x86 systems need such quirks for now.
+	 */
 	dmi_check_system(acpi_quirks_dmi_table);
+#endif
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {


-- 
Jean Delvare
SUSE L3 Support
