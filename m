Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF115C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BD721741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863918;
	bh=CQ5P3jttNEBYuEymsX1fgNOrHrVtjXYyKgN3Kr/BfDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gNCM7CYcJTvCkupLYcPiR8lyG2W52gZ5RKYT2YLU3/r/R4QnIDm/TZvuDlGnIRSdR
	 ltuPNkS/SCmi0O1/zwU+877xWa+sCKu5kqJbrUnuTdoxj5xriNCGK6/Vc0weLIIF9C
	 QYDVgk5Kh1/EnFv7p7R2Erc4/EcllSQ9Vd0NIBvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeLZWih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbeLZWiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC009218E2;
        Wed, 26 Dec 2018 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863904;
        bh=CQ5P3jttNEBYuEymsX1fgNOrHrVtjXYyKgN3Kr/BfDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ze8Ae0FeV6jQgdTqiu5q9lXCaUANkqP+qOALlsAyWhvXRKIH7eHwsDMxtpGUv/bSX
         EOf9eXV2CrlzL9ghMLP2CqlH1TmcMcwDK3bLPoaFfJgyseBQ2SgYg0mSBg0RI4hZ0K
         1BluQmWGRQfwys22Z8oHn/DhoxxsEvpheyuSLOyM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 88/97] lan743x: Remove MAC Reset from initialization
Date:   Wed, 26 Dec 2018 17:35:48 -0500
Message-Id: <20181226223557.149329-88-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan Whitehead <Bryan.Whitehead@microchip.com>

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

