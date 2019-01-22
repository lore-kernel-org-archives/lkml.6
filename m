Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0063AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D7620855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfAVMAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:00:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50242 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfAVMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:00:48 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 388f64bd33816695; Tue, 22 Jan 2019 13:00:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ACPI: EC: Simplify boot EC checks in acpi_ec_add()
Date:   Tue, 22 Jan 2019 12:57:28 +0100
Message-ID: <6098592.dL5p0bd45o@aspire.rjw.lan>
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

Consolidate boot EC checks in acpi_ec_add(), put the acpi_is_boot_ec()
checks directly into it and drop the latter.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1558,16 +1558,6 @@ static bool acpi_ec_ecdt_get_handle(acpi
 	return true;
 }
 
-static bool acpi_is_boot_ec(struct acpi_ec *ec)
-{
-	if (!boot_ec)
-		return false;
-	if (ec->command_addr == boot_ec->command_addr &&
-	    ec->data_addr == boot_ec->data_addr)
-		return true;
-	return false;
-}
-
 static int acpi_ec_add(struct acpi_device *device)
 {
 	struct acpi_ec *ec = NULL;
@@ -1579,22 +1569,22 @@ static int acpi_ec_add(struct acpi_devic
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 
 	if (!strcmp(acpi_device_hid(device), ACPI_ECDT_HID)) {
-		is_ecdt = true;
 		ec = boot_ec;
+		boot_ec_is_ecdt = true;
+		is_ecdt = true;
 	} else {
 		ec = acpi_ec_alloc();
 		if (!ec)
 			return -ENOMEM;
+
 		status = ec_parse_device(device->handle, 0, ec, NULL);
 		if (status != AE_CTRL_TERMINATE) {
 			ret = -EINVAL;
 			goto err_alloc;
 		}
-	}
 
-	if (acpi_is_boot_ec(ec)) {
-		boot_ec_is_ecdt = is_ecdt;
-		if (!is_ecdt) {
+		if (boot_ec && ec->command_addr == boot_ec->command_addr &&
+		    ec->data_addr == boot_ec->data_addr) {
 			/*
 			 * Trust PNP0C09 namespace location rather than
 			 * ECDT ID. But trust ECDT GPE rather than _GPE

