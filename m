Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83144C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53459218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358669;
	bh=6s5tlf5TaEsmuRY7VucU/dyJnjMKDGbnxUxDO2QUhXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HowIrvpEccra+lE46awu5T88FDqw6VQrqwZdRLdTuiXUsRFLL0Dnzuo2gmGs26I5s
	 4Uus1MahcY3Vs89o0oLTsb87TwlCV9mgMqX/yEN2RAD7WZQaVZXbZeLZW49GH10TCd
	 IUKS4rbVTGmT7l3iSa7q0mIRvfEtFO/fnopL2kjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfAXThr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732179AbfAXThp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0EEA21905;
        Thu, 24 Jan 2019 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358664;
        bh=6s5tlf5TaEsmuRY7VucU/dyJnjMKDGbnxUxDO2QUhXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfLu08sDwwEdKFSgMQLB0wrm2VRBWjWM+Cpjdhi4+WEBbUmj6qeBYOmoqD/v5/WsV
         VE9w33tY56KkO7u9kcdLJuRZcjZe29McPBKx1uSAmTllGimA5EJxUbiLB2lZezmi4r
         uzz8P0dA+yy6XKZ1pSAGN2TdmJKD1l09lasec/Bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parvi Kaustubhi <pkaustub@cisco.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 088/106] IB/usnic: Fix potential deadlock
Date:   Thu, 24 Jan 2019 20:20:45 +0100
Message-Id: <20190124190211.683334239@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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
index 9973ac893635..3db232429630 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -334,13 +334,16 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 
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



