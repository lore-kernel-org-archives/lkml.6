Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C42C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017792087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uT+gBkSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017792087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbeJICFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:39 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ACE42087D;
        Mon,  8 Oct 2018 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024751;
        bh=69mxjho+QiNb5gvH7t3aoxzWKHhsMGexQuKa4RnZBU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uT+gBkSqQ6np4HEmF9BI+vSvlei1QR72GgdGlnsx0HDWgcmYqV/lKgBwUZ7O9aZ8B
         lJb77dJg5j7Gsmow84KS7luGmSW9/2V7xPcsLSONCO8xPPUo9xoCP3MyOu7kUp8WJ5
         tiG8lGj1qFjrrOHqTp7tsS1c3RHyS7D/iu9frm9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Netanel Belgazal <netanel@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 118/168] net: ena: fix surprise unplug NULL dereference kernel crash
Date:   Mon,  8 Oct 2018 20:31:38 +0200
Message-Id: <20181008175624.531580718@linuxfoundation.org>
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

[ Upstream commit 772ed869f535b4ec2b134645c951ff22de4d3f79 ]

Starting with driver version 1.5.0, in case of a surprise device
unplug, there is a race caused by invoking ena_destroy_device()
from two different places. As a result, the readless register might
be accessed after it was destroyed.

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3408,12 +3408,12 @@ static void ena_remove(struct pci_dev *p
 		netdev->rx_cpu_rmap = NULL;
 	}
 #endif /* CONFIG_RFS_ACCEL */
-
-	unregister_netdev(netdev);
 	del_timer_sync(&adapter->timer_service);
 
 	cancel_work_sync(&adapter->reset_task);
 
+	unregister_netdev(netdev);
+
 	/* Reset the device only if the device is running. */
 	if (test_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags))
 		ena_com_dev_reset(ena_dev, adapter->reset_reason);


