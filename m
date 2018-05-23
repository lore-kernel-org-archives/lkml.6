Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933541AbeEWP7l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:59:41 -0400
Received: from zulu.geekplace.eu ([5.45.100.158]:38420 "EHLO zulu.geekplace.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754671AbeEWP7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:59:19 -0400
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] driver-core: print bus registration error value
Date: Wed, 23 May 2018 17:59:13 +0200
Message-Id: <20180523155913.29679-4-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180523155913.29679-1-flo@geekplace.eu>
References: <20180523155913.29679-1-flo@geekplace.eu>
In-Reply-To: <20180516160816.20251-1-flo@geekplace.eu>
References: <20180516160816.20251-1-flo@geekplace.eu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If driver_register() is called with an device driver which previously
called bus_register() but failed, then print out the bus_register()
error code.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---

Notes:
    Make it clear in the error message that the error code is from the bus
    registration and *not* from the driver registration.

 drivers/base/driver.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 857c8f1b876e..b21fed9687c9 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -149,8 +149,14 @@ int driver_register(struct device_driver *drv)
 	struct device_driver *other;
 
 	if (!drv->bus->p) {
-		pr_err("Driver '%s' was unable to register with bus_type '%s' because the bus was not initialized.\n",
-			   drv->name, drv->bus->name);
+		if (drv->bus->bus_register_error) {
+			pr_err("Driver '%s' was unable to register with bus_type '%s' because bus registration failed with error %d.\n",
+				   drv->name, drv->bus->name,
+				   drv->bus->bus_register_error);
+		} else {
+			pr_err("Driver '%s' was unable to register with bus_type '%s' because the bus was not initialized.\n",
+				   drv->name, drv->bus->name);
+		}
 		return -EINVAL;
 	}
 
-- 
2.16.1
