Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D638C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5662082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W26pc3z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5662082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeKCDqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeKCDqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:47 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1D72082D;
        Fri,  2 Nov 2018 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183916;
        bh=MO9Eya7Hp1KjBrz34XmNIYLRlvzl0HFUIOBMUKGPy08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W26pc3z4iyZ/x7WZF51qXt1l08vm9rUBAsfaWSNSNijG16oUZd+okhpOpdLVfMleW
         61sswq0oert6QFE9tbSiPqiedLr8iWQ1HP/6FN2ytBaW1Yo9ZjSdiHBwt9OtfbgqHj
         d41ZzhrrSkXVke8hqV9mB0md9xjLQ5T0LpbNEZ7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 020/150] net: macb: Clean 64b dma addresses if they are not detected
Date:   Fri,  2 Nov 2018 19:33:02 +0100
Message-Id: <20181102182904.409383911@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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
index dfa045f22ef1..db568232ff3e 100644
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



