Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BB8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DD1208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Xnv/1t05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DD1208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbeHWUJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:09:18 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38232 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeHWUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:09:18 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 235D110C1B2B;
        Thu, 23 Aug 2018 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535042327; bh=R0h6vbexWZTqWKlDLR1ODkMZKV20PzRe29mWCzJRIlw=;
        h=From:To:Cc:Subject:Date:From;
        b=Xnv/1t05G+01tTZ+4YLgxRmH7H1n4qMVRuvB5oDVKwoop2HyXxKmSTuLtroDouSpT
         Oithc2aveARy7b5ZidaXD8isp4hueg3B4B8TmAz5Xx3sx2jfGL1e3XK8woQ5Zcrldk
         xxTn53ly+IInH9dZOwJ8VSD/QkqpT24FQ9jJNYjbe/pkxZy//ZecgEJ5qpbzN7Dx5/
         IT3dqGJTlv/8sN+qDEWjLK2vyHRl0XsUwp2Ekxgd/Faoh91Ds8HXZVAONfX/CE8JIT
         SAIIXKgyaKc1MSh6flcAa8SDKknUzo39NK2anplmhJt7mUj7k/hxhFkBfkCNoacRRQ
         WpoxwQRevFuZg==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.36])
        by mailhost.synopsys.com (Postfix) with ESMTP id 032FD5BE5;
        Thu, 23 Aug 2018 09:38:42 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org, etnaviv@lists.freedesktop.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] etnaviv: setup missing dma_mask
Date:   Thu, 23 Aug 2018 19:38:39 +0300
Message-Id: <20180823163839.14824-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for today etnaviv device doesn't setup dma_mask.
The etnaviv device is a virtual device not represented in DT
so missing dma_mask isn't setup by generic plaform code
(by of_dma_configure function).

Missing dma_mask causes fails in some dma cache ops functions.
For example it causes fails on map_* operations in generic
dma_noncoherent_ops and dma_direct_ops.

We faced with this behaviour after switching ARC to generic
dma_noncoherent cache ops using.

So fix this by setting dma_mask via dma_coerce_mask_and_coherent()

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 540b59fb4103..69d80937e021 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -593,7 +593,7 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct component_match *match = NULL;
 
-	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 
 	if (!dev->platform_data) {
 		struct device_node *core_node;
-- 
2.14.4

