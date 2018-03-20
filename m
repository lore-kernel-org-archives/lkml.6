Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeCTM2F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:28:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48622 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeCTM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:28:00 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: [PATCH v4 1/8] mfd: cros_ec: fail early if we cannot identify the EC
Date: Tue, 20 Mar 2018 13:27:44 +0100
Message-Id: <20180320122751.14019-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320122751.14019-1-enric.balletbo@collabora.com>
References: <20180320122751.14019-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Palatin <vpalatin@chromium.org>

If we cannot communicate with the EC chip to detect the protocol version
and its features, it's very likely useless to continue. Else we will
commit all kind of uninformed mistakes (using the wrong protocol, the
wrong buffer size, mixing the EC with other chips).

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mfd/cros_ec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index d61024141e2b..74780f2964a1 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -112,7 +112,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 
 	mutex_init(&ec_dev->lock);
 
-	cros_ec_query_all(ec_dev);
+	err = cros_ec_query_all(ec_dev);
+	if (err) {
+		dev_err(dev, "Cannot identify the EC: error %d\n", err);
+		return err;
+	}
 
 	if (ec_dev->irq) {
 		err = request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
-- 
2.16.2
