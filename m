Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C9BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CEF20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CEF20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933433AbeFUNBI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:01:08 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:63762 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932972AbeFUNAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:00:36 -0400
X-IronPort-AV: E=Sophos;i="5.51,251,1526342400"; 
   d="scan'208";a="58220301"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     <netdev@vger.kernel.org>
CC:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] xen-netfront: Fix mismatched rtnl_unlock
Date:   Thu, 21 Jun 2018 14:00:20 +0100
Message-ID: <20180621130021.27029-2-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180621130021.27029-1-ross.lagerwall@citrix.com>
References: <20180621130021.27029-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 drivers/net/xen-netfront.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 922ce0a..ee4cb6c 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1810,7 +1810,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 	err = xen_net_read_mac(dev, info->netdev->dev_addr);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "parsing %s/mac", dev->nodename);
-		goto out;
+		goto out_unlocked;
 	}
 
 	rtnl_lock();
@@ -1925,6 +1925,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 	xennet_destroy_queues(info);
  out:
 	rtnl_unlock();
+out_unlocked:
 	device_unregister(&dev->dev);
 	return err;
 }
-- 
2.9.5

