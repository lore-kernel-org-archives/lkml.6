Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E6ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CB420883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJMBXOFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CB420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbeKIHku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbeKIHku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:50 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA5720883;
        Thu,  8 Nov 2018 22:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714600;
        bh=snAOapmGr1+LqVe5rhJul5CjlaDk8Mx7aX25rNzYH7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJMBXOFThEdrKrMUIAFIQ+akM6nsHHNt5CEOg4vS0px55M+qD0FaKs+ofg/FNL+LR
         VQuOdVQuc9TEKo5JT2POt/tc23/PR3YrYHWGU4V5I3R/3pP4Zac7tYl7iNoGM+cUq/
         79tnUfZdHchXkVGlI4eMLO5JPA4XAO8QWyxL7ttE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 011/171] net: macb: Clean 64b dma addresses if they are not detected
Date:   Thu,  8 Nov 2018 13:49:41 -0800
Message-Id: <20181108215128.054070467@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/ethernet/cadence/macb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index 8f55c23e9821..a0d640243df2 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -1737,6 +1737,7 @@ static void macb_configure_dma(struct macb *bp)
 		else
 			dmacfg &= ~GEM_BIT(TXCOEN);
 
+		dmacfg &= ~GEM_BIT(ADDR64);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 		dmacfg |= GEM_BIT(ADDR64);
 #endif
-- 
2.17.1



