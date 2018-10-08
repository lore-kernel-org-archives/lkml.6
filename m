Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254DFC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E309920645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kupg6GZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E309920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbeJICFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF882087D;
        Mon,  8 Oct 2018 18:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024757;
        bh=c1wlZTfoNRnEt3nR27LKvunfBsTwCanAmgICEJHnww0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kupg6GZnH9c4gHb2uxK8r1tS950VdFlbrPed59QXpKt2EryIUnL1bVngPjALnRVRv
         JAQIbyN9fFEDuNjLDMmP6D0gxQPmM8zvvboSymF9OhvH7AYxdTkayS8wqrbp+VsAOd
         3qtgKHZUSth6XNV3hmoF4Qhvrv6Cy4tMjhPzbotw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Netanel Belgazal <netanel@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 120/168] net: ena: fix device destruction to gracefully free resources
Date:   Mon,  8 Oct 2018 20:31:40 +0200
Message-Id: <20181008175624.610278349@linuxfoundation.org>
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

[ Upstream commit cfa324a514233b28a6934de619183eee941f02d7 ]

When ena_destroy_device() is called from ena_suspend(), the device is
still reachable from the driver. Therefore, the driver can send a command
to the device to free all resources.
However, in all other cases of calling ena_destroy_device(), the device is
potentially in an error state and unreachable from the driver. In these
cases the driver must not send commands to the device.

The current implementation does not request resource freeing from the
device even when possible. We add the graceful parameter to
ena_destroy_device() to enable resource freeing when possible, and
use it in ena_suspend().

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -76,7 +76,7 @@ MODULE_DEVICE_TABLE(pci, ena_pci_tbl);
 
 static int ena_rss_init_default(struct ena_adapter *adapter);
 static void check_for_admin_com_state(struct ena_adapter *adapter);
-static void ena_destroy_device(struct ena_adapter *adapter);
+static void ena_destroy_device(struct ena_adapter *adapter, bool graceful);
 static int ena_restore_device(struct ena_adapter *adapter);
 
 static void ena_tx_timeout(struct net_device *dev)
@@ -1900,7 +1900,7 @@ static int ena_close(struct net_device *
 			  "Destroy failure, restarting device\n");
 		ena_dump_stats_to_dmesg(adapter);
 		/* rtnl lock already obtained in dev_ioctl() layer */
-		ena_destroy_device(adapter);
+		ena_destroy_device(adapter, false);
 		ena_restore_device(adapter);
 	}
 
@@ -2549,7 +2549,7 @@ err_disable_msix:
 	return rc;
 }
 
-static void ena_destroy_device(struct ena_adapter *adapter)
+static void ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 {
 	struct net_device *netdev = adapter->netdev;
 	struct ena_com_dev *ena_dev = adapter->ena_dev;
@@ -2562,7 +2562,8 @@ static void ena_destroy_device(struct en
 	dev_up = test_bit(ENA_FLAG_DEV_UP, &adapter->flags);
 	adapter->dev_up_before_reset = dev_up;
 
-	ena_com_set_admin_running_state(ena_dev, false);
+	if (!graceful)
+		ena_com_set_admin_running_state(ena_dev, false);
 
 	if (test_bit(ENA_FLAG_DEV_UP, &adapter->flags))
 		ena_down(adapter);
@@ -2664,7 +2665,7 @@ static void ena_fw_reset_device(struct w
 		return;
 	}
 	rtnl_lock();
-	ena_destroy_device(adapter);
+	ena_destroy_device(adapter, false);
 	ena_restore_device(adapter);
 	rtnl_unlock();
 }
@@ -3466,7 +3467,7 @@ static int ena_suspend(struct pci_dev *p
 			"ignoring device reset request as the device is being suspended\n");
 		clear_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
 	}
-	ena_destroy_device(adapter);
+	ena_destroy_device(adapter, true);
 	rtnl_unlock();
 	return 0;
 }


