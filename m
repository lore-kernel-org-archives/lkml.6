Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57EEC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6892082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2p1r+Phq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6892082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbeKCEBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730465AbeKCEBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:52 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F962082D;
        Fri,  2 Nov 2018 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184816;
        bh=cSDTIZhOk5C0zfvE1CwjU18K7hIDU0+iKH06qIoD7Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2p1r+PhqoUnOCIXh8JszaR3lQK6uvRrryXdkyEr2y1P8riQAx9gthXoEsycSbmLU3
         1Elssw5tNJX5VNODxYNpG2Vqoq/L8/xgw4wuhdy45URK3U+Izb8DoSC1Jk3Ob+e+Q8
         MaHpKJZid/YrroMk5uhUxNDGP30Hib7v5PD648BU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arthur Kiyanovski <akiyano@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 102/143] net: ena: fix warning in rmmod caused by double iounmap
Date:   Fri,  2 Nov 2018 19:34:47 +0100
Message-Id: <20181102182906.012961551@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d79c3888bde6581da7ff9f9d6f581900ecb5e632 ]

Memory mapped with devm_ioremap is automatically freed when the driver
is disconnected from the device. Therefore there is no need to
explicitly call devm_iounmap.

Fixes: 0857d92f71b6 ("net: ena: add missing unmap bars on device removal")
Fixes: 411838e7b41c ("net: ena: fix rare kernel crash when bar memory remap fails")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 60b3ee29d82c..08c9c99a8331 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3059,15 +3059,8 @@ err_rss_init:
 
 static void ena_release_bars(struct ena_com_dev *ena_dev, struct pci_dev *pdev)
 {
-	int release_bars;
+	int release_bars = pci_select_bars(pdev, IORESOURCE_MEM) & ENA_BAR_MASK;
 
-	if (ena_dev->mem_bar)
-		devm_iounmap(&pdev->dev, ena_dev->mem_bar);
-
-	if (ena_dev->reg_bar)
-		devm_iounmap(&pdev->dev, ena_dev->reg_bar);
-
-	release_bars = pci_select_bars(pdev, IORESOURCE_MEM) & ENA_BAR_MASK;
 	pci_release_selected_regions(pdev, release_bars);
 }
 
-- 
2.17.1



