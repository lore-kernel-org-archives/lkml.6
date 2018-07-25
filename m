Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB2620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB2620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeGYEbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:31:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:1335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725752AbeGYEbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:31:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 20:21:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="69673733"
Received: from shawn-bm6650-bm6350.itwn.intel.com ([10.5.253.27])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2018 20:21:08 -0700
From:   alanx.chiang@intel.com
To:     linux-i2c@vger.kernel.org
Cc:     andy.yeh@intel.com, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com,
        rajmohan.mani@intel.com, andy.shevchenko@gmail.com,
        tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        rpjday@crashcourse.ca, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alan Chiang <alanx.chiang@intel.com>
Subject: [RESEND PATCH v4 2/2] eeprom: at24: Add support for address-width property
Date:   Wed, 25 Jul 2018 11:20:22 +0800
Message-Id: <1532488822-5622-3-git-send-email-alanx.chiang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com>
References: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com>
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
 drivers/misc/eeprom/at24.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0c125f2..7ea640b 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -478,6 +478,23 @@ static void at24_properties_to_pdata(struct device *dev,
 	if (device_property_present(dev, "no-read-rollover"))
 		chip->flags |= AT24_FLAG_NO_RDROL;
 
+	err = device_property_read_u32(dev, "address-width", &val);
+	if (!err) {
+		switch (val) {
+		case 8:
+			if (chip->flags & AT24_FLAG_ADDR16)
+				dev_warn(dev, "Override address width to be 8, while default is 16\n");
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

