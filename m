Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FC3C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4098214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789395;
	bh=JcjV/TlRKE06XMBItPP9qeYli2WPzlscz2pTeMuW5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OER7bcTUkP4qwY4mtsDBk0EWNhMRl90ZF1VorIcADV8G/8PjOeTy3NRVELh7/07cl
	 eOQPub2s9qIDM47faqHBwiah99aKmHhQ2QEnhRVpgv1WDCEap7H3M9HqpsZBdJ9vIA
	 KN9u2E1GyHBP3L8R+RTvPGnSKol09ntKgdx5twAE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4098214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbeLNMJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbeLNMJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA2F214C4;
        Fri, 14 Dec 2018 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789390;
        bh=JcjV/TlRKE06XMBItPP9qeYli2WPzlscz2pTeMuW5xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAYOUGF1PYm4gM6k0UEdwU18zGL+7K6OKZFtofs/qR3Y7x+vBG5u4H2GOYF8EO4mB
         2dpTKDzj5j7g1YdRRULn2RCgxdAfIExR7js8fA9/VPaHND4q9XOHtj2D6hCwQk6JiO
         +2A8QhvcqAlTgBLNhVyDV8xLpKNLccJWvOQqMB9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 63/89] net: hisilicon: remove unexpected free_netdev
Date:   Fri, 14 Dec 2018 13:00:16 +0100
Message-Id: <20181214115732.780047666@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c758940158bf29fe14e9d0f89d5848f227b48134 ]

The net device ndev is freed via free_netdev when failing to register
the device. The control flow then jumps to the error handling code
block. ndev is used and freed again. Resulting in a use-after-free bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 0cec06bec63e..c27054b8ce81 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -914,10 +914,8 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	}
 
 	ret = register_netdev(ndev);
-	if (ret) {
-		free_netdev(ndev);
+	if (ret)
 		goto alloc_fail;
-	}
 
 	return 0;
 
-- 
2.19.1



