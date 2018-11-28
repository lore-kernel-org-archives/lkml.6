Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92598C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA152081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA152081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeK1Wbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:31:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:61970 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbeK1Wby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:31:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="96165078"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2018 03:30:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 281156F3; Wed, 28 Nov 2018 13:30:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 12/15] platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
Date:   Wed, 28 Nov 2018 13:30:21 +0200
Message-Id: <20181128113024.42126-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
References: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ACPI table provides an Interrupt() resource we may consider to use it
instead of GpioInt() one.

Here we leave an error condition, when getting IRQ resource, to the driver
to decide how to proceed, because some drivers may consider IRQ resource
optional.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index 99db3e336718..365457f9c424 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -18,6 +18,7 @@
 #define IRQ_RESOURCE_TYPE	GENMASK(1, 0)
 #define IRQ_RESOURCE_NONE	0
 #define IRQ_RESOURCE_GPIO	1
+#define IRQ_RESOURCE_APIC	2
 
 struct i2c_inst_data {
 	const char *type;
@@ -104,6 +105,14 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 			}
 			board_info.irq = ret;
 			break;
+		case IRQ_RESOURCE_APIC:
+			ret = platform_get_irq(pdev, inst_data[i].irq_idx);
+			if (ret < 0) {
+				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
+					inst_data[i].irq_idx, ret);
+			}
+			board_info.irq = ret;
+			break;
 		default:
 			board_info.irq = 0;
 			break;
-- 
2.19.2

