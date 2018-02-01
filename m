Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeBAII1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:08:27 -0500
Received: from mail01.prevas.se ([62.95.78.3]:35443 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeBAIIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:08:24 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511823600";
   d="scan'208";a="3161077"
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mnhu@prevas.dk>
To: Jean Delvare <jdelvare@suse.com>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mnhu@prevas.dk>
Subject: [PATCH] firmware: dmi_scan: avoid printing error on non-efi systems
Date: Thu, 1 Feb 2018 09:08:05 +0100
Message-ID: <20180201080805.8076-1-mnhu@prevas.dk>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.8.31]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmi_init() rightfully checks if dmi is available at all, and errors out
if not. This leads to harmless errors being printed during boot on
non-efi systems, even when these are booted quietly.

Avoid this error-print by returning directly from dmi_init() if dmi
isn't available, instead of jumping to the err-label.

Signed-off-by: Martin Hundebøll <mnhu@prevas.dk>
---
 drivers/firmware/dmi_scan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 783041964439..86c5e0625a08 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -715,10 +715,8 @@ static int __init dmi_init(void)
 	u8 *dmi_table;
 	int ret = -ENOMEM;
 
-	if (!dmi_available) {
-		ret = -ENODATA;
-		goto err;
-	}
+	if (!dmi_available)
+		return -ENODATA;
 
 	/*
 	 * Set up dmi directory at /sys/firmware/dmi. This entry should stay
-- 
2.16.1
