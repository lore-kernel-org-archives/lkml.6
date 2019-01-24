Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB86C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C0021872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfAXLZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:25:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56232 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfAXLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:25:11 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id be190ba80cdf9948; Thu, 24 Jan 2019 12:25:09 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 2/6] driver core: Reorder actions in __device_links_no_driver()
Date:   Thu, 24 Jan 2019 12:16:43 +0100
Message-ID: <1613403.ZNkCsVQxPT@aspire.rjw.lan>
In-Reply-To: <2493187.oiOpCWJBV7@aspire.rjw.lan>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All links to suppliers have to be either "available" or in the
"supplier unbind in progress" state after __device_links_no_driver()
and the kref_put() may not actually delete them, so change the state
of each link in __device_links_no_driver() before attempting to drop
it.

While at it, update the kernedoc comment of __device_links_no_driver()
to reflect what happens more accurately.

Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -500,11 +500,11 @@ void device_links_driver_bound(struct de
  * __device_links_no_driver - Update links of a device without a driver.
  * @dev: Device without a drvier.
  *
- * Delete all non-persistent links from this device to any suppliers.
+ * Drop references to non-persistent links from this device to any suppliers.
  *
- * Persistent links stay around, but their status is changed to "available",
- * unless they already are in the "supplier unbind in progress" state in which
- * case they need not be updated.
+ * Links with DL_FLAG_AUTOREMOVE_CONSUMER unset stay around, but their status is
+ * changed to "available", unless they already are in the "supplier unbind in
+ * progress" state in which case they need not be updated.
  *
  * Links with the DL_FLAG_STATELESS flag set are ignored.
  */
@@ -516,10 +516,11 @@ static void __device_links_no_driver(str
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
+		if (link->status != DL_STATE_SUPPLIER_UNBIND)
+			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+
 		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
 			kref_put(&link->kref, __device_link_del);
-		else if (link->status != DL_STATE_SUPPLIER_UNBIND)
-			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 	}
 
 	dev->links.status = DL_DEV_NO_DRIVER;

