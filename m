Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC7DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAD421722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FaBm3P8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAD421722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeH0KoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:44:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeH0KoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GVWf/+w/sCO2UegASIQHlyTIjUUIEMdy03Or94LtLgk=; b=FaBm3P8TfeAXZTVSWNkGfO3uY
        Pr3p71rd2iqF6xu1UHTJ6nQQRydb/unVZRz23rnOLgn+DQZTELlf0iX78GtEwjLqAT4w8gDP6vDXs
        IExfz6y0AFpcdKNeHQ69FkZH+f0XeQabdP5OhwrHX7n7N/2CbHb2aVzrLtmnXGMU6qv+y9DVr3gqZ
        8K+ZCdzOKejz3CBaSNn33pVkz8cKyjPEM3ujTuZPYj+aDk/sVeqrSNdEgX8du8Fr+x3SFkC4kB7ig
        F2+VkNTHmOdRZHRe00DVPTg3z7PAkcFYSC+Nj2IEhvAd2eWUgf9uSMcV0OBcFSjNxBUGk7+jQtfx2
        GRaTsEwFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuBU1-0005fh-RB; Mon, 27 Aug 2018 06:58:41 +0000
Date:   Sun, 26 Aug 2018 23:58:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>, murphyt7@tcd.ie,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
 context which is necessary for any custom drivers using the IOMMU API while
 holding a spinlock.
Message-ID: <20180827065841.GA7053@infradead.org>
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
 <20180824145328.GA7996@infradead.org>
 <24d3f04a-e6e2-ed8f-e2bd-b38144f33f26@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d3f04a-e6e2-ed8f-e2bd-b38144f33f26@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 04:24:49PM +0100, Robin Murphy wrote:
> Although IIRC the AMD driver is in fact the only one whose map/unmap
> callbacks aren't already spinlock-safe (or at least it was last time I was
> looking). Stuff like iommu-dma is already relying on this in order to
> implement streaming DMA API calls (which may be in atomic context) on top of
> the corresponding IOMMU API operations.

True.  That should be mentioned in the spinlock, though - and once
it is done the calling conventions should be documented.
