Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E54C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB3D21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfAVMAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:00:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54015 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfAVMAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:00:49 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 108bf77c86f77330; Tue, 22 Jan 2019 13:00:47 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ACPI: EC: Untangle boot EC setup
Date:   Tue, 22 Jan 2019 12:56:35 +0100
Message-ID: <1735201.aqDTV77pFz@aspire.rjw.lan>
In-Reply-To: <2897234.rJkq6cDEjt@aspire.rjw.lan>
References: <2897234.rJkq6cDEjt@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The checks in acpi_config_boot_ec() are mostly redundant in all of
the cases when it is called and it is better to do them directly
in its callers anyway, so do that and get rid of it.

First, note that acpi_ec_ecdt_probe() is called when boot_ec is not
set, so it doesn't neeed to take the other possibility into account.
Accordingly, it only needs to set the handle field in the ec object
to ACPI_ROOT_OBJECT, call acpi_ec_setup() and (if that is successful)
set boot_ec to ec and boot_ec_is_ecdt to 'true'.  Make it do so
directly, without calling acpi_config_boot_ec(), and avoid the
pointless checks in the latter.

Second, acpi_ec_dsdt_probe() returns early if boot_ec is set, so at
the point when it calls acpi_config_boot_ec() (passing ec->handle
as the handle argument to it), boot_ec is always unset.  Thus calling
acpi_config_boot_ec() then is not really useful.  It is sufficient to
call acpi_ec_setup() directly and (if that is successful) set boot_ec,
so make acpi_ec_dsdt_probe() do that.

Finally, acpi_ec_add() calls acpi_config_boot_ec() when it finds that
the device object passed to it represents a "boot" EC, but in that
case the ec pointer passed to acpi_config_boot_ec() is guaranteed
to be equal to boot_ec (and ec->handle is passed as the handle
argument to it), so acpi_config_boot_ec() really only calls
acpi_ec_setup() and prints a message.  Avoid the pointless checks in
acpi_config_boot_ec() by calling acpi_ec_setup() directly and print
the message separately.

With the above changes in place, there are no users of
acpi_config_boot_ec(), so drop it.

No intentional functional impact except for changed messages.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   69 ++++++++++++++++--------------------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1539,49 +1539,6 @@ static int acpi_ec_setup(struct acpi_ec
 	return ret;
 }
 
-static int acpi_config_boot_ec(struct acpi_ec *ec, acpi_handle handle,
-			       bool handle_events, bool is_ecdt)
-{
-	int ret;
-
-	/*
-	 * Changing the ACPI handle results in a re-configuration of the
-	 * boot EC. And if it happens after the namespace initialization,
-	 * it causes _REG evaluations.
-	 */
-	if (boot_ec && boot_ec->handle != handle)
-		ec_remove_handlers(boot_ec);
-
-	/* Unset old boot EC */
-	if (boot_ec != ec)
-		acpi_ec_free(boot_ec);
-
-	/*
-	 * ECDT device creation is split into acpi_ec_ecdt_probe() and
-	 * acpi_ec_ecdt_start(). This function takes care of completing the
-	 * ECDT parsing logic as the handle update should be performed
-	 * between the installation/uninstallation of the handlers.
-	 */
-	if (ec->handle != handle)
-		ec->handle = handle;
-
-	ret = acpi_ec_setup(ec, handle_events);
-	if (ret)
-		return ret;
-
-	/* Set new boot EC */
-	if (!boot_ec) {
-		boot_ec = ec;
-		boot_ec_is_ecdt = is_ecdt;
-	}
-
-	acpi_handle_info(boot_ec->handle,
-			 "Used as boot %s EC to handle transactions%s\n",
-			 is_ecdt ? "ECDT" : "DSDT",
-			 handle_events ? " and events" : "");
-	return ret;
-}
-
 static bool acpi_ec_ecdt_get_handle(acpi_handle *phandle)
 {
 	struct acpi_table_ecdt *ecdt_ptr;
@@ -1649,12 +1606,17 @@ static int acpi_ec_add(struct acpi_devic
 			acpi_ec_free(ec);
 			ec = boot_ec;
 		}
-		ret = acpi_config_boot_ec(ec, ec->handle, true, is_ecdt);
-	} else
-		ret = acpi_ec_setup(ec, true);
+	}
+
+	ret = acpi_ec_setup(ec, true);
 	if (ret)
 		goto err_query;
 
+	if (ec == boot_ec)
+		acpi_handle_info(ec->handle,
+			"Boot %s EC used to handle transactions and events\n",
+			is_ecdt ? "ECDT" : "DSDT");
+
 	device->driver_data = ec;
 
 	ret = !!request_region(ec->data_addr, 1, "EC data");
@@ -1766,9 +1728,14 @@ void __init acpi_ec_dsdt_probe(void)
 	 * At this point, the GPE is not fully initialized, so do not to
 	 * handle the events.
 	 */
-	ret = acpi_config_boot_ec(ec, ec->handle, false, false);
+	ret = acpi_ec_setup(ec, false);
 	if (ret)
 		acpi_ec_free(ec);
+
+	boot_ec = ec;
+
+	acpi_handle_info(ec->handle,
+			 "Boot DSDT EC used to handle transactions\n");
 }
 
 /*
@@ -1905,14 +1872,20 @@ void __init acpi_ec_ecdt_probe(void)
 		ec->data_addr = ecdt_ptr->data.address;
 	}
 	ec->gpe = ecdt_ptr->gpe;
+	ec->handle = ACPI_ROOT_OBJECT;
 
 	/*
 	 * At this point, the namespace is not initialized, so do not find
 	 * the namespace objects, or handle the events.
 	 */
-	ret = acpi_config_boot_ec(ec, ACPI_ROOT_OBJECT, false, true);
+	ret = acpi_ec_setup(ec, false);
 	if (ret)
 		acpi_ec_free(ec);
+
+	boot_ec = ec;
+	boot_ec_is_ecdt = true;
+
+	pr_info("Boot ECDT EC used to handle transactions\n");
 }
 
 #ifdef CONFIG_PM_SLEEP

