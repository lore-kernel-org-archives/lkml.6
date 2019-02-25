Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8967C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B505C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131350;
	bh=WLzdJlrT6nIJRvRwUtAsrq9KsjaknFKG6KhNiByAkhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kgTLlYLf5imUsK1mFZyB0fGtC2QmEtXf1043aHIzgk6GUmb5GEFWwvEZT0U2VcT3R
	 Hgw2aijZ1gKAII1g8u2nCvFXncIgm8SyURPjHKwAHxtzvR3+KdU+yIZhpTnMJ59v91
	 lMs+dt4c0avVgkOW+hDmg+gRMvnlGesxHUtorMIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbfBYVZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730912AbfBYVZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47AD52084D;
        Mon, 25 Feb 2019 21:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129947;
        bh=WLzdJlrT6nIJRvRwUtAsrq9KsjaknFKG6KhNiByAkhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXYK3PH5Xl8ktCRb8JMjFlN+SVgh1WlT2lF27HcBkZ0uOBAYKm8dBD1ymFM0kE+9M
         +WOIFTqlxp8f/KWRCzHQ3yVLW/vJm86/ygct0fY0G/Sy75fygYQEzl5MDJ7njTiXo+
         2Miabn++Reonk1MWPu+CZe4q6EJ5ArYOXdvOTe2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arthur Kiyanovski <akiyano@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 101/152] net: ena: fix race between link up and device initalization
Date:   Mon, 25 Feb 2019 22:11:33 +0100
Message-Id: <20190225195049.912210611@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit e1f1bd9bfbedcfce428ee7e1b82a6ec12d4c3863 ]

Fix race condition between ena_update_on_link_change() and
ena_restore_device().

This race can occur if link notification arrives while the driver
is performing a reset sequence. In this case link can be set up,
enabling the device, before it is fully restored. If packets are
sent at this time, the driver might access uninitialized data
structures, causing kernel crash.

Move the clearing of ENA_FLAG_ONGOING_RESET and netif_carrier_on()
after ena_up() to ensure the device is ready when link is set up.

Fixes: d18e4f683445 ("net: ena: fix race condition between device reset and link up setup")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2595,11 +2595,6 @@ static int ena_restore_device(struct ena
 		goto err_device_destroy;
 	}
 
-	clear_bit(ENA_FLAG_ONGOING_RESET, &adapter->flags);
-	/* Make sure we don't have a race with AENQ Links state handler */
-	if (test_bit(ENA_FLAG_LINK_UP, &adapter->flags))
-		netif_carrier_on(adapter->netdev);
-
 	rc = ena_enable_msix_and_set_admin_interrupts(adapter,
 						      adapter->num_queues);
 	if (rc) {
@@ -2616,6 +2611,11 @@ static int ena_restore_device(struct ena
 	}
 
 	set_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
+
+	clear_bit(ENA_FLAG_ONGOING_RESET, &adapter->flags);
+	if (test_bit(ENA_FLAG_LINK_UP, &adapter->flags))
+		netif_carrier_on(adapter->netdev);
+
 	mod_timer(&adapter->timer_service, round_jiffies(jiffies + HZ));
 	dev_err(&pdev->dev, "Device reset completed successfully\n");
 


