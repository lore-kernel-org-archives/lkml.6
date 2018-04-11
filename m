Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDKCIc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:08:32 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45661 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbeDKCIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:08:30 -0400
X-Google-Smtp-Source: AIpwx4/UtcO9lPWvpPiQtaKEs99SdYTQQp56XgDyGgGlP5F/bRtjqB8m3DJI6Na0K8TuZ6LQu+8o9g==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: jeffrey.t.kirsher@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] intel: i40evf: Replace GFP_ATOMIC with GFP_KERNEL in i40evf_add_vlan
Date: Wed, 11 Apr 2018 10:08:18 +0800
Message-Id: <1523412498-2177-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i40evf_add_vlan() is never called in atomic context.

i40evf_add_vlan() is only called by i40evf_vlan_rx_add_vid(), 
which is only set as ".ndo_vlan_rx_add_vid" in struct net_device_ops.
".ndo_vlan_rx_add_vid" is not called in atomic context.

Despite never getting called from atomic context, 
i40evf_add_vlan() calls kzalloc() with GFP_ATOMIC, 
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL, 
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 1825d95..04b2b9c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -770,7 +770,7 @@ i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 
 	f = i40evf_find_vlan(adapter, vlan);
 	if (!f) {
-		f = kzalloc(sizeof(*f), GFP_ATOMIC);
+		f = kzalloc(sizeof(*f), GFP_KERNEL);
 		if (!f)
 			goto clearout;
 
-- 
1.9.1
