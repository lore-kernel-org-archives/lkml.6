Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C1FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20ED20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20ED20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeK0CDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:03:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:39090 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbeK0CD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:03:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 07:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="111521790"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Nov 2018 07:09:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C6F87C6; Mon, 26 Nov 2018 17:08:59 +0200 (EET)
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
Subject: [PATCH v2 10/13] platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
Date:   Mon, 26 Nov 2018 17:08:55 +0200
Message-Id: <20181126150858.16901-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
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
index 1faecc99e0a6..2110f2e4aa1a 100644
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
2.19.1

