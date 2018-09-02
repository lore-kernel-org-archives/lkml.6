Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C249C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C922C20658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ldo17t+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C922C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeIBLp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:45:57 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:58226 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeIBLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pnYcFnmudmv8f333KtzeXVkRB3jmFVCNK53ni9m/CW4=; b=ldo17t+EsKmdl7ULEaIOXtz7W/
        0B0g93B44HS0GqeqNfJr5sRESLqaeXEH5Ukbbw0PfFCGXGHcdpCilHNwc+T1C7IuZJpP0MmCUjrWq
        BfKBfwQ6IBSKzpX+oHP7xtDXLJILcLWFco+/VDezFo4h+d57bCz0tGP9SOsLFPqom9hc=;
Received: from p200300ccfbdb10001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbdb:1000:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fwMqc-0008TD-HZ; Sun, 02 Sep 2018 09:31:02 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1fwMqc-0004Rn-95; Sun, 02 Sep 2018 09:31:02 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     ulf.hansson@linaro.org, kishon@ti.com,
        wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] mmc: omap_hsmmc: fix wakeirq handling on removal
Date:   Sun,  2 Sep 2018 09:30:58 +0200
Message-Id: <20180902073058.17053-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after unbinding mmc I get things like this:
[  185.294067] mmc1: card 0001 removed
[  185.305206] omap_hsmmc 480b4000.mmc: wake IRQ with no resume: -13

The wakeirq stays in /proc-interrupts

rebinding shows this:
[  289.795959] genirq: Flags mismatch irq 112. 0000200a (480b4000.mmc:wakeup) vs. 0000200a (480b4000.mmc:wakeup)
[  289.808959] omap_hsmmc 480b4000.mmc: Unable to request wake IRQ
[  289.815338] omap_hsmmc 480b4000.mmc: no SDIO IRQ support, falling back to polling

That bug seems to be introduced by switching from devm_request_irq()
to generic wakeirq handling.

So let us cleanup at removal.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Fixes: 5b83b2234be6 ("mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq")
---
 drivers/mmc/host/omap_hsmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 071693ebfe18..68760d4a5d3d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2177,6 +2177,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	dma_release_channel(host->tx_chan);
 	dma_release_channel(host->rx_chan);
 
+	dev_pm_clear_wake_irq(host->dev);
 	pm_runtime_dont_use_autosuspend(host->dev);
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
-- 
2.11.0

