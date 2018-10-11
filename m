Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07631C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD60921477
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD60921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeJKRxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:53:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeJKRxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:53:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30BB3C074571;
        Thu, 11 Oct 2018 10:26:37 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAFF417001;
        Thu, 11 Oct 2018 10:26:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ACPI / PMIC: xpower: Block P-Unit I2C access during read-modify-write
Date:   Thu, 11 Oct 2018 12:26:26 +0200
Message-Id: <20181011102627.7418-3-hdegoede@redhat.com>
In-Reply-To: <20181011102627.7418-1-hdegoede@redhat.com>
References: <20181011102627.7418-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 11 Oct 2018 10:26:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_xpower_pmic_update_power() does a read-modify-write of the output
control register. The i2c-designware code blocks the P-Unit I2C access
during the read and write by taking the P-Unit's PMIC bus semaphore.
But between the read and the write that semaphore is released and the
P-Unit could make changes to the register which we then end up overwriting.

This commit makes intel_xpower_pmic_update_power() take the semaphore
itself so that it is held over the entire read-modify-write, avoiding this
race.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 316e55174aa9..9e6ddf2a2d4e 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
+#include <asm/iosf_mbi.h>
 #include "intel_pmic.h"
 
 #define XPOWER_GPADC_LOW	0x5b
@@ -180,15 +181,21 @@ static int intel_xpower_pmic_get_power(struct regmap *regmap, int reg,
 static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
 					  int bit, bool on)
 {
-	int data;
+	int data, ret;
 
 	/* GPIO1 LDO regulator needs special handling */
 	if (reg == XPOWER_GPI1_CTRL)
 		return regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
 					  on ? GPI1_LDO_ON : GPI1_LDO_OFF);
 
-	if (regmap_read(regmap, reg, &data))
-		return -EIO;
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret)
+		return ret;
+
+	if (regmap_read(regmap, reg, &data)) {
+		ret = -EIO;
+		goto out;
+	}
 
 	if (on)
 		data |= BIT(bit);
@@ -196,9 +203,11 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
 		data &= ~BIT(bit);
 
 	if (regmap_write(regmap, reg, data))
-		return -EIO;
+		ret = -EIO;
+out:
+	iosf_mbi_unblock_punit_i2c_access();
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.19.0

