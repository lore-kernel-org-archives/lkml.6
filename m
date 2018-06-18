Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30D2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E19208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E19208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965721AbeFRKDF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:03:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935092AbeFRIS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:18:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 935C9BAD;
        Mon, 18 Jun 2018 08:18:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shubhrata.Priyadarsh@dell.com,
        Takashi Iwai <tiwai@suse.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 077/279] ACPI / scan: Initialize watchdog before PNP
Date:   Mon, 18 Jun 2018 10:11:02 +0200
Message-Id: <20180618080612.003790910@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit cc6a0e315a68e5db85bea347b0c5b0fe4a9a5904 ]

At least on one Dell system the PNP motherboard resources device
includes resources used by WDAT table. Since PNP gets initialized before
WDAT it results following error and no watchdog:

  platform wdat_wdt: failed to claim resource 3: [io  0x046a-0x046c]
  ACPI: watchdog: Device creation failed: -16

Now, the PNP system driver is already accustomed with the situation that
it cannot reserve all those motherboard resources because drivers using
those might have reserved them already. In addition putting WDAT table
resources under motherboard resources device makes sense in general.

Fix this by initializing WDAT right before PNP. This allows WDAT to
reserve all its resources and still keeps PNP system driver happy.

Reported-by: Shubhrata.Priyadarsh@dell.com
Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2150,10 +2150,10 @@ int __init acpi_scan_init(void)
 	acpi_cmos_rtc_init();
 	acpi_container_init();
 	acpi_memory_hotplug_init();
+	acpi_watchdog_init();
 	acpi_pnp_init();
 	acpi_int340x_thermal_init();
 	acpi_amba_init();
-	acpi_watchdog_init();
 	acpi_init_lpit();
 
 	acpi_scan_add_handler(&generic_device_handler);


