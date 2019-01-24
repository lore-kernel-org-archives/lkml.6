Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3AAC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE577218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359025;
	bh=bf69ivCcxJIu4KCixeTHPsxiFIVbMUKiXGkRS+3+OOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YXx71oAvOsGkDifrdBAL3IJTylOnDgXV/cUUprSPTtFEkEwzzwUR2ND0Od3z6ZfqV
	 zJXDxo0TtvQNL30cih9b5kFMNJcWnA+8TvS8gvcLEzD1qe/jBQWNayK8Ldsg8qEShh
	 pAZTtcrLFGRKcn+la0OB7i6A78O86GJeeFKk1txM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbfAXTno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387961AbfAXTnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:43:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629FE20663;
        Thu, 24 Jan 2019 19:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359018;
        bh=bf69ivCcxJIu4KCixeTHPsxiFIVbMUKiXGkRS+3+OOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLWxOO6DA+7OUt1GSEYtsEqsaX2RIoifhAD6Uq/AexGwy32u7Zf3VqYDWBApmp6Nf
         09X7oSqtsc4zUYnl3jwAAvJ0q5Svs344HHPnEfTgAu6EXAROlZOEZN5uy2cDMS4Rsp
         Sm/Y9bR/XTLHrYO/81vNgqPLFa1p7821pV/3HZjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parvi Kaustubhi <pkaustub@cisco.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 106/127] IB/usnic: Fix potential deadlock
Date:   Thu, 24 Jan 2019 20:20:52 +0100
Message-Id: <20190124190216.503738230@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8036e90f92aae2784b855a0007ae2d8154d28b3c ]

Acquiring the rtnl lock while holding usdev_lock could result in a
deadlock.

For example:

usnic_ib_query_port()
| mutex_lock(&us_ibdev->usdev_lock)
 | ib_get_eth_speed()
  | rtnl_lock()

rtnl_lock()
| usnic_ib_netdevice_event()
 | mutex_lock(&us_ibdev->usdev_lock)

This commit moves the usdev_lock acquisition after the rtnl lock has been
released.

This is safe to do because usdev_lock is not protecting anything being
accessed in ib_get_eth_speed(). Hence, the correct order of holding locks
(rtnl -> usdev_lock) is not violated.

Signed-off-by: Parvi Kaustubhi <pkaustub@cisco.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 0b91ff36768a..598e23cf01fc 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -336,13 +336,16 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 
 	usnic_dbg("\n");
 
-	mutex_lock(&us_ibdev->usdev_lock);
 	if (ib_get_eth_speed(ibdev, port, &props->active_speed,
-			     &props->active_width)) {
-		mutex_unlock(&us_ibdev->usdev_lock);
+			     &props->active_width))
 		return -EINVAL;
-	}
 
+	/*
+	 * usdev_lock is acquired after (and not before) ib_get_eth_speed call
+	 * because acquiring rtnl_lock in ib_get_eth_speed, while holding
+	 * usdev_lock could lead to a deadlock.
+	 */
+	mutex_lock(&us_ibdev->usdev_lock);
 	/* props being zeroed by the caller, avoid zeroing it here */
 
 	props->lid = 0;
-- 
2.19.1



