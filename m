Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939D8C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C48820870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544136;
	bh=yKZ4VMUjh9lfzpD49sX2B2aVMYDFk9pgUjFF1rD0Vnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FoQ96qzL6Zi0NvYij1n8+nbPPJa0uV8CzgD+/R/yTZ2lne/uYwXcqRQBd8nkZzD6z
	 brTq8aVdJnGdptIoqHx5bSrzYkwi2AtjFHjIocOzoAGT4zBnxGI8L/kYZz6ER59zf0
	 G+p7lH/3TM6MJTEF69tpZDtTYx4sA3XpQW3B32iE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C48820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeLKQCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:02:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730716AbeLKP5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6182A205C9;
        Tue, 11 Dec 2018 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543821;
        bh=yKZ4VMUjh9lfzpD49sX2B2aVMYDFk9pgUjFF1rD0Vnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cHflJYrEn3zYzwggm5di8gDmPus1m5GbPZnJaM9Wz0B0I2UWxkYL8ATOepwVn7+u
         62sLe82zoW4/tUPCHkU7OCZNuhFnJVml0jhZW7yte8MH0dEbnpmXAaqcUmE8H0rVfe
         VjidjDDSW9paYlF5lsr13tfq/2tEv6RJVDt3HLZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arthur Kiyanovski <akiyano@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/118] net: ena: fix crash during failed resume from hibernation
Date:   Tue, 11 Dec 2018 16:41:01 +0100
Message-Id: <20181211151645.937797291@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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
@@ -2627,8 +2627,8 @@ err_device_destroy:
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
2.19.1



