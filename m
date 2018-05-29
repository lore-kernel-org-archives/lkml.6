Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934620AbeE2NK4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:10:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39937 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934552AbeE2NKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:47 -0400
X-Google-Smtp-Source: AB8JxZooO1ljjf020087jHozOFfgnk4wedMnUnRbUzvdeAiOLQFnxIZvWyWB11JUoxH37/LSZNiqyw==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 09/19] serdev: Provide modalias uevent for modalias devices
Date: Tue, 29 May 2018 15:10:04 +0200
Message-Id: <20180529131014.18641-10-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the sysfs uevent for modalias devices. This is required by newer
versions of udev for autoload modules.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index a9c935f68076..9414700e6442 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -46,6 +46,7 @@ ATTRIBUTE_GROUPS(serdev_device);
 static int serdev_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	int rc;
+	struct serdev_device *serdev = to_serdev_device(dev);
 
 	/* TODO: platform modalias */
 
@@ -53,7 +54,11 @@ static int serdev_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (rc != -ENODEV)
 		return rc;
 
-	return of_device_uevent_modalias(dev, env);
+	if (rc != of_device_uevent_modalias(dev, env))
+		return rc;
+
+	return add_uevent_var(env, "MODALIAS=%s%s", SERDEV_MODULE_PREFIX,
+						    serdev->modalias);
 }
 
 static void serdev_device_release(struct device *dev)
-- 
2.17.0
