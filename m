Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC797C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9549208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2FZl+S2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9549208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404478AbeKLIXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404439AbeKLIXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:47 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C754521582;
        Sun, 11 Nov 2018 22:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975629;
        bh=foWBHB8TgRonUCfk75oChh56fN9blBQbCpBCitiMP8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FZl+S2oEHLEVzrwks/kxz0a3MdmAogdtkLK2RrAf2nHfet5rDqgY+QdnJUImu+4Q
         +fHpmh5yezcIOMcnuIkk+39azTJqFWi34DOkiyRAZqc/xeOOwD8Ptp+Zd6rtkce3Dj
         QvH/rpTAhBrELEeV6Jze68jzn9f73Q7SVyQqXRNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 046/141] ACPI / LPSS: Add alternative ACPI HIDs for Cherry Trail DMA controllers
Date:   Sun, 11 Nov 2018 14:25:05 -0800
Message-Id: <20181111221633.842230956@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_lpss.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -278,9 +278,11 @@ static const struct acpi_device_id acpi_
 	{ "INT33FC", },
 
 	/* Braswell LPSS devices */
+	{ "80862286", LPSS_ADDR(lpss_dma_desc) },
 	{ "80862288", LPSS_ADDR(bsw_pwm_dev_desc) },
 	{ "8086228A", LPSS_ADDR(bsw_uart_dev_desc) },
 	{ "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
+	{ "808622C0", LPSS_ADDR(lpss_dma_desc) },
 	{ "808622C1", LPSS_ADDR(bsw_i2c_dev_desc) },
 
 	/* Broadwell LPSS devices */


