Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48889C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2442420815
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfBABEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:04:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49948 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfBABEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:04:04 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 52647f3649c24aeb; Fri, 1 Feb 2019 02:04:02 +0100
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
Subject: [PATCH v2 2/9] driver core: Avoid careless re-use of existing device links
Date:   Fri, 01 Feb 2019 01:46:54 +0100
Message-ID: <2222273.ydJmd408XJ@aspire.rjw.lan>
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

After commit ead18c23c263 ("driver core: Introduce device links
reference counting"), if there is a link between the given supplier
and the given consumer already, device_link_add() will refcount it
and return it unconditionally.  However, if the flags passed to
it on the second (or any subsequent) attempt to create a device
link between the same consumer-supplier pair are not compatible with
the existing link's flags, that is incorrect.

First off, if the existing link is stateless and the next caller of
device_link_add() for the same consumer-supplier pair wants a
stateful one, or the other way around, the existing link cannot be
returned, because it will not match the expected behavior, so make
device_link_add() dump the stack and return NULL in that case.

Moreover, if the DL_FLAG_AUTOREMOVE_CONSUMER flag is passed to
device_link_add(), its caller will expect its reference to the link
to be dropped automatically on consumer driver removal, which will
not happen if that flag is not set in the link's flags (and
analogously for DL_FLAG_AUTOREMOVE_SUPPLIER).  For this reason, make
device_link_add() update the existing link's flags accordingly
before returning it to the caller.

Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -221,12 +221,29 @@ struct device_link *device_link_add(stru
 		goto out;
 	}
 
-	list_for_each_entry(link, &supplier->links.consumers, s_node)
-		if (link->consumer == consumer) {
-			kref_get(&link->kref);
+	list_for_each_entry(link, &supplier->links.consumers, s_node) {
+		if (link->consumer != consumer)
+			continue;
+
+		/*
+		 * Don't return a stateless link if the caller wants a stateful
+		 * one and vice versa.
+		 */
+		if (WARN_ON((flags & DL_FLAG_STATELESS) != (link->flags & DL_FLAG_STATELESS))) {
+			link = NULL;
 			goto out;
 		}
 
+		if (flags & DL_FLAG_AUTOREMOVE_CONSUMER)
+			link->flags |= DL_FLAG_AUTOREMOVE_CONSUMER;
+
+		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+			link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
+
+		kref_get(&link->kref);
+		goto out;
+	}
+
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		goto out;

