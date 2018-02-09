Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeBINUx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:20:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:48699 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeBINUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:20:52 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH TRIVIAL] edd: don't spam log if no EDD information is present
Date: Fri,  9 Feb 2018 14:20:45 +0100
Message-Id: <20180209132045.21433-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've had reports from users being concerned about messages like:

  [    4.487246] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
  [    4.487251] EDD information not available.

While these are more or less irrelevant, tell edd.c to not annoy anyone.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
Jiri, I know you're not the edd maintainer (there's none) but I've seen you've
taken edd patches, so ;-).

 drivers/firmware/edd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 60a8f1363a10..1b82c89a49df 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -748,14 +748,12 @@ edd_init(void)
 	int rc=0;
 	struct edd_device *edev;
 
+	if (!edd_num_devices())
+		return -ENODEV;
+
 	printk(KERN_INFO "BIOS EDD facility v%s %s, %d devices found\n",
 	       EDD_VERSION, EDD_DATE, edd_num_devices());
 
-	if (!edd_num_devices()) {
-		printk(KERN_INFO "EDD information not available.\n");
-		return -ENODEV;
-	}
-
 	edd_kset = kset_create_and_add("edd", NULL, firmware_kobj);
 	if (!edd_kset)
 		return -ENOMEM;
-- 
2.13.6
