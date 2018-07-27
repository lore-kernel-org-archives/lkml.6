Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6050C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42F22089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42F22089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbeG0Lcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:32:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbeG0Lcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:32:53 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DDF20CB7;
        Fri, 27 Jul 2018 10:11:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 15/23] driver core: Partially revert "driver core: correct devices shutdown order"
Date:   Fri, 27 Jul 2018 12:09:16 +0200
Message-Id: <20180727100845.756548568@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100845.054377089@linuxfoundation.org>
References: <20180727100845.054377089@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 722e5f2b1eec7de61117b7c0a7914761e3da2eda upstream.

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
overhead in the majority of cases and it only covered an issue
with system shutdown, while system-wide suspend/resume potentially
had the same issue on the affected platforms (which was not covered).

Moreover, the shutdown issue originally addressed by the change in
really_probe() made by commit 52cdbdd49853 is not present in 4.18-rc
any more, since dra7 started to use the sdhci-omap driver which
doesn't disable any regulators during shutdown, so the really_probe()
part of commit 52cdbdd49853 can be safely reverted.  [The original
issue was related to the omap_hsmmc driver used by dra7 previously.]

For the above reasons, revert the really_probe() modifications made
by commit 52cdbdd49853.

The other code changes made by commit 52cdbdd49853 are useful and
they need not be reverted.

Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
Reported-by: Pingfan Liu <kernelfans@gmail.com>
Tested-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/dd.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -304,14 +304,6 @@ static int really_probe(struct device *d
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


