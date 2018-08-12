Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9229C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17C8219DE
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17C8219DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeHLN34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:29:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50939 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeHLN34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:29:56 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id fd5b4c1f0c3bc93f; Sun, 12 Aug 2018 12:52:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH] ACPICA: Clear status of all events when entering sleep states
Date:   Sun, 12 Aug 2018 12:50:09 +0200
Message-ID: <1764673.ub23GCSM6t@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit fa85015c0d95 (ACPICA: Clear status of all events when entering
S5) made the sleep state entry code in ACPICA clear the status of all
ACPI events when entering S5 to fix a functional regression reported
against commit 18996f2db918 (ACPICA: Events: Stop unconditionally
clearing ACPI IRQs during suspend/resume).  However, it is reported
now that the regression also affects system states other than S5 on
some systems and causes them to wake up from sleep prematurely.

For this reason, make the code in question clear the status of all
ACPI events when entering all sleep states (in addition to S5) to
avoid the premature wakeups (this may cause some wakeup events to
be missed in theory, but the likelihood of that is small and the
change here simply restores the previous behavior of the code).

Fixes: 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume)
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+: fa85015c0d95 ACPICA: Clear status ...
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/hwsleep.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/acpica/hwsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
+++ linux-pm/drivers/acpi/acpica/hwsleep.c
@@ -56,14 +56,9 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-	/*
-	 * If the target sleep state is S5, clear all GPEs and fixed events too
-	 */
-	if (sleep_state == ACPI_STATE_S5) {
-		status = acpi_hw_clear_acpi_status();
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
+	status = acpi_hw_clear_acpi_status();
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
 	}
 	acpi_gbl_system_awake_and_running = FALSE;
 

