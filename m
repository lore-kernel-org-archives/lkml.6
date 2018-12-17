Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D134C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331FF2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbeLQLYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:24:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53400 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeLQLYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:24:09 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 0dc6ba72cc4eaad6; Mon, 17 Dec 2018 12:24:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFT][PATCH 1/2] ACPI: EC / PM: Disable non-wakeup GPEs for suspend-to-idle
Date:   Mon, 17 Dec 2018 12:21:55 +0100
Message-ID: <2063835.z7HCSAZctJ@aspire.rjw.lan>
In-Reply-To: <4307523.O7RPX2KSmk@aspire.rjw.lan>
References: <4307523.O7RPX2KSmk@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are systems in which non-wakeup GPEs fire during the "noirq"
suspend stage of suspending devices and that effectively prevents the
system that tries to suspend to idle from entering any low-power
state at all.  If the offending GPE fires regularly and often enough,
the system appears to be suspended, but in fact it is in a tight loop
over "noirq" suspend and "noirq" resume of devices all the time.

To prevent that from happening, disable all non-wakeup GPEs except
for the EC GPE for suspend-to-idle (the EC GPE is special, because
on some systems it has to be enabled for power button wakeup events
to be generated as expected).

Fixes: 147a7d9d25ca (ACPI / PM: Do not reconfigure GPEs for suspend-to-idle)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       |   12 ++++++++++++
 drivers/acpi/internal.h |    2 ++
 drivers/acpi/sleep.c    |   11 +++++++++++
 3 files changed, 25 insertions(+)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1034,6 +1034,18 @@ void acpi_ec_unblock_transactions(void)
 		acpi_ec_start(first_ec, true);
 }
 
+void acpi_ec_mark_gpe_for_wake(void)
+{
+	if (first_ec && !ec_no_wakeup)
+		acpi_mark_gpe_for_wake(NULL, first_ec->gpe);
+}
+
+void acpi_ec_set_gpe_wake_mask(u8 action)
+{
+	if (first_ec && !ec_no_wakeup)
+		acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
+}
+
 void acpi_ec_dispatch_gpe(void)
 {
 	if (first_ec)
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -187,6 +187,8 @@ int acpi_ec_ecdt_probe(void);
 int acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
+void acpi_ec_mark_gpe_for_wake(void);
+void acpi_ec_set_gpe_wake_mask(u8 action);
 void acpi_ec_dispatch_gpe(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -940,6 +940,8 @@ static int lps0_device_attach(struct acp
 
 		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
 				  bitmask);
+
+		acpi_ec_mark_gpe_for_wake();
 	} else {
 		acpi_handle_debug(adev->handle,
 				  "_DSM function 0 evaluation failed\n");
@@ -968,11 +970,16 @@ static int acpi_s2idle_prepare(void)
 	if (lps0_device_handle) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
+
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
 	}
 
 	if (acpi_sci_irq_valid())
 		enable_irq_wake(acpi_sci_irq);
 
+	/* Change the configuration of GPEs to avoid spurious wakeup. */
+	acpi_enable_all_wakeup_gpes();
+	acpi_os_wait_events_complete();
 	return 0;
 }
 
@@ -1017,10 +1024,14 @@ static void acpi_s2idle_sync(void)
 
 static void acpi_s2idle_restore(void)
 {
+	acpi_enable_all_runtime_gpes();
+
 	if (acpi_sci_irq_valid())
 		disable_irq_wake(acpi_sci_irq);
 
 	if (lps0_device_handle) {
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
+
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
 	}

