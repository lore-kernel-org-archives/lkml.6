Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741E4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234572177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298223;
	bh=ckQCRdlC0+1Gn9IMG7U20hRq3ys4TKYdH4XrRe5g69E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1dQTKYyBt8OarepqTf9irdQxl2mTpgt2863b5HJzzsQfckCdIfSz95XQpLbTNSn2J
	 L9tl+vCDrrUlYeCC8Ko84PyV5mRfsqHH9EY2cd01pZ2Qo3gzFbhAd6Jd8NGyKLDCNZ
	 yl4/xpqCzXqU/wlvfD6U7/JGiLmA12cnu8d2AINw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbeLTJaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732876AbeLTJaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EAE20989;
        Thu, 20 Dec 2018 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298218;
        bh=ckQCRdlC0+1Gn9IMG7U20hRq3ys4TKYdH4XrRe5g69E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3RBm+qXAffvnQ0I7qu7aTE8zMLK9W3UManphagZ6Vs2QJsNrYAO9RIFZPa933jx8
         TKHGk467TRE5JtB+SeJHQnTSlBPj/5tCo0yXuycCmx9tWcKzNptP8932EQ9U7a6w+v
         gqXH0SMWAECanGt6WYNH4iqN8yETxu6lZAQHzAtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 43/67] macvlan: return correct error value
Date:   Thu, 20 Dec 2018 10:18:55 +0100
Message-Id: <20181220085905.246656676@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 59f997b088d26a774958cb7b17b0763cd82de7ec ]

A MAC address must be unique among all the macvlan devices with the same
lower device. The only exception is the passthru [sic] mode,
which shares the lower device address.

When duplicate addresses are detected, EBUSY is returned when bringing
the interface up:

    # ip link add macvlan0 link eth0 type macvlan
    # read addr </sys/class/net/eth0/address
    # ip link set macvlan0 address $addr
    # ip link set macvlan0 up
    RTNETLINK answers: Device or resource busy

Use correct error code which is EADDRINUSE, and do the check also
earlier, on address change:

    # ip link set macvlan0 address $addr
    RTNETLINK answers: Address already in use

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macvlan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index cfda146f3b3b..6372cdc4a510 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -608,7 +608,7 @@ static int macvlan_open(struct net_device *dev)
 		goto hash_add;
 	}
 
-	err = -EBUSY;
+	err = -EADDRINUSE;
 	if (macvlan_addr_busy(vlan->port, dev->dev_addr))
 		goto out;
 
@@ -706,7 +706,7 @@ static int macvlan_sync_address(struct net_device *dev, unsigned char *addr)
 	} else {
 		/* Rehash and update the device filters */
 		if (macvlan_addr_busy(vlan->port, addr))
-			return -EBUSY;
+			return -EADDRINUSE;
 
 		if (!macvlan_passthru(port)) {
 			err = dev_uc_add(lowerdev, addr);
@@ -747,6 +747,9 @@ static int macvlan_set_mac_address(struct net_device *dev, void *p)
 		return dev_set_mac_address(vlan->lowerdev, addr);
 	}
 
+	if (macvlan_addr_busy(vlan->port, addr->sa_data))
+		return -EADDRINUSE;
+
 	return macvlan_sync_address(dev, addr->sa_data);
 }
 
-- 
2.19.1



