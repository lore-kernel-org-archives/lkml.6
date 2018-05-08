Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeEHDIV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:08:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36072 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeEHDIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:08:19 -0400
X-Google-Smtp-Source: AB8JxZr9kKPu3WiDmrXj3oOTIeauitLeDsSWbbdBcB+KIaNQ27SnQxrif46mlUSq/qhQv4Q0tHOQqQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] acpi: scan: Fix a possible data race in acpi_scan_hotplug_enabled
Date: Tue,  8 May 2018 11:08:11 +0800
Message-Id: <20180508030811.12256-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The write operation to "hotplug->enabled" is protected by
the lock on line 1760, but the read operation to
this data on line 1755 is not protected by the lock.
Thus, there may exist a data race for "hotplug->enabled".

To fix this data race, the read operation to "hotplug->enabled" is 
also protected by the lock.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/acpi/scan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 970dd87d347c..e21d7b0f7179 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1752,11 +1752,13 @@ static struct acpi_scan_handler *acpi_scan_match_handler(const char *idstr,
 
 void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val)
 {
-	if (!!hotplug->enabled == !!val)
-		return;
-
 	mutex_lock(&acpi_scan_lock);
 
+	if (!!hotplug->enabled == !!val) {
+		mutex_unlock(&acpi_scan_lock);
+		return;
+	}
+
 	hotplug->enabled = val;
 
 	mutex_unlock(&acpi_scan_lock);
-- 
2.17.0
