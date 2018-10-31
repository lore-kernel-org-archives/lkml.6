Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC7EECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4997820664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgBKmrXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4997820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeKAIGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbeKAIGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEC520823;
        Wed, 31 Oct 2018 23:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027198;
        bh=2Hgx14Sui0rTxICiZtVqJ812vE5fhOiozRwac0iJpcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgBKmrXMPwsC2/BJP2KUJPhb73E/0Z4tSGDc2GqGv5/AcEfnL9fqUtBCHBVh/2zsm
         +Ai6aBdyt6MukeqxIcBbvXLSkclK4MhSzkWqSw47KSR0EBCwf2MI9dNkz5LFtJo91f
         DGkVVq+qyEyCVhFhnNbAXKUpDmT4ZvbSg6wM+zEQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 062/146] ACPI / LPSS: Add alternative ACPI HIDs for Cherry Trail DMA controllers
Date:   Wed, 31 Oct 2018 19:04:17 -0400
Message-Id: <20181031230541.28822-62-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 240714061c58e6b1abfb3322398a7634151c06cb ]

Bay and Cherry Trail DSTDs represent a different set of devices depending
on which OS the device think it is booting. One set of decices for Windows
and another set of devices for Android which targets the Android-x86 Linux
kernel fork (which e.g. used to have its own display driver instead of
using the i915 driver).

Which set of devices we are actually going to get is out of our control,
this is controlled by the ACPI OSID variable, which gets either set through
an EFI setup option, or sometimes is autodetected. So we need to support
both.

This commit adds support for the 80862286 and 808622C0 ACPI HIDs which we
get for the first resp. second DMA controller on Cherry Trail devices when
OSID is set to Android.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_lpss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index bf64cfa30feb..969bf8d515c0 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -327,9 +327,11 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 	{ "INT33FC", },
 
 	/* Braswell LPSS devices */
+	{ "80862286", LPSS_ADDR(lpss_dma_desc) },
 	{ "80862288", LPSS_ADDR(bsw_pwm_dev_desc) },
 	{ "8086228A", LPSS_ADDR(bsw_uart_dev_desc) },
 	{ "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
+	{ "808622C0", LPSS_ADDR(lpss_dma_desc) },
 	{ "808622C1", LPSS_ADDR(bsw_i2c_dev_desc) },
 
 	/* Broadwell LPSS devices */
-- 
2.17.1

