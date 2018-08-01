Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B26C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AE220844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AE220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405553AbeHATID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405022AbeHATID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:03 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 59F1BCC2;
        Wed,  1 Aug 2018 17:21:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 152/246] ACPI / LPSS: Only call pwm_add_table() for Bay Trail PWM if PMIC HRV is 2
Date:   Wed,  1 Aug 2018 18:51:02 +0200
Message-Id: <20180801165019.017997033@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit c975e472ec12392a0c34de1350e634310f8a1dea ]

The Point of View mobii wintab p800w Bay Trail tablet comes with a Crystal
Cove PMIC, yet uses the LPSS PWM for backlight control, rather then the
Crystal Cove's PWM, so we need to call pwm_add_table() to add a
pwm_backlight mapping for the LPSS pwm despite there being an INT33FD
ACPI device present.

On all Bay Trail devices the _HRV object of the INT33FD ACPI device
will normally return 2, to indicate the Bay Trail variant of the CRC
PMIC is present, except on this tablet where _HRV is 0xffff. I guess this
is a hack to make the windows Crystal Cove PWM driver not bind.

Out of the 44 DSTDs with an INT33FD device in there which I have (from
different model devices) only the pov mobii wintab p800w uses 0xffff for
the HRV.

The byt_pwm_setup code calls acpi_dev_present to check for the presence
of a INT33FD ACPI device which indicates that a CRC PMIC is present and
if the INT33FD ACPI device is present then byt_pwm_setup will not add
a pwm_backlight mapping for the LPSS pwm, so that the CRC PWM will get
used instead.

acpi_dev_present has a hrv parameter, this commit make us pass 2 instead
of -1, so that things still match on normal tablets, but on this special
case with its _HRV of 0xffff, the check will now fail so that the
pwm_backlight mapping for the LPSS pwm gets added fixing backlight
brightness control on this device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_lpss.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -69,6 +69,10 @@ ACPI_MODULE_NAME("acpi_lpss");
 #define LPSS_SAVE_CTX			BIT(4)
 #define LPSS_NO_D3_DELAY		BIT(5)
 
+/* Crystal Cove PMIC shares same ACPI ID between different platforms */
+#define BYT_CRC_HRV			2
+#define CHT_CRC_HRV			3
+
 struct lpss_private_data;
 
 struct lpss_device_desc {
@@ -162,7 +166,7 @@ static void byt_pwm_setup(struct lpss_pr
 	if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
 		return;
 
-	if (!acpi_dev_present("INT33FD", NULL, -1))
+	if (!acpi_dev_present("INT33FD", NULL, BYT_CRC_HRV))
 		pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
 }
 


