Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeC3L0i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:26:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43020 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeC3L0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:26:34 -0400
X-Google-Smtp-Source: AIpwx48K2G3siZjV3nPEESfUzSY6TIfaDDWN7+WN0+y4fbjbGOUybHudqF5VPjaH3ugdHS/vbVy6Rg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: srinivas.pandruvada@linux.intel.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] hid: intel-ish-hid: use put_device() instead of kfree()
Date: Fri, 30 Mar 2018 16:56:10 +0530
Message-Id: <66bd5f1ab1322081927f657090a04b44da326140.1522408033.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index f272cdd..2623a56 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -418,7 +418,7 @@ static struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device *dev,
 		list_del(&device->device_link);
 		spin_unlock_irqrestore(&dev->device_list_lock, flags);
 		dev_err(dev->devc, "Failed to register ISHTP client device\n");
-		kfree(device);
+		put_device(&device->dev);
 		return NULL;
 	}
 
-- 
2.7.4
