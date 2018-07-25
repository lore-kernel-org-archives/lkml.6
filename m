Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F3DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9785D2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1OmXPihq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9785D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeGYJ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:57:27 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:45002 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeGYJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:57:27 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w6P8kG7n029668;
        Wed, 25 Jul 2018 17:46:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w6P8kG7n029668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532508377;
        bh=uBtlUQnHHGOGzyW1oeCOcKxwS4m+Hiaue1W2j+A+DP4=;
        h=From:To:Cc:Subject:Date:From;
        b=1OmXPihq9dUmwyjXPajQecE0NQF/NDcxC4+aQMKTlVQ+zptB32WKdP6IvtIr7mGY3
         IRzZhiNtpzTT28URw8+jmZCy4ob2wxadtpsUbLI+grDbZeiPHvxrLYDXoQ4IA55mfK
         FwrTdefqbzTBR9fCydtxK0+xID/eDKQjixSueXubmU2KPXJiBX8BncJ6x0uJGBpIj3
         ioHiBhCStnFylxPbMkvhocxJ7gNYhbOBGRb3WLTUdxTFEsj0iRLGwCh62YpzTRDuWj
         ushfI1LbBXSGHCXihrBYxvoH9mskLAKP9APJyG2lxwq7nN7T6KycTrvOncEgVFBA2H
         Q08mmnJyUzTdg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: tmio: remove unneeded variable in tmio_mmc_start_command()
Date:   Wed, 25 Jul 2018 17:46:14 +0900
Message-Id: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass TMIO_MASK_CMD to tmio_mmc_enable_mmc_irqs() directly,
and remove the variable, irq_mask.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 3080299..3cb554c 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -309,7 +309,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
 {
 	struct mmc_data *data = host->data;
 	int c = cmd->opcode;
-	u32 irq_mask = TMIO_MASK_CMD;
 
 	switch (mmc_resp_type(cmd)) {
 	case MMC_RSP_NONE: c |= RESP_NONE; break;
@@ -349,7 +348,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
 			c |= TRANSFER_READ;
 	}
 
-	tmio_mmc_enable_mmc_irqs(host, irq_mask);
+	tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_CMD);
 
 	/* Fire off the command */
 	sd_ctrl_write32_as_16_and_16(host, CTL_ARG_REG, cmd->arg);
-- 
2.7.4

