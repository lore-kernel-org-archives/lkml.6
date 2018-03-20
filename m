Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeCTOPO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:15:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750888AbeCTOPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:15:12 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/meson: Fix potential NULL dereference in meson_drv_bind_master()
Date: Tue, 20 Mar 2018 14:20:30 +0000
Message-ID: <1521555630-29284-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource_byname() may fail and return NULL, so we should
better check it's return value to avoid a NULL pointer dereference
a bit later in the code.

This is detected by Coccinelle semantic patch.

@@
expression pdev, res, n, t, e, e1, e2;
@@

res = platform_get_resource_byname(pdev, t, n);
+ if (!res)
+   return -EINVAL;
... when != res == NULL
e = devm_ioremap(e1, res->start, e2);

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 3baceb7..32b1a6c 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -197,6 +197,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	priv->io_base = regs;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
+	if (!res)
+		return -EINVAL;
 	/* Simply ioremap since it may be a shared register zone */
 	regs = devm_ioremap(dev, res->start, resource_size(res));
 	if (!regs) {
@@ -213,6 +215,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
+	if (!res)
+		return -EINVAL;
 	/* Simply ioremap since it may be a shared register zone */
 	regs = devm_ioremap(dev, res->start, resource_size(res));
 	if (!regs) {
