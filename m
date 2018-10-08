Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABD7C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942B520645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSSQRKMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942B520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbeJICEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbeJICEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:31 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA41D204FD;
        Mon,  8 Oct 2018 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024684;
        bh=0RAMYZyGoWf6R+j7VVLoNhkUdKf2OFDfSB2vJWPJov0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSSQRKMTMfgPC5xYsw5bTzIndsjek2nNnhjzk4C7gJOmZoFKs0DNfKWNhtwB9Q6wK
         IphNvH8EgGR4kvVTdfOaBUp0TFbFo4w4briWWoa0JNG79SVWpHY/kl/a2vEpG2aZ/q
         8IHXO0F+0k9S68j5qtZudRHtvLu6GivndmgQXUUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Netanel Belgazal <netanel@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 121/168] net: ena: fix potential double ena_destroy_device()
Date:   Mon,  8 Oct 2018 20:31:41 +0200
Message-Id: <20181008175624.649349901@linuxfoundation.org>
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

[ Upstream commit fe870c77efdf8682252545cbd3d29800d8379efc ]

ena_destroy_device() can potentially be called twice.
To avoid this, check that the device is running and
only then proceed destroying it.

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2555,6 +2555,9 @@ static void ena_destroy_device(struct en
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
 	bool dev_up;
 
+	if (!test_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags))
+		return;
+
 	netif_carrier_off(netdev);
 
 	del_timer_sync(&adapter->timer_service);
@@ -2591,6 +2594,7 @@ static void ena_destroy_device(struct en
 	adapter->reset_reason = ENA_REGS_RESET_NORMAL;
 
 	clear_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+	clear_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
 }
 
 static int ena_restore_device(struct ena_adapter *adapter)
@@ -2635,6 +2639,7 @@ static int ena_restore_device(struct ena
 		}
 	}
 
+	set_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
 	mod_timer(&adapter->timer_service, round_jiffies(jiffies + HZ));
 	dev_err(&pdev->dev, "Device reset completed successfully\n");
 


