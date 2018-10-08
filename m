Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853442087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2W+GTgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853442087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbeJICEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbeJICEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF57F204FD;
        Mon,  8 Oct 2018 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024687;
        bh=rh+t9czMGs+SuL5ev3tQvQN+M1ESZDi9dRhSlsWmzm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2W+GTgMT7UhRImTQMZmdqWPu45mMjNV9AerViyfrXUUpwP6tf1b3JuvQd4Ju7DtY
         XFnHb8Cub5Is2WOKjJU7oBxvJ/0Y2eI+8Kx7xw816ybgR9wrs0KtsN+8SaAaZNrXed
         3p42R447NXuCW2/NQixzUifvXqkmCYCtyf5aLjPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Netanel Belgazal <netanel@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 122/168] net: ena: fix missing lock during device destruction
Date:   Mon,  8 Oct 2018 20:31:42 +0200
Message-Id: <20181008175624.688478781@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 944b28aa2982b4590d4d4dfc777cf85135dca2c0 ]

acquire the rtnl_lock during device destruction to avoid
using partially destroyed device.

ena_remove() shares almost the same logic as ena_destroy_device(),
so use ena_destroy_device() and avoid duplications.

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3420,24 +3420,18 @@ static void ena_remove(struct pci_dev *p
 
 	unregister_netdev(netdev);
 
-	/* Reset the device only if the device is running. */
+	/* If the device is running then we want to make sure the device will be
+	 * reset to make sure no more events will be issued by the device.
+	 */
 	if (test_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags))
-		ena_com_dev_reset(ena_dev, adapter->reset_reason);
+		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
 
-	ena_free_mgmnt_irq(adapter);
-
-	ena_disable_msix(adapter);
+	rtnl_lock();
+	ena_destroy_device(adapter, true);
+	rtnl_unlock();
 
 	free_netdev(netdev);
 
-	ena_com_mmio_reg_read_request_destroy(ena_dev);
-
-	ena_com_abort_admin_commands(ena_dev);
-
-	ena_com_wait_for_abort_completion(ena_dev);
-
-	ena_com_admin_destroy(ena_dev);
-
 	ena_com_rss_destroy(ena_dev);
 
 	ena_com_delete_debug_area(ena_dev);


