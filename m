Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813CEC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F602147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789142;
	bh=rreMxHsbuAgGyciKzb8/ZB7dJskN29t4BmNNZYJCWAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AcxU/ST6XoWvJ9Q5yszIPM9XW53Hk2ZXJNId0nuZiPzJMAjvTPh5yXQaAUBNlKR/g
	 PuS/SyexO+7F/06Tj2Ww/nP1+NjKos7He2sdiQPtqi0+W/QEHBHnC5FDTIs2nmN/FH
	 RHHOypMgCtDgdHGaT7h3pEKA3quMytXxF53muHY8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F602147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbeLNMFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeLNMFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB0E21479;
        Fri, 14 Dec 2018 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789138;
        bh=rreMxHsbuAgGyciKzb8/ZB7dJskN29t4BmNNZYJCWAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jm4aOWpTPW7HhleG569matkkRaA8sJEtbq4xD1fFJlBwZBY0sFbYzrxvqI+oj7/aC
         aNSZiX1Pnp6Cx/kOxJt53s9EbLI1VuHPVQ7/DAKAKNuIevqOzONAdx6LI9WVdm/4Vb
         YcUm76gPyYiPhkXro5dEytYutFN+7RDRulPIJ6bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/142] net: hisilicon: remove unexpected free_netdev
Date:   Fri, 14 Dec 2018 12:59:54 +0100
Message-Id: <20181214115751.407900304@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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
index 14374a856d30..6127697ede12 100644
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



