Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA1CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4482218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfBAKEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:04:53 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64585 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfBAKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:04:34 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 066adde30d6f43a7; Fri, 1 Feb 2019 11:04:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] ACPI: EC: Make acpi_ec_dsdt_probe() more straightforward
Date:   Fri, 01 Feb 2019 10:59:42 +0100
Message-ID: <1584296.eCrsGTMp5G@aspire.rjw.lan>
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

Since acpi_ec_dsdt_probe() returns early if boot_ec is set, it is
always unset when that function calls acpi_config_boot_ec() (passing
ec->handle as the handle argument to it).  Thus it is not really
useful to call acpi_config_boot_ec() at that point.  It is sufficient to
call acpi_ec_setup() directly and (if that is successful) set boot_ec,
so make acpi_ec_dsdt_probe() do that and avoid some pointless checks
in acpi_config_boot_ec().

No intentional functional impact except for a changed message.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1768,9 +1768,16 @@ void __init acpi_ec_dsdt_probe(void)
 	 * At this point, the GPE is not fully initialized, so do not to
 	 * handle the events.
 	 */
-	ret = acpi_config_boot_ec(ec, ec->handle, false, false);
-	if (ret)
+	ret = acpi_ec_setup(ec, false);
+	if (ret) {
 		acpi_ec_free(ec);
+		return;
+	}
+
+	boot_ec = ec;
+
+	acpi_handle_info(ec->handle,
+			 "Boot DSDT EC used to handle transactions\n");
 }
 
 /*

