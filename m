Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E9DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080AB2172D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H+NXMFoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080AB2172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeHNQ7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:59:53 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:45664 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNQ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:59:53 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5FDD310C119D;
        Tue, 14 Aug 2018 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534255952; bh=b+txpZOEHf4h8yNlZzz73CQXA+OuI/U6s98MsOHuw3o=;
        h=From:To:Cc:Subject:Date:From;
        b=H+NXMFoCJEzgMgdl8OkSi+lkFGt4/0grOxfX1DLXMg67/GTiFBOhT03DxjycZJJId
         oYPhaFE0URZi8kybEDroWx4wsUtXogPCukX+1rgVkhNx45/xXojAH1MbcrgWegCYtS
         3BAwCNe8+rLyOE02X2YbL68M8Y/FE3cU31AyMOHkecxzi+oq6vahXHM+kYs9480Pc1
         5p7jLOUxYoH/zNsaM4EWnYJC+zI7YRDYDmgellYQEZ4TjOIPWG6XavM0GZU4M3KpuY
         Z3wuS731m310JmYlc723ZnD4UVvzEjJpJaoItqozvjTLsCqYx/uTydmUaT54GUugEY
         93KBDLu63AY+A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7931756E2;
        Tue, 14 Aug 2018 07:12:28 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC] etnaviv: missing dma_mask
Date:   Tue, 14 Aug 2018 17:12:25 +0300
Message-Id: <20180814141225.6123-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas, Christoph,

After switching ARC to generic dma_noncoherent cache ops 
etnaviv driver start failing on dma maping functions because of
dma_mask lack.

So I'm wondering is it valid case to have device which is
DMA capable and doesn't have dma_mask set?

If not, then I guess something like that should work
(at least it works for ARC):

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

