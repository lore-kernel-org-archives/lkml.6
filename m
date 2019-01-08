Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76A1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A638120660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977664;
	bh=mtypxHq0a4vamiNHIFGeEMoptDQnE3J418frzcCqIoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYklJs3tRFH+cmH/7+iwmuPPf6zSSH71ljqRTQql48eEjCtcjKZnTsoIeHjxtt7Qo
	 BJ8zFpGHijjynqTkjJLy5IiCD08L1G4xXJVeaOcp1FYCC/at1Ra7c62QmHYKJ896b4
	 QiMESbdsmRiOEpzn+QTq4yBmJfEXaRMhjAL8DaiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbfAHT70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730356AbfAHT3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 472E920645;
        Tue,  8 Jan 2019 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975759;
        bh=mtypxHq0a4vamiNHIFGeEMoptDQnE3J418frzcCqIoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1sD6S4cnLz63UGCyEn2JMTOe0zI82A4Cz1ELBpFgB+YIy5CT7G+AJ8hijkDlSiiif
         De4Jdy5uRb246WJtVDomPQYTLd1TqdIHdFRFhvptMLUlMiTBQwl8tx1Q/ZyJSaKwGF
         2gldLD1dZUZH/ICs+Jyri3tMZD2F1MDCaYhK+TY8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Parvi Kaustubhi <pkaustub@cisco.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 102/117] IB/usnic: Fix potential deadlock
Date:   Tue,  8 Jan 2019 14:26:10 -0500
Message-Id: <20190108192628.121270-102-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parvi Kaustubhi <pkaustub@cisco.com>

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

