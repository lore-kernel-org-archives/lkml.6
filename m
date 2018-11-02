Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A44C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCBE20848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSG88Kje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCBE20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeKCEAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:10 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 491B620848;
        Fri,  2 Nov 2018 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184716;
        bh=MN3rKJNnCgjyqj5ycGkjWHstkaKpnzVt6rYVZh5Bzh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSG88KjekPAMqrgcvMKG0/Ee0906hWBqBQqkiF9yXBjh3487dyB1Lgkwe1doprF1M
         b3ihn/GgsL+x2gUMGe9y7+Q26KCuj7FscK970TRwjkd7b2w4fT2zxi5URsgD+b9Tep
         JT1FY3bkU96fOuSsHVM6TeXioK7vU/FkE4/tbebM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liam Shepherd <liam@dancer.es>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 078/143] xen-netfront: Update features after registering netdev
Date:   Fri,  2 Nov 2018 19:34:23 +0100
Message-Id: <20181102182903.759323328@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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

[ Upstream commit 45c8184c1bed1ca8a7f02918552063a00b909bf5 ]

Update the features after calling register_netdev() otherwise the
device features are not set up correctly and it not possible to change
the MTU of the device. After this change, the features reported by
ethtool match the device's features before the commit which introduced
the issue and it is possible to change the device's MTU.

Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
Reported-by: Liam Shepherd <liam@dancer.es>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/xen-netfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 1a40fc3517a8..ca239912c0e6 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1964,10 +1964,6 @@ static int xennet_connect(struct net_device *dev)
 	/* talk_to_netback() sets the correct number of queues */
 	num_queues = dev->real_num_tx_queues;
 
-	rtnl_lock();
-	netdev_update_features(dev);
-	rtnl_unlock();
-
 	if (dev->reg_state == NETREG_UNINITIALIZED) {
 		err = register_netdev(dev);
 		if (err) {
@@ -1977,6 +1973,10 @@ static int xennet_connect(struct net_device *dev)
 		}
 	}
 
+	rtnl_lock();
+	netdev_update_features(dev);
+	rtnl_unlock();
+
 	/*
 	 * All public and private state should now be sane.  Get
 	 * ready to start sending and receiving packets and give the driver
-- 
2.17.1



