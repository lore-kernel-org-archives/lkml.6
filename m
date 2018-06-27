Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB85C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97BE268F7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97BE268F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeF0FrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:47:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:36289 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750986AbeF0FrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:47:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 22:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,277,1526367600"; 
   d="scan'208";a="211496385"
Received: from shawn-bm6650-bm6350.itwn.intel.com ([10.5.253.27])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2018 22:46:56 -0700
From:   alanx.chiang@intel.com
To:     linux-i2c@vger.kernel.org
Cc:     andy.yeh@intel.com, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com,
        rajmohan.mani@intel.com, andy.shevchenko@gmail.com,
        tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>
Subject: [PATCH v3 2/2] eeprom: at24: Add support for address-width property
Date:   Wed, 27 Jun 2018 13:46:25 +0800
Message-Id: <1530078385-1546-3-git-send-email-alanx.chiang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Chiang <alanx.chiang@intel.com>

Provide a flexible way to determine the addressing bits of eeprom.
Pass the addressing bits to driver through address-width property.

Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
Signed-off-by: Andy Yeh <andy.yeh@intel.com>

---
since v1
-- Add a warn message for 8-bit addressing.
since v2
-- Modify the warning message for clear.
-- Move the clearing bit operation outside of a statement.

---
 drivers/misc/eeprom/at24.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0c125f2..d606f3b 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -478,6 +478,24 @@ static void at24_properties_to_pdata(struct device *dev,
 	if (device_property_present(dev, "no-read-rollover"))
 		chip->flags |= AT24_FLAG_NO_RDROL;
 
+	err = device_property_read_u32(dev, "address-width", &val);
+	if (!err) {
+		switch (val) {
+		case 8:
+			if (chip->flags & AT24_FLAG_ADDR16)
+				dev_warn(dev, "Override address width to be 8,"
+					 "while default is 16\n");
+			chip->flags &= ~AT24_FLAG_ADDR16;
+			break;
+		case 16:
+			chip->flags |= AT24_FLAG_ADDR16;
+			break;
+		default:
+			dev_warn(dev, "Bad \"address-width\" property: %u\n",
+				 val);
+		}
+	}
+
 	err = device_property_read_u32(dev, "size", &val);
 	if (!err)
 		chip->byte_len = val;
-- 
2.7.4

