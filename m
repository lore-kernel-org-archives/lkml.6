Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86629C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D16D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeLQLYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:24:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62965 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeLQLYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:24:07 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 7f1cddfd68bd67c7; Mon, 17 Dec 2018 12:24:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFT][PATCH 2/2] ACPI: PM: Loop in full LPS0 mode only
Date:   Mon, 17 Dec 2018 12:22:43 +0100
Message-ID: <1663330.5FSq7u8peI@aspire.rjw.lan>
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

After a previous change, all non-wakeup GPEs are disabled for
suspend-to-idle unless full Low-Power S0 (LPS0) mode is in use, so
it is not necessary to do anything in acpi_s2idle_wake() unless in
full LPS0 mode, which is when lps0_device_handle is set only.

Modify the code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -985,6 +985,8 @@ static int acpi_s2idle_prepare(void)
 
 static void acpi_s2idle_wake(void)
 {
+	if (!lps0_device_handle)
+		return;
 
 	if (pm_debug_messages_on)
 		lpi_check_constraints();
@@ -1003,8 +1005,7 @@ static void acpi_s2idle_wake(void)
 		 * takes too much time for EC wakeup events to survive, so look
 		 * for them now.
 		 */
-		if (lps0_device_handle)
-			acpi_ec_dispatch_gpe();
+		acpi_ec_dispatch_gpe();
 	}
 }
 

