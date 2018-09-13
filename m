Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA12C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81FD20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81FD20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeIMU1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:27:23 -0400
Received: from sauhun.de ([88.99.104.3]:38890 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbeIMU1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:27:23 -0400
Received: from localhost (p54B3335A.dip0.t-ipconnect.de [84.179.51.90])
        by pokefinder.org (Postfix) with ESMTPSA id 542E42C278A;
        Thu, 13 Sep 2018 17:17:24 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 0/3] dma-mapping: clear dangling pointers consistently
Date:   Thu, 13 Sep 2018 17:17:13 +0200
Message-Id: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When working with dma_set_max_seg_size(), I noticed issues with a
dangling dma_parms pointer. I saw Christoph just worked on handling
something similar for the dma_ops pointer, too. I came up with three
patches on top of Christoph's work which I send out for discussion here:

Patch 1 fixes a meanwhile stale comment.

Patch 2 makes clearing the dma_ops pointer more consistent because it
was missed on the custom ARM implementation to the best of my knowledge.

Patch 3 generalizes teardown_dma_ops to teardown_dma, so that clearing
dma_parms can be added there.

All these patches are based on the dma-mapping for-next branch. They are
build tested and runtime tested on a Renesas Salvator-XS board (R-Car
M3-N, ARM64) and Renesas Lager board (R-Car H2, ARM32).

A branch containing these (and dma_parms additions for the above boards)
can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/set_max_seg

Looking forward to opinions.

Regards,

   Wolfram


Wolfram Sang (3):
  ARM: dma-mapping: update comment about handling dma_ops when detaching
    from IOMMU
  dma-mapping: clear dma_ops pointer also on ARM
  dma-mapping: clear dma_parms on teardown, too

 arch/arm/mm/dma-mapping.c   | 8 ++++----
 include/linux/dma-mapping.h | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.18.0

