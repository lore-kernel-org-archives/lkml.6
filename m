Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685FDC282D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5CB20815
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfBABEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:04:13 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64615 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfBABEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:04:05 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 29387df70406e268; Fri, 1 Feb 2019 02:04:03 +0100
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 1/9] driver core: Fix DL_FLAG_AUTOREMOVE_SUPPLIER device link flag handling
Date:   Fri, 01 Feb 2019 01:45:55 +0100
Message-ID: <1798513.IhqZgjcq75@aspire.rjw.lan>
In-Reply-To: <1952449.TVsm6CJCTy@aspire.rjw.lan>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Change the list walk in device_links_driver_cleanup() to a safe one
to avoid use-after-free when dropping a link from the list during the
walk.

Also, while at it, fix device_link_add() to refuse to create
stateless device links with DL_FLAG_AUTOREMOVE_SUPPLIER set, which is
an invalid combination (setting that flag means that the driver core
should manage the link, so it cannot be stateless), and extend the
kerneldoc comment of device_link_add() to cover the
DL_FLAG_AUTOREMOVE_SUPPLIER flag properly too.

Fixes: 1689cac5b32a ("driver core: Add flag to autoremove device link on supplier unbind")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -179,10 +179,14 @@ void device_pm_move_to_tail(struct devic
  * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
  * ignored.
  *
- * If the DL_FLAG_AUTOREMOVE_CONSUMER is set, the link will be removed
- * automatically when the consumer device driver unbinds from it.
- * The combination of both DL_FLAG_AUTOREMOVE_CONSUMER and DL_FLAG_STATELESS
- * set is invalid and will cause NULL to be returned.
+ * If the DL_FLAG_AUTOREMOVE_CONSUMER flag is set, the link will be removed
+ * automatically when the consumer device driver unbinds from it.  Analogously,
+ * if DL_FLAG_AUTOREMOVE_SUPPLIER is set in @flags, the link will be removed
+ * automatically when the supplier device driver unbinds from it.
+ *
+ * The combination of DL_FLAG_STATELESS and either DL_FLAG_AUTOREMOVE_CONSUMER
+ * or DL_FLAG_AUTOREMOVE_SUPPLIER set in @flags at the same time is invalid and
+ * will cause NULL to be returned upfront.
  *
  * A side effect of the link creation is re-ordering of dpm_list and the
  * devices_kset list by moving the consumer device and all devices depending
@@ -199,8 +203,8 @@ struct device_link *device_link_add(stru
 	struct device_link *link;
 
 	if (!consumer || !supplier ||
-	    ((flags & DL_FLAG_STATELESS) &&
-	     (flags & DL_FLAG_AUTOREMOVE_CONSUMER)))
+	    (flags & DL_FLAG_STATELESS &&
+	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER | DL_FLAG_AUTOREMOVE_SUPPLIER)))
 		return NULL;
 
 	device_links_write_lock();
@@ -539,11 +543,11 @@ void device_links_no_driver(struct devic
  */
 void device_links_driver_cleanup(struct device *dev)
 {
-	struct device_link *link;
+	struct device_link *link, *ln;
 
 	device_links_write_lock();
 
-	list_for_each_entry(link, &dev->links.consumers, s_node) {
+	list_for_each_entry_safe(link, ln, &dev->links.consumers, s_node) {
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 

