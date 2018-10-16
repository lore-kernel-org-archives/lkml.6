Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA03C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668B121476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wTTa6mYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668B121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeJQBGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQBGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D4E2098A;
        Tue, 16 Oct 2018 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710083;
        bh=sOJ/UajUmnEGoiBtN86Khg9UtFclB4ByvkLT8VnK2XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTTa6mYC78kXhuB1rN76m1/U6b9HFcjI+cACexiZ7OuqrLJlryF642RRd6qCTmtOs
         +OKmRYQr7v01ZcojNKP4C6y2e5hcoNkKxfgibD3ukuQsKOVuVtkx55Z1O/Nc3EKMnL
         ZFlRvJraOkeSUZJS9SW6ymFjznRHgjprsDkRmk28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 097/135] net: ethernet: ti: add missing GENERIC_ALLOCATOR dependency
Date:   Tue, 16 Oct 2018 19:05:27 +0200
Message-Id: <20181016170522.053263682@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit f025571e96caa95ffc3c1792f762a584893de582 ]

This patch mades TI_DAVINCI_CPDMA select GENERIC_ALLOCATOR.
without that, the following sparc64 build failure happen

drivers/net/ethernet/ti/davinci_cpdma.o: In function `cpdma_check_free_tx_desc':
(.text+0x278): undefined reference to `gen_pool_avail'
drivers/net/ethernet/ti/davinci_cpdma.o: In function `cpdma_chan_submit':
(.text+0x340): undefined reference to `gen_pool_alloc'
(.text+0x5c4): undefined reference to `gen_pool_free'
drivers/net/ethernet/ti/davinci_cpdma.o: In function `__cpdma_chan_free':
davinci_cpdma.c:(.text+0x64c): undefined reference to `gen_pool_free'
drivers/net/ethernet/ti/davinci_cpdma.o: In function `cpdma_desc_pool_destroy.isra.6':
davinci_cpdma.c:(.text+0x17ac): undefined reference to `gen_pool_size'
davinci_cpdma.c:(.text+0x17b8): undefined reference to `gen_pool_avail'
davinci_cpdma.c:(.text+0x1824): undefined reference to `gen_pool_size'
davinci_cpdma.c:(.text+0x1830): undefined reference to `gen_pool_avail'
drivers/net/ethernet/ti/davinci_cpdma.o: In function `cpdma_ctlr_create':
(.text+0x19f8): undefined reference to `devm_gen_pool_create'
(.text+0x1a90): undefined reference to `gen_pool_add_virt'
Makefile:1011: recipe for target 'vmlinux' failed

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -41,6 +41,7 @@ config TI_DAVINCI_MDIO
 config TI_DAVINCI_CPDMA
 	tristate "TI DaVinci CPDMA Support"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
+	select GENERIC_ALLOCATOR
 	---help---
 	  This driver supports TI's DaVinci CPDMA dma engine.
 


