Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeA3UaC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:30:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeA3UaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:30:00 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Haixia Shi <hshi@chromium.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Zain Wang <wzz@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Yao <mark.yao@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 36/43] drm/rockchip: analogix_dp: Do not call Analogix code before bind
Date: Tue, 30 Jan 2018 21:29:06 +0100
Message-Id: <20180130202913.28724-37-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

Driver callbacks, such as system suspend or resume can be called any
time, specifically they can be called before the component bind
callback. Let's use dp->adp pointer as a safeguard and skip calling
Analogix entry points if it is an ERR_PTR().

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 23317a2269e1..6d45d62466b3 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -368,6 +368,8 @@ static void rockchip_dp_unbind(struct device *dev, struct device *master,
 	analogix_dp_unbind(dp->adp);
 	rockchip_drm_psr_unregister(&dp->encoder);
 	dp->encoder.funcs->destroy(&dp->encoder);
+
+	dp->adp = ERR_PTR(-ENODEV);
 }
 
 static const struct component_ops rockchip_dp_component_ops = {
@@ -391,6 +393,7 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dp->dev = dev;
+	dp->adp = ERR_PTR(-ENODEV);
 	dp->plat_data.panel = panel;
 
 	ret = rockchip_dp_of_probe(dp);
@@ -414,6 +417,9 @@ static int rockchip_dp_suspend(struct device *dev)
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
 
+	if (IS_ERR(dp->adp))
+		return 0;
+
 	return analogix_dp_suspend(dp->adp);
 }
 
@@ -421,6 +427,9 @@ static int rockchip_dp_resume(struct device *dev)
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
 
+	if (IS_ERR(dp->adp))
+		return 0;
+
 	return analogix_dp_resume(dp->adp);
 }
 #endif
-- 
2.14.1
