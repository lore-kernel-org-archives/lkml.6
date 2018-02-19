Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeBSWlT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:41:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46560 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932191AbeBSWlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:41:19 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: groeck@chromium.org, gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 5/6] mfd: cros_ec_dev: Check communication with ec at resume
Date: Mon, 19 Feb 2018 23:41:11 +0100
Message-Id: <20180219224111.21601-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

Send dummy command to EC at resume time, wait for status.
If EC loses that command and return a status for the
pre-suspend command, we will not interpret that status as an
answer for an important command.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/cros_ec_dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index fc98e0564061..c901839317ae 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -553,6 +553,16 @@ static __maybe_unused int ec_device_suspend(struct device *dev)
 static __maybe_unused int ec_device_resume(struct device *dev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(dev);
+	char msg[sizeof(struct ec_response_get_version) +
+		 sizeof(CROS_EC_DEV_VERSION)];
+	int ret;
+
+	/* Be sure the communication with the EC is reestablished */
+	ret = ec_get_version(ec, msg, sizeof(msg));
+	if (ret < 0) {
+		dev_err(ec->ec_dev->dev, "No EC response at resume: %d\n", ret);
+		return 0;
+	}
 
 	lb_resume(ec);
 
-- 
2.16.1
