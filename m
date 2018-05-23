Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754685AbeEWP7V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:59:21 -0400
Received: from zulu.geekplace.eu ([5.45.100.158]:38412 "EHLO zulu.geekplace.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbeEWP7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:59:17 -0400
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] driver-core: return EINVAL error instead of BUG_ON()
Date: Wed, 23 May 2018 17:59:11 +0200
Message-Id: <20180523155913.29679-2-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180523155913.29679-1-flo@geekplace.eu>
References: <20180523155913.29679-1-flo@geekplace.eu>
In-Reply-To: <20180516160816.20251-1-flo@geekplace.eu>
References: <20180516160816.20251-1-flo@geekplace.eu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I triggerd the BUG_ON() in driver_register() when booting a domU Xen
domain. Since there was no contextual information logged, I needed to
attach kgdb to determine the culprit (the wmi-bmof driver in my
case). The BUG_ON() was added in commit f48f3febb2cb ("driver-core: do
not register a driver with bus_type not registered").

Instead of running into a BUG_ON() we print an error message
identifying the, likely faulty, driver but continue booting.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---

Notes:
    Make it clear in the error message that the bus was not initialized
    and *not* the driver.

 drivers/base/driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index ba912558a510..857c8f1b876e 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -148,7 +148,11 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
-	BUG_ON(!drv->bus->p);
+	if (!drv->bus->p) {
+		pr_err("Driver '%s' was unable to register with bus_type '%s' because the bus was not initialized.\n",
+			   drv->name, drv->bus->name);
+		return -EINVAL;
+	}
 
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
-- 
2.16.1
