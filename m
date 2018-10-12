Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3C8C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D86B20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="19e1xXVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D86B20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeJLWbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:31:36 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:52675 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeJLWbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:31:36 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w9CEvjPA016823;
        Fri, 12 Oct 2018 23:57:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w9CEvjPA016823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539356267;
        bh=gNE/DT+c7dmomudF11g+hbkGUuoIwZPmrwl+ytK2nn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19e1xXVy8/mZhAhIGINGf7jhjKSgnirV57Kay2CQIN49iN8xYxj7b6KqdeBnQMizR
         I9MudRozbmuTMUz5RaXQ9oibBq4OChrxPvaVTQdeJKCFOk9P4ylR8HpqJDtr9ypF9w
         HvErPicdOkz1r010+6Tx8wNU2mVxTy5FSMppPthJndBHfRJZYFa5/p0ik1boGHjwMl
         rQmCMSUt+effQEsU9+m31dXRzdTfx2CWmNsw4+VXbGKy7+eFigyey56JkJD2BmjoxE
         K5dCmVdtThyIMALPOu0Av9Xhgq8ArejxfkrDts29j3Xpy3n6Z4kznGCWapuAfUYvyp
         hxkaNBtWIiZjQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: uniphier-sd: fix DMA disabling
Date:   Fri, 12 Oct 2018 23:57:37 +0900
Message-Id: <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once DMA is enabled, it is not possible to disable it because
uniphier_sd_dma_endisable() always sets the DMA_ENABLE_DMASDRW bit
regardless of the argument 'enable'. It should disable DMA when
'enable' is false.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/uniphier-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 10e7b30..10d49aa 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -78,7 +78,7 @@ static void *uniphier_sd_priv(struct tmio_mmc_host *host)
 
 static void uniphier_sd_dma_endisable(struct tmio_mmc_host *host, int enable)
 {
-	sd_ctrl_write16(host, CTL_DMA_ENABLE, DMA_ENABLE_DMASDRW);
+	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? DMA_ENABLE_DMASDRW : 0);
 }
 
 /* external DMA engine */
-- 
2.7.4

