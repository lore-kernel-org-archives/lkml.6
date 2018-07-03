Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551E1C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E29D2150E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E29D2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933155AbeGDKWq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:22:46 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:42382 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbeGDKWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:22:44 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 2C00942D43; Wed,  4 Jul 2018 12:22:40 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Tue, 3 Jul 2018 08:09:24 +0200
Subject: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>, nv@vosn.de
Message-Id: <20180704102240.2C00942D43@mail.steuer-voss.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
of_device_id table "compatible" strings in DSD, a pointer to the
corresponding DT table entry should be returned instead of a null
pointer. An acpi_device_id match still takes precedence.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/acpi/bus.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62018eb..c2deffea842e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -832,13 +832,18 @@ EXPORT_SYMBOL_GPL(acpi_match_device);
 
 const void *acpi_device_get_match_data(const struct device *dev)
 {
-	const struct acpi_device_id *match;
+	const struct acpi_device_id *acpi_id = NULL;
+	const struct of_device_id *of_id = NULL;
+	const struct device_driver *drv = dev->driver;
 
-	match = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!match)
+	__acpi_match_device(acpi_companion_match(dev), drv->acpi_match_table,
+			    drv->of_match_table, &acpi_id, &of_id);
+	if (acpi_id)
+		return (const void*)acpi_id->driver_data;
+	else if (of_id)
+		return (const void*)of_id->data;
+	else
 		return NULL;
-
-	return (const void *)match->driver_data;
 }
 EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
 
-- 
2.17.1

