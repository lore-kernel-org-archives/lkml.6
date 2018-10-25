Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92AAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A827B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zkbq+Az0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A827B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeJYWtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbeJYWt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:29 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90F62148E;
        Thu, 25 Oct 2018 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476992;
        bh=xZuKs+ATdiv19o8dBS+Afd5R2rNOhTsOYP9E80gK+zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zkbq+Az08QL1N0jJarnAXh6nSKTlJabiGEEjvCyE6MKa6YPUaVYf+zGKosNjIbEGx
         Hyz1TjI9rDsd45cnqr2woPBcQDt/y3z/KeXpSAruxhJsI96eg94ahyw1ZSaKotxy7J
         AjnNiQqg3u4hhZXWoeyJTdczEKmvzaVq7NQJkdds=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 88/98] xen-netfront: Fix mismatched rtnl_unlock
Date:   Thu, 25 Oct 2018 10:14:13 -0400
Message-Id: <20181025141423.213774-88-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit cb257783c2927b73614b20f915a91ff78aa6f3e8 ]

Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/xen-netfront.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index c85edd161a6c..aceae791baf3 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1848,7 +1848,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 	err = xen_net_read_mac(dev, info->netdev->dev_addr);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "parsing %s/mac", dev->nodename);
-		goto out;
+		goto out_unlocked;
 	}
 
 	rtnl_lock();
@@ -1963,6 +1963,7 @@ static int talk_to_netback(struct xenbus_device *dev,
 	xennet_destroy_queues(info);
  out:
 	rtnl_unlock();
+out_unlocked:
 	device_unregister(&dev->dev);
 	return err;
 }
-- 
2.17.1

