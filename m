Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756303AbeDXID1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:03:27 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39015 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeDXIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:03:21 -0400
X-Google-Smtp-Source: AIpwx4+ljHC4q3rftjDXkbPkJLC2UC7Mlwzr1obF7G4pupLDS+oFMV+5GJgoRYl3tBEU6VWhi7Ka0w==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jikos@kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] HID: wacom: Release device resource data obtained by devres_alloc()
Date: Tue, 24 Apr 2018 13:33:03 +0530
Message-Id: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free device resource data, if __wacom_devm_sysfs_create_group
is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/wacom_sys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index b54ef1f..ee7a37e 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1213,8 +1213,10 @@ static int __wacom_devm_sysfs_create_group(struct wacom *wacom,
 	devres->root = root;
 
 	error = sysfs_create_group(devres->root, group);
-	if (error)
+	if (error) {
+		devres_free(devres);
 		return error;
+	}
 
 	devres_add(&wacom->hdev->dev, devres);
 
-- 
1.9.1
