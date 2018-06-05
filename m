Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeFEUjC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:39:02 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:37370
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751834AbeFEUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:39:00 -0400
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc: Dexuan Cui <decui@microsoft.com>, stable@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/8] Drivers: hv: vmbus: Fix the offer_in_progress in vmbus_process_offer()
Date: Tue,  5 Jun 2018 13:37:52 -0700
Message-Id: <20180605203756.29809-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605203756.29809-1-kys@linuxonhyperv.com>
References: <20180605203536.29751-1-kys@linuxonhyperv.com>
 <20180605203756.29809-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfGumRw5Bjs0ayukI83o23tLho14mVMkJbxbII620kHmnkENVgkKr6Lg6/WsEW03ca6jwbUuahje8HmYZ9glHg8ZyI06y4ARB6J1nj2QDMh30dqtqCBGd
 jP5I8c81t6QY1AmjNgMwB+I8WEUMVlSDeXaXX30ocZsOpgS6ynRKr2MijehWgWNoNrHiqPvuhBr8uor6MQMXYlgu7W5DS9Su27CEmS4aISOQTJcHM19d7Stb
 H8rGXrEZtOZi3ePf04auwxzOVb2HbBRlRb0Zxaf0XIlV5RqNgZEO9MRQ72AtQ+RbWEln6VGYFIKvhTFNtZ2S2YZXkGrolw8/NeOi7rEAqV2Z4BJAqeVkInKz
 +YgnaK+pX5QgvLu6r88Nk/nsveuF+w9/G6JEBlzYvs1/v9/LHgyIaAAvaH7ZXvPQZzyCojigJhjXHKkNhItMuQzRMwFm7mfwAYuytwD4vAhbSmhY++b3UHJV
 WxxiDjeq6p/631MVES/31mA9fGOSVGpwC7HRG4bRTr7gs93rTDEwTlR5RYp8yVY5PqrOKFem5wsoNCCEd01Obhi/DkveRmvP83PObsQCwJHEdsnW94M94AEv
 FwFIIi88MaCkLJ8I7hyWoRZG
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

I didn't really hit a real bug, but just happened to spot the bug:
we have decreased the counter at the beginning of vmbus_process_offer(),
so we mustn't decrease it again.

Fixes: 6f3d791f3006 ("Drivers: hv: vmbus: Fix rescind handling issues")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Stable <stable@vger.kernel.org> # 4.14 and above
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index ecc2bd275a73..f3b551a50653 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -527,10 +527,8 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 		struct hv_device *dev
 			= newchannel->primary_channel->device_obj;
 
-		if (vmbus_add_channel_kobj(dev, newchannel)) {
-			atomic_dec(&vmbus_connection.offer_in_progress);
+		if (vmbus_add_channel_kobj(dev, newchannel))
 			goto err_free_chan;
-		}
 
 		if (channel->sc_creation_callback != NULL)
 			channel->sc_creation_callback(newchannel);
-- 
2.17.1
