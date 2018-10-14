Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E41C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CEB20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CEB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeJNXnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:43:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35806 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727315AbeJNXLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:47 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cU-CD; Sun, 14 Oct 2018 16:30:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000fh-13; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Tariq Toukan" <tariqt@mellanox.com>,
        "Tarick Bedeir" <tarick@google.com>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.514292731@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 304/366] net/mlx4_core: Fix error handling in
 mlx4_init_port_info.
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

From: Tarick Bedeir <tarick@google.com>

commit 57f6f99fdad9984801cde05c1db68fe39b474a10 upstream.

Avoid exiting the function with a lingering sysfs file (if the first
call to device_create_file() fails while the second succeeds), and avoid
calling devlink_port_unregister() twice.

In other words, either mlx4_init_port_info() succeeds and returns zero, or
it fails, returns non-zero, and requires no cleanup.

Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB ports")
Signed-off-by: Tarick Bedeir <tarick@google.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/mellanox/mlx4/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -2048,6 +2048,7 @@ static int mlx4_init_port_info(struct ml
 	if (err) {
 		mlx4_err(dev, "Failed to create file for port %d\n", port);
 		info->port = -1;
+		return err;
 	}
 
 	sprintf(info->dev_mtu_name, "mlx4_port%d_mtu", port);
@@ -2066,9 +2067,10 @@ static int mlx4_init_port_info(struct ml
 		mlx4_err(dev, "Failed to create mtu file for port %d\n", port);
 		device_remove_file(&info->dev->pdev->dev, &info->port_attr);
 		info->port = -1;
+		return err;
 	}
 
-	return err;
+	return 0;
 }
 
 static void mlx4_cleanup_port_info(struct mlx4_port_info *info)

