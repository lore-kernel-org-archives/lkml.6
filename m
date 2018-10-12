Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F153C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0513120865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0AOSn2Mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0513120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeJLWbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:31:39 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:52724 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeJLWbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:31:38 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w9CEvjPB016823;
        Fri, 12 Oct 2018 23:57:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w9CEvjPB016823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539356268;
        bh=mddxV7i40K2p+WcuchNOgFO0VNs4dZslkYzPME553/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0AOSn2MzD4asqNCffRzt1nQ899BrgC9wWwChcteE0U+W/5nFlHMWzT/0c9RZRfqrt
         5Bzb6NAN0Lz4p+bmtZPISZ+DXKzaY/go8UGbbpB3AfJOotJnjyQW1GtorumArDUDO7
         lbX108BqsS/3tEYHAC9ZLdmd+uU144QthekduJbbIHy1Ho1p4TFDuiAvy4PLBbjmMg
         5DVMf8oUepMaLwxwr9im0syvMFTRuoCSABzDZlfzC8YW0q16Uxg2DXwWrMTqy2KEm+
         pwfZ77SLvCiLVyoVv/oz+PIN0TbNvH6gBCucygV5vlXyuTWAEteEaRXBjku+/RQQMh
         2jL8FABwfSqXA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: uniphier-sd: avoid using broken DMA RX channel
Date:   Fri, 12 Oct 2018 23:57:38 +0900
Message-Id: <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

host->chan_rx is NULL when UNIPHIER_SD_CAP_BROKEN_DMA_RX quirk flag
is set. In this case, it should not set up DMA.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/uniphier-sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 10d49aa..1ee9fd0 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -251,6 +251,9 @@ static void uniphier_sd_internal_dma_start(struct tmio_mmc_host *host,
 	u32 dma_mode;
 	int sg_len;
 
+	if ((data->flags & MMC_DATA_READ) && !host->chan_rx)
+		goto force_pio;
+
 	if (WARN_ON(host->sg_len != 1))
 		goto force_pio;
 
-- 
2.7.4

