Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756442AbeBPPk3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:40:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:33268 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756412AbeBPPk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:40:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="18427797"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] platform/x86: wmi: Replace kmalloc + sprintf() with kasprintf()
Date: Fri, 16 Feb 2018 17:40:24 +0200
Message-Id: <20180216154024.389-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasprintf() does the job of two: kmalloc() and sprintf().
Replace two calls with one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index c0c8945603cb..4e76ffcb5394 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -933,12 +933,11 @@ static int wmi_dev_probe(struct device *dev)
 			goto probe_failure;
 		}
 
-		buf = kmalloc(strlen(wdriver->driver.name) + 5, GFP_KERNEL);
+		buf = kasprintf(GFP_KERNEL, "wmi/%s", wdriver->driver.name);
 		if (!buf) {
 			ret = -ENOMEM;
 			goto probe_string_failure;
 		}
-		sprintf(buf, "wmi/%s", wdriver->driver.name);
 		wblock->char_dev.minor = MISC_DYNAMIC_MINOR;
 		wblock->char_dev.name = buf;
 		wblock->char_dev.fops = &wmi_fops;
-- 
2.16.1
