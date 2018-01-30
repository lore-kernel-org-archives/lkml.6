Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbeA3UaJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:30:09 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56670 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeA3UaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:30:06 -0500
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
Subject: [PATCH v3 41/43] drm/rockchip: Disable PSR from reboot notifier
Date: Tue, 30 Jan 2018 21:29:11 +0100
Message-Id: <20180130202913.28724-42-thierry.escande@collabora.com>
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

It looks like the driver subsystem detaches devices from power domains
at shutdown without consent of the drivers. This means that we might have
our power domain turned off behind our back and the only way to avoid
problems is to stop doing any hardware programming at some point before
the power is cut. A reboot notifier, despite being a misnomer and
handling shutdowns as well, is a good place to do it.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index e7e16d92d5a1..1bf5cba9a64d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/input.h>
+#include <linux/reboot.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
@@ -33,6 +34,7 @@ struct psr_drv {
 	struct delayed_work	flush_work;
 	struct work_struct	disable_work;
 
+	struct notifier_block	reboot_nb;
 	struct input_handler    input_handler;
 
 	int (*set)(struct drm_encoder *encoder, bool enable);
@@ -309,6 +311,24 @@ static const struct input_device_id psr_ids[] = {
 	{ },
 };
 
+static int rockchip_drm_psr_reboot_notifier(struct notifier_block *nb,
+					    unsigned long action, void *data)
+{
+	struct psr_drv *psr = container_of(nb, struct psr_drv, reboot_nb);
+
+	/*
+	 * It looks like the driver subsystem detaches devices from power
+	 * domains at shutdown without consent of the drivers. This means
+	 * that we might have our power domain turned off behind our back
+	 * and the only way to avoid problems is to stop doing any hardware
+	 * programming after this point, which is achieved by the unbalanced
+	 * call below.
+	 */
+	rockchip_drm_psr_inhibit_get(psr->encoder);
+
+	return 0;
+}
+
 /**
  * rockchip_drm_psr_register - register encoder to psr driver
  * @encoder: encoder that obtain the PSR function
@@ -361,6 +381,9 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 	if (error)
 		goto err1;
 
+	psr->reboot_nb.notifier_call = rockchip_drm_psr_reboot_notifier;
+	register_reboot_notifier(&psr->reboot_nb);
+
 	mutex_lock(&drm_drv->psr_list_lock);
 	list_add_tail(&psr->list, &drm_drv->psr_list);
 	mutex_unlock(&drm_drv->psr_list_lock);
@@ -403,6 +426,7 @@ void rockchip_drm_psr_unregister(struct drm_encoder *encoder)
 			WARN_ON(psr->inhibit_count != 1);
 
 			list_del(&psr->list);
+			unregister_reboot_notifier(&psr->reboot_nb);
 			input_unregister_handler(&psr->input_handler);
 			kfree(psr->input_handler.name);
 			kfree(psr);
-- 
2.14.1
