Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19406C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5178205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pxwlz+UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5178205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeJPMXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeJPMBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A7CB214C3;
        Tue, 16 Oct 2018 04:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663162;
        bh=ce0VMcgALMtMRJFnoLQJxD1iK5FI4+NFV/r/SvxfQYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pxwlz+UZVECm3hpOd8v2QL2R/sjvMn7TRGuteJjQk/4qYWgnZAFH19fp76BjLFCfw
         ZAYTiBvc9a+duiLz5PnV2l0LThcOa1EXBMRUnx4n0vMBDgrxgtnwHjuD1S9Cm9doKH
         NXn9RIzKVMReMzVDqWrJBfrPe92BFJA0CgyHHgrc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 020/100] net: macb: Clean 64b dma addresses if they are not detected
Date:   Tue, 16 Oct 2018 00:11:01 -0400
Message-Id: <20181016041221.135528-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

[ Upstream commit e1e5d8a9fe737d94ccc0ccbaf0c97f69a8f3e000 ]

Clear ADDR64 dma bit in DMACFG register in case that HW_DMA_CAP_64B is
not detected on 64bit system.
The issue was observed when bootloader(u-boot) does not check macb
feature at DCFG6 register (DAW64_OFFSET) and enabling 64bit dma support
by default. Then macb driver is reading DMACFG register back and only
adding 64bit dma configuration but not cleaning it out.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c4d7479938e2..c11bbf143544 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2089,6 +2089,7 @@ static void macb_configure_dma(struct macb *bp)
 		else
 			dmacfg &= ~GEM_BIT(TXCOEN);
 
+		dmacfg &= ~GEM_BIT(ADDR64);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
 			dmacfg |= GEM_BIT(ADDR64);
-- 
2.17.1

