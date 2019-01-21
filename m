Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87ECC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C38520855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfAUMIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:08:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52704 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfAUMIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:08:49 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 41bf1d134aed43b4; Mon, 21 Jan 2019 13:08:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH] ACPI: EC: Clean up probing for early EC
Date:   Mon, 21 Jan 2019 13:07:50 +0100
Message-ID: <8960068.Hx1rCpHzTN@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Both acpi_ec_dsdt_probe() and acpi_ec_ecdt_probe() may be void as
their return values are ignored anyway.  This allows a couple of
gotos and labels to go away from there.

Moreover, acpi_ec_ecdt_probe() only needs to allocate the ec
object after getting the ECDT pointer and checking it, so the
pointless memory allocation and release on systems without the
ECDT can be avoided by reordering it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |   47 ++++++++++++++++++++---------------------------
 drivers/acpi/internal.h |    4 ++--
 2 files changed, 22 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1730,10 +1730,10 @@ static const struct acpi_device_id ec_de
  * namespace EC before the main ACPI device enumeration process. It is
  * retained for historical reason and will be deprecated in the future.
  */
-int __init acpi_ec_dsdt_probe(void)
+void __init acpi_ec_dsdt_probe(void)
 {
-	acpi_status status;
 	struct acpi_ec *ec;
+	acpi_status status;
 	int ret;
 
 	/*
@@ -1743,21 +1743,22 @@ int __init acpi_ec_dsdt_probe(void)
 	 * picking up an invalid EC device.
 	 */
 	if (boot_ec)
-		return -ENODEV;
+		return;
 
 	ec = acpi_ec_alloc();
 	if (!ec)
-		return -ENOMEM;
+		return;
+
 	/*
 	 * At this point, the namespace is initialized, so start to find
 	 * the namespace objects.
 	 */
-	status = acpi_get_devices(ec_device_ids[0].id,
-				  ec_parse_device, ec, NULL);
+	status = acpi_get_devices(ec_device_ids[0].id, ec_parse_device, ec, NULL);
 	if (ACPI_FAILURE(status) || !ec->handle) {
-		ret = -ENODEV;
-		goto error;
+		acpi_ec_free(ec);
+		return;
 	}
+
 	/*
 	 * When the DSDT EC is available, always re-configure boot EC to
 	 * have _REG evaluated. _REG can only be evaluated after the
@@ -1766,10 +1767,8 @@ int __init acpi_ec_dsdt_probe(void)
 	 * handle the events.
 	 */
 	ret = acpi_config_boot_ec(ec, ec->handle, false, false);
-error:
 	if (ret)
 		acpi_ec_free(ec);
-	return ret;
 }
 
 /*
@@ -1872,36 +1871,32 @@ static const struct dmi_system_id ec_dmi
 	{},
 };
 
-int __init acpi_ec_ecdt_probe(void)
+void __init acpi_ec_ecdt_probe(void)
 {
-	int ret;
-	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
 	struct acpi_ec *ec;
+	acpi_status status;
+	int ret;
 
-	ec = acpi_ec_alloc();
-	if (!ec)
-		return -ENOMEM;
-	/*
-	 * Generate a boot ec context
-	 */
+	/* Generate a boot ec context. */
 	dmi_check_system(ec_dmi_table);
 	status = acpi_get_table(ACPI_SIG_ECDT, 1,
 				(struct acpi_table_header **)&ecdt_ptr);
-	if (ACPI_FAILURE(status)) {
-		ret = -ENODEV;
-		goto error;
-	}
+	if (ACPI_FAILURE(status))
+		return;
 
 	if (!ecdt_ptr->control.address || !ecdt_ptr->data.address) {
 		/*
 		 * Asus X50GL:
 		 * https://bugzilla.kernel.org/show_bug.cgi?id=11880
 		 */
-		ret = -ENODEV;
-		goto error;
+		return;
 	}
 
+	ec = acpi_ec_alloc();
+	if (!ec)
+		return;
+
 	if (EC_FLAGS_CORRECT_ECDT) {
 		ec->command_addr = ecdt_ptr->data.address;
 		ec->data_addr = ecdt_ptr->control.address;
@@ -1916,10 +1911,8 @@ int __init acpi_ec_ecdt_probe(void)
 	 * the namespace objects, or handle the events.
 	 */
 	ret = acpi_config_boot_ec(ec, ACPI_ROOT_OBJECT, false, true);
-error:
 	if (ret)
 		acpi_ec_free(ec);
-	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -192,8 +192,8 @@ extern struct acpi_ec *first_ec;
 typedef int (*acpi_ec_query_func) (void *data);
 
 int acpi_ec_init(void);
-int acpi_ec_ecdt_probe(void);
-int acpi_ec_dsdt_probe(void);
+void acpi_ec_ecdt_probe(void);
+void acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
 void acpi_ec_mark_gpe_for_wake(void);

