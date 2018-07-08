Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DAEC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCBB208A4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCBB208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754144AbeGHJLr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 05:11:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41555 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754027AbeGHJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 05:11:44 -0400
Received: from 79.184.255.246.ipv4.supernova.orange.pl (79.184.255.246) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 9c4e14fc15384825; Sun, 8 Jul 2018 11:11:42 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Thomas =?ISO-8859-1?Q?H=E4nig?= <haenig@cosifan.de>,
        Takashi Iwai <tiwai@suse.de>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPICA: Clear status of all events when entering S5
Date:   Sun, 08 Jul 2018 11:10:13 +0200
Message-ID: <2396867.eZQXUlvGZn@aspire.rjw.lan>
In-Reply-To: <6f01a906-b27c-0e1a-e9f6-fa27c015faa3@cosifan.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <1704080.gFTvVrrZA1@aspire.rjw.lan> <6f01a906-b27c-0e1a-e9f6-fa27c015faa3@cosifan.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 18996f2db918 (ACPICA: Events: Stop unconditionally
clearing ACPI IRQs during suspend/resume) the status of ACPI events
is not cleared any more when entering the ACPI S5 system state (power
off) which causes some systems to power up immediately after turing
off power in certain situations.

That is a functional regression, so address it by making the code
clear the status of all ACPI events again when entering S5 (for
system-wide suspend or hibernation the clearing of the status of all
events is not desirable, as it might cause the kernel to miss wakeup
events sometimes).

Fixes: 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume)
Reported-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Thomas Hänig <haenig@cosifan.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Resend https://patchwork.kernel.org/patch/10511451/ with a changelig and tags.

---
 drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/acpica/hwsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
+++ linux-pm/drivers/acpi/acpica/hwsleep.c
@@ -51,16 +51,23 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
 		return_ACPI_STATUS(status);
 	}
 
-	/*
-	 * 1) Disable all GPEs
-	 * 2) Enable all wakeup GPEs
-	 */
+	/* Disable all GPEs */
 	status = acpi_hw_disable_all_gpes();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
+	/*
+	 * If the target sleep state is S5, clear all GPEs and fixed events too
+	 */
+	if (sleep_state == ACPI_STATE_S5) {
+		status = acpi_hw_clear_acpi_status();
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+	}
 	acpi_gbl_system_awake_and_running = FALSE;
 
+	 /* Enable all wakeup GPEs */
 	status = acpi_hw_enable_all_wakeup_gpes();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);

