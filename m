Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB8BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7792147E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tqc380+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7792147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeHTGB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 02:01:29 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45894 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeHTGB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 02:01:29 -0400
Received: by mail-yw1-f68.google.com with SMTP id 139-v6so6323332ywg.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 19:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b1I7dBbI/arDrANAKQX779/AMaCxS+x0jAszuzQ5uOU=;
        b=Tqc380+thWPlWjZdC43KIH9HsvJPBgjMwmT0IBzXAVc6OY8X5GHz/CVwSMLbYos0WX
         LOmHVBg5zoR5z0kMmMV5h2vN/8kQBD2idwExwxMltwsujCsD2KcAxbJEKoMHDEOmogvP
         GPrE6XSuEiw+9mVNHsyMjrlj2mgdDkwsXISSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b1I7dBbI/arDrANAKQX779/AMaCxS+x0jAszuzQ5uOU=;
        b=diiFsMC/gKXqeuxzNAyamI6Zgb8Ba/aQ5Ml0//7cMZD5FUrKtHEYbZZwUkFjRsCFVq
         Nifwl7cbGnbXH2a9o6U1DxuhQ7xE559M4fK+0jiJylwd1V0Z0jR5TYAnbXig1JVwyDhJ
         Xo/CBmhoHQcOBrlpqgRFN8F/3YRTWpm4VYWivK7ZXt2KX6HzcCAXmG4W22jUw51nqusp
         ZkTbM8tWJDu49FHF4xs/OtEuIEk5MBJ9zsshl4DUg0zRjOF6FIgvc1smguLCJmH6+uvu
         XAEfCGr2GmrUrWI//cH3IAKa9AYMFTxKrGo4mOMVhNVNbt948sxnRMdoEG0MMS+8dcFn
         6U7g==
X-Gm-Message-State: AOUpUlFFSb9nL/tO9HciSCS3z2HcPCmMuxuGhC5OZc9R0wJTcumGSMYi
        /f0zAubDKXharv5Utax7vEWHIg==
X-Google-Smtp-Source: AA+uWPzciJvK7tDvP1R58iv7axuCJ66pWbwqisQXPt1diLxRDs+sqlRezB/ZjLV+0SOxW809SouVNQ==
X-Received: by 2002:a81:518e:: with SMTP id f136-v6mr4067828ywb.46.1534733263608;
        Sun, 19 Aug 2018 19:47:43 -0700 (PDT)
Received: from a8k.localdomain (68-248-140-212.lightspeed.austtx.sbcglobal.net. [68.248.140.212])
        by smtp.gmail.com with ESMTPSA id h65-v6sm4335668ywe.75.2018.08.19.19.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 19:47:42 -0700 (PDT)
From:   Brian Brooks <brian.brooks@linaro.org>
To:     davem@davemloft.net
Cc:     antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        ymarkman@marvell.com, stefanc@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.topel@intel.com,
        brian.brooks@arm.com, Brian Brooks <brian.brooks@linaro.org>
Subject: [PATCH] net: mvpp2: avoid bouncing buffers
Date:   Sun, 19 Aug 2018 21:47:30 -0500
Message-Id: <20180820024730.9147-1-brian.brooks@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some memory regions used by this device need to share the same
upper 8 bits of the 40-bit bus address. Currently, a coherent
DMA mask of 32 bits is used so that dma_alloc_coherent() regions
have the same upper 8 bits. Packet buffers are not allocated via
DMA APIs, and the device does not require these memory regions
to have the same upper 8 bits. However, packet buffers are being
bounced during streaming mappings because streaming and coherent
DMA are using the same DMA mask, i.e. dev->dma_mask points to
dev->coherent_dma_mask.

Avoid bouncing packet buffers by ensuring streaming DMA uses a
mask of 40 bits and coherent DMA uses a mask of 32 bits. iperf3
shows throughput increases from 4.04 Gbps to 9.14 Gbps.

Signed-off-by: Brian Brooks <brian.brooks@linaro.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 3 +++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index def00dc3eb4e..3eb0c3ede8d2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -676,6 +676,9 @@ struct mvpp2 {
 	struct clk *mg_core_clk;
 	struct clk *axi_clk;
 
+	/* DMA mask for streaming mappings */
+	u64 dma_mask;
+
 	/* List of pointers to port structures */
 	int port_count;
 	struct mvpp2_port *port_list[MVPP2_MAX_PORTS];
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0319ed9ef8b8..3a190c489589 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5126,6 +5126,12 @@ static int mvpp2_probe(struct platform_device *pdev)
 	}
 
 	if (priv->hw_version == MVPP22) {
+		/* Platform code may have set dev->dma_mask to point
+		 * to dev->coherent_dma_mask, but we want to ensure
+		 * they take different values due to comment below.
+		 */
+		pdev->dev.dma_mask = &priv->dma_mask;
+
 		err = dma_set_mask(&pdev->dev, MVPP2_DESC_DMA_MASK);
 		if (err)
 			goto err_axi_clk;
-- 
2.17.1

