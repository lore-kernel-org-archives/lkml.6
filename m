Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AC4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBEC20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676493;
	bh=daS5TTNar35kx1OxE6zbXmhKhBvu4LRrXvkmPIIuyWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/OuBhH8+3kqaK/JhYvaACGeQ1zlwqbQZjMlyklvblJpiBC0hmHzbmU5vO3ipp2te
	 zBh2BRiwVPn+c/fJ+EmhOVdTeKDiLOz/dmLLU9fPVuyJ1hgBSjrf9/5w3E2Yt6Q40c
	 YT0STgfdiY9x/emXSSuCS8/xdkU81QbXCPAdgEnY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBEC20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeLMEsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:48:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbeLMEaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C81420879;
        Thu, 13 Dec 2018 04:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675407;
        bh=daS5TTNar35kx1OxE6zbXmhKhBvu4LRrXvkmPIIuyWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgwlK2XtihC0QOqqh5leGwI3fJih3OF2PxRltF+EHLF54K+8VbAVJJEa8sWqbbR8x
         gXjIvEKQ4KR4Y6Ex2Xt5U97Lb9aCyNCK8NwbjJkwHhcfPzqPMiRXmpc62VdtFtMDHk
         lxrd8XjBnKO9LwzT159YGCrdOXQ8lj9tIRPONQtQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matteo Croce <mcroce@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 46/73] macvlan: return correct error value
Date:   Wed, 12 Dec 2018 23:28:11 -0500
Message-Id: <20181213042838.75160-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

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

