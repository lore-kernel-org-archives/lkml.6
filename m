Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4041C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 18:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C290020859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 18:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zvb31Qj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfAFS2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 13:28:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfAFS2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 13:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eLDyUetQZfyKZfukLQ1m9gz0Y61/5C0xxyHTCt0PHXs=; b=Zvb31Qj/mBQDlWTlDQCk15E8Y3
        Nv6MYmvX3yE70mn3YPIvuwjRdNEl1aUGHXJP+HWKLm5cYQ2fluXRU3AEAjq3Aqhh/Qc3B9bf38Hf4
        j35lFkI8bhn6cOvbYwKXILNMZF8YJjEdvNKeN83RgHOer2vV6jxyaPHlKdsMIeuu6DWnt38p/oz1X
        MAj7VeQl522aNL+RnBjwDLZtapgbyEPzpq2JLGhSXACZjueEo+A4RuGmMPS21i886G718JH9ogqz/
        Xxx7K7YAeuvN5R4OizS6K80IBBdDdrovUpkQTwGDp/YXmAzZJ1ioVzFXjLwTwmPXK9qf1Xbq14WAH
        mlbwN7Dw==;
Received: from [195.143.101.197] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggDAH-0006N4-1R; Sun, 06 Jan 2019 18:28:49 +0000
Date:   Sun, 6 Jan 2019 19:28:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fixes for Linux 4.21-rc1
Message-ID: <20190106182846.GA10665@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull regression fixes, and code removals enabling them for
4.21-rc1.

The following changes since commit 96d4f267e40f9509e8a66e2b39e8b95655617693:

  Remove 'type' argument from access_ok() function (2019-01-03 18:57:57 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.21-1

for you to fetch changes up to 8270f3a11ceef64bdb0ab141180e8d2f17c619ec:

  dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING for remapped allocations (2019-01-05 08:28:29 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 4.21-rc1

Fix various regressions introduced in this cycles:

 - fix dma-debug tracking for the map_page / map_single consolidatation
 - properly stub out DMA mapping symbols for !HAS_DMA builds to avoid
   link failures
 - fix AMD Gart direct mappings
 - setup the dma address for no kernel mappings using the remap
   allocator

----------------------------------------------------------------
Christoph Hellwig (7):
      dma-mapping: implement dma_map_single_attrs using dma_map_page_attrs
      dma-mapping: implement dmam_alloc_coherent using dmam_alloc_attrs
      dma-mapping: remove dmam_{declare,release}_coherent_memory
      dma-mapping: properly stub out the DMA API for !CONFIG_HAS_DMA
      dma-mapping: remove a few unused exports
      x86/amd_gart: fix unmapping of non-GART mappings
      dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING for remapped allocations

 Documentation/driver-model/devres.txt |   1 -
 arch/x86/kernel/amd_gart_64.c         |  10 +-
 include/linux/dma-debug.h             |  11 +-
 include/linux/dma-mapping.h           | 340 +++++++++++++++++++---------------
 kernel/dma/coherent.c                 |   2 -
 kernel/dma/debug.c                    |  19 +-
 kernel/dma/mapping.c                  |  94 ----------
 kernel/dma/remap.c                    |  13 +-
 8 files changed, 215 insertions(+), 275 deletions(-)
