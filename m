Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C682AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F1524001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F1524001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbeGFMOe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:14:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50348 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:14:32 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id da16ad57a5b2ef46; Fri, 6 Jul 2018 14:14:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Thomas =?ISO-8859-1?Q?H=E4nig?= <haenig@cosifan.de>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date:   Fri, 06 Jul 2018 14:13:04 +0200
Message-ID: <1704080.gFTvVrrZA1@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <7049b672-859c-e049-a391-f66e4336d4a9@cosifan.de> <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 6, 2018 1:21:50 PM CEST Rafael J. Wysocki wrote:
> On Fri, Jul 6, 2018 at 1:12 PM, Thomas Hänig <haenig@cosifan.de> wrote:

[cut]
 
> So the latest patch:
> 
> https://patchwork.kernel.org/patch/10511211/
> 
> should work for you (please verify) and the change in
> drivers/acpi/sleep.c in it most likely is not necessary.
> 
> If you can confirm that this one works for you, I'll send a smaller
> one with the acpi_hw_legacy_sleep() part alone.

Well, scratch this, sorry.

The power button probably is a fixed event and it won't be effected by
that patch.

Instead, please test the patch below.

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

