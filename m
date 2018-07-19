Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D897C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5E220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5E220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbeGSLnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:43:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35261 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeGSLnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:43:21 -0400
Received: from 1-161-144-158.dynamic-ip.hinet.net ([1.161.144.158] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fg6fl-00035S-IA; Thu, 19 Jul 2018 11:00:38 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] Revert "ACPI / bus: Parse tables as term_list for Dell XPS 9570 and Precision M5530"
Date:   Thu, 19 Jul 2018 19:00:30 +0800
Message-Id: <20180719110030.9483-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 36904703aeeeb6cd31993f1353c8325006229f9a.

Since commit 5a8361f7ecce ("ACPICA: Integrate package handling with
module-level code"), acpi_gbl_execute_tables_as_methods is always true,
so we can remove the quirk for XPS 9570/Precision M5530.

Cc: Erik Schmauss <erik.schmauss@intel.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/bus.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62018eb..f61f8927d843 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -66,37 +66,10 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
 	return 0;
 }
 #endif
-static int set_gbl_term_list(const struct dmi_system_id *id)
-{
-	acpi_gbl_execute_tables_as_methods = 1;
-	return 0;
-}
 
-static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
-	/*
-	 * Touchpad on Dell XPS 9570/Precision M5530 doesn't work under I2C
-	 * mode.
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=198515
-	 */
-	{
-		.callback = set_gbl_term_list,
-		.ident = "Dell Precision M5530",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Precision M5530"),
-		},
-	},
-	{
-		.callback = set_gbl_term_list,
-		.ident = "Dell XPS 15 9570",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
-		},
-	},
+static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
 	/*
 	 * Invoke DSDT corruption work-around on all Toshiba Satellite.
-	 * DSDT will be copied to memory.
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
 	 */
 	{
@@ -110,7 +83,7 @@ static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
 	{}
 };
 #else
-static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
+static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
 	{}
 };
 #endif
@@ -1060,8 +1033,11 @@ void __init acpi_early_init(void)
 
 	acpi_permanent_mmap = true;
 
-	/* Check machine-specific quirks */
-	dmi_check_system(acpi_quirks_dmi_table);
+	/*
+	 * If the machine falls into the DMI check table,
+	 * DSDT will be copied to memory
+	 */
+	dmi_check_system(dsdt_dmi_table);
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
-- 
2.17.1

