Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031911AbeEXRv1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:51:27 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37045 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031361AbeEXRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:50:49 -0400
X-Google-Smtp-Source: AB8JxZq9EGtRDV57p9yWBwYQ6N7XV/EKQlqmcjE0feuvafT8tZnCi9AJW4Mup/hjAQcxhxDtTuqScA==
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 8/8] PM / Domains: Stop deferring probe at the end of initcall
Date: Thu, 24 May 2018 12:50:24 -0500
Message-Id: <20180524175024.19874-9-robh@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All PM domain drivers must be built-in (at least those using DT), so
there is no point deferring probe after initcalls are done. Continuing
to defer probe may prevent booting successfully even if managing PM
domains is not required. This can happen if the user failed to enable
the driver or if power-domains are added to a platform's DT, but there
is not yet a driver (e.g. a new DTB with an old kernel).

Call the driver core function driver_deferred_probe_check_init_done()
instead of just returning -EPROBE_DEFER to stop deferring probe when
initcalls are done.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1ea0e2502e8e..6398cf786e6a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2218,7 +2218,7 @@ int genpd_dev_pm_attach(struct device *dev)
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_init_done(dev, true);
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
-- 
2.17.0
