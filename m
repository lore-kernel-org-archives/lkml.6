Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D0EC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816482077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816482077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJNXoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:44:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35740 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbeJNXLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0004cp-QJ; Sun, 14 Oct 2018 16:30:25 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000Tq-5S; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Leon Romanovsky" <leonro@mellanox.com>,
        "Majd Dibbiny" <majd@mellanox.com>,
        "Danit Goldberg" <danitg@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.447215877@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 236/366] IB/mlx5: Use unlimited rate when static rate
 is not supported
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Danit Goldberg <danitg@mellanox.com>

commit 4f32ac2e452c2180cd2df581cbadac183e27ecd0 upstream.

Before the change, if the user passed a static rate value different
than zero and the FW doesn't support static rate,
it would end up configuring rate of 2.5 GBps.

Fix this by using rate 0; unlimited, in cases where FW
doesn't support static rate configuration.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Danit Goldberg <danitg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/mlx5/qp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1285,18 +1285,18 @@ enum {
 
 static int ib_rate_to_mlx5(struct mlx5_ib_dev *dev, u8 rate)
 {
-	if (rate == IB_RATE_PORT_CURRENT) {
+	if (rate == IB_RATE_PORT_CURRENT)
 		return 0;
-	} else if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_300_GBPS) {
+
+	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_300_GBPS)
 		return -EINVAL;
-	} else {
-		while (rate != IB_RATE_2_5_GBPS &&
-		       !(1 << (rate + MLX5_STAT_RATE_OFFSET) &
-			 dev->mdev.caps.stat_rate_support))
-			--rate;
-	}
 
-	return rate + MLX5_STAT_RATE_OFFSET;
+	while (rate != IB_RATE_PORT_CURRENT &&
+	       !(1 << (rate + MLX5_STAT_RATE_OFFSET) &
+		 dev->mdev.caps.stat_rate_support))
+		--rate;
+
+	return rate ? rate + MLX5_STAT_RATE_OFFSET : rate;
 }
 
 static int mlx5_set_path(struct mlx5_ib_dev *dev, const struct ib_ah_attr *ah,

