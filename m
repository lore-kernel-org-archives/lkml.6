Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A50C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5B12075C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5B12075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbeGJLhP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:37:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65436 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGJLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:37:13 -0400
Received: from 79.184.255.246.ipv4.supernova.orange.pl (79.184.255.246) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 675df17f1068173b; Tue, 10 Jul 2018 13:37:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] driver core: Partially revert "driver core: correct device's shutdown order"
Date:   Tue, 10 Jul 2018 13:35:41 +0200
Message-ID: <2927655.Y1qg3UnIrE@aspire.rjw.lan>
In-Reply-To: <8816662.k3KXbdkA2e@aspire.rjw.lan>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com> <8816662.k3KXbdkA2e@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 52cdbdd49853 (driver core: correct device's shutdown order)
introduced a regression by breaking device shutdown on some systems.

Namely, the devices_kset_move_last() call in really_probe() added by
that commit is a mistake as it may cause parents to follow children
in the devices_kset list which then causes shutdown to fail.  For
example, if a device has children before really_probe() is called
for it (which is not uncommon), that call will cause it to be
reordered after the children in the devices_kset list and the
ordering of that list will not reflect the correct device shutdown
order any more.

Also it causes the devices_kset list to be constantly reordered
until all drivers have been probed which is totally pointless
overhead in the majority of cases and it only covers an issue
with system shutdown, while system-wide suspend/resume potentially
has the same issue on the affected platforms (which is not covered).

For that reason, revert the really_probe() modifications made by
commit 52cdbdd49853 which unfortunately will expose the shutdown
issue the problematic commit attempted to fix (and which will have
to be addressed differently and correctly in the future).

The other code changes made by commit 52cdbdd49853 are useful and
they need not be reverted.

Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
Reported-by: Pingfan Liu <kernelfans@gmail.com>
Tested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a v2 of https://patchwork.kernel.org/patch/10511241/ under
a different subject.

The patch itself hasn't changed, but I rewrote the changelog (as per
the Bjorn's request) and changed the subject accordingly.

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

