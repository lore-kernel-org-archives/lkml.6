Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C44AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83B52146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCIDZNdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83B52146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbeK3Bds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbeK3Bdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DFB213A2;
        Thu, 29 Nov 2018 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501693;
        bh=vpvGs1d21MLliqAf5WTTOqDHu2uzmmBQyS6YlZxqm1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCIDZNdwIcE+VWfs6TY/Vh4AkpCzvJXLU6w6c9Y2+udbMZS1gYeGkdbW9z2xwVOcK
         lIPKww9ogJTTg79uKAj1MwoBTCLYxp0wX8wuYRFv1cge3bPd8AHfLHzSM9oq2v4jOO
         UfKOXvg9st0wv6r7jlar/Osb2Aq/k2bVVQ9u3m/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 087/100] driver core: Move device_links_purge() after bus_remove_device()
Date:   Thu, 29 Nov 2018 15:12:57 +0100
Message-Id: <20181129140106.334832162@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeffy Chen <jeffy.chen@rock-chips.com>

commit 2ec16150179888b81717d1d3ce84e634f4736af2 upstream.

The current ordering of code in device_del() triggers a WARN_ON()
in device_links_purge(), because of an unexpected link status.

The device_links_unbind_consumers() call in device_release_driver()
has to take place before device_links_purge() for the status of all
links to be correct, so move the device_links_purge() call in
device_del() after the invocation of bus_remove_device() which calls
device_release_driver().

Fixes: 9ed9895370ae (driver core: Functional dependencies tracking support)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1973,7 +1973,6 @@ void device_del(struct device *dev)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
 
-	device_links_purge(dev);
 	dpm_sysfs_remove(dev);
 	if (parent)
 		klist_del(&dev->p->knode_parent);
@@ -2001,6 +2000,7 @@ void device_del(struct device *dev)
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
 	device_remove_properties(dev);
+	device_links_purge(dev);
 
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...


