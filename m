Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9201C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9096B21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfBAKEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:04:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58946 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfBAKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:04:34 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 4af744f92d0df213; Fri, 1 Feb 2019 11:04:33 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] ACPI: EC: Make acpi_ec_ecdt_probe() more straightforward
Date:   Fri, 01 Feb 2019 10:58:20 +0100
Message-ID: <8113695.UgGZYynV14@aspire.rjw.lan>
In-Reply-To: <2804781.zocuRj5ZkX@aspire.rjw.lan>
References: <2897234.rJkq6cDEjt@aspire.rjw.lan> <2804781.zocuRj5ZkX@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since acpi_ec_ecdt_probe() is called when boot_ec is not set, it
doesn't neeed to take the other possibility into account.

Accordingly, it only needs to set the handle field in the ec object
to ACPI_ROOT_OBJECT, call acpi_ec_setup() and (if that is successful)
set boot_ec to ec and boot_ec_is_ecdt to 'true'.  Make it do so
directly, without calling acpi_config_boot_ec(), and avoid some
pointless checks in the latter.

No intentional functional impact except for a changed message.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1907,14 +1907,22 @@ void __init acpi_ec_ecdt_probe(void)
 		ec->data_addr = ecdt_ptr->data.address;
 	}
 	ec->gpe = ecdt_ptr->gpe;
+	ec->handle = ACPI_ROOT_OBJECT;
 
 	/*
 	 * At this point, the namespace is not initialized, so do not find
 	 * the namespace objects, or handle the events.
 	 */
-	ret = acpi_config_boot_ec(ec, ACPI_ROOT_OBJECT, false, true);
-	if (ret)
+	ret = acpi_ec_setup(ec, false);
+	if (ret) {
 		acpi_ec_free(ec);
+		return;
+	}
+
+	boot_ec = ec;
+	boot_ec_is_ecdt = true;
+
+	pr_info("Boot ECDT EC used to handle transactions\n");
 }
 
 #ifdef CONFIG_PM_SLEEP

