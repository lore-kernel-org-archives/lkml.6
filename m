Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F1EC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D5C2082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KWH8faT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D5C2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbeKEBFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:05:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbeKEBFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SbFisei11HLU0ftdItwXWCeiFJkdGV+gMhKAmFLfw34=; b=KWH8faT1iqZrC6YKpgphKQq0i
        ukzJPvJmMX77qRtVU3/vne//f72/gFe0kh4qg8CpO2GZlSPpcqRFlJt+yE/aJ6uUThpgQK8Jhg6NW
        eEo7DG6PssL2EqStkHEsh+Jw1fISsdB34UzJiGEtozYyNrdHqq1m+QowWXFNODH+ax8oyOida9ykX
        SveJbLcsk7uFwibwteNC072MC2MuLA17OjKXCOhfcki9gq50J6xHRpRuth/C0UJIc4vpETWwgehSX
        tmbRzdk+uBkVLp8WTZMSjNk28pguNMh4b78Vuj5AZx4LloxykKR+DP4uv+RWOdUYvaSITEfQvmnQ7
        j4ZYdy+VQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJKf4-0006pE-6E; Sun, 04 Nov 2018 15:50:02 +0000
Date:   Sun, 4 Nov 2018 07:50:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Message-ID: <20181104155001.GA25794@infradead.org>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101213500.21800-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 02:35:00PM -0700, Nicolin Chen wrote:
> The __GFP_ZERO will be passed down to the generic page allocation
> routine which zeros everything page by page. This is safe to be a
> generic way but not efficient for iommu allocation that organizes
> contiguous pages using scatterlist.
> 
> So this changes drops __GFP_ZERO from the flag, and adds a manual
> memset after page/sg allocations, using the length of scatterlist.
> 
> My test result of a 2.5MB size allocation shows iommu_dma_alloc()
> takes 46% less time, reduced from averagely 925 usec to 500 usec.

And in what case does dma_alloc_* performance even matter?
