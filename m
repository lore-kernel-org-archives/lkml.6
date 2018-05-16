Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeEPMOU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:14:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48311 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeEPMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:14:18 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        "Wang, Wendy" <wendy.wang@intel.com>
Subject: [PATCH 2/2] ACPI: EC: Dispatch the EC GPE directly on s2idle wake
Date: Wed, 16 May 2018 14:13:21 +0200
Message-ID: <3221007.8CUDle5b3u@aspire.rjw.lan>
In-Reply-To: <2406722.gU2bUHd7bl@aspire.rjw.lan>
References: <2406722.gU2bUHd7bl@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On platforms where the Low Power S0 Idle _DSM interface is used,
on wakeup from suspend-to-idle, when it is known that the ACPI SCI
has triggered while suspended, dispatch the EC GPE in order to catch
all EC events that may have triggered the wakeup before carrying out
the noirq phase of device resume.

That is needed to handle power button wakeup on some platforms where
the EC goes into a low-power mode during suspend-to-idle and while in
that mode it will discard events after a timeout.  If that timeout is
shorter than the time it takes to complete the noirq resume of
devices, looking for EC events after the latter is too late.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
---
 drivers/acpi/ec.c       |    6 ++++++
 drivers/acpi/internal.h |    1 +
 drivers/acpi/sleep.c    |    7 +++++++
 3 files changed, 14 insertions(+)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1034,6 +1034,12 @@ void acpi_ec_unblock_transactions(void)
 		acpi_ec_start(first_ec, true);
 }
 
+void acpi_ec_dispatch_gpe(void)
+{
+	if (first_ec)
+		acpi_dispatch_gpe(NULL, first_ec->gpe);
+}
+
 /* --------------------------------------------------------------------------
                                 Event Management
    -------------------------------------------------------------------------- */
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -188,6 +188,7 @@ int acpi_ec_ecdt_probe(void);
 int acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
+void acpi_ec_dispatch_gpe(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -989,6 +989,13 @@ static void acpi_s2idle_wake(void)
 	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
 		pm_system_cancel_wakeup();
 		s2idle_wakeup = true;
+		/*
+		 * On some platforms with the LPS0 _DSM device noirq resume
+		 * takes too much time for EC wakeup events to survive, so look
+		 * for them now.
+		 */
+		if (lps0_device_handle)
+			acpi_ec_dispatch_gpe();
 	}
 }
 
