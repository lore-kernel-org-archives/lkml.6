Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754828AbeDYO4j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:56:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38838 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754534AbeDYO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:56:23 -0400
X-Google-Smtp-Source: AIpwx4/VWOQX050JgxBKOJYt9F/fJJbchfo4gt0RBfCXUy+l4PZ/+ZZ7JhRYHMKJNUYynirwgAFh5g==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: davem@davemloft.net, shannon.nelson@oracle.com, jag.raman@oracle.com,
        liam.merwick@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH] sparc: vio: use put_device() instead of kfree()
Date: Wed, 25 Apr 2018 20:26:14 +0530
Message-Id: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/sparc/kernel/vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 1a0fa10..32bae68 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -403,7 +403,7 @@ static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
 	if (err) {
 		printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
 		       dev_name(&vdev->dev), err);
-		kfree(vdev);
+		put_device(&vdev->dev);
 		return NULL;
 	}
 	if (vdev->dp)
-- 
2.7.4
