Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbeEHRla (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:41:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755328AbeEHRl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:41:28 -0400
From: Mohammed Gamal <mgamal@redhat.com>
To: netdev@vger.kernel.org, sthemmin@microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        linux-kernel@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>
Subject: [PATCH] hv_netvsc: Fix net device attach on older Windows hosts
Date: Tue,  8 May 2018 19:40:47 +0200
Message-Id: <1525801247-27765-1-git-send-email-mgamal@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On older windows hosts the net_device instance is returned to
the caller of rndis_filter_device_add() without having the presence
bit set first. This would cause any subsequent calls to network device
operations (e.g. MTU change, channel change) to fail after the device
is detached once, returning -ENODEV.

Make sure we explicitly call netif_device_attach() before returning
the net_device instance to make sure the presence bit is set

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/net/hyperv/rndis_filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 6b127be..09a3c1d 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1287,8 +1287,10 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
 		   rndis_device->hw_mac_adr,
 		   rndis_device->link_state ? "down" : "up");
 
-	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_5)
+	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_5) {
+		netif_device_attach(net);
 		return net_device;
+	}
 
 	rndis_filter_query_link_speed(rndis_device, net_device);
 
-- 
1.8.3.1
