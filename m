Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434E1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8282080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8282080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbeKLGAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:00:51 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52476 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730938AbeKLGAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:00:51 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt3-0000lJ-D2; Sun, 11 Nov 2018 19:59:13 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001Wf-Hl; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Thierry Reding" <thierry.reding@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.509743851@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 122/366] ACPI / LPSS: Add missing prv_offset setting
 for byt/cht PWM devices
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit fdcb613d49321b5bf5d5a1bd0fba8e7c241dcc70 upstream.

The LPSS PWM device on on Bay Trail and Cherry Trail devices has a set
of private registers at offset 0x800, the current lpss_device_desc for
them already sets the LPSS_SAVE_CTX flag to have these saved/restored
over device-suspend, but the current lpss_device_desc was not setting
the prv_offset field, leading to the regular device registers getting
saved/restored instead.

This is causing the PWM controller to no longer work, resulting in a black
screen,  after a suspend/resume on systems where the firmware clears the
APB clock and reset bits at offset 0x804.

This commit fixes this by properly setting prv_offset to 0x800 for
the PWM devices.

Fixes: e1c748179754 ("ACPI / LPSS: Add Intel BayTrail ACPI mode PWM")
Fixes: 1bfbd8eb8a7f ("ACPI / LPSS: Add ACPI IDs for Intel Braswell")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J . Wysocki <rjw@rjwysocki.net>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
[bwh: Backported to 3.16:
 - Drop changes for Braswell
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -150,6 +150,7 @@ static struct lpss_shared_clock pwm_cloc
 
 static struct lpss_device_desc byt_pwm_dev_desc = {
 	.clk_required = true,
+	.prv_offset = 0x800,
 	.save_ctx = true,
 	.shared_clock = &pwm_clock,
 };

