Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753981AbeEaGXs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:23:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38684 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeEaGXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:23:47 -0400
X-Google-Smtp-Source: ADUXVKI/9QvoF8mFSH1GElrao3iSbS9hf4Or2ERpmlrj1+eSwnwSI6RnL2vK5nKaNq1V/U4So92Ing==
From: Stephen Boyd <swboyd@chromium.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] mfd: cros_ec_dev: Don't advertise junk features on failure
Date: Wed, 30 May 2018 23:23:43 -0700
Message-Id: <20180531062343.243720-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the feature query fails during this driver's probe, we memset the
features bits to 0, but then we continue to overwrite that with whatever
junk we read back when the feature probing failed. In the case of a SPI
device, it may be complete junk, causing the caller of this function to
think certain features are present when they aren't. Don't copy over the
bad message on failure so we can fail more gracefully.

Fixes: e4244ebddae2 ("platform/chrome: Introduce a new function to check EC features.")
Cc: Benson Leung <bleung@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 1d6dc5c7a19d..d37c79426c87 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -113,10 +113,10 @@ static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
 				 ret, msg->result);
 			memset(ec->features, 0, sizeof(ec->features));
+		} else {
+			memcpy(ec->features, msg->data, sizeof(ec->features));
 		}
 
-		memcpy(ec->features, msg->data, sizeof(ec->features));
-
 		dev_dbg(ec->dev, "EC features %08x %08x\n",
 			ec->features[0], ec->features[1]);
 
-- 
Sent by a computer through tubes
