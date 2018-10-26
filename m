Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2941C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CFD2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CFD2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeJZP6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:58:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47167 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725907AbeJZP6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:58:38 -0400
X-UUID: ad7a88e7757649708a23e9b44ad18bb7-20181026
X-UUID: ad7a88e7757649708a23e9b44ad18bb7-20181026
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2037085050; Fri, 26 Oct 2018 15:22:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 26 Oct 2018 15:22:29 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 26 Oct 2018 15:22:29 +0800
From:   CK Hu <ck.hu@mediatek.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 0/3] Mediatek drm driver use drm_gem_cma_object instead of mtk_drm_gem_obj
Date:   Fri, 26 Oct 2018 15:22:00 +0800
Message-ID: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Because there are many similar code in drm_gem_cma_helper.c and mtk_drm_gem.c,
merging these two files would reduce code size and be easier to maintain. The
major difference between these two gem object is that drm_gem_cma_object is for
CMA buffer and mtk_drm_gem_obj is for iommu buffer. This series just add two
iommu feature which is used by mediatek drm driver into cma helper, so there
is still some feature just support CMA buffer. The first feature is making sub
device as dma device for dma operation. So far drm core treat drm device as
dma device, but mediatek drm device is not a dma device and it use sub device
as dma device. The second feature is providing interface to create dumb buffer
without mapping kernel virtual address. For iommu buffer, mapping kernel virtual
address would reduce free virtual memory area. Some feature still support only
CMA buffer, for example, drm_gem_cma_prime_vmap(), so we still treat these
helper function as 'cma' helper function.

CK Hu (3):
  drm: Add dma_dev in struct drm_device
  drm: Add drm_gem_cma_dumb_create_no_kmap() helper function
  drm/mediatek: Use drm_gem_cma_object instead of mtk_drm_gem_obj

 drivers/gpu/drm/drm_gem_cma_helper.c     | 110 +++++++++++---
 drivers/gpu/drm/mediatek/Makefile        |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c   |  15 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h   |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_fb.c    |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_gem.c   | 243 -------------------------------
 drivers/gpu/drm/mediatek/mtk_drm_gem.h   |  56 -------
 drivers/gpu/drm/mediatek/mtk_drm_plane.c |   8 +-
 include/drm/drm_device.h                 |   1 +
 include/drm/drm_gem_cma_helper.h         |   7 +
 11 files changed, 110 insertions(+), 334 deletions(-)
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_gem.c
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_gem.h

-- 
1.9.1
