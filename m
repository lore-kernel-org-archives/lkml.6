Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60509C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261552087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOOJC4vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261552087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeJVShw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbeJVShv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:37:51 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CB72087D;
        Mon, 22 Oct 2018 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203596;
        bh=kxbu0U35Y+vewXaayrfy4bnjt+OVtDW7vl1uKyEHruc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOOJC4vltBPu1XAsX9SdB3iKQNDWeh5DPa4wLuhRC4nq2l3YAyG5QmfQL6r0Mx/Pd
         u8iUhA+nbIEkKuqCbIsMrweJR97SJ2BhpKbNmribYtInV/yRutpnhoWOlWiWjyLA7L
         uoVYKiqLVgdDPxpsWKZu78ytd+APxZhw2k6Uzzbg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arthur Kiyanovski <akiyano@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 16/27] net: ena: fix rare bug when failed restart/resume is followed by driver removal
Date:   Mon, 22 Oct 2018 06:19:13 -0400
Message-Id: <20181022101924.40531-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit d7703ddbd7c9cb1ab7c08e1b85b314ff8cea38e9 ]

In a rare scenario when ena_device_restore() fails, followed by device
remove, an FLR will not be issued. In this case, the device will keep
sending asynchronous AENQ keep-alive events, even after driver removal,
leading to memory corruption.

Fixes: 8c5c7abdeb2d ("net: ena: add power management ops to the ENA driver")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 7093b661c50e..72dbdebf4b5d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2648,7 +2648,11 @@ static int ena_restore_device(struct ena_adapter *adapter)
 	ena_free_mgmnt_irq(adapter);
 	ena_disable_msix(adapter);
 err_device_destroy:
+	ena_com_abort_admin_commands(ena_dev);
+	ena_com_wait_for_abort_completion(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
+	ena_com_dev_reset(ena_dev, ENA_REGS_RESET_DRIVER_INVALID_STATE);
 err:
 	clear_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
 	clear_bit(ENA_FLAG_ONGOING_RESET, &adapter->flags);
-- 
2.17.1

