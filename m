Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933101AbeCEHqR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:46:17 -0500
Received: from regular1.263xmail.com ([211.150.99.140]:53606 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932892AbeCEHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:46:14 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <df881cdc635decbaa4f28c1762d9b3a8>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Romain Perier <romain.perier@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel@lists.freedesktop.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Hans Verkuil <hverkuil@xs4all.nl>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [PATCH] drm/bridge/synopsys: dw-hdmi: Fix memleak in __dw_hdmi_remove
Date: Mon,  5 Mar 2018 15:45:55 +0800
Message-Id: <20180305074555.23368-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_device_register_full() will allocate dma_mask for
hdmi->audio, so we should free before platform_device_unregister().

Reported by kmemleak:
unreferenced object 0xffffffc0ef70ff00 (size 128):
  comm "kworker/4:1", pid 123, jiffies 4294670080 (age 189.604s)
  hex dump (first 32 bytes):
    ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000021946f44>] kmemleak_alloc+0x58/0x8c
    [<000000009c43890d>] kmem_cache_alloc_memcg_trace+0x18c/0x25c
    [<000000000e17cd06>] platform_device_register_full+0x64/0x108
    [<00000000418a0882>] __dw_hdmi_probe+0xb9c/0xcc0
    [<00000000e0b720fd>] dw_hdmi_bind+0x30/0x88
    [<000000009af347f6>] dw_hdmi_rockchip_bind+0x260/0x2e8

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index f9802399cc0d..d9afdc59d4f4 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2567,8 +2567,10 @@ __dw_hdmi_probe(struct platform_device *pdev,
 
 static void __dw_hdmi_remove(struct dw_hdmi *hdmi)
 {
-	if (hdmi->audio && !IS_ERR(hdmi->audio))
+	if (hdmi->audio && !IS_ERR(hdmi->audio)) {
+		kfree(hdmi->audio->dev.dma_mask);
 		platform_device_unregister(hdmi->audio);
+	}
 	if (!IS_ERR(hdmi->cec))
 		platform_device_unregister(hdmi->cec);
 
-- 
2.11.0
