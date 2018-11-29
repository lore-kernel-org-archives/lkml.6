Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EF5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC4021104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC4021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeK3BUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:02 -0500
Received: from verein.lst.de ([213.95.11.211]:43248 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbeK3BUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:01 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EC65068B02; Thu, 29 Nov 2018 15:14:29 +0100 (CET)
Date:   Thu, 29 Nov 2018 15:14:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     airlied@linux.ie, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, tfiga@chromium.org,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181129141429.GA22638@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 07:33:15PM +0530, Vivek Gautam wrote:
> dma_map_sg() expects a DMA domain. However, the drm devices
> have been traditionally using unmanaged iommu domain which
> is non-dma type. Using dma mapping APIs with that domain is bad.
> 
> Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
> to do the cache maintenance.

As I told you before:  hell no.  If you spent the slightest amount of
actually trying to understand what you are doing here you'd know this
can't work.  Just turn on dma debugging and this will blow up in your
face.

Either you use the DMA API properly, that is you use it to map and
to sync, or you don't use it at all.  Mix and match between iommu
APIs and DMA APIs is simply not possible.
