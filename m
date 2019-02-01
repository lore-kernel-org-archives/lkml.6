Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC5C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BEC20815
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfBABEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:04:40 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48374 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfBABEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:04:02 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 2945aa19392aad69; Fri, 1 Feb 2019 02:04:00 +0100
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
Subject: [PATCH v2 6/9] driver core: Do not call rpm_put_suppliers() in pm_runtime_drop_link()
Date:   Fri, 01 Feb 2019 01:52:45 +0100
Message-ID: <4428766.iRGOQCpFvn@aspire.rjw.lan>
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

Calling rpm_put_suppliers() from pm_runtime_drop_link() is excessive
as it affects all suppliers of the consumer device and not just the
one pointed to by the device link being dropped.  Worst case it may
cause the consumer device to stop working unexpectedly.  Moreover, in
principle it is racy with respect to runtime PM of the consumer
device.

To avoid these problems drop runtime PM references on the particular
supplier pointed to by the link in question only and do that after
the link has been dropped from the consumer device's list of links to
suppliers, which is in device_link_free().

Fixes: a0504aecba76 ("PM / runtime: Drop usage count for suppliers at device link removal")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c          |    3 +++
 drivers/base/power/runtime.c |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -374,6 +374,9 @@ EXPORT_SYMBOL_GPL(device_link_add);
 
 static void device_link_free(struct device_link *link)
 {
+	while (refcount_dec_not_one(&link->rpm_active))
+		pm_runtime_put(link->supplier);
+
 	put_device(link->consumer);
 	put_device(link->supplier);
 	kfree(link);
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1611,8 +1611,6 @@ void pm_runtime_new_link(struct device *
 
 void pm_runtime_drop_link(struct device *dev)
 {
-	rpm_put_suppliers(dev);
-
 	spin_lock_irq(&dev->power.lock);
 	WARN_ON(dev->power.links_count == 0);
 	dev->power.links_count--;

