Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED479C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD15A20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218290;
	bh=ml2jth2JLrbLFXvlvx1TlCFUr80AQ8vbryqY4F8g+yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HAU9dsOwk/V9foDfGEY7EaEMXsJ3USWTjNkgTfGADgyIA5CIFeEwLzL74mNRkM9Sv
	 b0EqRjgRA/I3Gy1UAPYxz2995+UemoGP1nZLltsS7NYNvKe9IqQjGjMNoS0fjm2OOf
	 EffitkmS7MwwnP/+7WZ2A4aVbVj37shzaPgKibLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbfAKOja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391037AbfAKOj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B10021841;
        Fri, 11 Jan 2019 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217568;
        bh=ml2jth2JLrbLFXvlvx1TlCFUr80AQ8vbryqY4F8g+yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO1V8AGwgAUssfJ/70YWiChxLiuSmmewY8JSuoVWTiyZ6r0r5YrHrRUh3U1v2ZERS
         lRU/PQh2jpb3xTIq5KLN1EbZZiAUpg9Ed4mcLythRcTeFE2e16Bv9SS/USE4QXGJaU
         NQ2FXg5M4Z4OsD/aMkupSnkmv9TVLyk85zNw8zD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/148] lan743x: Remove MAC Reset from initialization
Date:   Fri, 11 Jan 2019 15:14:08 +0100
Message-Id: <20190111131117.038238428@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

[ Upstream commit e0e587878f538c9e3400219b6c516b8199dc2042 ]

The MAC Reset was noticed to erase important EEPROM settings.
It is also unnecessary since a chip wide reset was done earlier
in initialization, and that reset preserves EEPROM settings.

There for this patch removes the unnecessary MAC specific reset.

Signed-off-by: Bryan Whitehead <Bryan.Whitehead@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index ff196a66eaaa..1393252c6e3c 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -802,14 +802,8 @@ static int lan743x_mac_init(struct lan743x_adapter *adapter)
 	u32 mac_addr_hi = 0;
 	u32 mac_addr_lo = 0;
 	u32 data;
-	int ret;
 
 	netdev = adapter->netdev;
-	lan743x_csr_write(adapter, MAC_CR, MAC_CR_RST_);
-	ret = lan743x_csr_wait_for_bit(adapter, MAC_CR, MAC_CR_RST_,
-				       0, 1000, 20000, 100);
-	if (ret)
-		return ret;
 
 	/* setup auto duplex, and speed detection */
 	data = lan743x_csr_read(adapter, MAC_CR);
-- 
2.19.1



