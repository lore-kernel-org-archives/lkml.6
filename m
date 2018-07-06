Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E754C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D792624003
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D792624003
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbeGFKBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:01:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59504 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeGFKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:01:34 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id e393566fd7189947; Fri, 6 Jul 2018 12:01:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] driver core: Drop devices_kset_move_last() call from really_probe()
Date:   Fri, 06 Jul 2018 12:00:06 +0200
Message-ID: <8816662.k3KXbdkA2e@aspire.rjw.lan>
In-Reply-To: <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com> <2108146.dv4EAOf6IP@aspire.rjw.lan> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The devices_kset_move_last() call in really_probe() is a mistake
as it may cause parents to follow children in the devices_kset list
which then causes system shutdown to fail.  Namely, if a device has
children before really_probe() is called for it (which is not
uncommon), that call will cause it to be reordered after the children
in the devices_kset list and the ordering of that list will not
reflect the correct device shutdown order.

Also it causes the devices_kset list to be constantly reordered
until all drivers have been probed which is totally pointless
overhead in the majority of cases.

For that reason, revert the really_probe() modifications made by
commit 52cdbdd49853.

Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
Reported-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/dd.c |    8 --------
 1 file changed, 8 deletions(-)

Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -434,14 +434,6 @@ re_probe:
 			goto probe_failed;
 	}
 
-	/*
-	 * Ensure devices are listed in devices_kset in correct order
-	 * It's important to move Dev to the end of devices_kset before
-	 * calling .probe, because it could be recursive and parent Dev
-	 * should always go first
-	 */
-	devices_kset_move_last(dev);
-
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
 		if (ret)

