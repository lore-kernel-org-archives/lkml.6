Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581E3213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEInSoE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581E3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeK2RDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:03:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbeK2RDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:03:49 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7679208E7;
        Thu, 29 Nov 2018 05:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471178;
        bh=d7AhfFqGKeZ/TmQbfHuzHJDRaBMdTbRlYBhLjoOYAFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WEInSoE8bEWki86wxNzG9hnxT20mCg+9q1TQk5KUHA9fg4t2ZGNcfSWUzScCAqQrk
         AGrtOuyFlis+VuzrHSbdhoyYVHyyQpD/sEzQlSIWthYHMZu11vrCYSUuL9Vc/T9TYu
         Jt59mU99aTSctPOqQ4Y4P6Vc6DAx7Qf1IQFeo2sg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arthur Kiyanovski <akiyano@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 45/68] net: ena: fix crash during failed resume from hibernation
Date:   Thu, 29 Nov 2018 00:55:36 -0500
Message-Id: <20181129055559.159228-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit e76ad21d070f79e566ac46ce0b0584c3c93e1b43 ]

During resume from hibernation if ena_restore_device fails,
ena_com_dev_reset() is called, and uses the readless read mechanism,
which was already destroyed by the call to
ena_com_mmio_reg_read_request_destroy(). This causes a NULL pointer
reference.

In this commit we switch the call order of the above two functions
to avoid this crash.

Fixes: d7703ddbd7c9 ("net: ena: fix rare bug when failed restart/resume is followed by driver removal")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index d906293ce07d..4b73131a0f20 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2627,8 +2627,8 @@ static int ena_restore_device(struct ena_adapter *adapter)
 	ena_com_abort_admin_commands(ena_dev);
 	ena_com_wait_for_abort_completion(ena_dev);
 	ena_com_admin_destroy(ena_dev);
-	ena_com_mmio_reg_read_request_destroy(ena_dev);
 	ena_com_dev_reset(ena_dev, ENA_REGS_RESET_DRIVER_INVALID_STATE);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 err:
 	clear_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
 	clear_bit(ENA_FLAG_ONGOING_RESET, &adapter->flags);
-- 
2.17.1

