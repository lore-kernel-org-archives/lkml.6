Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeEUMJJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:09:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38629 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752198AbeEUMJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:00 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>, <kvm@vger.kernel.org>
Subject: [PATCH 08/33] vfio: use match_string() helper
Date: Mon, 21 May 2018 19:57:45 +0800
Message-ID: <1526903890-35761-9-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/vfio/vfio.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 721f97f..6483387 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -630,8 +630,6 @@ static struct vfio_device *vfio_group_get_device(struct vfio_group *group,
 
 static bool vfio_dev_whitelisted(struct device *dev, struct device_driver *drv)
 {
-	int i;
-
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
@@ -639,12 +637,9 @@ static bool vfio_dev_whitelisted(struct device *dev, struct device_driver *drv)
 			return true;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(vfio_driver_whitelist); i++) {
-		if (!strcmp(drv->name, vfio_driver_whitelist[i]))
-			return true;
-	}
-
-	return false;
+	return match_string(vfio_driver_whitelist,
+			    ARRAY_SIZE(vfio_driver_whitelist),
+			    drv->name) >= 0;
 }
 
 /*
-- 
1.7.12.4
