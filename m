Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD74C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C182085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrHmcMhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C182085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbeKFAS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:18:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKFASz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4zmrgK9NWtBCdfLPG2fujyW6osmdBwuXHuQI+AjQGn8=; b=WrHmcMhMVmhPJI5pgdGj/ON5v
        J0qfO2AhUvW8JuU1TcvKi6TCKqhDdHCMbDqe5uFamLKlgFzFFW/MFpStx3YNHp+yh2cAIAjqgPBBq
        VEy+F7aIh/Fp6eFeyVMAU/wFiMFyyGYmlldxcf2ilXxpcSgkSTTIWoWyppHL8SHBbmpYKsGkEN1zh
        6k7xRSZiMu2gz4xcV0RJep60i555cURGuiB6MCVKPSItd3gl1uFsQ7vpwg3617+2LqkMqZRpPk0kF
        5geUg4YmJYpnEBsJw+J9zCcdXiNsbQkTZzri+TiI04ML4ttnt2OES36Aff5CCjNOQ310+UVCIIOPv
        VoFwKbI+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJgL1-0001qj-7J; Mon, 05 Nov 2018 14:58:47 +0000
Date:   Mon, 5 Nov 2018 06:58:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Message-ID: <20181105145847.GA31337@infradead.org>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
 <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:36:13PM -0700, Nicolin Chen wrote:
> > What if the pages came from highmem? I know that doesn't happen on arm64
> > today, but the point of this code *is* to be generic, and other users will
> > arrive eventually.
> 
> Hmm, so it probably should use sg_miter_start/stop() too? Looking
> at the flush routine doing in PAGE_SIZE for each iteration, would
> be possible to map and memset contiguous pages together? Actually
> the flush routine might be also optimized if we can map contiguous
> pages.

FYI, I have patches I plan to submit soon that gets rid of the
struct scatterlist use in this code to simplify it:

http://git.infradead.org/users/hch/misc.git/commitdiff/84e837fc3248b513f73adde49e04e7c58f605113
