Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933983AbeEIIRv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:17:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753176AbeEIIRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:17:48 -0400
From: Mohammed Gamal <mgamal@redhat.com>
To: netdev@vger.kernel.org, sthemmin@microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        linux-kernel@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>
Subject: [PATCH v2] hv_netvsc: Fix net device attach on older Windows hosts
Date: Wed,  9 May 2018 10:17:34 +0200
Message-Id: <1525853854-8277-1-git-send-email-mgamal@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On older windows hosts the net_device instance is returned to
the caller of rndis_filter_device_add() without having the presence
bit set first. This would cause any subsequent calls to network device
operations (e.g. MTU change, channel change) to fail after the device
is detached once, returning -ENODEV.

Instead of returning the device instabce, we take the exit path where
we call netif_device_attach()

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/net/hyperv/rndis_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 6b127be..e7ca5b5 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1288,7 +1288,7 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
 		   rndis_device->link_state ? "down" : "up");
 
 	if (net_device->nvsp_version < NVSP_PROTOCOL_VERSION_5)
-		return net_device;
+		goto out;
 
 	rndis_filter_query_link_speed(rndis_device, net_device);
 
-- 
1.8.3.1
