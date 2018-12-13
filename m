Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12756C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86F620879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86F620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeLMS2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:28:09 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57956 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeLMS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:28:09 -0500
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id ef3a5b3589861782; Thu, 13 Dec 2018 19:28:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martin Liu <liumartin@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH] driver core: Add missing dev->bus->need_parent_lock checks
Date:   Thu, 13 Dec 2018 19:27:47 +0100
Message-ID: <7586985.G9YL5ver76@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

__device_release_driver() has to check dev->bus->need_parent_lock
before dropping the parent lock and acquiring it again as it may
attempt to drop a lock that hasn't been acquired or lock a device
that shouldn't be locked and create a lock imbalance.

Fixes: 8c97a46af04b (driver core: hold dev's parent lock when needed)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This should go into -stable for everything over 4.18 methinks.

---
 drivers/base/dd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -933,11 +933,11 @@ static void __device_release_driver(stru
 
 		while (device_links_busy(dev)) {
 			device_unlock(dev);
-			if (parent)
+			if (parent && dev->bus->need_parent_lock)
 				device_unlock(parent);
 
 			device_links_unbind_consumers(dev);
-			if (parent)
+			if (parent && dev->bus->need_parent_lock)
 				device_lock(parent);
 
 			device_lock(dev);

