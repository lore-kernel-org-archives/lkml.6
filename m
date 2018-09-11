Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13CE2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13CE2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeIKVbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:31:17 -0400
Received: from sauhun.de ([88.99.104.3]:53630 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbeIKVbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:31:17 -0400
Received: from localhost (i577B9DAC.versanet.de [87.123.157.172])
        by pokefinder.org (Postfix) with ESMTPSA id E38BF2CF608;
        Tue, 11 Sep 2018 18:31:09 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-renesas-soc@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 0/2] dma-mapping: introduce helper for setting dma_parms
Date:   Tue, 11 Sep 2018 18:30:48 +0200
Message-Id: <20180911163050.28072-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

commit 78c47830a5cb ("dma-debug: check scatterlist segments") triggers
for Renesas hardware I look after, so thanks for pointing out we should
have proper dma_parms for our DMA providers.

When trying to fix it, I became a bit puzzled about the life cycle of
the pointer to dma_parms. AFAIU most drivers leave the pointer dangling
on driver unbind. Check drivers/dma/bcm2835-dma.c, for example:

	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
	if (!od)
		return -ENOMEM;

	pdev->dev.dma_parms = &od->dma_parms;
	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);

And that's all about handling dma_parms. So, on unbind, the memory for
'od' gets freed and dma_params is a dangling pointer.

drivers/gpu/drm/exynos/exynos_drm_iommu.c seems to do it correctly:

static inline int configure_dma_max_seg_size(struct device *dev)
{
        if (!dev->dma_parms)
                dev->dma_parms = kzalloc(sizeof(*dev->dma_parms), GFP_KERNEL);
        if (!dev->dma_parms)
                return -ENOMEM;

        dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
        return 0;
}

static inline void clear_dma_max_seg_size(struct device *dev)
{
        kfree(dev->dma_parms);
        dev->dma_parms = NULL;
}

But this seems error prone and quite some code to add for every DMA
provider. So, I wondered if we couldn't have a helper for that. After
some brainstorming, I favour a dmam_-type of function. It will ensure
the memory gets freed and the pointer cleared on unbind. And it should
be easy to use.

I attached an RFC which I tested on a Renesas R-Car H3 SoC with the internal
DMAC of the SD controller. A branch can be found here (still waiting for
buildbot results):

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/set_max_seg

I added the companion function dmam_free_dma_parms() for completeness
although there is no user yet. I'd be totally open to drop it until
someone needs it.

Please let me know what you think. If this is the right track, I'll be
willing to fix the dangling pointers with it, too.

Thanks and happy hacking,

   Wolfram



Wolfram Sang (2):
  dma-mapping: introduce helper for setting dma_parms
  mmc: sdhi: internal_dmac: set dma_parms

 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +
 include/linux/dma-mapping.h                   |  5 ++
 kernel/dma/mapping.c                          | 50 +++++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
2.18.0

