Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB64AC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A0021019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A0021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeK1WrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:47:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:26864 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbeK1WrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:47:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="114556499"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2018 03:45:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BA366491; Wed, 28 Nov 2018 13:45:36 +0200 (EET)
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
Subject: [PATCH v5 07/15] platform/x86: i2c-multi-instantiate: Get rid of obsolete conditional
Date:   Wed, 28 Nov 2018 13:45:27 +0200
Message-Id: <20181128114535.80223-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, when i2c_acpi_new_device() never returns NULL, there is no point to check
for it. Besides that, i2c_acpi_new_device() returns -EPROBE_DEFER directly and
caller doesn't need to guess is better.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index 16a0eabe1e31..724535673089 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -72,14 +72,10 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 			board_info.irq = ret;
 		}
 		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
-		if (IS_ERR(multi->clients[i]))
+		if (IS_ERR(multi->clients[i])) {
 			ret = PTR_ERR(multi->clients[i]);
-		else if (!multi->clients[i])
-			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
-		else
-			ret = 0;
-		if (ret) {
-			dev_err(dev, "Error creating i2c-client, idx %d\n", i);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Error creating i2c-client, idx %d\n", i);
 			goto error;
 		}
 	}
-- 
2.19.2

